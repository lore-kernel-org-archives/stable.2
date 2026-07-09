Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8553BD657
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625406; cv=none; b=VKTyRAQQOU4PQjIqBYx/C/1yd/ZP3uSoY/qY0GLvblCq/wTAp8zVI9xyw/QENJP9y0hgML69odgs1xIdgGudvUZgD8fYEahsII9q/43MXGMzqc1OIVyVxOUKcVMeNTgHadZsNGdOZJoQe63S+IQvBznokt6WECrkG9GEc6iCOA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625406; c=relaxed/simple;
	bh=hGWlZAdSKJyrO4vnRYHgI0oT7ZubZ5JXgla6IQEgQvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrMrBBfJiRNzQSXaW8VaZ9ZhzNhhDCIQbf61SjbShf1PTU1OwWZRO+NzncOI25zXJYrmv99SxSRvaeBt+nVnjHJt5NHonlzJJdUiUMAvovSBl5eMzGtMWyIudzemv+rpJxmVREWgXWAN+kWpaPuaxyZB7OeD2uuDUUDjIrOlLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fyeo8omV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fyeo8omV"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47df6a5202bso129537f8f.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 12:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783625402; x=1784230202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gHCpxEue7VXEZ9tnLbMHa9jIi5zBsJ5AQM9y2uBm52M=;
        b=Fyeo8omVIwyr7JyNtglr0rRAWxuPsWPpWoEjZP+KcVQsUD+A5YZtnppQmaN6N78gDi
         H/7/wNPaWtoYQBsKw1GMZnfcjKBDRl9NCmiao6jWCEhXK86/QjBdO/w2Oks8TG6CE+ZA
         waFm9MGRg1nHcL1OeJN7WTdxSe85FixjSAH54wopAM5xC5TiGikMDrnTlfptfmmapIP4
         G5g34LZwS3l02qImxYC8PQWUddyzlhG9C+zWapXd7fg4fBTMG8COwff+BOWjI6uMRf5A
         Ta8BMYIDpvaUMp0O990Y7IllY6Uuf+IjQkBeNBE3yU5MLT7sIVLyrARg5NgTlxwCP3NE
         kJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783625402; x=1784230202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gHCpxEue7VXEZ9tnLbMHa9jIi5zBsJ5AQM9y2uBm52M=;
        b=MPMdXLhF2cuCzU8IWr6SVyWU94thGJC8XQURBkiTfMQzOxLLYP6X1fSncWaGGAZdo/
         tKD0rOkUDNLpZ4PF0szOY3aPC9LNkXC291oRTKe4JsGRCLJ4T5YCafxcQkZMTBUdjKD7
         ivkdRx2kEEgkleo8fE+x0vLzm4IahGq/v96OreAib8IUhlmXMqIlbFu8fOvIX768c4zI
         0Av2SxhfwNhO3MogREFyDx+TVnev1EYWVNIzm1hVAU/ubNX1ZqEk0yJrgSlzOVnBKNPq
         jQnGr6qdsPffgqnzoVLHqPuq3pkgMM465FGbL0F6coo8ikMsl8csnzgi0F+QjNJCAaQF
         n7Dg==
X-Forwarded-Encrypted: i=1; AHgh+Rovnrfw9tPZK1A0muwd1U3T+UgkXATrRHEDU0sGYL20bIVj8Ow06WUlNY7Z+mMuGt2f+ADSJ1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0U0BDn3Bn1SZQnURPMlH7dHraeQhvDa2DoTEqXNNayQkiQx7
	60eP2eXZvVBf3e53pV7+apaJyTx0hZIC9K/TsJA+orY/o3PZjlFOrX5L
X-Gm-Gg: AfdE7cnL4Sf8xRobCz56767W8UENIeV1g92vhiUUNd2ZlYkxgclHycoXuVeOlLJpIjF
	pLGFX5cuUTxqSC9w8wnshDS8P8bGBIvoPeyQNiCpBWHBd/eV+aE+Hph59S07L/od9BaCqkp4Ohk
	AOenW1ArN7vscVtO/l1zQiLcdqtvd8obpscNjxq8OiiRkCaoc/js8Y+ye0e5EKPMiFJNVjPan6S
	eqRMtlSfVpurFWxmclqU9GKgHJ7nYvwUYBrOKGuv7U5TmOcX/2U6ZtTPQheV7w7Y4cdibDvb/Ue
	HgmjUjqbrBTSx7uEqaxhEYweUOcf5cyNO8bgHngYsNEjJg1DTJSj1BoRwmN0WvyceoqEIIRrR8l
	t4dW0p7YmfmJv0u+qtmPIBszjdeqir9uoBFJF/nhobnzloqvX8b+A0zezBC5QT/TofbhI6MVg+Z
	O3sb1hLD6/Wkz9se6ptQvn2tTB
