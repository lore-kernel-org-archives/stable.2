Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817863;
	b=LuV3LycDKyZK4PZ7W4CGRb666VA8GrtpwvrVajYf3L2/RzUaSyXyUDw8ZY1T2zCcL9Ml
	 QTZzdk09R5DnYcMWHuT88snvOcoOQq6pe4hQ38mPP2GhWUKii5LkgeOTcyzP2oaB41RhT
	 ubR66pVuGJ6dMI5PfDDMEHE6glPkFrRUs/TMN29KAZXa6VInITEN71zODoC8i2ZMSAvWK
	 XGHTa1SB0Xb/H1ICpVxk7kLbUreKjFSO7YR41g5dCnJcY3icRnuPZAp8Qnq0nBEsBhgNj
	 1AQEjpU4m4LEfckmpBlAQfyURtYXWbnVIZCXpm8mPYvWDSzyySpoFpl3WSCgBXEjAlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k28CGNrgsP1N/7X/mEZD1ccfEAetSu0oVzCNkNH+zAU=;
	b=0qPIydIMRl9hLO+Yc8ZU+Dlo0dkYWA1cP6+YTIPLckXq+m4Gum3mOg3qZn/dW2Gl3kJn
	 uefhRxijIM+HAJi9bhfnMlGNTrpLwvz8L5OcwK+KttMiMOHF4GykdeEiI/exzucsPzLQQ
	 LtFiAWbYmbzOoK06itmY7Mdr0T3Q/OjFert0iTo2MgHLezglDnfqe0793GJ1kQq7EGtwz
	 5tKqekqJALcpfQjEhVk9aWBlUnlCsfgeTuzCHmjt+EgeKhOkpeNQGSfsNB5ocRpKU4RJ8
	 5HsBjAV79s6kwHtGVUjGin2tgb1B7o0XI7eMFqm0sXShr37nN+raIZfH+YLNYBC5GJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=isC4kcGE;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E67606A336
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52E67606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=isC4kcGE
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-702dedeb70dso603415eaf.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817862; x=1794422662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k28CGNrgsP1N/7X/mEZD1ccfEAetSu0oVzCNkNH+zAU=;
        b=isC4kcGE2nkgQMKeDJjRL83mCm/AuFM4Bo4tovhrOMTVxpvzSe7ZQeILBNo4STzQ2E
         I4YohTeHnavVoSP893xOkQdYkUmABVma5EEpiuLALbKLpgOHcFO1+sgrMyQsJtG//Nv7
         mCEfGQBS+HIrzSJa8QskVHkqYRfPU3b8GxEUKBKYrkkH+do7XJrefqytTAnc1qs3tlLN
         P2GMhY8dA9gGEdlg+6phaP3+d9wjYpGPZU0m0rIznEslnyIC4clzX/qOu9+Evx2RIBRc
         JozALbXo5nppOxHqP+yL7LN8QirX04ZEhFofbT5xZR1vQMzQYLk3eIYPrigrevPKoJVr
         dsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817862; x=1794422662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k28CGNrgsP1N/7X/mEZD1ccfEAetSu0oVzCNkNH+zAU=;
        b=ia/XT45Sz1GVzFVUz+hxctzFBNd8iGfQ1BQ4f/9sVgwy0DAKHKPhoEPWbeZP7jvrWM
         +E0FkEDBEXb3SXGam+HZXrkPIOYtnHO9v7dHww1TuP2L+UGqhrfd9Rau97PBycIpK/Lq
         oVoJwEZIUJVJpTIXq4zk90F96e5hh4E+8y9juZSgCCtr+jn4qp4c+yqtiQCyrow1h1hw
         5XLDGTFShQijaoobFFW36i2RwMnR7tvI9NNvvaoTtF0P2v4Ef5c6mKN7wIJHqps1lSg7
         TQSKxvwT5Pk2jmrkz59NUnO0UAQZoo8IwNGo2Z6Kkk9SwepOKIFLO32T/KA5bVXgCo/K
         WeIQ==
X-Gm-Message-State: APuU4Z96Os9aJLbBzaNxEgd38V0WFgBUISlOZmDbodYCWv/zyZ0HwEsy
	u7f26YswjhwNcRAzZb/7jyT6lAyQXbQK/Y/OG2vBIcudXpz8k46mdw5Wv/xIeVxC+OLEhNWhHvn
	hNlG5bTE=
