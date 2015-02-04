module Jekyll

  class NestedMenuTag < Liquid::Tag

    def initialize(tag_name, menu_root, tokens)
      @menu_root = menu_root.strip
      super
    end

    def render(context)
      menu(context)
    end

    private
      def menu(context)
        site_data_key = "#{@menu_root}_menu_items"
        root_string = "/#{@menu_root}" 
        if not context['site']['data'].include?(site_data_key)
          menu_hash = {}
          menu_items = ''
          context['site']['pages'].find_all{|page| page.url.start_with?(root_string)}.each do |page|
            path_parts = page.path.split('/')
            path_parts.shift
            menu_hash = build_menu_hash(page, path_parts, menu_hash)
          end

          context['site']['data'][site_data_key] = build_menu_string(menu_hash)
        end

        context['site']['data'][site_data_key]
      end

      def build_menu_hash(page, path_parts, menu_hash=nil)
        if path_parts.empty?
          return page
        end

        menu_hash = {} if menu_hash.nil?
        path_part = path_parts.shift

        menu_hash[path_part] = build_menu_hash(page, path_parts, menu_hash[path_part])

        menu_hash
      end

      def build_menu_string(menu_hash)
        menu_string = ''
        menu_hash.each do |dir_name, dir|
          item_string_part = ''

          # Seperate the child pages from other decendent pages
          if dir.is_a?(Jekyll::Page)
            dir_hash = {}
            dir_hash[dir.name] = dir
            dir = dir_hash
          end
          pages = dir.select{ |k, v| v.is_a?(Jekyll::Page) }
          dir = dir.reject{ |k, v| v.is_a?(Jekyll::Page) } 

          pages.each do |file_name, page|
            item_string_part << "<a href='#{page.url}'>#{page.data['title'].split('/').last}</a>"
          end

          if not dir.empty?
            item_string_part << build_menu_string(dir)
          end

          menu_string << "<li>#{item_string_part}</li>"
        end
        "<ul>#{menu_string}</ul>"
      end
  end
end

Liquid::Template.register_tag('nested_menu', Jekyll::NestedMenuTag)
