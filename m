Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817923;
	b=eCPzOkM10e4cHbyfm9Oj7Tu2cHkV2oobTbKONhB4atAUUlAs2TYyQBz/QGeW63d+pwkM
	 rrdyNiwvsDAweF5YgPVxoOWWbu+8tlb6QoRNejgTezisiKnuTTjRJJAMXRHjXs4cm5yLx
	 MqOqt5P/1/KH6IIdRGmFzJKCg7eHosiAP/g+mWEg7Hn45H9Osng9ppGyHNwT0VgAcqSxE
	 Y1hjLMwWP2tBzcS64UypK8nNa1nn3Ih/L1YWwcyYXWPsfd0IWGIZLWNvdOClh7ekgy2gh
	 YH/XwUMuFCwphaZnFtdbbRCJDf1d0PJ2o4htSs2N7fOiGqbE88+tOc3iLJ6qQvqS2TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/HJvCdMj9t3RgsVVdsCkZ/tzMLTDI1OvXVNAicOL6xc=;
	b=nnTgKJxX2VOQUDVSPEiUi/vmHVJ/+gho8criaJf7Gkti1UaxS2/Ay24IPoi+xYwbTTJg
	 EsnDkP2mSD9HJKpn2lF3PFeJ1poFsVvvRiyyjq9DgIOec9DRBHrijKNOgbgbCz01u/j2M
	 yFp4s2NGLQkGerDTW1AdYx8WE6uJOy4/OOomqwTHsk4/ce1p3CNEoqunxu/AK4Xfaq8cm
	 KuMtDV9X0+GwP0Sv81z3lria2XrXYD1GmXXcFaz/jgpAWkVuNR+8N168xYZBzDafrojOs
	 IVtFgoRb4SKIOaDcvSA3mKJRap8ElyGI//21RsZl9cXW/SbcY+MTEN/jvuLQA482j2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ardWqYlr;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F45606A336
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06F45606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ardWqYlr
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4a6bb779d13so675127fac.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817922; x=1794422722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/HJvCdMj9t3RgsVVdsCkZ/tzMLTDI1OvXVNAicOL6xc=;
        b=ardWqYlrgh0AIawM5Nj4BdUuTrPvEPv75lLcj5DBOO3bAwYlVsXb0tsQWXzdLTCEFC
         XdGwrh1SGzCOmIj7IiczHl6Y94EAGQ7ge4KxJbH+Do/NTbaXNnzVgbZ3EgVDfFV9ws20
         ckDsi9U55hk4W1dgl+2JsJIX7OEQnkuIkp1ZdMb6I5TA2+XQTPGA6Fpmzw16lBCrCa1+
         mj+knzgbfzUIcTN+iNJ0j4irBjWG5i1Uz3J9layFgO62MHRUyc6ANYDUE4KIoLE9F8kF
         iub+5OWZVGZ6gb8wzv48gmrhL20qXlprXJLUQcXzEqyyYoaFtE1s9qleY6wr+9bzF/83
         d20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817922; x=1794422722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/HJvCdMj9t3RgsVVdsCkZ/tzMLTDI1OvXVNAicOL6xc=;
        b=h1gvsBy/IceXhiWmnqSh5gXgQhvKn2YbBVLZJyymBSWKkzTJU3+4uQ/5stMEmmxk2o
         L0r1S+d6jyorEokMY3TpTaR9qENGpKzDxlu6EQavVCkDqgxD1lgB1XN6NcjkPTxJyd5v
         jQ7PCGPpp4y6bU15sp/rY67chEak54GBBlVtx70lxQQvsSBsbaLjgkRCtigXpIImUWmu
         pKmQ/Xc4FVB1+UsbFtmXqW9YyG2liNrIZveURvYa/9nsL/4Yd6cA9pEw1GoYtGnJJmkf
         TR9wNUYLGHVoVgN2tHk3ldRfMSPhrAqUBYgbqMZYMrjnMQWn0yBLLr8v8MG1/NsP0Kq0
         90Lw==
