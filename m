Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296718;
	b=a/OkUZjiArNSXrcW7Fu5bClLh/u6cqkLaggnkgBZY+Dt8WV8InrEMwiBpaRrfD1nsE5T
	 jl8pqXLcmsFfSEflXvO9anf8KtwSB0e7Ut6vcCVuroDkoIBD3pEgxrCDcG/sTyGgXV4Qv
	 026tsJCqdIsx1KezyIIN/5GJo8qchv0F36YKO92KO7poe4Bo0fAcm6VEizjn8rXXtEN55
	 wmltjgeVi4MJ33pkD9Ahgbu8xbVTKKPtERQe95W3XoBglEkeOQHMtkw3YzwQ3ipdWciaZ
	 BUWNKyfikJ6Dq/THvBYyM6wtvenF0essGu+n4bqHAndiYSqfBYeHgjJIuA1y9cSyzcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qcbipzg59blEXLxk/+HdY8JplBYjXAb/NHpmnRdMBTU=;
	b=dyRH0Kkaz5czTa0b6dN7HS/mK7txrqO/6aoDV8d4k9paajvOdupgGg+llOwFmvhzQY1Y
	 emH2kw69Z3XMjXws8/TiUWiH0B2FxIoutIgHFHW3dJg7T3Scl3y1FlwSnUdv3wEsJEt4I
	 6pDbh3kvC2ezURxretzsphhrPaSXDaRhiIn2A1bH71aRy/uYpKZ++RtiPbO0wiv3iIPvC
	 Aeiiu6ee4Hde38J5o0ijKckyOGzSibaYHSzoxh+Z9418OiRaaScUlLTZasM4GpWZh9aJ/
	 xk6ohTOZ9g/SQhqgk/z+6DA/Q++JzBwWuJqdlcmBfuq05Ts5kWJaUMRifOFhjHnh+SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=XniqVYR2;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7356C606A335
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7356C606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=XniqVYR2
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-862bb0a189aso903421a34.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296717; x=1795901517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qcbipzg59blEXLxk/+HdY8JplBYjXAb/NHpmnRdMBTU=;
        b=XniqVYR21ksAEuLpaRPvai79n8FEc8wrxbSkN1MFR+EH0EJT+m40h4Vjt7eUW1Axr+
         x0n/SL9522+uyphEAC6qhNIfet2nsx72OIS+CqJ1YVU2+bjjjbeqBtxphUYL2EuEznbr
         AE5Cd3mLjO+jJ/c7rwfBp3CfGYltO+ZXn2L1q7Eupgt4ECHULJE3Z8fygUfE4crX4scm
         LdVnmVLYgpnaJWBNpQuMizhvuZIKtuwjtmCLO4oD1yBdpFuBoUf4MmdlZHQ+pIob12Dx
         RKppdZxgWGNvd6OOE48GkNlFOKd3nnicuxm0AoyWsJCsMALIPaqHNhbBzjisBDfKwIid
         ubqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296717; x=1795901517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Qcbipzg59blEXLxk/+HdY8JplBYjXAb/NHpmnRdMBTU=;
        b=ZailzCwc+JlfFlxMQ2ECFiF+ms/7wGZbZLZSEdNHHkxUfy+4QyWA0XZHvnI5XEUkQ5
         MKyDl/0JtM25OmdV5HU4oKYshYvrq5JCV7TWqJS8hyCgImU8riWT4xNBjo9w0CoKLzK7
         Z8oLrZD7dm6GhsN+8tJ8ve0kDS6jrccVd2OWxn3h94CTlHJu4IMFH6vaeEANaESVqsSF
         Ak+X4uktcNIGLKC3JQYsH9UibDGCvEhgDB1Y7iPN3TYTqgOe0AZ29gzIs0WGo/i2TMET
         rwG5zNk7RBhK195MlTqGGLd47i4aY1exwhUxQVmHVR2You88GnDyK2R54yN8WLJ0LctC
         DoOA==
