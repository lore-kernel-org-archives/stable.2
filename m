Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D09A33B6EF;
	Wed,  7 Oct 2026 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336448; cv=none; b=Bc9MmD6DvWkEFaHmHaQgmKWAnp2E7/vrWTEeRaAIP2uHfr0jTizJEvRCCmW78v+pHzadVsGVwZJsDhC8we1OEpsjGMVUc3MUr+vGuVbGBKkooIvA8x5jQwYJvSh/nFoRl5Acb/XqTDhDlWt815UXnqE4q9lVn7ed+JvociSJBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336448; c=relaxed/simple;
	bh=1SDnVWqu8JplbNjQCDGu4OsfoCACpWs1K3FKSVR9AhY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PcT/Q450BA0klPSXhLQUGqg8fwrYT3bHCrKIskkV2heMjs5aAWk+AYjiUkAn+7BUxj1gPsrIImKcpLdj+WSYxNnZZRq7c7ay+Gz90JnKK4tGr+9FP9dK6oNsUlGJYuNPLeAz6+B84nvth1tuZHzperbgda1xb2y610qSAHdsvUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ejhSkZfl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ejhSkZfl"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6971QtjcE3427983, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791336415; bh=1SDnVWqu8JplbNjQCDGu4OsfoCACpWs1K3FKSVR9AhY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ejhSkZflc/ltUJjYnkGhaWt7j7/9vK8Swou+ZBmA9nxvI3VJTRCyBWov30espLyJq
	 dRgOAnSl/9MSk5dSbQRgGPoCn08VFvvLJ4mGgE8PXDajsF0ElIDPDH8Vmecd5T9cma
	 RIJsxEv61Ff1tBv4DdDZZiMJMptoU3Uzd5Z+iBJHPdH5ceoFrAYfKzqK1YA3TJMxDY
	 vdsdD4SUB3rGmXxM1+BIF5/r397lg1g3qHxD4NqDmc5kvB0iinzNjUQhqh/OhMA1BT
	 baqJZjwKfNwVs+gVKRB/x7dr28w6jSZUw6ORs8lOxRvJKWxnYrqCYvoBpQonswDGWk
	 I/sghttnXGUEA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6971QtjcE3427983
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Oct 2026 09:26:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 09:26:55 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 09:26:54 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::b3cc:c263:b82d:e87c%10]) with mapi id
 15.02.2562.049; Wed, 7 Oct 2026 09:26:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Luka Gejak <luka.gejak@linux.dev>, Alastair D'Silva
	<alastair@d-silva.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next v4 2/4] wifi: rtw88: sdio: Track running state
 and cancel TX worker on stop
Thread-Topic: [PATCH rtw-next v4 2/4] wifi: rtw88: sdio: Track running state
 and cancel TX worker on stop
Thread-Index: AQHdVKaABn3K541ouEKSWwSRfxdAa7bvvepAgABJhoCAAULt8A==
Date: Wed, 7 Oct 2026 01:26:54 +0000
Message-ID: <1b8a86e84c474693bfa71f39e946e7e6@realtek.com>
References: <20261005084849.3109337-1-alastair@d-silva.org>
 <20261005084849.3109337-3-alastair@d-silva.org>
 <6665409e1d374c1face4936b827a6a9d@realtek.com>
 <ccc69689fe2a2cccc39d40221056722e24263f2f@linux.dev>
In-Reply-To: <ccc69689fe2a2cccc39d40221056722e24263f2f@linux.dev>
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