X-Gm-Message-State: APuU4Z/t2SxpL/6AA7ul//Woe8xhWov/Jp/uMNmOXD0lBJEoS5yI3iWl
	49BLO2KIVzMjqZMpqTqmx7Leg7mkzsucJUYwT+c7Jyfyh5+fNTt1Gsn2vrJJLNBjs9XaczTzC09
	Rv0VXx4w=
X-Gm-Gg: AYBFou2zQMJvmXLcnXtmHSWmiWEVi6jSiH7qFSvFUkvFWSolLN4Cqlbs6JoQXmdtcKr
	EAQoCxXg6ZlvuDETiNVXWxqIkLBOyJla/EjaWlCpEcHMpnM7yT39BJ4mhc7ZcQxsMZQIzYCuMgl
	jWf9PJqXZG6hlvYAK+iOy43zSbhO16zpG+7RSJ1BrNnGijLHztWSZkXOrDmvq7DEuXgoVA0/nKT
	09j1KxeycMVDgOt5x/+e1cFOpdsybWZHeo5uTFFaLeaBKYNAXBuWgZbtPU7Y2Mnn3vaFB6Dnppl
	zXXL/ODasMV+yUI2xq3Siz7p4tmuLNez7ugQ05NLBFdCCbI0SuBGhUnnsqYewWxcEZkhO1UzPbc
	G77VCwWqtVZkX31foK1PRKcqm8f17Pc7G1eXkuFbULSstWx7CCDRmTFDRO01ODvtOLdoPSRwalz
	AO37TLNrbD3Czv9bt0IHv8emNfzk/za1wK8+fcbHTx6NLCz0yB5AGm1ORiRfNwt5tMQWT7dNYsd
	WAKlnBLA3FKD8ZdP8GjYR354BzyBTkjr4beM6/Ly0RJebQ3lhBXjxE82MxCsD6qaSwtpY2fTpxO
	W9XdxpmWj0dQq50JX1InwxZKiXT05/Rh24xMSCQBB5JGzqfTxAHFmXueB1LxuSHOb4EICXyyyQ=
	=
X-Received: by 2002:a05:6870:a79f:b0:47b:7862:c1c6 with SMTP id 586e51a60fabf-4a9076b7670mr11797279fac.23.1793817921856;
        Wed, 04 Nov 2026 10:45:21 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea4903e9sm2590963fac.3.2026.11.04.10.45.20
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:45:20 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 09/16] io_uring: charge tctx nodes and personalities
Date: Wed,  4 Nov 2026 11:44:40 -0700
Message-ID: <20261104184447.516768-10-axboe@kernel.dk>
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
---
 io_uring/io_uring.c | 2 +-
 io_uring/tctx.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index dd6ad02d0e89..f218a1ec3f09 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -271,7 +271,7 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	if (ret)
 		goto free_ref;
 	init_completion(&ctx->ref_comp);
-	xa_init_flags(&ctx->personalities, XA_FLAGS_ALLOC1);
+	xa_init_flags(&ctx->personalities, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
 	mutex_init(&ctx->uring_lock);
 	init_waitqueue_head(&ctx->cq_wait);
 	init_waitqueue_head(&ctx->poll_wq);
diff --git a/io_uring/tctx.c b/io_uring/tctx.c
index 466b7300e208..4dedcdc44780 100644
--- a/io_uring/tctx.c
+++ b/io_uring/tctx.c
@@ -104,7 +104,7 @@ __cold struct io_uring_task *io_uring_alloc_task_context(struct task_struct *tas
 	}
 
 	tctx->task = task;
-	xa_init(&tctx->xa);
+	xa_init_flags(&tctx->xa, XA_FLAGS_ACCOUNT);
 	init_waitqueue_head(&tctx->wait);
 	atomic_set(&tctx->in_cancel, 0);
 	atomic_set(&tctx->inflight_tracked, 0);
@@ -123,7 +123,7 @@ static int io_tctx_install_node(struct io_ring_ctx *ctx,
 	if (xa_load(&tctx->xa, (unsigned long)ctx))
 		return 0;
 
-	node = kmalloc_obj(*node);
+	node = kmalloc_obj(*node, GFP_KERNEL_ACCOUNT);
 	if (!node)
 		return -ENOMEM;
 	node->ctx = ctx;
-- 
2.56.0

