Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF5A181334;
	Mon, 12 Oct 2026 08:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792435; cv=none; b=c/CUOY+XpcAqBlihWQxxAnfcjHUZSWsCUu9nOM4Ph7cb58mjkMQouqoQ+ps+yzKy1og8hW4cA2fO7P9tkDybtRiXO25Wt/n7D38aVpp0Wn7hEtCuLOut7vbn7JNJbbfujxkzUsb7FbptWtz0Kc0CTgU9x76L54/hhFKb4YV5FGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792435; c=relaxed/simple;
	bh=9iPVeqLUWrtKXbhMaWd18Cgu/KFeVQUiBVPojchgUrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=awMlOwGPWbY0npLU4F3YZZp+9/iyoFK33Yp43dh2vKBRLK2Nt+5bYi515HDjhpRsPa9Of+zW3CzGYKDDI3SHn055wG7F+f5uKi0V68xRj12QJfbbPIcazND8rgb8gGnsKfBotNHaqfcbMtdvdF5b8MSuYohQ/JgcgjFJm+0Jg3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=gtABGLd7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="gtABGLd7"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69C86tznE3635970, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791792415; bh=9iPVeqLUWrtKXbhMaWd18Cgu/KFeVQUiBVPojchgUrg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=gtABGLd7yaPQZ2E7hN0AtOgRHPREJKoa2MlZoXDhPff/JTLXco2+uk+h5fjmMSblA
	 o/4+PaU1wKM7yDRpcbImT6o1IfmIs18d8W5LMmimGpq9b+axKL1I/f3ijZ2MxKSSQY
	 uIO6PiVVmvT7OoH12eBm0jZQfZTx9aalI35tvaq1NXueTIF4AyB2pfVxjeZpa66rN1
	 /H+OALMRoLWCUzrDQ/WQJbF6yQuE03GWDysMVX8BlFnSM8TO/ywUI0ecE2qFSEpEDy
	 68ea5NRo1TLz3ew2vfpRmLJ+vuMRavLy9LbZDrXcSagbSuxE608a40i10x1GyBIZ+s
	 Pe84xb/4ozmxA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69C86tznE3635970
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Oct 2026 16:06:55 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 16:07:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 16:07:00 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Mon, 12 Oct 2026 16:07:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Luka Gejak <luka.gejak@linux.dev>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ulf Hansson
	<ulfh@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Kalle Valo
	<kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: sdio: reject oversized RX packets
Thread-Topic: [PATCH rtw-next] wifi: rtw88: sdio: reject oversized RX packets
Thread-Index: AQHdV+oFzdPCoTpk60GGBadLGCjSGrb5Jf/w///KD4CAAKE6IA==
Date: Mon, 12 Oct 2026 08:07:00 +0000
Message-ID: <62bf1150e0774c87b9a8281c64a6b3ed@realtek.com>
References: <20261009123022.87787-1-luka.gejak@linux.dev>
 <13bac899a2ea49d28dcbd4a8c765f3ca@realtek.com>
 <8a73778af0a82247f689236e0e7fb8387db71f75@linux.dev>
In-Reply-To: <8a73778af0a82247f689236e0e7fb8387db71f75@linux.dev>
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

