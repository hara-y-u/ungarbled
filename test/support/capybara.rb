Capybara.register_driver :ie7 do |app|
  Capybara::RackTest::Driver.new(
    app,
    headers: {
      'HTTP_USER_AGENT' => 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)'
    }
  )
end
