Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068204;
	b=3yUMrAp+p+VTEvjbrAgih8AwEXToZVSMmSv2CwcFiW7UG31EXOLMES837zx44X/03TZ3
	 Y/BBYKjnMVybumaSZCH+Wllj5c8ULZGdFVE52IETsqgxL+QHymK/BRiBZO55GbJw0OjT7
	 RD/p3LbsqNPLw8bRgaDQQiOv41u0IXqnB0NCHJ4Z6IkRXcTU4lYTAW7fpK0OvF1CQvVXs
	 1FR8Mil1vszyvYKmTlGx6gY2XCu0HyZAY+JL38caoknMG/NEdmiVoRCL2f6ycxrGSrazD
	 3H07wfZU+UTUK/cesAc01AQiOUxxpWbW9WsmHoKt7gxYVzbbI/pXhB13+aKEfReY/2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V0tXlb3eD3nFk9zZCTTXCVj6DaeJoJ38rtbisrRciEE=;
	b=w59/jjo+fip4SdSdFOXlH7Asb1ogL8ASxn7RpJTgaJplJKaNCVetsrTbwNoS+3STw133
	 W3GOX+YzCQS4rqPPBOzlFMkzC9KDnkrY1U6dAw+OS/VADicK3Gm6tRvvIoSs0e43g/ARp
	 PZ2FDWz1NTb3mBvhOdHAZ/KxnbqErMsAD0i+llgwjePJWwyX6og6wJtTmePLeXYwPkAnG
	 kquwFFUyYrgiLaCiFCsMWwip6LzdwPpmtqHhsk4+7iFPoXlLSY7o07V7TZi1BAhHfJNAR
	 /yGW8j1zqc3JfwKcCk1nNd/u2pe26pxzM2eTprYuAvRUi0RNaPEMhkpeQa3i5Ot9zKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="HJWJ/HxH";
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F7D606A337
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6F7D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HJWJ/HxH
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ed1e9ae5a8so5418265ad.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068203; x=1794673003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V0tXlb3eD3nFk9zZCTTXCVj6DaeJoJ38rtbisrRciEE=;
        b=HJWJ/HxHr0YZvMQNM3Lo4OeVtkTX+lACwdwcgF26uxt3sQY4Pys0C6i5yKQRydKzwg
         1y2Nx6ATJMpgdrhpVivZLZG90hAFfWtt7ld/jfd0DPibrUG+UYhluft5VCDdUKY5hOj9
         MCiWzgJC2Sh/Zv9lNWFH0n02QdkU1EhQeYVTSj2KpHy1wVVdEG2F8IRueIHau+072vJi
         eJSq+z5XW7ZqG7WKhOsRm9rJfZf55GNXQUCawLQcug6HKAbh1Fd4G2hpN2XKrFIDBo52
         ryyOGkWsw4cCnKspC6hRn0xoJ+LZn06eKKJ8BBRsdIyRWUBoG4uXoBbRTHY0YdZDepTD
         ClLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068203; x=1794673003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=V0tXlb3eD3nFk9zZCTTXCVj6DaeJoJ38rtbisrRciEE=;
        b=V/+xCnJx8r0v6jJUiDQIC4s1JIP4fccCH44/ZCmYiROSpvSUZ5c3clNIyejcT8C1Di
         7fFe3a+XpogbxI73TzI2M+yTuK0/3gaeZpi1ILqAx9QOuAKypfFNdlHHV1qrMfCLk+rY
         ej2KgUKCTmhFD084YR5jmmD6E57nga54ppD3yyQrbbgE8m9ZotoVNvsHn0niz5+c1PYE
         L5QsZqOsWNhV5C2+41f918B1kMPILGVeVh4eOx2fOqJTd6XAElgRt9z26ft6Dq+iIOsF
         hD8Hkm0iUWHQt70sAqUNNGPPfwlKhzCvVb+sk5TuY4rxyuexQdtD+iK/1iy3WIMc61xS
         3y8w==
X-Gm-Message-State: APuU4Z/PcUGLuT3dUUIdUXFfRko6ARyX3Zpvft149cWnqkftCmOQitzG
	BAh+nUy6fral8tTyB0bGqrRO6i5OgFy5KpokaXdfYhTse+h8Gnjy/DWsIFsz4vApkm2C5aDz4Xl
	uxhjjTew=
