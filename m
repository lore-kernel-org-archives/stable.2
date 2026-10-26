Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027748;
	b=2FxLcl3FWefbiAgmjn42uuA9lAn7j8wgtPOsDqx39lRhIEMMQBzEEzsO8A0GTv0aHoNx
	 h1Mq5o210fkth+PlhLF3+NENNYq3g0yUPGEfC1OID5hY861d8lxa+r3BS8mfdCO06FbVP
	 NqxjcdWney4TPOVzq59+DhVs/FHgvPAiEfQ2tsHBANA+4xNci/AaIfPld8jxKYecvSbWx
	 oY3FM24qTe6Ui6xvip/JTxFhj4ZbSCAWbMNvZrbsVvTCRFX30Sj5q2+KC0kuV7N1YoaVZ
	 lzUqJNOpukVH+Z+Csl3gr4cAX7ZLVG2goA0vILZPY+RhcmMcNKs+wlJae6dGzQ1gxVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mvj9fHn16t2M1QauOafuhsNe9KnZbuSZNw4c8kirWMA=;
	b=BSQuiFCzsblKqhwfollvVpGURMOQYdOfo1PKiUeexq/nKfsVO3PAd1xGPHFujEyX3uxj
	 lgOOvCOFS9VdhGtjUoFqiA/c/LjLJM8cyHU9LyzSn2Mw4QlJoS9NGiR3qb1oldptpM3Hr
	 YqpSKV4QH7oNdRQZXtxy3CFN9tdw0kubKPWQwh28igxslr/fkJy5f3UnAiM4/I45uCbgD
	 +AmC1n+FF4A2yixOVDLsctfvmKytwk5wsXvcrcWgYYkde78IkqFNMgODTwEMQHLo+v9Ik
	 CDRDbwMgzRTERRq0IHc06ehqI02uxxk7odlJX9x+IS//Pm+k+ZAapa8aw/xo1D1aNCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=pfaikxL5;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF48606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BF48606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=pfaikxL5
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c2fc03880so41683106d6.1
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793027747; x=1793632547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mvj9fHn16t2M1QauOafuhsNe9KnZbuSZNw4c8kirWMA=;
        b=pfaikxL5vjv2lDFdi022jDdLm8NmxSIg9DfGChk0lQdHYjFqNfhm96zygJjIL5Kdi5
         /jTSB472LmsKW+H9CcIoJ0rxGsibYhINFSHt34AN4SyNveE3qptCxO8igY6FYJDSj0Ve
         wqvhFgNrjfHrDNckeLJsqcolwCF5cZEO4q/xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793027747; x=1793632547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mvj9fHn16t2M1QauOafuhsNe9KnZbuSZNw4c8kirWMA=;
        b=FT0aG1YdVwmmh3+S2DfV2raMeBe+ZZ1pSjNDkay3iEG55+YYaKa37ss2rTjLQwIYC9
         eQSODHQDDRwXvUV7vPkZ8QPiUUPdhht2oJNkvmwuil6YC6BYyZF2nFwcixXYvGiL09Td
         XpST40qdNYEGFy24lzA1gBlzI2rS+vMKy1XC5AQ1bU8iOiTvsLaBZzHO03SLRmkfm9Pm
         veSZb8U/ykYJQlf/p5O4CBHVJ1i07/R6GFOumiAplRDqYxHacd1qBni2PTzqTDrJgMwe
         zkPez74HGeRnoeQOYsaPif2h7ICU3agvLkTiX/xYifZWTadraggsPvu13batKZedAZAB
         AlbQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXTup0JhRl6z0OHiSiOSdQ7BVnqA6XPtpaTm69bWmUCUl7CMFIzNBgcbYaJKh1736VEm3/a2s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIS9px780OUMqJxGNBWuqTFl2zQajAlaLQ4l5KaETtWcGrLTBJY
	a3kdWEIy6IPsVdxzKWsX234ew4Jl2X3t8zLpDlLIciiXOtPWREd78Yf0NfI04jCxbA==
