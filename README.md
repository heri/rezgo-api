# rezgo

A simple wrapper for connecting to the [Rezgo API](https://www.rezgo.com/developers/).

## Install

	gem install rezgo

## Usage

Using the library is as simple as creating a **Rezgo::Connection** object:

	conn = Rezgo::Connection.new(transcode, api_key, result_type)

The result type can be one of **hash** or **raw** where **raw** will return the raw XML from the API and **hash** will return a Ruby Hash of the result.

### Searches

	# Instantiate the connection
	conn = Rezgo::Connection.new("p999", "XXX-YYYY-ZZZZ-MMM", "hash")
	# Check we're working
	obj = conn.company
	 => {"currency_base"=>"USD", "company_name"=>"Heri", "date_format"=>"Y-m-d", "gt"=>"0.00432", "country"=>"us"(...)
	obj["company_name"]
	=> "Heri"
	# Search for tours available on 1-Dec-2015
	obj = conn.search_items(:d => "2015-12-01")
	=> {Hash of all items available on that date}
	# See how many tours you have access to.
	obj = conn.search_items
	obj["item"].count
	=> 100
	# Get the name of the first tour.
	obj["item"].first["name"]
	=> "Paris Essentials Tour"
	# Search for all tours in Canada
	obj = conn.search_items(:f => {["country"] => "ca"})
	=> {"gt"=>"0.02244", "total"=>"0"} # In this case, there are none.

### Passing parameters

Some Rezgo methods accept parameters. Most are named, but optional parameters are always passed using a Hash. Check the source for named parameters and further refer to the Rezgo API documentation for permissible parameters and values.

	obj = conn.search_items({:f => {["country"] => "ca"}, :q => "kayak"})

## List of functions in Rezgo::Connection

*	company
*	headers
*	about
*	search\_items
*	tags
*	commit
*	modify\_bookings
*	search\_bookings
*	month
*	region\_list
*	classification\_list

## Dependencies

This gem depends on ActiveSupport

## Contributing to rezgo

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Flextrip. See LICENSE.txt for further details.
