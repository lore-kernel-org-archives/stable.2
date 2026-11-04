Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793772596;
	b=UNulY1/PM1brNRs1d4w/Tr46aohWSnNvVTSDa5UghAy7D6RVrzKEEJiBHZwdglW52k/D
	 as57NruaBM9e08dHgsjjGcwBU13b/v5fPi2TBdiOw3YgBLXa57xcIAs7dAaFOM3/bB+gU
	 siN88K4LcZJ1yDhZtiw/PCnETsXsQl4Fn7KmWykIQ71NUEaCBoffYNR3D1ysphH8ByPvp
	 /4mWcDk4FsCubc5tcKUurEyC0DTS7KDgekeB8S1mEkv+kxPIZMpRgXWl1xLiwj+W7MXu4
	 NwCgte5lH2qvT0uH6ik0yQRpSUhV/lYP5NcvDOrPUaBwpeCbYdiiZLGM7sUJgwbfpBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793772596;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 x-originating-ip:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=3fqzlNIFl8e4DD3QtzcILKzoArZsVTIXy2/zJtbpfhQ=;
	b=bFZOR7oCV9xBJq2dJ2kbAx789yL5Bw3vylelZNNAK2q7L+y7lCWnd4jn8eSMrksaeBpx
	 6rrlbrvmTerNwbxr6MW7gRhcfhyPWPouBlFhWW9L15Mu5Fg89slyQK3mgpQXek61Uv+f1
	 Pj6N+nAcEJOIRNW7nH6ixvgpL0eWkVZmMXpYoiHWKXvcNMpXd+AydCilWMCEV73NLBFYJ
	 SllahgAzYjj3M1Pnw+6C3mjaDGeoulfoZ5sKngnjMsGs2G+zgKc1AUknJguG6gvSzFLC3
	 em0ILVeL6MdxH2IvGEjfmOuNa+2Ly26CgpVgOITmIPvOWXrSupc+5w6Y8VOTVqTLmHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=syA0olUt;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F618606A326;
	Wed,  4 Nov 2026 06:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F618606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=syA0olUt
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A469emqE3770355, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1793772581; bh=3fqzlNIFl8e4DD3QtzcILKzoArZsVTIXy2/zJtbpfhQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=syA0olUtRopOrCl99dTF+P775+b1CzutFgC3AdUUob+BuiinQgHi5DBZglHw30QcS
	 FXRmoSmNod9qmUlcKeQGeO99h730+W86YLgarMKGVijCJyf6zofU3OhEFrrBJjWfYT
	 MdEUBMLnWgO1VomilqX9yj8bD5YxWhILWfcq37DNPWE7eknuSBDUVz3ZawF+brFgS7
	 w65XvgGRtRa0DvchAQ2cyqhD2mDkXpFAvWW6HdqLMljedAABvhIky10TlTtnXpvJvi
	 l8RC+XuGzuSaccP+cJj2eFQjY8jx84PpnGRo5OuTH7nSXgT22gFjhU3/uWxCT9UFzZ
	 uGmTWMMAFv6Pw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A469emqE3770355
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Nov 2026 14:09:41 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 14:09:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 14:04:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::eeeb:c765:ca73:5eef%10]) with mapi id
 15.02.2562.056; Wed, 4 Nov 2026 14:04:40 +0800
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
Subject: RE: [PATCH 05/10] pinctrl: realtek: Prevent out-of-bounds access in
 rtd_pinctrl_find_config()
Thread-Topic: [PATCH 05/10] pinctrl: realtek: Prevent out-of-bounds access in
 rtd_pinctrl_find_config()
Thread-Index: AQHda9qYNWUoySvnvUSqlcQwwTjBP7cdbH4A
Date: Wed, 4 Nov 2026 06:04:39 +0000
Message-ID: <efec48c734f44016829a43d4e068794a@realtek.com>
References: <20261103213002.1673560-1-lee@kernel.org>
 <20261103213002.1673560-6-lee@kernel.org>
In-Reply-To: <20261103213002.1673560-6-lee@kernel.org>
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

