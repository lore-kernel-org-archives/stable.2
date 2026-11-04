Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817817;
	b=CYazGcTRLlYMkihvN9TN62ME3lVe8HnPy0fwMwMbJAR0sbrw0POU58SMqy/97KL6OmWv
	 bH8fz5TY7qZ3S4JHPAtkrai9Y+1iwKRzLxx7zXoYnWUcgQIqx2iCpQ2gQqROazi8SWI3n
	 /rw8GPZzweMnsQ0aQq4IHyxFD0ixdXuy9cDpYpH62P9ipa6oOyV1sY8WJZDbq8jgjVXyz
	 dwnYSzlPspoaZWD8IPxJH/KZb+57qH6EJzdKE13REqNtPQv/qJY2NGwmvK53yJ9YTgY29
	 A9YoWNk2RVofdaYmzEq2TyW/U8eEPeAzN1183BPh9/zFcKuoHp768ByWAO2r6jKBEqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xJboGRmmT39Hh2Be5ywGcNbnwDCkz01+zRY2+/nLuZg=;
	b=FmC4Axda5Dz1YtPePUF+8xF7mYg5jGDIfnh3oaJ4B/N3Zo45t4P3ctFDImBAk9TdtUYB
	 4qC0xH8sJMZxav0RkpTRM3dqJqGtELB4Ko5N0y7FC9WN7QX6za2O9R85+PekrFxHeiHFF
	 sp2GhZdtrWf5eZXz+C/5NZcJ2I+pmyyJ49qcjlEIoT/ixmfFcOMQkkfdtjmjcK74P+9/K
	 shdWPVTm1v07EtNF9t//3OVpf0BqIFbayQ4Km2b3Oggwp5yZu4eiV1Yy9IP89291IbRTc
	 w27sDfR3Xzyc+Miwo78OutcUYjOqs96PqHdeX/A2tCnXywAsaGS9i4hqa7J+jt8k+kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rNWuQodj;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEA9606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EEA9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rNWuQodj
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6aa9606ddadso705868eaf.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 10:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793817816; x=1794422616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xJboGRmmT39Hh2Be5ywGcNbnwDCkz01+zRY2+/nLuZg=;
        b=rNWuQodj51/Fx7B3FH0q/3qT/D7jzca05K1n0qg/XHuVcZrW7X3tHURrp4qktZmaOd
         C7m2gP5OFGZ6yd8Xw20BOgd5TX/kYEeUZdsGfr2wM7MAYN/HClEbezpidSRnwEDkOCQ+
         Ggq9FxUHbVl3lR0109GFCehFKK0Kl3ipqcCJS+b43shdRa/NzOaKVSvI9A+BwrNzh46f
         na3wbCkPS/0B4lq8iMw9Vdeec5+8dVBUhbnwnzAAHx1nTILlpPiXoZBPdKaX3Aym9+cw
         /YLHYUCX84GVOcthrawqeOY5m8ZIHV1GXUlltfkFyID+2RzYD9SQdMc4OuvvoogH5bx6
         uG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817816; x=1794422616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xJboGRmmT39Hh2Be5ywGcNbnwDCkz01+zRY2+/nLuZg=;
        b=OneAu4/7ueDzW3Wo0PduOVdTic4umfRc8gU3z/63qX1Sw8hRDqgJUP3SKodbBh9Pfz
         rXqHUzcdL1q5XG2Hp61UrCv+wazlWx3vqXLpsxCuMl9P+8TLXVXoE5aVr9v2uYcpVv2B
         8A3vQtQeUQvXeREgiYg67lTnHHy82lxc5xQCOcKfiL3rqiAdyPKIOuKR+TwYxkwaNhVo
         YlhPV7X1p335XqsZHAGswtPlWK7JO8jV1ZDObECvnTRqpzgpFudyKBWwvA1nze9VTTUg
         /ytmGPejE+ZU9vs1A1WLKocfYOfZEW68BibWXFJFpMXy7S5Q03jDtBiyHXJQBvMip9xi
         y7hw==
