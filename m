Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5C33839B4;
	Tue, 13 Oct 2026 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877106; cv=none; b=fTIZ3TnT9q8q0IHeX2nBwzaVqlMjW2LHMP9m1A8eCKn2SruOwfk+utPz/nGBOF/KJY5molC9OMxMk0gOCpF8V60QlaFsqJ9I/aigR4f4BnmKCb5V1080mgt1lMG3FJgfK92d/Wa38gZf0JjAFrwI1KFy127uDaGJWf0Abqv8Vgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877106; c=relaxed/simple;
	bh=3f3y2n0ApDaFEjDl2acfQmborKmaArBGLspM5vPlDbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uR449sMAny7hRqT/2LZ9cmTRuVP7OA+4F0l8KmY5Sb/t0znB7Nj5BF3LydOGOYmN91zbOw+zYSECHtwmEAjW9LW63A37OKr5cn6GVkKOSRX+wxxEBo/koPR6l3ipWV2bxUBBmtH8G8VSpxoVv0A9FufC6rF7FVls94AKjbpAfHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jEvILi9x; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jEvILi9x"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69D7bf8Z3324134, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791877062; bh=3f3y2n0ApDaFEjDl2acfQmborKmaArBGLspM5vPlDbQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=jEvILi9x7mXvn26VNS1Qcfmu77xobcVBqXqaHRP94bEzNtpVVlyRYvl+li9wJLUjd
	 /9xO1EVJ6lQ8vbdGS0Oufpvk45Ok5OVeE4Y8Kzi0jFnsm7KlsmZ7m0CTKqJdsuwrzw
	 O/MzmbUZT9XTmskkGc/IGm1KgrbbBdsHhAqZfgwDjCuoPGHN37NVt10oLutvm39J09
	 p/XSo0ReoKfXskEzXNQFxcvuw9WrTg0FK+JKAQWU8YNZd/BYngOPtZZDTCtVtUk2Vy
	 T1z1N5Av2qYOEzQ2WRoYDXAk/Tb14w1MYW/tFE/Vf/HhDHq7hQb3wcvJkKBq7+haHb
	 2RKPm/6FpRNfw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69D7bf8Z3324134
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Oct 2026 15:37:42 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 15:37:42 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::f36f:a844:4916:93f2%9]) with mapi id
 15.02.2562.049; Tue, 13 Oct 2026 15:37:42 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Linmao Li <lilinmao@kylinos.cn>, Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Chih Kai Hsu
	<hsu.chih.kai@realtek.com>, nic_swsd <nic_swsd@realtek.com>, Birger Koblitz
	<mail@birger-koblitz.de>, Xiangqian Zhang <zhangxiangqian@kylinos.cn>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v2] r8152: Use BMSR to detect the link state
Thread-Topic: [PATCH net v2] r8152: Use BMSR to detect the link state
Thread-Index: AQHdVLexra3FlE5swkqMdmzmTHCGJ7bwLnWg///8UICABCHSAIAGzjdg
Date: Tue, 13 Oct 2026 07:37:42 +0000
Message-ID: <ea950637b76b4f43b3031a040d1e5fec@realtek.com>
References: <20261005105249.1281648-1-lilinmao@kylinos.cn>
 <fd3bff0e63304681b9e5f35f2f57e50e@realtek.com>
 <7a8d21bd-3484-4120-abd6-f7290f919b7d@lunn.ch>
 <2bd3886a-da6e-4703-bd7a-9baa32bfd2f4@kylinos.cn>
In-Reply-To: <2bd3886a-da6e-4703-bd7a-9baa32bfd2f4@kylinos.cn>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