X-Gm-Gg: AYBFou2jycmHCK+3DiYMY1VfN1uYZfcUyjJFtEHUjDolBEiZlG0cJPPLcsNI91cubC0
	LsnRb5f6mEeLGcuvyXKGt1zV6QNmHZQ/EhrmcnhvXftEYNr01Nb0Pa1pz7VnaHZFPvDLT4E3KAf
	wC28s3lK1pJ3Zmc1FQCAq9DngNZwgMzCGwerDIYaw+3T3QzKsAkuLSfAbL5+FPZu/7RXJVh6Srs
	n6IwnwxjJ+WzzetMw25Zr9KMeMaaMF1ceXqoxQCCXvlNzR9f/Q8BqsCSyUm9Ay2wEx5RLHXrBff
	dTCod43ISItkQfoK6lu0oED7J2NUqIkomlThiK4WVW8PmgkkVCh66g7cIFichx2fzIwUneVNqgU
	iNzIuzddAMXgtUtnX2pmGPz7pSjiXV8AtU64Grh0DzhUNVnlmxF0gpRNdRMgKs6EtxqPwcIxOi8
	Omg6xUzBNzMz3LmnNxSiSe4E/OnBxFv+lv9kTAIEjSO7vBQuc6NmEMImoDNvINBwIWGvBQZxG0d
	4ZEG91s4okJ3K5FQsMOFVxdlQE6zzy/jeiInon0FyiN0BUgOB1w8PrOMmIjTaM4LcTunS5j8fdL
	XAtXnaPn4t+QGs1/vW8srebV+7PSRbj9xa7+iSAIRg==
X-Received: by 2002:a05:620a:450c:b0:93e:4c1b:a084 with SMTP id af79cd13be357-940efaacc56mr985762685a.7.1793027746468;
        Mon, 26 Oct 2026 08:15:46 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f067e3f0sm712706685a.22.2026.10.26.08.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:15:45 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sashiko <sashiko-bot@kernel.org>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v5] net/sched: clamp skb->queue_mapping before indexing the tx queue
Date: Mon, 26 Oct 2026 11:15:41 -0400
Message-Id: <QDISC-MD1X.v5.r0.20261026053226-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

This issue was caught by Sashiko (nipa). A producer-side path cap is
already merged (ea4d4b5dddb5); this patch adds the matching consumer-side
caps.

The issue:
The tx queue is picked and capped in netdev_core_pick_tx() before the
__dev_xmit_skb() qdisc enqueue path. A tc BPF program running inside an
egress qdisc (not clsact) can then change __sk_buff->queue_mapping; that
store is never re-checked. bpf_convert_ctx_access() bounds it only by
NO_QUEUE_MAPPING, not by the device's queue count.

Two consumers read the stale value:

  - On dequeue, qdisc_restart() calls netdev_get_tx_queue(), which
    indexes dev->_tx[]. netdev_get_tx_queue() guards it with just a
    DEBUG_NET_WARN_ON_ONCE, so sch_direct_xmit() takes the out-of-bounds
    txq->_xmit_lock and writes txq->xmit_lock_owner past the end of the
    allocation on non-lltx devices such as ifb. Drivers that index their
    rings from skb_get_queue_mapping() (ex: ifb) go out of range the same
    way.

  - On enqueue, taprio_enqueue() indexes q->qdiscs[] with the same value;
    the array is sized dev->num_tx_queues. A duplicating netem on a child
    qdisc clones the skb and re-enqueues the clone at the taprio root
    (qdisc_root_bh()) through a direct rootq->enqueue() call, so the value
    reaches taprio_enqueue() before any dequeue cap runs.

The Fix:
Cap the mapping at the consumers and write the capped value back, so the
qdisc's _tx[] lookup, the taprio q->qdiscs[] lookup and any later driver
read stay in range.

On the dequeue side the cap folds into the dequeue path instead of a
separate walk over the returned list: dequeue_skb() caps the head, and
each bulk helper caps the element it appends. netdev_cap_txqueue() already
logs a ratelimited notice and selects queue 0.

A TCQ_F_ONETXQUEUE qdisc is bound to a single tx queue: dequeue_skb() uses
q->dev_queue for the frozen check, the BQL limit and the trace point, while
qdisc_restart() transmits on the skb's queue. Capping an out-of-range
mapping to queue 0 would therefore send a per-queue child's skb through a
different queue than the one it was dequeued for. On mq, mqprio, taprio and
htb offload children, a stopped queue 0 could then park the list in
q->gso_skb, and the later wake would schedule queue 0's own child instead
of this qdisc. Pin a TCQ_F_ONETXQUEUE mapping to the qdisc's own queue to
keep the documented invariant.

