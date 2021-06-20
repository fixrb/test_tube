# frozen_string_literal: true

desc "Generate the picture of the behavior of the code"
task :brutal do
  Dir.chdir("test") do
    paths = %w[. ..]

    Dir.entries(".").reject { |name| paths.include?(name) }.each do |test|
      Dir.chdir(test) do
        print "Generating #{test} test suite... "

        `bundle exec brutal`
        `chmod +x test.rb`

        puts "Done."
      end
    end
  end
end
