require "yast"
require_relative "password"

# rubocop:disable Style/MethodName
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
module Yast
  # class to add label to button
  class LabelClass < Module
    def RevertButton
      _("&Revert")
    end
  end
end

#
# module password
#
module Password
  Yast.import "UI"
  Yast.import "Label"
  Yast.import "Popup"

  #
  # class for the dialog design
  #
  class PasswordDialog
    include Yast::UIShortcuts
    include Yast::I18n
    include Yast::Logger

    def initialize
      textdomain "password_policy"
    end

    # Displays the dialog
    def run
      return unless create_dialog

      begin
        return event_loop
      ensure
        close_dialog
      end
    end
    ###
    ###

    private

    # Draws the dialog
    def create_dialog
      Yast::UI.OpenDialog(
        Opt(:decorated, :defaultsize),
        VBox(
          # Header
          Heading(_("Password Policy Configuration")),

          # Filter checkboxes
          Frame(
            _("Endpoints"),
            add_endpoints_widget
          ),
          VSpacing(0.5),
          Frame(
            _("Password Policy"),
            add_password_policy_widget
          ),
          # buttons
          VSpacing(0.5),
          Frame(
            _("Actions"),
            ButtonBox(
              PushButton(Id(:cancel), Yast::Label.QuitButton),
              PushButton(Id(:revert), Yast::Label.RevertButton),
              PushButton(Id(:accept), Yast::Label.AcceptButton)
            )
          )
        )
      )
    end

    def close_dialog
      Yast::UI.CloseDialog
    end

    # Simple event loop
    def event_loop
      loop do
        case Yast::UI.UserInput
        when :cancel
          # Break the loop
          break
        when :accept
          p = apply_password_policy
          # if the password isnt the default
          # save it
          p.save_policy unless p == DEFAULT_POLICY
          Yast::Popup.Notify(_("Password policy applied successfully!"))
        when :revert
          revert_password_policy
          Yast::Popup.Notify(_("Password policy reverted sucessfully!"))
        else
          log.warn "Unexpected input #{input}"
        end
      end
    end

    # TODO
    # we should honor the defined password policy
    # to apply and to reset
    def apply_password_policy
      build_password_policy.apply
    end

    def revert_password_policy
      build_password_policy.revert
    end

    # Widget containing a checkbox per filter
    def add_endpoints_widget
      checkboxes = ENDPOINTS.map do |name, label|
        Left(
          HBox(
            CheckBox(Id(name), label, false),
            HSpacing(0.5)
          )
        )
      end
      VBox(*checkboxes)
    end

    def add_password_policy_widget
      elements = Password::current_policy.map do |name, value|
        Left(
          HBox(
            Label("#{name}:"),
            # HSpacing(1),
            Right(
              InputField(Id(name), "", value.to_s)
            )
          )
        )
      end
      VBox(*elements)
    end

    # build a password_policy object
    def build_password_policy
      Password.new(policy:    password_policy,
                   endpoints: selected_endpoints)
    end

    def password_policy
      Hash[DEFAULT_POLICY.map do |name, _|
        [name, Yast::UI.QueryWidget(Id(name), :Value)]
      end]
    end

    def selected_endpoints
      ENDPOINTS.select { |name, _| Yast::UI.QueryWidget(Id(name), :Value) }
    end
  end # class
end # module
