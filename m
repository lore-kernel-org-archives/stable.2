Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB283BD22F
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272180; cv=none; b=k4snZrQqJER1EWXHTQCUOLQY9UMtRzTobvabzD+mgecgjqFaNzu+26kCXcrj7aNTpObNEQg74nfV9bm2B8HiinGqVaX6Yij/Roz3BQZSxd/3QNoJo5c/9y1IFwCJjfGo58bAiNwsA5lB+YQkvhxreaVNvoUIGpkhH0ghD5Zmpjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272180; c=relaxed/simple;
	bh=+QwMA1sY8Uq1whUFEDmjRlq4Huc88/UCFWouSMyMobk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JBFM3WTIvgxrXlVhbK1lqnmPJ67HqrhT3QYLkCrhzYz5UQ7tjnExa/UmfVJM2d+3rc1CoC62r/pRcqKzHr4tDwir1KglmQ5L2sf7kpc+8jFbYqGkcIni8PZBs946tJuDYRxKWZY1cLujFOxjhg3ARcCN2KvTTUbXJx2aY8KMAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=KqdYQedz; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="KqdYQedz"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-9196d8543cbso21182846d6.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 00:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791272175; x=1791876975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vRQvGdgkDZAe0klSH7Hn68W19sGWIlPU9zaJ/Kc8q5c=;
        b=KqdYQedzkwzUN70pIYhu4ku/SHj2UXZr2n1n120DotLr/VgAOn3CQJzIGmczA7QaB3
         fYdR+rgCutTx29c0TmDygr4ekFaCOcb8S7BQt38CjZI9caRspiYf2zChHm6qtUjy+q77
         TsGrjR1Wf4/8h5OKoUM6quezjEjp3KPQkGDdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791272175; x=1791876975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vRQvGdgkDZAe0klSH7Hn68W19sGWIlPU9zaJ/Kc8q5c=;
        b=dF6LSmnduN+QdMhKpyZUkzniEn7jPR4oFtNhgJsenlxzl9BjDP11d+lRBkG/+G5OVe
         8SOe+Ffe0mJKvcfLyZjMh6/D0tOHrHMUQihKnmwm29vuGdKz6yC/d41lTUmqiqHXC8sG
         lUoyxOP4ETeDeQusE4fpc4tXorM8QFtkXHHyYEjwEQphVg2Hvlrjim6W+5FKcV0pmjfP
         ojPlNOogI5Ziefcp9tE2tCEGLrukkpcx+m1AAqypyIGAZxI039Bo5YXw7xtdqqk8Ptg/
         lhFAhLDfS0G/7pmYadmiHrBcCiaraaCDA2thX7M1HEcbE2EZnG8jXm4pcI3ifiwE7qMW
         7/0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwoERJmrSS2lC98kKlNOlhMulE58PPQysTimA9BfxGrghJbhjaypiSi51WhdaV1O/G+2sa88Tw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/3mn7X8VgSApYvwFDhITnBa01hXnu6V9MqeiIgWlC9cHyeTj1
	zjsQUjLXwbZdScJCVlcQDSZIguRlu+erxjL4J6P1Ioij3CcmkY0YRrzKvwuVHfw5OQ==
X-Gm-Gg: AYBFou1soTcsaFkLFEL5epZG2GLIPZAezmi09/+bJvElAwaISZRPCsFr9uJqZSEAxQu
	0nabX6eCdHxNRTOqljpTshbRyeiSia1izm2bR1W9CXXo71DSwUWXv1J9WLEybgtdevbGI/3amg4
	X5DDAhmDTGbksimwD1xrfMWqR6sy8EqHSTgTwMLupvhDmyvAX2/OzEco9DJC4dkjbh7T0/7jXGf
	+3K594/SlPzIOeyYuJ1kytO+s8xQhvYtTa/manadviOT+t/WkxWWFv4vIzMkI++UTlUhBTIjcol
	1m0xdvjic8JQd/H1MorPgJywWjJzkkG4DgDaw8OooZUogqjL2Mq9wNO/wSRSLuqSQF2l6TsBlsp
	JW30AWvH4mIGDRLeR4VFiLe9JtS+1ZK4rLMqdM8idMNh7CunQO00EfG8vO1YjC6ZvZQnP/+IKa1
	n8zi39hKSShn5sSQ0u2oB9m0DzW/P9SemugISUl41pxF1AL+6imtdq6+GLJW1yl9n4e1gw4OUe6
	VOC73VcgEMNjcjBMtdt/mviLH5qrv6aT0RyQ/CP4PufqKoLk6p7v/I4s0+C
