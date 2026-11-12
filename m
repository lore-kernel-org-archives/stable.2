Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473744;
	b=0xp5G/VOkuJJStbEAkiZYh6GQpkK3XDEzBhzAVUmBt6970FQmzoP5JGjYuimKjO1gzPR
	 UnB5CLocnpTN43/Eb1pYrhN4Pei2u0rAwX0YLLadNy6FQq6A9IcdpRe5Qp0NioFgoCroW
	 VfMGvzF2xZMxmw3rfW7HmoUMKzQ0Fcjy7enhYcq6/YzemGYmvbz32/A1NHfBN4vGJdHLF
	 mn3gJMG4Xiuqq+F3ORePZziFyQffXlY+6qxdj51YItmR0hr3iMdDV2mU0vHTF/cUA1CUO
	 mrVJAm10TwZZWsijg7gq2/xdYHm33eFD6FdrlV1PmPB5SXCMvX9DGser69lvbHXax+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473744;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=UG0eDg3wLsv9fEG3MiLxAJphk4oh699w/v03YlmGOME=;
	b=pLgDHRzuw2fbOlhjM1T/7q8ZEIY8o5zDb0Y0GBI0D4OMIdvTrgSF5ff97gWtiKqxQYSX
	 pH0D0crMim2MQB8Br8YPssontZDwIGc6v3hjNZxWg+PYX1QK5OzKevyMA26e/S9KMdiym
	 cHsn5opoU0zktaav+0NlkSrlAYkgFeFkH+cHC2fk92lQsXTtMNzgdFchSPDcA0BeT7o7d
	 Zv38zmgH1OO5FNmyl5cC+yznj6aWJzctIfuUeELLTuScrC4G5LZnP0W98KfkPhQ/qnVrM
	 OTnjXUu4Ke+2xt3GA1AyYHcBUErH+rJjXCltda76d0r1eRA5Zo9yGuwITRIfdzB5qKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=H5nlpqq2;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99B8606A335;
	Thu, 12 Nov 2026 08:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B99B8606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=H5nlpqq2
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AC8t2Ap93637595, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794473702; bh=UG0eDg3wLsv9fEG3MiLxAJphk4oh699w/v03YlmGOME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=H5nlpqq200PLAkn7SijgKjpdgEQn/L1iZH9asBt6nIOSaJ7DODWQ7pV8LFSpItLoh
	 0c+HWi3LexxguDy4uif7J1vL33a56jB+lr4F4FPw1QSq2JOtg5wdPGQ8kAAjdw2Mes
	 SA9iiw43a0WyPiklDDeSCfc/lNhNQJyqSRF6HFsznMsK8MD6/fGzttONSo7taeDzLP
	 yldIvN4KSP3of13U5fl7S6rYf4FW1BfUVpLCZYbj6EYukWXhweBkrCrSXyseFQR97u
	 7wZySlaontRH1dH6KLJAo9gKWiEi2EzRAKTnhDu8LWYIGxIAeSeEEhr2yRcZ3gdPg3
	 ujkrh+jfN2iwA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AC8t2Ap93637595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 12 Nov 2026 16:55:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 16:55:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef%10]) with mapi id
 15.02.2562.056; Thu, 12 Nov 2026 16:55:02 +0800
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
Subject: RE: [PATCH 10/10] pinctrl: realtek: rtd1625: Set dcycle_offset to NA
 for pins without duty-cycle support
Thread-Topic: [PATCH 10/10] pinctrl: realtek: rtd1625: Set dcycle_offset to NA
 for pins without duty-cycle support
Thread-Index: AQHdcic4ZX2/nMTP5UCESGNFFYBSnLcqIf/A
Date: Thu, 12 Nov 2026 08:55:02 +0000
Message-ID: <0138c369918d4d69a3d34cb7934656f6@realtek.com>
References: <20261111215256.1982044-1-lee@kernel.org>
 <20261111215256.1982044-11-lee@kernel.org>
In-Reply-To: <20261111215256.1982044-11-lee@kernel.org>
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

