Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A837310784;
	Mon, 19 Oct 2026 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417384; cv=none; b=Iqmqp2QpzhQKd2EdmZHzigSc/1Aid0PQusYRKGmKZDsYI76wsj9EcfzM/70pfBWYkNxhz908d62FeQ6DIdACc/Utn3+9fU2ZuxkXYD94WYodYwNj9hw8u/aTHzx9koSWT3TJiDKYAfaj6YX3ncEdU3cLRcrJ5I7ebQyCtWu3IZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417384; c=relaxed/simple;
	bh=VNtzJDvWk9TWK5tZkjVJ3nvsh+w988A6KI/bCREUbRA=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=MR1L0gfUSRX2dEwaHTwBxZB/+b4pdxU5S2GdYWFO8+xo3v6gN1WMtDhwmKB5Q0emLJv4YzBtRRXLtPE41m9F2eolxScwXwHFAYgsfPFw5g0Qu3Ic7UzSzFpCIouiOVtXJJweo9vw8uK7KuLnhD2Tnx4b79ZS9ldDe8LqhxE34+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=f4btETO4; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="f4btETO4"
Content-Language: ru-RU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1792417386; h=from:to:date:message-id:subject;
	bh=VNtzJDvWk9TWK5tZkjVJ3nvsh+w988A6KI/bCREUbRA=;
	b=f4btETO48u4Gjho95HDZ4g0RThU2xtWzUoVDtvE5X/a4uWgW4SWHg7aBQqde2QjA6CY08Z0/Rwz
	9jGRw25IXUHytt6UCohxKZAYDW8QGwOfrEdoYcbnoYJoNx+s+nxcqW+WLY2oBVG9tQasLNiO9USyE
	AkEcP0JDolaNLbLmVDgx1z/9HSAVUn7Nw9eDjj+9XKrZLDqVnmgmy3nnf+5KjmPrtmqaIOtKlabqm
	Iz6J6O1yt8ubCiSTUHbnN2EmI0BU/cmnYGoKsMbbRuXGaePuGMALhptec/5E88+VTSkJpFKtEApX6
	lKOW3XBNiaYlFVCja40BbE45dSKugz3mRWeg==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Mon, 19 Oct
 2026 18:43:06 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 19 Oct 2026 18:42:57 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Mon, 19 Oct
 2026 18:42:57 +0500
From: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
To: Andrew Lunn <andrew+netdev@lunn.ch>
CC: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michael
 Grzeschik" <mgr@kernel.org>, Jijie Shao <shaojijie@huawei.com>, "Aleksandr
 Loktionov" <aleksandr.loktionov@intel.com>, Denis Benato
	<benato.denis96@gmail.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
	<u.kleine-koenig@baylibre.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net v3 2/3] net: fealnx: disable the PCI device on remove and
 probe failure
Thread-Topic: [PATCH net v3 2/3] net: fealnx: disable the PCI device on remove
 and probe failure
Thread-Index: AQHdX8+/WqB39ft660+Q6+ZkrMTf1g==
Date: Mon, 19 Oct 2026 13:42:57 +0000
Message-ID: <20261019134136.104932-3-r.zhambakiev@prosoftsystems.ru>
References: <20261019134136.104932-1-r.zhambakiev@prosoftsystems.ru>
In-Reply-To: <20261019134136.104932-1-r.zhambakiev@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

