Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793966920;
	b=miCByUb3tOTFXZU6dctNI6u/N8fosxUNm7179NIZLLBzOzAh/e4utFYFXCQX5eSURbDX
	 vgoz36HhYCTEIMiwhYkk8cXAGoVaLwDCmlxNhtCiXz52Lx8s2ifPQntW/FSXmB5n36f/Y
	 b2V/l2tgbdi/3byyzECNyH+Zg1CWflUtaFOO+/JAqyMYTZBG6EycmNqY2wCxMHmHu0eGN
	 BezqGIHIoTYa6RT6t2msc9jjc7fyHDLYU7azOchlDGOLD50nY2uCcEAny0vGUQMgcLTRz
	 XBxo0V3Zb1SbJ/+0nGAU8SblM0jnYUF4rik8oHYN+IuKwFmKPWdy7ZeoWRvP9mHeLFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793966920;
	h=DMARC-Filter:DKIM-Signature:EX-QQ-RecipientCnt:X-QQ-GoodBg:X-QQ-SSF:
	 X-QQ-FEAT:X-QQ-BUSINESS-ORIGIN:X-QQ-Originating-IP:X-Originating-IP:
	 X-QQ-STYLE:X-QQ-mid:From:To:Cc:Subject:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:Date:X-Priority:Message-ID:X-QQ-MIME:
	 X-Mailer:X-QQ-Mailer:References:In-Reply-To:X-QQ-ReplyHash:
	 X-BIZMAIL-ID:X-Address-Ticket:X-QQ-SENDSIZE:Received:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=RKL+Jq6O2pfebghYB1j2lq21xSpMlV0Qw0R3bOf7GlA=;
	b=GRc7TazdAyuhF+IOg4IuraW1fr/0UrZJzndUaormKlPUBAOrfkZjw4z3UdOABPD0j/Aa
	 m+yNrz8TwUQp8FiaPgbRYrhBDg4zGSOyIQsx4n8QGmHS10kQG/7Knh/xnqYdoq0ErKzT4
	 OQVD2bbJC1Q6rcq73hqEPnTm5zGhd3OhYbwlqCbb7xmpqIg47N/DAaFoU1/Ygv+l4hEDU
	 BV3DNqbceJGpNxDwI8HAXO+PB80wbOXy3XKTX1XVzsiSxaEATvvRX6fAIJ623HBTCaQSR
	 cxMg4MRHuUlrgRGfBO9ARNF9eIt0ms+DZF3AfcB5+gHVSGmsp9WljAthWu1x2gRCZSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=iLeoVZ0D;
	arc=none smtp.remote-ip=54.254.200.128
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077CB606A32F
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 12:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 077CB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=iLeoVZ0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1793966871;
	bh=RKL+Jq6O2pfebghYB1j2lq21xSpMlV0Qw0R3bOf7GlA=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=iLeoVZ0Dynjy53D8PSDn+bM44qQzig84PJJ41N10+vgcmxbtlhwYPZF9qLW5wL6E5
	 BFg3YR5ShU9NEPkSqR+CYlYwAWlaAlrjGznqfxLNayvUgYsvfBjQ6MT2x1c+klhtob
	 1CO+1XebrAdJNktTBgCdS86myHrVEvy+CrUlSOmI=
EX-QQ-RecipientCnt: 7
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqRO9CuWAcjeqco6/xKk62mDx0R4/xCnRF0=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: bUHm4PH7GlVFcTGS3fAfhOCI6XVLqGMrh2Zb3jI7J6c=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1793966865tbb17d3fa
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?SmFuaSBOaWt1bGE=?=" <jani.nikula@linux.intel.com>, "=?utf-8?B?am9vbmFzLmxhaHRpbmVu?=" <joonas.lahtinen@linux.intel.com>, "=?utf-8?B?aW1yZS5kZWFr?=" <imre.deak@intel.com>, "=?utf-8?B?am91bmkuaG9nYW5kZXI=?=" <jouni.hogander@intel.com>
Cc: "=?utf-8?B?aW50ZWwtZ2Z4?=" <intel-gfx@lists.freedesktop.org>, "=?utf-8?B?aW50ZWwteGU=?=" <intel-xe@lists.freedesktop.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH] drm/i915/display: Don't drop the async-put delay on self-requeue
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 6 Nov 2026 20:07:45 +0800
X-Priority: 3
Message-ID: <tencent_4C927CB66A067D2368DD192E@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <134A26B6BCDD3C9C+20261104053910.1065103-1-guanwentao@uniontech.com>
	<a2b152662d219f9be0861e63ddbb78dd1971dc2a@intel.com>