PiBTZXZlcmFsIFJlYWx0ZWsgU29DIHBpbiBjb25maWd1cmF0aW9uIHRhYmxlcyAoc3VjaCBhcyBy
dGQxMzE5ZF9pc29fY29uZmlncywNCj4gcnRkMTYxOWJfaXNvX2NvbmZpZ3MsIGFuZCB0aGUgcnRk
MTYyNSBjb25maWcgdGFibGVzKSBvbWl0IHRyYWlsaW5nIHBpbnMgdGhhdCBkbw0KPiBub3Qgc3Vw
cG9ydCBwaW4gY29uZmlndXJhdGlvbiwgbWFraW5nIGRhdGEtPmluZm8tPm51bV9jb25maWdzIHNt
YWxsZXIgdGhhbg0KPiBkYXRhLT5pbmZvLT5udW1fcGlucy4gIEJlY2F1c2UgcnRkX3BpbmN0cmxf
ZmluZF9jb25maWcoKSBpbmRleGVzDQo+IGRhdGEtPmluZm8tPmNvbmZpZ3NbcGluXSB3aXRob3V0
IGNoZWNraW5nIGRhdGEtPmluZm8tPm51bV9jb25maWdzLCByZXF1ZXN0aW5nDQo+IHBpbiBjb25m
aWd1cmF0aW9uIG9uIGEgdHJhaWxpbmcgcGluIHJlYWRzIG91dC1vZi1ib3VuZHMgbWVtb3J5Lg0K
PiANCj4gQ2hlY2sgdGhhdCBwaW4gaXMgbGVzcyB0aGFuIGRhdGEtPmluZm8tPm51bV9jb25maWdz
IGJlZm9yZSBpbmRleGluZw0KPiBkYXRhLT5pbmZvLT5jb25maWdzW10uDQo+IA0KPiBGaXhlczog
ZTk5Y2U3ODAzMGRiICgicGluY3RybDogcmVhbHRlazogQWRkIGNvbW1vbiBwaW5jdHJsIGRyaXZl
ciBmb3IgUmVhbHRlaw0KPiBESEMgUlREIFNvQ3MiKQ0KPiBDbG9zZXM6DQo+IGh0dHBzOi8vc2Fz
aGlrby5kZXYvIy9idWcvbGludXgtNjBlMTM3NjEtZmQ5ZS00ZmQzLTgyNmEtNDczNDRmMzZkNGZh
DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IExlZSBKb25l
cyA8bGVlQGtlcm5lbC5vcmc+DQoNClJldmlld2VkLWJ5OiBZdS1DaHVuIExpbiA8ZWxlYW5vci5s
aW5AcmVhbHRlay5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3BpbmN0cmwvcmVhbHRlay9waW5j
dHJsLXJ0ZC5jIHwgMyArKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvcmVhbHRlay9waW5jdHJsLXJ0ZC5jDQo+
IGIvZHJpdmVycy9waW5jdHJsL3JlYWx0ZWsvcGluY3RybC1ydGQuYw0KPiBpbmRleCA2MDIyMjMz
OTcyNmIuLjJiODc3MDk5ZWM4NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waW5jdHJsL3JlYWx0
ZWsvcGluY3RybC1ydGQuYw0KPiArKysgYi9kcml2ZXJzL3BpbmN0cmwvcmVhbHRlay9waW5jdHJs
LXJ0ZC5jDQo+IEBAIC0yNTIsNiArMjUyLDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwaW5jdHJs
X3Bpbl9kZXNjICBzdGF0aWMgY29uc3Qgc3RydWN0DQo+IHJ0ZF9waW5fY29uZmlnX2Rlc2MNCj4g
ICAgICAgICAqcnRkX3BpbmN0cmxfZmluZF9jb25maWcoc3RydWN0IHJ0ZF9waW5jdHJsICpkYXRh
LCB1bnNpZ25lZCBpbnQgcGluKQ0KPiB7DQo+ICsgICAgICAgaWYgKHBpbiA+PSBkYXRhLT5pbmZv
LT5udW1fY29uZmlncykNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBOVUxMOw0KPiArDQo+ICAg
ICAgICAgaWYgKGRhdGEtPmluZm8tPmNvbmZpZ3NbcGluXS5uYW1lKQ0KPiAgICAgICAgICAgICAg
ICAgcmV0dXJuICZkYXRhLT5pbmZvLT5jb25maWdzW3Bpbl07DQo+IA0KPiAtLQ0KPiAyLjU2LjAu
Mzg1LmdhYzY3MWM4MTlhLWdvb2cNCg==
