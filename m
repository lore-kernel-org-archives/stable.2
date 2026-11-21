Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296687;
	b=qlXaLy4IW+hll3BuHkxq38kFlNdvi1BqUtEbg8/b+hXf/CTSAIuBas3SCk4Nsy5mFMCh
	 UigQAqEvoZ63SSz9s74n9almusGKfcs1ciU6IZJyayioYbWVLaB6eo01Fdx8Hd5QNuHjR
	 /fKWUiKzexHiC3Lr5M6kvhK8mifMOY2TW9RaBdX8uj0MwJnvmfKnVvg6gnzVHwZwO7bWb
	 lkBwKWwTyir04hlyrNcEej+jXkgw72/pJ4b8Xg7ScTruz4Zo1rfySQYTZJFCakF072eXv
	 XGygDDA9WOLSqAzSaIy0yFr2ijG60po902KLwqY1TZIVFtuMP9V5S0/2lSYpJkFfyFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ln+/jshLuzca2+9hJ+1AJSTnLbqdXhB9494WXRSLpWA=;
	b=t9WRZaSCX1bbijZeryJ7wrv0MufIuzArbfjhpGWFPmW8mT1RWo+L1R4i9bjQW5HK5RUT
	 I2D55cOokbzwvUC7tuSmEwV2qYXMFqzuw9pZyJlyKjhujlo5/I7DtmBiVpwRLb4M8O+VX
	 T/JouURGresgmAiEdTlYEmhaph2d16ZRUoPK8zUgW1cK1dHqYU6edl+Q2wbCsbvKIsVxa
	 qTRDX+us/HKUMRaPmvAz1HIh8ral6y4oReJSXSQ49qHaQGoObciPdy6G/b3JyZa/38JDA
	 iN1ltjNJ5VNJD0jmQWbqDQ8ZM/bPvK/sfjrt5YSyC8u9vQw+++qRasODURuahmTUVEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=f2SNBN44;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9A4606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD9A4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=f2SNBN44
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8629ef8613aso836752a34.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296686; x=1795901486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ln+/jshLuzca2+9hJ+1AJSTnLbqdXhB9494WXRSLpWA=;
        b=f2SNBN44ugua0v+6K+yGfn82095GDw2iONl7j7Kc1n8FuAgYznnBPFNhyuXY7kcnnt
         8OzCYTEDNh7RQ4Ga0I0+kZjSBuTO3ENEDhOr+BmALwiVE8kDWx3VGijKO9udif+QibdC
         RZe+sIGeGaXi8J0HaLE0O+yaA+AqXF8IRuwkHPfhKEebjed/lJY1MvT1w+gomnr6PXHp
         1fPIHyeSk5mrXY901Csv6a+6rMGhZHXMFgmyqGzLmPY+4wOWn7cBHilOz17WYPOcI7LF
         unQ6CfwMuH82IpN+y/reG1VJprUGwvfMQIrWhCHYMjZUJX0I8n9RZhAt6mrUO6wJVN+p
         Ackw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296686; x=1795901486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ln+/jshLuzca2+9hJ+1AJSTnLbqdXhB9494WXRSLpWA=;
        b=EPO9koMTUg3MpUXESAIWYlFvT7QrD1ZujTV4OGZn9vaRE+KDXzqPg4F1CYIVjaic73
         LL/819T/IzzR0uqc39u5kgzQNeo9dlwU4TDw6pii4QRiuqewuUspXm0++DgrfsVALx3c
         KNGW1Rgkyo1Q2BXaiy6IAXYya357dnDG9ilx31tgWiqvSBef7OjWkb2FnVOGqEnNz5SZ
         3yXIYJJEHwb0MRnUnQd26Mj04ykXsEZGrTYUWOh80BlyEe27PvCC6FPeDRjqEq++DH23
         XnrfnMNmm1pXd80s+2T/07u7DSsdTjNersgwT2efUPZ6AhIAfDshVQV8MI16bWNC8Ljc
         ntog==
X-Gm-Message-State: APuU4Z/ODcpYBARfKGwhEqX7TcjyhxI4sPCaqGewK96OnxZovE0W5L3N
	GELLyb98P3ebEc7OKuDPp7TeOifdnva7aTPjdHp0CmvI9PL95HziEItWObJsUHyo6sG6/43V8VB
	NIKHzteA=
