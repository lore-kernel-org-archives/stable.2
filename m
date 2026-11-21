Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296703;
	b=eZEHr9zb1p7GjMkCbmiwu4oV0yIcBWeG94tvgO8KretD59sbaRg17V9s3r1QJ5dZ3BzV
	 AFRBtfZl047dljwYdMol1I67Whf64TIEjgrvrEKbkz5oPJNDb8kJOv7NPHCtZSHAMydhN
	 cn+0BxQXr3LsQzr0NjpgpYOipVqSOEY/UaXh212993UjCS7JuvdUu7N48JltAK7jq+X3t
	 qBkmIPJVbEL8ezOZu9QSAZMNWGgzEGODukm9IHiEJdh8BskQbasOrX2mdRrahY4bPULRj
	 s0qr8TS3/CZyQQAKDvaKeFTnX+OtJu95Iz+8DNZ47jxqQU7gt7btfxSrnsh8pLO5BlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296703;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q5B/RRqusYqW3h3JjU8mSzh0GXhqmpCkdS858sP9cyc=;
	b=tMupHUZoFWvJCsO24Z0hCM3AIh9CZLULc/LvX2Th6AA6I2nJYRhSZBc7LtRT3bCbhybH
	 ft3JsCjNvjfPjCnTs/B+TrIFqirvj1fFKzafAxsCcSbF9YxRuzRndN1hm0QaacENhDkOB
	 urt1/an9Ph7MiQqV2U6GAV7yWiF4ABrptAKs3UALX5K5XCaPg4im6aMvvkEPm/nL8+som
	 wNtKSiUDMBkWXulUlAvOw9kYlVwp3AiEKmSIyHQY66vNhxxHfOxvXXNZPsucZDToVkyTB
	 PtQhZ9DyTQlcTZrRQTSA/Et9lpF98TY2E4MlDKLbHTA158Xa6+LOlaqzGfIXJzAj6Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=Qzfva0Ut;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1A9606A684
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C1A9606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=Qzfva0Ut
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-717080a2d50so1972631eaf.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296701; x=1795901501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q5B/RRqusYqW3h3JjU8mSzh0GXhqmpCkdS858sP9cyc=;
        b=Qzfva0Utt+TxYPSBA1+sD3kBeP485LDWWHkTaQnduiR7qmRvc0/qs8SLX1qXA1L+Vk
         8HjyGNdpf9n2cwMEAuCEk7dQGDwjwQDQ5SBPLWy4k03yGlVJlhqYbISAwPa6JKWGjWfO
         L587O2sxL1/s/ho6e6eo8REh7f6g5O3mvxWQZIJOvSmXmuMFl0aLjriGL/94RhwpB4yq
         B/J74HgnTgak+IxAKPgSnTYJtbhbfAiiV6ixfWgFrKb6zUlm/HZptiEYzdPo1lh2RAbl
         JSzS+fCio/Lc5zlxsu2ozKQwY9LXBc4UWAROq5cqHlp0z9AehFKV/s1S6txCfvGN0uD6
         ijvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296701; x=1795901501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=q5B/RRqusYqW3h3JjU8mSzh0GXhqmpCkdS858sP9cyc=;
        b=WCT0t03n4W6U/RxOtpMMGrLUxo6yxN7yMvdJgsJcbSyi3im/S02dIXBZufULJ7WYme
         oh8zXahHJqQonPxwPgG8k81UrQrGot9G4um2WwjsbGU1jRVGwqyzaMmT2yHpHuhcjQPV
         vMABnzz4/toMi/4sTzfUTXI6G1wkO3ORMsyib0N0BHKTfo26AlAByVsijeQUFh7eDBUK
         YWuGscSvL85bsGVYQW38xRGIGOk6USuF8UVFdhvQh3sZEnllVe6VueOPLpq2c+uqs1Oi
         +Rqono4iKQfNG8u9L5O0OCs9nAVgutsax0PlaHo9lqLojr7iDOSYL+XCrKJujWQ1c6Pd
         2jIw==