RnJvbTogUmFkaXkgWmhhbWJha2lldiA8ci56aGFtYmFraWV2QHByb3NvZnRzeXN0ZW1zLnJ1Pg0K
DQpwY2lfZW5hYmxlX2RldmljZSgpIGlzIGNhbGxlZCBpbiBwcm9iZSwgYnV0IHRoZSBkZXZpY2Ug
aXMgbmV2ZXINCmRpc2FibGVkIG9uIHByb2JlIGZhaWx1cmUgb3IgcmVtb3ZlLiBEZXZpY2UgcmVt
YWlucyBlbmFibGVkIGFuZA0KYnVzIG1hc3RlcmluZyBzdGF5cyBhY3RpdmUuDQoNCkFkZCBwY2lf
ZGlzYWJsZV9kZXZpY2UoKSB0byB0aGUgcHJvYmUgZXJyb3IgdW53aW5kIGFuZCB0bw0KZmVhbG54
X3JlbW92ZV9vbmUoKSwgYWZ0ZXIgYWxsIG90aGVyIHJlc291cmNlcyBoYXZlIGJlZW4gcmVsZWFz
ZWQuDQoNCkZvdW5kIGJ5IExpbnV4IFZlcmlmaWNhdGlvbiBDZW50ZXIgKGxpbnV4dGVzdGluZy5v
cmcpDQoNCkZpeGVzOiAxZGExNzdlNGMzZjQgKCJMaW51eC0yLjYuMTItcmMyIikNCkNjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnDQpTaWduZWQtb2ZmLWJ5OiBSYWRpeSBaaGFtYmFraWV2IDxyLnpo
YW1iYWtpZXZAcHJvc29mdHN5c3RlbXMucnU+DQotLS0NCiBkcml2ZXJzL25ldC9ldGhlcm5ldC9m
ZWFsbnguYyB8IDEyICsrKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9m
ZWFsbnguYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZlYWxueC5jDQppbmRleCA2ODE5NGM5ZWYz
MzIuLmI1ZTk2YzcwMzdmMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZlYWxu
eC5jDQorKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYw0KQEAgLTUwMiwxMiArNTAy
LDEzIEBAIHN0YXRpYyBpbnQgZmVhbG54X2luaXRfb25lKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0K
IAlpZiAobGVuIDwgTUlOX1JFR0lPTl9TSVpFKSB7DQogCQlkZXZfZXJyKCZwZGV2LT5kZXYsDQog
CQkJICAgInJlZ2lvbiBzaXplICVsZCB0b28gc21hbGwsIGFib3J0aW5nXG4iLCBsZW4pOw0KLQkJ
cmV0dXJuIC1FTk9ERVY7DQorCQllcnIgPSAtRU5PREVWOw0KKwkJZ290byBlcnJfb3V0X2Rpc2Fi
bGU7DQogCX0NCiANCi0JaSA9IHBjaV9yZXF1ZXN0X3JlZ2lvbnMocGRldiwgYm9hcmRuYW1lKTsN
Ci0JaWYgKGkpDQotCQlyZXR1cm4gaTsNCisJZXJyID0gcGNpX3JlcXVlc3RfcmVnaW9ucyhwZGV2
LCBib2FyZG5hbWUpOw0KKwlpZiAoZXJyKQ0KKwkJZ290byBlcnJfb3V0X2Rpc2FibGU7DQogDQog
CWlycSA9IHBkZXYtPmlycTsNCiANCkBAIC02NzEsNiArNjcyLDggQEAgc3RhdGljIGludCBmZWFs
bnhfaW5pdF9vbmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsDQogCXBjaV9pb3VubWFwKHBkZXYsIGlv
YWRkcik7DQogZXJyX291dF9yZXM6DQogCXBjaV9yZWxlYXNlX3JlZ2lvbnMocGRldik7DQorZXJy
X291dF9kaXNhYmxlOg0KKwlwY2lfZGlzYWJsZV9kZXZpY2UocGRldik7DQogCXJldHVybiBlcnI7
DQogfQ0KIA0KQEAgLTY5MCw2ICs2OTMsNyBAQCBzdGF0aWMgdm9pZCBmZWFsbnhfcmVtb3ZlX29u
ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikNCiAJCXBjaV9pb3VubWFwKHBkZXYsIG5wLT5tZW0pOw0K
IAkJZnJlZV9uZXRkZXYoZGV2KTsNCiAJCXBjaV9yZWxlYXNlX3JlZ2lvbnMocGRldik7DQorCQlw
Y2lfZGlzYWJsZV9kZXZpY2UocGRldik7DQogCX0gZWxzZQ0KIAkJcHJpbnRrKEtFUk5fRVJSICJm
ZWFsbng6IHJlbW92ZSBmb3IgdW5rbm93biBkZXZpY2VcbiIpOw0KIH0NCi0tIA0KMi41My4wDQo=