X-Gm-Gg: AZFdTZcc80CuJg+OZ5YASCYUbuLsIyYp8nzOWi9Ax0rPYc83p9VHLAzsAa9P28qVUeW
	Q/hmfT2pFj7EEKUTQj2qRHMTzW4SHIN3n6Y27llgzPcACeIufY9QUkAQkJzHPz8CXu7nSn1XHyi
	BBSjBeO5yWtnZJbiDiqNybUBs7gnMZV+xp9bXyp29qIfnNWHuI4+CpMUVohBDDG4M2++8MdzuXE
	79ZfiPWAysF6r4d2tcIYMWIMJEgwUpkmVQn7OjVrARko2J11edvfu1j+sQ0949aeD7VYcZ2KFqL
	IJZOzZieG548bdSitoJp/JzNmG3hoYrXyRZphoyL/p3RTU8+IJcxoEtP/0K7Yo/n2WK05PQWc8y
	kiq/yTp7+LA5ucILkLLVGAwO6aFS2QM8CqS+kMqq+3/ZfA3AIecKBylKHVis9bp2opG2lUrQs0u
	WkQz2LudT6n7EEYRROIwqaMDh//LM+zY9V5qwwOcXhazSMQ6IWq/pKMFlIf7xNM1giJK39I+GP5
	wZ5bU/bIlyftTbZ6xas3YGbKX16o4Hj5P1XtYh55ybPv9n1UAdWFRE6GkWiRjD7IiAAUtaEWf3A
	5psMZduz9mchLGcvpSfVg6S1x3h2zRP6CWD2mwxVFixR/vS6JJIoTdYxiO0J/EsWY0Sg6M8CWXK
	DFMbITW5TydxgpbBjDbEmyaKSnhC0VqI5nAqm
X-Received: by 2002:a05:6830:2b0d:b0:862:9ae0:8911 with SMTP id 46e09a7af769-86315491031mr8486575a34.6.1795296685820;
        Sat, 21 Nov 2026 13:31:25 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d33sm4946113a34.18.2026.11.21.13.31.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:25 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 2/9] io_uring/napi: don't end the single NAPI busy poll early on need_resched()
Date: Sat, 21 Nov 2026 21:31:14 +0000
Message-ID: <20261121213121.1789042-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213121.1789042-1-axboe@kernel.dk>
References: <20261121213121.1789042-1-axboe@kernel.dk>
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

From: Cinq Prairie <notprairie@gmail.com>

Commit 39c7210e970200f8b17de3767c73efe64173a95f upstream.

With a single registered NAPI, io_napi_blocking_busy_loop() hands
io_napi_busy_loop_should_end() to napi_busy_loop_rcu() as loop_end and
runs its own loop once, relying on __napi_busy_loop() to spin until
that predicate fires. napi_busy_loop_rcu() sets NAPI_F_END_ON_RESCHED,
so __napi_busy_loop() also returns on the first need_resched(). io_uring
treats the return as the end of the busy poll period and sleeps in
schedule_hrtimeout() for the rest of the wait timeout.

With two or more NAPIs the inner loop is single-shot and io_uring's own
loop runs until its predicate is met, so busy_poll_to is honoured. The
same registration therefore behaves differently for one NAPI than for
several.

Make the busy poll deadline absolute, stored in io_wait_queue, so that
io_napi_busy_loop_should_end() no longer depends on the start_time the
napi loop snapshots on every entry. The single NAPI loop can then be
re-entered after an early need_resched() exit if there is budget left,
and the loop condition drops the "run once" special case. The fast path
that holds the NAPI across polls is kept.

Measured on io_uring-7.4 at 9c207aa58e54, x86-64, HZ=1000,
PREEMPT_DYNAMIC (lazy), no CPU isolation, low RX traffic, r8169 with one
RX queue, prefer_busy_poll, busy_poll_to = wait timeout = 10 ms.
"waker" is a SCHED_FIFO task pinned to the polling CPU waking every 1 ms:

  1 NAPI, waker, before:  busy 0.5-1.5 ms per 10 ms wait, ~0.8M polls/s
  1 NAPI, waker, after:   busy 10 ms per 10 ms wait,      ~16.2M polls/s
  1 NAPI, idle, before:   busy 10 ms per 10 ms wait,      ~15.3M polls/s
  1 NAPI, idle, after:    busy 10 ms per 10 ms wait,      ~16.2M polls/s
  2 NAPIs, waker, before: busy 10 ms per 10 ms wait,      ~7.2M polls/s
  2 NAPIs, waker, after:  busy 10 ms per 10 ms wait,      ~7.1M polls/s

