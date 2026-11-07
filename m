Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068171;
	b=bPvHjz9BQbuI6xDzRAWmDU+sTv90iOSictCMU4jPJou+XSM6XJxtZVN6wNEfslFRP8Aq
	 gTZDIQsQvCqJ7U76tVvjeFhLMu8nE+7KgQjhlLLgYWNSPrvKNrsW0xR9S282LqElYyKim
	 NXvWr9Hq1/wcaPqVEMqt4oztbnoN4VAWDxSRtvpfmWyYD3yOVUlV8COlc21X7jsT3IWqb
	 aOd566JDAQ1whvN/Q5k0QSnWTzOh+BBQHgr6AXRM8+Y48Viqs4RyfaDM/TKgs6TTSPiZN
	 EzCjcUnZ/0tCeL8+pw8aeA5rk+Nc1qyODX8PHHoDvqP3ttBQ/hKqwtyOYCnbfsMGX6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9ZEQ7vsCMnS7gPHtv4gQPgZCwV9yMPWe6WILiPqB9OE=;
	b=q2a9hekhX+PWHLaGUcVO+CRwzqI2XN0HAGkXZUAQPpTj7JGWeCHJxVKFHUJ5Q5ByF/fB
	 gs87fHkkEHlFIW/F4MuyKZY0iNGTF1rGayn010doe66G6DIvTOkXW5MiBww2/qYGu81kY
	 hReqs/MKQ6injEx90/FyeEFBaNnZiEoPjUx/RmYS5KvgcPKfKABW0MOHuLdhP05vwfqfc
	 YZI+6iV5AIttBoHZYuhD+lR9Earh+5ZUG92e9U14V2+7Qhww6/fzErRSVmiNJpB1BdRYT
	 0m+iSYeAJnWnrnGtV3/qtEGOx2OCHHCYJ+RsT4kHRGlZyQ28owCO3Z9va4lC5bF9poQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=B8skMFZ4;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3D606A336
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C3D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=B8skMFZ4
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc758830601so1072568a12.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068171; x=1794672971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9ZEQ7vsCMnS7gPHtv4gQPgZCwV9yMPWe6WILiPqB9OE=;
        b=B8skMFZ491CETJsqSNl57hw35vA9xIOOJJwYpZgFx4l5O9IZXNtu7S0MC5Ygfpy+qc
         hCGTJAvdSG674CggyafBzgRGcxBAQvFfjFNtwL9gF3bdqkSUdIFAwO8r7XNv5Y/nuog4
         0yEaDb1JqzU94Xk0uGQA4V3FjhlPtHbk5i2pV/F+Wu48pSWXLYYb3zttVvMMhnR2U6Vn
         QUrPw9vKIfWqwIsdgpJVIjmtP8/RSssJQqWGbvhJSuoEdQvKUkWnyOD0QNhhirYgb06a
         BuzlHkjw5i2my7fNwzj7prnEwqMd0WScyqQIkCJp6G6tvhDegDh93lxJcic4jNoJRpTf
         sY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068171; x=1794672971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9ZEQ7vsCMnS7gPHtv4gQPgZCwV9yMPWe6WILiPqB9OE=;
        b=zW+KiSD9E+yy8qDI529VMNgTLbKiDNzuRtBpxpZcsfJ91xE+h2bFG03JBR64dnSmox
         Xzn6D2vK3jVlTfBggud8gpcoVNAL9b0UO7hXzeaqLj4YMEejf+hA5hewiFeYIS+RHo1E
         pnT/7AISNAMPV1jvA8VQGqLXhw7uztCcbsuqyu7y0jdmAScdsMqTQbNwgGLtnJN9RmLd
         u+/tpMpTSa6pjpPg62o1vJCtbiqalm1Uw5XwMs31dJCa5y5Pn5nTd4HUuIesf9FjC3kn
         psm/a8zsFZkTg0Emi9s70yG9hOe+RXlNHmaytNUnuni55iZcb7mXw96VCMkGJ8ylV7ba
         NRmg==
X-Gm-Message-State: APuU4Z/am7lgaPZwWynQGOhZvvksmKH7AnjCr4HDRmPzYN5TV0+9/SSV
	5hQpYc3+r2YcPftwV38BAHrX7qdhpzSwEe3CZGowKOYlGra7Hn24VISpk6S2fjc3UZFBrQV6tJ4
	CmZK/4SA=
X-Gm-Gg: AYBFou22LO9e6T2UUQBW/hAJA5JccDFEeO9S6nZtZWXK29MXCxpT+31LBFRxlVnE6zG
	MXExdTQs+8WyI0DKFi8JxGlRxMIgHI9paNuziVII5PL5O/TTyoRR42ROnlV79DiC+O7FjzBK3Tu
	7BRRiaIi/oL/GR00YKKGY+pPFpA5Q8xWecpcHJi0LCqDVZV4QdAdQLCjnWrjVj1pj7VTDDs0a1x
	kHYAgYCUYAtjaIHgNHOCNBRjHuIc09Uho9nVf5LUI7euBPehIJstZFzRbBxoh4hjIXRN5qLQk1F
	o2ZQ/LmcCpctyT+LBTbtegl55m+7s5tPGRekH+rcEPW3sVYEbn2acd8+v/Xh1WnznmQJ1nrS7QB
	wi/Vk/0dnTqY8VkIee9JjT/KXi9WpHYo/tcxGtP3u5yubd7Q6OYsQ/fGzHxt0VcpVM5zhtEi6An
	pLE5rbok2GsXKFxxrTxcMIRfeYBDi51jQzc0MrDRCSGAHlW1Do2hfTP+3Kly4V8uc4EGu5mD3dj
	wdDd4b4SKDj92P7mMIMHyBVJzC1cNfqN+M3g9+Sg76HpfJLLFyt9vHnOQqpW2j2RHJyp8M3zg8M
	aeHm7d6ZIaKzegD2idPZbI/vYMQBAexJWA+VEZUmgjSDmVQYORCXYRZ4epwHtraDkk/bLzvWEQs
	=
X-Received: by 2002:a05:6a20:da1a:b0:3eb:a6f4:2d2d with SMTP id adf61e73a8af0-3ebb29867afmr6732529637.21.1794068170691;
        Sat, 07 Nov 2026 08:16:10 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb7064908fsm1344384a12.7.2026.11.07.08.16.09
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 1/9] io_uring/cancel: drop sqd->lock while SQPOLL waits
Date: Sat,  7 Nov 2026 09:15:58 -0700
Message-ID: <20261107161606.2500384-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161606.2500384-1-axboe@kernel.dk>
References: <20261107161606.2500384-1-axboe@kernel.dk>
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
[axboe: io_uring_cancel_generic() is in io_uring.c in 6.12, and uses a
schedule() based wait loop]
---
 io_uring/io_uring.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 52759ee3bd6c..09551e3907f9 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3282,7 +3282,16 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
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
 
@@ -3300,8 +3309,20 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
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

