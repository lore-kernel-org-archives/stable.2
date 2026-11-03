Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714119;
	b=qnjYjQsKgjGq307EM80CUvyf43f5GgU71EX+vuJYcGHAERX0TQwfkFrqgELyGILlyJts
	 mfkPbHS/51kF9jflfb+4DjDFKC5Sz57hYfkKBaNcMOwBJy03Hof5UdNc4u1xv5OUy/k/8
	 VjptKGOk+blaW2Eauu5Ojok/6NODnELyCMMzwj54HAMT2GnNZWeP6/I2GSyBBjk6iTu1t
	 kDwaTYgqiELKzFx3WV/J+JqwsN2DnTfGXERx+HP/l+ZCvN4CGRqeyUo8gWZXnUXAlDGXS
	 D3ZP6uJ2byyi7VF8wxjMXmLVKhjZscdiCUSY1CX4GXb6UwiHt6M0uT4A8hzaGcm8RjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714119;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vzvDnS3m+RqAseH0EdxkMImjP6HGDJkXstyQ6Mu3TCM=;
	b=DeUOx3lnkWL08A+3sQVM26NLUbgINdWBPRfwCV5jDvNkg/B5iikoujqt7m5uzeXVjI2M
	 p8GM1MxoSu3xUyBUjy1UlIWlqtJFVnCSpi0ueGC6co+X9k0vCPsp5vgIDpY8yb9VeLPUZ
	 zJQ/aqbT0rThmxRuTC+79ntU5UBL5qfAzTzfHiygODxGtNZbs0QBtp51a9O7+HZxijUyq
	 bty2/kfqq8CD+Ew9ZAaUv3LLm/oXtlxqIQ0blY+XLzhfunFNCPwS+ipwx9K/fq6wdeZDR
	 uMs5bGTcnJDQVIDQH5WbeDbVjlwSyOPv09Ok/RLwHhghXZ5ZPIfWmYWn/8+o8hWbMzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdkYDYQo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C34606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kdkYDYQo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D151F000C1;
	Tue,  3 Nov 2026 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793714118;
	bh=vzvDnS3m+RqAseH0EdxkMImjP6HGDJkXstyQ6Mu3TCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kdkYDYQoky/F2GlV3euOe+G8fL5KCJF1U28tNxR8zAevLm31wIkua345CfKx2ulOY
	 GVfFGDWAsqJuC6NtiNXRAyjbArFvhRxUSKk55SGbDCcGXi7RO+FH8SuIRV75yscEO4
	 sRr/vQy46MYlVYmDmqov4EEWBN4KvDnugFx9lNlQXeVpufdJL5Uk+qnz1inKDBpoV7
	 4hVWXGK7Zj8Dk55ZGn52gbLwz7i4w99iq6yyQiqmlJ/V0xfghc5rPnAwPLZ1rM3pMC
	 mKpqLorrv9tnNKI04TS8f3X8yZydH034Jor+L9w8+RozXS60/ICcWW6YnccgH6IyZg
	 A9Ko8ACm27sWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net/sched: fix packet reordering on requeue
Date: Tue,  3 Nov 2026 08:55:17 -0500
Message-ID: <20261103135458.3968306-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110344-headcount-urgent-8af6@gregkh>
References: <2026110344-headcount-urgent-8af6@gregkh>
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

From: Antonio Quartulli <antonio@mandelbit.com>

[ Upstream commit 14368b9aa1017fee35d2589be7b17e0485c0f93e ]

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
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Link: https://patch.msgid.link/20261026153113.3275494-1-antonio@mandelbit.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Adjusted dev_requeue_skb() context to preserve the existing unlock-and-reschedule sequence. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_generic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 43ef80f11a9d7..af066995f811a 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -139,8 +139,11 @@ static inline void qdisc_enqueue_skb_bad_txq(struct Qdisc *q,
 
 static inline void dev_requeue_skb(struct sk_buff *skb, struct Qdisc *q)
 {
+	struct sk_buff_head requeue;
 	spinlock_t *lock = NULL;
 
+	__skb_queue_head_init(&requeue);
+
 	if (q->flags & TCQ_F_NOLOCK) {
 		lock = qdisc_lock(q);
 		spin_lock(lock);
@@ -149,7 +152,7 @@ static inline void dev_requeue_skb(struct sk_buff *skb, struct Qdisc *q)
 	while (skb) {
 		struct sk_buff *next = skb->next;
 
-		__skb_queue_tail(&q->gso_skb, skb);
+		__skb_queue_tail(&requeue, skb);
 
 		/* it's still part of the queue */
 		if (qdisc_is_percpu_stats(q)) {
@@ -164,6 +167,12 @@ static inline void dev_requeue_skb(struct sk_buff *skb, struct Qdisc *q)
 
 		skb = next;
 	}
+
+	/* the skbs may come from the head of gso_skb, so put them back there:
+	 * appending them would let the ones still parked overtake them
+	 */
+	skb_queue_splice(&requeue, &q->gso_skb);
+
 	if (lock)
 		spin_unlock(lock);
 	__netif_schedule(q);
-- 
2.53.0

