Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB6453A5E;
	Wed, 12 Aug 2026 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542882; cv=none; b=nZPg+Xk/7YiEk8tAtiauhh3bUR26UtF3xfdY5BjCvNGlNNrGju1Wf+PDTRTIAdUPbvNvU98Buclxks7P2jgubwbDs1/jYeS3UwNHbKQk0ekpw1A3uO9ZSHIbDMJAvRLvmV+YZBYBGI+tYGNxJf6+g7RzaeMDy9JuiLdAZ5+RkmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542882; c=relaxed/simple;
	bh=5prlBIMuaikR7j4v0HbsDKCZ3fzdc1O6MoQlTU25Gl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxcRL47mSrCz+3QnRyyogWmSJGz+PRt2kqdWxdVSwC36wr23Xqk+X81x3B77DaqxK68ZxWWlzqHCeVoSun0SFavJHMevq5LKNkvvn+Brvp8ngQhz7V3Bqyu8VgeuHSzD6F48pyzoNfEv08WhozzhOe4LkEwcQKzsc9TTVzNbYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=h5XVQhBE; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="h5XVQhBE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1786542879; x=1818078879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i19Nri/sQmXNkNViQnM3o+4W0jtFa3ZN/7Up2hTNe8E=;
  b=h5XVQhBEePjsMbZ6KOXkLLaUntX5K0DcK8eVkZd1borrkFp8svfoeKqz
   a+BomDiFYs1rDFuddAmTDP+ngZZ6ueUcJ/NTUEPKODdtqjxjwOXdzf6xG
   Hs2xCBt55HVN/ELhlJDcIu5tncNFNnGXZ2Fdo2LgTIBvPxasb6MWpAEFH
   VVPeP1FcOPrB/fiL6MMCj7eskTYKf8hRHDWyhz1p8IoX5KNSkH2gL8OMF
   WC/96ol9pDZxGfM2QyUI7abKyor/deVKfmQ4BFbpBRDKk5Pq39KdJyUA+
   OAPFuBjDU0heIP5KJPiwhKrCLhyD/o2ckfQgml906fNtVnSPhZFX1YS8R
   Q==;
X-CSE-ConnectionGUID: CyncxKG2SB+muSY6j4PAyg==
X-CSE-MsgGUID: cwabdT8/SM68X1l/a5IvIw==
X-IronPort-AV: E=Sophos;i="6.25,219,1779148800"; 
   d="scan'208";a="25674786"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 13:54:35 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:22199]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.40:2525] with esmtp (Farcaster)
 id 4dadcb8c-accb-47e5-8d3b-fe752394e1e8; Wed, 12 Aug 2026 13:54:35 +0000 (UTC)
X-Farcaster-Flow-ID: 4dadcb8c-accb-47e5-8d3b-fe752394e1e8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Wed, 12 Aug 2026 13:54:35 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45; Wed, 12 Aug 2026
 13:54:34 +0000
From: Simon Liebold <simonlie@amazon.de>
To: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Simon
 Liebold" <simonlie@amazon.de>
Subject: [PATCH 6.12.y 2/3] blk-mq: pop cached request if it is usable
Date: Wed, 12 Aug 2026 13:54:11 +0000
Message-ID: <20260812135412.2715611-2-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812135412.2715611-1-simonlie@amazon.de>
References: <20260812135412.2715611-1-simonlie@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
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
[ fix contextual conflicts ]
Signed-off-by: Simon Liebold <simonlie@amazon.de>
---
 block/blk-mq.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c1dff0d9f9439..fd21976375ed4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2989,7 +2989,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 /*
  * Check if there is a suitable cached request and return it.
  */
-static struct request *blk_mq_peek_cached_request(struct blk_plug *plug,
+static struct request *blk_mq_get_cached_request(struct blk_plug *plug,
 		struct request_queue *q, blk_opf_t opf)
 {
 	enum hctx_type type = blk_mq_get_hctx_type(opf);
@@ -3005,27 +3005,10 @@ static struct request *blk_mq_peek_cached_request(struct blk_plug *plug,
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
-	blk_mq_rq_time_init(rq, 0);
-	rq->cmd_flags = bio->bi_opf;
-	INIT_LIST_HEAD(&rq->queuelist);
-}
-
 static bool bio_unaligned(const struct bio *bio, struct request_queue *q)
 {
 	unsigned int bs_mask = queue_logical_block_size(q) - 1;
@@ -3063,7 +3046,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	/*
 	 * If the plug has a cached request for this queue, try to use it.
 	 */
-	rq = blk_mq_peek_cached_request(plug, q, bio->bi_opf);
+	rq = blk_mq_get_cached_request(plug, q, bio->bi_opf);
 
 	/*
 	 * A BIO that was released from a zone write plug has already been
@@ -3122,7 +3105,10 @@ void blk_mq_submit_bio(struct bio *bio)
 
 new_request:
 	if (rq) {
-		blk_mq_use_cached_rq(rq, plug, bio);
+		rq_qos_throttle(rq->q, bio);
+		blk_mq_rq_time_init(rq, blk_time_get_ns());
+		rq->cmd_flags = bio->bi_opf;
+		INIT_LIST_HEAD(&rq->queuelist);
 	} else {
 		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
 		if (unlikely(!rq))
@@ -3165,12 +3151,10 @@ void blk_mq_submit_bio(struct bio *bio)
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
-- 
2.50.1

