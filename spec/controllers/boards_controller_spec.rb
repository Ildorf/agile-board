require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  let(:board) { create(:board) }

  describe "GET #new" do
    before { get :new }
    it "assigns new Board to @board" do
      expect(assigns(:board)).to be_a_new Board
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    it "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    before { get :show, params: {id: board} }

    it "assigns requsted board to @board" do
      expect(assigns(:board)).to eq board
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe "GET #index" do
    let(:boards) { create_list(:board, 2) }
    before { get :index }

    it "populates an array of all boards" do
      expect(assigns(:boards)).to match_array(boards)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe "GET #edit" do
    before { get :edit, params: {id: board} }

    it "assigns requsted board to @board" do
      expect(assigns(:board)).to eq board
    end

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe "PATCH #update" do
    it "returns http success" do
      patch :update, params: {id: board}
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE #destroy" do
    it "returns http success" do
      delete :destroy, params: {id: board}
      expect(response).to have_http_status(:success)
    end
  end

end
