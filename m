Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12332472B8;
	Mon, 28 Sep 2026 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598690; cv=none; b=aircaLWHbxlzOd/qMUvBfYYuhRdbME8YJs7DDkJwRjrwAMUlaO4jJepqcyGWFOXZGzV4JMqxRv9AolGY6WRb7RtgLzJtozHJ07Sn8NA4Ly5Q6jcvxmMfa7CR6VX00P8ayXLwdsW84ZOMOUar9oiruRrXqYXbVZoL8ufrYnu2Rjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598690; c=relaxed/simple;
	bh=UG5SjHlGto5qqVq/s9e1BJcnSof4gZlugHBCbCMcOmI=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=VCOKwUE+E9xK43em2lA0NK0ypyDs/ra4lsfYwgnfQ1cm+M7ZHKYbNLrwCqqoP4pp5lk78RKsg2HhwTaEQGljbN0ypnCZFCBPHNfsesL2Qlhqlt6GU1sfBxq2gL9Fm9vSGhWeaFUbfRPa/RFsvvs996Iay1VJvhUFhOYRywAwtBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=sRGG4v6C; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="sRGG4v6C"
Content-Language: ru-RU
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E398AB00A657D4F9A1CD3C297450863@prosoftsystems.ru>
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1790598686; h=from:to:date:message-id:subject;
	bh=UG5SjHlGto5qqVq/s9e1BJcnSof4gZlugHBCbCMcOmI=;
	b=sRGG4v6C2jFQS6KLIOfu77Ed/iffwoZ5f9WJqc8PFP+cGeuBgf7H6q0H4d/hu1FttSm1WQGlaWy
	NqtcAWCkgCuZjWwYJfZ+EUc8BbjtJ5AWqQiCCrDNS7TxHsGc1mFKoxc5ECnDmjYK6DyPo3eam4ztK
	zQBFiB7f995hVR2+boCBMzlC6tdAItMQIZCtPQf1+LvJ9UHe8XUpXFJ84sVe+teo/Lw/e+q7bxpfH
	+lfH6RL154mbOlbuHLbSnHOc4zeEgpr9PumeWYG84mTwDEbgDDaIFmikEvxoPdOf9MUFxyj82CeNd
	gAI83edTTLfVRgOXf+DTVdYo0TaaBCvWplRw==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Mon, 28 Sep
 2026 17:31:25 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 28 Sep 2026 17:31:17 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Mon, 28 Sep
 2026 17:31:16 +0500
From: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "benato.denis96@gmail.com" <benato.denis96@gmail.com>, "petrm@nvidia.com"
	<petrm@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"jacob.e.keller@intel.com" <jacob.e.keller@intel.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net 1/3] net: fealnx: fix teardown order in remove
Thread-Topic: [PATCH net 1/3] net: fealnx: fix teardown order in remove
Thread-Index: AQHdTBGoaPRFHxtaVUSWHKvuDP/4n7bdm8QAgAYCyQA=
Date: Mon, 28 Sep 2026 12:31:16 +0000
Message-ID: <d20c94930acc066f48abb40f82bdfadaa5ca30c2.camel@prosoftsystems.ru>
References: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
	 <95c9fa4a-79e5-47fe-9de5-2c6cd186216d@lunn.ch>
In-Reply-To: <95c9fa4a-79e5-47fe-9de5-2c6cd186216d@lunn.ch>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI2LTA5LTI0IGF0IDE4OjQzICswMjAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
PiAtLS0NCj4gPiDCoGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZlYWxueC5jIHwgMjkgKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspLCAxMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvZmVhbG54LmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZlYWxueC5jDQo+
ID4gaW5kZXggYmRjMzhhYWM1ODUwLi5kN2NkMTY0NGEzNzUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvZmVhbG54LmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9mZWFsbnguYw0KPiA+IEBAIC02NzgsMjAgKzY3OCwyMyBAQCBzdGF0aWMgaW50IGZlYWxueF9p
bml0X29uZShzdHJ1Y3QgcGNpX2Rldg0KPiA+ICpwZGV2LA0KPiA+IMKgc3RhdGljIHZvaWQgZmVh
bG54X3JlbW92ZV9vbmUoc3RydWN0IHBjaV9kZXYgKnBkZXYpDQo+ID4gwqB7DQo+ID4gwqDCoMKg
wqDCoCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+
ICvCoMKgwqDCoCBzdHJ1Y3QgbmV0ZGV2X3ByaXZhdGUgKm5wOw0KPiA+ICsNCj4gPiArwqDCoMKg
wqAgaWYgKCFkZXYpIHsNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldl9lcnIoJnBk
ZXYtPmRldiwgInJlbW92ZSBmb3IgdW5rbm93biBkZXZpY2VcbiIpOw0KPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPiA+ICvCoMKgwqDCoCB9DQo+IA0KPiBJIGtub3cgeW91
IGFyZSBqdXN0IG1vdmluZyBjb2RlIGFyb3VuZCwgYnV0IGlzIHRoYXQgcG9zc2libGU/wqAgV2Ug
dHJ5DQo+IGF2b2lkIGRlZmVuc2l2ZSBjb2RlLiBJdCBpcyBiZXR0ZXIgdG8gYWN0dWFsbHkgdW5k
ZXJzdGFuZCB0aGUgY29kZQ0KPiBhbmQgc3RvcCBiYWQgdGhpbmdzIGhhcHBlbmluZy4NCj4gDQo+
IMKgwqDCoMKgIEFuZHJldw0KPiANClRoYW5rIHlvdSBmb3IgcmV2aWV3Lg0KDQpUaGlzIGlzIGFj
dHVhbGx5IG5vdCBwb3NzaWJsZSBhcyBzdWNjZXNzZnVsIHByb2JlIGFsd2F5cyBzZXRzIHRoZSBk
ZXYNCmFuZCBpdCB3aWxsIG5ldmVyIGJlIE5VTEwuIElmIHByb2JlIHJldHVybmVkIGVhcmx5IHdp
dGggYW4gZXJyb3IsDQpyZW1vdmUgd29udCBiZSBjYWxsZWQgYXQgYWxsLg0KDQpJIHdpbGwgcmVt
b3ZlIGl0IGlmIHJlZmFjdG9yaW5nIHdpbGwgYmUgYXBwcm92ZWQgaW4gcmVzdWx0IG9mIHRoaXMN
CnRocmVhZCwgYXMgaXQgaXMgbW9yZSBjb2RlIHF1YWxpdHkgZml4LCB0aGVuIGFuIGVycm9yLg0K
