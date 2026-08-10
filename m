Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7350DF6C;
	Mon, 10 Aug 2026 03:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786331877; cv=none; b=Y/WWsVpaeuXmNj4LCesXBAFdpDcDI75YBnetfvLiL8yIM/duTPSLnQkp1gVNcF9d2dUSN4xNhk0000AtXa9FK4iaPkX358a3mYYTqhiTqH8GlpOpzOp3gP/+bBJnNUkviDEREO0WaXa+EUAsKXe/VIMdeKndFyLKjyzFtK7aikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786331877; c=relaxed/simple;
	bh=5gUwKfS1v4EtH8J4mClks55f8X2L6SspAC9kSag3DBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5agJm7kumzEqgYGNyAU9QLaU+qWMoPcUTvEiMPgKGfS2qI27gABeJ0JHTK3ICR+30PwgZkK8Ms4KP++Cp2z4ZH53Z760F2rtqk2YGkwy7VmgtN/8IqdzaYJwuTwscBaoVhZC1vsSp0CisOzyiXEHzFEqwWUZCwkxfJrINa4oWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GFPoLG+2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GFPoLG+2"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67A3HoKuA1424215, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1786331870; bh=5gUwKfS1v4EtH8J4mClks55f8X2L6SspAC9kSag3DBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GFPoLG+28xAh+WewOYc5O0peSCsJwjPGEiP8SmHTzoLB20OJxVa6J6rNP7H61cZAx
	 8Yc6EA9sQhb75WAyzlgBfaWvIwPJ2mWTSAKmzibwPokrkqQhb8uiuWBtBqEf4X8GKr
	 h4EcJjpwRWkrt6KOYZH49ACBuSPIaVALtEGs6FCqYQSL5y+vMNwGdSluOHUbIMouxA
	 n0Is9QcPGf6LO+IQnb8wS2xCWrU36vlrXY82T2HfT2Gv0TspPwWAOTLUtGSYCBCo4j
	 BhgrmLUFKzvgswJB9DhMfOJBUYHpRiX4UoEKiBX3uA0jeAxQ4i0FFKr3ZAMY6DD7Rg
	 6mnXNfLORM7YQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67A3HoKuA1424215
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Aug 2026 11:17:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 10 Aug 2026 11:17:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::126f:59ad:658:674d%10]) with mapi id
 15.02.2562.043; Mon, 10 Aug 2026 11:17:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?44Kk44Og44OG44Kj44Ok44K6?= <reza1234khan1234@gmail.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: fix out-of-bounds CAM write when key table
 is full
Thread-Topic: [PATCH] wifi: rtw88: fix out-of-bounds CAM write when key table
 is full
Thread-Index: AQHdJR7AexfNMbMg2kKY8auZwqgSbbaWoJug
Date: Mon, 10 Aug 2026 03:17:50 +0000
Message-ID: <253cd5376c6346c893b5a88b32215b23@realtek.com>
References: <20260805210941.75136-1-reza1234khan1234@gmail.com>
In-Reply-To: <20260805210941.75136-1-reza1234khan1234@gmail.com>
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