X-Gm-Gg: AYBFou1JDfRD0UFn/9P5yi0VcSpkABC/ZgSITZZ3FDwBuL+ZnxrGnkGTyOi6Jt6TjDC
	mWWkWWfGLRmxlEtcG2eGbAAWnuT9HQCfn1Nmv//g4lyK292BSjuxzZPemoNR+nh8qifQyDWpCDl
	S702q2+NOKJXWwvay/Ely5f0pDTmq6VtDxlQuFVb/QMk/asSjMBWD0hGER6u143RG59j/ILjeUY
	2VLrOLCcpA3hAu/gp23HByitc8dm75EDOgR7gp9Rq/r7Vzi28iuJL0oV68pw6NJWZBIHdIA6iC3
	A1otGflBvBpY8x/1sM4t3W921MGPffSiZ6Up/L+icBgK6ydaPGQm1jiLUoxA+ttqk3Jajwqk+E5
	r8mSsvopYJIDe1sc+LyJXTF1q+cP89OFRyBrDRTTni+UBzGv/wOYwHuYuIEOq7iDN55M1x9PlsX
	xkk36cW/aX7/vF8OtlcYXL/hCWchDx5y0TfomBqf2BV8sMeTrbv398xtglrJLu7pExFCcp8zcda
	HTiqKIg/b9szZU2cbdrmDWA+r801rbANP3BTd48w1fHv4GpZvAU52ap4h2l72g+hYMBZcbppfuN
	AguGt3xWouwcxFdGEGDfBUEYDPM3qh8mb+J/hQdgbv+wykA6wR1GI+GvWnIaNFxWuKGj5hL0/gX
	fY2B3BbCXfOvyXUDlNUM=
X-Received: by 2002:a05:6820:c448:10b0:703:a9bc:b80c with SMTP id 006d021491bc7-714f246437cmr7014362eaf.36.1793817862206;
        Wed, 04 Nov 2026 10:44:22 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e16ef1sm2540779a34.14.2026.11.04.10.44.20
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 05/11] io_uring/rsrc: charge buffer arrays and nodes to memcg
Date: Wed,  4 Nov 2026 11:44:06 -0700
Message-ID: <20261104184412.516558-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184412.516558-1-axboe@kernel.dk>
References: <20261104184412.516558-1-axboe@kernel.dk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

Commit 075d5837bafc317e796548f721b8fbf7add6821d upstream.

The io_mapped_ubuf of a registered buffer has one bio_vec per page,
unless the pages coalesce into huge pages. Huge pages only count against
RLIMIT_MEMLOCK once per ring, so a buffer that maps the same 2MB folio
over and over in a way that defeats coalescing gets a full bvec array
per registration while only the one folio counts as locked. 1GB of that
registered in 100 slots took several times a 64MB memory.max, with 2.6MB
charged.

Allocate the io_mapped_ubuf and the io_rsrc_node with
GFP_KERNEL_ACCOUNT. An object reused from the ring caches stays charged
to whoever allocated it first, same as the io_kiocb cache.

Fixes: de2939388be5 ("io_uring: improve registered buffer accounting for huge pages")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.18 uses kvmalloc() + struct_size_t() rather than
kvmalloc_flex()]
---
 io_uring/rsrc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 8d28c6bfebb1..41e5755bd9aa 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -110,9 +110,9 @@ static struct io_mapped_ubuf *io_alloc_imu(struct io_ring_ctx *ctx,
 					   int nr_bvecs)
 {
 	if (nr_bvecs <= IO_CACHED_BVECS_SEGS)
-		return io_cache_alloc(&ctx->imu_cache, GFP_KERNEL);
+		return io_cache_alloc(&ctx->imu_cache, GFP_KERNEL_ACCOUNT);
 	return kvmalloc(struct_size_t(struct io_mapped_ubuf, bvec, nr_bvecs),
-			GFP_KERNEL);
+			GFP_KERNEL_ACCOUNT);
 }
 
 static void io_free_imu(struct io_ring_ctx *ctx, struct io_mapped_ubuf *imu)
@@ -140,7 +140,7 @@ struct io_rsrc_node *io_rsrc_node_alloc(struct io_ring_ctx *ctx, int type)
 {
 	struct io_rsrc_node *node;
 
-	node = io_cache_alloc(&ctx->node_cache, GFP_KERNEL);
+	node = io_cache_alloc(&ctx->node_cache, GFP_KERNEL_ACCOUNT);
 	if (node) {
 		node->type = type;
 		node->refs = 1;
-- 
2.56.0

