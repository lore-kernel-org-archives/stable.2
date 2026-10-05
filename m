Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C923371D01;
	Mon,  5 Oct 2026 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183475; cv=none; b=agHV4pbbPP+7twOuplTpJThIbj519te3+yFc8fOZph0tFxdl9NcOyS50ZOQAGqXRmfC2cAhVReI8Y0KQ40l9fpqOgAi1hb66st8ZSQMQgAfpbfnUrm+mRFE1/XsHGJedE3hkLBLn7p/wcYLRGa+qxWwzmW/sDzRPZmv7Ys4E17w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183475; c=relaxed/simple;
	bh=cakKebxd6SYR3mrRpNebAr69JFunqZ4AtJnzIzKfmks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y06rPT1EnLp5edhJzUzu2C0+xr/cHoDQluKGXLZvdi+/9BRL8IwZb1p4vESHWhTABQ+jOih/7zfdzPfS97SfrXOiBFK2UStVpmj8M6enyoT+eu082gPWnsvj/GDZBjhOsEKXoocy0E+T7OP/VA3cxr+eRVct+gR+T884s2orupg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=i4zioz4F; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="i4zioz4F"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6956vNi051722935, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791183443; bh=cakKebxd6SYR3mrRpNebAr69JFunqZ4AtJnzIzKfmks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=i4zioz4FFbjazCODfYhyRl8PVfrUadFgFT2pNWMtvmG7lcR2uNrzej3nx/QBIeNX2
	 MB80mlkYgwGsaakLTXGWSFKUnzqx+w4swaJmcJIs7FBCBbYOEOJd1gBj1LznR0rAKY
	 J9nQAiOXvrRUW7wEDHM2gKM+8U4iDJuCB3cT57JjDeEq2dzGwNiZOV1o1IW+wRjZt+
	 csNdYHp+7Eca2EiuXksxxchwa8XFApnBm08mZIXBvhaGzUBH0Rlqoxp4stRTpg43oO
	 FTElritKtmGJvtsHhaf1g0AV9Bxcsg94N6nKeDMVdXGgFkbdm2uoXPkdo+jV/qTgtC
	 44+ybIbJ42Czg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6956vNi051722935
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Oct 2026 14:57:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 14:57:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 14:57:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Mon, 5 Oct 2026 14:57:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Alastair D'Silva <alastair@d-silva.org>, Luka Gejak
	<luka.gejak@linux.dev>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ulf Hansson
	<ulfh@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Kalle Valo
	<kvalo@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] wifi: rtw88: sdio: Fix unhandled RX request
 interrupt storm
Thread-Topic: [PATCH v3 1/2] wifi: rtw88: sdio: Fix unhandled RX request
 interrupt storm
Thread-Index: AQHdUThjHehNiw0xlkuYT1bxT/PheLbuUbcg//+M34CAAJPnEP//jsQAgACJRnA=
Date: Mon, 5 Oct 2026 06:57:23 +0000
Message-ID: <f99dd5a0de9343c495b072ced41f9298@realtek.com>
References: <20261001000303.3505264-1-alastair@d-silva.org>
	 <20261001000303.3505264-2-alastair@d-silva.org>
	 <661b9fc47ce942a491f8c53d90fdf39a@realtek.com>
	 <6ef33599cc268fa12e4663461248f1700969df34@linux.dev>
	 <c852aa23403e4ec7ad80a17a6dc18d0e@realtek.com>
 <9bb2ad98540bd716d00a0eb0b4faf3593c06cc7a.camel@d-silva.org>
In-Reply-To: <9bb2ad98540bd716d00a0eb0b4faf3593c06cc7a.camel@d-silva.org>
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

QWxhc3RhaXIgRCdTaWx2YSA8YWxhc3RhaXJAZC1zaWx2YS5vcmc+IHdyb3RlOg0KPiBPbiBNb24s
IDIwMjYtMTAtMDUgYXQgMDU6MzAgKzAwMDAsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiBMdWth
IEdlamFrIDxsdWthLmdlamFrQGxpbnV4LmRldj4gd3JvdGU6DQo+ID4gPiBJIHRoaW5rIHlvdSBt
aXNzZWQgbXkgcmV2aWV3IGF0IFsxXS4NCj4gPiA+DQo+ID4gPiBbMV06aHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjYxMDAxMDYwMjEzLjI0NzU5LTEtbHVrYS5nZWpha0BsaW51eC5kZXYv
DQo+ID4NCj4gPiBJIGZlZWwgbGlrZSB0aGF0IG1pZ2h0IGJlIGV4aXN0aW5nIGlzc3VlPyBJZiBz
bywgdXNlIG90aGVyIHBhdGNoZXMgdG8gZml4DQo+ID4gdGhlbS4NCj4gPg0KPiANCj4gWWVzLCBp
dCdzIGFuIGV4aXN0aW5nIGlzc3VlIC0gSSBjYW4gc3VibWl0IHRoYXQgaW4gYSBzZXBhcmF0ZSBz
ZXJpZXMgaWYgeW91IHByZWZlci4NCg0KWWVzLCBwbGVhc2UuIA0KDQpJZiB0aGlzIHNlcmllcyBp
c24ndCBodXJyeSwgcGxlYXNlIHB1dCBpbnRvIHRoZSBzYW1lIHNlcmllcy4gDQooSSdkIHNlbmQg
cHVsbC1yZXF1ZXN0IGZvciBjdXJyZW50IC1uZXh0IGN5Y2xlIHRoaXMgd2Vlay4pDQoNClBpbmct
S2UNCg0K
