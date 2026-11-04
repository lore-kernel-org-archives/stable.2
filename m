Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772503;
	b=xyBUKguu1vl5tGom8+UPeucdfywHBIqRbwb5U/I5ZrvbutRzpxbbB6OoK21BhFek3464
	 ahfBH3yQjfBABqpQa7FByWYZHesKbA5P5FeOzkZdQjspitHqhmfdbIcoprtVZ4bNu93A2
	 wjeToTzCpVAqIJ6+e9YXqvKtUdAfDWL2anYYYsb8JjzGEfQuKWifhAGMx2P+dgKBQkIse
	 oHLKwPJAI+gcN7svOVJiK2M+vaEPObBJMRqJD90QIO/4Ke23LYWW7caJoNxt5kx/Vw1yK
	 PbY2OQ222BU88oJYL6t+XgMXE6dOgZ/5U6aP2R5lARrnM9m9UFwAU7JuucPKUk7UHCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772503;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=zDtggkZku8PgJt9OARmJv04xDfsbkkp5F4eyRrnZB7M=;
	b=431ySKIPsE9cluhsu2eRJC748jgMrogG9l7fsYYn0qbPPqUd0/vsPSj1txRvrWrRL0K5
	 aAbC98peJBVvZWvT5VMn4fhoJ+NKMswqbdeAvnIMx24fncMBOGbvxQl6F2bcN8i4LgiVQ
	 bepAB95K5sqRjak0sISF+6lq4c0rkrqHhxFRdNob+kLswVu6TBOEsKfJtVoxV8VnoedBf
	 PKBr1CRidX3riiqGgYtP5BX3iyGJk7Q382Cr9B8SXnmsWZUH9NDYGj1MSw3jp43llHjRo
	 oTzDzBYiT4lj4YZLzHga4YxtuNfhGkPdU/nbNN4UPTwKxFqTnX8hDlDhkhcMO33+5Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=Se7ovEnL;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C238606A31B;
	Wed,  4 Nov 2026 06:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C238606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=Se7ovEnL
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A467Y0v83769780, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1793772454; bh=zDtggkZku8PgJt9OARmJv04xDfsbkkp5F4eyRrnZB7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Se7ovEnLOecaDyUD3iXqu4ZiBrA1AiwbzBm+EZo5g9xGEyoLWuCcIUOTo0P4sq6p7
	 gjGM2pXhIORx7aYofDar/wrMGPF9uVK0KmpngnO9ayrLIPEP1Jg1eNCqXsRgJ8VXoc
	 E0PVLVwYRfFPoYbVBkGei3WhXm8oUpIbh0x5uX51v8EGegBxa5me5xAv/tsj1D/+fi
	 LdY6JI0aH0ezpi1MjXWC7UPZBDXseXanP5j45uO0xtZF7HFfoyV6w/ULFsOX0q9cOe
	 nhuk0G1tsDrdx6kUSOzyRbtpwQz1AyR7gsXkq8/MMuSFo4KaSvm7PbXeqHODyKokKd
	 83pxoFmwjP2Lg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A467Y0v83769780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Nov 2026 14:07:34 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 14:07:34 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 14:07:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef%10]) with mapi id
 15.02.2562.056; Wed, 4 Nov 2026 14:07:33 +0800
From: =?utf-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
To: Lee Jones <lee@kernel.org>, =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?=
	<james.tai@realtek.com>, =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?=
	<afaerber@suse.com>, Linus Walleij <linusw@kernel.org>,
	=?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-realtek-soc@lists.infradead.org"
	<linux-realtek-soc@lists.infradead.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 07/10] pinctrl: realtek: Initialise omitted offset fields
 to NA in config macros
Thread-Topic: [PATCH 07/10] pinctrl: realtek: Initialise omitted offset fields
 to NA in config macros
Thread-Index: AQHda9qgbhIxCAk+mka0RzFPD9N5YrcdbaGA
Date: Wed, 4 Nov 2026 06:07:33 +0000
Message-ID: <c48f0d12ee764bf3bd04b57db9a8b9cb@realtek.com>
References: <20261103213002.1673560-1-lee@kernel.org>
 <20261103213002.1673560-8-lee@kernel.org>
In-Reply-To: <20261103213002.1673560-8-lee@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

