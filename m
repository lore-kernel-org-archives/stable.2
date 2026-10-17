Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCB13B38A1
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792207710; cv=none; b=Z2Wn9TN6GxPJadAqmFPzDC31ftptLTvTvaqL3ocdUwVXRayAY21SwuIcMna14hJ+pGnpvz/5w4ccjLseJ9BjtUCCFV/xKQE09wt1SgGTr+JDgGpSag9qVvWDrdr4dYE4KCwaJNZD8rNpNFjI1sNzCYYbSboKfF8EGoOS7iLWd0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792207710; c=relaxed/simple;
	bh=oPvpngYgb3gDSbNgR2i6nItLp+8/l01MxAbIoxQYnPk=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=A2HLlWRadnPGRuFPgnAnLOaw1HuLIRs6GDr4LGoNTH+JB6doEuwY1hiXg/2fcyR40/cT87FZ57uPbgirPrbzh9oG5vpKzI/bOhLQL8y/vrQKeMhuoraKTxCHnI9GqFXlzl6A0hxsQkohLpT9RKCrwgyTEkUyhmMC0PmBUBg5Neo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=j3U6ECFt; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="j3U6ECFt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792207697; bh=oPvpngYgb3gDSbNgR2i6nItLp+8/l01MxAbIoxQYnPk=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=j3U6ECFtu/6JahI3XHv8rm9hY7tDqswWDOu6zCwHL5rOP91BBLyvK/JxIqET7gcvk
	 g7yDEV79RISNtqjyNGH8HXj3XGZGFThUz3fkdxZPKHVI6/m6jAG1lUfxiW0vvO7Poi
	 gm5YrNvO/8OKUg83qJqHMfD4gE0qLyl7PCmz9iN4=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-XMAILINFO: N/Vcqssfup8JQjUcZJqhvtZnz0BM1ovXR1FQrDMUcw43sIlBo0ec2E7J6fTSPm
	 99rBKKqRA0X8/g8znrLel5OZReJE8SnpzJPCH1Xy9Ad44Qlyb/Yd2/COi2/nzV0+ifFhk5faskbik
	 iogObJWwosHWc1UFZ13gA8sHm+fjFUsbV92xoMRHmrbVuaPKSrFXNqpvAdl1nPNRCXRBAgS23JO3+
	 S26px2QISMzyzzcN3Bgm9lYOAAAl9Y8ulT89XuKNnljaCur9hzX5FtDmufmMHlsCCmq7fjEroR3t+
	 7bSz8LBtaeu/qH/JRTP8QNIhV4J9miIj4UueaKGH0dbq+p7oIj7dCeBqo/s/s+8X4Au48HnQ+PM6U
	 cn8RNAI7bVHyTrYRbl8nseyJe1ucs+Qg9hmKf2MZ1qfHveSGxUi/VoMlN6FbqQKXON9zlovAhNPS4
	 kmv2Rkyw/I+E5EE5TwN7rSGv2Spy+ExFiP249ipYHA5UPNAjZZ3T4582mtXi1ejhB7KXNC6D52QGH
	 kGSfk8uxlM1JfPBabHnE6G9UOZzWnT8l4h/umZNzIyzRl5/dl0kDpr0N+Wk36ht8thXnkOQiq74FH
	 oBZ67SRvIMprALVb76h1LMhw2NITwrB8v5DMqR9k+clTFtV3tKc1UHkheRMpZLyAE4Gps5ZBmO4ut
	 gSGk0MKGga/jit1hucE27G3gsjv0lWJB/gd+M3xWNAI17ogA8hfBtYA0BNpr4YGPpdEc11YI+T/gK
	 ywwNI/qh+of/jjaZtELyuMKyHcBXkCKCFC6l7B7m3v+wx/DfdwONP+Z/OavEkAIFe6A3iPs9evwUK
	 9RXsTm5QcZC+UnqPsodOg9F0mt1MxnFX1CS8c2QKlnc9OZkU4N72xr80noEGvXCl+dSSaegTeSLwq
	 sy2Ykn1LgywfILS/7F5DrFtVfwvfEgdSfnepRmwtew7JBq/lcviMli6wjIBwdyWdtzLioDYQjL99q
	 gyoONzmfyxh5IcwzybNVrZktD4itjnmQQvNWYsaiOz0C9k2Au+cSLHUPr7wht8ErCXNO2iNzUslzm
	 WOfAYJxqfSxmHQ6b0ry+8ootz2fol8RJ7g5UWFqoHLUZhkDg2W4LapuCtKj53VJDRk1t5VOJDcx4W
	 9hjbVzUXf8ACoTrD+iSkZ4nu69mFNm5P7drA75ySsjCQJDIE9kYNX7tBrncevk3uhsINDbknSktmc
	 w==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?bmV0ZGV2LWJvdCtzYXNoaWtv?=" <netdev-bot+sashiko@kernel.org>
Cc: "=?utf-8?B?bWts?=" <mkl@pengutronix.de>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?d2c=?=" <wg@grandegger.com>, "=?utf-8?B?c29ja2V0Y2Fu?=" <socketcan@hartkopp.net>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>
Subject: Re: [PATCH net v5 1/6] can: dev: prevent bus-off recovery when the interface is not running
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 17 Oct 2026 11:27:03 +0800
X-Priority: 3
Message-ID: <tencent_AB234A019188927E4F4DAB34DF32E2091E08@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261015-rockchip-canfd-restart-close-v5-1-ae77327037c9@qq.com>
	<179219884173.1406898.3472467604167875171@kernel.org>
