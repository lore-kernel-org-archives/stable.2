Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C5318B0A
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854344; cv=none; b=ay/tO9vn+74ngrol0EfRmFQfbVvnw9Wlshftzzi43RUHXIuYYqmt+tDPcJZoWNofdZAsYj/7H0b6pgULZj5IFzQHpL+f9NBeZgmEgUDNtXBUc5nQe3w679Qk42ViZrAbnyaRFEsA0KEgoHOXQvLkq6LaZLE90MKrZO3GyT3aj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854344; c=relaxed/simple;
	bh=76J6QT2U4Zmwua/an3raaX8mcotyHLhKqUs+oat/mq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LlsQIMir6NtaTq7q4MwU+uAv4o7GQNDRDeW4xRK8eNtsPiBOnDvVIXlKvcjEK/rUq5KAq650y5hvhiLJvD4DqcM/I4Xzt7pMzpq7pqB/jN1b8Mjqhm1iEwJvN6iKB5gleV2iSXmrh0CZM9uqvtqqjnmEoRim5ZU2d70K8mV7DlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=Si/qmoK3; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="Si/qmoK3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1781854340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P8btzKAYhJAhJYikE3mPJqmB+d5uAE8KSa/GQhmRov4=;
	b=Si/qmoK32NyMKWaCjci5ghVgB63HcO437wtgIPL58uSFlwpHrM8Klj8mFj01jzcBsgrt6t
	CcQmzWuSr1LCOLCLBLkJSKp7QKW6zbNrYBRnjp2mjyIpVDp7vw3YePEqScdpjo/AxIKP/g
	czT0M1CVvNyfSi3mSJM//SUmDl7OgD1c+8tCokGvgNjWJgJ2rqLYUnZWPEi03PmBM9+lyJ
	/++jzAfo/zQj4Q3SptN5ILW0B4IrZiBCvS+vfL1c9kK0QyYQnKqZa/p6BzKpHkf0kIGANi
	35XRDqaQD0VUmx57NdrbouJwnXOHUOB0jkfkeCjuMQ14PFd9l+M/QJ99AwBocw==
From: Xingquan Liu <b1n@b1n.io>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Xingquan Liu <b1n@b1n.io>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] net/sched: dualpi2: fix GSO backlog accounting
Date: Fri, 19 Jun 2026 03:31:43 -0400
Message-ID: <20260619073211.637928-1-b1n@b1n.io>
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

Follow the same pattern used by tbf_segment() and taprio: count only
successfully queued segments, propagate the difference between the
original skb and those segments, and return NET_XMIT_SUCCESS whenever
at least one segment was queued.

Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
Cc: stable@vger.kernel.org
Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
v2:
- Change patch commit message.
- Add tdc test.

 net/sched/sch_dualpi2.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index d7c3254ef800..5434df6ca8ef 100644
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

base-commit: 96e7f9122aae0ed000ee321f324b812a447906d9
--
Xingquan Liu

