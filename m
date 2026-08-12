Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1642FCA1;
	Wed, 12 Aug 2026 11:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533972; cv=none; b=blHHFNr1SFDQswDn/GFhwi/qgQhX+hDPqpWUtH80XKRgVKqnyTjz4SB/BcmANJqQYnNvHIOE8lFtVILJPj+14721GX4b8gV2x3kGBLNsFU+MMMc+7PVrbxQmxto5minHXBI0+jsC280RLjd9NChhspk4AqtU+x/7hWW+D2WcMrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533972; c=relaxed/simple;
	bh=x4zVZy/4Gw4Kh0sKDdA5vMvOfAI4KSIhzYdd6uH4VLY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V0qP6/QDO6la/v5Ao+eas2FhfFhZmidaYqjxn6vBCKx34zm8vJFDy92iRO5mGuWUkpXYYFDrPha8oZ+ft0eNCClZ5hOkKordxIVMFP3lg2bas4LbMYKl26UpdKP91vudnw4vLU7iM+xrGchE6EzUv0/IbblAYPXVFI/FJ3rUIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=SeO6m2yt; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="SeO6m2yt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1786533969; x=1818069969;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1tg7B1zD1egL+D8CuslrJDXfxIsbHWRwbCXLRjrVcEE=;
  b=SeO6m2ythmqQ7FRH4UvOMtpZ0DstUP9M74zHqyipe8mDDrvERMMHI4+T
   2hl7v0ost3nhRlVgzBLlaFkevdwbl5pUgIJOeMpfZniboSO+8ZetQEYQp
   J4TpcKL7l+r4Ong83t3YDiK3N/eo4DCpZflNx+WTM0tiNncYEk1LHyCdx
   jNnnX3twSi+VnSmrAvU+K+NsOfCkghyKV2UxdvG9YH8ZqysiRk1yMbei4
   9vIWpa2QJ2GhukzU72bD18qWc+kCYsJX3Oo2GWlodcxtTSJhD9DtHH1H0
   aH8qOhsrpJhTAsDpfXv02DtJUVtaMLnLITHj77ejM5QGT5DCd8ckpCa1S
   g==;
X-CSE-ConnectionGUID: alRG/RyjQk6JigDKIE2sLA==
X-CSE-MsgGUID: 4Y/+ASnaTai7qHm34TIfuA==
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="25566000"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 11:26:05 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:7212]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.125:2525] with esmtp (Farcaster)
 id 24834529-4e62-4935-a83c-df8ec0d7c5d0; Wed, 12 Aug 2026 11:26:04 +0000 (UTC)
X-Farcaster-Flow-ID: 24834529-4e62-4935-a83c-df8ec0d7c5d0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Wed, 12 Aug 2026 11:26:04 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Wed, 12 Aug 2026
 11:26:03 +0000
From: Simon Liebold <simonlie@amazon.de>
To: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Simon
 Liebold" <simonlie@amazon.de>
Subject: [PATCH 6.18.y 1/2] blk-mq: pop cached request if it is usable
Date: Wed, 12 Aug 2026 11:25:44 +0000
Message-ID: <20260812112545.2630000-1-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit dc278e9bf2b9513a763353e6b9cc21e0f532954e ]

When submitting a bio to blk-mq, if the task should sleep after peeking
a cached request, but before it pops it, the plug flushes and calls
blk_mq_free_plug_rqs, freeing the cached_rqs. This creates a
use-after-free bug. Fix this by popping the cached request before any
possible blocking calls if it is suitable for use.

Popping this request first holds a queue reference, so avoid any
serialization races with queue freezes and can safely proceed with
dispatching that request to the driver. This potentially increases a
timing window from when a driver wants to freeze its queue to when
requests stop being dispatched. That scenario is off the fast path
though, and drivers need to appropriately handle requests during a
freeze request anyway.

The downside is the popped element needs to be individually freed when
we performed a bio plug merge. The cached request would have had to be
freed later anyway, but this patch does it inline with building the plug
list instead of after flushing it.

Fixes: b0077e269f6c1 ("blk-mq: make sure active queue usage is held for bio_integrity_prep()")
Fixes: 7b4f36cd22a65 ("block: ensure we hold a queue reference when using queue limits")
Signed-off-by: Keith Busch <kbusch@kernel.org>
Link: https://patch.msgid.link/20260521190253.242065-1-kbusch@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Simon Liebold <simonlie@amazon.de>
---
 block/blk-mq.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ab05c5c9e6ae2..711d295d36db9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3057,7 +3057,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 /*
  * Check if there is a suitable cached request and return it.
  */
-static struct request *blk_mq_peek_cached_request(struct blk_plug *plug,
+static struct request *blk_mq_get_cached_request(struct blk_plug *plug,
 		struct request_queue *q, blk_opf_t opf)
 {
 	enum hctx_type type = blk_mq_get_hctx_type(opf);
@@ -3073,27 +3073,10 @@ static struct request *blk_mq_peek_cached_request(struct blk_plug *plug,
 		return NULL;
 	if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
 		return NULL;
+	rq_list_pop(&plug->cached_rqs);
 	return rq;
 }
 
-static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
-		struct bio *bio)
-{
-	if (rq_list_pop(&plug->cached_rqs) != rq)
-		WARN_ON_ONCE(1);
-
-	/*
-	 * If any qos ->throttle() end up blocking, we will have flushed the
-	 * plug and hence killed the cached_rq list as well. Pop this entry
-	 * before we throttle.
-	 */
-	rq_qos_throttle(rq->q, bio);
-
-	blk_mq_rq_time_init(rq, blk_time_get_ns());
-	rq->cmd_flags = bio->bi_opf;
-	INIT_LIST_HEAD(&rq->queuelist);
-}
-
 static bool bio_unaligned(const struct bio *bio, struct request_queue *q)
 {
 	unsigned int bs_mask = queue_logical_block_size(q) - 1;
@@ -3131,7 +3114,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	/*
 	 * If the plug has a cached request for this queue, try to use it.
 	 */
-	rq = blk_mq_peek_cached_request(plug, q, bio->bi_opf);
+	rq = blk_mq_get_cached_request(plug, q, bio->bi_opf);
 
 	/*
 	 * A BIO that was released from a zone write plug has already been
@@ -3189,7 +3172,10 @@ void blk_mq_submit_bio(struct bio *bio)
 
 new_request:
 	if (rq) {
-		blk_mq_use_cached_rq(rq, plug, bio);
+		rq_qos_throttle(rq->q, bio);
+		blk_mq_rq_time_init(rq, blk_time_get_ns());
+		rq->cmd_flags = bio->bi_opf;
+		INIT_LIST_HEAD(&rq->queuelist);
 	} else {
 		rq = blk_mq_get_new_requests(q, plug, bio);
 		if (unlikely(!rq)) {
@@ -3235,12 +3221,10 @@ void blk_mq_submit_bio(struct bio *bio)
 	return;
 
 queue_exit:
-	/*
-	 * Don't drop the queue reference if we were trying to use a cached
-	 * request and thus didn't acquire one.
-	 */
 	if (!rq)
 		blk_queue_exit(q);
+	else
+		blk_mq_free_request(rq);
 }
 
 #ifdef CONFIG_BLK_MQ_STACKING

base-commit: 1efe5d048a391de3ead2804b2e7f86376c356cc5
-- 
2.50.1

