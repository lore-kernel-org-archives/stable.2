Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6C83E0088;
	Mon, 19 Oct 2026 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792411980; cv=none; b=LHijfHItWbSkrea0XW23jAvQOoUZdzLasoP3ATvCUBjGSq2IPNK0BaLya3WFxXO76/69sHxPqMLpdgpiimV1oPbhLPNWr7t25uvUEIcSH2+aKmgM3xu2MTirak2lnPf9t4PXUaA2Jr0KIp5BTCljMCWlyqIi/nARlywqB5JFNEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792411980; c=relaxed/simple;
	bh=Y3J17ScURVLMgamwb8LB4OcOXkKMkuQtLh0AIehEdpY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YVYCinH+o9PdYxBBCq2BQUuNVENeYau5yLpMZQIWCKMzDs+ejdjCXB7s2gMuTbbofyJMh3uhg+pueURsMtZfaWTsLaL/iE75cO3nin4um8Ioc4E9bbhuc7IggJIGVl71SnF6KtY8yvykZA4jVbP7ELamcHgBHerVqAvW/oSVmOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=lvzrf4da; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="lvzrf4da"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69JCC62X01879690, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1792411926; bh=Y3J17ScURVLMgamwb8LB4OcOXkKMkuQtLh0AIehEdpY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=lvzrf4davbB2v/FdvT9F/Ss0DdNTxKejmC+krgh6aHe1Xg2ZmL8yKX7MSQ6FKJoMe
	 uAlvxWrC71OYwlbn0Kt/1B/0MMAoNN00ZyrDbq22/62rwZVyRaiciJ5/PGAFrU/gKJ
	 2xGF/VXW4woeajCx4bDgYN6F+1nvraYS67HiR8+MIvgR4C+z1hlxBq7knQLoRAYG5B
	 GPYN+ObZ3IZLdFRRoXwrodXthAkCX049flzFw4YWClTtHYM630M12+MdCXLSK81Q3n
	 vkIhTUGQZNSTOqJooGlFmFvjE3eRRiW753wPI0SX/qiUfL5+QRqfMJNZ5gpuYc+HcQ
	 Eiy4sQj4iGi9w==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69JCC62X01879690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 19 Oct 2026 20:12:06 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 20:12:06 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::f36f:a844:4916:93f2%9]) with mapi id
 15.02.2562.049; Mon, 19 Oct 2026 20:12:06 +0800
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
Thread-Index: AQHdVLexra3FlE5swkqMdmzmTHCGJ7bwLnWg///8UICABCHSAIAAVXKAgAaA7TCAAZqtgIACjy+AgAWOExA=
Date: Mon, 19 Oct 2026 12:12:06 +0000
Message-ID: <04de94998df1449b945b8847204980d2@realtek.com>
References: <20261005105249.1281648-1-lilinmao@kylinos.cn>
 <fd3bff0e63304681b9e5f35f2f57e50e@realtek.com>
 <7a8d21bd-3484-4120-abd6-f7290f919b7d@lunn.ch>
 <2bd3886a-da6e-4703-bd7a-9baa32bfd2f4@kylinos.cn>
 <591ca604-b296-4469-94b5-957d9ba45ae4@lunn.ch>
 <16d9caec96e8449d88ac456e8512f08b@realtek.com>
 <06aaa778-ad49-4e30-b1c6-a7dc68718a21@lunn.ch>
 <cf64cf73-aa31-4a78-82c4-a9a6c866d7cf@kylinos.cn>
