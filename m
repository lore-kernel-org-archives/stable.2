Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5FF4E5328;
	Tue, 29 Sep 2026 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673668; cv=none; b=gKgk84YLWime3Ix57trLIwPTMhRtTs8l6rzQeSoJR4ZAxoirDBQRA1BNGznkfCkxSo3neVFRSyUPTP5OkaMU27anFqehYCcS39LJ1wG07EUL/+G9x14bnvlgI/eQc+4ovlGLCaOUo7HIlCvD4ZFvS3qd4JwWMbZiGUyRqy8X3Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673668; c=relaxed/simple;
	bh=b5RKstOGIf/or6l/f3eSS1EznFXUEIvtecv1dNeO1xg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qgWWmjqK/NlFikGhPpfP+Kjo2dJ0POqASYBpT8utGVN2h16gsipv8By5hcleCR2M+1Shiz/r900FmjYxS7JEfnMjnEzQNZsSiEdtwJb0i+ELrLJTV4bLv3TdnCTfppQiZeMBVmMsrc572wdCyyxR8kildNakamUIHPLIynY0NIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FgWxQo5p; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FgWxQo5p"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68T9KKliC1171700, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790673620; bh=b5RKstOGIf/or6l/f3eSS1EznFXUEIvtecv1dNeO1xg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=FgWxQo5pdtbXLC2yrwhtetn50fVraXZP6ILohYx6GXEcrjNCflByEqjOGvhKfSeZU
	 aagGmC5G8JhojOC5zHrrW9O2VAf6qPbiqq+HCrno0HeL7FZtVVixGunrYaz4rZ7rUH
	 yTw6URc8Eu6Zv0yibt+lyqwPb4l90/osNhtNtrcXgoG5FC/vyI3IFNJrFJZfBHHMxn
	 xUhsSqSRgJz51IHu4H6gNygstN9+jdeA5Ke5geTGdXAARIw/6l4Z4MKLPOueQO2u59
	 6/fAfcIYcEJKjbuf+ZSKYoyndEPeNEHliK5RPUiazGM+Fu491KS4B7xLtUQtCRuX7V
	 luN6fbqBCDpEw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68T9KKliC1171700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 17:20:20 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 29 Sep 2026 17:20:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 29 Sep 2026 17:20:20 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Tue, 29 Sep 2026 17:20:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alastair D'Silva <alastair@d-silva.org>, Kalle Valo <kvalo@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: sdio: Fix unhandled RX request interrupt
 storm
Thread-Topic: [PATCH] wifi: rtw88: sdio: Fix unhandled RX request interrupt
 storm
Thread-Index: AQHdRZjHlTD58hEpHEaBWkK5Af0sf7bSYOjAgAAXxcD//43kgIAGUHjw///r0ICAAZBuQIAKqkoAgADb4/A=
Date: Tue, 29 Sep 2026 09:20:20 +0000
Message-ID: <a90352f8a1e74c538b605ac4eed64675@realtek.com>
References: <20260916040635.205094-1-alastair@d-silva.org>
			 <ea3434d849b34a4286b0a193351a610e@realtek.com>
			 <58a857e3b0614e2b9a520024b9932685@realtek.com>
		 <919109e886399f09db41ef5800e7335440ed4971.camel@d-silva.org>
		 <5ff354336f4748b9bb45621dd899156a@realtek.com>
	 <4662c1bbc73df10449a3925161979c130d94492b.camel@d-silva.org>
	 <7f1ad86870184bfe826dd96a3b031d69@realtek.com>
 <242775cb0b45938c0138ae256073bbd9088c02c2.camel@d-silva.org>
In-Reply-To: <242775cb0b45938c0138ae256073bbd9088c02c2.camel@d-silva.org>
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

QWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+IHdyb3RlOg0KPiBJbnN0ZWFk
IG9mIG92ZXJoYXVsaW5nIHRoZSBkcml2ZXIgZm9yIE5BUEksIHRoaXMgcmFjZSBjb25kaXRpb24g
Y2FuIGJlIHNvbHZlZA0KPiBjbGVhbmx5IGFuZCByb2J1c3RseSB1c2luZyB0aGUgSU1SIG1hc2tp
bmcgc3VnZ2VzdGlvbiBmcm9tIHlvdXIgaW50ZXJuYWwgdGVhbToNCj4gSW4gcnR3X3NkaW9faGFu
ZGxlX2ludGVycnVwdCgpOg0KPiAgICAgaGlzciA9IHJ0d19yZWFkMzIocnR3ZGV2LCBSRUdfU0RJ
T19ISVNSKTsNCj4gICAgIGlmICghaGlzcikNCj4gICAgICAgICByZXR1cm47DQo+ICAgICAvKiBN
YXNrIGludGVycnVwdHMgYW5kIGFja25vd2xlZGdlIHBlbmRpbmcgc3RhdHVzIGJpdHMgKi8NCj4g
ICAgIHJ0d19zZGlvX2Rpc2FibGVfaW50ZXJydXB0KHJ0d2Rldik7DQo+ICAgICBydHdfd3JpdGUz
MihydHdkZXYsIFJFR19TRElPX0hJU1IsIGhpc3IpOw0KPiAgICAgaWYgKGhpc3IgJiBSRUdfU0RJ
T19ISVNSX1RYRVJSKQ0KPiAgICAgICAgIHJ0d19zZGlvX3R4X2Vycl9pc3IocnR3ZGV2KTsNCj4g
ICAgIGlmIChoaXNyICYgUkVHX1NESU9fSElTUl9SWF9SRVFVRVNUKQ0KPiAgICAgICAgIHJ0d19z
ZGlvX3J4X2lzcihydHdkZXYpOw0KPiAgICAgLyogUmUtZW5hYmxlIGludGVycnVwdHM6IGlmIG5l
dyBwYWNrZXRzIGFycml2ZWQgZHVyaW5nIHJ4X2lzciwNCj4gICAgICAqIFJFR19TRElPX0hJU1Jf
UlhfUkVRVUVTVCB3YXMgYXNzZXJ0ZWQgaW4gaGFyZHdhcmU7IHVubWFza2luZyBISU1SDQo+ICAg
ICAgKiBpbW1lZGlhdGVseSBhc3NlcnRzIFNESU8gREFUWzFdLCBjYXVzaW5nIGtzZGlvaXJxZCB0
byBydW4gYW5vdGhlciBwYXNzLg0KPiAgICAgICovDQo+ICAgICBydHdfc2Rpb19lbmFibGVfaW50
ZXJydXB0KHJ0d2Rldik7DQoNClllcywgSSBwcmVmZXIgdGhpcyBraW5kIG9mIGZsb3cgYXMgd2Vs
bC4gSXQgbG9va3MgdmVyeSBzaW1pbGFyIHRvIHdoYXQgUENJIGRvZXMuDQoNCj4gDQo+IEkgcHJl
ZmVyIHRoaXMgYXBwcm9hY2ggYXM6DQo+IDEuIEl0IGNvbXBsZXRlbHkgY2xvc2VzIHRoZSByYWNl
IHdpbmRvdzogYW55IHBhY2tldCBhcnJpdmluZyBkdXJpbmcgRklGTyBkcmFpbmFnZQ0KPiAgICBs
YXRjaGVzIFJFR19TRElPX0hJU1JfUlhfUkVRVUVTVCBpbiBoYXJkd2FyZS4gV2hlbiBydHdfc2Rp
b19lbmFibGVfaW50ZXJydXB0KCkNCj4gICAgcmVzdG9yZXMgSElNUiwgdGhlIGludGVycnVwdCBs
aW5lIGlzIGFzc2VydGVkIGFuZCBrc2Rpb2lycWQgaW1tZWRpYXRlbHkNCj4gICAgc2VydmljZXMg
dGhlIG5ldyBwYWNrZXQuDQoNClBsZWFzZSBkbyB0aGUgc2FtZSBleHBlcmltZW50cyB0byBlbnN1
cmUgaXQgZG9lc24ndCBnZXQgc3R1Y2sgaW4gRklGTy4NCg0KDQo+IDIuIFRoZSBvdmVyaGVhZCBv
ZiB0b2dnbGluZyBISU1SIGlzIGp1c3QgdHdvIDQtYnl0ZSBDTUQ1Mi9DTUQ1MyB3cml0ZXMNCj4g
ICAgKH4xLTIgbWljcm9zZWNvbmRzIHRvdGFsIHBlciBpbnRlcnJ1cHQgYnVyc3QpLCB3aGljaCBp
cyBuZWdsaWdpYmxlICg8MC4xJSkNCj4gICAgY29tcGFyZWQgdG8gdHJhbnNmZXJyaW5nIHBheWxv
YWQgZGF0YSBvdmVyIFNESU8uDQoNCkkgaGF2ZSBsYWNrIGtub3dsZWRnZSBvZiBTRElPLCBzbyBJ
IGNhbid0IGp1ZGdlIHRoaXMuDQpDYW4geW91IGRlc2lnbiBleHBlcmltZW50cyBhcyBldmlkZW5j
ZT8NCg0KDQo+IDMuIEl0IHVzZXMgdGhlIGV4aXN0aW5nIHJ0d19zZGlvX2Rpc2FibGVfaW50ZXJy
dXB0KCkgYW5kIHJ0d19zZGlvX2VuYWJsZV9pbnRlcnJ1cHQoKQ0KPiAgICBoZWxwZXJzIGFuZCBy
ZXF1aXJlcyBvbmx5IH40IGxpbmVzIG9mIGNvZGUgY2hhbmdlcyB3aXRob3V0IHRvdWNoaW5nIHJ4
X2lzci4NCg0KTWFrZSBzZW5zZS4gT25seSBJTVIgaXMgYWZmZWN0ZWQuIA0KDQo+IA0KPiBBbHRl
cm5hdGl2ZWx5LCBpZiB3ZSBwcmVmZXIgbm90IHRvIHRvdWNoIEhJTVIsIHdlIGNhbiBwZXJmb3Jt
IGEgZHJhaW4tYW5kLXJlY2hlY2sNCj4gaW5zaWRlIHJ0d19zZGlvX3J4X2lzcigpOg0KPiAgIHdo
ZW4gcnhfbGVuIHJlYWRzIDAsIGlzc3VlIFcxQyB0byBSRUdfU0RJT19ISVNSX1JYX1JFUVVFU1Qg
YW5kIGltbWVkaWF0ZWx5IHJlLXJlYWQNCj4gUkVHX1NESU9fUlgwX1JFUV9MRU4uDQo+ICAgSWYg
aXQgcmVhZHMgPiAwLCBjb250aW51ZSBkcmFpbmluZywgb3RoZXJ3aXNlIGJyZWFrLg0KDQpIb25l
c3RseSBJIGRvbid0IHJlYWQgYW5kIHRoaW5rIHRoaXMgaW4gZGV0YWlsLCBidXQgSSBjYW4ndCB1
bmRlcnN0YW5kIGl0IGNhbg0KYXZvaWQgcmFjaW5nLiBBcyB5b3UgYXJlIG5vdCBhIGZhbiBvZiB0
aGlzIGFwcHJvYWNoLCBqdXN0IGlnbm9yZSB0aGlzLg0KDQo+IA0KPiBUb2dnbGluZyBISU1SIGFz
IG91dGxpbmVkIGFib3ZlIGlzIHRoZSBjbGVhbmVzdCBhbmQgbW9zdCBzdGFuZGFyZCBwYXR0ZXJu
Lg0KPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhpcyBhcHByb2FjaCBpcyBhY2NlcHRhYmxlIHRv
IHlvdSwgYW5kIEkgd2lsbCBwcmVwYXJlDQo+IGFuZCBzdWJtaXQgdjIuDQoNCkknbSBva2F5IHRo
aXMgdGhlIHByb3Bvc2FsLiANCg0KSSBoZWFyZCBmcm9tIGludGVybmFsIHRoYXQgc29tZSB3ZWFr
IHBsYXRmb3JtcyBtaWdodCB3YW50IHRoaXMga2luZCBvZiANCiJidXN5IHBvbGxpbmciIHRvIHlp
ZWxkIHBlcmZvcm1hbmNlLiBNYXliZSwgd2UgY2FuIGRlc2lnbiBhbm90aGVyIGFsdGVybmF0aXZl
DQp3YXlzIGlmIHNvbWV0aW1lIHBlb3BsZSBlbmNvdW50ZXIgcHJvYmxlbS4gT3IgeW91IGhhdmUg
YW5vdGhlciB0aG91Z2h0IG5vdz8NCg0KUGluZy1LZQ0KDQo=
