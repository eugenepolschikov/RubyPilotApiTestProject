ParameterType(
    name: 'email',
    regexp: /.*/,
    transformer: ->(s) {
      if s.include? "unique"
        "test_#{Faker::Internet.email}"
      else
        s
      end
    }
)

ParameterType(
    name: 'first_name',
    regexp: /.*/,
    transformer: ->(s) {
      if s.include? "unique"
        "#{Faker::Name.first_name}"
      else
        s
      end
    }
)

ParameterType(
    name: 'last_name',
    regexp: /.*/,
    transformer: ->(s) {
      if s.include? "unique"
        "#{Faker::Name.last_name}"
      else
        s
      end
    }
)

ParameterType(
    name: 'phone_number',
    regexp: /.*/,
    transformer: ->(s) {
      if s.include? "unique"
        "#{Faker::Number.number(digits: 12)}"
      else
        s.to_s
      end
    }
)
