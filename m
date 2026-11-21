Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296692;
	b=s5EUez+Ghik8CmU5JP99O/Ub/O8OYlRCX4pKIas36oLOJ8hKI5qKoKuoHOUZ3JKWufEy
	 vLtBvuy0aLWt+JNcSQD3rdaaa+KVsj9vd0BOl8HWz8GYlxWzpp7O7uC5EMS78wVgH30y1
	 K28eytL67PKGdrQObQMsOg3gp0NTGgAuE/aJU6laoRTysmB6n7/mUr4fNnh6v1hwsL7Jh
	 jCQgMvPSy06eG81lMQ9cLkPT4vc5lIiFnoJpRV9bnfUD+Kv7t1k8qYZKn8F4+o50qodh6
	 gYNFwOyr3TtoLOSW03g6PFRuOY+9Oy3Zcpf+fpW8X2Nwtuhww5xTbAqZ/t0QZ8u4xhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lH22vwA2Rh3600WDFjkvZKEHTXIiY16CLtaxtnnoQBk=;
	b=sraWe1fP0QFMW8+K34YUJM8h3aOlZ05y6nrbkyed97WvhlzusnCKYEt1KV1may4CNxJm
	 8whxHzmy8R0/vxqeCYkyLdUiBpWvhN8kAaO8U8ElNznzuIeuD/Vh1p3fZ+9wFwqKJ+jri
	 qL20QwGjV8G1hVFf5uTyUcA/XvY88oUK7H7rB5KgImmiquMC8ba3Xh+zKIQzgHA1oZNbf
	 UfvI9ftbCtxnGR874rfEMwd68e+dDZteF0x0fvurbGY3oZeOKiJKJGCVUBJIDekWzTzuZ
	 PPgGZoLzprhO0PgkyvpIYIzx+XSQYUYvTD4Xu21NZLQx3RFlN4ZYZF9gQsm//l2y4JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b="Rt/pafEI";
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0716E606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0716E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=Rt/pafEI
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-862b76e3c8cso920603a34.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296691; x=1795901491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lH22vwA2Rh3600WDFjkvZKEHTXIiY16CLtaxtnnoQBk=;
        b=Rt/pafEIZrFNlTrsPLfSBNg9Nwyf1AQajXR1nZ7uSUQmdbsrYlFx+4m0TRgf1THLoH
         1K0W+eXxyYnGLcVaBMJbKZPwCG8AqJe6NWQZPlG8qWlbg0h9w49OH67v8DEHf9ksBvKX
         B/vVa6yC22xo+47eN35jmhbZYlQ+1wJyqa8Izru7ZkLtdp77Sdikzcu6Dqt4iMjhKZUt
         lVj4pYMKn590TzEW3yKZvPCj311pBAsw7+YDXnVN3xogcuB3B6wFcswOeUKP+MMoPUQP
         is5iRD6QEhF+uZCCrDzU37daxLkIxr38K6I3dKZk+mD4saROZg/aer6W9w4bel1ETeah
         u73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296691; x=1795901491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lH22vwA2Rh3600WDFjkvZKEHTXIiY16CLtaxtnnoQBk=;
        b=ylHH5sflvi/17aNO8eHYm59DG3293aLHFeJb0DjAdcmFoxjJRvHF1ww480e257yLlg
         EO9bwmo99L9UWPo5WX6lRuCj/NustNn2wDbhWrmyxcWGI1dWXueN2gijv9sBEW431fOx
         actcxywjs6Q7qtyDz5sCEunjmIvrz57jCLlkjjwfV03GPnnskfCGIm3BJyBASrZNE25l
         A8w0srqeq+UMr3S0P2aZwYwshFq0FEqKdrggrXucgLWGknAcw37XerM7fnS5fpndnzqi
         KT1KTunsQ3xZzP+wo8N/Y9qAmDbJe7FoRT7/MOts3vlTK/w3uF/hfY/KYWOmJOo8hSqE
         xJVQ==
X-Gm-Message-State: APuU4Z8Nin38AqPvuXKA10BK6jArdAVc81cZ6zZjHiIYDtdKOba2PTaU
	afmXhY1SXkj7unOaP9wjVvpfJ+HeVSYJAi2AMlITIb1reqod2arry4BAkno54PwP2N+U1cqHjFR
	KtWSFPZ8=
