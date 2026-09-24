Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EB6224AFA;
	Thu, 24 Sep 2026 00:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210974; cv=none; b=V17ZgbQC4ZVTgmTgaGKSTHBEtVyE9FLbWaBWmSQ0fC78ToeGNFSZFFe5YyX1qvURrsAwgl3VMje5DXD02puUhodAWz/qNs4Ks+E2mgdNXAVoUvr0NLDFFx9IKZ6jHhp/dSZtpDEqgnYsodcDczBIHVTKGZU2Bbx0Fh+aimRw79c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210974; c=relaxed/simple;
	bh=0S0Q2ZnEizyjRV0nHgLWG20eI9b0fZbqwRPb55FHysk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bz53U5Z2wQEil5PPUcXas5ilKAIPfPVNY9auZyPntokZASeeeOUg6jmT+FChCSJbnS85k7zdBwXCKLei8X15QmydLheqZc+rbK/CC/u/gfuDFlIwU4NZRB9oyAZEf9SL1hTIyF8yDCy3ccYJG4df8Dyc9sMdvBnNATGPjEwfqEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Y4HfnhUG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Y4HfnhUG"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68O0nS7v9768405, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790210968; bh=0S0Q2ZnEizyjRV0nHgLWG20eI9b0fZbqwRPb55FHysk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Y4HfnhUGyTAShXVeNP8+JRUx1v+o+amN56vBFSCT5UsG4uaT+kyONQl1xnsLxaUAn
	 V24L8Jyf4MSEJMco76lqYwqDMCulolWQz8ACqsbCl1GXnp+v2LKtHJUmkzf1KDxtIy
	 AbiavPBD5u8rWm/dxFp5ZXv/qJ2qQn/M6NxVkIGrSX5Q/6Wx1VMBq/NgqPlgFPPoK4
	 kKiKGkGzgAEEza084A/f3pXJggMKGj10GNC7v3ATA3Rpsnswldn+CSWXWdPLCHu1LX
	 xQOwGwOpEPtY7Z+yoO1pCZJ4kF/vQ+xIA55kupWvoy2ZxhuOt+5Fdhe/Mlcqv3PRQp
	 N/QjqJHZdxzMg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68O0nS7v9768405
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Sep 2026 08:49:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 24 Sep 2026 08:49:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 24 Sep 2026 08:49:28 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Thu, 24 Sep 2026 08:49:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>, Josef Schlehofer
	<pepe.schlehofer@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: extend the TX report timeout to
 RTL8822BU
Thread-Topic: [PATCH rtw-next] wifi: rtw88: extend the TX report timeout to
 RTL8822BU
Thread-Index: AQHdSenJcyZ0zJutbUi+wqdx39QBULbZ2AMggAHnXICAASlsMA==
Date: Thu, 24 Sep 2026 00:49:28 +0000
Message-ID: <3d24a4e461dd4e5fbb7aaac66aad1b0b@realtek.com>
References: <20260921165343.8131-1-pepe.schlehofer@gmail.com>
 <4c000f11b23c4920b052e8513ad28345@realtek.com>
 <96f122e7-2004-43d6-917d-a07027f568a4@gmail.com>
In-Reply-To: <96f122e7-2004-43d6-917d-a07027f568a4@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgSm9zZWYsDQoNCkJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPiB3
cm90ZToNCj4gT24gMjIvMDkvMjAyNiAwNTowMywgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IEpv
c2VmIFNjaGxlaG9mZXIgPHBlcGUuc2NobGVob2ZlckBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC90eC5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC90eC5jDQo+ID4+IGluZGV4IDRlMTEwYTQ1
Ny4uNTVkNzkyM2UxIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg4L3R4LmMNCj4gPj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OC90eC5jDQo+ID4+IEBAIC0yMDgsNyArMjA4LDggQEAgdm9pZCBydHdfdHhfcmVwb3J0X2Vu
cXVldWUoc3RydWN0IHJ0d19kZXYgKnJ0d2Rldiwgc3RydWN0IHNrX2J1ZmYgKnNrYiwgdTggc24p
DQo+ID4+ICAgICAgICAgX19za2JfcXVldWVfdGFpbCgmdHhfcmVwb3J0LT5xdWV1ZSwgc2tiKTsN
Cj4gPj4gICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ0eF9yZXBvcnQtPnFfbG9jaywg
ZmxhZ3MpOw0KPiA+Pg0KPiA+PiAtICAgICAgIGlmICgocnR3ZGV2LT5jaGlwLT5pZCA9PSBSVFdf
Q0hJUF9UWVBFXzg3MjNEICYmDQo+ID4+ICsgICAgICAgaWYgKCgocnR3ZGV2LT5jaGlwLT5pZCA9
PSBSVFdfQ0hJUF9UWVBFXzg3MjNEIHx8DQo+ID4+ICsgICAgICAgICAgICAgcnR3ZGV2LT5jaGlw
LT5pZCA9PSBSVFdfQ0hJUF9UWVBFXzg4MjJCKSAmJg0KPiA+PiAgICAgICAgICAgICAgcnR3ZGV2
LT5oY2kudHlwZSA9PSBSVFdfSENJX1RZUEVfVVNCKSB8fA0KPiA+DQo+ID4gSGkgQml0dGVyYmx1
ZSwNCj4gPg0KPiA+IEl0IHNlZW1zIGxpa2UgbW9yZSBhbmQgbW9yZSBVU0IgY2hpcHMgbmVlZCB0
aGlzLCBsZXQncyBlbmxhcmdlIHRpbWVvdXQgdGltZQ0KPiA+IGZvciBhbGwgVVNCIGRldmljZXMu
IERvIHlvdSBoYXZlIGFueSBjb25jZXJuPyBOZWVkIHlvdXIgaW5wdXQuDQo+ID4NCj4gDQo+IEl0
IHNlZW1zIGZpbmUgdG8gbWUuDQo+IA0KPiA+PiAgICAgICAgICAgICBydHdfaXNfODcyM2JzKHJ0
d2RldikpDQo+ID4NCj4gPiBBbHNvLCBjb25zaWRlcmluZyBTRElPIGNoaXBzLCBzaG91bGQgd2Ug
a2VlcCBvcmlnaW5hbCB0aW1lb3V0IGZvciBQQ0kgb25seT8NCj4gPg0KPiANCj4gVGhpcyB0b28u
DQo+IA0KDQpJIHNlbnQgYSBwYXRjaCBbMV0uIFBsZWFzZSB0ZXN0IGlmIGl0IHdvcmtzIHRvIHlv
dS4gDQpJZiBzbywgSSdkIHRha2UgbXkgb25lLCBhbmQgZHJvcCB0aGlzLg0KDQpbMV0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvMjAyNjA5MjQwMDQ2MzcuOTk1OC0xLXBr
c2hpaEByZWFsdGVrLmNvbS9ULyN1DQoNCg0KDQo=
