Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795477128;
	b=Dj8tDbuFvmRxy2V+IzC+tpanoM0Xlq0salW2mtI3aHdHtf1k2B8h13m2hF4jbRuKp8e7
	 T1asZKKdsvcxevzV+6/G5ZUeZK8ji2OAT0puv1U37qhaKvR1Fqe6qlId3/6gUSJDMX270
	 UIw1DmjJuo7tE35hPQ4rMcUJ8mWIdMJhZPGbBSslvhlFcY+z+t7fQHO2MGK05vZZ0+h3U
	 gI43mxtjMjgep1SF5tZWDSktUyp5P3ckCpvHRSo+EpHpXjUU1HOhUluF8qZkDMW6of5Io
	 OaOqrogo15xTLMKWIB0pr3EDqqp05tlupDk/6mWa0YwDwDIZo4dL8S7ETb5tXdWNnmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795477128;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ViCuzC29eFKJ8ML9lwnxCCTUFjkhP+S+d0AfhX4Jfo4=;
	b=G/NGd6tCmvkg7PLK/vPfHAXUBx+w4+OGfXhlf3JR60PQhTCIH45VaBFVoihyFzmKQmPB
	 FGdIEdfBoLsYjX2gU045IhlG07x1WKrvg7ftYMAMmiHnJdUOxNjRj8RA/DIuwGxt3LNq6
	 u8/zzoYtbJaCqW6DuBQIj6A0wxVg8IQ5RDecfXadp+Mvr6evzjUdrYJWrmRoMJqQr6wgA
	 ep5GGowbg9rkWXY0sEVSv+leyIO+fc6S+lB+dolNcbNTNbXFD1nyuIl5clBWwWX0dH4Rz
	 ztY6tlTb/pUHbAq27f6VVmLNEiPQRntwnQDb4bP3OwiRsW0MEZjhy3ETGd5/QhVusuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wxf4IhsA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8474606A321;
	Mon, 23 Nov 2026 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wxf4IhsA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795477128;
	b=MTiKCHBYdDnerQR7KVaOcegIOxVRy/FDgYSn5qGO5wj4HyHQz47cQHc1GYnd5AAJ0W92
	 6dVson2rt659QmtlXeTj+TLVAw1ZU6znu8FUMEr0xdW5zEUK0uUQ9XLIkm66eMhtP6cAm
	 V83DYJ76vtdhWRiabqNac1FNsFNZIUCb1YcICSRTuCDcEGhJyfpItK/8e8qYL39KTCb64
	 M0rTWQfFIek+zg2WPgUxqw1hne8Vu62WmtL7rq3aYNaLvRUQ49rSWGiYgeRHbQLXcCKQt
	 Q9ryfUxy/EvhxIZyH26cyglu+WBzM7Asn4HXNdzlUgz2ipYxrhB2bOYoQDkM1f9L6Bw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795477128;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ViCuzC29eFKJ8ML9lwnxCCTUFjkhP+S+d0AfhX4Jfo4=;
	b=f28d5EQNOGBvJJCQqifzwgVHqnvjgB0pp8b3cNp+1N09XIUrkXJSfwOmolymr9acHOHr
	 JAO36qa27sWQ6is0WkjLxUng50njG1tVoHejWVyZJuE3RAHeIIOBpIQJeVUFKtjRVC7mC
	 +gaw2G3T3+uIf7yVYlrgPyMSckMJwFIu2qCsCRvoP2wbo3CgNX1c80fOjLgAf0f32gfW1
	 S3cnf5HmMscBZj+aDbBSTtVuYb9HlBltRRuFS6mP9SHwL3NB1W2DVgfEjaI3SKqeE26FP
	 3ZjvX6bo4bzvq06CKhxuupTTmg8I4aE0PGfhhWw7WFApRgtlB7m3+9k+KMdzN7eNTkw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 41A471F000C0;
	Mon, 23 Nov 2026 23:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795477128;
	bh=ViCuzC29eFKJ8ML9lwnxCCTUFjkhP+S+d0AfhX4Jfo4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Wxf4IhsA9YVrVfJVyWFVjDLKsFFQrHxqmUYfW/hjK6AgpSCeo4QdAJmWQWsZ5Xa6W
	 Eh1E8zyuSoYy1RSXUjHDjN5s8dNM+rFbejaxmLKWr5nQAWxROl9UGE6Lx5mXJWeT4F
	 gH9NfW8BxGS5qC8xqM8JP+s9NN3cLPPHuViIGeEmc3ihZx6MxY4LwRAfA3mplZ+L1F
	 52fok10VVEhU4XsonC/87BVDGHupClvyLiERWteM9rzgK1a5D63tnoSyBbE7sHEX8w
	 oUVo1HFpgmCB/gPM5ovXHbeOGzBG6McAj+Ik8n/QP9Vvd0LFcyHRX/+ivUIM64VcQe
	 wZZX91U8cwDTg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 94FC24C7CC;
	Mon, 23 Nov 2026 23:38:39 +0000 (UTC)
