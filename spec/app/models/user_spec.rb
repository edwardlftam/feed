require 'model_helper'

describe User do
  describe 'validations' do
    context 'when email is invalid' do
      let(:invalid_email) { 'invalid_email' }
      subject { build :user, email: invalid_email }
      it "is invalid" do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.first).to include("is invalid")
      end
    end

    context "when password is empty" do
      subject { build :user, password: nil }
      it "is invalid" do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.first).to include("cannot be empty")
      end
    end

    context "when password does not match confirmation" do
      subject { build :user, password: '12345678', password_confirmation: '87654321' }
      it "is invalid" do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.first).to include("did not match the confirmation")
      end
    end

    context "when password exceeds maximum length" do
      let(:password) { '1' * 256 }
      subject { build :user, password: password, password_confirmation: password }
      it "is invalid" do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.first).to include("must have length between 8 and 255")
      end
    end

    context "when first_name is not provided" do
      subject { build :user, first_name: nil }
      it "is invalid" do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.first).to include("First name can't be blank")
      end
    end

    context "when first_name exceeded maximum length" do
      subject { build :user, first_name: 'a' * 256 }
      it "is invalid" do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.first).to include("First name is too long")
      end
    end

    context "when last_name is not provided" do
      subject { build :user, last_name: nil }
      it "is invalid" do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.first).to include("Last name can't be blank")
      end
    end

    context "when last_name exceeded maximum length" do
      subject { build :user, last_name: 'a' * 256 }
      it "is invalid" do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.first).to include("Last name is too long")
      end
    end
  end

  describe "behaviors" do
    context "on create" do
      let(:password) { '12345678' }
      subject { create :user, password: password, password_confirmation: password }
      it "encrypts the password" do
        expect(BCrypt::Password.new(subject.encrypted_password)).to eq(password)
      end
    end
  end

  describe "#authenticate!" do
    context "when password is correct" do
      let(:password) { '12345678' }
      subject { create :user, password: password, password_confirmation: password }
      before { subject }
      it "updates and returns the auth token" do
        token = nil
        expect { token = subject.authenticate!(password) }.to change { subject.reload.auth_token }
        expect(token).to eq(subject.auth_token)
      end
    end
  end
end