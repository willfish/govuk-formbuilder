module Setup
  module ExampleData
    def departments_data_raw
      <<~DATA
        department = Struct.new(:id, :name, keyword_init: true)
        departments = [
          department.new(id: 1, name: 'Sales'),
          department.new(id: 2, name: 'Marketing'),
          department.new(id: 3, name: 'Finance')
        ]
      DATA
    end

    def departments_value_data_raw
      <<~DATA
        department = Struct.new(:id, keyword_init: true)
        departments = [
          department.new(id: :sales),
          department.new(id: :marketing),
          department.new(id: :finance),
          department.new(id: :digital)
        ]
      DATA
    end

    def contact_types_data_raw
      <<~DATA
        contact_type = Struct.new(:value, keyword_init: true)
        contact_types = [
          contact_type.new(value: :email),
          contact_type.new(value: :phone),
          contact_type.new(value: :letter)
        ]
      DATA
    end

    def lunch_options_raw
      <<~DATA
        lunch_option = Struct.new(:id, :name, :description, keyword_init: true)
        lunch_options = [
          lunch_option.new(
            id: 1,
            name: 'Salad',
            description: 'Lettuce, tomato and cucumber'
          ),
          lunch_option.new(
            id: 2,
            name: 'Jacket potato',
            description: 'With cheese and baked beans'
          )
        ]
      DATA
    end

    def grouped_lunch_options_raw
      <<~DATA
        grouped_lunch_options = {
          "Sandwiches" => { "Ploughman's lunch" => :pl, "Tuna mayo" => :tm },
          "Salads" => { "Greek salad" => :gs, "Tabbouleh" => :tb }
        }
      DATA
    end

    def primary_colours_raw
      <<~DATA
        colour = Struct.new(:id, :name, :description, keyword_init: true)
        primary_colours = [
          colour.new(
            id: :cyan,
            name: 'Cyan',
            description: 'Greenish-blue'
          ),
          colour.new(
            id: :magenta,
            name: 'Magenta',
            description: 'Purplish-red'
          ),
          colour.new(
            id: :yellow,
            name: 'Yellow',
            description: 'Yellowy-yellow'
          )
        ]
      DATA
    end

    def laptops_data_raw
      <<~DATA
        laptops = %w(thinkpad xps macbook_pro zenbook)
      DATA
    end

    def custom_locale_config_raw
      <<~CONFIG
        GOVUKDesignSystemFormBuilder.configure do |conf|
          conf.localisation_schema_fallback = %i(helpers __context__)
          conf.localisation_schema_hint     = %i(copy descriptions __context__ subdivision)
        end
      CONFIG
    end

    def custom_error_presenter_raw
      <<~CODE
        class ErrorSummaryUpperCasePresenter
          def initialize(error_messages)
            @error_messages = error_messages
          end

          def formatted_error_messages
            @error_messages.map { |attribute, messages| [attribute, messages.first.upcase] }
          end
        end

        custom_error_presenter = ErrorSummaryUpperCasePresenter
      CODE
    end

    # Yes, eval is bad, but when you want to display code in documentation as
    # well as run it, it's kind of necessary. Not considering this a security
    # threat as it's only used in the guide 👮

    # rubocop:disable Security/Eval
    def departments
      eval(departments_data_raw)
    end

    def departments_collection
      eval(departments_value_data_raw)
    end

    def contact_types
      eval(contact_types_data_raw)
    end

    def lunch_options
      eval(lunch_options_raw)
    end

    def grouped_lunch_options
      eval(grouped_lunch_options_raw)
    end

    def primary_colours
      eval(primary_colours_raw)
    end

    def laptops
      eval(laptops_data_raw)
    end

    def custom_locale_config
      eval(custom_locale_config_raw)
    end

    def custom_error_presenter
      eval(custom_error_presenter_raw)
    end

    # rubocop:enable Security/Eval

    def form_data
      {
        departments:,
        departments_collection:,
        contact_types:,
        lunch_options:,
        grouped_lunch_options:,
        primary_colours:,
        laptops:,
        custom_error_presenter:,
      }
    end
  end
end
