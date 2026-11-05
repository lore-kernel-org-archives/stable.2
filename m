Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793859250;
	b=NMwb5s8sjx054ODpWs27NmuDxiSnmidiR4y/Z/zKoaZ4QGNSNkXgfv5Y/Oqg1YmquP1+
	 BnYE4EM5QoeP8XwEvlOATyuNnWrEiV3AzNkV7HM5u9wFyHb+S/b4+vW1mcOLbGBgoWfg/
	 +In3FGhEQEY3LuWL9/8G4TbAGcnHjJvaYP06Rdb2m06iN/Odw7Fs8Y6D2FITDyF8t4cMO
	 UBc7HuCdimFWuf29NuJuDL/tuVR/yO4P3uyYAcyJpLa7mOAJgsbb1tZHSePQMUC5NEmr9
	 s0gPcSle1I4UhrOsvrSccW0ly8tmtsd5mPkIJ3z5Pco5bfjVEFgNmFW7TTp6hmIKUHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793859250;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=xRNZ0pQNv0O4AgQe25xHeQd1/afXwgVq8ve3/6zEzsA=;
	b=XM2+YDVPAd+FwozHG42aWajjuLd2siiVjsrtih5KzizydhDNF/vZJiFWpWiTIgeKvGRP
	 l/AJrnuEoSekXppzOCbcftR2XflnRFauONaGoC4e4fnipC5XD00Jx3NqQHMVglFPsj1a7
	 mIfpEMxHf4VVL81DuuQ7x4C8baefvVzUt891BFF4ePirmKBv5d+LTDVyLEP/vgd0dTC01
	 diM88BfnlJw49RgyFZI1aXmvZ1OrbDwj4poggoQI9unaEanWqYI5fX/2zomXlcaJbUS0i
	 pT6xL3DEcmRN8s/8RDrF8XQC/l34Y7+BsdV3skoHqwIuiMvIkKTJQeSr6BHDxSWxxOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b="FOEcAI/t";
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33FB606A32C;
	Thu,  5 Nov 2026 06:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E33FB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=FOEcAI/t
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A56ChI12526563, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1793859163; bh=xRNZ0pQNv0O4AgQe25xHeQd1/afXwgVq8ve3/6zEzsA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=FOEcAI/tlG14NSSEwve85seR3xewsDtvND5Tbu7t2sj6uLzFwbA4W4kF28DyknAWP
	 qOzVbt/tpWg3/4PtPnvAupa1KbJDE6RgzF0FmkhpQmcwKzoGJksXkQxU5C8dBUYLGu
	 iOkLuZzk8BrCT0qbW6QBYxRGnTXBZlaCYZT6cx4xu2Ovaq+xBcdPV9XBNPO6kDaeFs
	 x9Lx/TtH7e8MinXDUDqQowZbba9ilrkJvglLUi+ziPIZW8tGeRajg/1IMHEqi37ISa
	 kZKW7FzlbF/xDcnvupnoGo8mQWsV1YeM+8vYrLxM4n9Q4nlTdsJeSVCeDp3yTlFf/p
	 LNyoDBZ5XIqIA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A56ChI12526563
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Nov 2026 14:12:43 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 14:12:43 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([fe80::d2b4:cd25:1a3e:aca8]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::d2b4:cd25:1a3e:aca8%9]) with mapi id
 15.02.2562.056; Thu, 5 Nov 2026 14:12:43 +0800
From: =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To: Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Vinod Koul
	<vkoul@kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>
CC: Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam
	<mani@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] phy: realtek: usb: fix the USB 2.0 PHY's port range check
Thread-Topic: [PATCH] phy: realtek: usb: fix the USB 2.0 PHY's port range
 check
Thread-Index: AQHdbGd3K0WzKIaqJEurOjghSm2EKrce/gDA
Date: Thu, 5 Nov 2026 06:12:43 +0000
Message-ID: <0cd63684f1ab4704848f317a96a4105b@realtek.com>
References: <202611041419.6A4EJBeM41365932@rtits1.realtek.com.tw>
In-Reply-To: <202611041419.6A4EJBeM41365932@rtits1.realtek.com.tw>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="big5"
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

