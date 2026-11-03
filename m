Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700646;
	b=bfE0EyqCjS0mlZD9kNdgeTDxnjenbaoblxJgm3pb/Rvr9+iyO5EIhil/q1wwckokeIjK
	 0BAgWpkuoS9W17InXD76/1gL32/0xu7OQ52Y9FQ4PkU+gHN/HmaWjLiJQpRSKq2eyv0lP
	 4kiirm+a6zm3yQTs/cTG4a3zqnwxsCIDzn07kE9s9nPrzlhFe7rAzL8RcJ5yJPgweHkm+
	 zvF4ebG0nZNvhqPqU/xLcyxQN6EdNo7fWkxg+ycm6hwmms9eh9oaGfAZu2kQUUUd/V+6W
	 yf1ihAgpleMaLnkS7QEKghhX3rBqmoyjsMrVfJzQJnsOK2ApzvyoGluv529G6MH+feg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700646;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZacAEQsKRdTBk6pqu59uPdfr8wGt5ZqSWYx1IZFANNU=;
	b=S1+ZCjFuGHwyiw9HbBL3saMlwhVWXu4hTAbpICgrVx7iqsEUa607p06C6LNVfA/4Vuje
	 q4VQrRT4Y551beHp7R3WS9v7YOsotcwH0r0KyyAUSzjd9VDnYtv3G01+Jj7ZK3Kx9AJaC
	 6Oc3RekXHNfiFq1XUYbIK0uSpxeOHOqsO79g6D9k7sY8dZ2BqFSrtreprepBsn8PGi8MI
	 LOWMdtvVvjQmKx8Ym10cDJV8oXdj9Y/fpvfZ2PCzxZ22Wm89QY11mAe8J2HroYTMqbZbW
	 BwT1ZndyNI7nyeGECnTCKVuWwdc/sN743BoHsaaUo3tOUvxxrWf3C63XD0LJyBWPWhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jye7OuDL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4D60A3823
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=jye7OuDL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFD81F000C1;
	Tue,  3 Nov 2026 10:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700645;
	bh=ZacAEQsKRdTBk6pqu59uPdfr8wGt5ZqSWYx1IZFANNU=;
	h=Subject:To:Cc:From:Date;
	b=jye7OuDLEUwp6O4hPVEekhq1WTPaDkPWzJFRTcXKOs5urxvISnU96tN/ddn5XuQQH
	 jSu3KOD5C6aUOkyEhnNlzCsymslpT/yr5HlzOnwOCt2knwCgDwyr+gdZmxxdpIioEK
	 /NWYMa4mpG1IzQ4yIp2Nh2V9AxrGrFjwO74B2b5A=
Subject: FAILED: patch "[PATCH] net/sched: fix packet reordering on requeue" failed to apply to 5.10-stable tree
To: antonio@mandelbit.com,edumazet@kernel.org,hawk@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:10:44 +0100
Message-ID: <2026110344-headcount-urgent-8af6@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 14368b9aa1017fee35d2589be7b17e0485c0f93e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110344-headcount-urgent-8af6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 14368b9aa1017fee35d2589be7b17e0485c0f93e Mon Sep 17 00:00:00 2001
From: Antonio Quartulli <antonio@mandelbit.com>
Date: Mon, 26 Oct 2026 16:31:12 +0100
Subject: [PATCH] net/sched: fix packet reordering on requeue

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

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index bff425a14526..3e8ee4a691c3 100644
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