DQrjgqTjg6Djg4bjgqPjg6TjgrogPHJlemExMjM0a2hhbjEyMzRAZ21haWwuY29tPiB3cm90ZToN
Cj4gSW4gcnR3X29wc19zZXRfa2V5KCksIHdoZW4gdGhlIENBTSB0YWJsZSBpcyBmdWxsLA0KPiBy
dHdfc2VjX2dldF9mcmVlX2NhbSgpIHJldHVybnMgUlRXX01BWF9TRUNfQ0FNX05VTSAoMzIpIGJl
Y2F1c2UNCj4gZmluZF9uZXh0X3plcm9fYml0KCkvZmluZF9maXJzdF96ZXJvX2JpdCgpIHJldHVy
biB0aGUgYml0bWFwIHNpemUNCj4gd2hlbiBubyBmcmVlIHNsb3QgZXhpc3RzLiBUaGUgYm91bmRz
IGNoZWNrIGNvbXBhcmVzIHRoZSByZXR1cm5lZA0KPiBpbmRleCB3aXRoICI+IiBhZ2FpbnN0IHRv
dGFsX2NhbV9udW0gKDMyKSwgc28gdGhlIGludmFsaWQgaW5kZXggMzINCj4gcGFzc2VzIHRoZSBj
aGVjay4NCj4gDQo+IHJ0d19zZWNfd3JpdGVfY2FtKCkgdGhlbiBpbmRleGVzIGNhbV90YWJsZVsz
Ml0sIGFuIGFycmF5IGRlY2xhcmVkDQo+IHdpdGggUlRXX01BWF9TRUNfQ0FNX05VTSAoMzIpIGVu
dHJpZXMsIGNhdXNpbmcgYW4gb3V0LW9mLWJvdW5kcw0KPiB3cml0ZSB0aGF0IGNvcnJ1cHRzIHRo
ZSBjYW1fbWFwIGFsbG9jYXRpb24gYml0bWFwLiBUaGUgd3JpdGUgYWxzbw0KPiBzZXRzIGJpdCAz
MiBvZiBjYW1fbWFwLCB3aGljaCBvdmVycnVucyB0aGUgYml0bWFwIGFzIHdlbGwuDQo+IA0KPiBG
aXggdGhlIG9mZi1ieS1vbmUgYnkgcmVqZWN0aW5nIGluZGljZXMgPj0gdG90YWxfY2FtX251bS4N
Cj4gDQo+IEZpeGVzOiBlMzAzNzQ4NWM2OGUgKCJydHc4ODogbmV3IFJlYWx0ZWsgODAyLjExYWMg
ZHJpdmVyIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCg0KVGhlc2UgdHdvIGFyZSBm
b3JtYWwgdGFncywgc28gSSdkIG1vdmUgdGhlbSB0b2dldGhlciB3aXRoIFRlc3RlZC1ieSB0YWcu
DQoNCj4gDQo+IFRlc3RlZCBvbjogUlRMODgyMUNFIChQQ0llKSBvbiBrZXJuZWwNCj4gNy4yLjAt
cmM2LXJ0dzg4dGVzdC0wMDA1OS1nMGQ4Mzk1NzA3NjUxLiBUaGUgcGF0Y2hlZCBtb2R1bGUgbG9h
ZGVkDQo+IGFuZCBhc3NvY2lhdGVkIHRvIGEgV1BBMiBuZXR3b3JrOyBwaW5nIHRyYWZmaWMgcGFz
c2VkIHdpdGggMCUgcGFja2V0DQo+IGxvc3MuIFJlYXNzb2NpYXRpb24gYW5kIGRpc2Nvbm5lY3Qv
cmVjb25uZWN0IGN5Y2xlcyBjb21wbGV0ZWQNCj4gd2l0aG91dCBlcnJvcnMsIGFuZCB0aGUgQ0FN
IHRhYmxlIChkZWJ1Z2ZzIGR1bXBfY2FtKSBzaG93ZWQgdmFsaWQNCj4ga2V5IGVudHJpZXMuIFRo
ZSBDQU0tZnVsbCBib3VuZGFyeSAoMjgrIHBhaXJ3aXNlIGtleXMpIHJlcXVpcmVzIGFuDQo+IGFj
Y2VzcyBwb2ludCB3aXRoIDI4KyBjbGllbnRzIGFuZCBpcyBub3QgcmVhY2hhYmxlIGluIGENCj4g
c2luZ2xlLWNsaWVudCBzZXR1cCwgc28gdGhhdCBwYXRoIHdhcyB2ZXJpZmllZCBieSBjb2RlIGlu
c3BlY3Rpb24uDQoNClllcy4gVW5sZXNzIHlvdSBzdGFydCBhbiBBUCBtb2RlLCBhbmQgdXNlIG1h
bnkgY2xpZW50cyBjb25uZWN0IGl0LCBidXQNCkkgc3VzcGVjdCBydHc4OCBjYW4ndCBhZmZvcmQg
dG8gc3VwcG9ydCBzdWNoIGNsaWVudHMuIA0KDQo+IA0KPiBUZXN0ZWQtYnk6IOOCpOODoOODhuOC
o+ODpOOCuiA8cmV6YTEyMzRraGFuMTIzNEBnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IOOC
pOODoOODhuOCo+ODpOOCuiA8cmV6YTEyMzRraGFuMTIzNEBnbWFpbC5jb20+DQoNCkJ5IHRoZSB3
YXksIGlmIHlvdSB3YW50IHNwZWxsIHlvdXIgSmFwYW5lc2UgbmFtZSBpbiBFbmdsaXNoLCB0aGUg
ZGlzcGxheSB3b3VsZA0KYmUgbm9ybWFsIHNpbmNlIG15IHNvbWUgZ2l0IHRvb2xzIGRvIG5vdCBz
dXBwb3J0IFVURi04LiBCdXQgSSBkb24ndCBpbnNpc3QgdGhpcy4NCg0KQWNrZWQtYnk6IFBpbmct
S2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==