In-Reply-To: <a2b152662d219f9be0861e63ddbb78dd1971dc2a@intel.com>
X-QQ-ReplyHash: 3438078101
X-BIZMAIL-ID: 14064812400548868991
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Fri, 06 Nov 2026 20:07:46 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MIHPxziOyMXedoTZoUSZeQDVnMyw46BT4LEQMHI+t9jwJAKZyzBLxPZV
	jndnBOMO4jn/dzENGOQDS42AYhShNAwvMJqMKz+jaGHEEc1WQ4IaTdaTp8nZNdOkkNFelq4
	GVv69kKr9wezKqG7LjApvbhVW2heffBTCFzQ7aDCivpVOemSGxz1Veq/waquEWTpDTyIBdE
	y/D6mIXlga8b8rFdAWi5ZLyaG/BEdMrAyXUqG7F3tmCKJONMb1pxrdldgl7KxGaJUzd3UYI
	Gnw6jDGAvGvPJgDs/ZihOxPRDD98eWoh4SnMa4aDUrN4wKrWcMqclQFUF5dtR2C20NZoEN/
	8Ig48HjWWYstv5GPRrXjB4HbsRttHvPGr+dBu8ZM6P/EFWEx73pUIh2Vwfy0Pd8X3XBAaBo
	uaF8feX6KLLi8bIokT/ZN7rUZsUWpIyjtLf7mxSRN4RPpYigpL61y+3cTnbUTeAMv152L0w
	XZNkRJKno3/EFNDnX8vBHBq5cukGmaHjE2MJAGAdPzIjbx818lLzpXoBvVXD7QPXt0ootpJ
	8eOH3f5KyfCFfgZZDMsgvRipi3REJlJ3pL7GOf//GXfv5VAM/eT5PECmQAOBbbNOm5ln1hE
	gRRN3tcxWs7S9Z9GRFs5uqr4xwyqZUHhutWLCY98+foBn1a8zD8is5KVR2cVnUdF0q0xZ8A
	GA3ekm4cpIYkt0K0euSx01fh1eJJTfyMcU8Ie7r5Axxy7IpoELxFx15tFEKe6/0UNn6k8ZD
	UEzOOVC5K2lLSsg87pHYCTTZ5R4hm0vPdmYPsK1zSg60I5FJHP9b6veYfO0qqEbwKNX7WU7
	ep1KRwkdTtxRrkzjjlXwoE1Xc4XsyzkP2vRS6haxKSiv5pyIySS3h/JuQ1iiQcvkXU0T52W
	kFbD3zrU52ah6YUtN6ToqSG+yXAmRT6MaLbHRE1DTrFYEKAewq+6KLhc4vpVwNG0zKQWCy0
	ie44kXoiOZa37O4UcQMqsijOEP4p5DaQ3SDADKZPr2jIEZkJ/xPc2qs4l7QSuB6bqKLOHFZ
	XMoJ9aFM4z4xeS591Atk9K4F68MMb5SzxkrEcC3CGKV/BzHQ1j/2S/KXka68kvuVuq43Kec
	hCeetZmxgvoHf+sQw36zEHxOxCXNN8DKQ==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

