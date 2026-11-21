Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296725;
	b=059Uaj+WBUWOl9mC17C4jTD7YK7JcgeRQwToVNzM1lDMKPxVYwvfQsxFipisebGAO9Wb
	 Ys2rcqRX04DOoTXlHKm1/iYED5EMFg7tm2H7bsuyLVlu/Bf2ASMBJ+je2A676XqEPDZ6n
	 UjMWnZtea6EE5ygF63g80vwzL2qEVwC/wj7YgHP+U0iBVtu0IczWmDu8y3zXbiSpxwXhi
	 PQoWz14OPgK+LAvcdqLzsKEQdHgj0TCE5KjcMNdaWUKf3EBWp9Z/n2mBo8pRJ+fL1WPxo
	 wFo+jX5CAbPhFgYyxYZk0fq7TKgpRd7Ryu31/CpUvUY7n3KlZOmOvbl2AgXk/fOPU4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iAb9bgFqE3AZOPdZLPqsX//RYhcWpilzLnMIHJyehZs=;
	b=tSb87oqt/1cdivE0HmtfyOSHLGoPWN3fA8gs9BOCMU7CpWwAPUMWVYZ7Y08ppdIOm1MX
	 eGACxq/SM3riBrfPn09Rwmmgj1eovJUVo2E1qUgz9il0E960RBZHmysGe95DoVq/JXz4y
	 fZ/o4wx/fljeta0vRwT7YaEBLEQEhlKHYDpZkQTE1U1V5kiDLG2ccelqbwTK578qu6DzL
	 Vb+/mlVaIW4f6mYxhyMNel6brwKAMeoJXDqLjAyBJnWG9vQxZfFzMmfVFVscNtAbB2Wn/
	 GRgJgTFmsRiwHsV3xvMxhuFpCw8LMOxYpUuhH4ESFnwD+HHkddZXtpSAQvRsnYeKhzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=as0yFEuB;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244E606A683
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E244E606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=as0yFEuB
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4ad881b6517so1544079fac.2
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296724; x=1795901524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iAb9bgFqE3AZOPdZLPqsX//RYhcWpilzLnMIHJyehZs=;
        b=as0yFEuBuH0WSkxp6HRooLXJMpyCsXJ97VeYGCMgImz1FbMkHmsqsPUrPHTgk4oVKS
         L6cqxWDQYnqunyKT0oxsdzgUvTIdR/QS+41pjJU7WLrfrrrxsxLUPYBl8tYFVvecxBui
         0QEd08oZ78o2qyoFPg1jqInAlIKayWlHdkklplR6j5VN51tSLzZNac9XE6c8Bo9SyXNt
         yfLvAFROmgh3Qu47hveiHVpWhMt42DWjLRKrQIe8PS3nmmR0iFyJZaHk93Md1a7pnp49
         3Lt4u/a0zVChiqUhldA6XHQUf8NiZNazVbrSKz43a/vw49CQm2/jmFuE0oiC1biryf3g
         RhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296724; x=1795901524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iAb9bgFqE3AZOPdZLPqsX//RYhcWpilzLnMIHJyehZs=;
        b=Urb/vnle/YGBlrPs4iCh8OPZNfP2OQxvZ079j462v7hpQD3TTljCHRYJKHSpbl2pOu
         HNGLBrfevB5HEMouT5XosKrEkV76JShOOb7mSZBDRxleb4cKtwUdj/5Olv6r1LVskJZM
         og2VCWgcf3xiFgkQUp8Qyzs5j7qKbiKt14IjH/QtTl/2HPLuapU8g9oejF6ItUexLUJ8
         9xhST1fbPl3MET4aNxEPtxnD67bP9evIJ9vkUXK4Xug2tblTiz7prxk0WTRsACu3+aSt
         nEaH4DIyPWluTrQjHjWdXhcKmfEryA9omV0n/yxQU4R6geNao23sQPnvauyKHQaYVsBD
         kobQ==
X-Gm-Message-State: APuU4Z8+p+zcTMQ7TG2f/U9QGU1J+rZ6J5FM7yyEg+/mzOmx8PV9Ad32
	O4lAzYLQ4ur+1oWmB2OTeywQQcFpu5jZpw1+QVU7UGQMd/nJwhlZFYrXM2uWCbAG+A1KgHwVtkv
	iz7bNcEk=
X-Gm-Gg: AZFdTZfCRabi+GPCG42isF4lnBuomZcTDQ0cKvRg3NBtdc0glkUiXhLHQmC0W+Ig+SN
	T/aMNlCpo1Qx184jbjTb9/Birjui/pTMwnAwgA9QhkrrbtKicftfmjbOdrrxwwERnMtgBjUaSad
	dHqBjO9nYZtGyu/wObZm1AgOdEWxSWLoqdBcwBzU8ZO5IBxvzMGcGOv3klmfypNJklqh/YYjIxp
	wAZWihlPxUWsduFL7xeqga9iKynm5OiRGiSXvI2cc7fI7/NaAq8dualKpEoSeypZBFeE1e0/1SX
	gqZ1UJvOsA6LFzbILlPa0UVqyd11ZMItjgmoZQL42AA5GDt2F6voWaMUHoAQFPE+W3E2W7lqKUT
	OwQ09UTGtL9cGMBIxxl0Q/co6aseqPkjLrPHWslnhEZoeDyc+bdbQWXO+z4Tzh6wqyA2Hb5Pw7w
	wpeuSfSL9F/1QeC4fhC9Mdr73z+wfu6dJzmrB/irsPS1+HfkF1dmGPiBOnDjc5SKzdWxEBYaCRe
	4zGUksNQBSn+I3L8o7gJzIAfWEYSNf75e0CubVNmUgwlbJB/dRP/xFbZa5HN3JzEDPFRBakvHAN
	/RLOyrINUu9ANvmMyETkaMb2I79VpWQB1BWNosh5qf0bFY1ehylQR/wDCbUUVJGU+TclkiSv3Ol
	jahpYT1ruLv0xLphRf4qQhzgb8zezUQbvQgyg
X-Received: by 2002:a05:6870:2388:b0:499:f197:d79 with SMTP id 586e51a60fabf-4bc825a0088mr6373234fac.17.1795296723961;
        Sat, 21 Nov 2026 13:32:03 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc55895b9csm6204636fac.0.2026.11.21.13.32.02
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:32:03 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 6/9] io_uring/timeout: don't rearm a multishot timeout on cancel
Date: Sat, 21 Nov 2026 21:31:51 +0000
Message-ID: <20261121213154.1790334-7-axboe@kernel.dk>
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
index 8e7a4bd7e514..b46a50b39517 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -115,7 +115,8 @@ static void io_timeout_complete(struct io_tw_req tw_req, io_tw_token_t tw)
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

