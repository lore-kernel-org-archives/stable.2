Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449DB3C1413
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 19:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626061; cv=none; b=PX1lcBrvDLwy0tLRFdtiidsABezvARJ9afI/H0FyKQ/I2+KExPlOdE36Hk0BCIFjkn5ikbypq/0BImVbI8Iv5pGH4h1dHteRH7ZqGWTxEfZMHt6jyBfjCoHtYz9wU+o/jvXKcz0YT63NMXaEqVZLbvAki8hvmBihUbrLRg02vig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626061; c=relaxed/simple;
	bh=65Idyz1sDs9eWG2wgPYu7Qcgmm8fUR/7vH9Y0/N6jM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODXMYdOkxt1Lquke3UPurs6Z0SfujZRm1UsTJS5wrJc+D55RtwIoMXDfl2g0tAClpCeN9NbXfydNHmapuciXfctwqA1qNeqk7IP//ZseLoMgBSWLbcUOAA7JS3wlkdOlYHUkGPAZGrfmCo/r6krGY+1jnaog7B9Ku1nsPuQ4EwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCd77N5C; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCd77N5C"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47de008b020so96317f8f.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 12:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783626058; x=1784230858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4x0XMO7ZOolpmBLxmTy2H2GAqq0zcQmA38pNAG6AsLI=;
        b=LCd77N5CIvdkHfctwufaX5ziHRIczsJnStcnRFZS1t3LgspBj4fKT4TUnpUnlcbH9C
         nRZh9aAyu/vPcFlv5dGh4hxJyYLgQqfNXGgQvrBnAzRE2lZAEo8UxQ3XHju+1qdb0dSK
         mkyfshatvKyG8uXG3cAxzsPUZSi5qzv6EmFCwhqsR2mQuXSp0ywqyI3zHoOw99dbzD2i
         Cn++tgqbpF/6PNUrbgbTBrgOpSC1lXF0hkfeTDQ3Xf1dFJJgrZUfZL4GCWqwLCEZb3CN
         e0ejhINUdZjw9zAh1Qm6vmj+B7tMrP8NQGCLGCE6xmHlZGX1+Z7j6/hAzewIlUQ4l4vM
         ZZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783626058; x=1784230858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4x0XMO7ZOolpmBLxmTy2H2GAqq0zcQmA38pNAG6AsLI=;
        b=A/rPGCchIj1gopB/41PwlYNK/4j7b+7dtPkOfoq1G4VWeE9T5A2Fxno4S6ELI1ZXpA
         HLAEBXRXOlwpWVJ9r/YNuo8ddSEDAOB+UTqht3VsTj+HqkP6l09VqGYcMMXoFIYwtP4E
         0TG05Mt0goL17aIU9TWox3YqcGV548HozG7o3flVDAoDxYW+29W2BwQUC40L//VhxkxE
         WoOHaruU7yJoDV0iPCOqIQ6jrIRWcD/fzu2ct5hxuhwKhbO9zwOKbnbbniAOHv4oB+N1
         AqiTZzwwqt5tBxPFhkGFkY6H2YXPxdaYMazJse4siU9lTs/r2oSI6EW69GHUUoFqp7OB
         f/mQ==
X-Forwarded-Encrypted: i=1; AHgh+RpTj59A51hv+i0M3tSersuczbPwFxBK0AUaHaK+goGhfRqFyeNHesaFHADx0GXvGnLxgcw+8zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnq1xISB2iiXFuAA2KUZwmMzixQZE/PLghqS7Q7Gzn/rP5vKrr
	2+Dd9YmqNqgAmSLaZraeY7pZHomBDd2iImcP3TWyCXc8yeub5uw3KVDD
