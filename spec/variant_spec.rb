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

require 'variant'

RSpec.describe Variant do
	it "has a version number" do
		expect(Variant::VERSION).not_to be nil
	end
	
	it "can force the environment" do
		environment = {'VARIANT' => 'production', 'DATABASE_VARIANT' => 'replica'}
		
		Variant.force!('test', environment)
		
		expect(environment).to include('VARIANT' => 'test')
		expect(environment).to_not include('DATABASE_VARIANT')
	end
	
	describe '.default' do
		it 'can get default variant' do
			expect(Variant.default).to_not be_nil
		end
	end
	
	describe '.default=' do
		it 'can set default variant' do
			Thread.new do
				Variant.default = :testing
				expect(Variant.default).to be :testing
			end.join
		end
	end
	
	describe '.for' do
		it "gives the default variant if a specific variant is not specified" do
			Thread.new do
				Variant.default = :staging
				expect(Variant.for(:database)).to be :staging
			end.join
		end
		
		it "gives the specific variant if a specific variant is specified" do
			Thread.new do
				Variant.default = :staging
				Variant::Environment.instance.override_variant(:database, :testing)
				expect(Variant.for(:database)).to be :testing
			end.join
		end
	end
end
