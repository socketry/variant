# frozen_string_literal: true

# Copyright, 2020, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require_relative 'lib/variant/version'

Gem::Specification.new do |spec|
	spec.name = "variant"
	spec.version = Variant::VERSION
	spec.authors = ["Samuel Williams"]
	spec.email = ["samuel.williams@oriontransfer.co.nz"]
	
	spec.summary = "A policy gem for selecting different environments."
	spec.homepage = "https://github.com/socketry/variant"
	spec.license = "MIT"
	spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
	
	# Specify which files should be added to the gem when it is released.
	# The `git ls-files -z` loads the files in the RubyGem that have been added into git.
	spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
		`git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
	end
	
	spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
	spec.require_paths = ["lib"]
	
	spec.add_dependency "thread-local"
	
	spec.add_development_dependency "covered"
	spec.add_development_dependency "bundler"
	spec.add_development_dependency "rspec"
	spec.add_development_dependency "rake"
end
