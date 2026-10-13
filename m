Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246374E36C8;
	Tue, 13 Oct 2026 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887464; cv=none; b=rYRYMbShR7WFgGZeEdCS08382cUmw0OzwEljlyDV4Flwz/j2mUCRIlhaYnPexeUQQRUvrsELITP1Ub+xVQDhIqq40pRkCGLTLN2bGIxX6FustWIVyL5fWxGW77Ls0POLp4tiNMfUDeLRU1CuNXqBU7Wt3fKLXuN8/gzPAnEE6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887464; c=relaxed/simple;
	bh=ph/I59TWPz3ZRmhDZlqj4Tr3vQPtkuQGStXlC1cwwvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uiop362LqRZXVWDCJXMvmegzVSruGxlE5iDYFCGE2OMZKtWRTtmExUTiYTjTQXLcY9yqVu5iJrPO/3YeyOWpHJ6O9adhIlcKRHD2hAxi3Qa3N54JNlejn1pfIzismAtxekvOAPmXbwNrZpBQwgk+1vqYR2FRAKqOQyMomkrkLXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HxzVHtmf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HxzVHtmf"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69DAUWWU0454001, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791887432; bh=ph/I59TWPz3ZRmhDZlqj4Tr3vQPtkuQGStXlC1cwwvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HxzVHtmfIxm7z7UlMp2FyJ0NbRG7e5y/rc1RLEQJIYq2s0FYiD1JLh9Kvu9sZaPkD
	 7F5h+X36kOyTocntTlUXqNzoZ1XdjAabE5wUuc6vnetY1gnCepESZ6KEoazIHjTly8
	 sDpGM3nFOqv7uihiRMi79WGslhNmkssDO7oeDj4JMQYd5TpfqPJL59VW23GbjjMhU1
	 zMspjukbN/BRUFhY/X2bxpkTDDpdwj3SEvC6blcl59TbEomHoBxy8sIGgQGtX6JdMT
	 tvmNcHwmlpAA9ZACKipVX1v9/azBOiy+GWBnUQEe5+tjnquUv+zAL7IyJi4+0fBEE/
	 BtCtimGajxzDw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69DAUWWU0454001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Oct 2026 18:30:32 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 18:30:32 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::f36f:a844:4916:93f2%9]) with mapi id
 15.02.2562.049; Tue, 13 Oct 2026 18:30:32 +0800
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
Thread-Index: AQHdVLexra3FlE5swkqMdmzmTHCGJ7bwLnWg///8UICABCHSAIAAVXKAgAWlrQCAAPX7AA==
Date: Tue, 13 Oct 2026 10:30:32 +0000
Message-ID: <0573f6c64cac4bdd83388cb1bd76583a@realtek.com>
References: <20261005105249.1281648-1-lilinmao@kylinos.cn>
 <fd3bff0e63304681b9e5f35f2f57e50e@realtek.com>
 <7a8d21bd-3484-4120-abd6-f7290f919b7d@lunn.ch>
 <2bd3886a-da6e-4703-bd7a-9baa32bfd2f4@kylinos.cn>
 <591ca604-b296-4469-94b5-957d9ba45ae4@lunn.ch>
 <c32ac5e1-ecbe-4857-b36f-cd0cb1f54f90@kylinos.cn>
In-Reply-To: <c32ac5e1-ecbe-4857-b36f-cd0cb1f54f90@kylinos.cn>
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

