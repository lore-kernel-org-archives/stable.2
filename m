Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817848;
	b=m6XKTeGcRab8nhn106VDMH8dXbxANVg0qwlgvDMloxKcgkzxpR5H6EbVrVqlGWZXs/tL
	 tshnXIxowracJfElgQlC1LyEHevZXQG2NZZPq+Dtx91sAD/PZzZmETc9VlIYTwADMqkt4
	 raq1NTmv9uDTTAeePBy2zA0BiRdZjyGOCP1Rsr3tt8BvU5Vd7mW2AwowhOIM+PDql3gEr
	 f6is1wFzlUI8dkY/eKTwmu79eS6oMTCjKVYIgtMXrV3jkdCrkHFEC1apBFRpJ10mQILid
	 DsCMGkshbLX3Fq5AGYTlOMSXUSevQ9Ks8pe6NHy7ck3ATos8W5+z2kxhw+SJm0KZ0iQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pxKm2CQD1OZ3CVqcykeuoxCWHTwuDypxWncmZ9TEiGU=;
	b=vtGOCX2/9Y8H7ZvBNA8AmKMpArNYIqq5lT5FkQgEkl5rUVLiQTBL9q4MkxpqI4OHltu8
	 em62ZQLb2vPgZDwS+zTB0dneWw7A9lCMfqlUBBOOnTRFruxHMDENArFVFmLwP91h2WG7R
	 xBNFEchioEIIKNLTBfijrxU6VYPP39+PMY+CBLe0wzZ3VNSqljn9LzmlLW/kyukT5niIG
	 up7yBMF4Ct04UEqUAr5O5+0w45XtMyoyd8dmk8pUBOzesCmT4rafi74imKALzZYHr3UIJ
	 lseFto5kiFphL7a15S6PZ2YUasCH7pQ+T6x3Sfst4H1Sx2SQtK42s9VZ3sFaGu1Luqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="TRm7/dgU";
	arc=none smtp.remote-ip=209.85.210.47
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AB8606A32D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45AB8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=TRm7/dgU
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-83bbcfba0ffso726790a34.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817847; x=1794422647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pxKm2CQD1OZ3CVqcykeuoxCWHTwuDypxWncmZ9TEiGU=;
        b=TRm7/dgUQxpjybRVmgavRv5OJgxu8ucquElsMf4LTuLLo1PZu7AHdchGNZQQjXG+wi
         TL5vuKC83dPdtteG7AyMbcLXNWj2fDCbAEYtoYZKVc3kfyrLkMr8hyQ2i/akN6+1UZVy
         skNNgVtOxHFS3Dxnu/yP2Z02KBsF9qOpwHId5H/womug71ye8E8hNl7KK55QoTXw2sdO
         ObR77GTCcIjM8ykBz73lWIk6nr++Z7OfuGm2EZW261Ot5QwA0NFJgTTyFNzWXrcLs4tE
         cJkZk8KDn4sLEfC5L4TICJ35CLhjuk+s5AGHpAxIHQtP/uAxwqPOGE/ysuW+pwlRhC/Y
         vlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817847; x=1794422647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pxKm2CQD1OZ3CVqcykeuoxCWHTwuDypxWncmZ9TEiGU=;
        b=0N8pdouQ+L52ZPza4PKG2QyAEurKmXq7SeU4JFijNkTFeZDl0lCyy9vllOLrsxHDop
         jzqC19JJL+KkFeJ8bu3RW+M0cJMalwLQ2PcnEwMJzkK/B2muWFZcUMKdp2ah3V3Ayo/M
         UouJO9mmepDRy4cRuQmoHc0ukXz2e4SGq8oJqy6yIMZJWg7I8NHd0yAeFNy2kix7AFO0
         iuYyXqYYJOHokTMcZRNP0BwhN6BS7N+PTdjOkDs8x41S6zoLXdZFNYrZEVBmR0dRPy/J
         pIIOmbXLkbZ3aahrb7d4ggoRPIa/jEJZhb0T/PH2jdzm2R9oTbzwiyNk1Su5UW7+l1HE
         B2Ew==
X-Gm-Message-State: APuU4Z/NHeDGlCobVNrKpP3BwrLK/VWQBcZ868TBij4TmiOweLk6pycs
	oqayqUT4/V3rTYTPiWwvuSOsvk0GG9ZUIgC8Hwu9eZxi3D/PZi38w6niZZ6pxyrExN5v5vurJc3
	L9u6vWFg=