From: Arina Kharlamova via B4 Relay <devnull+arina.kharlamova.mbzuai.ac.ae@kernel.org>
Date: Tue, 24 Nov 2026 03:37:45 +0400
Subject: [PATCH] selinux: reject a 65535-byte xfrm context that ctx_len
 cannot hold
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261124-dev-v1-1-00b99ee684ec@mbzuai.ac.ae>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyMT3ZTUMl1jIzNz4+RkC2MzUzMloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0AjuyniWcAAAA=
X-Change-ID: 20261124-dev-32673cc83656
To: Paul Moore <paul@paul-moore.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, stable@vger.kernel.org, 
 Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795477118; l=2642;
 i=arina.kharlamova@mbzuai.ac.ae; s=20261123; h=from:subject:message-id;
 bh=Z7AJMpvi6SLYbFT+owIrY8vSwJq5AGT0uGxXNqbrlAE=;
 b=Ar6QmklyIzqD+a5uCiu5IjDZKs7GTVmt6UryLLGPxeHsXub11JIu7vvJo8WDXBtpbHA9LBn3B
 5m9am+0ZMXsDbMhnvdQPkyZt+lMZLvvHY//Z1rLqhVLarbTzka0VtzK
X-Developer-Key: i=arina.kharlamova@mbzuai.ac.ae; a=ed25519;
 pk=DzQWwMpUtJvSDuzprqvRdbrC72n4Sq8dW6cq3NRt2Mk=
X-Endpoint-Received: by B4 Relay for arina.kharlamova@mbzuai.ac.ae/20261123
 with auth_id=1625
X-Original-From: Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>
Reply-To: arina.kharlamova@mbzuai.ac.ae
Content-Transfer-Encoding: 7bit

From: Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>

Commit 86c8db86af43 ("selinux: fix selinux_xfrm_alloc_user() to set
correct ctx_len") made ctx_len count the terminating NUL. ctx_len is a
__u16 and selinux_xfrm_alloc_user() only rejects str_len >= PAGE_SIZE.
With 64K pages, str_len = 65535 passes, and ctx_len = str_len + 1 wraps
to 0 (kmalloc_flex() stores the same truncated value first).

ctx_str[] is __counted_by(ctx_len), so the following memcpy() of
str_len bytes is checked against a buffer of size 0. With
CONFIG_FORTIFY_SOURCE this ends in __fortify_panic():

  memcpy: detected buffer overflow: 65535 byte write of buffer size 0
  kernel BUG at lib/string_helpers.c:1044!
  ...
   selinux_xfrm_state_alloc+0x18/0x24
   security_xfrm_state_alloc+0x3c/0x6c

The memory written stays inside the allocation (65536 bytes for the
string); without FORTIFY_SOURCE the context is stored with ctx_len 0.

A user context of 65535 bytes can reach this hook through PF_KEY
(af_key.c only limits sadb_x_ctx_len to PAGE_SIZE); the xfrm netlink
path cannot, because there uctx->len (a __u16) includes the header.

Reject a str_len that does not leave room for the NUL in ctx_len.

Found while surveying callers of kmalloc_flex() whose __counted_by()
counter is narrower than the count, with the help of an AI coding
assistant (Claude); I reviewed the analysis and the fix. Tested on
v7.4-rc2, arm64 with ARM64_64K_PAGES, FORTIFY_SOURCE and SELinux, under
QEMU (GCC 15.2.0), with a KUnit case that passes a 65535-byte context to
security_xfrm_state_alloc(): the unpatched kernel hits the BUG above,
the patched one returns -ENOMEM. The PF_KEY path itself was not
exercised.

Fixes: 86c8db86af43 ("selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len")
Cc: stable@vger.kernel.org
Signed-off-by: Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>
---
 security/selinux/xfrm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 8e00b3306574..181748bb5eb3 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -85,7 +85,8 @@ static int selinux_xfrm_alloc_user(struct xfrm_sec_ctx **ctxp,
 		return -EINVAL;
 
 	str_len = uctx->ctx_len;
-	if (str_len >= PAGE_SIZE)
+	/* ctx->ctx_len below includes the NUL and has to fit its type. */
+	if (str_len >= PAGE_SIZE || str_len >= type_max(ctx->ctx_len))
 		return -ENOMEM;
 
 	ctx = kmalloc_flex(*ctx, ctx_str, str_len + 1, gfp);

---
base-commit: 347b0c5bacbe94bc99f7683e3c9269c77a0b9c92
change-id: 20261124-dev-32673cc83656

Best regards,
--  
Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>


