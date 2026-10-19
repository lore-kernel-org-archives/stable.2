Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C614A4FD7A6;
	Mon, 19 Oct 2026 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.48.77.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417390; cv=none; b=Rme/QPoFfkynbHVq3duqs8WSBgnVKQ/JaStPat4gAD/BvQEVCsNG7BRJnnIXEBlwTeEG+LUySlXidlNJ+rfXBOYOQdSsj+HyyP2eHpuKaybvmq49GdFEfeihUa/5M0pOOaJf0GuKXtfa4WtDKMfvakZ7HFR0qHWr4fceQ4VfeJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417390; c=relaxed/simple;
	bh=w2I6dUNX+lVC5tw05EezKVTbmi0AzEe6g6msg8ES0lw=;
	h=Content-Type:From:To:CC:Subject:Date:Message-ID:References:
	 In-Reply-To:MIME-Version; b=f2uYyoPsC/t7aEWRXOAUkJkThEf0dclUHEo8BfW6SFW0SvEW1aSXyEdtnV57x2ZGZ1Ate+ZtIxt/mtbQQz5O81lf1iMAJdLuBvrmuIwNMSj9ThYE+KIupfT7e5obm2hxTlbAyLBzjfVkMT7DaPFtonOTE9S+B9HJZ5SS+3zn6o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru; spf=pass smtp.mailfrom=prosoftsystems.ru; dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b=OVPg26GI; arc=none smtp.client-ip=46.48.77.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.b="OVPg26GI"
Content-Language: ru-RU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1792417393; h=from:to:date:message-id:subject;
	bh=w2I6dUNX+lVC5tw05EezKVTbmi0AzEe6g6msg8ES0lw=;
	b=OVPg26GIUBfKzK1bxQh1ClLgXLEFSWkLw/KWJHu+DZJsTEIMZz5U8e9t7G3eDAlrjf1nCP5osrB
	MZomLmMMiZs1o9HECstmlDtBvu1Bd0sqZJSz5t0Wce9uL6JosDjAlSf9in7iDAKMgWfBFJk3Y1uqo
	S88JE3K1yxRGdhGV19ne+YJJLbbOeK4K4ptCxjdZV9c7QkQGiPIN/Oo0DqGBxOHel/CvEXTm7lQA+
	7e61TeakJgoNRkvoFbv/nuJ+tJtBFWAjgVe2erOTj3HMrJqLYm6gf97o4Z3TBJG7tGvMFqkD0JkYR
	rz3C4mGFvbC4vA+0AdTJexaua4n0PdqiGCKw==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Mon, 19 Oct
 2026 18:43:12 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 19 Oct 2026 18:43:03 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::c1a2:90f7:8820:c669%17]) with mapi id 15.02.1748.039; Mon, 19 Oct
 2026 18:43:03 +0500
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
Subject: [PATCH net v3 3/3] net: fealnx: bound card_idx to prevent
 out-of-bounds access
Thread-Topic: [PATCH net v3 3/3] net: fealnx: bound card_idx to prevent
 out-of-bounds access
