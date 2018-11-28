require 'rails_helper'

RSpec.describe Authentication, type: :model do
  let!(:Authentication) { create(:authentication) }

  describe 'Validations' do
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :provider }
    it { is_expected.to validate_presence_of :uid }
    it { is_expected.to validate_uniqueness_of(:provider).scoped_to(:uid) }
  end

  describe '.find_by_auth' do
    it 'returns Authentication instance based on auth.provider and auth.uid' do
      auth = OmniAuth::AuthHash.new(provider: "hoge", uid: 123_456_789)
      expect(Authentication.find_by_auth(auth)).to eq authentication
    end
  end

  describe '.find_or_create_by_oauth' do
    context 'when authentication exists' do
      it 'returns authentication.user' do
        auth = OmniAuth::AuthHash.new(provider: "hoge", uid: 123_456_789)
        expect(Authentication.find_or_create_by_oauth(auth)).to eq authentication.user
      end
    end

    context 'when authentication does not exist' do
      it 'calls find_or_create_user method' do
        auth = OmniAuth::AuthHash.new(provider: "foo", uid: 987_654_321)
        allow(Authentication).to receive(:find_or_create_user)
        Authentication.find_or_create_by_oauth(auth)
        expect(Authentication).to have_received(:find_or_create_user)
      end
    end
  end

  descrive '.find_or_create_user' do
    let(:user) { create(:user) }

    context 'when user already registered' do
      it 'returns registered_user and creates new authentication' do
        info_hash = { email: user.email }
        auth = OmniAuth::AuthHash.new(provider: "foo", uid: 000_000_000, info: info_hash)
        expect{ Authentication.find_or_create_user(auth) }.to change{ Authentication.count }.by(1).and change{User.count }.by(0)
      end
    end

    context 'when user did not register yet' do
      it 'creates new authentication and user' do
        info_hash = { email: "fuga@fuga.com", nickname: "hogehoge" }
        auth = OmniAuth::AuthHash.new(provider: "foo", uid: 000_000_000, info: info_hash)
        expect{ Authentication.find_or_create_user(auth) }.to change{ Authentication.count }.by(1).and change{ User.count }.by(1)
      end
    end
  end
end