In-Reply-To: <179219884173.1406898.3472467604167875171@kernel.org>
X-QQ-mid: xmsezb41-0t1792207623tzsdiwpov

SGksCgo+IFtTZXZlcml0eTogTWVkaXVtXQo+IElzIHRoaXMgY2hlY2sgZW5vdWdoIHRvIGRl
bGl2ZXIgd2hhdCB0aGUgc3ViamVjdCBsaW5lIHByb21pc2VzPyBJdCByZWFkcwo+IHRoZSBy
dW5uaW5nIGJpdCBvbmNlIHdpdGhvdXQgYW55IGxvY2suIGNhbl9yZXN0YXJ0X3dvcmsoKSBy
dW5zIG9uIHRoZQo+IHN5c3RlbSB3b3JrcXVldWUgd2l0aG91dCBSVE5MIG9yIGFueSBDQU4t
cHJpdmF0ZSBsb2NrLCBzbyBub3RoaW5nIG9yZGVycwo+IGl0IGFnYWluc3QgX19kZXZfY2xv
c2VfbWFueSgpIGFuZCBuZG9fc3RvcCgpLgoKVGhlIGNoZWNrIGFsb25lIGRvZXMgbm90IHNl
cmlhbGl6ZSByZXN0YXJ0IHdpdGggbmRvX3N0b3AoKSwgYXMgbm90ZWQgaW4KdGhlIGNvbW1p
dCBtZXNzYWdlLiBGb3IgUm9ja2NoaXAsIHRoaXMgc2VyaWVzIGFsc28gY2FsbHMKY2xvc2Vf
Y2FuZGV2X2NhbmNlbF9yZXN0YXJ0X3N5bmMoKSBhdCB0aGUgYmVnaW5uaW5nIG9mIHJrY2Fu
ZmRfc3RvcCgpLAp3aGlsZSB0aGUgcmVzb3VyY2VzIGFyZSBzdGlsbCBhdmFpbGFibGUsIHRv
IHdhaXQgZm9yIGFueSByZXN0YXJ0IHRoYXQKaGFzIGFscmVhZHkgcGFzc2VkIHRoZSBjaGVj
ayBiZWZvcmUgdGVhcmluZyBkb3duIHRoZSBoYXJkd2FyZSBhbmQgSVJRLgpUaGUgcHJlLWV4
aXN0aW5nIHRlYXJkb3duIHJhY2VzIGluIG90aGVyIGRyaXZlcnMgYXJlIG91dHNpZGUgdGhl
IHNjb3BlCm9mIHRoaXMgc2VyaWVzIGFuZCBzaG91bGQgYmUgYWRkcmVzc2VkIGluIHNlcGFy
YXRlIHBhdGNoZXMuCgo+IFtTZXZlcml0eTogSGlnaF0KPiBUaGlzIGlzIGEgcHJlLWV4aXN0
aW5nIGlzc3VlIGFuZCB3YXMgbm90IGludHJvZHVjZWQgYnkgdGhpcyBwYXRjaC4gVGhlCj4g
cGF0Y2ggbWFrZXMgdGhlIHdpbmRvdyBzbWFsbGVyLCBidXQgY2FuIHJlc3RhcnRfd29yayBz
dGlsbCBiZSBxdWV1ZWQKPiBhZnRlciBjbG9zZV9jYW5kZXYoKSBoYXMgY2FuY2VsbGVkIGl0
PwoKWWVzLCBpZiBhIGJ1cy1vZmYgcHJvZHVjZXIgaXMgc3RpbGwgcnVubmluZywgdGhlIGNo
ZWNrIGRvZXMgbm90IHByZXZlbnQKaXQgZnJvbSBxdWV1aW5nIHdvcmsgYWZ0ZXIgY2FuY2Vs
bGF0aW9uLiBGb3IgUm9ja2NoaXAsIHRoZSBzZXJpZXMga2VlcHMKdGhlIGZpbmFsIGNsb3Nl
X2NhbmRldigpIGFmdGVyIGZyZWVfaXJxKCkgaGFzIGRyYWluZWQgdGhlIGJ1cy1vZmYKcHJv
ZHVjZXIuIFRoaXMgZmluYWwgY2FuY2VsbGF0aW9uIGNhdGNoZXMgd29yayBxdWV1ZWQgYWZ0
ZXIgdGhlIGVhcmx5CmNhbmNlbGxhdGlvbiwgYW5kIHRoZSBydW5uaW5nIGNoZWNrIHByZXZl
bnRzIHN1Y2ggd29yayBmcm9tIHJlc3RhcnRpbmcKdGhlIGhhcmR3YXJlIHdoaWxlIHRoZSBp
bnRlcmZhY2UgaXMgZG93bi4KClRoZSBsYXRlLWVucXVldWUgYW5kIGxpZmV0aW1lIGlzc3Vl
cyBpbiBvdGhlciBkcml2ZXJzIHNob3VsZCBhbHNvIGJlCmhhbmRsZWQgaW4gc2VwYXJhdGUg
cGF0Y2hlcy4gVGhpcyBzZXJpZXMgaXMgbGltaXRlZCB0byB0aGUgUm9ja2NoaXAKQ0FOLUZE
IHJlc3RhcnQvY2xvc2UgcmFjZXMgYW5kIGRvZXMgbm90IGFkZCBhIGdlbmVyaWMgZnJlZS91
bnJlZ2lzdGVyCnNhZmVndWFyZC4KClJlZ2FyZHMsCkN1bmhhbyBMdQo=

