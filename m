Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.204.34.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795070439;
	b=CVrf5eEuKEVbnwODp1ucycsOmEIQ4cGi8Qql2irnf1POaXpk906ru5VWxkNV7x9pSdWY
	 MEwk+mopHXjB/9TvEOjvLlZQcdgLRdkFihVGETsxoAVOpENl/SLpo5JK4xmgqJnCqn5jK
	 t1EOQhDQK9FBUI9e9aQVtPPCgNfjFo2/r1OpxGMH5e+VI0Go3xAuL5Vn58nXaUT64vHdX
	 XNrAFosAd22iH8mAxLoiqO49F62MMRh0VZ/6qv618zkZjeGPktAF+ryfgWgP3RiYBjDlH
	 ldW67m6CfY17LIDwADjgIe7TmsL+TpzEgx0PLcArG4eQJwOqZnakyqAe30OKqVV42gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795070439;
	h=DMARC-Filter:DKIM-Signature:EX-QQ-RecipientCnt:X-QQ-GoodBg:X-QQ-SSF:
	 X-QQ-FEAT:X-QQ-BUSINESS-ORIGIN:X-QQ-Originating-IP:X-Originating-IP:
	 X-QQ-STYLE:X-QQ-mid:From:To:Cc:Subject:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:Date:X-Priority:Message-ID:X-QQ-MIME:
	 X-Mailer:X-QQ-Mailer:References:In-Reply-To:X-QQ-ReplyHash:
	 X-BIZMAIL-ID:X-Address-Ticket:X-QQ-SENDSIZE:Received:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=AwsLghpy1yPpOZnLIXZoveOlFux3x91/YWYqiaFzdMQ=;
	b=SpLvtQj5bUxp9ydqA2AeRFWy04r7HxMhkpi73QQ2+XFrw+XdNVAZUoHZaJIhNvgOgiuR
	 OVz71mPxABPWOJ/BHA/8U4TUHF+kAsYKP186c/14Sy6t0MWTfylI36lf0mCe1DDEpi4k0
	 Qj3WNnmmmVaTIBRcTTaV+Nnte+DLT50mebbmqhY75eMWa4k7ZfzabCnNEghOeUyXu9MPy
	 Jz17f1wV+cxfkutEEqfzeKSYWiMD9k18Pu2SQocEbJDvZvLTCik6bHpeMDAbLs+sH78JE
	 0kKzCmylQLp0Z6IjT98IEweqYNigf6ijjYO0xbWI6HQnCpQSctxQPX/MmZyjZ2GL2xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uniontech.com;
	spf=pass smtp.mailfrom=uniontech.com;
	dkim=pass header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=mt0cdyGr;
	arc=none smtp.remote-ip=54.204.34.129
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FAC606A320;
	Thu, 19 Nov 2026 06:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98FAC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=mt0cdyGr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1795070418;
	bh=AwsLghpy1yPpOZnLIXZoveOlFux3x91/YWYqiaFzdMQ=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=mt0cdyGrOp/qTmojcMWJq5xhdycxAia4USXkM0+2v3IbEeRsOImycxQYVfWZ0v3U5
	 YHIVUmcNy+o2+PGputj6xcbDO1PMnHHwbrezjVzBmPuKUWzH3RCXKKMScfNhVzV5UG
	 7ArHU2OZG8DcVVRShE28JAfqO06IDSRDd2jZEr1Q=
EX-QQ-RecipientCnt: 7
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqRO9CuWAcjeqco6/xKk62mDx0R4/xCnRF0=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: 7UaYbNymNysPlrBN3u5SlIoma/GkM9A9zUI/5dVGGpE=
X-QQ-STYLE: 
X-QQ-mid: lv3gz7b-6t1795070416t309a1a73
From: "=?utf-8?B?5YWz5paH5rab?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?S3VuaXl1a2kgSXdhc2hpbWE=?=" <kuniyu@google.com>
Cc: "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?bmNhcmR3ZWxs?=" <ncardwell@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bWVsb3R0aQ==?=" <melotti@google.com>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH net] tcp: cancel cloned request timers without waiting
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
Date: Thu, 19 Nov 2026 14:40:16 +0800
X-Priority: 3
Message-ID: <tencent_39F082F22E8C4DA7199FAC72@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <0907415D86226AEA+20261119025619.3485277-2-guanwentao@uniontech.com>
	<av6VHCsEnrAMOx0M@google.com>
