Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685710;
	b=NuI+C3juj6itFTpHr8deM+F/yg0MQZDTtaoANT9A3NA025z1ywnaLvWYXsbmvMsEd69C
	 SsNhVQlL24dP1ICDX4kO34cqyGnTGakzvrI2lATv0jQRZt4u2f57Gmcwx7olvV6PWyhnW
	 kfsFpIDYNqEIikJJJ8cK6tvAGwzSDqxJNZdvXfs6AViC9gEtAtGf0f0kD6y7uhRhXmdYd
	 8wBAvrVQXjCbuj2InACdcZntbyRxrL+Utr1H8uXPavliO7oOAxJ7o3+WS/eR1SX+u1Bt6
	 CB243eHmnppQjNrLMnbGU+KRkSJiqqTrmiKqda3BHLSlj1piPgXCwue5zIrvhq4N16w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685710;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:X-Priority:
	 X-Mailer:In-Reply-To:References:X-NTES-SC:Content-Transfer-Encoding:
	 Content-Type:MIME-Version:Message-ID:X-Coremail-Locale:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=4rXhKT8TtFGgK7PSIy2cEeLBQd2+yyLrWU2UR0XS9OY=;
	b=EGEwabnWApEqZIOVBE/Yhka+uLy5IHInn+J2Jp80XiOv2XzqsmytbHPhgomzSwgT7zd+
	 M/xEYynhyFS6TMrTSLs6OzyMWY/bXU6bFVrIyHGVpHc+jhP45yzbsH0fv7A63HW4BvUXS
	 DpSRq2UsGve4fwJkdcxmjS4WEtmI8jkU/psOKKQpr8bzMgIqOu8pyhEuLbLpJ5AVSczUH
	 8+3Hgpk82tmtym2Ieq4vyrPiDFzwYwC2TRNEcqYBSs1SLkBB0Fxuf7yKzCKu0hRcPa3F3
	 +owzLrbxeDtPUb0/RfXy33PF/O2w3IZegNCkQARWqwYw16/BXHO0D/hWv4lDNuA6gQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=ZgNMhUAU;
	arc=none smtp.remote-ip=117.135.210.6
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0F606A31E;
	Thu, 26 Nov 2026 09:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03B0F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=ZgNMhUAU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=4rXhKT8TtFGgK7PSIy2cEeLBQd2+yyLrWU2UR0XS9OY=; b=Z
	gNMhUAUcklFYXKfTMNIUBm/CKZkSZH5q9wsyebphEl2D9jelp51BXM0o6o4gSL4x
	Yoo/uCmuGpOD/1Sea0YOa6elkMtsD71c0Ipifs+upIGloo+qkXjTgRgXgVfCTr/y
	WbxEVDtWKaUGrDaLmsBzN8zI17eqpIkcDn6k9LWGZM=
Date: Thu, 26 Nov 2026 17:34:45 +0800 (CST)
From: dd  <zhongling0719@126.com>
To: "Hyunchul Lee" <hyc.lee@gmail.com>
Cc: "Hongling Zeng" <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
	liubaolin12138@163.com, ntfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re:Re: [PATCH 3/6] ntfs: read initialized_size under size_lock in
 the iomap paths
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <awfxvg7w_i49JxBv@hyunchul-PC02>
References: <20261125073547.154150-1-zenghongling@kylinos.cn>
 <20261125073547.154150-4-zenghongling@kylinos.cn>
 <awfxvg7w_i49JxBv@hyunchul-PC02>
