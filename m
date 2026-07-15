Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8BE4248B2
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784143831; cv=none; b=CT4fWArwsjY3v53tEDsVb1vTmpmjByDCQZOrlzvRzSgfkOR61KZB6TSWDJR07DCwnbfAhicLuY+K+zmQIultHvISla6Zd8TfFncViv/PR4P6znvJRjeEWlNwE6PCIvM5JpsnttyyINUsyg/rK/WhjGFEjHCUhW/NV8n73SQwgYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784143831; c=relaxed/simple;
	bh=/o2pQ6I0UNHS1txPe1Ba1QmitdEVq/qnXd8xOzN3DmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjtDqhizc1fgfsSLWQIp1o/u40u5mrmuwUMXXW1IHCU0+8CH51DFBxuXGKcE0B4DZH2rktuSLHctrF9VR4BUMwl1RJD9JQ+1FLTX0UbqFCpWZxFfgTNG5zVOzqW15+6oChNP6MG+lkqOoYNZYY9l6vOPf5G2SWe6WA9nf3BoqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waychison.com; spf=pass smtp.mailfrom=waychison.com; dkim=pass (1024-bit key) header.d=waychison.com header.i=@waychison.com header.b=CCnFbz9c; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waychison.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waychison.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=waychison.com header.i=@waychison.com header.b="CCnFbz9c"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38759bcd877so5111466a91.2
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waychison.com; s=google; t=1784143826; x=1784748626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k3p19RXCQA1WgE0TNasZ3+exAMqY6Cp1IX2RpB7+gGE=;
        b=CCnFbz9cAnqkw1I4PN/tYDRSCDtzOh/v55Hvz+ySX37+ibWMSofoHbjdtiOAc+zFue
         bRGWDortR0NEghs8bTfOWgGEjN0HVYiQ1HihmDF62IZmSjVSqqS08CVQTqxP9TKAWNHk
         L2f7s8pNJmLAWBqn7N/4jWiwVGD77/sJiG/9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784143826; x=1784748626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k3p19RXCQA1WgE0TNasZ3+exAMqY6Cp1IX2RpB7+gGE=;
        b=QmbOtLsh84kH5bnsVriBHSnDC72KcvX+GJNPjJrHc0SnIeaM5AHTrmmxVR43pdcvyU
         pwDQhgeW3j6Uz3MIkJNh3WHavUOxS0i/SSL9jALmqeHr6QHkZTjGPCoxnaAKhUatbHY9
         kJAyyF35vDdU5bDp6pxlSg2pcL672QSKE7Ko+wdl6o+vasTUVODZ9pfTS6bvp6vHD/Ly
         Kvrfi5lIMt2t60RoCr8PyrKkXmgQ4e6aowd7AFjMZ5ttlTvu3MNVqrsidq55D5LDycGa
         hDJSFcEUCjP1iNnbEGe2SLHNCSrgFfHqk14y7H26rvcjxyoEvc37BW1IAYtlbg4YxNNS
         mGDg==
X-Forwarded-Encrypted: i=1; AHgh+Rqkw/OYFnUDg2a6ilDYoJxNKkJkl0oQVKL1uIG+7bGfGPsSVLvsURM4c1+aP/m23w08KDw0K+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyoexKTUAdMJV31LBsekb2VH0jUP5sRne51nDEXxms50EM9Wnw
	J65ENeZdyTHfMxBdb0aRpeI6ihvZTKnTWQpS2azKnQ2JWIvlyygUHPpPi00gVNCQAyM=
X-Gm-Gg: AfdE7cncaX6u+D0NsmxSELVs6t4HPd8NxLidxnkAy50mVwXtZK5z7xGmPN5xEqikzTw
	8Gv87mkQIJ97zn8czq48WdEMTY3V6plJlQMoHxjLoBT0UXs7v9fRuZ3+sYlX5uP6gIqPxWqGZA2
	H07aDohMir5PQIqF5KbthLQyTYDo4vuJ0E0SBF4vxDNjt2Sfwef+zj3xrdSD46GyID+dnBF6TRB
	FICQNf1Ziq/XTGndM4WmbD7sf9ZDDCXHX4a8Au0H6zyDIzymEuPhpyhuj0WOyvFZWo4HiNBMu7s
	xQhcEgRPIgUQs2xF9ziWWMYlgynmcb82SO65Y7BPrRnwqTg1l/WtWzgAXefG0WPpQV3NVXieb7W
	wXvtAQeZPuLWVGSkwmmxY/T10R0viwxxm4uBLLvonEYXA7DnBpMoBwbGAzgCIsxVPItx0R//Pto
	MDjTvwY5g=
