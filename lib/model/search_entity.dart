class SearchEntity {
	SearchHead head;
	List<SearchData> data;
	String keyword;

	SearchEntity({this.head, this.data});

	SearchEntity.fromJson(Map<String, dynamic> json) {
		head = json['head'] != null ? new SearchHead.fromJson(json['head']) : null;
		if (json['data'] != null) {
			data = new List<SearchData>();(json['data'] as List).forEach((v) { data.add(new SearchData.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.head != null) {
      data['head'] = this.head.toJson();
    }
		if (this.data != null) {
      data['data'] =  this.data.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SearchHead {
	int errcode;
	dynamic auth;

	SearchHead({this.errcode, this.auth});

	SearchHead.fromJson(Map<String, dynamic> json) {
		errcode = json['errcode'];
		auth = json['auth'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['errcode'] = this.errcode;
		data['auth'] = this.auth;
		return data;
	}
}

class SearchData {
	String star;
	String districtname;
	String price;
	String type;
	String word;
	String zonename;
	String url;

	SearchData({this.star, this.districtname, this.price, this.type, this.word, this.zonename, this.url});

	SearchData.fromJson(Map<String, dynamic> json) {
		star = json['star'];
		districtname = json['districtname'];
		price = json['price'];
		type = json['type'];
		word = json['word'];
		zonename = json['zonename'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['star'] = this.star;
		data['districtname'] = this.districtname;
		data['price'] = this.price;
		data['type'] = this.type;
		data['word'] = this.word;
		data['zonename'] = this.zonename;
		data['url'] = this.url;
		return data;
	}
}
