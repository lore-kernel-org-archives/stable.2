Received: from bjy-spam.kuaishou.com (bjy-spam.kuaishou.com [162.219.34.252])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD7D3F5BE5;
	Fri, 24 Jul 2026 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.219.34.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784893247; cv=none; b=QdKxIIGoT4GOXf/8C7tOWzICUekhQOiCAAowigWXvCbZqqL6cz5teUf+Bnq/LdvCc17GD14K9bt1sO5mTyhDGdpxMCy4m+7GIh5kgx6J1yZAoQCu/0KO5vaiR66YXcZkWBngaYRr1eSzfHE2nn2OvbQT+Isi274QbXZloFvfmVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784893247; c=relaxed/simple;
	bh=jeWutDJGohW7+SSBhts5Gq1bVhTx1OxmWUd8QfvRlug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BDiiudOxpYJLNwsI1UWu0uG+HwKz6rwp88oMA2Qp3kA2/v+ByWvxRPA4f08OfPSOf/ka7CK+6MSVICxR08Serq8drdUswiaF1Xh3Nlr8OKDYrCtiWc0yR/ee8xaoMUN50Qq0XuR1C/JQ6wJ0ZwNgb5i5MZRcRtBhYwWbOZZ0NXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com; spf=pass smtp.mailfrom=kuaishou.com; dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b=SdFugssZ; arc=none smtp.client-ip=162.219.34.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b="SdFugssZ"
Received: from xm-spam02.kuaishou.com (unknown [172.28.128.162])
	by bjy-spam.kuaishou.com (Postfix) with ESMTP id 96FBA5C753;
	Fri, 24 Jul 2026 19:40:38 +0800 (CST)
Received: from bjm7-pm-mail09.kuaishou.com (unknown [172.28.1.91])
	by xm-spam02.kuaishou.com (Postfix) with ESMTPS id 4h65dt3Kx1zB3yy2;
	Fri, 24 Jul 2026 19:40:34 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
	t=1784893234; h=from:subject:to:date:message-id;
	bh=jeWutDJGohW7+SSBhts5Gq1bVhTx1OxmWUd8QfvRlug=;
	b=SdFugssZCfDwC5ul7dV5iX8QeObb+L1kV+tQLpsRN9+Lc7eyvSu4ZMMy4km7Vv/LUSZJAOH8ci0
	QFoTNIGmnaIpcCzZs/UAFecqhaffx4BlWkOpy0+nd5bnw4XvrC5B+PgMPVv2RNGv+lgZdhQd7YGfp
	NSHzmb3c3bMe5QXnFdw=
