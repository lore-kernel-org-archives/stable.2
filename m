Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9883537E8;
	Mon, 12 Oct 2026 05:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783865; cv=none; b=YbrQzO2ipvn0xyp8H5pL9NLMz1ZsSb82UhwrTCOl/2p/agQj1jpvealH7ht94/Rnno//khOvzRJHkDPvqDBwF+lj9s/yug+NrAymbdQs56kh605GNlylFVYmjnGvsfgKheJeX6pLgNvFrRa/Z40YuvdrchLoe4OVku4zoXqmKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783865; c=relaxed/simple;
	bh=Cogu/pFMc9yuLZJiJzJBing2CsSEJdu2Yd8zlYYfu84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h0BdieiQkShwAL+/+7UGBL3lF92QN0L8XclkpJ6UOCC2aR9+ElPcKOAocB0PkXkCgCnTsynXsZC9b4w805n3beWO8RuuDmYJbAA73oc37e9XDmLN0Ozc2Kqx/IGsWNbphHbetnBnRyOv5Cp6+BhVSwUv8sTemPbA8rTbJey6TGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=RMJvgf3G; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="RMJvgf3G"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69C5iCz653574260, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791783853; bh=Cogu/pFMc9yuLZJiJzJBing2CsSEJdu2Yd8zlYYfu84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=RMJvgf3GcbuFY3d9kbzDsh0tEDrmaPoDjxE6pInJ2tgZ2PGkDntJKdX05DFaxpjyO
	 0VHYqLFVhUw8HhMfNhgju5A/IOPgFScwqpXqkEv055OM5vsmCQCzYYGGDp6ur4Xy8q
	 GMl5HYgScML0BA49TQqtJroY3fWx6QD99cBEahqlOEFnjClZrYm59afk0xcKJxQA89
	 rseo0r1xp4gzIE3hpa+BTd39BBVUWrXvwMDsgXoMKSDhOq6X95tOoPZHEnfq19PPn/
	 s1TeYVsICP08YjD8MtKeQpYCe9AaSG0tLgRfPWRzZpc3G2L432IF1X7rv9gUALLTsV
	 TNBeBhy3PvMsw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69C5iCz653574260
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Oct 2026 13:44:13 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 13:44:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 13:44:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Mon, 12 Oct 2026 13:44:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "5mghybrid@khu.ac.kr" <5mghybrid@khu.ac.kr>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtl8xxxu: isolate the USB register buffer
 from CPU state
Thread-Topic: [PATCH rtw-next] wifi: rtl8xxxu: isolate the USB register buffer
 from CPU state
Thread-Index: AQHdWD8IbE0sWRKeB0i8lqEjk1P2g7b5aFkw
Date: Mon, 12 Oct 2026 05:44:19 +0000
Message-ID: <1fc8c339df1944afa6186197337edda3@realtek.com>
References: <20261010-rtl8xxxu-usb-dma-v1-0-e670d9c08fdf@khu.ac.kr>
 <20261010-rtl8xxxu-usb-dma-v1-1-e670d9c08fdf@khu.ac.kr>
In-Reply-To: <20261010-rtl8xxxu-usb-dma-v1-1-e670d9c08fdf@khu.ac.kr>
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

S2ltIFdvb3Nlb2sgdmlhIEI0IFJlbGF5IDxkZXZudWxsKzVtZ2h5YnJpZC5raHUuYWMua3JAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IEZyb206IEtpbSBXb29zZW9rIDw1bWdoeWJyaWRAa2h1LmFjLmty
Pg0KPiANCj4gQW4gUlRMODE5MkVVIGZhaWxlZCB0byByZWNvbm5lY3Qgb24gYSBSYXNwYmVycnkg
UGkgYWZ0ZXIgYW4gQVAgcG93ZXINCj4gY3ljbGUuIFJGX01PREUgY29udGFpbmVkIGEgY29ycnVw
dGVkIHZhbHVlLCBhbmQgcmVzdG9yaW5nIGl0cyBpbml0aWFsaXplZA0KPiB2YWx1ZSByZXN0b3Jl
ZCByZWNlcHRpb24uDQo+IA0KPiBUaGUgcmVnaXN0ZXIgYWNjZXNzIGhlbHBlcnMgcGFzcyB1c2Jf
YnVmIGRpcmVjdGx5IHRvIHVzYl9jb250cm9sX21zZygpLA0KPiBidXQgdGhlIGJ1ZmZlciBpcyBl
bWJlZGRlZCBuZXh0IHRvIHVzYl9idWZfbXV0ZXguIE9uIHRoZSBhZmZlY3RlZCBQaSwNCj4gaXQg
c2hhcmVzIGEgY2FjaGUgbGluZSB3aXRoIHRoZSBtdXRleCdzIHdhaXRlciBzdGF0ZS4gQSBjb250
ZW5kaW5nIHRhc2sNCj4gdXBkYXRlcyB0aGF0IHN0YXRlIHdoaWxlIHRoZSBVU0IgdHJhbnNmZXIg
dXNlcyB0aGUgYnVmZmVyLiBUaGlzIHZpb2xhdGVzDQo+IHRoZSBjYWNoZS1saW5lIGlzb2xhdGlv
biByZXF1aXJlZCBmb3Igbm9uLWNvaGVyZW50IERNQS4NCg0KQ29vbC4gSG93IGRpZCB5b3UgZGln
IHRoYXQ/DQoNCj4gDQo+IEFsbG9jYXRlIHRoZSBidWZmZXIgb25jZSBpbiBwcm9iZSBhbmQgcmV1
c2UgaXQsIGF2b2lkaW5nIGFuIGFsbG9jYXRpb24NCj4gZm9yIGV2ZXJ5IHJlZ2lzdGVyIGFjY2Vz
cy4gS2VlcCB0aGUgZXhpc3RpbmcgcmVnaXN0ZXIgYWNjZXNzIGhlbHBlcnMgYW5kDQo+IG11dGV4
IHByb3RlY3Rpb24uIEZyZWUgdGhlIGJ1ZmZlciBvbiBwcm9iZSBmYWlsdXJlIGFuZCBhZnRlciBw
b3dlcl9vZmYoKQ0KPiBpbiBkaXNjb25uZWN0LCBzaW5jZSBzaHV0ZG93biBzdGlsbCB1c2VzIHRo
ZSByZWdpc3RlciBhY2Nlc3MgaGVscGVycy4NCj4gDQo+IEZpeGVzOiAyNmYxZmFkMjlhZDkgKCJO
ZXcgZHJpdmVyOiBydGw4eHh4dSAobWFjODAyMTEpIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcNCj4gU2lnbmVkLW9mZi1ieTogS2ltIFdvb3Nlb2sgPDVtZ2h5YnJpZEBraHUuYWMua3I+
DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo=
