require 'rails_helper'

RSpec.describe 'Events API' do
  let(:user) { create(:user)  }
  let!(:group) { create(:group, created_by: user.id)  }
  let!(:events) { create_list(:event, 10, group_id: group.id) }
  let(:group_id) { group.id }
  let(:id) {events.first.id }
  let(:headers) { valid_headers }

  describe 'GET /groups/:group_id/events' do
    before { get "/groups/#{group_id}/events", params: {}, headers: headers }

    context 'when group exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all group events' do
        expect(json.size).to eq(10)
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

  describe 'GET /groups/:group_id/events/:id' do
    before { get "/groups/#{group_id}/events/#{id}", params: {}, headers: headers }
    
    context 'when group event exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the event' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when group event does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end
  end

  describe 'POST /groups/:group_id/events' do
    let(:valid_attributes) { { title: 'Fun Times', description: 'This is for sure a fun time', created_by: user.id.to_s, expires_at: '2017-12-04 00:00:00' }.to_json }

    context 'when request attributes are valid' do
      before { post "/groups/#{group_id}/events", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/groups/#{group_id}/events", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /groups/:group_id/events/:id' do
    let(:valid_attributes) { { title: 'Superfun Times' }.to_json }

    before do
      put "/groups/#{group_id}/events/#{id}", params: valid_attributes, headers: headers 
    end

    context 'when event exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the event' do
        updated_event = Event.find(id)
        expect(updated_event.title).to match(/Superfun Times/) 
      end
    end

    context 'when the event does not exist' do
      let(:id) { 0 }
      
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Event/)
      end
    end
  end

  describe 'DELETE /groups/:id/' do
    before { delete "/groups/#{group_id}/events/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