SGkgSm9zaHVhLA0KDQoNCj4gDQo+IHJ0a19waHlfdG9nZ2xlKCkgY2hlY2tzIHRoZSBwb3J0IG51
bWJlciBiZWZvcmUgdXNpbmcgaXQgdG8gaW5kZXggdGhlDQo+IHBoeV9wYXJhbWV0ZXIgYXJyYXks
IHdoaWNoIGhhcyBudW1fcGh5IGVudHJpZXMuIFBvcnRzIGFyZSBudW1iZXJlZCBmcm9tDQo+IHpl
cm8sIHNvIHRoZSBjaGVjayBzaG91bGQgcmVqZWN0IHBvcnQgPT0gbnVtX3BoeSwgYnV0IGl0IG9u
bHkgcmVqZWN0cyBwb3J0cw0KPiBncmVhdGVyIHRoYW4gbnVtX3BoeS4gRml4IHRoZSBvZmYtYnkt
b25lLg0KPiANCj4gRm91bmQgYnkgY29kZSBpbnNwZWN0aW9uLg0KPiANCj4gRml4ZXM6IGVlZGE0
OTQ1NDJlNSAoInBoeTogcmVhbHRlazogdXNiOiBhZGQgbmV3IGRyaXZlciBmb3IgdGhlIFJlYWx0
ZWsgUlREDQo+IFNvQyBVU0IgMi4wIFBIWSIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
DQo+IFNpZ25lZC1vZmYtYnk6IEpvc2h1YSBTY290dCA8am9zaHVhLnNjb3R0QGFsbGllZHRlbGVz
aXMuY28ubno+DQo+IC0tLQ0KPiBQcmVwYXJlZCB3aXRoIHRoZSBoZWxwIG9mIENsYXVkZSBDb2Rl
IChjbGF1ZGUtb3B1cy01LTUpLCB3aGljaCBkcmFmdGVkIHRoZQ0KPiBjaGFuZ2UgYW5kIGNoYW5n
ZWxvZy4gSSByZXZpZXdlZCBpdCBhbmQgdGVzdGVkIGl0IG9uIGFuIFJUTDkzMTFCIGJvYXJkLA0K
PiB3aGVyZSBVU0IgZGV2aWNlcyBzdGlsbCBjb25uZWN0IGFuZCBkaXNjb25uZWN0IG5vcm1hbGx5
Lg0KPiANCj4gIGRyaXZlcnMvcGh5L3JlYWx0ZWsvcGh5LXJ0ay11c2IyLmMgfCAyICstDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BoeS9yZWFsdGVrL3BoeS1ydGstdXNiMi5jDQo+IGIvZHJpdmVycy9w
aHkvcmVhbHRlay9waHktcnRrLXVzYjIuYw0KPiBpbmRleCAxZjA4YjE1MWQ5MGEuLmU0M2FkNWZh
NmQ2NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waHkvcmVhbHRlay9waHktcnRrLXVzYjIuYw0K
PiArKysgYi9kcml2ZXJzL3BoeS9yZWFsdGVrL3BoeS1ydGstdXNiMi5jDQo+IEBAIC02NzAsNyAr
NjcwLDcgQEAgc3RhdGljIHZvaWQgcnRrX3BoeV90b2dnbGUoc3RydWN0IHJ0a19waHkgKnJ0a19w
aHksDQo+IGJvb2wgY29ubmVjdCwgaW50IHBvcnQpICB7DQo+ICAgICAgICAgaW50IGluZGV4ID0g
cG9ydDsNCj4gDQo+IC0gICAgICAgaWYgKGluZGV4ID4gcnRrX3BoeS0+bnVtX3BoeSkgew0KPiAr
ICAgICAgIGlmIChpbmRleCA+PSBydGtfcGh5LT5udW1fcGh5KSB7DQo+ICAgICAgICAgICAgICAg
ICBkZXZfZXJyKHJ0a19waHktPmRldiwgIiVzOiBUaGUgcG9ydD0lZCBpcyBub3QgaW4gdXNiIHBo
eQ0KPiAobnVtX3BoeT0lZClcbiIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19f
LCBpbmRleCwgcnRrX3BoeS0+bnVtX3BoeSk7DQo+ICAgICAgICAgICAgICAgICByZXR1cm47DQoN
ClJldmlld2VkLWJ5OiBTdGFubGV5IENoYW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0K
DQoNClRoYW5rcywNClN0YW5sZXkNCg==