X-Gm-Message-State: APuU4Z/wh4bAsYJIkyPrdXHJhzDwWVzKBLx4Uq1Gya2gsN9VUx0I9rlq
	wNf1+ATRCytSD86GxORIsevsOXeDFDT2yztXUNPz1sLatuAnYuM7j1ekdGf4RHFwyRHAandVEtB
	8FerNBr8=
X-Gm-Gg: AYBFou1EnK46Z60pue5gB8bCARCRV5B4pH6UvZRncK6q3N1HlVIuVBcKF2G1w1224gM
	E86MS7d0UneEqEJEpoqh7JZeVZWwmO9qGqiaqo1u2oIP+q3hlZYGH3TiL9BoO8uK5rtY2PErPeJ
	5dWE7dDSXYogng/iis/3X7QypwwyShM4XsCHFor0Ru602ldDqwqdIzYIFKOYNR4M8xo0/VbAfmJ
	PM/VcxA5ujsWharwJJjulU+Ja9yyaaQueUyi/q2kfLg6GREeBWdrllrVGJmPSupYbj0yF7t+7ow
	juzk6w4HeKPNNArRciUjCmiFHZMfcGVdq8jF9LfnWUt3pPecuawK390SNhWvoL4HO80Hnb9A7Oi
	0zH2fvppaZIvRvij8KyeLfKTqAlB8qwkBOfjE0KBPEtwCRhH4oQ5smIv3Un2bJ6HqoSwo7jkS50
	ReZPG40xxPghtIbbJQi08/ys1x4LrrQC2S/VTlAMWvmG2/drbZTBYXzVDRewAtpdJeePNu9AXFR
	rHhgj3xADLLH2iR9bXng+xDxGq/E8yi2OfWWq1k1HOrIDs1GttJvM7puOF0+4vCUI3H4jUFCSf5
	J4XrmmUmHKzXOdEDgdtbKUcbki98CLO/MbtOP0HsMDcaDfb11b4MRdLnNf7ZHSXN4EnLKQwcKAp
	M+iOK2C6Ru0w2suFlRPA=
X-Received: by 2002:a05:6820:2206:b0:6f8:2e98:cfcb with SMTP id 006d021491bc7-714f29f9a6dmr9705962eaf.48.1793817815958;
        Wed, 04 Nov 2026 10:43:35 -0800 (PST)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85ef3d74959sm2578834a34.5.2026.11.04.10.43.33
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:43:34 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 5/8] io_uring: charge tctx nodes and personalities
Date: Wed,  4 Nov 2026 11:43:25 -0700
Message-ID: <20261104184328.516206-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104184328.516206-1-axboe@kernel.dk>
References: <20261104184328.516206-1-axboe@kernel.dk>
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
[axboe: 6.1 has kmalloc() for the node, inline in
__io_uring_add_tctx_node()]
---
 io_uring/io_uring.c | 2 +-
 io_uring/tctx.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 655674be3859..dc4ff66ac64f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -299,7 +299,7 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	io_alloc_cache_init(&ctx->apoll_cache);
 	io_alloc_cache_init(&ctx->netmsg_cache);
 	init_completion(&ctx->ref_comp);
-	xa_init_flags(&ctx->personalities, XA_FLAGS_ALLOC1);
+	xa_init_flags(&ctx->personalities, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
 	mutex_init(&ctx->uring_lock);
 	init_waitqueue_head(&ctx->cq_wait);
 	spin_lock_init(&ctx->completion_lock);
diff --git a/io_uring/tctx.c b/io_uring/tctx.c
index e4ec8c0411ab..d2da97d86f44 100644
--- a/io_uring/tctx.c
+++ b/io_uring/tctx.c
@@ -93,7 +93,7 @@ __cold int io_uring_alloc_task_context(struct task_struct *task,
 		return ret;
 	}
 
-	xa_init(&tctx->xa);
+	xa_init_flags(&tctx->xa, XA_FLAGS_ACCOUNT);
 	init_waitqueue_head(&tctx->wait);
 	atomic_set(&tctx->in_idle, 0);
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

