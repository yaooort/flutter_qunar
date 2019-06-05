class HomeEntity extends Object {
  List<HomeBannerlist> bannerList;
  List<HomeSubnavlist> subNavList;
  List<HomeLocalnavlist> localNavList;
  HomeSalesbox salesBox;
  HomeConfig config;
  HomeGridnav gridNav;

  HomeEntity(
      {this.bannerList,
      this.subNavList,
      this.localNavList,
      this.salesBox,
      this.config,
      this.gridNav});

  HomeEntity.fromJson(Map<String, dynamic> json) {
    if (json['bannerList'] != null) {
      bannerList = new List<HomeBannerlist>();
      (json['bannerList'] as List).forEach((v) {
        bannerList.add(new HomeBannerlist.fromJson(v));
      });
    }
    if (json['subNavList'] != null) {
      subNavList = new List<HomeSubnavlist>();
      (json['subNavList'] as List).forEach((v) {
        subNavList.add(new HomeSubnavlist.fromJson(v));
      });
    }
    if (json['localNavList'] != null) {
      localNavList = new List<HomeLocalnavlist>();
      (json['localNavList'] as List).forEach((v) {
        localNavList.add(new HomeLocalnavlist.fromJson(v));
      });
    }
    salesBox = json['salesBox'] != null
        ? new HomeSalesbox.fromJson(json['salesBox'])
        : null;
    config =
        json['config'] != null ? new HomeConfig.fromJson(json['config']) : null;
    gridNav = json['gridNav'] != null
        ? new HomeGridnav.fromJson(json['gridNav'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bannerList != null) {
      data['bannerList'] = this.bannerList.map((v) => v.toJson()).toList();
    }
    if (this.subNavList != null) {
      data['subNavList'] = this.subNavList.map((v) => v.toJson()).toList();
    }
    if (this.localNavList != null) {
      data['localNavList'] = this.localNavList.map((v) => v.toJson()).toList();
    }
    if (this.salesBox != null) {
      data['salesBox'] = this.salesBox.toJson();
    }
    if (this.config != null) {
      data['config'] = this.config.toJson();
    }
    if (this.gridNav != null) {
      data['gridNav'] = this.gridNav.toJson();
    }
    return data;
  }
}

class HomeBannerlist {
  String icon;
  String url;

  HomeBannerlist({this.icon, this.url});

  HomeBannerlist.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['url'] = this.url;
    return data;
  }
}

class HomeSubnavlist {
  String icon;
  String title;
  String url;
  bool hideAppBar;

  HomeSubnavlist({this.icon, this.title, this.url, this.hideAppBar});

  HomeSubnavlist.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    url = json['url'];
    hideAppBar = json['hideAppBar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['url'] = this.url;
    data['hideAppBar'] = this.hideAppBar;
    return data;
  }
}

class HomeLocalnavlist {
  String statusBarColor;
  String icon;
  String title;
  String url;
  bool hideAppBar;

  HomeLocalnavlist(
      {this.statusBarColor, this.icon, this.title, this.url, this.hideAppBar});

  HomeLocalnavlist.fromJson(Map<String, dynamic> json) {
    statusBarColor = json['statusBarColor'];
    icon = json['icon'];
    title = json['title'];
    url = json['url'];
    hideAppBar = json['hideAppBar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusBarColor'] = this.statusBarColor;
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['url'] = this.url;
    data['hideAppBar'] = this.hideAppBar;
    return data;
  }
}

class HomeSalesbox {
  HomeSalesboxBigcard2 bigCard2;
  HomeSalesboxSmallcard4 smallCard4;
  HomeSalesboxSmallcard3 smallCard3;
  HomeSalesboxBigcard1 bigCard1;
  HomeSalesboxSmallcard2 smallCard2;
  HomeSalesboxSmallcard1 smallCard1;
  String icon;
  String moreUrl;

  HomeSalesbox(
      {this.bigCard2,
      this.smallCard4,
      this.smallCard3,
      this.bigCard1,
      this.smallCard2,
      this.smallCard1,
      this.icon,
      this.moreUrl});

  HomeSalesbox.fromJson(Map<String, dynamic> json) {
    bigCard2 = json['bigCard2'] != null
        ? new HomeSalesboxBigcard2.fromJson(json['bigCard2'])
        : null;
    smallCard4 = json['smallCard4'] != null
        ? new HomeSalesboxSmallcard4.fromJson(json['smallCard4'])
        : null;
    smallCard3 = json['smallCard3'] != null
        ? new HomeSalesboxSmallcard3.fromJson(json['smallCard3'])
        : null;
    bigCard1 = json['bigCard1'] != null
        ? new HomeSalesboxBigcard1.fromJson(json['bigCard1'])
        : null;
    smallCard2 = json['smallCard2'] != null
        ? new HomeSalesboxSmallcard2.fromJson(json['smallCard2'])
        : null;
    smallCard1 = json['smallCard1'] != null
        ? new HomeSalesboxSmallcard1.fromJson(json['smallCard1'])
        : null;
    icon = json['icon'];
    moreUrl = json['moreUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bigCard2 != null) {
      data['bigCard2'] = this.bigCard2.toJson();
    }
    if (this.smallCard4 != null) {
      data['smallCard4'] = this.smallCard4.toJson();
    }
    if (this.smallCard3 != null) {
      data['smallCard3'] = this.smallCard3.toJson();
    }
    if (this.bigCard1 != null) {
      data['bigCard1'] = this.bigCard1.toJson();
    }
    if (this.smallCard2 != null) {
      data['smallCard2'] = this.smallCard2.toJson();
    }
    if (this.smallCard1 != null) {
      data['smallCard1'] = this.smallCard1.toJson();
    }
    data['icon'] = this.icon;
    data['moreUrl'] = this.moreUrl;
    return data;
  }
}

