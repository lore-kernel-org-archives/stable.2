Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068199;
	b=1O732UNB7ZkSsbiNnmbimHj61ATaKsJEJnk2uh039BBgMx+Ghp30Krb4/5fj3A/Zi3AW
	 lW/18x5JKQNL2tcNmQToo135/tm8sSX4lYWf+LI5l0kPple6O+dlo6Caem6aQBNYThYEq
	 Vv4//6l4FOOx4Jco2l/DsvtvP3J+VFiD68pbKxdIX8ZguLZBNfcENquSv+vZuPyA86jO5
	 hQIqm3QWZ6BJI1ZiBEBfrXWejL6BCuJs78Mx11bnRwhAH0T+JIGw7vjcWkVA63LyT+1fo
	 /nODCaqJ0Fk/mZS7V+63t5YVQ2pyXAhlcXxcbpROEb6zaCwp0W/zHEBvmsHqNbtSAZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S64Er2p0Kw/Jqk12G7+TVPxnihLwc336ZdbvUks4uPw=;
	b=b7JNonSyd4KVqQFQpaimRLLHfkbYlPHHYZG1U1kSNfm684OEYrWD6RsWywDr17qCxvVA
	 SgiBPHBsizjoFmedDE36A8yveC1eNXwSRC3XdL3dCpvPxRMxNU+P4GKspJypfHsAXoMca
	 7uQ7T1dW8lIp6tSkeYpcaylsYDmWhcVbavVgh6MFjf4syFZCyQNxGX8tB/xCx43u5Hr7C
	 Wa6/6Yn9NYbeG5xbXxs9PxOR8XVGEhOrgF7Pv8HQuCgzul97Q532DLag3HontXSSnSLhi
	 zNHEE6k2H0cCJf0LYAhUxRtSrOLeZFDgZRlE9OAa5/pX2xRq0+BW733S77obmy/du4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=f3wJeUMc;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C445606AC24
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C445606AC24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=f3wJeUMc
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso286636a91.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068199; x=1794672999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S64Er2p0Kw/Jqk12G7+TVPxnihLwc336ZdbvUks4uPw=;
        b=f3wJeUMcjCVue3OXi8i1UOpLsesQ/Wxlu9DkiHsDMzkRRk9WcvIAEt9oMsS0NwYXI9
         cUqjMYLk5OejAB+XqxyPh9MK7ZjaOAM3D2xeWHgsHZEJPhFvzenDemiDfNST/ygpzWBt
         R05lS6RUkV/w/7VeD3fCwfD5C5A1vK1al2WAmI+ydkyjrEE/2vOTXnf2II3GFKXD5wRn
         Lr7ZLkriF552fET3oqyktt87kVDNzB5ETQ6k5qnmrOoKlo388/6vdaSNWT/rrToG84Yh
         yWNyQZGSeBUmWYjToZWoLBKGPCUUq/KQv/g+MMgoDoGhLkotiRcq4um8SVyskkGu67B9
         8HYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068199; x=1794672999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=S64Er2p0Kw/Jqk12G7+TVPxnihLwc336ZdbvUks4uPw=;
        b=ZGYQutmjBQVH43T/CgAGftG6G6PWa6dULOm5K5sFqsANdctdv20WY6nhhkHPtUEIX9
         uODuRKfeaT9OpYvFqZmgYvyEuu2hkVaTYiu0DO3xdjWirpsJnYG9ubMD8H7K+vTj7IN3
         lrNHL2M8r9dgECKbeYr1KB20f0L/xmein1BtnpoCf2fxstFiPsyQ8Xkr/27FZ/V3LDr5
         vl1QeCWq1+acT6J3uA8RPv2oGlhhXPQSaKJXaKlKKfU9gRcWK/IhVIKttarGr0tiJI7X
         NxXMLi4zOak/tLRGVUuG55qx972mIoKSc81XQES0teJWCsPy1o+Sd0+WRXO6I8fK9u96
         UUzw==
X-Gm-Message-State: APuU4Z8KgP9t8v31lKTghX37GIDh6/H2JO0BaIuuhbNtWI4zisgP/ell
	DtoAoxhf0Lg61Ydjfd/g686YpTnI9VIeCPn7n5l8vADA3anhztSlqF2QYwWcrmgM2R7syZsjHoM
	eMwXqe44=
