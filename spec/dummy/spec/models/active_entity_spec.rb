require "rails_helper"

RSpec.describe ActiveEntity do
    subject { ActiveEntity.create }
    context "when the entity is inferable" do
      it { is_expected.to respond_to(:pending_records) }
      it { is_expected.to respond_to(:features) }
      it { is_expected.to respond_to(:any_feature_changed?) }
    end
    context "when the entity is not inferable" do
      subject { PlainEntity.create }
      it { is_expected.not_to respond_to(:pending_records) }
      it { is_expected.not_to respond_to(:features) }
      it { is_expected.not_to respond_to(:any_feature_changed?) }
    end
    describe "callbacks" do
      describe "after_create" do
        it "creates exactly one pending record" do
          expect(subject.pending_records.size).to eq 1
        end
      end
      describe "after_update" do
        context "when the feature is inferable" do
          before(:each) { subject.inferable_feature = 1 }
          it "creates exactly one pending record" do
            expect { subject.save! }.to change { subject.pending_records.size }.by 1
          end
        end
        context "when the feature is not inferable" do
          before(:each) { subject.non_inferable_feature = 1 }
          it "does not create pending records" do
            expect { subject.save! }.not_to change { subject.pending_records.size }
          end
        end
      end
    end
  end