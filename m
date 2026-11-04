Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817847;
	b=EKX2hfxXIagwcVZFEyojCffOE4aNivv1FBy+v/jqhr67xWidaNyJm09nFg5Mt/fWCg70
	 wN3ZMCCMvJklTsC42HgcycY3LB97rh99nZPygH5hxYgVnOntebr55MyEqw3mKz3gpmQqW
	 C/Z4Dpzr4Fh1LtnOQ+7XNDo82y9aWqp8Ehz9ppPif2Oh58eCv6xSGb4X5uWORj87idPgv
	 Vxl1mVlVjVKmsoL2fkNYVdhiITzQR48FGcvtL115z3W1Cwj264IIyq0X+BALQtSKo8DF9
	 KrlyRKx8zAUExlGFUht0oX9koco4aP0nzzNgaTsR4hdSwBP/6T7/mcSgVSwKVR5h+/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=js051FxEjEBk07tnP5DGQP7j36TGHOjjBlGBbOJjHlc=;
	b=ZQFGj5gVmzR9TbpsPxgfktgMfLC5BqhAIl93whOT1CjCoVTIDfoIUv1C/mEgKOxUYur8
	 iAEXgYmwGJzNSJdiBIVceAAHBW3q9OfD06dnPjX8GreBt3JTzULVH/3gS6ZvVShJqpWg5
	 3ugNjMM8dbk8UbwJbm60GSG+kE5eS0v9B0N0vfujtMtwjb6nCEvtDMm3c0OYuejCkABYL
	 lngrxKLooUapOvxytu9xs9op7Os4Si8RwGxcbxs9fQCYWtqjd89CAMMJJt5xX7w2gjVP1
	 IN+Yj+CLoQCl+SHgKR0UFcx4/IC4oROrYMc452cYiTAMW/I6K55ep+yiya9IYrNfSYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="lBc9lJe/";
	arc=none smtp.remote-ip=209.85.167.174
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BBC606A338
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7BBC606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lBc9lJe/
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4f66bb2ab57so396998b6e.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817846; x=1794422646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=js051FxEjEBk07tnP5DGQP7j36TGHOjjBlGBbOJjHlc=;
        b=lBc9lJe/NzuucVHWo6JZg9cSK1//Pu0XfkMRSZdo/yfO/cJJHw16+9TMsgCIBQONQF
         WgWxZVCQgAcZAe6gQwrbnnNaECsuCS0yk69PCQkuqghDtgRZVRsGqtxpkPwOcgMxrWVo
         lfIvG8kbkDVYNsVZlLhSxETakZrmHz9n8xRzYA5sz3SIftGDSRFEBfSRNp26vzmNto7T
         WgP7omVSiewWZzAHxQBTQBEIIb5GG/F9weCvNQdWg0DpBSPA4bDGRvQbkvzYIo/sE9D9
         kz533P82JXzjbOx3ds8QnOnmpBy5+8jAlSzdoQgzg8F4NuJFZs9Exh0yu/AuodivFqdU
         6IQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817846; x=1794422646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=js051FxEjEBk07tnP5DGQP7j36TGHOjjBlGBbOJjHlc=;
        b=19T46a+Dfl1mx2CGABjNuTHu7VCVivBB494+i3qGdonLyLctzpTlaU35hglrEPOndS
         oWUApDuQTKU/WN8M6lRAWc/13+4gr2WpPzQEKRhWhprehkxN09TebiapNMSiS6wuqnx/
         PtOZGe4q3MFb2AoG6HqMr9NkvEholX6pq1+6m7TaRDUJoUI8wkliCksvaX50bGzyURtW
         xqWD3te4TJpwWjpYb8uoQQVC3YPs47jMMajIK/eyeGXkydaRC7TGwood0/lRBOfzOZnC
         xFWAtNo2t/XZJ3L3EVeExgKhMUTxYccP7/9b/NyjMofIWAeLqu9vbW2BCqADMi0fHHQL
         0qtA==
X-Gm-Message-State: APuU4Z+KBULJ+iazsCNfnrAjNM2/Q3wvtlBC4cYP7FPwdPbCDWAOheiI
	eNr8ZSoL0q0VOHuW/4DnKZRsGrXae7PMXMqo/E8KjCzRT18CMNAo7zACYKq5RHnEDoKXuWzHN/8
	pbwzNLnY=