X-Received: by 2002:a17:90b:4a04:b0:387:e0bb:5802 with SMTP id 98e67ed59e1d1-38e2a12332amr3793336a91.41.1784143825821;
        Wed, 15 Jul 2026 12:30:25 -0700 (PDT)
Received: from mike-yyz. ([184.175.42.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39e1b7adsm84595a91.7.2026.07.15.12.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 12:30:25 -0700 (PDT)
From: Mike Waychison <mike@waychison.com>
To: Jens Axboe <axboe@kernel.dk>,
	Usama Arif <usama.arif@linux.dev>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mike Waychison <mike@waychison.com>,
	stable@vger.kernel.org
Subject: [PATCH] block: fix race in blk_time_get_ns() returning 0
Date: Wed, 15 Jul 2026 15:29:50 -0400
Message-ID: <20260715192950.2488921-1-mike@waychison.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_time_get_ns() populates the per-plug cached timestamp and then
returns it by re-reading the field:

	if (!plug->cur_ktime) {
		plug->cur_ktime = ktime_get_ns();
		current->flags |= PF_BLOCK_TS;
	}
	return plug->cur_ktime;

This is problematic when the compiler emits the final
"return plug->cur_ktime" as a reload from memory, after PF_BLOCK_TS has
already been set.

Since the cached timestamp is now invalidated from finish_task_switch()
(fad156c2af22 "block: invalidate cached plug timestamp after task
switch"), a task preempted between setting PF_BLOCK_TS and that reload
has plug->cur_ktime zeroed by blk_plug_invalidate_ts() when it is
scheduled back in.  The reload then returns 0.

A 0 handed back here is stored as a start timestamp -- e.g.
blk_account_io_start() writes it to rq->start_time_ns -- and later
subtracted from "now".  blk_account_io_done() then adds (now - 0), i.e.
roughly the system uptime, to the per-group nsecs[] counters.  On an
otherwise idle, healthy device this appears as sudden ~uptime-sized jumps
in the diskstats time fields (write_ticks/discard_ticks/time_in_queue).

The solution is to be explicit in our reads and writes to this field
that is preemption volatile.  We also add a barrier() to ensure that any
setting of PF_BLOCK_TS is ordered to happen after the cur_ktime update.

This issue was discovered using AI-assisted kprobes looking for paths
that were leaking zeroed timestamps in a live system, based on the
observation that we were sometimes seeing uptime-sized jumps in kernel
exported counters. This was flagged by NodeDiskIOSaturation
prometheus alerts that started firing on all hosts post 7.1.3 kernel
upgrade, due to node-exporter now exporting a nonsensical
node_disk_io_time_weighted_seconds_total.

Fixes: fad156c2af22 ("block: invalidate cached plug timestamp after task switch")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Waychison <mike@waychison.com>
Assisted-by: Claude:claude-opus-4.8
---
 block/blk.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index b998a7761faf..17e03656ba9a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -689,6 +689,7 @@ static inline int req_ref_read(struct request *req)
 static inline u64 blk_time_get_ns(void)
 {
 	struct blk_plug *plug = current->plug;
+	u64 now;
 
 	if (!plug || !in_task())
 		return ktime_get_ns();
@@ -697,12 +698,18 @@ static inline u64 blk_time_get_ns(void)
 	 * 0 could very well be a valid time, but rather than flag "this is
 	 * a valid timestamp" separately, just accept that we'll do an extra
 	 * ktime_get_ns() if we just happen to get 0 as the current time.
+	 *
+	 * cur_ktime can be zeroed by pre-emption the moment PF_BLOCK_TS is set.
 	 */
-	if (!plug->cur_ktime) {
-		plug->cur_ktime = ktime_get_ns();
+	now = READ_ONCE(plug->cur_ktime);
+	if (!now) {
+		now = ktime_get_ns();
+		WRITE_ONCE(plug->cur_ktime, now);
+		/* Ensure PF_BLOCK_TS is set after cur_ktime. */
+		barrier();
 		current->flags |= PF_BLOCK_TS;
 	}
-	return plug->cur_ktime;
+	return now;
 }
 
 static inline ktime_t blk_time_get(void)
-- 
2.47.3

