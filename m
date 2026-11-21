Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296660;
	b=hgAfGOA+4WXA0jlrQBnkcyj6KrYl5AZrYX6Ju2GMP0SHZPHOl8yD295XR3oa200Ctwu5
	 aRA3vLSD/frlJ0WWjkbT3rrPGY1tY5/yiVNL1WSCGkCZJIHWi5lzUk3+y1WAYegxR08Dj
	 cB3dSOuRJ/rLXo5Er5c5PH45Z0NKHuePOq+fmrTNvlsaciH+RqDlrmGDZUcZO8AYrL4Sv
	 5+/VpD0SjwHUMzJJdQqi/3C5Keg4z0H4w/lO8n+ObJA0NSIzGaL/F77FTQ0Q2hYu47qQB
	 aJYUF/btMGTrREKrw/XbnftjCWJZxfnbilKQeifhR0boszcgbd0cDfCwJVq3iCPv/Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=SXokKDX2FRYdfasi8OubBdj/zcnTHgK0c+jbCiPd+bA=;
	b=AZfwiix3STTfTylgXqVeyuGPprgZbRvClg3Rcp9o+xEGMTdkjHQz63SPK2GI1kYgJgLw
	 qA/s9oX5gIdPptkRaWbMaMob93lqYFIJulApqHrL4uxhoRKQUkSeqcPzPn7Aep3Yo4D0d
	 Csucdpf104f3Q/EC6uWIhB989fETtKQ30SQsJS9vWFklPNql4VDVjewOvUaZxUjoaImoq
	 FOMCkWW6ztwtgJvYjEa3mMkDDqXG3BcYDseriqcvQb0fdLqy+hA9muKRascC6xmzQ1lHT
	 S6fyrlN0AvwSZYDdxty9tUB0vxaD3G0jxZ7HU7TEm7pBK/Rkqmy7hAuY8PR8+NxneKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b="s5E/ROqu";
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DCD606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37DCD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=s5E/ROqu
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6d68de53053so1517347eaf.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296659; x=1795901459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SXokKDX2FRYdfasi8OubBdj/zcnTHgK0c+jbCiPd+bA=;
        b=s5E/ROqujPIx0UMEO/0zd7W2hQkXnRLArIu7ZRCd5Hr/L44aGwfSdlM2aIWOGAaKfh
         iq88KqzNu/rNgx7gsogBkpKYORdUrJ0jHkRROM2Pq4mrqdmIlkY1/gb/lR1O5RBpOiTL
         kYtDYLW5QzEoEE9zlfOOdFG1to7k1ZcygrucoL1zCXctuY/EBljJAxS4cid/Gm0KWsyk
         0+6rNFo3JNP9mvn2ziu7E1kushw2WyW/J4OYuQ0+rOJr7eviKB6n2O7V77jk5Qdmf8Pz
         9FeVt1MnIx5B4UR/Z5fKVxrXuVB9lfOQYo8IFKxrANjXD9b+Yr6cUGONJwg93NEvNRa7
         iWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296659; x=1795901459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SXokKDX2FRYdfasi8OubBdj/zcnTHgK0c+jbCiPd+bA=;
        b=HnS8tT5kxdtjDU/RJKEUD85pfBfmHETxvECyDhxVXgyk4Gsm2UGxUF3QZvUvUQ7OTw
         dHDnTxNM3ntrvs98t4mMq0m86nXWuxD/ab9bY9gXyznUySIFeZkGwazf3xawi0lge/OH
         h89915m7nuJ56FA4cM6GNw2cd3a6fJUoZv33jRr8u+86KFCbrtrKE+l2G0bSHdHoiXur
         PN45DdGaNxBG1+IKNGTOLs11usJfc/VYZ6kBog3SBHsXCtWnTJxH9/SDecM207WEmNq9
         +fGloT7i35sUoiSlMKg938eZK43vzhOZ4dEJ4qdKEKRxCsSVqYoWoLGW2x90mLeq65WQ
         c0Rg==
X-Gm-Message-State: APuU4Z9ZfTb65HlpMgg53k8eHjsE6GjCTrbHCK/bZOrDP5ebzojq8Jhr
	hHdC3dUiS9gI1OW0a2PZOKlPLXasFzZ/iG2VSOCBij+WDIxUxfBJMWZH+SjiERKOxzTnB+ejM6F
	AkKzeDyY=