X-Gm-Gg: AfdE7clLQO+bW/svfCYxzYntoox0k6JtiSvaEae14srTwXuZSetUMhC00PHoyPpzw9R
	eSvW1rIzNejxdmKfxLnfZM7kz0nZnRwrclYhBqrclvRNmfEO8rpc2uSPJCOdyXQH9MR1Fi32a/y
	NeQsL3/uhoUSF1qX2bMVBvX63P1E1Yh+xHoDEvO91QTAaSl7pxmgVKb6Kk3YT0ofpEvv6IVytKw
	o0h260PRL16tkPVAUnLOjQFNL+/nRoeWsph09kpV5Hc+dL2/R7iMcDb0e0yBDuTYunBG+YK+7zV
	w/NsopYYPTFoAaVOxgPweiQl6o1AGv229hPzbGS/v4ZfYKjZz/gMcPoaguvdlu7JH314sYyZvKZ
	FkfOArOtb/x+upkPXExmgSfeSEtedFcJDbOINeRR1YP2Ek3Y60rX2UhrYXPt43f/q+pwDZnwONK
	Ur6YfbfsicGNEG2qr86B7rG1GA
X-Received: by 2002:a05:6000:40e0:b0:470:8e2b:9c84 with SMTP id ffacd0b85a97d-47ef695b55dmr753432f8f.7.1783626057578;
        Thu, 09 Jul 2026 12:40:57 -0700 (PDT)
Received: from mini.main.internal ([2a02:908:c211:cd18:d9f3:ab2b:ac6e:fc84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a558easm53986441f8f.27.2026.07.09.12.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:40:56 -0700 (PDT)
From: Goetz Goerisch <ggoerisch@gmail.com>
To: gregkh@linuxfoundation.org
Cc: ggoerisch@gmail.com,
	herbert@gondor.apana.org.au,
	herve.codina@bootlin.com,
	linux-crypto@vger.kernel.org,
	miquel.raynal@bootlin.com,
	paul.louvel@bootlin.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Eric Biggers <ebiggers@google.com>
Subject: [PATCH 3/5] crypto: talitos - stop using crypto_ahash::init
Date: Thu,  9 Jul 2026 21:39:54 +0200
Message-ID: <20260709193956.15619-4-ggoerisch@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709193956.15619-1-ggoerisch@gmail.com>
References: <2026070912-pluck-bagful-2a71@gregkh>
 <20260709193956.15619-1-ggoerisch@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

commit 9826d1d6ed5f86cb3d61610b3b1fe31e96a40418 upstream.

The function pointer crypto_ahash::init is an internal implementation
detail of the ahash API that exists to help it support both ahash and
shash algorithms.  With an upcoming refactoring of how the ahash API
supports shash algorithms, this field will be removed.

Some drivers are invoking crypto_ahash::init to call into their own
code, which is unnecessary and inefficient.  The talitos driver is one
of those drivers.  Make it just call its own code directly.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/talitos.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 4ca4fbd227bc..a941ec08817e 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2119,13 +2119,14 @@ static int ahash_finup(struct ahash_request *areq)
 
 static int ahash_digest(struct ahash_request *areq)
 {
-	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
-	struct crypto_ahash *ahash = crypto_ahash_reqtfm(areq);
-
-	ahash->init(areq);
-	req_ctx->last = 1;
+	ahash_init(areq);
+	return ahash_finup(areq);
+}
 
-	return ahash_process_req(areq, areq->nbytes);
+static int ahash_digest_sha224_swinit(struct ahash_request *areq)
+{
+	ahash_init_sha224_swinit(areq);
+	return ahash_finup(areq);
 }
 
 static int ahash_export(struct ahash_request *areq, void *out)
@@ -3242,6 +3243,8 @@ static struct talitos_crypto_alg *talitos_alg_alloc(struct device *dev,
 		    (!strcmp(alg->cra_name, "sha224") ||
 		     !strcmp(alg->cra_name, "hmac(sha224)"))) {
 			t_alg->algt.alg.hash.init = ahash_init_sha224_swinit;
+			t_alg->algt.alg.hash.digest =
+				ahash_digest_sha224_swinit;
 			t_alg->algt.desc_hdr_template =
 					DESC_HDR_TYPE_COMMON_NONSNOOP_NO_AFEU |
 					DESC_HDR_SEL0_MDEUA |
-- 
2.55.0

