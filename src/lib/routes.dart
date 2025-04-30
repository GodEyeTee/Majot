final router = GoRouter(
  routes: [
    ...getHotelRoutes(),
    ...getShoppingRoutes(),
    ...getProfileRoutes(),
    ...getAdminRoutes(),
  ],
);
