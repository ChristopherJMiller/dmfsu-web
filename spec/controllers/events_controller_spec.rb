require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  let(:event) do
    FactoryGirl.create(:event)
  end

  let(:valid_parameters) do
    {title: 'Test Event', description: 'Test description', location: '1234 Street St. New York, USA', start_time: '2016-07-01 23:57:29.000000000 -0500', end_time: '2016-07-02 23:57:29.000000000 -0500'}
  end

  let(:invalid_parameters) do
    {title: nil, description: 'Test description', location: '1234 Street St. New York, USA', start_time: '2016-07-01 23:57:29.000000000 -0500', end_time: '2016-07-02 23:57:29.000000000 -0500'}
  end

  describe 'GET #index' do
    it 'assigns all events as @events' do
      test_event = FactoryGirl.create(:event)
      get :index
      expect(assigns(:events)).to eq([test_event])
    end
  end

  describe 'GET #show' do
    context 'with a valid event' do
      before do
        get :show, params: { id: event.id }
      end

      it 'returns HTTP status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns the requested event as @event' do
        expect(assigns(:event)).to eq(event)
      end
    end

    context 'with an invalid event' do
      it 'returns HTTP status 404 (Not Found)' do
        expect do
          get :show, params: { id: -1 }
        end.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe 'GET #new' do
    it 'assigns a new event as @event' do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe 'POST #create' do
    context 'while logged in' do
      context 'as an admin' do
        login_admin
        context 'with valid parameters' do
          it 'returns HTTP status 201 (Created)' do
            post :create, params: { event: valid_parameters }
            expect(response).to have_http_status(:created)
          end

          it 'creates a new event' do
            expect do
              post :create, params: { event: valid_parameters }
            end.to change(Event, :count).by(1)
          end
        end

        context 'with invalid parameters' do
          it 'returns HTTP status 400 (Bad Request)' do
            post :create, params: { event: invalid_parameters }
            expect(response).to have_http_status(:bad_request)
          end
        end
      end

      context 'as an unapproved admin' do
        login_unapproved_admin
        it 'returns HTTP status 403 (Forbidden)' do
          post :create, params: { event: valid_parameters }
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'while logged out' do
      it 'returns HTTP status 403 (Forbidden)' do
        post :create, params: { event: valid_parameters }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with a valid event' do
      context 'as an admin' do
        login_admin
        it 'returns HTTP status 200 (OK)' do
          delete :destroy, params: { id: event.id }
          expect(response).to have_http_status(:ok)
        end

        it 'deletes the requested event' do
          event_to_delete = FactoryGirl.create(:event)
          expect do
            delete :destroy, params: { id: event_to_delete.id }
          end.to change(Event, :count).by(-1)
        end
      end

      context 'as an unapproved admin' do
        login_unapproved_admin
        it 'returns HTTP status 403 (Forbidden)' do
          put :destroy, params: { id: event.id }
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'with an invalid event' do
      it 'returns HTTP status 404 (Not Found)' do
        delete :destroy, params: { id: 1 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