X-Gm-Gg: AYBFou2kN/rNDU0sQKHdclWwSvZ0zcm6dVwMjtybN1LGeeWoBgl6O0AX6qeja383QXW
	jLlPG3T1ecNw0c4lM/fIJ8ep7izBrrhyvEZszRzjdRsEpVdBp9K2L0AKcTGpcFnDMGDujpjJOpJ
	mr1OQKQ0hXr7IYmSyKiNYD/raRBGv2w7a24mP/AypZLvFqgnqsH/Mw3lZtssEQWPcoSoFIHLKAO
	6BBs2rsBXE7OmItree67dw44/6caHrcxlMzY3cjJIflWqnGUZ4DUUgHTPHbyInl+gEf8ov68+5n
	HRTq8CE0sIQhAcrmUvfXW1HsVC1WVkkXqk3hu04c5bY/ZzWmZ2w59gP8pK+fh7J/IlkrxjUwuHv
	ymp7zTB02CPMG+8HN3KECYZOmWVTQqWthSZJrRbXyG+cK+sedjtCdaYHPbDs6I/KvhYvB5Vh21N
	avQUrDIQS2nrIPZe4BvTgGTxmeTb6JDBB0ybXODyM5+z/T/l2VZyG28hl3blc2pq2jbH4Nxx8C6
	U6sEhXLyKhdHmaTQhScpM7/IcPFMk+fbdf3rHbJTCMDYKrOFfBgMGeDkSeSdfKaPmz7FCgCv5vf
	4SNfCT24vPWILeg7k6qK9Ia3qa2vvWMY2FVRshhrYXEBR0rGnr22Ma9G8e6gsmS+wBqc66K/pA=
	=
X-Received: by 2002:a05:6808:3c4d:b0:55b:f8cc:aef1 with SMTP id 5614622812f47-5640ddfbf7bmr11922977b6e.15.1793817845588;
        Wed, 04 Nov 2026 10:44:05 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9fdfa53sm2199007b6e.15.2026.11.04.10.44.04
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:44:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 6/9] io_uring: charge tctx nodes and personalities
Date: Wed,  4 Nov 2026 11:43:50 -0700
Message-ID: <20261104184353.516403-7-axboe@kernel.dk>
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
[axboe: 6.12 has kmalloc() for the node, inline in
__io_uring_add_tctx_node()]
---
 io_uring/io_uring.c | 2 +-
 io_uring/tctx.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index fdf7c646da1a..6d1f06642c2d 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -319,7 +319,7 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	if (ret)
 		goto free_ref;
 	init_completion(&ctx->ref_comp);
-	xa_init_flags(&ctx->personalities, XA_FLAGS_ALLOC1);
+	xa_init_flags(&ctx->personalities, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
 	mutex_init(&ctx->uring_lock);
 	init_waitqueue_head(&ctx->cq_wait);
 	init_waitqueue_head(&ctx->poll_wq);
diff --git a/io_uring/tctx.c b/io_uring/tctx.c
index 8597bcb903b2..d056cce2c1a8 100644
--- a/io_uring/tctx.c
+++ b/io_uring/tctx.c
@@ -93,7 +93,7 @@ __cold int io_uring_alloc_task_context(struct task_struct *task,
 		return ret;
 	}
 
-	xa_init(&tctx->xa);
+	xa_init_flags(&tctx->xa, XA_FLAGS_ACCOUNT);
 	init_waitqueue_head(&tctx->wait);
 	atomic_set(&tctx->in_cancel, 0);
 	atomic_set(&tctx->inflight_tracked, 0);
@@ -125,7 +125,7 @@ int __io_uring_add_tctx_node(struct io_ring_ctx *ctx)
 		}
 	}
 	if (!xa_load(&tctx->xa, (unsigned long)ctx)) {
-		node = kmalloc(sizeof(*node), GFP_KERNEL);
+		node = kmalloc(sizeof(*node), GFP_KERNEL_ACCOUNT);
 		if (!node)
 			return -ENOMEM;
 		node->ctx = ctx;
-- 
2.56.0

