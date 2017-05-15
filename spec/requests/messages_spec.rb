require 'rails_helper'

RSpec.describe 'Messages API' do
  let!(:group) { create(:group) }
  let!(:messages) { create_list(:message, 20, group_id: group.id) }
  let(:group_id) { group.id }
  let(:id) {messages.first.id }

  describe 'GET /groups/:group_id/messages' do
    before { get "/groups/#{group_id}/messages" }

    context 'when group exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all group messages' do
        expect(json.size).to eq(20)
      end
    end

    context 'when group does not exist' do
      let(:group_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Group/)
      end
    end
  end

  describe 'GET /groups/:group_id/messages/:id' do
    before { get "/groups/#{group_id}/messages/#{id}" }
    
    context 'when group message exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the message' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when group message does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Message/)
      end
    end
  end

  describe 'POST /groups/:group_id/messages' do
    let(:valid_attributes) { { content: 'This is for sure a fun time', created_by: 'Drew' } }

    context 'when request attributes are valid' do
      before { post "/groups/#{group_id}/messages", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/groups/#{group_id}/messages", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Content can't be blank/)
      end
    end
  end

  describe 'PUT /groups/:group_id/messages/:id' do
    let(:valid_attributes) { { content: 'This is actually super fun' } }

    before { put "/groups/#{group_id}/messages/#{id}", params: valid_attributes }

    context 'when message exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the message' do
        updated_message = Message.find(id)
        expect(updated_message.content).to match(/This is actually super fun/) 
      end
    end

    context 'when the message does not exist' do
      let(:id) { 0 }
      
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Message/)
      end
    end
  end

  describe 'DELETE /groups/:id/' do
    before { delete "/groups/#{group_id}/messages/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

