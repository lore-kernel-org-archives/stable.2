Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772701;
	b=Hlmyv/Nrw07la7BbXQv+bISqEb2ncsZycJgCd/WfuLfLFztHOB04Yr8HFjZ332vN5eki
	 ixmySRU8GaPGpCKcK0F3XnWUk2GDFvwoMTmN6bPGdG0DELfVXHT2YuKUJglLHAh8ahth/
	 qu576L6wvJLKWaBVzhV5gK60NUQmQp6V4xa2lJ0aE4/8+lvLsZzEi/YHNvhbgK1IPxY9J
	 YRLLPU4oI4qxPjtrB2CnBM6vl2u9vBifMpEd+ZeEdmQlCTLnngG6J3eWeNldhDJIt0jzf
	 A+t1S730vnRBacp9rRWOkSyX1RZQ+zFmO/zVEaYiwY+zCLNyNYYBYCtEpBfa43O480w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772701;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=W2+vG0KPIH8/bYQUlolzGe5acC3JyyLLgqwS1M/RQn4=;
	b=XUcXNkWn1QO7PDd5GgBlHC8tWSrvPQtOhNyTl4qlEE1bJ4CsRA4gXxMdHTv0Hnk1hVhf
	 etlJ4g5rtxNerof1jAMb3suhju0fbwOh+gxD1kiQN47x3bO0WSrZEM6W1TSk+Eqote4kW
	 IPiWxDZP5CT2y9Z1SPpSBUn4zGuxpajHF8pfMks8BNz66fJRWULUIUG95gGutz0Kk24P+
	 TBY6cFPRhOtXFmYk/x52ScJhPVTkD5+88yuJYNVes9yybTgCCZG+IztgVlCyOvAqEEztA
	 kIJNTV4P4EEqtDUjDC5RClxHiZxTMJ1OxioQpiRtV5PYNjReP1XVNndcd84iDb755YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=m0Ql2Bhs;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6921606A31B;
	Wed,  4 Nov 2026 06:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6921606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=m0Ql2Bhs
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A46BQKY03770829, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1793772686; bh=W2+vG0KPIH8/bYQUlolzGe5acC3JyyLLgqwS1M/RQn4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=m0Ql2BhsnzDwwls4B1Eq15/kvkhTwwutT3FeSAmm+SYqyQNIa+tvrPSRCOKc3Vga9
	 uT+fOdihro4+ZWuWvNEwmiHNEdxug2R0UHyZztB54BB0QI8Jr2UYmZErQ5Mt7b2mcO
	 pRs08leZmr8GW0KpMeuZjM2g9cnh1li9tXu2kqXLvm1iPabDvWRdOq/T/o/RVGg/Fw
	 kQtVrrVWxFQ/4ipL1/gf2w/HsEeGpJOT1hxEyifPeXSLBrpFrrcO/2gawOMa71ETCG
	 JCpAhrQNQOuxphUCoAcnHoWTC9H5+sWhW6WqYG48R5cUnER6ntS1w+lohqb1bdJQ5+
	 EMNsQ5IhtTejw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A46BQKY03770829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Nov 2026 14:11:26 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 14:11:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 14:06:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef%10]) with mapi id
 15.02.2562.056; Wed, 4 Nov 2026 14:06:24 +0800
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
Subject: RE: [PATCH 06/10] pinctrl: realtek: Fix bit shift when configuring
 RTD_HIGH_VIL
Thread-Topic: [PATCH 06/10] pinctrl: realtek: Fix bit shift when configuring
 RTD_HIGH_VIL
Thread-Index: AQHda9qcs5VNo2mdPkWfhFNS4aI0ubcdbUDg
Date: Wed, 4 Nov 2026 06:06:24 +0000
Message-ID: <e7944214d9394aaf80d64c7e394f0232@realtek.com>
References: <20261103213002.1673560-1-lee@kernel.org>
 <20261103213002.1673560-7-lee@kernel.org>
In-Reply-To: <20261103213002.1673560-7-lee@kernel.org>
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