In-Reply-To: <av6VHCsEnrAMOx0M@google.com>
X-QQ-ReplyHash: 2729464397
X-BIZMAIL-ID: 4085145250553562557
X-Address-Ticket:version=;type=;ticket_id=;id_list=;display_name=;session_id=;
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Thu, 19 Nov 2026 14:40:17 +0800 (CST)
Feedback-ID: lv:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MvyKdZyVtFx37N1CZ+q1CdC53x/1NSR/mraI9xSyV+IMYhzZVndBOGIm
	L9Hx0jTqIaVtZAg2TMrnSY+ooQv0SXq3QsFYsjpeqkpKCh5zL428AYdzB9DrMJkx/WAFQ9f
	FcnI6xgsktf2Oza1Fm/l4Z8i3lazAnFdFZ1lYkbb0HzIoIWZmrMKi3j9yjJKjS85XDNOVEu
	xTWkF+cYSf1Q6aBH7wuJ/PY4RCRxitfn2FM8hLkG5M0SILnCSJ4ZLREGNfRYCMITm8Hw2GN
	rlCmqEPenN994tF+MmcFxVBldLNbZk8w6UUxA8XDf64MrTJwi6vvaoO5Fl5dlX4TW5CZwk8
	fgV0fdd4jvH98OYAtfgDtwlD13qqPxQsuXJhh5NBTmAFronWmt/p47Kht4sFqk3BVziV5nJ
	rgGnA+98vAGykXCgfKq0DIzC5TP1mHLBg5Lxicdf7psKzYH61xrUA7xcQmkRrRKVkRjNrCq
	femXO1Fl98YQKCH0sIHg8gebe7qloEedm7bu8T5O0d5Z/H+pnPHlq4iseWGOZjWiSm8cnzk
	9AbwiJTKasDq9U39pxlWXA04nAgrvsATJBvekGZWRfYFaDD3VgmUFoeDePbIlAC/3ldVHME
	74kswCDvx9TQ/+uYpyPlJWnIY3H6awI49wzrAl2I+yD6cbPayhVX3zv1sbyJa4EcDvot9GF
	D0ER3Nq6RZOaA9W/tx6tmE2r6GkD6uD7q5PaYNclBaUPH8zg5ROHOQ0O7AEJpTE33uAigMs
	SLAsaM1PxsWWxC+h16u745yI736tcAx2JP6YQS7P62tjwsXmmo/+1YJNbKqj6zeabfd70w6
	PdRPr6IFjV+wXE3S2rfLJ1zLxqm9vqS8Yk7OsvHxpq/pH5VOGGtFidDLOG0CRP6Qz29Aii6
	CetAVeYmmjgM+TcNhFihTVrNFPp4oqbGtHALM5Dp1HurLxA5V4OW2d7lE3rpaqYYYWnui3g
	5iTM/r4H5sEQh8FZidw6AuHT4tfOR+49OCdV23Po/Lr5gfkiNpaNlqSmlML+Enn97Ixg=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

SGksDQoNCj4gT24gVGh1LCAxOSBOb3YgMjAyNiAxMDo1NjoyMCArMDgwMCwgV2VudGFvIEd1
YW4gd3JvdGU6DQo+ID4gV2hlbiBhIGNsb25lZCByZXF1ZXN0IGlzIG1pZ3JhdGVkIGFnYWlu
LCBpdHMgdGltZXIgaGFzIHRoZSBzYW1lIGxvY2tkZXANCj4gPiBjbGFzcyBhcyB0aGUgcnVu
bmluZyByZXF1ZXN0IGNhbGxiYWNrLiBVc2luZyB0aW1lcl9kZWxldGVfc3luYygpIHRocm91
Z2gNCj4gPiBfX2luZXRfY3NrX3JlcXNrX3F1ZXVlX2Ryb3AoLi4uLCBmYWxzZSkgY2FuIHRo
ZXJlZm9yZSB0cmlnZ2VyIGENCj4gPiByZWN1cnNpdmUtbG9ja2luZyBzcGxhdCBhbmQgZGlz
YWJsZSBsb2NrZGVwLg0KPiANCj4gVGhpcyBpcyBuZXQtbmV4dCBtYXRlcmlhbC4NCg0KVGhh
bmtzIGZvciB5b3VyIHJldmlldywgSSB3aWxsIG1vZGlmaXkgaXQgaW4gdjIuDQoNCj4gPg0K
PiA+IFRoZSBjbG9uZSBpcyB1bmhhc2hlZCB3aGVuIGluZXRfZWhhc2hfaW5zZXJ0KCkgZmFp
bHMsIHNvDQo+ID4gcmVxc2tfcXVldWVfdW5saW5rKCkgaXMgYSBuby1vcC4gSXRzIHRpbWVy
IGlzIHBpbm5lZCB0byB0aGUgY3VycmVudCBDUFUsDQo+ID4gYWxsb3dpbmcgaXQgdG8gYmUg
Y2FuY2VsbGVkIHdpdGhvdXQgd2FpdGluZyBmb3IgaXRzIGNhbGxiYWNrLiBVc2UNCj4gPiB0
aW1lcl9kZWxldGUoKSBhbmQgZHJvcCB0aGUgdGltZXIgcmVmZXJlbmNlIGRpcmVjdGx5IGlu
c3RlYWQgb2YNCj4gPiBzeW5jaHJvbm91c2x5IGRlbGV0aW5nIGl0IHRocm91Z2ggdGhlIHF1
ZXVlIGhlbHBlci4NCj4gDQo+IFRoaXMgY2hhbmdlIGRlcG5kcyBvbiA0ZTJiM2VmMTllMGUs
IHdpdGhvdXQgdGhhdCwgX19yZXFza19mcmVlKCkNCj4gZnJlZXMgcmVxc2sgaW1tZWRpYXRl
bHkgYW5kIHRpbWVyIHRyaWdnZXJzIFVBRi4NCj4gDQo+IFNvIHBsZWFzZSBtZW50aW9uIHRo
ZSBjb21taXQuDQpPSywgSSB3aWxsIGFkZCB0aGVtLg0KDQo+ID4NCj4gPiBGaXhlczogOTdj
OGEzYzFmNzNkICgidGNwOiBGaXggcG90ZW50aWFsIFVBRiBpbiByZXFza190aW1lcl9oYW5k
bGVyKCkuIikNCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPg0KPiBQbGVhc2Ug
ZHJvcCB0d28gdGFncyBhYm92ZS4NCk9LLg0KDQpCUnMNCldlbnRhbyBHdWFu

