Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645514;
	b=sp9CedDUihT1VKlXyXHMqaML2k6DldCJ4xHYdu0Z90g7L0JjPyT2sA/V47w1IpnsPsie
	 G2ubIyeiA9V6L3E9+31Tig5Xu5SLhed5DWwlptP/YqMd3ewty0HJxPPVjQNQRbw3tvIJz
	 O3Kigk3NNlHeClxLsI9P8wgr0pNzwY5znfc7XhxJGR2VH1JeNwTXPeprG8F3W4lEgKGLK
	 gLUuXubl4EQosRAzEEdqlSkybNeQVPQKDzFVHmVEgUJLUeGep4tC0ZmkkzuJh/KjyL4QM
	 1kBLpuUHEOnV5U1tVJvVLSdHDoqRXf2IUJZ4UbaZqV0aQ5v4qEQRRyygaVV+CNpMijw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=tA8fanYUNEMCKg95/5mIB2W/4rmsixDLYX61xDs+OiI=;
	b=VKzjfO4dJ6yUbVyiKnhLi3lyfXwRNlhkc1tvCp2rk+Fqz64BlcAYZsXeHiQba81qwz0G
	 YCvE2UMaumfIIyFtn82yoCq71sr6IoU8cZVenHNJBm8mBL68/7ILnvvtb+g+ZQCVFR97B
	 L5GCL2O9RTFKT0drPwvCPNz4PfkXAsZeSQmrgpIEnbIet3aPp+79pqwDYD7sK8IF+ujg5
	 Ekb+zXSTimvYbRKgdTqdXfONe/oB40L+svOn4pdPYoq7aQATPB/YqG8S9vN1hL770l3T4
	 jrMPdSeHwMxTpmd4xn7x0LWWvqe4dvXipBq3TAqlc+/dWRYc56lnz+HF0iXvgtR040Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Hc8LIBqX;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56B7606A6BE
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D56B7606A6BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Hc8LIBqX
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33713e5e6daso10352763eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645513; x=1796250313; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tA8fanYUNEMCKg95/5mIB2W/4rmsixDLYX61xDs+OiI=;
        b=Hc8LIBqX/i4qh0XvLtJP23L+eOD2VsoHlO7L049gXWJbF+ger6+KOnNHPeX8fjoGw8
         XrJnxPre+5/ckLQACOqFa58IVlBi+Pk6344tWHPb621Cxw3+6Hj8wKlzgFzNaIPDUdxA
         qRy25mT0R/EhwRKu68EHv4885MNtFvQaQ6HwSoLKAd/TOX9dI5VaBGypebG6NHGo8LBu
         Wqs0IvI2yKamFSiOZKvbF9z6MHKRrSR9sLLVOPZFgHZinVEkg65VD28nMNS+W74LaApg
         oUBcQlztHbcO/3ys8z0QtozswgYYojsand5nIu+HviH4Y2TUohZj8d5ElLb2+v3BgXa0
         YKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645513; x=1796250313;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tA8fanYUNEMCKg95/5mIB2W/4rmsixDLYX61xDs+OiI=;
        b=AC5OjqdElhzFEZ61mW5lMGWq7QPNciXyrJdt4/pjmQSF8KWvtAaLAZrh8WEWZTk1jD
         I99XT3RCAWIt446DkWMBg+pTvpMJFsNSKUUFPbh5pClCe0S4/5xAQXffWa2+0Myh2lrV
         l4aI9hZ8iU3Dfq4F8N40Fsds6mLpbw6lwgzzWFdOrR2b2IsGMwCsyg4F07tDHgKV68N1
         5eFtCCd0y8ytNCXXZ3BAGtWhV1Qu7AczxinEU3o0OZsPgYWcHcWzCdCRq0QFopnUuuTE
         W3B/dMpWbqap9CtVlnzrgRbQHCkjx5nAz/pYX7BHSrWBxwMoRaQ1aG5nibxgzsKG2xrs
         o2cw==
X-Forwarded-Encrypted: i=1; AL+hErHVqC2pKVnAjz5ZwUm44tC1W4UMaRKtXrk5wg3wKfogcny415Lo4+eAiJp8Lgmd0X8ZTVKH4gI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/mFmv3aRfUMiPR7Zub6qIBCnVvq7rpWXTevizb6UDCvrKNUXIL
	b0Phs9CfbvMDXYs5nbn+d9ZRLWkhRAYtqfbLMTzyYKFPKt3IMTk12BsIy7zoS1wbBYcD017DeQw
	mpw==
X-Received: from dybkf17.prod.google.com ([2002:a05:7301:3a91:b0:359:198a:8046])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:dd8b:b0:372:32a1:b384
 with SMTP id 5a478bee46e88-38571510675mr21473493eec.33.1795645512613; Wed, 25
 Nov 2026 14:25:12 -0800 (PST)
Date: Wed, 25 Nov 2026 22:25:03 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222503.1445426-1-elkin@google.com>
Subject: [PATCH] crypto: sa2ul - fall back to software when assoclen exceeds
 u8 enc_offset
From: Elkin Cruz <elkin@google.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, irogers@google.com, Elkin Cruz <elkin@google.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In sa_aead_run(), req->assoclen (unsigned int) is assigned to
sa_req.enc_offset, which is a u8 field corresponding to the 8-bit
SA_CMDL_SOP_BYPASS_LEN_MASK hardware command-label field. The existing
fallback check only tests auth_size against SA_MAX_DATA_SZ (65535) and
the unsafe [240, 255] packet size window, allowing requests with
req->assoclen >= 256 to silently truncate enc_offset modulo 256 and
corrupt encryption/authentication offsets in hardware.

Fall back to the software AEAD implementation whenever
req->assoclen > U8_MAX, and compute auth_size in u64 to avoid 32-bit
size_t addition wrap-around.

Fixes: d2c8ac187fc9 ("crypto: sa2ul - Add AEAD algorithm support")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

 drivers/crypto/sa2ul.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index f8216b5d3991..1d9cb5932b25 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -1771,17 +1771,18 @@ static int sa_aead_run(struct aead_request *req, u8 *iv, int enc)
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct sa_tfm_ctx *ctx = crypto_aead_ctx(tfm);
 	struct sa_req sa_req = { 0 };
-	size_t auth_size, enc_size;
+	u64 auth_size;
+	size_t enc_size;
 
 	enc_size = req->cryptlen;
-	auth_size = req->assoclen + req->cryptlen;
+	auth_size = (u64)req->assoclen + req->cryptlen;
 
 	if (!enc) {
 		enc_size -= crypto_aead_authsize(tfm);
 		auth_size -= crypto_aead_authsize(tfm);
 	}
 
-	if (auth_size > SA_MAX_DATA_SZ ||
+	if (req->assoclen > U8_MAX || auth_size > SA_MAX_DATA_SZ ||
 	    (auth_size >= SA_UNSAFE_DATA_SZ_MIN &&
 	     auth_size <= SA_UNSAFE_DATA_SZ_MAX)) {
 		struct aead_request *subreq = aead_request_ctx(req);
-- 
2.56.1.839.g22a8290db9-goog

