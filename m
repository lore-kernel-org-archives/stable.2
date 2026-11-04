Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817921;
	b=on2ILEjtvWvj73FfHYKiPBuVq7Lc90nGJfYXTFRYCC7jycNE4Rx6N9S+HBC4SCT08Sf7
	 e0tIwDO/ng/GS4sDIzHoNq2mPV1bQvvJBF+Jpr34w8/4ezaogmpyiwIUmVHpZq/mBBZYF
	 u3HsRnI0PTxdeYIg3V71jXeBmThYBiA03YkmDKLwvfZWtF8xfPFbQcbg9E+qWVU7P9W8Q
	 PJrPdUgtCXEbAnswzvwz4Ph2SBvetcGTYKiLT317F9oAWf97nqv3ZVNk7KMb8PxpdCxaQ
	 m2OLsqhng5EvlfjRMzV3C823I9tTzdQWJDBnuM+bpaIKaUeQ6cZUUyijB8rzRP6rS0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4Czltm/TkJa9OTuuR5SYKkBPpKSZSBm36SyvuTKq0wA=;
	b=jxw9vfopsTjpbFAk0zlOgPtFETlwffCCr3SXFDLzFD7QLWZpsW5LPtLbO8GaBAb9rljJ
	 sa4Or4eHQu0wTIF1j6DoUaoLm9HoD2/lbWUhBdi5NLbG1IaOh0g8Q5ltm/GMaJqzPZqqF
	 7OQnbnqk62Wse4ordQTmsy/2ggd4O3ulnAmZL1aAP49bCt68dE0GBhYCKZuPVhY/Ev0Xe
	 yqMjn0ydxqlo4vZ5Y48vPNhFQw5jBIt9rJhhTrCawOuWuSqKEfSBnxdmDW6vatbiJoh34
	 jrMqwQEPWMW03Uf5XCy10y8pTa3O1C9jh8DpaFarkWxq1cMjap8SsCN98YaDYSGlEpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="c/kSDzj7";
	arc=none smtp.remote-ip=209.85.167.181
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5B606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECB5B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=c/kSDzj7
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-53ec9237600so606514b6e.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817920; x=1794422720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4Czltm/TkJa9OTuuR5SYKkBPpKSZSBm36SyvuTKq0wA=;
        b=c/kSDzj7DvcTEJuNKOgdHVBeNytYBwEgOsSrK94CbFFHgUbcncTv5+7sl6lQKVtMC5
         OYAsHfya/gWvDdriRgbXaUEQX9k2uw5fHSrwZxJoGHB0FE5Ko8EeYAs8ebaI8b51cxWx
         JZ8wsLGbpuFH3SrO9S9no+//e+Tg8HQHzykQHQv645WsSe6BRKexWZm4/6uR/KbdzEtM
         JdgUkcPqyx18lg+PFFKsk9sc01mFdWCNtvgqnlNi/4chZLbHmGAx06j6Batj2qnS/NUZ
         IPYqaPYaGGqyC+Zfgezy6VXs3IM7akjNBujqZc9TrfOj2Khg1HQoCuPNqc9ZynG3knLx
         sAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817920; x=1794422720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4Czltm/TkJa9OTuuR5SYKkBPpKSZSBm36SyvuTKq0wA=;
        b=Fw84JIvLidcxHr82CicloSsGiK3GbZUXgPRXrwhlNO+PnOgsKltQsVVFpHzlfpggWc
         8+vEflGksXIn7UwstP0/UvXcRg9aY2aB7pecI4oYfl0wjsG6V/oaLBnKXg19uIpOWwMf
         bulDgykGSNiI4f2EMwMFDh+UCk6su/WG33SDyU8i7kWbUQbn90HZzVJOwM71Liby6B8x
         RomZF7VUJzlQotV2BvvneNYJnWcRUze++dMlw307QtQkU0FBLtk1alNvhviVKv9HqHf7
         Uaj6/6vamAew23YVFuFR/fmf3KIYsFzsAqMd3QEQSUv5Q2CYKU2zHxqcxu5Vb9Rl0nm8
         aC/A==