X-Gm-Gg: AYBFou0MhLYU4r/SZZcafpI/QbOJdDII/sfMftOAWBR5ggwc9gRAwRhSaQ93ExgOw5L
	9+HkMmvLTf40Z+9jLf8XhMYsUFJA2YbKklrucFB6qY/uuMN5nrmhoFX4G1U2bkpnjl7hCqo49Wj
	Roi4UuVROBpWSvN6dhFK0U7PdBThTu8YlVe5vbxWYPXEODc/ISqKCGnzcuEE+ODe/v7Dr1e+O2i
	XKI0AyTmNBkgwIjCucY8kU9j7Svvqge59u8A+7Mh1HMr8PqbHs5CkthyQzhQhTEWiMdODWdrQG7
	o3rd5iPZQs7XLZutKX8PnC2nMnE+DrMrvfytT46E9AMig//KMaks3CSBmadyViS5h93NijwJD7A
	hZWLcItAjsor/s0AG0wp9vTvzPrDBbp7B3zhzUHaJtkLcUYw0YQY1tCXo6oybOioFoxMD5EtPw4
	7Zzx4puuQGcKBkJhyLGlpefcGGhqFjCB2K+IOJhwopvoR11F9lRw2UMKiFjsrQGD+4eDpVj4e6P
	gZJDnLXeOlmtr7V4Dl1IdXrcoFaVYyYE0bW/0dh+LSAjNI0+Ixmx5GmaQfhT1cxXefG+0DdDl0r
	WNQxrs43HoFTI6r3FDWWZPGFYFg1Ky9FOHn+6c5Lb8hjYetfSST0kI0d7Btcaf+CEqY4dgp55AZ
	7
X-Received: by 2002:a17:90b:4488:b0:3ad:7f4d:2839 with SMTP id 98e67ed59e1d1-3b1060a69f7mr1662685a91.14.1794068198543;
        Sat, 07 Nov 2026 08:16:38 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10581caccsm3753898a91.10.2026.11.07.08.16.37
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:37 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 1/9] io_uring/cancel: drop sqd->lock while SQPOLL waits
Date: Sat,  7 Nov 2026 09:16:26 -0700
Message-ID: <20261107161634.2500557-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161634.2500557-1-axboe@kernel.dk>
References: <20261107161634.2500557-1-axboe@kernel.dk>
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

Commit cb0306c52ffae083a86fb283de67875ae7a9500e upstream.

An exiting SQPOLL thread calls io_uring_cancel_generic() with sqd->lock
held, and keeps it across cond_resched() and the sleep until nothing is
in flight anymore. A zero-copy send notification can't be canceled and
stays pending as long as the peer doesn't read, so the lock is held for
as long as a user cares to. io_ring_exit_work() needs it to park the
thread, and so do IORING_REGISTER_IOWQ_AFF and IOWQ_MAX_WORKERS. With
64 such rings sharing the thread, every iou_exit slot sleeps on the lock
and no ring gets freed for anyone.

Drop the lock around cond_resched() and the sleep, like the main loop of
the thread does. Each walk of ctx_list is still under one hold, and
nothing is kept across the unlock. The thread drops its io-wq, frees its
tctx and clears sqd->thread under one hold after the loop, so whoever
holds the lock and finds sqd->thread set can still use them.

Fixes: 63809137ebb5 ("io_uring: flush notifiers after sendzc")
Signed-off-by: Chris Mason <mason@kernel.org>
[axboe: adapted to the schedule_timeout() based loop]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[axboe: adapted to the schedule() based wait loop]
---
 io_uring/cancel.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 50ec818aa19f..44d8b7b25267 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -641,7 +641,16 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
 		}
 
 		if (loop) {
+			/*
+			 * A request that runs in io-wq and doesn't end makes
+			 * each round come here. Don't hold sqd->lock for that
+			 * long either.
+			 */
+			if (sqd)
+				mutex_unlock(&sqd->lock);
 			cond_resched();
+			if (sqd)
+				mutex_lock(&sqd->lock);
 			continue;
 		}
 
@@ -659,8 +668,20 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
 		 * avoids a race where a completion comes in before we did
 		 * prepare_to_wait().
 		 */
-		if (inflight == tctx_inflight(tctx, !cancel_all))
+		if (inflight == tctx_inflight(tctx, !cancel_all)) {
+			/*
+			 * A zero-copy notification can't be canceled, and a
+			 * peer that doesn't read keeps it pending. Don't hold
+			 * sqd->lock while waiting for it, or whoever wants the
+			 * lock sleeps as long. No ring is used across this,
+			 * the next round walks ->ctx_list anew.
+			 */
+			if (sqd)
+				mutex_unlock(&sqd->lock);
 			schedule();
+			if (sqd)
+				mutex_lock(&sqd->lock);
+		}
 end_wait:
 		finish_wait(&tctx->wait, &wait);
 	} while (1);
-- 
2.56.0

