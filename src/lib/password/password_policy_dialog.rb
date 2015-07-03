require "yast"
require_relative "password"

Yast.import "UI"
Yast.import "Label"


module Password
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
        Heading(_("Password Policy")),

        # Filter checkboxes
        Frame(
          _("Endpoints"),
          add_endpoints_widget
        ),
        VSpacing(0.3),
        Frame(
          _("Password Policy"),
          add_password_policy_widget
        ),
        # Quit button
        PushButton(Id(:cancel), Yast::Label.QuitButton)
      )
    )
  end
  def close_dialog
    Yast::UI.CloseDialog
  end

  # Simple event loop
  def event_loop
    loop do
      input = Yast::UI.UserInput
      if input == :cancel
        # Break the loop
        break
      else
        log.warn "Unexpected input #{input}"
      end
    end
  end

  # Widget containing a checkbox per filter
  def add_endpoints_widget
      endpoints = Password::ENDPOINTS.collect { |k,v| {:name =>k, :label => _(v) } }

       checkboxes = endpoints.map do |endpoint|
         name = endpoint[:name]
         Left(
           HBox(
             CheckBox(Id(name), endpoint[:label])           )
         )
       end
       VBox(*checkboxes)
  end

  def add_password_policy_widget
    elements = Password::DEFAULT_POLICY.map do |name,value|
      Left(
        HBox(
          Label("#{name.to_s}:"),
          HSpacing(1),
          InputField(Id(name), "", value.to_s)
        )
      )
    end
    VBox(*elements)
  end
 end # class
end # module
