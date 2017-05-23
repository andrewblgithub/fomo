require 'rails_helper'

RSpec.describe 'Groups API', type: :request do
  # initialize test data 
  let(:user) { create(:user)  }
  let!(:groups) { create_list(:group, 7, created_by: user.id) }
  let(:group_id) { groups.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # test suite for GET /groups
  describe 'GET /groups' do
    # make HTTP request before each example
    before { get '/groups', params: {}, headers: headers  }

    it 'returns groups' do
      # json is cusom helper to parse json responses
      expect(json).not_to be_empty
      expect(json.size).to eq(7)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # test suite for GET /groups/:id
  describe 'GET /groups/:id' do
    before { get "/groups/#{group_id}", params: {}, headers: headers  }

    context 'when the record exists' do
      it 'returns the group' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(group_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:group_id) { 100 }

      it 'return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Group/)
      end
    end
  end
  
  # test suite for POST /groups
  describe 'POST /groups' do
    #valid payload
    let(:valid_attributes) do
      { name: 'FunGroup', created_by: user.id.to_s }.to_json
    end

    context 'when the request is valid' do
      before { post '/groups', params: valid_attributes, headers: headers  }

      it 'creates a group' do
        expect(json['name']).to eq('FunGroup')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:valid_attributes) { { name: nil }.to_json }
      before { post '/groups', params: valid_attributes, headers: headers  }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        # changed Validation failed: created_by... to Name
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # test suite for PUT /groups/:id
  describe 'PUT /groups/:id' do
    let(:valid_attributes) { { name: 'SuperFunGroup' }.to_json }

    context 'when the record exists' do
      before { put "/groups/#{group_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # test suite for DELETE /groups/:id
  describe 'DELETE /groups/:id' do
    before { delete "/groups/#{group_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