That also keeps a bulk list on one queue by construction: every element of
a TCQ_F_ONETXQUEUE qdisc, including a follower changed by a filter, is
pinned to q->dev_queue before it is appended. The fast bulk helper
therefore needs no head comparison and no skb_bad_txq requeue; the slow
helper, used only by non-ONETXQUEUE qdiscs, still compares and requeues a
mismatched follower, where a wake on any queue reschedules q.

On the enqueue side taprio_enqueue() caps the mapping against
real_num_tx_queues and writes it back before selecting q->qdiscs[queue], so
a duplicating child cannot steer the clone out of the array.

Conditions to recreate the bug:
The dequeue path: load a SCHED_CLS or SCHED_ACT program that stores
__sk_buff->queue_mapping (a tc BPF action is enough), attach it to a
transmit qdisc (for example a matchall filter on a prio root), and send a
packet. With a 1-queue device a store of 1 indexes one past dev->_tx[].
Under KASAN with panic_on_warn=1 the unfixed kernel faults with "BUG:
KASAN: slab-out-of-bounds in sch_direct_xmit". Loading the program needs
CAP_BPF/CAP_SYS_ADMIN, so the trigger is root.

The enqueue path: on a multi-queue device, install a software taprio root,
graft a prio child with a duplicating netem on every class, and store an
out-of-range queue_mapping from a matchall+bpf filter on the prio. The
duplicate is re-enqueued at the taprio root and indexes q->qdiscs[] past
dev->num_tx_queues; the unfixed kernel faults in taprio_enqueue_one().
Same CAP_BPF/CAP_SYS_ADMIN requirement.

Fixes: 74e31ca850c1 ("bpf: add skb->queue_mapping write access from tc clsact")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/179033713973.2160803.4914570693994398206@kernel.org/
Link: https://lore.kernel.org/netdev/179293123940.3134.1149128679923234677@kernel.org/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v4.r0.20261021042722-1%40mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v3.r0.20261015165943-1%40mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1.20261005193231%40mojatatu.com
Link: https://lore.kernel.org/netdev/20261015125822.GH83879@horms.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v4 -> v5:
- Fold in the enqueue-side consumer: taprio_enqueue() indexes q->qdiscs[]
  with skb_get_queue_mapping(), and a duplicating netem re-enqueues the
  clone at the taprio root before any dequeue cap can run. Cap the mapping
  against real_num_tx_queues before the lookup. Reported by Sashiko (nipa).
- Call out the TCQ_F_ONETXQUEUE steering change for stable users: an
  in-range mapping set by a filter on a per-queue child is pinned to the
  child's own queue, restoring the documented invariant. Reported by
  Sashiko (nipa).

v3 -> v4:
- Cap a TCQ_F_ONETXQUEUE mapping to the qdisc's own tx queue instead of
  queue 0, so a per-queue child of mq, mqprio, taprio or htb offload keeps
  the documented invariant between q->dev_queue and the transmitted queue.
  Reported by Sashiko (nipa).
- With every element pinned to q->dev_queue, the fast bulk helper no longer
  needs a head comparison or a skb_bad_txq requeue; a mismatched follower
  there could otherwise be stranded behind a stopped queue that cannot
  reschedule this qdisc. Reported by Sashiko (nipa).

v2 -> v3:
- Considered Comments from Simon Horman (hunk counts did not match the
  diff content; patch did not apply):
  https://lore.kernel.org/netdev/20261015125822.GH83879@horms.kernel.org/

v1 -> v2:
- try_bulk_dequeue_skb(): the fast bulk helper (TCQ_F_ONETXQUEUE) capped
  each follower but appended it without comparing it against the head, so
  a mismatched follower was still sent under the head's txq lock. Compare
  the capped follower with the head and requeue a mismatch to skb_bad_txq,
  matching try_bulk_dequeue_skb_slow(). Reported by Sashiko (nipa).
---
 net/sched/sch_generic.c | 41 ++++++++++++++++++++++++++++++++++++-----
 net/sched/sch_taprio.c  |  5 +++++
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6f6a6f0d5eb0..5dc1d47f811a 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -96,9 +96,34 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q,
 
 #define SKB_XOFF_MAGIC ((struct sk_buff *)1UL)
 