X-Received: by 2002:a05:6214:4a08:b0:914:4464:41ac with SMTP id 6a1803df08f44-9198b4fe989mr10514606d6.2.1791272175137;
        Tue, 06 Oct 2026 00:36:15 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917d5939b0dsm107135446d6.7.2026.10.06.00.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 00:36:14 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sashiko <sashiko-bot@kernel.org>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: clamp skb->queue_mapping before indexing the tx queue
Date: Tue,  6 Oct 2026 03:36:11 -0400
Message-Id: <QDISC-MD1X.v1.20261005193231@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This issue was caught by Sashiko (nipa).
A producer-side path cap is already merged (ea4d4b5dddb5); this
patch adds the matching consumer-side cap.

The tx queue is picked and capped in netdev_core_pick_tx(), before
__dev_xmit_skb() qdisc egress path. A tc BPF program running inside
egress qdisc (not clsact) can then change __sk_buff->queue_mapping;
that update is never re-checked. bpf_convert_ctx_access() bounds it
only by NO_QUEUE_MAPPING, not by the device's queue count.

On dequeue, qdisc_restart() we end up in netdev_get_tx_queue() which
indexes dev->_tx[] with that value. netdev_get_tx_queue() guards it with
just a DEBUG_NET_WARN_ON_ONCE, so sch_direct_xmit() takes the out-of-bounds
txq->_xmit_lock and writes txq->xmit_lock_owner past the end of the
allocation on non-lltx devices such as ifb. Drivers that index their rings
from skb_get_queue_mapping() (ex: ifb) go out of range the same way.

Cap the mapping at the consumer and write the capped value back, so both
the qdisc's _tx[] lookup and any later driver read stay in range. The cap
folds into the dequeue path instead of a separate walk over the returned
list: dequeue_skb() caps the head, and each bulk helper caps the element it
appends. netdev_cap_txqueue() already logs a ratelimited notice and selects
queue 0. The single-packet case pays one extra compare against
real_num_tx_queues.

To recreate the bug: load a SCHED_CLS or SCHED_ACT program that stores
__sk_buff->queue_mapping (a tc BPF action is enough), attach it to a
transmit qdisc (for example a matchall filter on a prio root), and send a
packet. With a 1-queue device a store of 1 indexes one past dev->_tx[].
Under KASAN with panic_on_warn=1 the unfixed kernel faults with
"BUG: KASAN: slab-out-of-bounds in sch_direct_xmit". Loading the program
needs CAP_BPF/CAP_SYS_ADMIN, so the trigger is root.

Fixes: 74e31ca850c1 ("bpf: add skb->queue_mapping write access from tc clsact")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/179033713973.2160803.4914570693994398206@kernel.org/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-9R8V.v2.20260924072708%40mojatatu.com
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_generic.c | 45 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6f6a6f0d5eb0..e3e76e794aae 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -96,9 +96,33 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q,

 #define SKB_XOFF_MAGIC ((struct sk_buff *)1UL)