THVrYSBHZWphayA8bHVrYS5nZWpha0BsaW51eC5kZXY+IHdyb3RlOg0KPiA+ID4gIEBAIC0xNzAz
LDYgKzE3MTIsOSBAQCBzdGF0aWMgdm9pZCBydHdfc2Rpb190eF9oYW5kbGVyKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykNCj4gPiA+ICBydHdkZXYgPSB3b3JrX2RhdGEtPnJ0d2RldjsNCj4gPiA+
ICBydHdzZGlvID0gKHN0cnVjdCBydHdfc2RpbyAqKXJ0d2Rldi0+cHJpdjsNCj4gPiA+DQo+ID4g
PiAgKyBpZiAoIXJ0d3NkaW8tPnJ1bm5pbmcpDQo+ID4gPiAgKyByZXR1cm47DQo+ID4gPiAgKw0K
PiA+ID4NCj4gPiBJIGRvbid0IHRoaW5rIHdlIG5lZWQgdGhpcywgc2luY2UgeW91IGFkZGVkIGNh
bmNlbF9kZWxheWVkX3dvcmtfc3luYygpIGluDQo+ID4gcnR3X3NkaW9fc3RvcCgpLg0KPiANCj4g
SSB0aGluayB3ZSBzaG91bGQga2VlcCB0aGUgY2hlY2suIFRoZSB0eCB3b3JrIGFybXMgdGhlIFNE
SU8gd29yayBhdCB0aGUgZW5kLA0KPiBhbmQgc3RvcCBkb2VzIG5vdCBjYW5jZWwgaXQ6DQo+IA0K
PiAgICAgICAgIHJ0d19oY2lfdHhfa2lja19vZmYocnR3ZGV2KTsNCj4gDQo+ICAgICAgICAgY2Fu
Y2VsX3dvcmtfc3luYygmcnR3ZGV2LT5jMmhfd29yayk7DQo+ICAgICAgICAgY2FuY2VsX3dvcmtf
c3luYygmcnR3ZGV2LT51cGRhdGVfYmVhY29uX3dvcmspOw0KPiAgICAgICAgIGNhbmNlbF9kZWxh
eWVkX3dvcmtfc3luYygmcnR3ZGV2LT53YXRjaF9kb2dfd29yayk7DQo+ICAgICAgICAgY2FuY2Vs
X2RlbGF5ZWRfd29ya19zeW5jKCZjb2V4LT5idF9yZWxpbmtfd29yayk7DQo+ICAgICAgICAgY2Fu
Y2VsX2RlbGF5ZWRfd29ya19zeW5jKCZjb2V4LT5idF9yZWVuYWJsZV93b3JrKTsNCj4gICAgICAg
ICBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmNvZXgtPmRlZnJlZXplX3dvcmspOw0KPiAgICAg
ICAgIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmY29leC0+d2xfcmVtYWluX3dvcmspOw0KPiAg
ICAgICAgIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmY29leC0+YnRfcmVtYWluX3dvcmspOw0K
PiAgICAgICAgIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmY29leC0+d2xfY29ubmVjdGluZ193
b3JrKTsNCj4gICAgICAgICBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJmNvZXgtPmJ0X211bHRp
X2xpbmtfcmVtYWluX3dvcmspOw0KPiAgICAgICAgIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygm
Y29leC0+d2xfY2NrbG9ja193b3JrKTsNCg0KSW4gcnR3X3NkaW9fc3RvcCgpLCBpdCBkb2VzIGNh
bmNlbF9kZWxheWVkX3dvcmtfc3luYygmcnR3c2Rpby0+dHhfaGFuZGxlcl9kYXRhLT53b3JrKTsN
CklzIGl0IG5vdCBlbm91Z2g/DQoNCj4gDQo+IHNvIGEga2ljayBjYW4gbGFuZCBhZnRlciB0aGUg
Y2FuY2VsIGhhcyBydW4sIGFuZCBvbmx5IHRoaXMgZmxhZw0KPiBrZWVwcyB0aGUgaXRlbSBvZmYg
dGhlIHBvd2VyZWQtZG93biBkZXZpY2UuDQo+IA0KPiBBbHNvIEkgYmVsaWV2ZSB0aGlzIHNlcmll
cyBzaG91bGQgYmUgdGVzdGVkIG9uIGhhcmR3YXJlIHRvIGVuc3VyZQ0KPiBub3RoaW5nIGJyZWFr
cy4NCg0KV2hlbiBjYWxsaW5nIHJ0d19zZGlvX3N0b3AoKSwgSSB0aGluayBtYWM4MDIxMSBkb2Vz
bid0IFRYIGFueW1vcmUNCnRvIGRyaXZlciwgYW5kIHRoZW4gcnR3X3NkaW9fc3RvcCgpIGRvZXMN
CiAxLiBydHdzZGlvLT5ydW5uaW5nID0gZmFsc2U7DQogICAgLy8gcHJldmVudCB0byBzY2hlZHVs
ZSBydHdzZGlvLT50eF9oYW5kbGVyX2RhdGEtPndvcmsgYWdhaW4NCiAyLiBydHdfc2Rpb19kaXNh
YmxlX2ludGVycnVwdChydHdkZXYpOw0KICAgIC8vIHByZXZlbnQgdG8gcnVuIHJ0d19zZGlvX2hh
bmRsZV9pbnRlcnJ1cHQgYWdhaW4NCiAzLiBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnJ0d3Nk
aW8tPnR4X2hhbmRsZXJfZGF0YS0+d29yayk7DQogICAgLy8gZmx1c2gvd2FpdCB0aGUgcGVuZGlu
ZyBydHdfc2Rpb190eF9oYW5kbGVyDQoNCkFueXRoaW5nIEkgbWlzcz8gQ291bGQgeW91IHBvaW50
IG91dCBhIGNhc2UgdGhpcyBpcyBuZWVkZWQ/DQoNClBpbmctS2UNCg0K
