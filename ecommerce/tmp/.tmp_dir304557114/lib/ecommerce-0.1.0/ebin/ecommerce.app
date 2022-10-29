{application,ecommerce,
    [{compile_env,[{ecommerce,['Elixir.EcommerceWeb.Gettext'],error}]},
     {applications,
         [kernel,stdlib,elixir,logger,runtime_tools,phoenix,phoenix_ecto,
          ecto_sql,postgrex,phoenix_html,phoenix_live_reload,
          phoenix_live_view,phoenix_live_dashboard,esbuild,swoosh,
          telemetry_metrics,telemetry_poller,gettext,jason,plug_cowboy,
          distillery,ex_doc]},
     {description,"ecommerce"},
     {modules,
         ['Elixir.Ecommerce','Elixir.Ecommerce.Application',
          'Elixir.Ecommerce.Catalog','Elixir.Ecommerce.Catalog.Category',
          'Elixir.Ecommerce.Catalog.Product','Elixir.Ecommerce.Mailer',
          'Elixir.Ecommerce.Orders','Elixir.Ecommerce.Orders.LineItem',
          'Elixir.Ecommerce.Orders.Order','Elixir.Ecommerce.Repo',
          'Elixir.Ecommerce.ShoppingCart',
          'Elixir.Ecommerce.ShoppingCart.Cart',
          'Elixir.Ecommerce.ShoppingCart.CartItem','Elixir.EcommerceWeb',
          'Elixir.EcommerceWeb.CartController',
          'Elixir.EcommerceWeb.CartItemController',
          'Elixir.EcommerceWeb.CartView','Elixir.EcommerceWeb.Endpoint',
          'Elixir.EcommerceWeb.ErrorHelpers','Elixir.EcommerceWeb.ErrorView',
          'Elixir.EcommerceWeb.Gettext','Elixir.EcommerceWeb.LayoutView',
          'Elixir.EcommerceWeb.OrderController',
          'Elixir.EcommerceWeb.OrderView',
          'Elixir.EcommerceWeb.PageController','Elixir.EcommerceWeb.PageView',
          'Elixir.EcommerceWeb.ProductController',
          'Elixir.EcommerceWeb.ProductView','Elixir.EcommerceWeb.Router',
          'Elixir.EcommerceWeb.Router.Helpers',
          'Elixir.EcommerceWeb.Telemetry']},
     {registered,[]},
     {vsn,"0.1.0"},
     {mod,{'Elixir.Ecommerce.Application',[]}}]}.