Received: from bjm7-pm-mail11.kuaishou.com (172.28.1.93) by
 bjm7-pm-mail09.kuaishou.com (172.28.1.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 24 Jul 2026 19:40:34 +0800
Received: from bjm7-pm-mail11.kuaishou.com ([fe80::ec41:ec1f:4b29:4543]) by
 bjm7-pm-mail11.kuaishou.com ([fe80::ec41:ec1f:4b29:4543%15]) with mapi id
 15.02.1118.020; Fri, 24 Jul 2026 19:40:28 +0800
From: =?utf-8?B?5pyx5LiA6bij?= <zhuyiming@kuaishou.com>
To: "xiubli@redhat.com" <xiubli@redhat.com>, "idryomov@gmail.com"
	<idryomov@gmail.com>, "amarkuze@redhat.com" <amarkuze@redhat.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "jlayton@kernel.org"
	<jlayton@kernel.org>
Subject: Re: [PATCH] ceph: fix mds random selection readiness predicate
Thread-Topic: [PATCH] ceph: fix mds random selection readiness predicate
Thread-Index: AQHdG1oZnuQ5ElazK0qzhOIKzASQErZ8BZWA
Date: Fri, 24 Jul 2026 11:40:28 +0000
Message-ID: <F5EF2BE9-F97C-4E06-806C-E0EB694F162A@kuaishou.com>
References: <20260724104920.6493-1-zhuyiming@kuaishou.com>
In-Reply-To: <20260724104920.6493-1-zhuyiming@kuaishou.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3E3BBB9C6EF7C4FB2D2E2690046CBDD@kuaishou.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

QWRkaW5nIHRoZSBjdXJyZW50IENlcGggY2xpZW50IG1haW50YWluZXIgbGlzdA0KDQo+IE9uIEp1
bCAyNCwgMjAyNiwgYXQgMTg6NDksIOacseS4gOm4oyA8emh1eWltaW5nQGt1YWlzaG91LmNvbT4g
d3JvdGU6DQo+IA0KPiBDRVBIX01EU19JU19SRUFEWSgpIGlzIHBhcnNlZCBzbyB0aGF0IHRoZSB0
ZXJuYXJ5IGV4cHJlc3Npb24gY2FuDQo+IHJldHVybiB0cnVlIGZvciBhbiBNRFMgZW50cnkgd2l0
aCBzdGF0ZSAwIHdoZW4gaXQgaXMgbm90IGxhZ2d5LiBUaGlzDQo+IGFsbG93cyB0aGUgcmFuZG9t
IHNlbGVjdG9yIHRvIGNob29zZSBhIGRvd24vRE5FIHJhbmsuDQo+IA0KPiBHcm91cCB0aGUgdGVy
bmFyeSBleHByZXNzaW9uIHVuZGVyIHRoZSBzdGF0ZSBjaGVjayBzbyB6ZXJvLXN0YXRlIHJhbmtz
DQo+IGFyZSBub3QgdHJlYXRlZCBhcyByZWFkeS4NCj4gDQo+IEZpeGVzOiBiMzhjOWViNDc1N2Qg
KCJjZXBoOiBhbGxvdyBjaG9vc2UgcmFuZG9tIG1kcyIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJu
ZWwub3JnDQo+IExpbms6IGh0dHBzOi8vdHJhY2tlci5jZXBoLmNvbS9pc3N1ZXMvNzg2NDgNCj4g
U2lnbmVkLW9mZi1ieTogWWltaW5nIFpodSA8emh1eWltaW5nQGt1YWlzaG91LmNvbT4NCj4gLS0t
DQo+IGZzL2NlcGgvbWRzbWFwLmMgfCAyICstDQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvbWRzbWFwLmMg
Yi9mcy9jZXBoL21kc21hcC5jDQo+IGluZGV4IGQ4ZTQ2ZWI3ZTVlYi4uNDUwYTRkYzk2NjJlIDEw
MDY0NA0KPiAtLS0gYS9mcy9jZXBoL21kc21hcC5jDQo+ICsrKyBiL2ZzL2NlcGgvbWRzbWFwLmMN
Cj4gQEAgLTE1LDcgKzE1LDcgQEANCj4gI2luY2x1ZGUgInN1cGVyLmgiDQo+IA0KPiAjZGVmaW5l
IENFUEhfTURTX0lTX1JFQURZKGksIGlnbm9yZV9sYWdneSkgXA0KPiAtCShtLT5tX2luZm9baV0u
c3RhdGUgPiAwICYmIGlnbm9yZV9sYWdneSA/IHRydWUgOiAhbS0+bV9pbmZvW2ldLmxhZ2d5KQ0K
PiArCShtLT5tX2luZm9baV0uc3RhdGUgPiAwICYmIChpZ25vcmVfbGFnZ3kgPyB0cnVlIDogIW0t
Pm1faW5mb1tpXS5sYWdneSkpDQo+IA0KPiBzdGF0aWMgaW50IF9fbWRzbWFwX2dldF9yYW5kb21f
bWRzKHN0cnVjdCBjZXBoX21kc21hcCAqbSwgYm9vbCBpZ25vcmVfbGFnZ3kpDQo+IHsNCj4gDQo+
IGJhc2UtY29tbWl0OiA0OGE1YTdhYjhkNmFiNzA5MDU2NDMzOWUwMzljNDIxZjMxNWRlOTEyDQo+
IC0tIA0KPiAyLjU1LjANCj4gDQoNCg==