X-Received: by 2002:a05:6000:2911:b0:46f:7d90:8125 with SMTP id ffacd0b85a97d-47df07b4f2amr8658697f8f.15.1783625401576;
        Thu, 09 Jul 2026 12:30:01 -0700 (PDT)
Received: from mini.main.internal ([2a02:908:c211:cd18:d9f3:ab2b:ac6e:fc84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm53873509f8f.5.2026.07.09.12.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:30:00 -0700 (PDT)
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
	thomas.petazzoni@bootlin.com
Subject: [PATCH 1/5] Revert "crypto: talitos - rename first/last to first_desc/last_desc"
Date: Thu,  9 Jul 2026 21:28:22 +0200
Message-ID: <20260709192826.12699-2-ggoerisch@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709192826.12699-1-ggoerisch@gmail.com>
References: <2026070912-pluck-bagful-2a71@gregkh>
 <20260709192826.12699-1-ggoerisch@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a866e2b1c65edaee2e1bb1024ee2c761ced335f8.
---
 drivers/crypto/talitos.c | 46 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 347483f6fc5d..f78a44f99101 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -869,8 +869,8 @@ struct talitos_ahash_req_ctx {
 	u8 buf[2][HASH_MAX_BLOCK_SIZE];
 	int buf_idx;
 	unsigned int swinit;
-	unsigned int first_desc;
-	unsigned int last_desc;
+	unsigned int first;
+	unsigned int last;
 	unsigned int last_request;
 	unsigned int to_hash_later;
 	unsigned int nbuf;
@@ -889,8 +889,8 @@ struct talitos_export_state {
 	u32 hw_context[TALITOS_MDEU_MAX_CONTEXT_SIZE / sizeof(u32)];
 	u8 buf[HASH_MAX_BLOCK_SIZE];
 	unsigned int swinit;
-	unsigned int first_desc;
-	unsigned int last_desc;
+	unsigned int first;
+	unsigned int last;
 	unsigned int to_hash_later;
 	unsigned int nbuf;
 };
@@ -1722,7 +1722,7 @@ static void common_nonsnoop_hash_unmap(struct device *dev,
 	if (desc->next_desc &&
 	    desc->ptr[5].ptr != desc2->ptr[5].ptr)
 		unmap_single_talitos_ptr(dev, &desc2->ptr[5], DMA_FROM_DEVICE);
-	if (req_ctx->last_desc)
+	if (req_ctx->last)
 		memcpy(areq->result, req_ctx->hw_context,
 		       crypto_ahash_digestsize(tfm));
 
@@ -1759,7 +1759,7 @@ static void ahash_done(struct device *dev,
 		 container_of(desc, struct talitos_edesc, desc);
 	struct talitos_ahash_req_ctx *req_ctx = ahash_request_ctx(areq);
 
-	if (!req_ctx->last_desc && req_ctx->to_hash_later) {
+	if (!req_ctx->last && req_ctx->to_hash_later) {
 		/* Position any partial block for next update/final/finup */
 		req_ctx->buf_idx = (req_ctx->buf_idx + 1) & 1;
 		req_ctx->nbuf = req_ctx->to_hash_later;
@@ -1825,7 +1825,7 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 	/* first DWORD empty */
 
 	/* hash context in */
-	if (!req_ctx->first_desc || req_ctx->swinit) {
+	if (!req_ctx->first || req_ctx->swinit) {
 		map_single_talitos_ptr_nosync(dev, &desc->ptr[1],
 					      req_ctx->hw_context_size,
 					      req_ctx->hw_context,
@@ -1833,7 +1833,7 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 		req_ctx->swinit = 0;
 	}
 	/* Indicate next op is not the first. */
-	req_ctx->first_desc = 0;
+	req_ctx->first = 0;
 
 	/* HMAC key */
 	if (ctx->keylen)
@@ -1866,7 +1866,7 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 	/* fifth DWORD empty */
 
 	/* hash/HMAC out -or- hash context out */
-	if (req_ctx->last_desc)
+	if (req_ctx->last)
 		map_single_talitos_ptr(dev, &desc->ptr[5],
 				       crypto_ahash_digestsize(tfm),
 				       req_ctx->hw_context, DMA_FROM_DEVICE);
@@ -1908,7 +1908,7 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 		if (sg_count > 1)
 			sync_needed = true;
 		copy_talitos_ptr(&desc2->ptr[5], &desc->ptr[5], is_sec1);
-		if (req_ctx->last_desc)
+		if (req_ctx->last)
 			map_single_talitos_ptr_nosync(dev, &desc->ptr[5],
 						      req_ctx->hw_context_size,
 						      req_ctx->hw_context,
@@ -1964,7 +1964,7 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	bool is_sec1 = has_ftr_sec1(priv);
 	u8 *ctx_buf = req_ctx->buf[req_ctx->buf_idx];
 
-	if (!req_ctx->last_desc && (nbytes + req_ctx->nbuf <= blocksize)) {
+	if (!req_ctx->last && (nbytes + req_ctx->nbuf <= blocksize)) {
 		/* Buffer up to one whole block */
 		nents = sg_nents_for_len(req_ctx->request_sl, nbytes);
 		if (nents < 0) {
@@ -1981,7 +1981,7 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	nbytes_to_hash = nbytes + req_ctx->nbuf;
 	to_hash_later = nbytes_to_hash & (blocksize - 1);
 
-	if (req_ctx->last_desc)
+	if (req_ctx->last)
 		to_hash_later = 0;
 	else if (to_hash_later)
 		/* There is a partial block. Hash the full block(s) now */
@@ -2041,19 +2041,19 @@ static int ahash_process_req_one(struct ahash_request *areq, unsigned int nbytes
 	edesc->desc.hdr = ctx->desc_hdr_template;
 
 	/* On last one, request SEC to pad; otherwise continue */
-	if (req_ctx->last_desc)
+	if (req_ctx->last)
 		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_PAD;
 	else
 		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_CONT;
 
 	/* request SEC to INIT hash. */
-	if (req_ctx->first_desc && !req_ctx->swinit)
+	if (req_ctx->first && !req_ctx->swinit)
 		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_INIT;
 
 	/* When the tfm context has a keylen, it's an HMAC.
 	 * A first or last (ie. not middle) descriptor must request HMAC.
 	 */
-	if (ctx->keylen && (req_ctx->first_desc || req_ctx->last_desc))
+	if (ctx->keylen && (req_ctx->first || req_ctx->last))
 		edesc->desc.hdr |= DESC_HDR_MODE0_MDEU_HMAC;
 
 	return common_nonsnoop_hash(edesc, req_ctx->areq, nbytes_to_hash, ahash_done);
@@ -2076,7 +2076,7 @@ static void sec1_ahash_process_remaining(struct work_struct *work)
 			req_ctx->remaining_ahash_request_bytes;
 
 		if (req_ctx->last_request)
-			req_ctx->last_desc = 1;
+			req_ctx->last = 1;
 	}
 
 	err = ahash_process_req_one(req_ctx->areq,
@@ -2103,7 +2103,7 @@ static int ahash_process_req(struct ahash_request *areq, unsigned int nbytes)
 		if (nbytes > TALITOS1_MAX_DATA_LEN)
 			nbytes = TALITOS1_MAX_DATA_LEN;
 		else if (req_ctx->last_request)
-			req_ctx->last_desc = 1;
+			req_ctx->last = 1;
 	}
 
 	req_ctx->current_ahash_request_bytes = nbytes;
@@ -2124,14 +2124,14 @@ static int ahash_init(struct ahash_request *areq)
 	/* Initialize the context */
 	req_ctx->buf_idx = 0;
 	req_ctx->nbuf = 0;
-	req_ctx->first_desc = 1; /* first_desc indicates h/w must init its context */
+	req_ctx->first = 1; /* first indicates h/w must init its context */
 	req_ctx->swinit = 0; /* assume h/w init of context */
 	size =	(crypto_ahash_digestsize(tfm) <= SHA256_DIGEST_SIZE)
 			? TALITOS_MDEU_CONTEXT_SIZE_MD5_SHA1_SHA256
 			: TALITOS_MDEU_CONTEXT_SIZE_SHA384_SHA512;
 	req_ctx->hw_context_size = size;
 	req_ctx->last_request = 0;
-	req_ctx->last_desc = 0;
+	req_ctx->last = 0;
 	INIT_WORK(&req_ctx->sec1_ahash_process_remaining, sec1_ahash_process_remaining);
 
 	dma = dma_map_single(dev, req_ctx->hw_context, req_ctx->hw_context_size,
@@ -2223,8 +2223,8 @@ static int ahash_export(struct ahash_request *areq, void *out)
 	       req_ctx->hw_context_size);
 	memcpy(export->buf, req_ctx->buf[req_ctx->buf_idx], req_ctx->nbuf);
 	export->swinit = req_ctx->swinit;
-	export->first_desc = req_ctx->first_desc;
-	export->last_desc = req_ctx->last_desc;
+	export->first = req_ctx->first;
+	export->last = req_ctx->last;
 	export->to_hash_later = req_ctx->to_hash_later;
 	export->nbuf = req_ctx->nbuf;
 
@@ -2249,8 +2249,8 @@ static int ahash_import(struct ahash_request *areq, const void *in)
 	memcpy(req_ctx->hw_context, export->hw_context, size);
 	memcpy(req_ctx->buf[0], export->buf, export->nbuf);
 	req_ctx->swinit = export->swinit;
-	req_ctx->first_desc = export->first_desc;
-	req_ctx->last_desc = export->last_desc;
+	req_ctx->first = export->first;
+	req_ctx->last = export->last;
 	req_ctx->to_hash_later = export->to_hash_later;
 	req_ctx->nbuf = export->nbuf;
 
-- 
2.54.0

