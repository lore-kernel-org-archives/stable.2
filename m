Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068148;
	b=TLJsP7krLkB3Ckgvo7atr9JfjR4EzNPULZz8LNNAhwL2K3zROJw4fQfbYXt8eNAAsIoC
	 ivBvOT0gEryXnLDx6m/fGq47IZplSlomO0/4sHujwmfur6MYt6cJu3cHkmawvznWUUvUn
	 QS67euXHcN08fU8W4j1vPHa7tl4hdOvqAeL4gixyDDRydIh6G/3SwnBqUmK4K/uVKVAxB
	 syHzc4jvMy3sHaJtkSTTg4STfJok/LDVHxStNbD8+ggMskBNMWaWpZpOHNw3KyIhkMHD4
	 RzVmK7BfmXY4ufjoinw73EzQKOZDHWy3xBeWmakIu8GyhSXPwDZ1/can7vn3CTINPYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068148;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AZbs6SbdYoG/1/xdxC6vB+pl7MOj/ZcoBb4FrSs+muw=;
	b=3FUa8rY96FCuaoDktzkG/HCg8R06VmwwObu/WHo6HgWJ0XfLIZNgGUjC/gxDqhN6y6XQ
	 wzj2TBCS5XlHYcWvA7R58+aIf8SRWBMZmIHOfAmPWKtz4EGGfO6fOhQC3uXwjvw2PA1HY
	 2trpxMEr45gqEwy6640G2IKRVNc30tIid7sjo3omAWo7GP8/lHueTRUB58iinOoPAPHKr
	 YZoq51W6gWFpwkvE71vSEOPvLiZOjn8zEOqn67XonaHFMUmLUnXtut+HshXUTp2CqkSf3
	 I7gZbKDX/FUBvm0yXYZd5gGnChLuwTDU+O0pNbQo7TJQd2K00qdwElPFy40cwhux0pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="W70gSmT/";
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD680606D3D8
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD680606D3D8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=W70gSmT/
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e9d7791b00so13086885ad.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068147; x=1794672947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AZbs6SbdYoG/1/xdxC6vB+pl7MOj/ZcoBb4FrSs+muw=;
        b=W70gSmT/6d7UcNK0y/zbtBJ6n0rWZgBNXMF1rw9YNWgFFlwmwBn2M0MRFjIL/CWvE+
         W9VMEe1crheKkSIEuEjrFRCGy7NH5xDZki4QJ6CGlrYkfunsOJHScfPsEP5MtAu5B5a3
         Yx2tFcY001h6W9qczcK5JR88fajAyxx4XO4nE4mvVLt2SlUyQ1OxAdyphrmoZnZO5BmB
         NXzzN0q5BRZJC9Yba2BShq80sDMyFYN4UjkosJdHO70enK66k7Avxh0lQgKzaNFie51t
         D7JY1n+JoAs3koq3Dt3uIUmHOcE2t7ZJOIiHSxHYm/KGNadl5RKLNwQPhPyO/aqSgCJS
         reHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068147; x=1794672947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AZbs6SbdYoG/1/xdxC6vB+pl7MOj/ZcoBb4FrSs+muw=;
        b=fdJ//o2LacN8p5vib1BkNEaNxB/j5hpJfGggWCTJZwZj4cXBqBLBUpXyk7B8n7V9EQ
         ws13vB+cd2wmJj4cV/J09CTxomMkc98NHrTZLAlIyACYEn6csx62IFcBoUUa4mqebR4q
         kRP6yN+60JHjjK7oWuNdsavbxUrKGb70cIVE9bCl2p7Y6L/NqMVHGdoCG3AWyVUmEbxI
         9TlZwFLfFflg/JxOTR5dPL14mXE0siuJ43MJem6yUll1w8oE21zVfOXmkORnx+bfW/eQ
         FJNYdSodqVcycgvDn8BnwWEnoeyZH/yV5bEEMZywUqoUq8nKH6rV1/ZcP7VUtc3NdE+u
         k14w==
X-Gm-Message-State: APuU4Z9buWwfjAPmDxnOHpuJZQHJARoYNjz2q8GKrg8CTFVbPKYy4L86
	Jdi6KK3KmAxMx/3ImKPJOtsVwP3Sn7Rrx5+WYhSYLsQg3/tOXThLNFUoUYwHKhxLIBk3RND0CdB
	tO4VL0fc=
X-Gm-Gg: AYBFou2pakRlURqQRqgBqqnA0JpEY54WFRzkiXqIB6jXPrOrXDxGHcTEgibplcJt5zN
	MX+ZFoJXHq0PO30umSAgItO3e/vfT7LK8A6zRDdtoJXZGBIm4B05hKfSpt4VuUT/eJZlJy4dVTm
	Iyy8MGrqTgqWglUf2MiJFhzy0/2Ix9XbnNpfMIqeHNoycQ9+cEsAOD805+sgkp2saJO1YyBWjfK
	EXgwk9tPb/3CW4yDJEi5pEF59csAL+ACKlo14UKKpILVZ1S/NvEmgr/76tTHTfCD/qkuuwNBaDK
	84moX+Z765j3zSCNKOD1caCZ8YieS4qepICkPXFq6n6L/70lmKO2pzM7MU21sWYYGiu+tsZfgpY
	En3wvicRMaS0RLVB/ySotXSQzcjlwWMz4+4UsuOw0cF4wcV9nycZHOVLuP+27j/aTg2SIli5zaF
	5BaJwhEWjX4Y3SJY4uH9/S4yDO/wHm6Isi2JRWM4vkoUcfi7RIYwppvcRI5dxU2edbrfcxG2H98
	uLBMJJ0CbBFDUcvp1NZ8xKJWx/dJ17ScFslFRSdfowIijKgBRCzWfRa2FRfdbUzWkFNpjmv2CzF
	ZtbGIToPN87CPXGxWJsPuy6akVmyvWP+AAGddsXjobCw+4FefQ4WSvP9A4hAFBkBXC93I4wxmEQ
	=
X-Received: by 2002:a17:903:22c2:b0:2ed:29eb:177f with SMTP id d9443c01a7336-2ed40988199mr69614645ad.13.1794068146881;
        Sat, 07 Nov 2026 08:15:46 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d5f234sm13144985ad.46.2026.11.07.08.15.45
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:15:45 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y 1/7] io_uring/cancel: drop sqd->lock while SQPOLL waits
Date: Sat,  7 Nov 2026 09:15:36 -0700
Message-ID: <20261107161542.2500190-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107161542.2500190-1-axboe@kernel.dk>
References: <20261107161542.2500190-1-axboe@kernel.dk>
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
[axboe: io_uring_cancel_generic() is in io_uring.c in 6.6, and uses a
schedule() based wait loop]
---
 io_uring/io_uring.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index af349afeb4cb..43860048d2bf 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3566,7 +3566,16 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
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
 
@@ -3584,8 +3593,20 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
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