PiBUaGUgUmVhbHRlayBwaW5jdHJsIGRyaXZlciB1c2VzIE5BICgweGZmZmZmZmZmKSBhcyB0aGUg
c2VudGluZWwgZm9yIHVuc3VwcG9ydGVkDQo+IHBpbiBjb25maWd1cmF0aW9uIGZlYXR1cmVzLiAg
SG93ZXZlciwgUlRLX1BJTl9DT05GSUcgb21pdHMNCj4gaW5wdXRfdm9sdF9vZmZzZXQsIHNsZXdf
cmF0ZV9vZmZzZXQsIGFuZCBodmlsX29mZnNldCwgYW5kDQo+IFJUS19QSU5fQ09ORklHX1YyIG9t
aXRzIHNsZXdfcmF0ZV9vZmZzZXQgYW5kIGh2aWxfb2Zmc2V0LiAgQmVjYXVzZSBDOTkNCj4gZGVz
aWduYXRlZCBpbml0aWFsaXNlcnMgemVyby1pbml0aWFsaXNlIG9taXR0ZWQgbWVtYmVycywgdGhv
c2UgZmllbGRzIGRlZmF1bHQgdG8gMA0KPiBpbnN0ZWFkIG9mIE5BLCBjYXVzaW5nIHJ0ZF9wY29u
Zl9wYXJzZV9jb25mKCkgdG8gdHJlYXQgdW5zdXBwb3J0ZWQgZmVhdHVyZXMgYXMNCj4gdmFsaWQg
YXQgYml0IG9mZnNldCBiYXNlX2JpdCArIDAgYW5kIGNvcnJ1cHQgYWRqYWNlbnQgcmVnaXN0ZXIg
Yml0cy4NCj4gDQo+IEV4cGxpY2l0bHkgaW5pdGlhbGlzZSB0aGUgb21pdHRlZCBvZmZzZXQgZmll
bGRzIHRvIE5BIGluIFJUS19QSU5fQ09ORklHIGFuZA0KPiBSVEtfUElOX0NPTkZJR19WMi4NCj4g
DQo+IEZpeGVzOiBkY2M5MzM0NDM1YjAgKCJwaW5jdHJsOiByZWFsdGVrOiBhZGQgc3VwcG9ydCBm
b3Igc2xldyByYXRlLCBpbnB1dCB2b2x0YWdlDQo+IGFuZCBoaWdoIFZJTCIpDQoNClRoaXMgc2hv
dWxkIGJlOg0KRml4ZXM6IGU5OWNlNzgwMzBkYiAoInBpbmN0cmw6IHJlYWx0ZWs6IEFkZCBjb21t
b24gcGluY3RybCBkcml2ZXIgZm9yIFJlYWx0ZWsNCkRIQyBSVEQgU29DcyIpDQoNCj4gRml4ZXM6
IGUzMDlkYmQ1MjNiOCAoInBpbmN0cmw6IHJlYWx0ZWs6IGFkZCBydGQxNjI1IHBpbmN0cmwgZHJp
dmVyIikNCj4gQ2xvc2VzOg0KPiBodHRwczovL3Nhc2hpa28uZGV2LyMvYnVnL2xpbnV4LWZiZDBi
ZjU0LTZkYmEtNDY1Mi05NDE4LTI3MGIxMWZiNmQ4Yg0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZUBrZXJuZWwub3JnPg0KDQpPdGhl
cndpc2UsIGxvb2tzIGdvb2QgdG8gbWUuDQoNClRoYW5rcyBmb3IgdGhlIGZpeGVzLg0KDQpSZXZp
ZXdlZC1ieTogWXUtQ2h1biBMaW4gPGVsZWFub3IubGluQHJlYWx0ZWsuY29tPg0KDQo+IC0tLQ0K
PiAgZHJpdmVycy9waW5jdHJsL3JlYWx0ZWsvcGluY3RybC1ydGQuaCB8IDUgKysrKysNCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BpbmN0cmwvcmVhbHRlay9waW5jdHJsLXJ0ZC5oDQo+IGIvZHJpdmVycy9waW5jdHJsL3JlYWx0
ZWsvcGluY3RybC1ydGQuaA0KPiBpbmRleCA3N2MzMGVhNzY0NDMuLjg2ZGI1NGVhM2NlOCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9waW5jdHJsL3JlYWx0ZWsvcGluY3RybC1ydGQuaA0KPiArKysg
Yi9kcml2ZXJzL3BpbmN0cmwvcmVhbHRlay9waW5jdHJsLXJ0ZC5oDQo+IEBAIC05Niw2ICs5Niw5
IEBAIHN0cnVjdCBydGRfcGluX3JlZ19saXN0IHsNCj4gICAgICAgICAgICAgICAgIC5zbXRfb2Zm
c2V0ID0gX3NtdF9vZmYsIFwNCj4gICAgICAgICAgICAgICAgIC5wb3dlcl9vZmZzZXQgPSBfcG93
X29mZiwgXA0KPiAgICAgICAgICAgICAgICAgLmN1cnJfdHlwZSA9IF9jdXJyX3R5cGUsIFwNCj4g
KyAgICAgICAgICAgICAgIC5pbnB1dF92b2x0X29mZnNldCA9IE5BLCBcDQo+ICsgICAgICAgICAg
ICAgICAuc2xld19yYXRlX29mZnNldCA9IE5BLCBcDQo+ICsgICAgICAgICAgICAgICAuaHZpbF9v
ZmZzZXQgPSBOQSwgXA0KPiAgICAgICAgIH0NCj4gDQo+ICAjZGVmaW5lIFJUS19QSU5fQ09ORklH
X1YyKF9uYW1lLCBfcmVnX29mZiwgX2Jhc2VfYml0LCBfcHVkX2VuX29mZiwgXA0KPiBAQCAtMTEy
LDYgKzExNSw4IEBAIHN0cnVjdCBydGRfcGluX3JlZ19saXN0IHsNCj4gICAgICAgICAgICAgICAg
IC5wb3dlcl9vZmZzZXQgPSBfcG93X29mZiwgXA0KPiAgICAgICAgICAgICAgICAgLmlucHV0X3Zv
bHRfb2Zmc2V0ID0gX2lucHV0X3ZvbHRfb2ZmLCBcDQo+ICAgICAgICAgICAgICAgICAuY3Vycl90
eXBlID0gX2N1cnJfdHlwZSwgXA0KPiArICAgICAgICAgICAgICAgLnNsZXdfcmF0ZV9vZmZzZXQg
PSBOQSwgXA0KPiArICAgICAgICAgICAgICAgLmh2aWxfb2Zmc2V0ID0gTkEsIFwNCj4gICAgICAg
ICB9DQo+IA0KPiAgI2RlZmluZSBSVEtfUElOX0NPTkZJR19JMkMoX25hbWUsIF9yZWdfb2ZmLCBf
YmFzZV9iaXQsIF9wdWRfZW5fb2ZmLCBcDQo+IC0tDQo+IDIuNTYuMC4zODUuZ2FjNjcxYzgxOWEt
Z29vZw0K