X-Gm-Gg: AYBFou2qNDk3zmpTS+09kB89GybevvwoJENB1DV4/IsHIhqRB9u5auhSALuE9bxOkfA
	CR8kOtZ7BYpWWjOgylGDVQJwCtqfwdTWu0mSfF00girAu64m5wkKTZKBsYeuehwj+56d4U8kpUt
	iPBjsNuxE42yIC91P91bTuXw58zWosnv2kZAtX5XCi2DXTjcXQIweFCwUh3PZZWwBzzfa5kIIz2
	njHVZphLd9YpE+aN3v8kGaEEOusUHtFXJthmKeLp5bmm+L0WD582EEzZPOXJFPAXRW+6QaiZWbP
	V3wCqK2IxCq+Q58lxAKO9sclWQX55DDoJZYpdNiTccoIWVi5Oa1w5ErjGJChsSKWNcXBsKW1Wx0
	+uSIoqaUO9hUmgQqPmHEn2G+WF1JHq7tFL8M75sLP5haLu40I9ikjIehl+zY2mrHD5P3NB3FVQo
	etsqxxXirFoRMnNmeVXBRa25aFQqV1xWY+78decEuPBm7gssbOlYChkAdleJkpEPqSFyfy2ojQK
	ceOKhVRM87oDm4St+lusGXTjYhizTUBomnCu8ZhcGSfGXgrsDLThPa3Dng4kKoX4xo/vEk7JVkp
	E/pGPHTU4OGRyOxQQMsYFpSst6ZOXxypIkP3m8a8/HXNVAlWD7OqhDuAQbY7fRXA++lZn+em+Og
	=
X-Received: by 2002:a17:90a:e185:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-3b0db6c9b4fmr5924902a91.18.1794068202945;
        Sat, 07 Nov 2026 08:16:42 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b10581caccsm3753898a91.10.2026.11.07.08.16.41
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:41 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y 4/9] io_uring/sqpoll: do the return-to-userspace work in the SQPOLL thread
Date: Sat,  7 Nov 2026 09:16:29 -0700
Message-ID: <20261107161634.2500557-5-axboe@kernel.dk>
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

From: Shakeel Butt <shakeel.butt@linux.dev>

Commit f013b695506491c5202a412a6568313549c81f50 upstream.

The SQPOLL thread never returns to userspace. io_sq_tw() runs its
task_work, but the rest of resume_user_mode_work(), like memory.high
reclaim and block cgroup throttling, only runs when the thread exits.
So memory.high reclaim only happens inside a charge, with sqd->lock and
ctx->uring_lock held, and not at all if the charges can't block.

This used to work. The loop called io_run_task_work(), which does this
work since commit b5d3ae202fbf ("io_uring: handle TIF_NOTIFY_RESUME
when checking for task_work"). Commit af5d68f8892f ("io_uring/sqpoll:
manage task_work privately") replaced that call with io_sq_tw().

Call resume_user_mode_work() at the top of the loop when
TIF_NOTIFY_RESUME is set, with sqd->lock dropped. It runs once per pass,
so a pass that charges two or more batches still reclaims inside the
charge, as before.

Tested in a VM with memory.high=64M and swap on zram. An SQPOLL ring
reads 256M from /dev/zero into untouched memory, 64K at a time. Before,
the thread made 337 calls to __mem_cgroup_handle_over_high(), all from
inside the charge. After, it makes 704, all from the top of the loop.
memory.peak stays at 64M. With 1M reads, 296 of its 385 calls still come
from inside the charge. Both runs take about 50% longer, and the extra
time is in the handler, which now runs more often. Without memory.high
pressure, the test never calls resume_user_mode_work() and the times
do not change. Lockdep showed no warnings, also with io_uring_register()
racing for sqd->lock.

Fixes: af5d68f8892f ("io_uring/sqpoll: manage task_work privately")
Cc: stable@vger.kernel.org
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Link: https://patch.msgid.link/20261101022146.309201-1-shakeel.butt@linux.dev
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/sqpoll.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 1d31a4b1a9aa..66405f4630e7 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -358,6 +358,18 @@ static int io_sq_thread(void *data)
 			timeout = jiffies + sqd->sq_thread_idle;
 		}
 
+		/*
+		 * The SQPOLL thread never returns to userspace, so do the
+		 * return-to-userspace work, like memory.high reclaim, here.
+		 * It can sleep for a long time, so drop sqd->lock.
+		 */
+		if (test_thread_flag(TIF_NOTIFY_RESUME)) {
+			mutex_unlock(&sqd->lock);
+			resume_user_mode_work(NULL);
+			mutex_lock(&sqd->lock);
+			sqd->sq_cpu = raw_smp_processor_id();
+		}
+
 		cap_entries = !list_is_singular(&sqd->ctx_list);
 		list_for_each_entry(ctx, &sqd->ctx_list, sqd_list) {
 			int ret = __io_sq_thread(ctx, sqd, cap_entries, &ist);
-- 
2.56.0

