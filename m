Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817864;
	b=MJttSCgfSRrzJ7Yv8KnZmINIJ+VRUKwe1VtOXSHpx1dnt1/svAH+Mkme6PyAD3i5kx9f
	 pkyOTFeQPDaDOTBb+2+WB3ws7VcmqwBU7HBzUC1tR4piNfkqB1Kxa3yUl7/3MM+BZtOiB
	 0/tfhkEV/NbQ1vPgjrjiE2HEgAbURN+U3pgpDY4U85SUCLSmusChwfS9KOKUMSuKemx7f
	 MDBZ8JliGRYz2loS/qGNfjWx/h2MGCUrN7s9vJtjm/APLkd/KirGJSWClta6B9QbiTHST
	 hcsDOLbbLMdb5vP1t6aOyRYZjEimR/1ENWDQvNR+xRy2i2lKFwSgKpbDXpA6NW/N0Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IBjb/iCWXoppuO4QQjBPt2m8j2t3x0aQqbVEBgPFj5E=;
	b=UeqYKO/YzlPT2fynLdzcCcL3WsLBOQc11SEdTptW5r3h3mBwJ7NMTuOYIza8T6k3/jk3
	 PDwm7cihu8MiNUKs8VLwfnrIWULGtjyRxZp14s5PkO1T3CKDXbJHKvZwrXqbTuI4rg24u
	 0JjmXsqlZoErvT5m/85VJI5TzHiDGK773IVQ95AmwZJ/IaXkiiS+CkngvmbBMyCpYM4LU
	 GMtZxE6Rz7iUwt0chlPRpCYXJNnQSBaD6Mqeg56OKm/hfoifJaQOBdoxkVl3yHPausNlF
	 viy0MaYRuEWHdKtaTI4Vz2vEsWqlyfFxJLw1Uzy1ZkBdnDZtYUUXyNyaAJMu9hYPGzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="M+t/p1mN";
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CAB606A32E
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38CAB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=M+t/p1mN
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-854b6e2e41fso592113a34.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817863; x=1794422663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IBjb/iCWXoppuO4QQjBPt2m8j2t3x0aQqbVEBgPFj5E=;
        b=M+t/p1mNR/OieQtHSHxlUgMg6mZojmEdmn8BE0/tPHxr24/RIVfUI8dttNdp41ri5b
         URqyJShEvWJiPQmPONcTpfHnfppC9ccbeoRnneYUYi1wkgJegoVAAC8fBz3akzThQ4Dm
         vWjL/+C0lo6gHf/eTrbIIyCnIHxt5gkj6vn1DyV8v15eK/rz/9vEmfenicJshn64HUzi
         XolznWOhS095KJ3OhiBeX68rel9//JbJyW667L1WznbxeymGbSUExjcEehNNgOvQWIZz
         euGtOsFLJLPZgXETh/LetygHOxoGI5oUkYzy6/W+3PBgMI7bD6Af1VJUfUbc47bpdODs
         y+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817863; x=1794422663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IBjb/iCWXoppuO4QQjBPt2m8j2t3x0aQqbVEBgPFj5E=;
        b=HoZ9A2DgDlF50L64oprfiOzD5c7G02pJHrOZgSIHvhBloQXocUmmSpMWgj0CzIeS4J
         LD6YO9TI3rvYJAHQYxKfz/tU6TTPWfwcPZa5K3gZOX04hakK7v0+W3zwx/1J0t/NEixT
         B+dKZbgMqNNBv76LJIQ3/ekCI6/vpkyZHCeKMWS3eoOokcob22+71UIxYRK8PyjrOOY+
         0tROrRLNT4uObW+D3ppAywbvRjrIN55j0lNpd33d2d61IULR/YZFLzBG52ShE/NIO3iQ
         uULeP0EjWXZDW6qetCvLjvwy7XvmjuaIYhbz9bXkSvafl+W1QatQ2ugFJP7xotsAdf8m
         1KDg==
X-Gm-Message-State: APuU4Z+rShBe6EnIQmU6U95jRGi2AUktAtin4gTbUXNJiPDkzPjltKh4
	2lAdwamZmfdzDcrG4aMwAKlqTglL8qAU4tJJkkdCXrx3R5ZnODNEeqbtV3eBonKzUKdsOibDF+p
	+OioF4WM=