Thread-Index: AQHdX8/D1qEnsPavCki1JbM1cebLZA==
Date: Mon, 19 Oct 2026 13:43:03 +0000
Message-ID: <20261019134136.104932-4-r.zhambakiev@prosoftsystems.ru>
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
DQpjYXJkX2lkeCBpcyBhIHN0YXRpYyBjb3VudGVyIHRoYXQgaXMgaW5jcmVtZW50ZWQgb24gZXZl
cnkNCnByb2JlLiBJdCBjYW4gb3ZlcmZsb3cgYW5kIHdyYXAgdG8gYSBuZWdhdGl2ZSB2YWx1ZSwg
d2hpY2gNCnRoZW4gaW5kZXhlcyBvcHRpb25zW10gYW5kIGZ1bGxfZHVwbGV4W10gb3V0IG9mIGJv
dW5kcy4NCkxhcmdlIHZhbHVlcyBhbHNvIG5vIGxvbmdlciBmaXQgaW4gdGhlIDEyLWJ5dGUgYm9h
cmRuYW1lW10NCmJ1ZmZlci4NCg0KQm91bmQgY2FyZF9pZHggdG8gOTk5OTksIHRoZSBsYXJnZXN0
IHZhbHVlIHRoYXQgc3RpbGwgZml0cw0KaW50byBib2FyZG5hbWUsIGFuZCBmYWlsIHRoZSBwcm9i
ZSBmb3IgYW55IGNhcmQgYmV5b25kIHRoYXQuDQoNCmZlYWxueCBpcyBhbiBvbGQgZHJpdmVyIHRo
YXQgY2Fubm90IGJlIHRlc3RlZCBwcm9wZXJseSBvbg0KcmVhbCBoYXJkd2FyZSwgc28gYSBtaW5p
bWFsIGJlc3QtZWZmb3J0IGd1YXJkIHdhcyBjaG9zZW4NCm92ZXIgYSBsYXJnZXIgcmV3b3JrLg0K
DQpGb3VuZCBieSBMaW51eCBWZXJpZmljYXRpb24gQ2VudGVyIChsaW51eHRlc3Rpbmcub3JnKQ0K
DQpGaXhlczogMWRhMTc3ZTRjM2Y0ICgiTGludXgtMi42LjEyLXJjMiIpDQpDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KU2lnbmVkLW9mZi1ieTogUmFkaXkgWmhhbWJha2lldiA8ci56aGFtYmFr
aWV2QHByb3NvZnRzeXN0ZW1zLnJ1Pg0KLS0tDQogZHJpdmVycy9uZXQvZXRoZXJuZXQvZmVhbG54
LmMgfCA1ICsrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZmVhbG54LmMgYi9kcml2ZXJzL25ldC9ldGhlcm5l
dC9mZWFsbnguYw0KaW5kZXggYjVlOTZjNzAzN2YzLi5kNTkzMWMwMzE0ZmMgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL25ldC9ldGhlcm5ldC9mZWFsbnguYw0KKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvZmVhbG54LmMNCkBAIC00MSw2ICs0MSw3IEBAIHN0YXRpYyBpbnQgcnhfY29weWJyZWFrOw0K
IC8qIGludGVyb3BlcmFiaWxpdHkuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAqLw0KIC8qIFRoZSBtZWRpYSB0eXBlIGlzIHVzdWFsbHkgcGFzc2VkIGluICdvcHRp
b25zW10nLiAgICAgICAgICAgICAqLw0KICNkZWZpbmUgTUFYX1VOSVRTIDgJCS8qIE1vcmUgYXJl
IHN1cHBvcnRlZCwgbGltaXQgb25seSBvbiBvcHRpb25zICovDQorI2RlZmluZSBNQVhfQ0FSRF9J
RFgJCTk5OTk5DQogc3RhdGljIGludCBvcHRpb25zW01BWF9VTklUU10gPSB7IC0xLCAtMSwgLTEs
IC0xLCAtMSwgLTEsIC0xLCAtMSB9Ow0KIHN0YXRpYyBpbnQgZnVsbF9kdXBsZXhbTUFYX1VOSVRT
XSA9IHsgLTEsIC0xLCAtMSwgLTEsIC0xLCAtMSwgLTEsIC0xIH07DQogDQpAQCAtNDg5LDYgKzQ5
MCwxMCBAQCBzdGF0aWMgaW50IGZlYWxueF9pbml0X29uZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwN
CiAJaW50IGJhciA9IDE7DQogI2VuZGlmDQogDQorCWlmIChjYXJkX2lkeCA+PSBNQVhfQ0FSRF9J
RFgpIHsNCisJCWRldl9lcnIoJnBkZXYtPmRldiwgImNhcmRfaWR4IGlzIHRvbyBiaWcgJWQsIGFi
b3J0aW5nIiwgY2FyZF9pZHgpOw0KKwkJcmV0dXJuIC1FTk9ERVY7DQorCX0NCiAJY2FyZF9pZHgr
KzsNCiAJc3ByaW50Zihib2FyZG5hbWUsICJmZWFsbnglZCIsIGNhcmRfaWR4KTsNCiANCi0tIA0K
Mi41My4wDQo=