class HomeSalesboxBigcard2 {
  String icon;
  String title;
  String url;

  HomeSalesboxBigcard2({this.icon, this.title, this.url});

  HomeSalesboxBigcard2.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}

class HomeSalesboxSmallcard4 {
  String icon;
  String title;
  String url;

  HomeSalesboxSmallcard4({this.icon, this.title, this.url});

  HomeSalesboxSmallcard4.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}

class HomeSalesboxSmallcard3 {
  String icon;
  String title;
  String url;

  HomeSalesboxSmallcard3({this.icon, this.title, this.url});

  HomeSalesboxSmallcard3.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}

class HomeSalesboxBigcard1 {
  String icon;
  String title;
  String url;

  HomeSalesboxBigcard1({this.icon, this.title, this.url});

  HomeSalesboxBigcard1.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}

class HomeSalesboxSmallcard2 {
  String icon;
  String title;
  String url;

  HomeSalesboxSmallcard2({this.icon, this.title, this.url});

  HomeSalesboxSmallcard2.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}

class HomeSalesboxSmallcard1 {
  String icon;
  String title;
  String url;

  HomeSalesboxSmallcard1({this.icon, this.title, this.url});

  HomeSalesboxSmallcard1.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}

class HomeConfig {
  String searchUrl;

  HomeConfig({this.searchUrl});

  HomeConfig.fromJson(Map<String, dynamic> json) {
    searchUrl = json['searchUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchUrl'] = this.searchUrl;
    return data;
  }
}

class HomeGridnav {
  HomeGridnavItem flight;
  HomeGridnavItem hotel;
  HomeGridnavItem travel;

  HomeGridnav({this.flight, this.hotel, this.travel});

  HomeGridnav.fromJson(Map<String, dynamic> json) {
    flight = json['flight'] != null
        ? new HomeGridnavItem.fromJson(json['flight'])
        : null;
    hotel = json['hotel'] != null
        ? new HomeGridnavItem.fromJson(json['hotel'])
        : null;
    travel = json['travel'] != null
        ? new HomeGridnavItem.fromJson(json['travel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.flight != null) {
      data['flight'] = this.flight.toJson();
    }
    if (this.hotel != null) {
      data['hotel'] = this.hotel.toJson();
    }
    if (this.travel != null) {
      data['travel'] = this.travel.toJson();
    }
    return data;
  }
}

class HomeGridnavItem {
  GridItemCard item2;
  GridItemCard item1;
  String endColor;
  GridMainItem mainItem;
  GridItemCard item4;
  GridItemCard item3;
  String startColor;

  HomeGridnavItem(
      {this.item2,
      this.item1,
      this.endColor,
      this.mainItem,
      this.item4,
      this.item3,
      this.startColor});

  HomeGridnavItem.fromJson(Map<String, dynamic> json) {
    item2 =
        json['item2'] != null ? new GridItemCard.fromJson(json['item2']) : null;
    item1 =
        json['item1'] != null ? new GridItemCard.fromJson(json['item1']) : null;
    endColor = json['endColor'];
    mainItem = json['mainItem'] != null
        ? new GridMainItem.fromJson(json['mainItem'])
        : null;
    item4 =
        json['item4'] != null ? new GridItemCard.fromJson(json['item4']) : null;
    item3 =
        json['item3'] != null ? new GridItemCard.fromJson(json['item3']) : null;
    startColor = json['startColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.item2 != null) {
      data['item2'] = this.item2.toJson();
    }
    if (this.item1 != null) {
      data['item1'] = this.item1.toJson();
    }
    data['endColor'] = this.endColor;
    if (this.mainItem != null) {
      data['mainItem'] = this.mainItem.toJson();
    }
    if (this.item4 != null) {
      data['item4'] = this.item4.toJson();
    }
    if (this.item3 != null) {
      data['item3'] = this.item3.toJson();
    }
    data['startColor'] = this.startColor;
    return data;
  }
}

class GridItemCard {
  String title;
  String url;
  bool hideAppBar;
  String statusBarColor;

  GridItemCard({this.title, this.url, this.hideAppBar, this.statusBarColor});

  GridItemCard.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    hideAppBar = json['hideAppBar'];
    statusBarColor =
        json['statusBarColor'] != null ? json['statusBarColor'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['hideAppBar'] = this.hideAppBar;
    data['statusBarColor'] = this.statusBarColor;
    return data;
  }
}

class GridMainItem {
  String icon;
  String title;
  String url;
  bool hideAppBar;
  String statusBarColor;

  GridMainItem(
      {this.icon, this.title, this.url, this.hideAppBar, this.statusBarColor});

  GridMainItem.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    title = json['title'];
    url = json['url'];
    hideAppBar = json['hideAppBar'];
    statusBarColor = json['statusBarColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    data['title'] = this.title;
    data['url'] = this.url;
    data['hideAppBar'] = this.hideAppBar;
    data['statusBarColor'] = this.statusBarColor;
    return data;
  }
}
