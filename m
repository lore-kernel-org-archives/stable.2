Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068222;
	b=K/xQ/TvYPJCMhAdR+YosFE1IbAZQcfKouqr+X1DQcvDgUuQ68d13gaxej14Ppk5o2QMo
	 GyISNRy5ifEbUgb7sGuCpIdarmFpDMn8fkhdllo8PSKf9aMTiSV678Ijdf/S8WaQPPEdn
	 V59PdrxyJ9/coJ+BeTDq5RFFyGscIYSRTEyYJekvdMHPkRPhdA7qQG/tqbxsIkoIIWc3I
	 CsE3kVznIErJlO2rzXC+iPDXI17voiVSaR/jFXvaDiJDs7vmDa8XgutkmzmZXuUfOgvLV
	 ADWX0uhYk7UFqT8ftfhM+MUaEcxANhMWoznTP5z1fX7pqRhagviSZuDIHNY09Ytqndg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068222;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VYoSqA3ByJnJ1YBHUx/UV6V4sazLPj6dT0SScyG6zPw=;
	b=hIKVdtpUGAqRr52fX9nh4kLE2Um/DSU5m3hKoLkNj6CbErOMDUtW2otmLHljxDtYF7ZY
	 ZFPdkR8S8dC6eyIRM9qPQEGOxcUdZUOLaiUm821cl1ZDMJpOPYtNYlUgW0XjBhH2Pl/TL
	 k7WQc0d+us0fpPTCkjYgAvVblUYS7NqR3t1OGWyU5ARB7a2nxStfgxSQc8+9yPnJO5nLh
	 7WVd3+eju6x4K7Gu0CrZ3cpJQh+Bt5pMChtL51eeTWm+IZo02gQgjri7B0eI7wDQu2NmO
	 IJX1JVrrUE9eJZmMN8wkT0dJxnZBg/CDTWj9aienepGRebjkvdjagzz4BviWAopmTxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=divV2ra3;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE946082BD2
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AE946082BD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=divV2ra3
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso762618a91.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068221; x=1794673021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VYoSqA3ByJnJ1YBHUx/UV6V4sazLPj6dT0SScyG6zPw=;
        b=divV2ra3qDm8cQp1/BzjuYVPIXL+QU+TS8ykcNkNzzM9WhR6AIrl+OGPbhANxOTDYb
         jdCxZdLqfN3mjLDSFYTpYeEGfsKpbPeKl2SIg4yKxDsd3L1FLk9c3PFDUrfplmQc5vmi
         oiCirS4pXtep1qw7hjo79uoy752ZZ410yOTC3/8y32EWXr1avpT3hHLp1aL2oXgOmE72
         xpIFIN0FG5WIMDt8NjCAUem224fTKFBt7aJyjuW919aOxNmvrm4KUlKm6IlWS9dxGN/o
         qKXpjuvVuUScxDWOmIprZdFxTKWvF+OrncNeiGJzhxr0mvQeesZ1saFGDvND2tqCy+uq
         0WeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068221; x=1794673021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VYoSqA3ByJnJ1YBHUx/UV6V4sazLPj6dT0SScyG6zPw=;
        b=g7ynJTGTiJXlDlvjGnGiS65jCLkMzbFSKI44MZ0bop2kQCZgFEX12zIUnHORoeBerK
         VlCOiTqA1ejO00fjZHyTRmeXyvZR7/SWIfR5jy0XReyjVgOc6We/4wIHrVnBUODunvdo
         nrCOBYzd9b6Dj3zChK18EwBlfk6Jy/4CJVzZOEg3wXObvnM4BrslC5bLBJhZq6p0gk7b
         XFa7bJyuOrgY2g9kwPzvBVZBShaUUfPqtyC9k/KeYnErhZ/wGtplymr7FHaKL092c6z5
         g6tSArkZm48NCPjVbSGBiW2ZG46mPV1tMJgIXsApSe81EyVlTapUWCj9g2V2IEaytouY
         mwyg==
X-Gm-Message-State: APuU4Z9hm6rfKUOm5Lgj1MWqmIC49u8W3znHW37PXU7td9JKA/mxBfY1
	KunwvKZPuZ+KMXI1fOEbqCmxITihtFkWbw0+2zjAZWzKxbjI2FuFLbwu4p9d5UFzNw6Kc47I0BL
	C3iaZOiM=
X-Gm-Gg: AYBFou0fBjp79UIT6FUUjXPoukP1cgYPemYd61dK/TFRME5RUqa0bzxJOLbpYHRT5Hc
	pl3sHWEV2n0KQ8j5BoU0I2c7kPQDjLXnDI768HI3sbOEEH2t6w7JSncFn6Ws8eeg1pDt98Inw+r
	a6axgvTNOEp9d7JyCF8o9e9w7bE7izZzrwHGQDGQvzlN8Awc2Ywxy5pGDhvUpnbSp7lLXLSxQU7
	cBh0DqC3xzjAw/xS5pdd2GqlQ/b9/3KrTbRDsJj0aVtLq10unwY+sdxS8stkzTtb4uqyMEeszN1
	l1XmBB98842dl5CEFOHl4lReHx/15gkNQLHP/MHSsC/WDuiWMgho1alqAZbJl19ytwnSRDdj+pE
	RO6teU6yFv3RDro0wW3G9PcvX8ZMZlq0TmWnSNq11h9SL6KXxgJkoSGpuVxmnGgY3bsGOmmzpCx
	QhVVaKuHmHYIeoCbfXhH+dR8bo9FiK5QHGzBTa53BKbkehrUUxIpa93dyJPbvdZeSjLzXYm7SOF
	ZRMwIz7HR80SgxLDO/CHbubJKEekujYqxunyLtuHLD9elde31ZiY9F90g8jhQsGgcocg13x/HoH
	+oTgxKnASzUELGa+aEFGkHKFPRd7nCWGkDkL3wWBAqwD9Ny0ngxLQDB/ftDEKadPT5Lz4G8UsNX
	7+207Y2EclM+T62eBFyZj
X-Received: by 2002:a17:90b:554d:b0:3ac:aa8d:19e0 with SMTP id 98e67ed59e1d1-3b0db5efbcbmr6465830a91.9.1794068220798;
        Sat, 07 Nov 2026 08:17:00 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1058a7b29sm3732962a91.10.2026.11.07.08.16.59
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:59 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 1/9] io_uring/cancel: drop sqd->lock while SQPOLL waits
Date: Sat,  7 Nov 2026 09:16:48 -0700
Message-ID: <20261107161656.2500790-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161656.2500790-1-axboe@kernel.dk>
References: <20261107161656.2500790-1-axboe@kernel.dk>
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
index 75a21ecfe69c..c7ed51377dea 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -650,7 +650,16 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
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
 
@@ -678,8 +687,20 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
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

