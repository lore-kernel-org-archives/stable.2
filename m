Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028697;
	b=sC09YL7YAZ0tBPZZ+Eqi40s4ZfNqb+g838A+TOb4ri9Dewz6BX21vxNbKH4DrclyX4Ik
	 SlqnxZgQ0tBllWENJZ7AiAKfyRO71MNzIrfJGZT+s3WQK6ohRLWsBN25QzDt/eZWlcCfL
	 KY1pk4efpqKi24wN5kNsGprWKzJo0VaxT1Na9eL0qaSHYL1v9y9pqX0SRmZ6tvzRALuPt
	 g3s/+fYlN7KaizziL8akRDw6VM5LisKT4D7H3HIMtQDUv2v30Nf7md4OYKo6MWawXYPMA
	 s45liu/qdBgfAZWXjcaZMnk3fyry7BTSv88p6LwozW97SUEgBHMOZJ9v3yT8r6rU2oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028697;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id;
	bh=pOB9T81mWY71KGKb0fMw7JUuanDsXrgOIuCV8Xs8wzg=;
	b=LM0tVezPrqtoyoPcfMlbDyAQ2oQV2pG5WKLZVPY9PmFUKVlWddyAynvkMkhOlvhC7t8t
	 xeTnOSfah6cnO7Wg2jjTxEQalHUMRZG5GmuCcchVM8/rQyLJegL4t35NFUEWwOd78UEhY
	 jnJSKJojA1lQU2jbrN8pgxIvPKAs/lD5XU6K4yA9ge7Fez4r1McevoNF1MBWjU9aChc7M
	 CUNvnutQvfhnjEqn1Y+/Bf70TcJWvlmEc7DOYSfLFMwXyXger14KaOiZnHPoe+T8dKmuU
	 zAkH57b5vwFW/DaoiZd09TQd+64dCFZUVS9L++4DuXNeVPzYrqWzvuPCHtnc9vFPFmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=I5FKtEew;
	arc=none smtp.remote-ip=195.10.208.40