ID4gSW4gcnRkMTYyNV9tYWluMl9zY29uZmlnc1tdLCBwaW5zIGdwaW9fODYgdGhyb3VnaCBncGlv
XzkxIGRvIG5vdCBzdXBwb3J0DQo+IGNsb2NrIGR1dHktY3ljbGUgYWRqdXN0bWVudCAoZGN5Y2xl
X21hc2tiaXRzIGlzIDApLCBidXQgc3BlY2lmeSAwIGluc3RlYWQgb2YgTkENCj4gZm9yIGRjeWNs
ZV9vZmZzZXQuICBCZWNhdXNlIHJ0ZF9wY29uZl9wYXJzZV9jb25mKCkgdGVzdHMNCj4gc2NvbmZp
Z19kZXNjLT5kY3ljbGVfb2Zmc2V0ID09IE5BIHRvIGRldGVybWluZSB3aGV0aGVyIGR1dHktY3lj
bGUNCj4gY29uZmlndXJhdGlvbiBpcyBzdXBwb3J0ZWQsIGFuIG9mZnNldCBvZiAwIGNhdXNlcyBp
dCB0byBjb21wdXRlDQo+IEdFTk1BU0soMCAtIDEsIDApIGFuZCBjb3JydXB0IHRoZSBwYWQgY29u
dHJvbCByZWdpc3Rlci4NCj4gDQo+IFNldCBkY3ljbGVfb2Zmc2V0IHRvIE5BIGZvciBncGlvXzg2
IHRocm91Z2ggZ3Bpb185MS4NCj4gDQo+IEZpeGVzOiBlMzA5ZGJkNTIzYjggKCJwaW5jdHJsOiBy
ZWFsdGVrOiBhZGQgcnRkMTYyNSBwaW5jdHJsIGRyaXZlciIpDQo+IENsb3NlczoNCj4gaHR0cHM6
Ly9zYXNoaWtvLmRldi8jL2J1Zy9saW51eC04YThmNjkwZi0xNWU3LTRkYmQtYTNhMi04N2JjMDBl
ZGY3YjkNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogTGVl
IEpvbmVzIDxsZWVAa2VybmVsLm9yZz4NCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2ghDQoNClJldmll
d2VkLWJ5OiBZdS1DaHVuIExpbiA8ZWxlYW5vci5saW5AcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+
ICBkcml2ZXJzL3BpbmN0cmwvcmVhbHRlay9waW5jdHJsLXJ0ZDE2MjUuYyB8IDEyICsrKysrKy0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvcmVhbHRlay9waW5jdHJsLXJ0ZDE2
MjUuYw0KPiBiL2RyaXZlcnMvcGluY3RybC9yZWFsdGVrL3BpbmN0cmwtcnRkMTYyNS5jDQo+IGlu
ZGV4IDg4ZjJiZTM3Zjc0My4uZjZlMDM4ZTRiYmRkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Bp
bmN0cmwvcmVhbHRlay9waW5jdHJsLXJ0ZDE2MjUuYw0KPiArKysgYi9kcml2ZXJzL3BpbmN0cmwv
cmVhbHRlay9waW5jdHJsLXJ0ZDE2MjUuYw0KPiBAQCAtMjk5MywxMiArMjk5MywxMiBAQCBzdGF0
aWMgY29uc3Qgc3RydWN0IHJ0ZF9waW5fc2NvbmZpZ19kZXNjDQo+IHJ0ZDE2MjVfbWFpbjJfc2Nv
bmZpZ3NbXSA9IHsNCj4gICAgICAgICBSVEtfUElOX1NDT05GSUcoZ3Bpb182NSwgMHgzNCwgMTYs
IDMsIDE5LCAzLCAyMiwgMyksDQo+ICAgICAgICAgUlRLX1BJTl9TQ09ORklHKGdwaW9fNjYsIDB4
MzgsIDMsIDMsIDYsIDMsIDksIDMpLA0KPiAgICAgICAgIFJUS19QSU5fU0NPTkZJRyhncGlvXzY3
LCAweDM4LCAxNiwgMywgMTksIDMsIDIyLCAzKSwNCj4gLSAgICAgICBSVEtfUElOX1NDT05GSUco
Z3Bpb184NiwgMHgzYywgMCwgMCwgMTQsIDQsIDE4LCA0KSwNCj4gLSAgICAgICBSVEtfUElOX1ND
T05GSUcoZ3Bpb184NywgMHgzYywgMCwgMCwgMjQsIDQsIDI4LCA0KSwNCj4gLSAgICAgICBSVEtf
UElOX1NDT05GSUcoZ3Bpb184OCwgMHg0MCwgMCwgMCwgMiwgNCwgNiwgNCksDQo+IC0gICAgICAg
UlRLX1BJTl9TQ09ORklHKGdwaW9fODksIDB4NDAsIDAsIDAsIDEyLCA0LCAxNiwgNCksDQo+IC0g
ICAgICAgUlRLX1BJTl9TQ09ORklHKGdwaW9fOTAsIDB4NDAsIDAsIDAsIDIyLCA0LCAyNiwgNCks
DQo+IC0gICAgICAgUlRLX1BJTl9TQ09ORklHKGdwaW9fOTEsIDB4NDQsIDAsIDAsIDIsIDQsIDYs
IDQpLA0KPiArICAgICAgIFJUS19QSU5fU0NPTkZJRyhncGlvXzg2LCAweDNjLCBOQSwgMCwgMTQs
IDQsIDE4LCA0KSwNCj4gKyAgICAgICBSVEtfUElOX1NDT05GSUcoZ3Bpb184NywgMHgzYywgTkEs
IDAsIDI0LCA0LCAyOCwgNCksDQo+ICsgICAgICAgUlRLX1BJTl9TQ09ORklHKGdwaW9fODgsIDB4
NDAsIE5BLCAwLCAyLCA0LCA2LCA0KSwNCj4gKyAgICAgICBSVEtfUElOX1NDT05GSUcoZ3Bpb184
OSwgMHg0MCwgTkEsIDAsIDEyLCA0LCAxNiwgNCksDQo+ICsgICAgICAgUlRLX1BJTl9TQ09ORklH
KGdwaW9fOTAsIDB4NDAsIE5BLCAwLCAyMiwgNCwgMjYsIDQpLA0KPiArICAgICAgIFJUS19QSU5f
U0NPTkZJRyhncGlvXzkxLCAweDQ0LCBOQSwgMCwgMiwgNCwgNiwgNCksDQo+ICAgICAgICAgUlRL
X1BJTl9TQ09ORklHKGhpZl9jbGssIDB4NDQsIDEzLCAzLCAxNiwgMywgMTksIDMpLA0KPiAgICAg
ICAgIFJUS19QSU5fU0NPTkZJRyhoaWZfZGF0YSwgMHg0OCwgMywgMywgNiwgMywgOSwgMyksDQo+
ICAgICAgICAgUlRLX1BJTl9TQ09ORklHKGhpZl9lbiwgMHg0OCwgMTYsIDMsIDE5LCAzLCAyMiwg
MyksDQo+IC0tDQo+IDIuNTYuMC41NjcuZ2RiODBhZThjZDUtZ29vZw0KDQo=