X-Gm-Gg: AZFdTZfJAt2f9ZZmr3pgGBtQ1jWLxG96igmszjo1tz0R1b4sk0ujVd/wPCiACFyZtxZ
	hxRQQt/x87fv97f+zoabZT3zq10PcW1OJKehwbQqEpLbJBMs6RPxAYVQurvc709BfKn2moTYa+8
	0mfDhmoLQpd/+Psn6YDXFVwQPIPKJvNXpBo7nREbh0DlhzaaJNeLXve7VtqRptQVwtbDjlB4NtH
	UJ6pndOqbV+TC8gQxcayr5vZBINzvGGSgFeGOECuGApuvb+viujZS/S4t3HKko7tNj7dxmLEkyB
	3wFioiXHn/6VkUVNRn6sFlkObQjsI364ngLEfhHzeWHKqHpZALNNh5MJQl1saiegGPiDFVcGlcU
	QIxuXYGlgMisGyBklhCI4GCwPkgDsv7pOW1u8uUIY6PyWuB9c2DUwp6eEtX2odMECYNqCodqkxo
	84E1Z71H5tovRFN7V9b/HAvKhm8b/jyn8xMF56mBl0pT+YTA/90+1ThLLxnCluQrwR7wgD0pMff
	cUm0o4kRo8+0A+WJ552Ful11CdeISI5qBkA13965s5cKv3fe1VQyG8fc975wSsQtFQVru8HH32G
	KxPlsrDzAIg1ZJ9fdg93VCtQaFcSpCnxodp3ldKnxft5nCJVREj++YqZ1DEazAPFSkluIyPNBRE
	ZiyK+mA0uauXQdou/9L89vHEdhW/MPtB2Q0iryQ==
X-Received: by 2002:a05:6830:6413:b0:862:abc2:9c52 with SMTP id 46e09a7af769-8631562e308mr8716788a34.14.1795296690945;
        Sat, 21 Nov 2026 13:31:30 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168f6d33sm4946113a34.18.2026.11.21.13.31.29
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:30 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 6/9] io_uring/timeout: don't rearm a multishot timeout on cancel
Date: Sat, 21 Nov 2026 21:31:18 +0000
Message-ID: <20261121213121.1789042-7-axboe@kernel.dk>
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

From: Cheng Yongkang <teel4res@gmail.com>

Commit 97d4a585db2b91d855f957be0a9f126068c5be93 upstream.

io_timeout_complete() does not check tw.cancel. When it runs from
io_cancel_local_task_work(), a multishot timeout that has not reached
its count still posts an IORING_CQE_F_MORE completion and rearms its
timer. With a zero interval the timer expires again right away and
queues new task work, so the drain keeps running it until posting a
CQE fails.

Normally the CQ fills up quickly and the request then completes. But
if userspace moves the CQ head far ahead of the tail, for example to
cq.tail + 0x7fffffff, posting keeps succeeding and ring teardown is
delayed for a long time.

Don't post another CQE or rearm the timer when tw.cancel is set, so
the request completes through io_req_task_complete(), like the poll and
linked timeout task work does when cancelled.

Fixes: ea97f6c8558e ("io_uring: add support for multishot timeouts")
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
Link: https://patch.msgid.link/20261116044519.281756-1-teel4res@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: 6.12 has no tw.cancel, use io_should_terminate_tw() like
io_req_task_link_timeout() does]
---
 io_uring/timeout.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index d71b0fdbb066..e99709c4089d 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -72,7 +72,8 @@ static void io_timeout_complete(struct io_kiocb *req, struct io_tw_state *ts)
 	struct io_ring_ctx *ctx = req->ctx;
 
 	if (!io_timeout_finish(timeout, data)) {
-		if (io_req_post_cqe(req, -ETIME, IORING_CQE_F_MORE)) {
+		if (!io_should_terminate_tw(ctx) &&
+		    io_req_post_cqe(req, -ETIME, IORING_CQE_F_MORE)) {
 			/* re-arm timer */
 			spin_lock_irq(&ctx->timeout_lock);
 			list_add(&timeout->list, ctx->timeout_list.prev);
-- 
2.55.0

