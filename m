Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793933425;
	b=FzJDHsKC4HNaSpmiQU8jTFKXotj+RBU2kGSADtgtrvYEZUBw/tYA13Lkfjevx1coA46x
	 8ukfWAuOCn5CACSx6sRtfmIPK6gzipvmBMgkEmUlaIcLvFmwf6zdRWfOsuv+WG7CFXwjR
	 fKjpEBd5AuHdtqoKCdZocAtF5i1nIrW/xL9UHfP7W+veDQljsxgksPx/tvBlRk+Y4LjJP
	 zqDRPf9g8AQlczEnU8SD7dst2WHY0Brq4yPHK3KCe+RkhOgUigI/cPb8x4L2p8iobCu2Z
	 g1iWMIfchLjbyEPwp4WyXan5VUAcf9xCMZqOON7MOofTQY9iwQiabAL+8LkHo545lkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793933425;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=WWrBPkeC4TvVvs6w11n3c6Qn5dT9hgJIXbxG1uIC660=;
	b=CGPuj9Dl0Jz/8GrSZzSGTAiLYjxXKDzPBPtYBubgRV9AwZjqk7VGv9ah2h6Wzr8luv2S
	 MHudrd+RZJhIn8syh/0ySBLRk2fZT3HvibJJhcZm4wAdJdwpGa9c6ILIuJrVZ3On1UW4G
	 bThOwTEPO+uaEZ2qUw6FjkDLmTE5d9CgQQz5hdAcNUEVOzLGzuYZCHAmG2aikXA62LIaE
	 pTOfaHn12t3WwRnQeApz7d78s19S6MysNj038ZogkyEkxOWDzxWGympvzkqkwGLgo2556
	 eZ7GL9RUQOVeBy8CQ8GM8GyfsJOodAgOVCx4Pn3G+H/0r4lr4vO5Dps+d20vb/pOY4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=VJ0opFGf;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6B606A31B;
	Fri,  6 Nov 2026 02:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71D6B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=VJ0opFGf
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A62njXG31267802, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1793933385; bh=WWrBPkeC4TvVvs6w11n3c6Qn5dT9hgJIXbxG1uIC660=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VJ0opFGfYol8UEOicELHeNyNa5LmZcIvkPryunCBAwpKJqnS0P2wKTKB99aFuSsEi
	 TyDiD51TolTFWHb8LzUbz2GNA627q/zQLE/LqNRKTXLzTRWvztFEaqGwFr/CbykZay
	 e8Dr3vHr2fODEoFKWmMyslG0b/hNfHMUg99COjKb9T3b5aEh7HxIVkV0xOxKW3QCWk
	 kplqUQA0V4ChAodvpVlze5FDX+hLGE6Yr5VY4cWMfDVYVXQnoLC8N37lAp2ksK1IKp
	 C7qUMPWargvCrQh977PfRfWHU1vl39rzNelNbXI1dk9mRoIv++ibLH65izNdxBvwau
	 rDdO7Ql34H03w==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A62njXG31267802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Nov 2026 10:49:45 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 10:49:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 10:49:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef%10]) with mapi id
 15.02.2562.056; Fri, 6 Nov 2026 10:49:44 +0800
From: =?utf-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
To: Linus Walleij <linusw@kernel.org>, Lee Jones <lee@kernel.org>
CC: =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>,
	=?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.com>,
	=?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-realtek-soc@lists.infradead.org"
	<linux-realtek-soc@lists.infradead.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 07/10] pinctrl: realtek: Initialise omitted offset fields
 to NA in config macros
Thread-Topic: [PATCH 07/10] pinctrl: realtek: Initialise omitted offset fields
 to NA in config macros
Thread-Index: AQHda9qgbhIxCAk+mka0RzFPD9N5YrcesHKAgAGqjsA=
Date: Fri, 6 Nov 2026 02:49:43 +0000
Message-ID: <5c414196f5e34bfeb7a94714e5542a72@realtek.com>
References: <20261103213002.1673560-1-lee@kernel.org>
 <20261103213002.1673560-8-lee@kernel.org>
 <CAD++jLmF0U6ehFSuauqKDQiZRkuUnqpbZd--v2aqF2YZQF=HwA@mail.gmail.com>
In-Reply-To: <CAD++jLmF0U6ehFSuauqKDQiZRkuUnqpbZd--v2aqF2YZQF=HwA@mail.gmail.com>
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

