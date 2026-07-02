Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B20A20FA81
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 01:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782954640; cv=none; b=d1Nue4gdttHBXhYp8j7GMvLfsmkSYXMK0nxU/sXhM7NWOslfYU63fLK0WEfGtR/Hpcs8grOU6Ye6iHWFRgmtBfc846LJ+L6f3R4wwYnX6LyjzYV6VnLIlehgHyQMnWXpR3GMUHmI9Lt133mWKNspMsFhcCGRCIQQk7fSeETFWAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782954640; c=relaxed/simple;
	bh=mOGFYf2NVq2+X+4ukULrmQkJlrQ1JeQwuSMJOslFPvs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Cc:Subject:
	 In-Reply-To:References; b=QMvZqVcu+TzpbYuUAxcJAwkzdqi+GoLPpDI16wk/riIj6CoJS9kcl+gZxAC8tKjYCJa/DZiktN7bAIX9VJCgTWDxBWdAAmfKNsCBTwEhZdDqP72akLG/u5vsz6F0YN2W5FzCvnTh9ptsF9OTLlEZu6phm6htuSdZU1GVVK9K3d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5J0FbJF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5J0FbJF"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so6639625e9.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 18:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782954638; x=1783559438; darn=vger.kernel.org;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOGFYf2NVq2+X+4ukULrmQkJlrQ1JeQwuSMJOslFPvs=;
        b=S5J0FbJFdM/AMSygSEGVa4WennqDRQKg0YoC7xGpGOwJKByVbvkI3ClVl8edntzYk6
         U6HLqhyutcburVNaM2SFYlx9nul+yuiiiNjsldQFiF+J37KGrZ346g/GFqhSa8AuwIKq
         u8l1JDowIcte0Vj/Gz5KfIU8zaWZNIfmR/SHvohvXAWKBrOti+CGgXqcNv2V6ZZVaLZD
         DxReCMTMEux3mFmGcyictwIsHKnOsPBx2VnJXJdm3l/WVV0GJ5kjOQZBhso7J2hOCMq4
         a3kng/9bi0Zmy2LBhtJ2HgZV20H5TLwrpbpeWo4zwp7EU9QRpNgQi5ULEjOrhrp5NBTN
         kdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782954638; x=1783559438;
        h=references:in-reply-to:subject:cc:to:from:content-transfer-encoding
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOGFYf2NVq2+X+4ukULrmQkJlrQ1JeQwuSMJOslFPvs=;
        b=IvvzODW/YunIXLY/DrFWve8825B5jilZu8JFO1Ckk7d43SnWpCQmP5fzTATSdgHPmA
         I7oOk74jh9yO9rX6IKK+eTYsd2kfIRLpzfmYZgtO80GdqiAEcvrMFEmod4qGfZZiHuTy
         aU4cnQrFrjUgtRThI4u03JNp9wIYUpgLLbfW8E/SdwDYrUE4K2p64ZCwhqXl3jz25e4k
         98rQUBik8jRzsciSW/PUoLrhtycfvyF6dITjnL7PggA61WVE+1iH18kJTw6fkfsTRoLb
         SMgbosI25AvbSk+38XJCebXMl6AgEs//9udX/nNlJMC5293m2fDcxmChcCZ5xLiDIyiM
         s8fA==
X-Forwarded-Encrypted: i=1; AFNElJ82My92HstA0efTGEhMKtbdM0W2PeRVw0W0oYlREpVd4Uc5RppNwmE7bUHKfrJJgPd0vzRYEq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhJy54/cBECrfCb/bYfKmatntAuFDszPihBQMeK0gBnP+tmpF
	y3ZZbFVnHeQA/2F+dnlK4OiGfy1HdutNFh4532iWh0vGk+UflQT3xZ/VkdC9
X-Gm-Gg: AfdE7cmIQV23thlIjVnmLL4MurD7zMJYyy3yEhQ46aFhtQ6IXdQ/WTWtH910e/pRqD2
	D7OytBA4Wk+G7OLb7rmqhpC/8HqCcEXf7zajlxVwr8jnAhVDtu1E/ljfb2b9Cx+Dh4XQ5FpuKjZ
	zhnGn3ns4sIL3UpELEoSD2cN7w6qqpOAOGy4vX1qC/vb5xQ17/GTaKeOAPlJVthW7eWxvP0WAXj
	1/NSCflxvp04Tmx1hFgDppECzjPTvSVM7M1KKjdPJDfsPmrFAoyNMppslBtWoN4R7qbkxNcTm/H
	Qv0CTGyY1TaE45NGl7a0ycgZQh9FoZ9ns8KG50bD80ZKkfW/3ES2s9BZAdlmrVYYThxNhiJ+eLf
	zsTN5lUFj7BG5SiVxrCGxqMslu48Ag48M+dACYA1bVhJwgHhFS/2EUw2k49VLXQ==
X-Received: by 2002:a05:600c:34d4:b0:493:b8cf:cc8a with SMTP id 5b1f17b1804b1-493c2b3ccd2mr50214495e9.4.1782954637980;
        Wed, 01 Jul 2026 18:10:37 -0700 (PDT)