TGlubWFvIExpIDxsaWxpbm1hb0BreWxpbm9zLmNuPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVy
IDEzLCAyMDI2IDEwOjM2IEFNDQpbLi4uXQ0KPiBIaSBBbmRyZXcsDQo+IA0KPiBUaGFua3MuIElu
IHRlc3RzIG9uIG15IFJUTDgxNTNCLCBkb3duIGFuZCB1cCBub3RpZmljYXRpb25zIHdlcmUgYWJv
dXQNCj4gMy4xIHMgYXBhcnQgYWZ0ZXIgYSBxdWljayBjYWJsZSByZXBsdWcsIGFuZCBhYm91dCAz
LjQgcyBhcGFydCBhZnRlciBldGh0b29sIC1yLiBBDQo+IGRvdWJsZSByZWFkIHNob3VsZCBzdGls
bCByZXBvcnQgZG93biBpZiB0aGUgbGluayB3b3JrIHJ1bnMgZHVyaW5nIHRoYXQgaW50ZXJ2YWws
DQo+IGJ1dCBJIGhhdmUgbm90IHZlcmlmaWVkIHRoaXMgZGlyZWN0bHkuDQo+IFRoZXNlIHJlc3Vs
dHMgZG8gbm90IGNvdmVyIHNob3J0ZXIgbGluayBpbnRlcnJ1cHRpb25zIG9yIG90aGVyIGNoaXBz
Lg0KPiANCj4gU2luY2UgdGhpcyBmaXhlcyBhIHJlZ3Jlc3Npb24gZm9yIG5ldCBhbmQgc3RhYmxl
LCB3b3VsZCB5b3UgYWNjZXB0IGEpIHRoZXJlLA0KPiBrZWVwaW5nIFBMQV9QSFlTVEFUVVMgYW5k
IHJlYWRpbmcgQk1TUiBvbmNlIGJlZm9yZSBhbiBvZmYtdG8tb24gY2Fycmllcg0KPiB0cmFuc2l0
aW9uLCBhbmQgbW92aW5nIGNhcnJpZXIgZGV0ZWN0aW9uIHRvIEJNU1Igd2l0aCBwZXItY2hpcCBo
YW5kbGluZyBhcyBhDQo+IGZvbGxvdy11cCBmb3IgbmV0LW5leHQsIG9uY2UgdGhlIGNoaXAgYmVo
YXZpb3VyIGlzIGtub3duPw0KPiANCj4gSGF5ZXMsIHRvIGJ1aWxkIHRoYXQgbGlzdDogd2hpY2gg
SUNzIG5vdGlmeSBvbmx5IG9uIGxpbmsgY2hhbmdlcz8gQW5kIG9uIGFueSBvZg0KPiB0aGVtLCBk
b2VzIHJlYWRpbmcgQk1TUiwgd2hpY2ggY2xlYXJzIHRoZSBsYXRjaGVkIGxpbmsgZG93biwgdHJp
Z2dlciBhbm90aGVyDQo+IG5vdGlmaWNhdGlvbj8gVGhlIHNpbmdsZSByZWFkIGRlcGVuZHMgb24g
dGhhdC4gQmlyZ2VyIHRlc3RlZCB2MiBvbiBhbiBSVEw4MTU3DQo+IGFuZCBhbiBSVEw4MTUzQSB3
aXRob3V0IHByb2JsZW1zLCBzbyBpdCB3b3VsZCBhbHNvIGhlbHAgdG8ga25vdyBob3cgdGhlDQo+
IFJUTDgxNTcgbm90aWZpZXMuDQoNClNvbWUgdXNlcnMgaGF2ZSBjb21wbGFpbmVkIGFib3V0IHRo
ZSBwZXJpb2RpYyBub3RpZmljYXRpb25zLCBzbyB3ZSBwbGFuIHRvIG1vZGlmeSB0aGUgZHJpdmVy
IGFjY29yZGluZ2x5Lg0KUlRMODE1NiBhbmQgbGF0ZXIgY2hpcHMgd2lsbCBub3RpZnkgdGhlIGRy
aXZlciBvbmx5IHdoZW4gdGhlIGxpbmsgc3RhdGUgY2hhbmdlcy4gDQpUaGUgV2luZG93cyBkcml2
ZXIgYWxyZWFkeSB1c2VzIHRoaXMgYmVoYXZpb3IuDQpJbiBhZGRpdGlvbiwgSSBkb27igJl0IGJl
bGlldmUgdGhhdCBjbGVhcmluZyB0aGUgbGF0Y2hlZCBsaW5rLWRvd24gc3RhdHVzIHdpbGwgdHJp
Z2dlciBhbm90aGVyIG5vdGlmaWNhdGlvbi4NCg0KDQpCZXN0IFJlZ2FyZHMsDQpIYXllcw0KDQo=