The held-NAPI fast path polls about twice as often as the single-shot
path used for several NAPIs, which is why it is kept.

Fixes: 8d0c12a80cde ("io-uring: add napi busy poll support")
Cc: stable@vger.kernel.org
Signed-off-by: Cinq Prairie <notprairie@gmail.com>
Link: https://patch.msgid.link/20261027204840.7823-1-notprairie@gmail.com
[axboe: trim comments, drop __always_unused]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/io_uring.h |  1 +
 io_uring/napi.c     | 31 ++++++++++++++-----------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 628ced4b44b2..1cdfc5725e01 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -48,6 +48,7 @@ struct io_wait_queue {
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	ktime_t napi_busy_poll_dt;
+	ktime_t napi_busy_poll_end;
 	bool napi_prefer_busy_poll;
 #endif
 };
diff --git a/io_uring/napi.c b/io_uring/napi.c
index bdae13367e0f..ade35aff6375 100644
--- a/io_uring/napi.c
+++ b/io_uring/napi.c
@@ -107,19 +107,15 @@ static inline void io_napi_remove_stale(struct io_ring_ctx *ctx, bool is_stale)
 		__io_napi_remove_stale(ctx);
 }
 
-static inline bool io_napi_busy_loop_timeout(ktime_t start_time,
-					     ktime_t bp)
+static inline bool io_napi_busy_loop_timeout(struct io_wait_queue *iowq)
 {
-	if (bp) {
-		ktime_t end_time = ktime_add(start_time, bp);
-		ktime_t now = net_to_ktime(busy_loop_current_time());
-
-		return ktime_after(now, end_time);
-	}
-
-	return true;
+	if (!iowq->napi_busy_poll_dt)
+		return true;
+	return ktime_after(net_to_ktime(busy_loop_current_time()),
+			   iowq->napi_busy_poll_end);
 }
 
+/* Uses an absolute deadline, so the napi loop can be re-entered */
 static bool io_napi_busy_loop_should_end(void *data,
 					 unsigned long start_time)
 {
@@ -129,8 +125,7 @@ static bool io_napi_busy_loop_should_end(void *data,
 		return true;
 	if (io_should_wake(iowq) || io_has_work(iowq->ctx))
 		return true;
-	if (io_napi_busy_loop_timeout(net_to_ktime(start_time),
-				      iowq->napi_busy_poll_dt))
+	if (io_napi_busy_loop_timeout(iowq))
 		return true;
 
 	return false;
@@ -157,13 +152,16 @@ static bool __io_napi_do_busy_loop(struct io_ring_ctx *ctx,
 static void io_napi_blocking_busy_loop(struct io_ring_ctx *ctx,
 				       struct io_wait_queue *iowq)
 {
-	unsigned long start_time = busy_loop_current_time();
+	ktime_t now = net_to_ktime(busy_loop_current_time());
 	bool (*loop_end)(void *, unsigned long) = NULL;
 	void *loop_end_arg = NULL;
 	bool is_stale = false;
 
-	/* Singular lists use a different napi loop end check function and are
-	 * only executed once.
+	iowq->napi_busy_poll_end = ktime_add(now, iowq->napi_busy_poll_dt);
+
+	/*
+	 * A single NAPI is held by __napi_busy_loop() for the whole spin. It
+	 * may return early on need_resched(), loop until our own deadline.
 	 */
 	if (list_is_singular(&ctx->napi_list)) {
 		loop_end = io_napi_busy_loop_should_end;
@@ -174,8 +172,7 @@ static void io_napi_blocking_busy_loop(struct io_ring_ctx *ctx,
 		do {
 			is_stale = __io_napi_do_busy_loop(ctx, loop_end,
 							  loop_end_arg);
-		} while (!io_napi_busy_loop_should_end(iowq, start_time) &&
-			 !loop_end_arg);
+		} while (!io_napi_busy_loop_should_end(iowq, 0));
 	}
 
 	io_napi_remove_stale(ctx, is_stale);
-- 
2.55.0