X-Gm-Gg: AZFdTZep0ZTWYdqzfNGvsV0O2ajCvqZ6YmQ42KLSNMPW5oDNZJdzVy1/qM8/on3ZjcW
	nAIsIUj7p8FrT4KxaTvIVDT1i52n844nnqccsNJ00QXsaTHR4vsNG5JSwTl2sRXM0xsgy5UnZJj
	ctDofjl2iHDfEOopG/hWkPksvwqgXl4gdETDsglcA5T+FGXwiKdLDNEJ/ZT5b+bqikJ3HCcY+oc
	Okc6yq90+47bR//OnXPCZAtvwXnxY2XfGX87w9yoc7IIEOFf7QzrX1y3wCwYw4RM7+XdDSoHwWJ
	EYpc8IiAO7tefKL7llUZJOo6mghOeFipBECA+DaEjVJaGKxrorTCzpennK7++5bWVk6WdSbvpJB
	tRMA7Gc0LhRjNWHDZcKYnZOEP4ZgS3ONaQjzusj05DE2xV5cQbSEko6sCCdhhClxqKWHyRc1eWW
	Zms58OqaDsgqGieslPTf35/tlZBbFYCQowbXc6C4zQoY5fAPhVo6ylSDxqvxvt0ZA5ron9Wy2dq
	bdWmdeqmN0A0eNaFB2CmMitXLdjJI6TLcmTbiiRulDcQ072kFMMh1yc2d2WqTUy0SXNAVrllQsb
	lzUFuY1R5MfOZlGOOctxjN0CbbFPw6jJXQwUyHC6MbsO4Aor4sN7ACYQWWjBUkTBk/q2AweCLSv
	hETIq8BBmnNIfA8uH8krccJE4X0b5wyWngZ/C
X-Received: by 2002:a05:6820:2509:b0:71a:edb5:3aa8 with SMTP id 006d021491bc7-71b395919b7mr4419531eaf.81.1795296659210;
        Sat, 21 Nov 2026 13:30:59 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.30.58
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:30:58 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 06/19] io_uring: cleanup handle_tw_list() calling convention
Date: Sat, 21 Nov 2026 21:30:36 +0000
Message-ID: <20261121213049.1788332-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213049.1788332-1-axboe@kernel.dk>
References: <20261121213049.1788332-1-axboe@kernel.dk>
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

Commit 42c0905f0cac9a86d2cb8138665a6d62ea607078 upstream.

Now that we don't loop around task_work anymore, there's no point in
maintaining the ring and locked state outside of handle_tw_list(). Get
rid of passing in those pointers (and pointers to pointers) and just do
the management internally in handle_tw_list().

Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.6 runs normal task_work in LIFO order, as it doesn't have
170539bdf109 ("io_uring: handle traditional task_work in FIFO order"),
so call handle_tw_list() without llist_reverse_order()]
---
 io_uring/io_uring.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8bbcab4d1d7c..96474d9ebef8 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1197,10 +1197,10 @@ static void ctx_flush_and_put(struct io_ring_ctx *ctx, struct io_tw_state *ts)
 	percpu_ref_put(&ctx->refs);
 }
 
-static unsigned int handle_tw_list(struct llist_node *node,
-				   struct io_ring_ctx **ctx,
-				   struct io_tw_state *ts)
+static unsigned int handle_tw_list(struct llist_node *node)
 {
+	struct io_ring_ctx *ctx = NULL;
+	struct io_tw_state ts = { };
 	unsigned int count = 0;
 
 	do {
@@ -1210,25 +1210,26 @@ static unsigned int handle_tw_list(struct llist_node *node,
 
 		prefetch(container_of(next, struct io_kiocb, io_task_work.node));
 
-		if (req->ctx != *ctx) {
-			ctx_flush_and_put(*ctx, ts);
-			*ctx = req->ctx;
+		if (req->ctx != ctx) {
+			ctx_flush_and_put(ctx, &ts);
+			ctx = req->ctx;
 			/* if not contended, grab and improve batching */
-			ts->locked = mutex_trylock(&(*ctx)->uring_lock);
-			percpu_ref_get(&(*ctx)->refs);
+			ts.locked = mutex_trylock(&ctx->uring_lock);
+			percpu_ref_get(&ctx->refs);
 		}
 		INDIRECT_CALL_2(req->io_task_work.func,
 				io_poll_task_func, io_req_rw_complete,
-				req, ts);
+				req, &ts);
 		node = next;
 		count++;
 		if (unlikely(need_resched())) {
-			ctx_flush_and_put(*ctx, ts);
-			*ctx = NULL;
+			ctx_flush_and_put(ctx, &ts);
+			ctx = NULL;
 			cond_resched();
 		}
 	} while (node);
 
+	ctx_flush_and_put(ctx, &ts);
 	return count;
 }
 
@@ -1277,8 +1278,6 @@ static __cold void io_fallback_tw(struct io_uring_task *tctx, bool sync)
 
 void tctx_task_work(struct callback_head *cb)
 {
-	struct io_tw_state ts = {};
-	struct io_ring_ctx *ctx = NULL;
 	struct io_uring_task *tctx = container_of(cb, struct io_uring_task,
 						  task_work);
 	struct llist_node *node;
@@ -1291,9 +1290,7 @@ void tctx_task_work(struct callback_head *cb)
 
 	node = llist_del_all(&tctx->task_list);
 	if (node)
-		count = handle_tw_list(node, &ctx, &ts);
-
-	ctx_flush_and_put(ctx, &ts);
+		count = handle_tw_list(node);
 
 	/* relaxed read is enough as only the task itself sets ->in_cancel */
 	if (unlikely(atomic_read(&tctx->in_cancel)))
-- 
2.55.0