TGlubWFvIExpIDxsaWxpbm1hb0BreWxpbm9zLmNuPg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIg
OSwgMjAyNiAzOjE2IFBNDQpbLi4uXQ0KPiBIaSBIYXllcywgQW5kcmV3LA0KPiANCj4gVGhhbmtz
LiBTaW5jZSB0aGUgbmV3ZXIgSUNzIG5vdGlmeSBvbmx5IHdoZW4gdGhlIGxpbmsgc3RhdHVzIGNo
YW5nZXMsIHRoZSBkcml2ZXINCj4gY2Fubm90IHJlbHkgb24gYW5vdGhlciBsaW5rIHVwIG5vdGlm
aWNhdGlvbiBhZnRlciB0aGUgbGluayBoYXMgc2V0dGxlZCwgc28gdjIgY2FuDQo+IGxlYXZlIHRo
ZSBjYXJyaWVyIG9mZiB3aGVuIHRoZSBmaXJzdCByZWFkIHJldHVybnMgdGhlIGxhdGNoZWQgbGlu
ayBkb3duLg0KPiANCj4gQmVmb3JlIHNlbmRpbmcgdjMsIHdoaWNoIGFwcHJvYWNoIHdvdWxkIHlv
dSBwcmVmZXI/IEJvdGggZml4ZWQgdGhlIHByb2JsZW0NCj4gaW4gbXkgdGVzdHMgb24gYW4gUlRM
ODE1M0Igd2l0aCB2Ny4zLXJjNjoNCj4gDQo+IGEpIEtlZXAgY2FycmllciBkZXRlY3Rpb24gb24g
UExBX1BIWVNUQVRVUyBhbmQgcmVhZCBCTVNSIG9uY2UgYmVmb3JlDQo+ICAgICBjYXJyaWVyIG9u
LCBvbmx5IHRvIGNsZWFyIHRoZSBsYXRjaC4gVGhpcyBpcyB0aGUgb3B0aW9uIEkgYXNrZWQNCj4g
ICAgIGFib3V0IG9uIHYxLg0KDQpJIHByZWZlciBvcHRpb24gYSkuIFVzaW5nIFBMQV9QSFlTVEFU
VVMgZm9yIGNhcnJpZXIgZGV0ZWN0aW9uIGlzIHRoZSBhcHByb2FjaA0KcmVjb21tZW5kZWQgYnkg
b3VyIGhhcmR3YXJlIGVuZ2luZWVycywgYW5kIHdlIGhhdmUgdGVzdGVkIGFuZCB2ZXJpZmllZCBp
dC4NCg0KPiBiKSBEZXRlY3QgY2FycmllciBmcm9tIEJNU1IgYW5kIHJlYWQgaXQgYWdhaW4gd2hl
biB0aGUgZmlyc3QgcmVhZA0KPiAgICAgcmV0dXJucyBsaW5rIGRvd24sIGFzIGdlbnBoeV91cGRh
dGVfbGluaygpIGRvZXMgaW4gaW50ZXJydXB0IG1vZGUuDQo+IA0KPiBOZWl0aGVyIGRlcGVuZHMg
b24gYW5vdGhlciBub3RpZmljYXRpb24uIE5laXRoZXIgcmVwb3J0cyBhIHNob3J0IGxpbmsgZHJv
cCB0aGF0DQo+IHJlY292ZXJzIGJlZm9yZSB0aGUgbGluayB3b3JrIHJ1bnM6IHdpdGggYSkgYSBs
YXRlciBzcGVlZCBxdWVyeSBzdGlsbCBzZWVzIHRoZQ0KPiBsYXRjaGVkIGxpbmsgZG93biwgd2l0
aCBiKSB0aGUgbGF0Y2ggaXMgY2xlYXJlZC4NCj4gDQo+IEhheWVzLCBmb3IgYik6IGlzIEJNU1Jf
TFNUQVRVUyByZWxpYWJsZSBhcyB0aGUgY2FycmllciBzb3VyY2Ugb24gYWxsIGNoaXBzDQo+IHN1
cHBvcnRlZCBieSByODE1Mj8NCg0KSeKAmW0gbm90IGZhbWlsaWFyIHdpdGggdGhpcyBwYXJ0LCBz
byBJIG5lZWQgdG8gY29uZmlybSBpdCB3aXRoIG91ciBQSFkgZW5naW5lZXJzLg0KDQpCZXN0IFJl
Z2FyZHMsDQpIYXllcw0KDQo=