X-Gm-Gg: AYBFou3xh5Ne+HgpWmqnKyaz72t/JB3E9L5PZGKEvetLBAHc76LoyARbNFPSOlrqTyR
	FYQtPtHaGoskKderR3R/IG4ltR5FTOSjrhpEpKRPieMsblqBVKQMQJF//+mK/wdM+tYkBKBlUYy
	xFApNIVZVLIEEczluU2ePwFJrgGkWXUsUVr6+2k5noEvGC1W7cOpQLOU6xoL13v0Vq93dIB7W09
	uKOF8T0cnCfVAXpL68Y43xIdzomHWae7VQ3D8idgJilA1l88Vxo8xvgwJ2GPT8GjP2AmEpco7Ne
	WTHyMZjizPk8Low6sfQ0SaWCg/1XMBwjotGzgWBTDH8m2wccbevmNixJzn4TcYYIJDVacngxl0r
	wVpcmyVN/FrlioIsL+bi4/poSzWjIaYi/tLUWXERt6Ysboj8unXpfiZD58O1cY3rKH0znPqLQHL
	EXfSbsj0Rx8NrqFJeWB41QTVz8QHD/+dTPIPzwwWGZsrFEDPiuCtsjCKNy2IT92lFE1kxTRuyHp
	J0RWqN/8pkieBOr2iYCQb68qgRYA8LXHC3jN/hYHEb1WdipLki9BijZZPnnaXuZdXCzDgATmqDF
	XG7f6FOWX1G48FQ15Nx+Vegf65BEMyQaCl47g9BAYCJ849VP7J6DEsmeX5Q6I2TDOVR/pmUWooE
	4zwIfvUo6kRliIlEeJIo=
X-Received: by 2002:a05:6830:2e01:b0:80c:d30f:97e with SMTP id 46e09a7af769-85d3665eb4bmr13497690a34.31.1793817863145;
        Wed, 04 Nov 2026 10:44:23 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3e16ef1sm2540779a34.14.2026.11.04.10.44.22
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 06/11] io_uring: charge tctx nodes and personalities
Date: Wed,  4 Nov 2026 11:44:07 -0700
Message-ID: <20261104184412.516558-7-axboe@kernel.dk>
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

Commit 0b34e7b20a48710b6f53716bf7030920b69fdbdd upstream.

The io_tctx_node allocated the first time a task touches a ring, and
the XArray nodes behind tctx->xa and ctx->personalities, are plain
GFP_KERNEL. tctx->xa is indexed by the ring pointer, so nearly every
entry needs nodes of its own, and a task gets one entry per ring it has
used. 642 threads on 4000 rings held 2.3GB with 59MB charged against a
64MB memory.max.

Allocate the node with GFP_KERNEL_ACCOUNT and set XA_FLAGS_ACCOUNT on
both XArrays.

Fixes: 0f2122045b94 ("io_uring: don't rely on weak ->files references")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.18 has kmalloc() for the node, inline in
__io_uring_add_tctx_node()]
---
 io_uring/io_uring.c | 2 +-
 io_uring/tctx.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 04a90824c190..f1cd0e2b5b68 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -332,7 +332,7 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	if (ret)
 		goto free_ref;
 	init_completion(&ctx->ref_comp);
-	xa_init_flags(&ctx->personalities, XA_FLAGS_ALLOC1);
+	xa_init_flags(&ctx->personalities, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
 	mutex_init(&ctx->uring_lock);
 	init_waitqueue_head(&ctx->cq_wait);
 	init_waitqueue_head(&ctx->poll_wq);
diff --git a/io_uring/tctx.c b/io_uring/tctx.c
index 03c278aa5812..bf851ba5ca1a 100644
--- a/io_uring/tctx.c
+++ b/io_uring/tctx.c
@@ -91,7 +91,7 @@ __cold int io_uring_alloc_task_context(struct task_struct *task,
 	}
 
 	tctx->task = task;
-	xa_init(&tctx->xa);
+	xa_init_flags(&tctx->xa, XA_FLAGS_ACCOUNT);
 	init_waitqueue_head(&tctx->wait);
 	atomic_set(&tctx->in_cancel, 0);
 	atomic_set(&tctx->inflight_tracked, 0);
@@ -131,7 +131,7 @@ int __io_uring_add_tctx_node(struct io_ring_ctx *ctx)
 	if (tctx->io_wq)
 		io_wq_set_exit_on_idle(tctx->io_wq, false);
 	if (!xa_load(&tctx->xa, (unsigned long)ctx)) {
-		node = kmalloc(sizeof(*node), GFP_KERNEL);
+		node = kmalloc(sizeof(*node), GFP_KERNEL_ACCOUNT);
 		if (!node)
 			return -ENOMEM;
 		node->ctx = ctx;
-- 
2.56.0