+/* A tc BPF program attached to a transmit qdisc runs inside q->enqueue(),
+ * after the tx queue has been picked and capped, so its store to
+ * __sk_buff->queue_mapping is not re-capped. Bound it against the device at
+ * the consumer and write the capped value back, so a driver that re-reads
+ * skb_get_queue_mapping() in ndo_start_xmit() also indexes in range.
+ */
+static u16 qdisc_cap_skb_tx_queue(struct net_device *dev, struct sk_buff *skb)
+{
+	u16 queue = skb_get_queue_mapping(skb);
+	u16 capped;
+
+	capped = netdev_cap_txqueue(dev, queue);
+	if (unlikely(capped != queue))
+		skb_set_queue_mapping(skb, capped);
+
+	return capped;
+}
+
+static struct netdev_queue *skb_cap_tx_queue(struct net_device *dev,
+					     struct sk_buff *skb)
+{
+	return netdev_get_tx_queue(dev, qdisc_cap_skb_tx_queue(dev, skb));
+}
+
 static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
 {
-	const struct netdev_queue *txq = q->dev_queue;
+	const struct netdev_queue *txq;
 	spinlock_t *lock = NULL;
 	struct sk_buff *skb;

@@ -110,7 +134,7 @@ static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
 	skb = skb_peek(&q->skb_bad_txq);
 	if (skb) {
 		/* check the reason of requeuing without tx lock first */
-		txq = skb_get_tx_queue(txq->dev, skb);
+		txq = skb_cap_tx_queue(qdisc_dev(q), skb);
 		if (!netif_xmit_frozen_or_stopped(txq)) {
 			skb = __skb_dequeue(&q->skb_bad_txq);
 			if (qdisc_is_percpu_stats(q)) {
@@ -208,6 +232,7 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
 				 int *packets, int budget)
 {
 	int bytelimit = qdisc_avail_bulklimit(txq) - skb->len;
+	struct net_device *dev = qdisc_dev(q);
 	int cnt = 0;

 	while (bytelimit > 0) {
@@ -216,6 +241,10 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
 		if (!nskb)
 			break;

+		/* A tc BPF store may have poisoned the mapping after pick;
+		 * cap every element before it reaches the driver.
+		 */
+		qdisc_cap_skb_tx_queue(dev, nskb);
 		bytelimit -= nskb->len; /* covers GSO len */
 		skb->next = nskb;
 		skb = nskb;
@@ -233,7 +262,7 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
 				      struct sk_buff *skb,
 				      int *packets)
 {
-	int mapping = skb_get_queue_mapping(skb);
+	struct net_device *dev = qdisc_dev(q);
 	struct sk_buff *nskb;
 	int cnt = 0;

@@ -241,7 +270,11 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
 		nskb = q->dequeue(q);
 		if (!nskb)
 			break;
-		if (unlikely(skb_get_queue_mapping(nskb) != mapping)) {
+		/* cap every element; the head was already capped, so a
+		 * poisoned follower now compares equal to a poisoned head
+		 */
+		if (unlikely(qdisc_cap_skb_tx_queue(dev, nskb) !=
+			     skb_get_queue_mapping(skb))) {
 			qdisc_enqueue_skb_bad_txq(q, nskb);
 			break;
 		}
@@ -286,7 +319,7 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
 		if (xfrm_offload(skb))
 			*validate = true;
 		/* check the reason of requeuing without tx lock first */
-		txq = skb_get_tx_queue(txq->dev, skb);
+		txq = skb_cap_tx_queue(qdisc_dev(q), skb);
 		if (!netif_xmit_frozen_or_stopped(txq)) {
 			skb = __skb_dequeue(&q->gso_skb);
 			if (qdisc_is_percpu_stats(q)) {
@@ -322,6 +355,8 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
 	skb = q->dequeue(q);
 	if (skb) {
 bulk:
+		/* cap the head; the bulk helpers cap every appended element */
+		qdisc_cap_skb_tx_queue(qdisc_dev(q), skb);
 		if (qdisc_may_bulk(q))
 			try_bulk_dequeue_skb(q, skb, txq, packets, budget);
 		else
--
2.43.0