X-Gm-Gg: AYBFou1JudpW8yazpEZQXNyF8niLY2NMFJoNvUBECscgbNpFhGjPDFLUHPQmjbsEeUq
	H5zs9erZ0V6SknwDochhy99o2RdhPaScT1EXcsVZslwirIbwRMhNgvocIwhEkuHzDCKQtPnnLPB
	JOV9sM2YUFfczXk+wVMlWOJKTNwhMeFAquQNZH00X5QMeAOGX95w1LHljOkNjwYtwhZZ2WjMnsf
	lYVeV0kCDGYOt2XENgc6tux2/t25ahcwiggS0ZBnzUUl7jeUZn/9AZs4p5GjmTgAnAnsWT9o17O
	Rqh7+HCeRvj4r6QJKRHYQzqo1g+g2ldITWRdbdV+4lI7TyLdlwFDtHaBvtRSR8EeFPcsXFoR8HK
	HQXJfJJkZVD+zIeRbWJdVEU885aeKzerIy5GUBzZ7edLL0M0iCC3uFNOlPEOfpSNBwAgwbJ0JuE
	FsEp83z6PGC4A1xIpRI+a6hYvVk6n8IgSONIGa3LPyXu9lLirhVimIyi3WBbLPKRWbmCva5d/4s
	OH4OpPTCaSprZ+7/cvixrR9yWUPLcFl0RdOxpIWGP2JcfmqpD+dLuQfOaAyJkjhWGphgyRqMOOS
	5BxYs4z5qYpN/E6i9ZAdTGsWByT1mS68MVyCemMQZkTwTZ0d1618O2Zklj5kdBAVBoc/lThqsg=
	=
X-Received: by 2002:a05:6808:1526:b0:4f5:aa1c:d934 with SMTP id 5614622812f47-5640ddde4b9mr12836424b6e.38.1793817847111;
        Wed, 04 Nov 2026 10:44:07 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9fdfa53sm2199007b6e.15.2026.11.04.10.44.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 7/9] io_uring: free XArray nodes left by a failed store
Date: Wed,  4 Nov 2026 11:43:51 -0700
Message-ID: <20261104184353.516403-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184353.516403-1-axboe@kernel.dk>
References: <20261104184353.516403-1-axboe@kernel.dk>
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

Commit 51bab09b7ca1a9a6dd9303a3b7ee346f8128c963 upstream.

A failed xa_store() can leave nodes without entries in the tree, and
erasing every entry doesn't free those. An XArray needs xa_destroy()
before it goes away, even an empty one. That was dropped for tctx->xa in
commit ca6484cd308a ("io_uring: no need to call xa_destroy() on empty
xarray") over a lockdep report from freeing the tctx in softirq context,
and ctx->personalities never had it.

Now that the nodes are charged, a store can fail at memory.max and the
leaked nodes stay charged. Call xa_destroy() in io_uring_clean_tctx(),
which the task runs itself in process context before the tctx is freed,
in the error path of __io_uring_add_tctx_node(), and for
ctx->personalities in io_ring_ctx_free().

Fixes: ca6484cd308a ("io_uring: no need to call xa_destroy() on empty xarray")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.12 installs the tctx before adding the node and has no error
path that frees it, drop that hunk. There's no ctx->hpage_acct either]
---
 io_uring/io_uring.c | 1 +
 io_uring/tctx.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 6d1f06642c2d..52759ee3bd6c 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2856,6 +2856,7 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	kfree(ctx->cancel_table.hbs);
 	kfree(ctx->cancel_table_locked.hbs);
 	xa_destroy(&ctx->io_bl_xa);
+	xa_destroy(&ctx->personalities);
 	kfree(ctx);
 }
 
diff --git a/io_uring/tctx.c b/io_uring/tctx.c
index d056cce2c1a8..cea6d082a262 100644
--- a/io_uring/tctx.c
+++ b/io_uring/tctx.c
@@ -197,6 +197,8 @@ __cold void io_uring_clean_tctx(struct io_uring_task *tctx)
 		io_uring_del_tctx_node(index);
 		cond_resched();
 	}
+	/* A failed xa_store() leaves nodes with no entry behind. */
+	xa_destroy(&tctx->xa);
 	if (wq) {
 		/*
 		 * Must be after io_uring_del_tctx_node() (removes nodes under
-- 
2.56.0

