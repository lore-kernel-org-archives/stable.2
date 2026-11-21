Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296708;
	b=AbU+zv15cqzJFfGXuIfp8MKHqUmB3B1NHwPJQDth6hvehQg12FGkIo0VJHd1dKw8khZc
	 B+nDV2D70tmnxXvZyBLyBfycDZKlL9bxW2Bn3oUwrMOOmNdYARXc7wtejau4PuVFjFvRb
	 mMwe0P2jnma4iu1xhtW+zlvq8KEsLtXu8+Nq/kcFyMZjqA7er9XlN6oWpHfl0yqbdf00o
	 TiWyIbpbclAin5KLkshQ6x7XpJ2KxlYygm1N13n+XuXs+59hViPM5TpgOc9RPU8iASQXs
	 wTY9/DIvyx8uLrGVWKJqxct8gVrj9jWvqdxLgBcz2il8aKxKeDzn5mWHjtZGV+zl6NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296708;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1TGb1HhBHaH/d1MYOQsGF3DmTAkDgPfuSZpXLmC/h6Y=;
	b=pCQqbu3fFzCU0jiGtAvCpjySgy0Ho6mHsHAcckH0G+xiRdi9kOlddhj2jvSMT9326GA1
	 RXgfJZblC25SlDbNwG6ucGm+IjVtzkFu3Uux6yMReBhPryH+YtQ+ru4D2DJ2YPd5BIk/M
	 JqbVTVTmX/MQd7cCxWM2hqpNbJqRfVlAOgLRKOHV75V7W7WVhlx8YUfp64m3eCVRDFlVD
	 G0J/0z63SRkBSV40cuHn1NPeaYbZDrZnEkHUlqIgLs8C/5pVOo0FktlYCrfqTJp47CxYA
	 ontzY94qaDaIDGeqMNm2KKhuBVqbrzvTwdMXJC35SAH5nplm3DFVkeeZmX//AJPcy/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=H3r2WzVJ;
	arc=none smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9AC606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD9AC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=H3r2WzVJ
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-71ab5e64742so1261889eaf.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296707; x=1795901507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1TGb1HhBHaH/d1MYOQsGF3DmTAkDgPfuSZpXLmC/h6Y=;
        b=H3r2WzVJR0AWC0O1N9oymOeI37Do2jyyf+Tl8awIwjjMZ4HuFywF3VsohwXM1JroWy
         P5UoJ9WUlAasTtX7Mh0QQw4lfrP58qfW4UKBJmfDJ+aMtak2quL8T2xVMqUlqpnvJoui
         0FSJIZBd+wbg6K37GeSno44EEA/kJfbpMh+bhU5nUq37pL9LvWtT1uloSd2XQzlsZIkd
         /L4MtpjtpVLdXGTG7EEwBZBe+wIe93/h4cMG6myV2yrX27b8TEHTSbgeQUjzaNjC0CpD
         iWM+k02il+MPOEa9TdHTY5y6K89ljqWjRfzzfp+8aQINQlsv/whpaCATJbpm+GReAXtF
         DoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296707; x=1795901507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1TGb1HhBHaH/d1MYOQsGF3DmTAkDgPfuSZpXLmC/h6Y=;
        b=FPG+8j57LE5FsVV/UIDSA3ZuQSe//tftqMPFAFkYxt6P/rPMJxf6C4XQMu8A+T9Uoa
         hvYNazsa/XzMb4Gk9w2B/G9+BKCJsnlpmoGUv41Xyr1KidjX0JLE5wyw8R2paJQYzlre
         eruKkUQmaEX0KjQBKkdYvBfkSMCMhiPUYGLBEPaPjDhDuV+B54SqXKeqg77o2LtgA2ZA
         14E7b7dyzD9bii8BAmvL4GWfmi6j8UdDswFcjFjvdG3muhhSowykxJsulv6RtSCJYa/c
         FThRcP0AJzNvfA7BZs5hC+XXd67bw81LcQsW//0rb3En0+dlHO+ZZpdGV/mFWrLFY4wE
         O/lA==
X-Gm-Message-State: APuU4Z9CWle/Ui8/3N22vmXC3hyhwZ5TJT+NkpDJCoIjcqN6Loz+PvcM
	zTul/1H+GHGqU0GlyM6IWbk7+h9s6Bt51D61dmEw7itE47XyPrm+0LIBFaWP2E1SjGYrbf6cPax
	AWVbCrRc=
X-Gm-Gg: AZFdTZdQohwclUdIVYTsCwBTV9kJ/k02lgJ0JJI7oWOtypVoBBSLbF/lrXwCX2z8zrE
	LquRQLsTybr5mJ2j5QYeMQp8YkqX7HJGt9AnSHV//FD5alseHyCpH/7HwKVx2w9FEEErmYCbLqd
	Vl2pZQc4DmlWDz7kRWnzKabCyzE0eyyGcAibfqCWSvhSdSSwm2qm7wSCAzPwvxBDxZ3FfVVZA9t
	uqrOBzX0UjayQ3WKlygpiCoboih1iIXchwckO71ksoeWHm0mg/jStuVt/DyTBy3iN6KuKhSCNni
	EZ81PBT23tpGLE2FRnL6zikWmOn++ojaegVIKtFaOV9Si7PWmSiyGseheyJ6yHBNHfrC1CnSKjv
	EP06Jngt3yfbi9GN0lYydWzUzFiYOJ8FncxoY6bJd1MYrYASuAjNnhUP2bGo/MzWx1LK3SxuVwo
	xkfqdDh9tnBpBCU+iwHbqdAo/A3lwcd3LmyuqHA8GnllqKOCyFOnlEjAV/Li2ARC0hPzaWs+ImA
	yPtLMAcGmwg5mmAOrCrQxJ9zo80a9Sem3Hj05q4CxuoDNu08ZKiY1NeOMAJRkB68ZfToSo4xdOq
	McetE/B0b0IYX3vi1m+syrM5uw+UG6w6hqBUTDyEtrkDCj/8qiV9x2CHbTH+cNmJXc3/NB95xWK
	zdkb9v7TyRTXxqKp+Esz4oI7GudOYxfkKaCyf
X-Received: by 2002:a05:6820:f026:b0:714:b51d:f513 with SMTP id 006d021491bc7-71b392990c9mr5903408eaf.13.1795296706754;
        Sat, 21 Nov 2026 13:31:46 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e4a6dsm4669694eaf.13.2026.11.21.13.31.45
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:31:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 5/8] io_uring/timeout: don't rearm a multishot timeout on cancel
Date: Sat, 21 Nov 2026 21:31:34 +0000
Message-ID: <20261121213137.1789687-6-axboe@kernel.dk>
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
---
 io_uring/timeout.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 2637c8bb61a0..36c8f3dae27a 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -76,7 +76,8 @@ static void io_timeout_complete(struct io_tw_req tw_req, io_tw_token_t tw)
 	struct io_ring_ctx *ctx = req->ctx;
 
 	if (!io_timeout_finish(timeout, data)) {
-		if (io_req_post_cqe(req, -ETIME, IORING_CQE_F_MORE)) {
+		if (!tw.cancel &&
+		    io_req_post_cqe(req, -ETIME, IORING_CQE_F_MORE)) {
 			/* re-arm timer */
 			raw_spin_lock_irq(&ctx->timeout_lock);
 			list_add(&timeout->list, ctx->timeout_list.prev);
-- 
2.55.0

