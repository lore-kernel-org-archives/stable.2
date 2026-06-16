Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2882877F4
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647392; cv=none; b=Q5Mzf+gzoEWaDtrtcIEkzk0lWF81sKm84BwO/3vs89Q42arLY9sz8+ZiBL5wCzjl0ZB/vzAspoDaCBWKUhvTJ0iCNBjUZuLgF+3CSGuwHbnbpjYXMk4rjjtUgGCtFK48/nbueofACJTds8AHnLCq+horrpb/pEVxFPSVQQckdtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647392; c=relaxed/simple;
	bh=kMIyOPyyPt38UyDnITJTgKCZUzj9WUW/qPR3hrmv3u0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FM65HAEVhUuJGtgWHHMvMi2NaE+EApGbC5kVXfU58wCNu14LXy0HU7el5n0JZ5lZEnqTTSbmxDtPzIXbc6dO03zLvVJGZr4Haqj5n52ryufO9TZU2/Hyu1LV7CkJbR1wiNUDTdqONQDiq7TOm1mMypJ1/gTU0Fta89iBnlnnhZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=uzlfo+cH; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="uzlfo+cH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1781647388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aC2zHBB7viNDTfbkrGQIbZDq1+Il4dEG6NUdwG6XLkE=;
	b=uzlfo+cH+54jWn/5+a5l4GOQ2w+ndhW+rRFr+4Z/PV7mItD+8aGqM4xBbVqMPYjQMhLgqP
	Hbobx+8GNxkrvrhka2XsLRkEubTHRtCphWoZDIpytVI6YCzOExs5/Q//4goLHYfkO8slEd
	mhH1g4GPeTRszimOPqtUniKSU1Zw2avH4N1UL7OXM2X+GpWEBSwMwewx+nMRbmAgf7N3Dw
	9kN0GDURfd64wiebyV2/eBC91q8MI7tgB6V0p52pCYdmdWSkAwo/s4GPNYkc0biujofz91
	hSoB0imnBb+gWeXjjQxMIOw9T2LVBbBMP8DOaEoug6YDcQhGm6IURj/JQKQ9Lg==
From: Xingquan Liu <b1n@b1n.io>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Xingquan Liu <b1n@b1n.io>,
	stable@vger.kernel.org
Subject: [PATCH] net/sched: dualpi2: fix GSO backlog accounting
Date: Tue, 16 Jun 2026 18:02:43 -0400
Message-ID: <20260616220303.31552-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When DualPI2 splits a GSO skb into N segments, it propagates N
additional packets to its parent before returning NET_XMIT_SUCCESS.
The parent then accounts for the original skb once more, leaving its
qlen one larger than the number of packets actually queued.

With QFQ as the parent, after all real packets are dequeued, QFQ still
has a non-zero qlen while its in-service aggregate has no active
classes. qfq_choose_next_agg() returns NULL and qfq_dequeue() passes
the result to qfq_peek_skb(), causing a NULL pointer dereference.

Count only successfully queued segments and propagate the difference
between the original skb and those segments. Return success whenever
at least one segment was queued.

Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
Cc: stable@vger.kernel.org
Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
 net/sched/sch_dualpi2.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index dfec3c99eb45..37d6a8960310 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -461,7 +461,7 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (IS_ERR_OR_NULL(nskb))
 			return qdisc_drop(skb, sch, to_free);

-		cnt = 1;
+		cnt = 0;
 		byte_len = 0;
 		orig_len = qdisc_pkt_len(skb);
 		skb_list_walk_safe(nskb, nskb, next) {
@@ -488,16 +488,15 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 				byte_len += nskb->len;
 			}
 		}
-		if (cnt > 1) {
+		if (cnt > 0) {
 			/* The caller will add the original skb stats to its
 			 * backlog, compensate this if any nskb is enqueued.
 			 */
-			--cnt;
-			byte_len -= orig_len;
+			qdisc_tree_reduce_backlog(sch, 1 - cnt,
+						  orig_len - byte_len);
 		}
-		qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
 		consume_skb(skb);
-		return err;
+		return cnt > 0 ? NET_XMIT_SUCCESS : err;
 	}
 	return dualpi2_enqueue_skb(skb, sch, to_free);
 }

base-commit: fbc6a80cb5d3fd4ac4b56e8c9d791dd17be890c4
--
Xingquan Liu

