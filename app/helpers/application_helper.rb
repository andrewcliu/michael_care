module ApplicationHelper
	def cancel_btn 
		"<button class='cancelBtn btn btn-danger '>Cancel</button>".html_safe
	end

	def double_space
		'&nbsp;&nbsp;'.html_safe
	end
	def methods
		%w'new create update destroy edit create show'
	end

	def convert_oz a
		Unit.new(a).convert_to('oz')
	end

	def biz_name 
		"C.A.R.E"
	end
	def business_header_name 
		"<span class='color_red'>2</span>Cheng's".html_safe
	end
	def business_info
		'<p><span class="title"><i class="fas fa-phone"></i>:</span> (415)295-2882<br> 
		<span class="title"><i class="fas fa-envelope-open"></i>:</span> info@onemilktea.com <br>
		<span class="title"><i class="fas fa-map-marked-alt"></i>:</span> 4443 Auburn Blvd, Sacramento CA</p>'.html_safe
	end

	def this 
		unless just_controller.include? controller_name.to_s.downcase
			return controller_name.to_s.include?('_') ? controller_name.camelcase.singularize.constantize : controller_name.singularize.humanize.constantize
		end
	end

	def just_controller 
		%w'menu'
	end

	def constantize_table e
		e.to_s.include?('_') ? e.camelcase.singularize.constantize : e.to_s.last=='s' ? e.singularize.humanize.constantize : e.camelcase.singularize.constantize
	end

	def var_name e 
		instance_variable_set(:"@#{e.singularize}",e)
	end

	def attribute_keys e 
		f=e.new.attributes.keys - %w'updated_at created_at'
		temp=[]
		f.each do |g| 
			temp.push g.to_sym 
		end
		return temp
	end

	def not_tables_in_admin
		%w'admins ar_internal_metadata schema_migrations'
	end

	def db_tables
		table=[]
		temp=ActiveRecord::Base.connection.tables
		temp.each do |e|
			table.push(e)
		end
		table=table-not_tables_in_admin
		return table.sort_by{|h| h}.reverse!
	end

	def table_fields e
		constantize_table(e).admin_view.present? ? (constantize_table(e).admin_view-['updated_at']) : constantize_table(e).list_view 
	end

	def sanitize e
		if e.present?
			if e.is_a? Float 
				number_to_currency(e)
			elsif e == true 
				return '<i class="fas fa-check"></i>'.html_safe 

			elsif e.is_a? String 
				unless e == true or e == false
					e.humanize.camelcase
				end
			elsif e.is_a? Date or e.class.to_s.include?('TimeWithZone')
				Date.parse(e.to_s).strftime("%m/%d/%Y")
			else
				e 
			end
		else
			if e == false
				return '<i class="fas fa-times"></i>'.html_safe
			end
		end
	end

	def form_fields e
		e.form_view.present? ? view=e.form_view : e.list_view.present? ? view=e.list_view : view=e.admin_view
		return view
	end

	# def prod_type 
	# 	%w'null boba milk syrup juice tea_leaves sauce food_related utensils jam jelly powder operations other'
	# end

	def men_type 
		%w'null top_picks snacks slider'
	end

	def form_collection e
		if e.to_s.include? '_ids'
			g=e.to_s.gsub('_ids','')
		elsif e.to_s.include? '_id'
			g=e.to_s.gsub('_id','')
		end
		if g.to_s.include?('_')
			g=g.camelcase.singularize.constantize
		else 
			g=g.humanize.constantize
		end
		g=g.all.collect{|e|[e.to_s,e.id]}
		return g
	end

	def form_class e 
		e.include?('date') ? cn='datepicker' : cn='validate inputs'
		return cn
	end

	def return_views e 
		f=e.new.attributes.keys - %w'updated_at created_at'
		return f
	end

	def month_date e
		Date.parse(e.to_s).strftime("%m/%d") 
	end

	def admin_links 
		%w'tasks'
	end

	def item_menu 
		%w'categories items'
	end

	def inventory_menu 
		%w'products inventories'
	end


	def customer_menu 
		%w'categories items'
	end

	def associates_and_hr
		%w'employees employee_infos handbooks'
	end

	def hiring_process 
		%w'employments careers'
	end

	def public_relations
		%w'events surveys surveychoices slideshows'
	end

	def marketing_related 
		%w'campaigns barcodes'
	end

	def inventory
		%w'inventories products orders'
	end

	def all_menu 
		%w'customer_menu inventory associates_and_hr hiring_process public_relations marketing_related'
	end

	def menu_items
		%w'admins careers employees employee_infos accounts events campaigns employments barcodes products inventories categories items tasks sessions orders surveys surveychoices slideshows handbooks'
	end
	
	def test_singularity(str)
	  str.pluralize != str && str.singularize == str
	end

	def read_pdf pdf 
		# pdf.path
	end

	def editable 
		%w'Account Item Product Category Barcode Slideshow Menucontrol'
	end

	def editable_items 
		%w'email tv_menu_location root_description company url notes phone name on_hand price purchase_price units ingredients description order has_delivery pix'
	end

  def navigation_add(title, url)
    nav_list = session['navigation'].present? ? session['navigation'] : []
    nav_list << { 'title' => title=='admin' ? title='dashboard' : title, 'url' => url }
    
    nav_list = nav_list[-3..-1] if nav_list.length > 4
    
    nav_list.shift if nav_list[0]['url'] == admins_path
    
    nav_list.pop if nav_list.length > 1 && (nav_list[-1]['url'] == nav_list[-2]['url'])

    session['navigation'] = nav_list
  end

  def render_navigation
    render partial: 'bread_crumb', locals: { nav_list: session['navigation'] }
  end

  def no_auth 
  	%w'StaticPage'
  end

  def no_auth_create 
  	%w'Career Surveychoice Campaign Admin'
  end

  def is_super_admin?
  	current_admin.id == 1 
  end

  def current_user
  	current_admin
  end

end