X-NTES-SC: AL_Qu2SB/qTuk4j4ymdZOkfmUoQhu82WMW3uvog3I9UP514jAvj+BsGdFRZMlTSwMGzKieyiCCWSRNg7vxLXq1cXaYxtvSDZLZ5RZjEh28sWQpEjg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <63810a45.6fa0.1a217351ac6.Coremail.zhongling0719@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cikvCgD31wY1_Qdrf5VoAA--.45874W
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBoBUp+WsH-TV-bwAA3R
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCkF0IDIwMjYtMTEtMjYgMTY6NDU6NTAsICJIeXVuY2h1bCBMZWUiIDxoeWMubGVlQGdtYWls
LmNvbT4gd3JvdGU6Cj4+ICAJaWYgKCEoZmxhZ3MgJiBJT01BUF9aRVJPKSAmJgo+PiAtCQkJaW9t
YXAtPnR5cGUgPT0gSU9NQVBfTUFQUEVEICYmCj4+IC0JCQlpb21hcC0+b2Zmc2V0IDwgbmktPmlu
aXRpYWxpemVkX3NpemUgJiYKPj4gLQkJCWlvbWFwLT5vZmZzZXQgKyBpb21hcC0+bGVuZ3RoID4g
bmktPmluaXRpYWxpemVkX3NpemUpIHsKPj4gLQkJaW9tYXAtPmxlbmd0aCA9IHJvdW5kX3VwKG5p
LT5pbml0aWFsaXplZF9zaXplLCAxIDw8IGlub2RlLT5pX2Jsa2JpdHMpIC0KPj4gLQkJCWlvbWFw
LT5vZmZzZXQ7Cj4+ICsJCQlpb21hcC0+dHlwZSA9PSBJT01BUF9NQVBQRUQpIHsKPj4gKwkJbG9m
Zl90IGluaXRpYWxpemVkX3NpemU7Cj4+ICsKPj4gKwkJcmVhZF9sb2NrX2lycXNhdmUoJm5pLT5z
aXplX2xvY2ssIGlycWZsYWdzKTsKPj4gKwkJaW5pdGlhbGl6ZWRfc2l6ZSA9IG5pLT5pbml0aWFs
aXplZF9zaXplOwo+PiArCQlyZWFkX3VubG9ja19pcnFyZXN0b3JlKCZuaS0+c2l6ZV9sb2NrLCBp
cnFmbGFncyk7Cj4KPklzIGl0IHNhZmUgdG8gcmVhZCB0aGUgc2l6ZSBhZ2FpbiBpbnN0ZWFkIG9m
IHJldXNpbmcgdGhlIGZpcnN0IG9uZT8KCk5vLiAgVGhlIHR5cGUgb2YgdGhlIG1hcHBpbmcgd2Fz
IGRlY2lkZWQgYWdhaW5zdCB0aGUgZmlyc3Qgc25hcHNob3QsCmFuZCBhIGNvbmN1cnJlbnQgZXh0
ZW5zaW9uIGluIGJldHdlZW4gY291bGQgY2xhbXAgYSBNQVBQRUQgZXh0ZW50IHRvIGEKYm91bmRh
cnkgdGhlIHR5cGUgZGVjaXNpb24gbmV2ZXIgc2F3LiAgdjIgcmV1c2VzIHRoZSBmaXJzdCBzbmFw
c2hvdApmb3IgdGhlIGxlbmd0aCBhZGp1c3RtZW50LgoKPkFuZCB0aGUgc2l6ZV9sb2NrIGlzIG1p
c3NpbmcgaW4gbnRmc19pb21hcF9yZWFkX2VuZF9pby4KWW91IGFyZSByaWdodCwgdGhhdCBpcyBh
IG1pc3M6IGl0IHJ1bnMgaW4gdGhlIGJpbyBjb21wbGV0aW9uIHBhdGggYW5kIGhvbGRzIG5vCm90
aGVyIGxvY2ssIGFuZCBvbiAzMi1iaXQgdGhlIHVubG9ja2VkIHJlYWQgY2FuIHRlYXIuICB2MiB0
YWtlcyB0aGUKc2l6ZV9sb2NrIHRoZXJlIGFzIHdlbGwsIGluIHRoZSBzYW1lIHBhdGNoLgpUaGFu
a3MgZm9yIHRoZSByZXZpZXcuCgo+Cj4tLSAKPlRoYW5rcywKPkh5dW5jaHVsCg==