DQo+IE9uIFR1ZSwgTm92IDMsIDIwMjYgYXQgMTA6MzHigK9QTSBMZWUgSm9uZXMgPGxlZUBrZXJu
ZWwub3JnPiB3cm90ZToNCj4gDQo+ID4gVGhlIFJlYWx0ZWsgcGluY3RybCBkcml2ZXIgdXNlcyBO
QSAoMHhmZmZmZmZmZikgYXMgdGhlIHNlbnRpbmVsIGZvcg0KPiA+IHVuc3VwcG9ydGVkIHBpbiBj
b25maWd1cmF0aW9uIGZlYXR1cmVzLiAgSG93ZXZlciwgUlRLX1BJTl9DT05GSUcgb21pdHMNCj4g
PiBpbnB1dF92b2x0X29mZnNldCwgc2xld19yYXRlX29mZnNldCwgYW5kIGh2aWxfb2Zmc2V0LCBh
bmQNCj4gPiBSVEtfUElOX0NPTkZJR19WMiBvbWl0cyBzbGV3X3JhdGVfb2Zmc2V0IGFuZCBodmls
X29mZnNldC4gIEJlY2F1c2UgQzk5DQo+ID4gZGVzaWduYXRlZCBpbml0aWFsaXNlcnMgemVyby1p
bml0aWFsaXNlIG9taXR0ZWQgbWVtYmVycywgdGhvc2UgZmllbGRzDQo+ID4gZGVmYXVsdCB0byAw
IGluc3RlYWQgb2YgTkEsIGNhdXNpbmcgcnRkX3Bjb25mX3BhcnNlX2NvbmYoKSB0byB0cmVhdA0K
PiA+IHVuc3VwcG9ydGVkIGZlYXR1cmVzIGFzIHZhbGlkIGF0IGJpdCBvZmZzZXQgYmFzZV9iaXQg
KyAwIGFuZCBjb3JydXB0DQo+ID4gYWRqYWNlbnQgcmVnaXN0ZXIgYml0cy4NCj4gPg0KPiA+IEV4
cGxpY2l0bHkgaW5pdGlhbGlzZSB0aGUgb21pdHRlZCBvZmZzZXQgZmllbGRzIHRvIE5BIGluDQo+
ID4gUlRLX1BJTl9DT05GSUcgYW5kIFJUS19QSU5fQ09ORklHX1YyLg0KPiA+DQo+ID4gRml4ZXM6
IGRjYzkzMzQ0MzViMCAoInBpbmN0cmw6IHJlYWx0ZWs6IGFkZCBzdXBwb3J0IGZvciBzbGV3IHJh
dGUsDQo+ID4gaW5wdXQgdm9sdGFnZSBhbmQgaGlnaCBWSUwiKQ0KPiA+IEZpeGVzOiBlMzA5ZGJk
NTIzYjggKCJwaW5jdHJsOiByZWFsdGVrOiBhZGQgcnRkMTYyNSBwaW5jdHJsIGRyaXZlciIpDQo+
ID4gQ2xvc2VzOg0KPiA+IGh0dHBzOi8vc2FzaGlrby5kZXYvIy9idWcvbGludXgtZmJkMGJmNTQt
NmRiYS00NjUyLTk0MTgtMjcwYjExZmI2ZDhiDQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZUBrZXJuZWwub3JnPg0KPiANCj4g
VGhpcyBwYXRjaCA3LzEwIGFwcGxpZWQgdG8gdGhlIHBpbmN0cmwgdHJlZSBmb3IgZml4ZXMuDQo+
IA0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0KDQpIaSBMaW51cywNCg0KVGhhbmtzIGZvciBh
cHBseWluZyB0aGlzIHBhdGNoLiBKdXN0IGEgcXVpY2sgaGVhZHMtdXAgb24gdGhlIG1lcmdlZCBj
b21taXQgWzFdOg0KDQoxLiBUaGUgZmlyc3QgRml4ZXMgdGFnIGtlcHQgdGhlIG9yaWdpbmFsICdk
Y2M5MzM0NDM1YjAnIGluc3RlYWQgb2YgdGhlIGNvcnJlY3RlZA0KJ2U5OWNlNzgwMzBkYicgSSBz
dWdnZXN0ZWQuDQoyLiBCcmFuY2g6IEl0IHdhcyBhcHBsaWVkIHRvICdmb3ItbmV4dCcgaW5zdGVh
ZCBvZiAnZml4ZXMnLiBKdXN0IGNoZWNraW5nIGlmDQp0aGlzIHdhcyBpbnRlbmRlZC4NCg0KWzFd
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2xpbnVzdy9s
aW51eC1waW5jdHJsLmdpdC9jb21taXQvP2g9Zm9yLW5leHQmaWQ9MGU2MmE2YWFkZWY1YmY5M2Ez
NzlhYzdhYTlhODlmNDM1OTZmODNlNA0KDQpCZXN0IHJlZ2FyZHMsDQpZdS1DaHVuDQo=