X-Gm-Message-State: APuU4Z9QLiIONau2GzVENdWJF8gArXNgWpsDai7+/nmxvLtPVtlUvMs5
	AmWD2e+RqrH5NlZ8kJc6S5mLljV1RshMgDzxmO/xZMaIO8c6FCbLFgNCAmH7SZfuipXvfQUW0Yb
	lfR9pXIc=
X-Gm-Gg: AYBFou1jx1lrVv0BtpbHV6Ju225IikTeXd3iyiSAKFfh0OewGapyr/R3Ql6ecuBsWjG
	Lwdqz2YG22+17IvASmUkWmjfO2lXwRyWHp+F0FykWaHEQaATF2MNowwz2drBlzdSw+k5Yaik0hS
	KTDJdqJCuFRoAvGUhRRQ0kKY4A7Bnnyh9ojv7cdgWDCirCBf5xk1QTitlY54dyxztlh+lm2QZyR
	k49/2uIAzvduJHiyfVYIXlxdOo98Q/wbkNw+Ag4s/6At6M0qK7Hi/qvxhyczqxOMeYwEVnK4gDx
	tHdU18Od9pTJMerh6nimkz1qp6JBGQIn3rhSVfpwlfWDgxyle6Y19TMQS75sV/eYOxiW9uCCp2d
	+YLqHc5LsXMil7zTTkUAnuA0KDMHpEw3NtrFe/2b/J02aGs7OSu3BnN9aI+SICGy7QuN6ap4+0+
	k5Da06V9N429sOmqPBn5YGq/gdSnvjNc4+FL7jhMkbEIA+rqnHdhRjltxsvapcYYZ7Mmgbne6XM
	I1X8OQpcYP6xPu7bGVHvHWztbE4jpbV3G4/1OWVPK2RegKFt5D8XKVmWRrF57vsCwKB6MtJnk4q
	K2P6d/B4Kxi6806JSRzXfZ2YOjo6TVymgbgglbmMWMy6yYLsN5+2vIXJdZDARrt5WEncwXjM6Pg
	lqyU0gh5En5BYmxIpqT25
X-Received: by 2002:a05:6809:2791:10b0:564:30ff:6cca with SMTP id 5614622812f47-56430ff6e84mr6194759b6e.60.1793817919908;
        Wed, 04 Nov 2026 10:45:19 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.45.14
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:15 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 08/16] io_uring/rsrc: charge buffer arrays and nodes to memcg
Date: Wed,  4 Nov 2026 11:44:39 -0700
Message-ID: <20261104184447.516768-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184447.516768-1-axboe@kernel.dk>
References: <20261104184447.516768-1-axboe@kernel.dk>
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
---
 io_uring/rsrc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 51b46e624ddd..d69baa47c7e7 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -162,8 +162,9 @@ static struct io_mapped_ubuf *io_alloc_imu(struct io_ring_ctx *ctx,
 					   int nr_bvecs)
 {
 	if (nr_bvecs <= IO_CACHED_BVECS_SEGS)
-		return io_cache_alloc(&ctx->imu_cache, GFP_KERNEL);
-	return kvmalloc_flex(struct io_mapped_ubuf, bvec, nr_bvecs);
+		return io_cache_alloc(&ctx->imu_cache, GFP_KERNEL_ACCOUNT);
+	return kvmalloc_flex(struct io_mapped_ubuf, bvec, nr_bvecs,
+			     GFP_KERNEL_ACCOUNT);
 }
 
 static void io_free_imu(struct io_ring_ctx *ctx, struct io_mapped_ubuf *imu)
@@ -229,7 +230,7 @@ struct io_rsrc_node *io_rsrc_node_alloc(struct io_ring_ctx *ctx, int type)
 {
 	struct io_rsrc_node *node;
 
-	node = io_cache_alloc(&ctx->node_cache, GFP_KERNEL);
+	node = io_cache_alloc(&ctx->node_cache, GFP_KERNEL_ACCOUNT);
 	if (node) {
 		node->type = type;
 		node->refs = 1;
-- 
2.56.0