In-Reply-To: <cf64cf73-aa31-4a78-82c4-a9a6c866d7cf@kylinos.cn>
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
MTYsIDIwMjYgMzoxNiBQTQ0KWy4uLl0NCj4gT3B0aW9uIGEpIGFkZHJlc3NlcyBvbmx5IHRoZSBz
cGVlZCByZWdyZXNzaW9uLiBJdCBrZWVwcyB0aGUgZXhpc3RpbmcNCj4gUExBX1BIWVNUQVRVUyBj
YXJyaWVyIGRldGVjdGlvbiBhbmQgZG9lcyBub3QgaW1wcm92ZSByZXBvcnRpbmcgb2Ygc2hvcnQg
bGluaw0KPiBkcm9wcyB0aGF0IHJlY292ZXIgYmVmb3JlIHRoZSBsaW5rIHdvcmsgcnVucy4NCj4g
DQo+IEkgcGxhbiB0byBwb3N0IGEpIGFzIHYzIGZvciBuZXQgbmV4dCB3ZWVrLCBrZWVwaW5nIHRo
YXQgc2NvcGUgZXhwbGljaXQuIFBsZWFzZSBsZXQNCj4gbWUga25vdyBpZiB5b3Ugc2VlIGEgcHJv
YmxlbSB3aXRoIHRoaXMgYXBwcm9hY2guDQoNCkkgdGVzdGVkIHRoZSBmb2xsb3dpbmcgcGF0Y2gs
IGFuZCBpdCB3b3JrcyBmb3IgbWUuIEl0IG1pZ2h0IGJlIHVzZWZ1bCBhcyBhIHJlZmVyZW5jZS4N
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3VzYi9yODE1Mi5jIGIvZHJpdmVycy9uZXQvdXNi
L3I4MTUyLmMNCmluZGV4IGY2MTY4NjQzMzAzMS4uMzk4ZDM1ZjZmYjdiIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9uZXQvdXNiL3I4MTUyLmMNCisrKyBiL2RyaXZlcnMvbmV0L3VzYi9yODE1Mi5jDQpA
QCAtNjk3OSwxMSArNjk3OSw4IEBAIHN0YXRpYyB2b2lkIHNldF9jYXJyaWVyKHN0cnVjdCByODE1
MiAqdHApDQogew0KIAlzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2ID0gdHAtPm5ldGRldjsNCiAJ
c3RydWN0IG5hcGlfc3RydWN0ICpuYXBpID0gJnRwLT5uYXBpOw0KLQl1MTYgc3BlZWQ7DQotDQot
CXNwZWVkID0gcnRsODE1Ml9nZXRfc3BlZWQodHApOw0KIA0KLQlpZiAoc3BlZWQgJiBMSU5LX1NU
QVRVUykgew0KKwlpZiAocjgxNTJfbWRpb19yZWFkKHRwLCBNSUlfQk1TUikgJiBCTVNSX0xTVEFU
VVMpIHsNCiAJCWlmICghbmV0aWZfY2Fycmllcl9vayhuZXRkZXYpKSB7DQogCQkJdHAtPnJ0bF9v
cHMuZW5hYmxlKHRwKTsNCiAJCQluZXRpZl9zdG9wX3F1ZXVlKG5ldGRldik7DQpAQCAtNzAwOSw2
ICs3MDA2LDExIEBAIHN0YXRpYyB2b2lkIHNldF9jYXJyaWVyKHN0cnVjdCByODE1MiAqdHApDQog
CQkJdGFza2xldF9lbmFibGUoJnRwLT50eF90bCk7DQogCQkJbmV0aWZfaW5mbyh0cCwgbGluaywg
bmV0ZGV2LCAiY2FycmllciBvZmZcbiIpOw0KIAkJfQ0KKw0KKwkJaWYgKHJ0bDgxNTJfZ2V0X3Nw
ZWVkKHRwKSAmIExJTktfU1RBVFVTKSB7DQorCQkJc2V0X2JpdChSVEw4MTUyX0xJTktfQ0hHLCAm
dHAtPmZsYWdzKTsNCisJCQlzY2hlZHVsZV9kZWxheWVkX3dvcmsoJnRwLT5zY2hlZHVsZSwgMCk7
DQorCQl9DQogCX0NCiB9DQoNCg0KQmVzdCBSZWdhcmRzLA0KSGF5ZXMNCg0K
