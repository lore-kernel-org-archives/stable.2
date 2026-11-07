Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794068180;
	b=rcdY/decZpXPBMPCj9+5/0Zc3EFRcChVr42bhg7GV6fZNuXb7QRilHPbKWOzNj5y8Pdo
	 CwZuwcyjoFI8sjgujXY/RoCofpCvTJM6QmwIhy3i8rB2qlrnPLTq/m8BL/0e0odXGM3Hf
	 vTjMHCu8SXQ3SIVoHEqBxncpKJ6anqSdhH+fL3VDofXXctcX71RB1IJYM1Zfu0ci19VLK
	 eoqCO7CcXn6eavWu7/XwGqH+wt4lxdetuiJuF1h9r8QL2o07LgUbKSHm6lqLdLGgCV4bY
	 Ni97u7x3N4/nV/dxJtr37YnoqlVVTlk1u+oPFDCSpypaywyuDodaKipQtJKnvcPKWyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794068180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6qec1Jdp69Sc0kOkCf8HTuqvv24e4JJYAFz6SEgdUAM=;
	b=kmD1rM8KKfaz7sLaUBr3OH2+wWAxNg+oFrfZDhjiuYRvZlNSgDrQ9w9Rpdw0aWr6QtVW
	 g6IJl50610IC2eoiPoqjAW5dY+8SVKtRzXDFpONLUoB/n1FlS+OB/LVl1OCiD3xK2+nYv
	 zTS6bfLTJW0LahtLo/gT6swP9r36uOasPTtq+t6gRb9BEsHapibIJtzYGHxtmJEOr8lpF
	 7SpKRTUdqUNNSQnueE4ZqyeFy/z3rVz0+OR0WxhEmaP9BuoMQltG9/BK+c8SdxUUBkiXt
	 NytWZmkUkwWXvlxvNJapiaBcP3VeI9SbNj/e4irbzN2eOPvdeEbT19v/BJwMOSrjcsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="WFwKXxa/";
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB75606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 16:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EB75606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WFwKXxa/
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so734737a12.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 08:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794068179; x=1794672979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6qec1Jdp69Sc0kOkCf8HTuqvv24e4JJYAFz6SEgdUAM=;
        b=WFwKXxa/ptM6MLUm7gApzypslzIrE80A3DntoJWJ/3GynII4Ms3EX4FO7YDwi9kLXQ
         girDJfj2Qo4cRm56CH8LvO77fIPBM13AHeGZm0+edoNsTCvaP+KeaNpv9CCQFx0tGPRm
         SS8nf3H6h8GWggYuyqtNt+RmuSVlm/iZ2BuVcQIHw+1QHklMeKfy+96zkiiBO6WDOm4G
         Kn0PkuJs+eoe1NXn/ziOKHCfzvRqlrxAii7yyrvOFdn8FxbJwB5CYIgiM+/wiDVsHKWf
         CDyw678DOnuxvts+0GIG3wux7HLPDlBWxUabVKrN+QvZTdMpTEVsbdj7DNpH7X+CLdQR
         oO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794068179; x=1794672979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6qec1Jdp69Sc0kOkCf8HTuqvv24e4JJYAFz6SEgdUAM=;
        b=0yGpgYWx6fWXNn9iOXhX3r0ktJQJztkPS5P4LSwEjiGj1aCRgIqRfbX+qjMta/jbJv
         gdP6kAXlldgoZTGHc6eA6cwBSJuT2I4L32SzFAGeql3EXB39TCDnafEyHv5caiN4bL2f
         5A+i+E/P7I0EAcxHOkXQgMZ5eLJAGWHNjj6ONnU/sJDREN0i27gPW8mhL7Je4Cpsh3ke
         /hvMyNvuQ6HN7mNGC5pcC2c4J1RetQrl7AZt68uBZ/c/VYuwoJDIqyfqE689m+y9cfvg
         dhYFBxN7KxxLSGtWfpbP9yRvzwBGTDeKJBLrgYrHrd6svR8hzCRf28YHjgOgdLBWfmlg
         ebCg==
X-Gm-Message-State: APuU4Z/ZIERmBr/9/EMR0GAEcYsbnekC+3VhBGws9Dn0xzP3Rtx1bmfq
	G1lLJFmu9tKytUwmrKg9uTwcKieNm6Db8NtkJXbUQ1/skbxUiAI1QZSa67JA6XxOr5K8KZ2JhES
	6zaweYR8=
X-Gm-Gg: AYBFou3mWa71rnsSaTM58xNRTXFuycu90HdiZ2XACwJQHC/vyyyYwi1wEYEmTOvj8Mm
	Ib+yMgoNWA7P+/6HEKnpahp+6s9NSgcReFrBn68/Ma0BfllyA0v62UGyicne5xgUM5wWlpXzxUt
	GSQ+K8Ni3XpkJaX3NSm+9WITcxbzz6UBBQ1ROKNhpkVF/L5ljkMj8rBAeYEgJA90wAnc1YGbvRC
	Y0izw+KZ7NLD1PH5td7DRNcdCmouXsCI4HUdRHazeQGA6PudIeASKUB/Cv1jges1ro8EygNK1Qy
	MtRv4dnokdD/UV1cKf//pJs0YDXilaOdwdmVFAfnS/+KXxSy3IX6Gveno655SwX65XRqCWPiWAm
	cZaTYathqdCrWewGIyR33tw4F2luL6a+TunfO4FZoc3zYNyPKr7oM5l9OCG+amb0kCJz+TO4LHg
	k5BARgLj/LxZk41d+FjeMn5o0RViswZ0aJGMeJauapUOOZAdF/v8JX8t+4ISWD57tpvdMHAd6EY
	PAMWNk7p0k6C5qV+uhf4sR8dxYoBqmH2UNFZupoi9INXkl46PQF1hmtCyoCTFasHydPDpgWLonJ
	KWU3iaXaWDrm7WSPHQgH+OV03E/uqIjN5uHxgjt+qEjrDRSfm9dZCq/vhp4SdvMKbTheLbyopls
	=
X-Received: by 2002:a17:90b:274e:b0:3b0:bd53:8e5d with SMTP id 98e67ed59e1d1-3b0db727171mr4874897a91.58.1794068178960;
        Sat, 07 Nov 2026 08:16:18 -0800 (PST)
Received: from xps16 ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb7064908fsm1344384a12.7.2026.11.07.08.16.16
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:16:17 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y 4/9] io_uring/sqpoll: do the return-to-userspace work in the SQPOLL thread
Date: Sat,  7 Nov 2026 09:16:01 -0700
Message-ID: <20261107161606.2500384-5-axboe@kernel.dk>
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
index 09cd74c4d0dd..130da8f8f67b 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -355,6 +355,18 @@ static int io_sq_thread(void *data)
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