+/* Re-cap a stale queue_mapping; an ONETXQUEUE qdisc pins q->dev_queue. */
+static u16 qdisc_cap_skb_tx_queue(struct Qdisc *q, struct sk_buff *skb)
+{
+	u16 queue = skb_get_queue_mapping(skb);
+	struct net_device *dev = qdisc_dev(q);
+	u16 capped;
+
+	if (q->flags & TCQ_F_ONETXQUEUE)
+		capped = q->dev_queue - netdev_get_tx_queue(dev, 0);
+	else
+		capped = netdev_cap_txqueue(dev, queue);
+
+	if (unlikely(capped != queue))
+		skb_set_queue_mapping(skb, capped);
+
+	return capped;
+}
+
+static struct netdev_queue *skb_cap_tx_queue(struct Qdisc *q,
+					     struct sk_buff *skb)
+{
+	return netdev_get_tx_queue(qdisc_dev(q),
+				   qdisc_cap_skb_tx_queue(q, skb));
+}
+
 static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
 {
-	const struct netdev_queue *txq = q->dev_queue;
+	const struct netdev_queue *txq;
 	spinlock_t *lock = NULL;
 	struct sk_buff *skb;
 
@@ -110,7 +135,8 @@ static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
 	skb = skb_peek(&q->skb_bad_txq);
 	if (skb) {
 		/* check the reason of requeuing without tx lock first */
-		txq = skb_get_tx_queue(txq->dev, skb);
+		/* re-cap: real_num_tx_queues may have shrunk */
+		txq = skb_cap_tx_queue(q, skb);
 		if (!netif_xmit_frozen_or_stopped(txq)) {
 			skb = __skb_dequeue(&q->skb_bad_txq);
 			if (qdisc_is_percpu_stats(q)) {
@@ -216,6 +242,8 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
 		if (!nskb)
 			break;
 
+		/* Every element of an ONETXQUEUE qdisc is pinned to q->dev_queue. */
+		qdisc_cap_skb_tx_queue(q, nskb);
 		bytelimit -= nskb->len; /* covers GSO len */
 		skb->next = nskb;
 		skb = nskb;
@@ -233,7 +261,6 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
 				      struct sk_buff *skb,
 				      int *packets)
 {
-	int mapping = skb_get_queue_mapping(skb);
 	struct sk_buff *nskb;
 	int cnt = 0;
 
@@ -241,7 +268,9 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
 		nskb = q->dequeue(q);
 		if (!nskb)
 			break;
-		if (unlikely(skb_get_queue_mapping(nskb) != mapping)) {
+		/* A tc BPF store may have changed the mapping; cap it. */
+		if (unlikely(qdisc_cap_skb_tx_queue(q, nskb) !=
+			     skb_get_queue_mapping(skb))) {
 			qdisc_enqueue_skb_bad_txq(q, nskb);
 			break;
 		}
@@ -286,7 +315,7 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
 		if (xfrm_offload(skb))
 			*validate = true;
 		/* check the reason of requeuing without tx lock first */
-		txq = skb_get_tx_queue(txq->dev, skb);
+		txq = skb_cap_tx_queue(q, skb);
 		if (!netif_xmit_frozen_or_stopped(txq)) {
 			skb = __skb_dequeue(&q->gso_skb);
 			if (qdisc_is_percpu_stats(q)) {
@@ -322,6 +351,8 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
 	skb = q->dequeue(q);
 	if (skb) {
 bulk:
+		/* cap the head; the bulk helpers cap every appended element */
+		qdisc_cap_skb_tx_queue(q, skb);
 		if (qdisc_may_bulk(q))
 			try_bulk_dequeue_skb(q, skb, txq, packets, budget);
 		else
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 39ac5b97aa3a..0eb0803047a1 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -632,6 +632,11 @@ static int taprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	int queue;
 
 	queue = skb_get_queue_mapping(skb);
+	if (unlikely(queue >= qdisc_dev(sch)->real_num_tx_queues)) {
+		/* A tc BPF program may have stored an out-of-range mapping. */
+		queue = netdev_cap_txqueue(qdisc_dev(sch), queue);
+		skb_set_queue_mapping(skb, queue);
+	}
 
 	child = q->qdiscs[queue];
 	if (unlikely(child == &noop_qdisc))
-- 
2.43.0

