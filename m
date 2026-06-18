Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE633F5A3
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 21:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781818017; cv=none; b=q/ZQRVvVPL25/rLva/qJcUvBRaGq7h5F4F1FKzCEqYIyxjJN2D279yLQEmeCZWR7FoSkPdCcFGpEsOP7VVtendyHIRTXecjfO2hGoxfRVvvNPzPwUMcOLTJq011xa0ribwIG24Eda2dFdwbw4TPpv690seSIX/3nfaXQS3bokkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781818017; c=relaxed/simple;
	bh=tf39Gx+71AHzKOEChBQsnNZgcN5v82vwvgftT47VpxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PeJhjup60dK6GunXzhGmhc2rEd3Gs/QOFkYf+fbEiIHuxqpsOxjPLVoANiWwav8laYbd46SYDoJfNI2ikoauInzTK7ElskRtxGlCV0Sp0CReG65QxxZY0lJTq4446D2iWP3lQtdfpQp2uzwwzyl0ZfvL2u0qlMMlUcjwGeqUVBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=giOdsZ+K; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="giOdsZ+K"
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3191A2C083F;
	Fri, 19 Jun 2026 09:26:45 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1781818005;
	bh=tf39Gx+71AHzKOEChBQsnNZgcN5v82vwvgftT47VpxM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=giOdsZ+KfRikxC0muskyGRjojTCbO5FKFp20Qj+aFl7QiZc6b6LlbcEdCYiiuOaF7
	 CrrdCTTLPF21trPWa06y+9RM0kgbklFyIyMC1x4ICcjljosFPxfkLlT55yxslVNFwF
	 xT5MkkJ32U6TTvsUdpVnB3gKTqFu3DLgoDZVnYmfw+t5mhuIQtFHQkj4D327VeOQRE
	 PFxp17nTWibQa/1hzrPSBHsn/MOnW5685BiUu70dvtPoSchPJ0YZGRcAp7T/pfI1sW
	 klbxG4SUliwk0CupMmTJchpj7lZTMaCYO81e9ztV+L2N8LIbIhEbEckG+DC6oNA4qP
	 DdvQB9uLF0K0A==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a3462950001>; Fri, 19 Jun 2026 09:26:45 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 19 Jun 2026 09:26:44 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Fri, 19 Jun 2026 09:26:44 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andi Shyti <andi.shyti@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] i2c: mpc: Fix timeout calculations
Thread-Topic: [PATCH v1 1/1] i2c: mpc: Fix timeout calculations
Thread-Index: AQHc/zG12vHm7Fd8uk2zvTPPC3yYsbZECsQA
Date: Thu, 18 Jun 2026 21:26:44 +0000
Message-ID: <874ab342-fd2c-448f-996f-6af7604c0024@alliedtelesis.co.nz>
References: <20260618144934.3249950-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260618144934.3249950-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <935E9BD2BB0D5C41A608FC0E33A0A65C@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=TI3mSEla c=1 sm=1 tr=0 ts=6a346295 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=JZ2mbyU0Sn6zIN7-TMQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

SGkgQW5keSwNCg0KT24gMTkvMDYvMjAyNiAwMjo0OSwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0K
PiBPTiB0aGUgZmlyc3QgZ2xhbmNlIHRoZSBoYXJtbGVzcyBjbGVhbnVwIG9mIHRoZSBkcml2ZXIg
ZG9lcyBub3RoaW5nIGJhZC4NCj4gSG93ZXZlciwgYXMgdGhlIG9wZXJhdG9yIHByZWNlZGVuY2Ug
bGlzdCBzdGF0ZXMgdGhlICcqJyAobXVsdGlwbGljYXRpb24pDQo+IGFuZCAnLycgZGl2aXNpb24g
b3BlcmF0b3JzIGhhdmUgb3JkZXIgNSB3aXRoIGxlZnQtdG8tcmlnaHQgYXNzb2NpYXRpdml0eQ0K
PiB0aGUgKj0gaGFzIG9yZGVyIDE3IGFuZCBhc3NvY2lhdGl2aXR5IHJpZ2h0LXRvLWxlZnQuIEl0
IHdvdWxkbid0IG5vdCBiZQ0KPiBhIHByb2JsZW0gdG8gcmVwbGFjZQ0KPg0KPiAJZm9vID0gZm9v
ICogSFogLyAxMDAwMDAwOw0KPg0KPiB3aXRoDQo+DQo+IAlmb28gKj0gSFogLyAxMDAwMDAwOw0K
Pg0KPiBpZiBIWiBjb25zdGFudCBpcyBpbiBIZXJ0ei4gVGhlIHByb2JsZW0gaXMgdGhhdCBpbiB0
aGUgTGludXgga2VybmVsIEhaIGlzDQo+IGRlZmluZWQgaW4gamlmZnkgdW5pdHMsIHdoaWNoIGlz
IG9yZGVyIG9mIG1hZ25pdHVkZSBzbWFsbGVyIHRoYW4gYSBtaWxsaW9uLg0KPiBUaGF0J3Mgd2h5
IG9wZXJhdG9yIHByZWNlZGVuY2UgaGFzIGEgY3J1Y2lhbCByb2xlIGhlcmUuIEZpeCB0aGUgcmVn
cmVzc2lvbg0KPiBieSByZXZlcnRpbmcgcHJlLW9wdGltaXplZCBjYWxjdWxhdGlvbnMuDQo+DQo+
IEZpeGVzOiBiZTQwYTNhZTcxOWYgKCJpMmM6IG1wYzogVXNlIG9mX3Byb3BlcnR5X3JlYWRfdTMy
IGluc3RlYWQgb2Ygb2ZfZ2V0X3Byb3BlcnR5IikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0Bs
aW51eC5pbnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5wYWNr
aGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQoNClRoYW5rcy4NCg0KPiAtLS0NCj4gICBkcml2ZXJz
L2kyYy9idXNzZXMvaTJjLW1wYy5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVz
c2VzL2kyYy1tcGMuYyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtbXBjLmMNCj4gaW5kZXggMjhj
NWM1YzFmYjdhLi5hMjFmYTQ1YmQ2NGMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaTJjL2J1c3Nl
cy9pMmMtbXBjLmMNCj4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1tcGMuYw0KPiBAQCAt
ODQ0LDcgKzg0NCw3IEBAIHN0YXRpYyBpbnQgZnNsX2kyY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1f
ZGV2aWNlICpvcCkNCj4gICAJCQkJCSAgICAgICJmc2wsdGltZW91dCIsICZtcGNfb3BzLnRpbWVv
dXQpOw0KPiAgIA0KPiAgIAlpZiAoIXJlc3VsdCkgew0KPiAtCQltcGNfb3BzLnRpbWVvdXQgKj0g
SFogLyAxMDAwMDAwOw0KPiArCQltcGNfb3BzLnRpbWVvdXQgPSBtcGNfb3BzLnRpbWVvdXQgKiBI
WiAvIDEwMDAwMDA7DQo+ICAgCQlpZiAobXBjX29wcy50aW1lb3V0IDwgNSkNCj4gICAJCQltcGNf
b3BzLnRpbWVvdXQgPSA1Ow0KPiAgIAl9IGVsc2Ugew==
