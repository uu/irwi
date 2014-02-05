require 'active_support/core_ext/hash'

class Irwi::Paginators::None

  def paginate( collection, options = {} )
    find_options = options.except :page, :per_page, :total_entries, :finder

    if collection.is_a? ActiveRecord::Base
      collection.all
    else
      collection
    end
  end

  def paginated_section( view, collection, &block )
    yield
    return
  end

end