X-Gm-Message-State: APuU4Z/VnJsB/48n333uPvGl2BxDlYzgGaRCJoEhzzoA4tGZrjr+4AZd
	qBrGeqEt5N0STWqHKm9OUR+GXKBIHhqbKwAZoh6sdW8RrRJkTy9q1uKw4GSL17NA8ZeaJbNgZIY
	EMQaIJms=
X-Gm-Gg: AZFdTZcj0QIflkpgSaKscf9Nbgjs7i27SSxqiStLeMn+2GBV7inwVjY6Ytd+U+9Jcsi
	4FMSlWB2oBtrexp9wx/7yEMGrPAHXWXYrtp3MYH3xeSNGH0Kr65RVlnl1oEhXORDi0TFl9/bB6M
	6xGoij7GBCQD7foTaAHmyWdwGxUR8Suv5OF071/ze08mVYuJ/wTEvhFnHPwq/Sl78SywqHPa5UM
	1oBEhPjWPS2IWKnb8IPqKdPLUOPF9E7yydBkee4mfcZ3Ae/s12Ko7OIr1NA0JOChF5c9rRjkrxv
	91LxNRY68FI+FJ7UlbpHnnICmSmzRy4AwcyuiElVBErpohBKP0YJ+GuV6F+baboaJW789+owwKR
	dltHcYYGBI3Y9gbZVMcTwzOpL4itc8ac3DwlpnGcbMyfivvwB+glTmzuE7qH4DRXPt2QU1L6gsb
	3ruF1SC1AaJJcShNAQX5XJYnDy8dvK7tcLgsX/dP70lG3xmC1+2RQm65Tk90XbP/qJPY0KsNGn9
	AcCd7WDcgq3c2kNwbngkqUG6qdu4tLoGEpQc7zgfMsueUD6EO1Dv5bZjYh11cnwBMofwxflJtUy
	VfkTELygvP6aWtBJDuMRt4420Fvubm7u2lkq3srFlJT12jMFh5qiAq88ijjU/rA0FWE4DT8xSja
	WBwrTqd/LcJJ971I9S1NrWOYtMrP1LeqBij3+
X-Received: by 2002:a05:6870:2246:b0:48f:e0f6:c45d with SMTP id 586e51a60fabf-4bc84244a53mr6644672fac.43.1795296717380;
        Sat, 21 Nov 2026 13:31:57 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc55895b9csm6204636fac.0.2026.11.21.13.31.56
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:56 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 1/9] io_uring/napi: don't end the single NAPI busy poll early on need_resched()
Date: Sat, 21 Nov 2026 21:31:46 +0000
Message-ID: <20261121213154.1790334-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121213154.1790334-1-axboe@kernel.dk>
References: <20261121213154.1790334-1-axboe@kernel.dk>
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
index 2d6b2158605a..0cb053aabe4b 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -139,6 +139,7 @@ struct io_wait_queue {
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	ktime_t napi_busy_poll_dt;
+	ktime_t napi_busy_poll_end;
 	bool napi_prefer_busy_poll;
 #endif
 };
diff --git a/io_uring/napi.c b/io_uring/napi.c
index 7e698720cd51..54c1b328a89d 100644
--- a/io_uring/napi.c
+++ b/io_uring/napi.c
@@ -134,19 +134,15 @@ static inline void io_napi_remove_stale(struct io_ring_ctx *ctx, bool is_stale)
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
@@ -156,8 +152,7 @@ static bool io_napi_busy_loop_should_end(void *data,
 		return true;
 	if (io_should_wake(iowq) || io_has_work(iowq->ctx))
 		return true;
-	if (io_napi_busy_loop_timeout(net_to_ktime(start_time),
-				      iowq->napi_busy_poll_dt))
+	if (io_napi_busy_loop_timeout(iowq))
 		return true;
 
 	return false;
@@ -215,13 +210,16 @@ __io_napi_do_busy_loop(struct io_ring_ctx *ctx,
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
@@ -232,8 +230,7 @@ static void io_napi_blocking_busy_loop(struct io_ring_ctx *ctx,
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