Received: from [127.0.1.1] ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef248b7sm62043285e9.2.2026.07.01.18.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 18:10:35 -0700 (PDT)
Message-ID: <6a45ba8b.940a5a52.377c47.efec@mx.google.com>
Date: Wed, 01 Jul 2026 18:10:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: Tristan Madani <tristmd@gmail.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Richard Haines <richard_c_haines@btinternet.com>, selinux@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org, tristan@talencesecurity.com
Subject: Re: [PATCH v3] selinux: avoid sk_socket dereference in selinux_sctp_bind_connect()
In-Reply-To: <0fa8e2f769f889368756a1ed1f12ea8e@paul-moore.com>
References: <20260625235336.3641828-1-tristmd@gmail.com> <0fa8e2f769f889368756a1ed1f12ea8e@paul-moore.com>

T24gV2VkLCAwMSBKdWwgMjAyNiwgUGF1bCBNb29yZSB3cm90ZToKPiBIb3dldmVyLCB0aGVyZSBp
cyBhbm90aGVyIGlzc3VlIHJlbGF0aW5nIHRvIHRoZSBTQ1RQIHNvZnRpcnEgY29kZSBwYXRoczoK
PiB0aGUgZmFjdCB0aGF0IHdlIGNhbGwgaW50byBzb2NrX2hhc19wZXJtKCkgaW4gYm90aAo+IF9f
c2VsaW51eF9zb2NrZXRfYmluZCgpIGFuZCBzZWxpbnV4X3NvY2tldF9jb25uZWN0X2hlbHBlcigp
LiAgVGhlCj4gc29ja19oYXNfcGVybSgpIGZ1bmN0aW9uIHVzZXMgY3VycmVudF9zaWQoKSBhcyB0
aGUgc3ViamVjdCBpbiB0aGUKPiBhdmNfaGFzX3Blcm0oKSBjYWxsLCBhbmQgaW4gdGhlIHNvZnRp
cnEgY2FzZSB0aGF0IGlzIG5vdCB3aGF0IHdlIHdhbnQuCgpIYWQgYSBsb29rIGF0IHRoaXMuIFRo
ZSBBU0NPTkYgc29mdGlycSBwYXRoIGlzOgoKICBzY3RwX3JjdigpICBbTkVUX1JYIHNvZnRpcnFd
CiAgICAtPiBzY3RwX3Byb2Nlc3NfYXNjb25mKCkKICAgICAgLT4gc2N0cF9wcm9jZXNzX2FzY29u
Zl9wYXJhbSgpCiAgICAgICAgLT4gc2VjdXJpdHlfc2N0cF9iaW5kX2Nvbm5lY3Qoc2ssIFNDVFBf
UEFSQU1fQUREX0lQL1NFVF9QUklNQVJZKQogICAgICAgICAgLT4gc2VsaW51eF9zY3RwX2JpbmRf
Y29ubmVjdCgpCiAgICAgICAgICAgIC0+IHNvY2tfaGFzX3Blcm0oKQogICAgICAgICAgICAgIC0+
IGF2Y19oYXNfcGVybShjdXJyZW50X3NpZCgpLCBza3NlYy0+c2lkLCAuLi4pCgpJbiBzb2Z0aXJx
LCBjdXJyZW50IGlzIHdoYXRldmVyIHByb2Nlc3Mgd2FzIGludGVycnVwdGVkLCBzbyB0aGUgc3Vi
amVjdApTSUQgaXMgZWZmZWN0aXZlbHkgcmFuZG9tLiBNZWFud2hpbGUgdGhlIHBvcnQvbm9kZSBi
aW5kIGNoZWNrcyBmdXJ0aGVyCmRvd24gaW4gX19zZWxpbnV4X3NvY2tldF9iaW5kKCkgYW5kIHRo
ZSBwb3J0IGNvbm5lY3QgY2hlY2sgaW4Kc2VsaW51eF9zb2NrZXRfY29ubmVjdF9oZWxwZXIoKSBh
bHJlYWR5IHVzZSBza3NlYy0+c2lkIGFzIHRoZSBzdWJqZWN0LAp3aGljaCBpcyB0aGUgZXN0YWJs
aXNoZWQgcGF0dGVybiBmb3Igc29mdGlycSBjb250ZXh0CihzZWxpbnV4X3NvY2tldF9zb2NrX3Jj
dl9za2IsIHNlbGludXhfc2N0cF9hc3NvY19yZXF1ZXN0LCBldGMuKS4KClRoZSBhcHByb2FjaCBJ
IHdvdWxkIHN1Z2dlc3Q6IHRocmVhZCBhbiBleHBsaWNpdCBzdWJqZWN0IFNJRCBpbnRvIHRoZSBp
bm5lcgpoZWxwZXJzLiBzZWxpbnV4X3NjdHBfYmluZF9jb25uZWN0KCkgd291bGQgcGFzcyBza3Nl
Yy0+c2lkLCBhbmQgdGhlCnByb2Nlc3MtY29udGV4dCB3cmFwcGVycyAoc2VsaW51eF9zb2NrZXRf
YmluZCwgc2VsaW51eF9zb2NrZXRfY29ubmVjdCkKd291bGQgcGFzcyBjdXJyZW50X3NpZCgpLiBU
aGF0IGtlZXBzIHNvY2tfaGFzX3Blcm0oKSBzZW1hbnRpY3MKdW5jaGFuZ2VkIGZvciB0aGUgbm9y
bWFsIHBhdGggYW5kIG1ha2VzIHRoZSBTSUQgY2hvaWNlIHZpc2libGUgYXQgZWFjaApjYWxsIHNp
dGUuCgpJIGNhbiBzZW5kIGEgcGF0Y2ggZm9yIHRoaXMgaWYgdGhpcyBhcHByb2FjaCB3b3JrcyBm
b3IgeW91LgoKLS0KVHJpc3Rhbgo=
