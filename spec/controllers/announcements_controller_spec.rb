require 'rails_helper'

RSpec.describe AnnouncementsController, type: :controller do

  let(:announcement) do
    FactoryGirl.create(:announcement)
  end

  let(:valid_parameters) do
    {title: 'Test Announcement', post: 'Test post'}
  end

  let(:invalid_parameters) do
    {title: 'Test Announcement', post: nil}
  end

  describe 'GET #index' do
    it 'assigns all announcements as @announcements' do
      test_announcement = FactoryGirl.create(:announcement)
      get :index
      expect(assigns(:announcements)).to eq([test_announcement])
    end
  end

  describe 'GET #show' do
    context 'with a valid announcement' do
      before do
        get :show, params: { id: announcement.id }
      end

      it 'returns HTTP status 200 (OK)' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns the requested announcement as @announcement' do
        expect(assigns(:announcement)).to eq(announcement)
      end
    end

    context 'with an invalid announcement' do
      it 'returns HTTP status 404 (Not Found)' do
        expect do
          get :show, params: { id: -1 }
        end.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe 'GET #new' do
    it 'assigns a new announcement as @announcement' do
      get :new
      expect(assigns(:announcement)).to be_a_new(Announcement)
    end
  end

  describe 'POST #create' do
    context 'while logged in' do
      context 'as an admin' do
        login_admin
        context 'with valid parameters' do
          it 'returns HTTP status 201 (Created)' do
            post :create, params: { announcement: valid_parameters }
            expect(response).to have_http_status(:created)
          end

          it 'creates a new announcement' do
            expect do
              post :create, params: { announcement: valid_parameters }
            end.to change(Announcement, :count).by(1)
          end
        end

        context 'with invalid parameters' do
          it 'returns HTTP status 400 (Bad Request)' do
            post :create, params: { announcement: invalid_parameters }
            expect(response).to have_http_status(:bad_request)
          end
        end
      end

      context 'as an unapproved admin' do
        login_unapproved_admin
        it 'returns HTTP status 403 (Forbidden)' do
          post :create, params: { announcement: valid_parameters }
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'while logged out' do
      it 'returns HTTP status 403 (Forbidden)' do
        post :create, params: { announcement: valid_parameters }
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'with a valid announcement' do
      context 'as an admin' do
        login_admin
        it 'returns HTTP status 200 (OK)' do
          delete :destroy, params: { id: announcement.id }
          expect(response).to have_http_status(:ok)
        end

        it 'deletes the requested announcement' do
          announcement_to_delete = FactoryGirl.create(:announcement)
          expect do
            delete :destroy, params: { id: announcement_to_delete.id }
          end.to change(Announcement, :count).by(-1)
        end
      end

      context 'as an unapproved admin' do
        login_unapproved_admin
        it 'returns HTTP status 403 (Forbidden)' do
          put :destroy, params: { id: announcement.id }
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

    context 'with an invalid announcement' do
      it 'returns HTTP status 404 (Not Found)' do
        delete :destroy, params: { id: 1 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
