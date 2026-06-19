Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE1620ED
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882151; cv=none; b=Di8YpWX0URmBVJfuDSEQaelvK7hyi/eKA2YePRs1TXDunGMP0cF6/BA3Hy3cq8363XU8/lkYrs+slM8VoOkACUtPc+C489n002EGdO+AsbWZNdaIoh8eMulLdunexEzElaT/3BqtXo97D21QHY+WxSPrkV6XT++qtBCp0m+iAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882151; c=relaxed/simple;
	bh=TGYgwiTJHtJNlt/17k021rosdmJg6Kpva8siZ53rSS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVCqDBPu+2qhc/z0vI4leVZ/hLuzLBV9t6HcVdwl22tplasYPdGAX/tf3Tycapt9+hL5fbc7bkaOQeG2CH5kZWa14JO7xrBrvTFlt8Uza6vE2erfV6Se4oELaKkgG1phgdoDDYETJOcrzgvWtBwgE+9Nv66ySCh8p1o+eh414gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=oWe0BT6L; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="oWe0BT6L"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1781882147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PwWF7KrEgnuENNQxPC3DbTo9dxOZ56k4AODfX6tSOv8=;
	b=oWe0BT6LKfEp3HNDr0a0+gAFN8hTy9XeiHfsSLQcUELBdMJtLwZ1bbGlpAOXTXWP3nbRto
	7AjIjNUL2WmS1waIXOxsteHZ7TfTGkTzx0hxauNasBgBpxj5ky98xsdyzw9+7t5Pwv+NXn
	1RMheBWDJPUgt079/n/tmvYRHjddADaovTeIJ+UJNB4F9Zx2OpfznshY5A96Gh47dvN2qb
	UbkBn2oO6rB1GZG9O30Ifv0nBWl61xmrWsq3LCHsOOmgdEZhNz+60V5nukgwYwFpkuv/8f
	YSegefPrS3hBjIj0NjfR5HhZhMd8+hNhHO3qKwXC2jX2OPevlDJCSIWRRlrZcg==
From: Xingquan Liu <b1n@b1n.io>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Xingquan Liu <b1n@b1n.io>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] net/sched: dualpi2: fix GSO backlog accounting
Date: Fri, 19 Jun 2026 11:13:47 -0400
Message-ID: <20260619151447.223640-1-b1n@b1n.io>
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
v3:
- Move the UDP GSO sender into tdc_gso.py.

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