Received: from mout-b-210.mailbox.org (mout-b-210.mailbox.org [195.10.208.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146E6606A31A;
	Mon, 26 Oct 2026 15:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 146E6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=I5FKtEew
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-210.mailbox.org (Postfix) with ESMTPS id 4jCyJz6LhBzFpnc;
	Mon, 26 Oct 2026 16:31:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1793028691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pOB9T81mWY71KGKb0fMw7JUuanDsXrgOIuCV8Xs8wzg=;
	b=I5FKtEewt+WJ/ysRkCdlDtlSj+UgAMbIUu6wtrpLoik6rhDnrQn1TFwCc0sRnHyAgZYXXM
	Lb0xBVChU/QtyQPrNpFjqSXj5B58++l2445nfU7YNgVOtuoo62r7lg5hK5YVnrdUJnhx37
	OV7ZiBosMjK3O2Ng3SzQFFUVGYphoTgeoQX/Yn2/cT3siuZ7fS3PwTOsC1m7hWwbGFA9uR
	aFApDDcv08L8lHddxA1gsS6buXtHJiG1HDyuZ5K++J7CLNKWQwiSh915f/6E1lSXyMu4DW
	C/04sbxTLIYIWxJ823SXi5kOyuMV23v3B2+HqzeZciz5B1Zm0ekMnMxv9hj2YQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=antonio@mandelbit.com
From: Antonio Quartulli <antonio@mandelbit.com>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: fix packet reordering on requeue
Date: Mon, 26 Oct 2026 16:31:12 +0100
Message-ID: <20261026153113.3275494-1-antonio@mandelbit.com>
X-Mailer: git-send-email 2.55.0
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
X-Rspamd-Queue-Id: 4jCyJz6LhBzFpnc

dev_requeue_skb() appends requeued skbs to the tail of q->gso_skb, while
dequeue_skb() takes them back one at a time from the head. If the driver
returns NETDEV_TX_BUSY again for the first of them, it moves behind the
skbs still parked there and is sent after them.

This showed up as heavy TCP reordering while benchmarking over veth,
which returns NETDEV_TX_BUSY whenever its ring is full since
commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops").

Requeue the skbs at the head of gso_skb, keeping their order. With 4 TCP
streams over a veth pair with a pfifo qdisc, this removes about 1.3M
out-of-order segments and 15-37k retransmits per 15 seconds, and raises
throughput from about 40 to 76 Gbit/s.

Fixes: a53851e2c321 ("net: sched: explicit locking in gso_cpu fallback")
Fixes: 9540d977618c ("net: sched: fix skb leak in dev_requeue_skb()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
---
Notes:

- Setup: 8-vCPU VM, veth pair; sender with a pfifo qdisc and TSO off,
  receiver with GRO and threaded NAPI; iperf3, 15 s runs.

- A single stream gets about 7% slower (87 -> 81 Gbit/s), with 0
  retransmits instead of 1-20k. This is not a cost of the change: without
  the losses TCP keeps the veth ring full, and veth_poll() waking the
  queue makes net_tx_action() run the transmit work on the receiver's
  NAPI CPU. With VETH_RING_SIZE raised to 4096 the ring doesn't fill,
  nothing is requeued and both kernels do 86-90 Gbit/s, while 4 streams
  still go from 45 to 70 Gbit/s.

- History: before a53851e2c321, gso_skb was a single pointer.
  dev_requeue_skb() stored the busy skb there with the rest of the list
  still chained through skb->next, and dequeue_skb() handed the whole
  chain back, so the order was kept. a53851e2c321 turned gso_skb into a
  queue that dequeue_skb() drains one skb at a time; requeuing queued
  only the first skb (at the head for locked qdiscs, at the tail for
  TCQ_F_NOLOCK ones) and lost the rest of the list. 9540d977618c fixed
  that leak by queueing every skb of the list, and moved the locked path
  to the tail too, "to avoid skb out of order". Appending keeps a
  requeued list in order while gso_skb is empty, but not when the
  requeued skb was just taken from the head of a non-empty gso_skb,
  which is the case fixed here. So locked qdiscs reorder since
  9540d977618c, TCQ_F_NOLOCK ones since a53851e2c321; both are in 4.16.

 net/sched/sch_generic.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6f6a6f0d5eb0..e79e9f33efba 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -168,8 +168,11 @@ static inline void qdisc_enqueue_skb_bad_txq(struct Qdisc *q,
 
 static inline void dev_requeue_skb(struct sk_buff *skb, struct Qdisc *q)
 {
+	struct sk_buff_head requeue;
 	spinlock_t *lock = NULL;
 
+	__skb_queue_head_init(&requeue);
+
 	if (q->flags & TCQ_F_NOLOCK) {
 		lock = qdisc_lock(q);
 		spin_lock(lock);
@@ -178,7 +181,7 @@ static inline void dev_requeue_skb(struct sk_buff *skb, struct Qdisc *q)
 	while (skb) {
 		struct sk_buff *next = skb->next;
 
-		__skb_queue_tail(&q->gso_skb, skb);
+		__skb_queue_tail(&requeue, skb);
 
 		/* it's still part of the queue */
 		if (qdisc_is_percpu_stats(q)) {
@@ -194,6 +197,11 @@ static inline void dev_requeue_skb(struct sk_buff *skb, struct Qdisc *q)
 		skb = next;
 	}
 
+	/* the skbs may come from the head of gso_skb, so put them back there:
+	 * appending them would let the ones still parked overtake them
+	 */
+	skb_queue_splice(&requeue, &q->gso_skb);
+
 	if (lock) {
 		spin_unlock(lock);
 		set_bit(__QDISC_STATE_MISSED, &q->state);
-- 
2.55.0

