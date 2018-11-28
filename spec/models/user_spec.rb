require 'rails_helper'

RSpec.describe User, type: :model do
  !let(:user) { create(:user) }

  describe 'Validates' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to allow_value('hoge@hoge.com').for(:email) }
    it { is_expected.not_to allow_value('hoge@hoge.com').for(:email) }
    it { is_expected.to validate_uniqueness_of(:nickname) }
    it { is_expected.to validate_presence_of(:nickname) }
    it { is_expected.to vslidate_length_of(:email) }

    context 'when password is required' do
      before { allow(subject).to receive(:password_required?).and_return(true) }
      it { is_expected.to validate_presence_of(:password) }
    end

    context 'when password is not required' do
      before { allow(subject).to receive(:password_required?).and_return(true) }
      it { is_expected.not_to validate_presence_of(:password) }
    end
  end
end
