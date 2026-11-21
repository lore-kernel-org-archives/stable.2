Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296658;
	b=3tYyHAD4M+CUupngGiLD8p2wOz79TnD+V497oPt8zSuGC4gzi/0M8fFDELKAblEVdYQ7
	 os4BnE1sKHEjV0YdO3UTc2JoXYP3lpx3upbk32zDO+zEpXz1iBQDpYNTzg4kLrEnisC7J
	 55euMT/8Tq5Sq9vvCTLuRFjfTZBoTljaDuEe1eBVCF9/1qjWonBniQ0QzVCSncVzubyAC
	 MT9xU2uBWAFfwNoCTzfGthpS9EBW74AE7sVA+OTIK4qBJuT6K/TnHh77EVTo4mnGKvA9k
	 jQyuj1/hRaj8f9+v9y67VDY2kgYnmvK6Ch9fq3XysydYs0jTbB1Nhdz0km/iWMCrt3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b9lmoL7swP/DPWStWIM3N9xXwewjYYbu6CxAgeEmr+U=;
	b=2s4zRp1m4NV1xuypXqTQTmLjKslbhyjTVCYc3FT8Y0+c4EXcoJ98DzOGd1M7FlI2CGOf
	 QNnC1ubVD7VSUhvn9LwuYGpCBl7NNv482yAgPkB9OL9SjEgK26yZyZB5wL/j+xjQBNrtb
	 p1ybYe0IunVDIXaBq4HnY9qGMKtUoOuoP1t9H736Nf0+TV5N9yL+1D9YSEeDm/+j7SBlH
	 6y7kL7+2bUGZ3cFASV1Ji8tPnB/wU5J7mjwPmQUO1jXMn0kY9LrEmQY9iK3mnhsrLf0ug
	 Ax0YTynZXgDCRurwTGpi3C6GceNlfCEwptLZZBQLfWWSVGXhTPlKjniVZEKDEtJTdGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b="RwU/774T";
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D096C606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 21:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D096C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=RwU/774T
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-71ad047710aso1335452eaf.3
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 13:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795296657; x=1795901457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b9lmoL7swP/DPWStWIM3N9xXwewjYYbu6CxAgeEmr+U=;
        b=RwU/774TBTlXHAlbBfv8NJ7GBY/gdYPMFCO9C8wseZVQNgI5QYmP+si7ltHiiaTPV4
         zs7ePVEKMISNLxzvVOd8ytyMISu4YUVxjxeKlOZSPr2vTURDS7+j/lm/MJS1ZV7qk+cY
         gcaF2mMhx2NI3zaGsdbG83hwXUEOEj0fDkLdZVFabl2X8YAtRa4KqRtEr9iTTCTENuef
         i3RQkTg0FUH8Vs0HVIrxum7zOvbzjuvOVDGlfhnmOztJRsRppqgEqTb6mz+GRrvQNEaA
         SLf6NiuQXFWSJtdtFBDVKlyXvdUjAT90w7DpehuaUNusrxy3SJl9cicGhmNhTtcOrFKq
         ReBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795296657; x=1795901457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=b9lmoL7swP/DPWStWIM3N9xXwewjYYbu6CxAgeEmr+U=;
        b=K7OC8kcZ8Y2Bsm4ZJcvLbpo93I+WJ1YCj1kw9hYX2ehkXxQFFzL+7CnbKppaS2Qdkw
         oGEN302hB1I1A73cr96Ohzq+AR7ITRyY4LwX5ISaGHkjU3Y1ciQaBhxN1J1062i0z+Iz
         QDk2VVosQFDegi+IMyz6x1y+M6Unkixlj9+31UPjyx5JMziVKLyeJ6CK0dyTz3LSEet0
         8rs12FME4W9zwzPvUOMExjihiSyCohf4gPU6plUomZZw0idNrV9omG6OnRxDN3GZvbLN
         o9zIljvFDldxA9Omqr4BXiUlxTZd0gOboct9rje/PdJqV/1U3JWjjg5TGv7Yq8LvR3HB
         M5Gg==
X-Gm-Message-State: APuU4Z9cxdHv+IcL+kPSoM30/BajhzqZu4LxMh+JtXKfMHAIJaa/dqnW
	4MzVPSyv6dyDOWhaBrHCVMI3sI4koirHOLzTKbUme92aPb/YQPLDJ7eeLp60FnG/0Wu5XfszUb0
	P8c3P80k=
X-Gm-Gg: AZFdTZcwlXphcl1GdFnrIVwCD5jZZzEvBdTV3h35fdaXiexilwn7K0SU66m3pUyEgTi
	ABCV8uPLgYpVtHqAezU3GC8c0294S/5nI00aI9NUUV2iDQBfAPCLdiDzNnJ4pDz54LM3C8qmxXL
	AH3aEtETGiFRPX0CV8zzy/afYsK0XtThJEkNQli/WVvx7807HLGElW5phRVG9A187Y1OEcFMfUL
	ok6NQZnNb87iOOZukKRNvLMNXQjeB8UC7dCWBS2FdXnBuKC1h/mVmZsDP+c8WLcA81MXO7yQwUF
	xlRnho2Tx9TTghMrSAzt04aWcM68CLRxOznjw3kCYU/azcjbGy6gkn6ZVgKl42wb/bqXJJusjp3
	Q5cIl9XJb62HkFJW6r4B93WL2JrfnqLTStvzMW08Eu+etMYRy5SIiHS0GwBrlYPlNhZrIbOBEaB
	fOPNf6u+scO9nlTmglLXZRa/BsqlF4CXKnymY4oLBBdzblQ3DFIqO4+toMgByuig98CW4yvJugy
	gS3QkTIiFZYqaxnW/AqlKfC6B5u+rvwTx6m0JxAagHP4I9H/+mhq8h3jfuPNG2srCgKvWZBdjeU
	76R8ffzjt7jnaKgi+CfiW03A2kG3zSS4LxUFbC+3V1XUCKyN0tA7c0yI0W8rNFp9Hq5vP5iF6Pp
	+h9QYRJDd/6Vh3suibss35G2gwfcUsszA+Gyl
X-Received: by 2002:a05:6820:4a16:b0:71a:e73d:afbc with SMTP id 006d021491bc7-71b395bd931mr4907105eaf.67.1795296656750;
        Sat, 21 Nov 2026 13:30:56 -0800 (PST)
Received: from r7625 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b38015c46sm4469155eaf.4.2026.11.21.13.30.55
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 13:30:55 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 04/19] io_uring/timeout: don't rearm a multishot timeout on cancel
Date: Sat, 21 Nov 2026 21:30:34 +0000
Message-ID: <20261121213049.1788332-5-axboe@kernel.dk>
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
[axboe: 6.6 has no tw.cancel, use io_should_terminate_tw() like
io_req_task_link_timeout() does]
---
 io_uring/timeout.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index df9ef01ebf19..4eec4445fafb 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -72,9 +72,11 @@ static void io_timeout_complete(struct io_kiocb *req, struct io_tw_state *ts)
 	struct io_ring_ctx *ctx = req->ctx;
 
 	if (!io_timeout_finish(timeout, data)) {
-		bool filled;
-		filled = io_fill_cqe_req_aux(req, ts->locked, -ETIME,
-					     IORING_CQE_F_MORE);
+		bool filled = false;
+
+		if (!io_should_terminate_tw(ctx))
+			filled = io_fill_cqe_req_aux(req, ts->locked, -ETIME,
+						     IORING_CQE_F_MORE);
 		if (filled) {
 			/* re-arm timer */
 			spin_lock_irq(&ctx->timeout_lock);
-- 
2.55.0

