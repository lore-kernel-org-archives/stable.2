Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817830;
	b=J+Z2cJqfm3UYF8AklMsqVC7shHuusVQWthKfuXhF01I9ISGzjSNQL88lHj+JATzjWrbq
	 JXMwrMnBLYmfEy+5/bjvmdzo8DXGz1+RAlk83Pix9NL7elzPaIjZLg5ejXjY1AQK3xMY6
	 woTpOW+ui1bLGefEarufrQ75HPnfMtxIEpzVZ2Bu1hfGrx85cuptoJ9cVgs7y/crtMkkh
	 5GSMiVw8MvhpxqQ37ozGa+Dz22oDQ/CIDSF0g5jBSSg73CiOr1sWIgF+nZ9s0L8cgHBOf
	 4W+I9Ff4DWPoKM9K/h3JLk6265PkgtrUH13vlYho+5s0yh3uuXM90XRKEBWqM3T0vmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5S2lL6q1+XmgrZBygKR5ls/zfYCVTUdCBbe0io5PlBg=;
	b=DQcbb7anm2/yJ3ZI3mds2Brhe35pDIaaTRGGrK6cqxGLG3djQ91ho9mfMs9b/486QOsi
	 N54kt0vL+t3Y4BKvqL8qBEg5pqwaxeO0qQ0vmdDVTM9LdBK3+gGZkoJqOv2XfhBk/W3ou
	 tHmYOsiBmhjLRLN4e9aM1rCHaHAxKNUDkujS+DzDmc+b2KstPkqic8K4AB+dHd9aJ4Pda
	 Wj8nxGoC17U1NJOTUaDZkrKZMb8SwYKfhFmxoTD/LkSbc+FuiDcXNID4DQBrFYrsCqEt3
	 Vg4iDOVgQfYRHcWLhzTZ+fgkCC3/hFKHsWjTQEkt/81Wbo9Gy5GwXaXXm2TmXXGjq0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l5nAoj1N;
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CDA606D80D
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27CDA606D80D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=l5nAoj1N
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-490d838b425so619318fac.3
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817829; x=1794422629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5S2lL6q1+XmgrZBygKR5ls/zfYCVTUdCBbe0io5PlBg=;
        b=l5nAoj1NnzH6pDlrHGIkbY42+3aMkknzX6Xpdckdl2v2sgOjI2A+UV5t5HjyurRY+q
         rnI7v1eSYHJmBuwVQ9o8D8jdY4fE3ozpc7Y5918ml0eEuDnKpHbFku4IihvDL+iihiFi
         KiKQIJptWGVanFo26kMTH38aJnyd75gb/xlGcj5/ZhED6Gqz87HwV36s6fnrwShi71Nq
         cATPG8B8R6kZEr1Px3C+smdbRtH//PXsCNSLSQKGwW6lVe3YlM/AUChYLLn34MCE9dTh
         m07yvvL/aWHV7fsJXBH3mhhgXUmWl9MMou2yFp5JMOHzCOoYrDrepqw7+PqRVM8qEmIk
         1/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817829; x=1794422629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5S2lL6q1+XmgrZBygKR5ls/zfYCVTUdCBbe0io5PlBg=;
        b=GMhdtAWY0Z/se44b+Y9Ks+kVjRYC4gMRfHafvXV1thbxa9wVULFgZTlBMeZ3GIthFT
         Kz6pq5iKa33di53G/8Jwbe1J32NvIbY5Wq8SxeAtqhuvmiokvFoYUMt6EHogTQ17OOqE
         DOb+XvPMdm6cO/bJW9eRNscv617W8mirdeB381d95lFdwGvYHWle27kqpgwvk2sD9ZxK
         kP51o34/tiElJOCHAgdy+Z0E/Px3r4ss8mLLe5p8EqtreXadO9qdDLsymIHncoxTfIyv
         kg2oysELmLwz9mLNpfwA7e4y90wK2n74yoXZvY3m8D+GUT/8Wm0Cp6lHUIl4fl2nLFgV
         vubQ==
X-Gm-Message-State: APuU4Z9hjXjYnTWHpgE7Bo+eEwUKLEnM6UlpfdJnFXo7V3Ss/VSGIVuN
	/1SpjQU/grWfUjuS2V2GDsxyxEtBOFFulpxsHnvWfpk5iwafh56nhpiXvxF+5BuOpM24biMlmLx
	BfElrJBQ=
X-Gm-Gg: AYBFou1nnPygjPdtvcBYbcTrLz5xmGra502BYStrLJQWI3jDXTaZFNC6ka8CEKRxwTz
	wcWOBo2kwVgz+ZBVrIFsYCOtOVqUFA4WwvFLcw3mCti+eAaqC1o3q65HoJUifc1JbsAaC2GwSTg
	Y/ik6yv1wuohyY60mGrXLr6AUKAHLqSjxQFMaWfGgLPqwlJ1D0byNlIuA+C/A5q12iFNSHTlgpc
	y8t9rFKzfbqUkItrSfr4+ydnuBKnZgiDa/utn7b8H7CoAymiy0sw5BrGVhoxzOjXi9L6ZFmTRm6
	H4GimmUgoAFnbRzhVp1TrkXYZ/4NF2AE3iRABH4DAL0S+K5QfWrJR0hXDthjsiWUsfWNnY/tlH6
	f9kn5MFpE0tTdFe4bOI4qD+KBeJDYP72E5DMs8IMG84bZNnJJaeuNguD5agcy9gtStgqs7lAwND
	GjQf0KnQAhFAc2TTQvBDTJE6DxmFQPLOn+12xn0qVTNjkARCqlXyDsWhmlG6dZs+gNKG4QrTX9e
	l2szNlFm5bTl5Aw6wSpHOaXfZfgA4xqnDT/r7ZRFydm9AaolJ7OUN4hiMe3SCJkONtdlx1Nt9Pq
	c0oMrB6KnmiYAGN9eFlQDZpGjbbp/Rwobgbgt4otw0q3U+YTvXh84UrhwEIcSeJPTdVSNUfxEA=
	=
X-Received: by 2002:a05:6870:75c7:b0:47d:4a10:7303 with SMTP id 586e51a60fabf-4a9076f979amr10730878fac.31.1793817829057;
        Wed, 04 Nov 2026 10:43:49 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4acea61d382sm2595770fac.13.2026.11.04.10.43.48
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:48 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 5/8] io_uring: charge tctx nodes and personalities
Date: Wed,  4 Nov 2026 11:43:38 -0700
Message-ID: <20261104184341.516297-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184341.516297-1-axboe@kernel.dk>
References: <20261104184341.516297-1-axboe@kernel.dk>
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
[axboe: 6.6 has kmalloc() for the node, inline in
__io_uring_add_tctx_node()]
---
 io_uring/io_uring.c | 2 +-
 io_uring/tctx.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index bc47a7d745b5..5836612781ff 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -319,7 +319,7 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	io_alloc_cache_init(&ctx->netmsg_cache, IO_ALLOC_CACHE_MAX,
 			    sizeof(struct io_async_msghdr));
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