PiBJbiBydGRfcGNvbmZfcGFyc2VfY29uZigpLCB0aGUgUlREX0hJR0hfVklMIGNhc2UgcHJlcGFy
ZXMgbWFzayBhcw0KPiBCSVQoaHZpbF9vZmYpIGZvciByZWdtYXBfdXBkYXRlX2JpdHMoKSwgYnV0
IHNldHMgdmFsID0gMSB3aXRob3V0IHNoaWZ0aW5nIGl0IHRvDQo+IGh2aWxfb2ZmLiAgV2hlbmV2
ZXIgaHZpbF9vZmYgaXMgbm9uLXplcm8sDQo+IHJlZ21hcF91cGRhdGVfYml0cygpIG1hc2tzIHZh
bCB3aXRoIEJJVChodmlsX29mZikgYW5kIGNsZWFycyB0aGUgaGlnaCBWSUwgYml0DQo+IGluc3Rl
YWQgb2Ygc2V0dGluZyBpdC4NCj4gDQo+IFNldCB2YWwgdG8gQklUKGh2aWxfb2ZmKSBzbyB0aGF0
IHRoZSB0YXJnZXQgYml0IGlzIHNldCBhcyBpbnRlbmRlZC4NCj4gDQo+IEZpeGVzOiBkY2M5MzM0
NDM1YjAgKCJwaW5jdHJsOiByZWFsdGVrOiBhZGQgc3VwcG9ydCBmb3Igc2xldyByYXRlLCBpbnB1
dCB2b2x0YWdlDQo+IGFuZCBoaWdoIFZJTCIpDQo+IENsb3NlczoNCj4gaHR0cHM6Ly9zYXNoaWtv
LmRldi8jL2J1Zy9saW51eC1lNzA3NzMxMS0zZjMwLTRiNzctODQ0Yi0xNDQ3NTE5ZDBjODQNCj4g
Q2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxs
ZWVAa2VybmVsLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IFl1LUNodW4gTGluIDxlbGVhbm9yLmxpbkBy
ZWFsdGVrLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvcGluY3RybC9yZWFsdGVrL3BpbmN0cmwt
cnRkLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvcmVhbHRlay9waW5jdHJs
LXJ0ZC5jDQo+IGIvZHJpdmVycy9waW5jdHJsL3JlYWx0ZWsvcGluY3RybC1ydGQuYw0KPiBpbmRl
eCAyYjg3NzA5OWVjODUuLjcyNzczNjAwMzAzYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waW5j
dHJsL3JlYWx0ZWsvcGluY3RybC1ydGQuYw0KPiArKysgYi9kcml2ZXJzL3BpbmN0cmwvcmVhbHRl
ay9waW5jdHJsLXJ0ZC5jDQo+IEBAIC00NzMsNyArNDczLDcgQEAgc3RhdGljIGludCBydGRfcGNv
bmZfcGFyc2VfY29uZihzdHJ1Y3QgcnRkX3BpbmN0cmwNCj4gKmRhdGEsDQo+ICAgICAgICAgICAg
ICAgICBodmlsX29mZiA9IGNvbmZpZ19kZXNjLT5iYXNlX2JpdCArDQo+IGNvbmZpZ19kZXNjLT5o
dmlsX29mZnNldDsNCj4gICAgICAgICAgICAgICAgIHJlZ19vZmYgPSBjb25maWdfZGVzYy0+cmVn
X29mZnNldDsNCj4gICAgICAgICAgICAgICAgIG1hc2sgPSBCSVQoaHZpbF9vZmYpOw0KPiAtICAg
ICAgICAgICAgICAgdmFsID0gMTsNCj4gKyAgICAgICAgICAgICAgIHZhbCA9IEJJVChodmlsX29m
Zik7DQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gDQo+ICAgICAgICAgY2FzZSBSVERfRFJJ
VkVfU1RSRU5HVEhfUDoNCj4gLS0NCj4gMi41Ni4wLjM4NS5nYWM2NzFjODE5YS1nb29nDQo=