SGksDQoNCj4gT24gV2VkLCAwNCBOb3YgMjAyNiwgV2VudGFvIEd1YW4gPGd1YW53ZW50YW9A
dW5pb250ZWNoLmNvbT4gd3JvdGU6DQo+ID4gY2FuY2VsX2FzeW5jX3B1dF93b3JrKCkgYWxz
byBjbGVhcnMgYXN5bmNfcHV0X25leHRfZGVsYXksIHNvIG1vdmluZyBpdA0KPiA+IGFoZWFk
IG9mIHRoZSByZXF1ZXVlIGluIGludGVsX2Rpc3BsYXlfcG93ZXJfcHV0X2FzeW5jX3dvcmso
KSBtYWtlcyB0aGUNCj4gPiByZXF1ZXVlIGFsd2F5cyB1c2UgYSB6ZXJvIGRlbGF5LiBUaGF0
IGRpc2NhcmRzIHRoZSBkZWxheSBhY2N1bXVsYXRlZCBieQ0KPiA+IGNvbmN1cnJlbnQgYXN5
bmMgcHV0cywgaW5jbHVkaW5nIHRoZSAxNyBtcyBEQy1zdGF0ZSBhbnRpLXRvZ2dsZSBkZWxh
eQ0KPiA+IHJlcXVlc3RlZCBmb3IgUE9XRVJfRE9NQUlOX0RDX09GRi4NCj4gPg0KPiA+IFVz
ZSBjYW5jZWxfZGVsYXllZF93b3JrKCkgZGlyZWN0bHkgdG8gY2FuY2VsIHRoZSBzdGFsZSBp
bnN0YW5jZSB3aXRob3V0DQo+ID4gY2xlYXJpbmcgdGhlIGRlbGF5LCBhbmQgY2xlYXIgdGhl
IGRlbGF5IG9ubHkgYWZ0ZXIgdGhlIHJlcXVldWUgaGFzDQo+ID4gY29uc3VtZWQgaXQuDQo+
ID4NCj4gPiBGaXhlczogMzBjYTYzNjViYjQyICgiZHJtL2k5MTU6IEZpeCBhc3NlcnQgb24g
cGVuZGluZyBhc3luYy1wdXQgcG93ZXIgZG9tYWluIHdvcmsgd2hlbiBpdCByZXF1ZXVlcyBp
dHNlbGYiKQ0KPiA+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2Ni4xMSsNCj4g
PiBTaWduZWQtb2ZmLWJ5OiBXZW50YW8gR3VhbiA8Z3VhbndlbnRhb0B1bmlvbnRlY2guY29t
Pg0KPiANCj4gSG93IGRpZCB5b3UgZmluZCB0aGlzPw0KRHVyaW5nIGEgc3RhYmxlIGJ1Z2Zp
eCBiYWNrcG9ydCB3b3JrLCBmb3VuZCBieSBnaXRodWIgY29waWxvdCBtYXgoZ3B0LTYuMS1z
b2xbUmVhc29uaW5nRWZmb3J0PXhoaWdoXSkuDQoNCj4gSXMgdGhlcmUgYSBidWcgcmVwb3J0
IGFib3V0IHRoaXM/DQpKdXN0IHNlZTogaHR0cHM6Ly9naXRodWIuY29tL2RlZXBpbi1jb21t
dW5pdHkva2VybmVsL3B1bGwvMjIzOSNkaXNjdXNzaW9uX3I0NDYzNzE4ODgzDQoNCj4gSG93
IGRpZCB5b3UgdGVzdCB0aGlzPw0KUmV2aWV3IGFnYWluLCBidWlsZCBhZ2FpbiwgaW50ZWdh
dGlvbiBieSBhbm90aG9yIG9uZS4NCkl0IGlzIG5vdCB0aGUgb3JpZ2luYWwgYnVnIHdlIG1l
dCwgdGhlIGJ1ZyBzb3ZsZWQgYnkgYmFja3BvcnQgbWFueSBpOTE1IHVwZGF0ZSBjb21taXRz
IGFzIHRoZW0gaW4gbWFpbmxpbmUuDQoNCkJScw0KV2VudGFvIEd1YW4=