X-Gm-Message-State: APuU4Z/7tfRZmOCE12e+1SApQ7O9FOJQAQpr1U9h+bz+jN1WL8kwguSZ
	1gUkhVpo+s1En0DCCc9mGAhtPsxueHzsD0B02FpYGukHjDVynVdAEAdiSqMSEo8MzqmBPgB7sA+
	+ig0+Kl0=
X-Gm-Gg: AZFdTZeBpuTn0/iW5aXfOEXWXbg4/Iz6xNOmzAVruu8VOVz4r0lmQ0RSfDwyz8fFBU3
	LvMJMQOO3K5169rqCIUrLLVsDT2/56LbZUsejXCRSISSoXBK7H8GqBf1ZIg+Hc66eSP/s60VZFW
	YIa/ylliNjFivCuzf1xUHcEneMbRKQ1gNdTk0gkbtHoA4dYTXRRjwmj5WTXfXLTukgmqWs1O4IW
	Ea8p81ist4N6qP3Q5BYyws//4fLL4GgHEtKPy7SOP2EgsRIkBQRXT+hO2xfUE46LglQ3NNddT06
	plkX+oxaeatmmi89axjYelUztJWTOjwRayYSeWBvQsTm8ZuQNJ2YYx0udcJRPbUaIBMRiVVxcw2
	PL9WSKo/5hMgsBkrP+0Z2boG7QfEq/qoLxw0Yh+pG4MfQ7AbWKw9TcaUfhIMRtcGLYWXDApqppD
	h35tNt8h8/3DK1/srinmgq3iDMoPVXnJ96OggOknT1VItd2six4O13sGTuu+XRflB/qDWKupqpb
	mcvrH5UJo5wcR7NlI773Nw1vTq/tvsduWPZqOh/QZgm8f5FXoaf+FRaLhOJfMzJ6pstz/fHhtEk
	HIOtyo43UYzwYVADaXZM+F3BEANYYIO4UrhNt8g1xNks+m0PcGmkywHfFlMzzWhfVoo9xGBZGAi
	+WJinh2A6jeQuyXA6kZlZBflRn+ydgTLepdi9VA==
X-Received: by 2002:a05:6820:82c:b0:71a:e0bd:acff with SMTP id 006d021491bc7-71b3944035bmr6230003eaf.30.1795296701136;
        Sat, 21 Nov 2026 13:31:41 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4669694eaf.13.2026.11.21.13.31.40
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 1/8] io_uring/napi: don't end the single NAPI busy poll early on need_resched()
Date: Sat, 21 Nov 2026 21:31:30 +0000
Message-ID: <20261121213137.1789687-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213137.1789687-1-axboe@kernel.dk>
References: <20261121213137.1789687-1-axboe@kernel.dk>
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
index 922bdf68aec8..4f1d20d28f72 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -113,6 +113,7 @@ struct io_wait_queue {
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	ktime_t napi_busy_poll_dt;
+	ktime_t napi_busy_poll_end;
 	bool napi_prefer_busy_poll;
 #endif
 };
diff --git a/io_uring/napi.c b/io_uring/napi.c
index 45180b172bec..46f5854f05ef 100644
--- a/io_uring/napi.c
+++ b/io_uring/napi.c
@@ -128,19 +128,15 @@ static inline void io_napi_remove_stale(struct io_ring_ctx *ctx, bool is_stale)
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
@@ -150,8 +146,7 @@ static bool io_napi_busy_loop_should_end(void *data,
 		return true;
 	if (io_should_wake(iowq) || io_has_work(iowq->ctx))
 		return true;
-	if (io_napi_busy_loop_timeout(net_to_ktime(start_time),
-				      iowq->napi_busy_poll_dt))
+	if (io_napi_busy_loop_timeout(iowq))
 		return true;
 
 	return false;
@@ -204,13 +199,16 @@ __io_napi_do_busy_loop(struct io_ring_ctx *ctx,
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
@@ -221,8 +219,7 @@ static void io_napi_blocking_busy_loop(struct io_ring_ctx *ctx,
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

