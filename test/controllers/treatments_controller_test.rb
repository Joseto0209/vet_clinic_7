require "test_helper"

class TreatmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @appointment = appointments(:one)
    @treatment = treatments(:one)
  end

  test "should get new" do
    get new_appointment_treatment_url(@appointment)
    assert_response :success
  end

  test "should create treatment with valid params" do
    assert_difference("Treatment.count", 1) do
      post appointment_treatments_url(@appointment), params: { treatment: {
        name: "Dental Cleaning",
        medication: "Anesthesia",
        dosage: "5 ml",
        notes: "Routine dental procedure",
        administered_at: "2026-04-09 15:00:00"
      } }
    end
    assert_redirected_to appointment_url(@appointment)
    assert_equal "Treatment was successfully created.", flash[:notice]
  end

  test "should not create treatment with invalid params" do
    assert_no_difference("Treatment.count") do
      post appointment_treatments_url(@appointment), params: { treatment: {
        name: "",
        administered_at: ""
      } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_appointment_treatment_url(@appointment, @treatment)
    assert_response :success
  end

  test "should update treatment with valid params" do
    patch appointment_treatment_url(@appointment, @treatment), params: { treatment: { name: "Updated Treatment" } }
    assert_redirected_to appointment_url(@appointment)
    assert_equal "Treatment was successfully updated.", flash[:notice]
  end

  test "should not update treatment with invalid params" do
    patch appointment_treatment_url(@appointment, @treatment), params: { treatment: { name: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy treatment" do
    assert_difference("Treatment.count", -1) do
      delete appointment_treatment_url(@appointment, @treatment)
    end
    assert_redirected_to appointment_url(@appointment)
    assert_equal "Treatment was successfully deleted.", flash[:notice]
  end
end