THVrYSBHZWphayA8bHVrYS5nZWpha0BsaW51eC5kZXY+IHdyb3RlOg0KPiBPY3RvYmVyIDEyLCAy
MDI2IGF0IDM6NTMgQU0sICJQaW5nLUtlIFNoaWgiIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3Rl
Og0KPiANCj4gPg0KPiA+IEx1a2EgR2VqYWsgPGx1a2EuZ2VqYWtAbGludXguZGV2PiB3cm90ZToN
Cj4gPg0KPiA+ID4NCj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODgvc2Rpby5jDQo+ID4gPiAgKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OC9zZGlvLmMNCj4gPiA+ICBAQCAtMTM4OSw2ICsxMzg5LDE0IEBAIHN0YXRpYyB2b2lkIHJ0d19z
ZGlvX3J4Zmlmb19yZWN2KHN0cnVjdCBydHdfZGV2ICpydHdkZXYsIHUzMiByeF9sZW4pDQo+ID4g
PiAgY3Vycl9wa3RfbGVuID0gQUxJR04ocGt0X29mZnNldCArIHBrdF9zdGF0LnBrdF9sZW4sDQo+
ID4gPiAgUlRXX1NESU9fREFUQV9QVFJfQUxJR04pOw0KPiA+ID4NCj4gPiA+ICArIGlmICh1bmxp
a2VseShwa3Rfb2Zmc2V0ICsgcGt0X3N0YXQucGt0X2xlbiA+IHJ4X2xlbikpIHsNCj4gPiA+DQo+
ID4gQ2FuIHlvdSB1c2UgcmVhbCBoYXJkd2FyZSB0byB0ZXN0IHRoaXMgcGF0Y2ggdG8gc2VlIGlm
IHRoZXJlIGlzIGFjdHVhbCBjYXNlDQo+ID4gZmFsbGluZyBpbnRvIHRoaXMgYnJhbmNoPyAoc2Vl
IGJlbG93KQ0KPiA+DQo+IA0KPiBTdXJlLCBpdCBkb2VzIGhhcHBlbi4gSSByYW4gaXQgb24gdGhl
IDg3MjNCUyB3aXRoIGRlYnVnX21hc2s9MHg0MDAwMCBmb3IgMw0KPiBob3VycyAyNyBtaW51dGVz
LCBjeWNsaW5nIGlwZXJmMyBSWCB0cmFmZmljLCBzY2FucyBhbmQgcmVhc3NvY2lhdGlvbnMsIGFu
ZA0KPiB0aGUgbWVzc2FnZSBjYW1lIG91dCB0d2ljZS4gQm90aCB0aW1lcyB0aGUgZGVzY3JpcHRv
ciBjbGFpbWVkIG1vcmUgYnl0ZXMNCj4gdGhhbiB3ZXJlIGxlZnQgaW4gdGhhdCB0cmFuc2Zlciwg
c28gdGhpcyBpcyBub3QganVzdCBhIHRoZW9yZXRpY2FsIGJvdW5kLg0KPiBUaGUgYWdncmVnYXRl
IGdldHMgZHJvcHBlZCwgdGhlIGxpbmsgc3RheXMgdXAsIGFuZCBub3RoaW5nIGVsc2Ugc3Rvb2Qg
b3V0DQo+IGF0IHRoZSB0aW1lLg0KPiANCj4gPiA+DQo+ID4gPiArIHJ0d19kYmcocnR3ZGV2LCBS
VFdfREJHX1NESU8sDQo+ID4gPiAgKyAib3ZlcnNpemVkIFJYIHBhY2tldDogJXUsICV1IGJ5dGVz
IGxlZnRcbiIsDQo+ID4gPiAgKyBwa3Rfb2Zmc2V0ICsgcGt0X3N0YXQucGt0X2xlbiwgcnhfbGVu
KTsNCj4gPiA+ICArIGRldl9rZnJlZV9za2JfYW55KHNrYik7DQo+ID4gPiAgKyByZXR1cm47DQo+
ID4gPiAgKyB9DQo+ID4gPiAgKw0KPiA+ID4gIGlmICgoY3Vycl9wa3RfbGVuICsgcGt0X2Rlc2Nf
c3opID49IHJ4X2xlbikgew0KPiA+ID4NCj4gPiBCZWNhdXNlIEkgd29uZGVyIGlmIHRoaXMgY29u
ZGl0aW9uIGlzIHJpZ2h0PyBJbiBteSBwZXJzcGVjdGl2ZSwgdGhlDQo+ID4gY3Vycl9wa3RfbGVu
ID0gcGt0X29mZnNldCArIHBrdF9zdGF0LnBrdF9sZW4gKyBhbGlnbl9ieXRlcw0KPiA+ICA9IHBr
dF9kZXNjX3N6ICsgLi4uICsgcGt0X3N0YXQucGt0X2xlbiArIGFsaWduX2J5dGVzDQo+ID4NCj4g
PiBXaHkgZG9lcyB0aGUgaWYtY29uZGl0aW9uIHBsdXMgcGt0X2Rlc2Nfc3ogdHdpY2UgYW5kIGNv
bXBhcmUgd2l0aCByeF9sZW4/DQo+ID4NCj4gDQo+IHBrdF9kZXNjX3N6IHR1cm5zIHVwIHR3aWNl
IGJlY2F1c2UgdHdvIGRlc2NyaXB0b3JzIGFyZSBpbnZvbHZlZC4gVGhlIG9uZQ0KPiBpbnNpZGUg
cGt0X29mZnNldCBiZWxvbmdzIHRvIHRoaXMgZW50cnk6DQo+IA0KPiAgICAgICAgIHBrdF9vZmZz
ZXQgPSBwa3RfZGVzY19zeiArIHBrdF9zdGF0LmRydl9pbmZvX3N6ICsgcGt0X3N0YXQuc2hpZnQ7
DQo+ICAgICAgICAgY3Vycl9wa3RfbGVuID0gQUxJR04ocGt0X29mZnNldCArIHBrdF9zdGF0LnBr
dF9sZW4sDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUlRXX1NESU9fREFUQV9QVFJf
QUxJR04pOw0KPiANCj4gcnhfbGVuIGlzIHdoYXQgaXMgbGVmdCBvZiB0aGUgdHJhbnNmZXIgZnJv
bSB0aGlzIGRlc2NyaXB0b3Igb24sIHNpbmNlIHRoZQ0KPiBsb29wIHN1YnRyYWN0cyBjdXJyX3Br
dF9sZW4gZnJvbSBpdCBlYWNoIHRpbWUgcm91bmQuIFRoZSBzZWNvbmQgcGt0X2Rlc2Nfc3oNCj4g
aXMgdGhlIGhlYWRlciBvZiB0aGUgZW50cnkgYWZ0ZXIgdGhpcyBvbmUsIHNvDQo+IA0KPiAgICAg
ICAgIChjdXJyX3BrdF9sZW4gKyBwa3RfZGVzY19zeikgPj0gcnhfbGVuDQo+IA0KPiBtZWFucyB0
aGVyZSBpcyBubyByb29tIGxlZnQgZm9yIGFub3RoZXIgZGVzY3JpcHRvci4gVGhhdCBtYWtlcyB0
aGlzIHRoZSBsYXN0DQo+IGVudHJ5LCBhbmQgdGhlIG9yaWdpbmFsIHNrYiBjYW4gZ28gdXAgaW5z
dGVhZCBvZiBhIGNvcHkgc28gdGhlIHN0YWNrIGZyZWVzDQo+IGl0LiBXaXRob3V0IHRoYXQgdGVy
bSwgd2hlbmV2ZXIgbGVzcyB0aGFuIHBrdF9kZXNjX3N6IGlzIGxlZnQgYmVoaW5kIHRoaXMNCj4g
ZW50cnksIHRoZSBsb29wIHdvdWxkIGNvbWUgcm91bmQgb25jZSBtb3JlIGFuZCByZWFkIGEgZGVz
Y3JpcHRvciBvdXQgb2YNCj4gcGFkZGluZy4gY3Vycl9wa3RfbGVuIGlzIHJvdW5kZWQgdXAgdG8g
OCwgc28gaXQgc3RvcHMgdXAgdG8gNyBieXRlcyBlYXJseSwNCj4gd2hpY2ggb25seSBkZWNpZGVz
IHdoZXRoZXIgdGhlIGxhc3QgcGFja2V0IGlzIGNvcGllZCBvciBub3QuDQo+IA0KPiA+IEhvd2V2
ZXIsIGl0IHNob3VsZCBlbnRlciB0byBoYW5kbGUvZnJlZSB0aGUgbGFzdCBhZ2dyZWdhdGVkIHBh
Y2tldC4NCj4gPiBDYW4geW91IGVubGlnaHRlbiBtZSBob3cgaXQgbG9va3MgbGlrZSB0aGF0Pw0K
PiA+DQo+IA0KPiBGb3IgYSBzYW5lIGFnZ3JlZ2F0ZSB0aGF0IGlzIGV4YWN0bHkgd2hhdCBoYXBw
ZW5zLiBNeSBjaGVjayByZWFjdHMgdG8gdGhlDQo+IG90aGVyIGNhc2U6IHRoZSBkZXNjcmlwdG9y
IGNsYWltcyBtb3JlIGJ5dGVzIHRoYW4gd2VyZSByZWFkLCBzbyBjdXJyX3BrdF9sZW4NCj4gaXMg
YWxyZWFkeSBwYXN0IHJ4X2xlbiBhbmQgdGhpcyBzYW1lIGJyYW5jaCBoYW5kcyB0aGUgZW50cnkg
dG8NCj4gcnR3X3NkaW9fcnhfc2tiKCkgd2l0aCBhIHBrdF9sZW4gdGhlIHRyYW5zZmVyIGRvZXMg
bm90IGhhdmUuIEkgd291bGQgcmF0aGVyDQo+IGRyb3AgdGhhdCBlbnRyeSBhbmQgdGhlIHJlc3Qg
b2YgdGhlIHRyYW5zZmVyIHRoYW4gcGFzcyBpdCB1cCwgYW5kIGFmdGVyIGENCj4gZGVzY3JpcHRv
ciBsaWtlIHRoYXQgdGhlIG9mZnNldCBvZiB0aGUgbmV4dCBvbmUgY2Fubm90IGJlIHRydXN0ZWQg
YW55d2F5Lg0KDQpUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLiANCg0KQWNrZWQtYnk6IFBp
bmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg0KDQo=
