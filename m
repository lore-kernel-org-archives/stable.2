Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250A477980;
	Thu, 24 Sep 2026 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790246679; cv=none; b=nYjP1lUnxDuamEwu5Y087T6nr2NbqEK8Gfs6r4Emt9nAZNmDNI9sik7GhJG0S79PLethWrFfUe1CgeDr34MyZtrG0AVVM6z1AeNxtb2IOCienbfT3CRIx+EvVhRmbzklDAuvFRNZFI4asmSEStfKj/02JI2u2HPrlnthQRyQR24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790246679; c=relaxed/simple;
	bh=BukrpADQUaApA1Eb2H13QS3F9EnTYIBeoQN6r0VgOks=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=tSpmsaiB/SNncLpqJmSTLdoEdC02isKyHo5+F0z6RnQgvWsJuRWYrZoGe2UNjTQ2v81JF51Ka7raKvYzc8T3gG8LhjacSp1RQ951Cwi2DSPnA2mIIt2ojf/CTQ6iXDyZrFwiRFe7qAsv1h0CjlD7gLrPTPb3uTKfD+cgtRv0enk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=S61zMXN1; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="S61zMXN1"
Content-Language: ru-RU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1790246666; h=from:to:date:message-id:subject;
	bh=BukrpADQUaApA1Eb2H13QS3F9EnTYIBeoQN6r0VgOks=;
	b=S61zMXN1Xv5adki/hPtwXn7/YmRTuMR1RHYbwJyBiNNdyquTsVE0IDvwjJlhAcVZo9hKFvTPHVs
	tW+ko61gJABU/tEpb5136h6likl8Hu/SKghi83wjLswbDZt+R+koJN5JjUQ0yzFwC3En7sOTA4UU7
	wwYlPVF/gV4TEpSZ+3Zb46h0x7SavCv57PVXp/mlK1aoS88kFuePY2zQUzcfTytjjX4/RUFbAhcd7
	UVXX2X3zq6Q0+XzWOmfnks+e3fDNzWqItUyKnLWR0CcCxj82rmbR91ftWjGOCvt8SQH7IqamMa1NT
	1dXXLQ3ASF6nEzmoJGBhVRtCM6djzvzbzCAg==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Thu, 24 Sep
 2026 15:44:25 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Thu, 24 Sep 2026 15:44:23 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Thu, 24 Sep
 2026 15:44:23 +0500
From: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>
To: Andrew Lunn <andrew+netdev@lunn.ch>
CC: =?utf-8?B?0JbQsNC80LHQsNC60LjQtdCyINCg0LDQtNC40Lkg0KDQuNC60LDRgNC00Lg=?=
 =?utf-8?B?0L3QvtCy0LjRhw==?= <r.zhambakiev@prosoftsystems.ru>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Denis Benato
	<benato.denis96@gmail.com>, Jacob Keller <jacob.e.keller@intel.com>, "Petr
 Machata" <petrm@nvidia.com>,
	=?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?=
	<u.kleine-koenig@baylibre.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net 2/3] net: fealnx: disable the PCI device on remove and
 probe failure
Thread-Topic: [PATCH net 2/3] net: fealnx: disable the PCI device on remove
 and probe failure
Thread-Index: AQHdTBGpre9GaYvKQEulBtE3n3fMXQ==
Date: Thu, 24 Sep 2026 10:44:23 +0000
Message-ID: <20260924104231.110576-2-r.zhambakiev@prosoftsystems.ru>
References: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
In-Reply-To: <20260924104231.110576-1-r.zhambakiev@prosoftsystems.ru>
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
ZWFsbnguYyB8IDE3ICsrKysrKysrKysrLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9mZWFsbnguYyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZlYWxueC5jDQppbmRleCBkN2Nk
MTY0NGEzNzUuLjQ2YTQwZDAwYjU5YSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0
L2ZlYWxueC5jDQorKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYw0KQEAgLTQ5NCwy
MCArNDk0LDIyIEBAIHN0YXRpYyBpbnQgZmVhbG54X2luaXRfb25lKHN0cnVjdCBwY2lfZGV2ICpw
ZGV2LA0KIA0KIAlvcHRpb24gPSBjYXJkX2lkeCA8IE1BWF9VTklUUyA/IG9wdGlvbnNbY2FyZF9p
ZHhdIDogMDsNCiANCi0JaSA9IHBjaV9lbmFibGVfZGV2aWNlKHBkZXYpOw0KLQlpZiAoaSkgcmV0
dXJuIGk7DQorCWVyciA9IHBjaV9lbmFibGVfZGV2aWNlKHBkZXYpOw0KKwlpZiAoZXJyKQ0KKwkJ
cmV0dXJuIGVycjsNCiAJcGNpX3NldF9tYXN0ZXIocGRldik7DQogDQogCWxlbiA9IHBjaV9yZXNv
dXJjZV9sZW4ocGRldiwgYmFyKTsNCiAJaWYgKGxlbiA8IE1JTl9SRUdJT05fU0laRSkgew0KIAkJ
ZGV2X2VycigmcGRldi0+ZGV2LA0KIAkJCSAgICJyZWdpb24gc2l6ZSAlbGQgdG9vIHNtYWxsLCBh
Ym9ydGluZ1xuIiwgbGVuKTsNCi0JCXJldHVybiAtRU5PREVWOw0KKwkJZXJyID0gLUVOT0RFVjsN
CisJCWdvdG8gZXJyX291dF9kaXNhYmxlOw0KIAl9DQogDQotCWkgPSBwY2lfcmVxdWVzdF9yZWdp
b25zKHBkZXYsIGJvYXJkbmFtZSk7DQotCWlmIChpKQ0KLQkJcmV0dXJuIGk7DQorCWVyciA9IHBj
aV9yZXF1ZXN0X3JlZ2lvbnMocGRldiwgYm9hcmRuYW1lKTsNCisJaWYgKGVycikNCisJCWdvdG8g
ZXJyX291dF9kaXNhYmxlOw0KIA0KIAlpcnEgPSBwZGV2LT5pcnE7DQogDQpAQCAtNjcxLDYgKzY3
Myw4IEBAIHN0YXRpYyBpbnQgZmVhbG54X2luaXRfb25lKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0K
IAlwY2lfaW91bm1hcChwZGV2LCBpb2FkZHIpOw0KIGVycl9vdXRfcmVzOg0KIAlwY2lfcmVsZWFz
ZV9yZWdpb25zKHBkZXYpOw0KK2Vycl9vdXRfZGlzYWJsZToNCisJcGNpX2Rpc2FibGVfZGV2aWNl
KHBkZXYpOw0KIAlyZXR1cm4gZXJyOw0KIH0NCiANCkBAIC02OTQsNiArNjk4LDcgQEAgc3RhdGlj
IHZvaWQgZmVhbG54X3JlbW92ZV9vbmUoc3RydWN0IHBjaV9kZXYgKnBkZXYpDQogCQkJICBucC0+
cnhfcmluZ19kbWEpOw0KIAlwY2lfaW91bm1hcChwZGV2LCBucC0+bWVtKTsNCiAJcGNpX3JlbGVh
c2VfcmVnaW9ucyhwZGV2KTsNCisJcGNpX2Rpc2FibGVfZGV2aWNlKHBkZXYpOw0KIAlmcmVlX25l
dGRldihkZXYpOw0KIH0NCiANCi0tIA0KMi41My4wDQo=
