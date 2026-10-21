Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584235;
	b=T5rgV3QlKWcsA3As0cAwrBzSBAg/sXQuBOER/45ZxbjcYqAWT0mL6gsu36W1pxzuIGOA
	 FjkR3ygkpBeUZFOMj0hk2zRuLXgIkd26H05btx7TnbdPFKrc86bk7SsWpsoNS+xdOwhbP
	 mRVzrnHXWFlNNrhGy3JP/mjx2iyIf1JoyiCw1hC05Hm3UEmbzJIdfELwRrFgPtut8CZ4X
	 CPzgqeIGO/baKEDC+uVl/QEFtq1i/WDTa0kplekHyjjVRPlK/ZAEbdEKGAlEjQrb3hIvw
	 DVAGoUV1E16EDtEIXkbQypblhWtlsg1IoUbxAem8A0EB80BhthRHKzIoDHOOKWat2lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GK+opxzbNDvYLIX7cW8mwNi+aajSyz2/r7yxGFUzHOQ=;
	b=aZETI1OtRsQyLQoDoqaf0Sr18M1wwZLgSEAIx+XOBYHizuDESzsemA5ZOV0avWeKv9AR
	 aSDGNYbfH7jDJpF8G/7Nal4fDV7Nt3hbA0JsfrkuvBH57d48+LsiUW1p8JySnNqU/NtSE
	 EDjNtVRgVUs4gwsG9MMm49G5UmmBZnFQkdpCb7Nfem2PEUg1ToSlpNWDZtaxBlK77tQO9
	 qC9VNAdTbeNsH2WMtzzq8cFk+z6Q+Oa2F6M3MRbw0JlR+KUKRiZPQu54z+OKI0bwWaZBO
	 faylx2n6rubOOK0gHqhVrGxnu9AGSk1t9Chuledsn7Co9/Csk0XCZ1wfqyn+xQwOmXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="qkt54zB/";
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95355606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95355606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=qkt54zB/
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f20b304c0so73133785a.3
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 05:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792584233; x=1793189033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GK+opxzbNDvYLIX7cW8mwNi+aajSyz2/r7yxGFUzHOQ=;
        b=qkt54zB/ZzmRP4fJf97FZlKX2wQLBkLCPEMZ359Sr9wPvelXCDeL8i80gwAR0pbRqB
         aooSSf91ZT+JaIo0aFgdy4Td01UTFsHVhN+bvnFxydhjX6XUi7iWpxff9PX2R6KUgNeZ
         5fFJjgk55TSAJjP9+a4A14OtHIgbVN2SRpXw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792584233; x=1793189033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GK+opxzbNDvYLIX7cW8mwNi+aajSyz2/r7yxGFUzHOQ=;
        b=YCu3f2dtaIzQpDRnQhts/3WZOnjD9wXLu53w39ZOm5z2YvG22j95bdewdwVe7ByBgN
         XrynTS6+0NJTJUom5Wus2+tdHrrj+0SMyJ6O1GftZ2axzBCXhP2QynsodFaJd5znmB30
         MdKpecXaEzMyFmtAfaInaKGScJa+WKQH2RaiaJw4hhsgT4GvtzmRVNo5exSlnp1LWSZW
         BYJY9og48ULSVSNquoamcjPfoz/UnJLwYrozl46rJkRYmC+r1XbZ6Visc1gu2B+wE1TW
         zlrr+7zrL0Il/UnLFbMdlQkE64R0GwEMlAsGQ4xuTmXHjpX6YASxYYTVpmt38NKeaVuz
         ECCA==
X-Forwarded-Encrypted: i=1; AKwUvBxHEejAlMUs1ka/O+wuMH17AdZ7PpAK0puv0ciQIOH1t5LZnPVu8M7QYSh4U57QBmQABPDxhbg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDU269hrvif5cAumAhPqlAtdOqoPr9D5vE1TI+X4/7YqaH7rSk
	ko2p1jlpiN6OsdLCmnCkyKHDU5dX8IUdqjf/x7aMSv3kGJKaOXjZvrns2jzK8+94GQ==
X-Gm-Gg: AYBFou15Y+po4s1VuRlQFBTyKH2FuWTdH51wOhxEKVTzKTHwuYQkG2FJFrqQCHgCtT+
	Dp0jaJ+7giOtU2NVCYL7Sh+0PW01RZr8zmu16Pwcws72AZ64wI/43heHgTtghCVkUeGlhXCkKkZ
	N5y+7dc5q60daY1AXmb7G9jKljlaXszDh7T1Vz5rdsgczhnqtdBymdI3s34xWIIJJdyWYok+Ih2
	alSQdO583gdPVgfkZOpaH2qG+mIvXpC5DO7fKAJ8m8ZnpnIK1gmRPffmJF177Wri9kEejUf2up7
	J6VZHB5oQD2Tmq3ZdLfVilD32TgiCIaRNlJfCKn5Nou3p0R8krOcrUtR+qoLVDG2YL11m62pAOv
	ib6b4JiR0IPsgrVhPNVPjvkX8YtNSVJExmywhsXIu4P5HuSuLgw+gQ+ydZfePL0yQnzwvwHipwZ
	9Q25wxgyygfi2NZ1DIPRybN6NsmVQKGae7V5A2h6A2zKz5H6eTRAYiIb2JeMQGKdUSp9uPepYmp
	XKS0fPb6rzOXRqVp8etgdywfDnV10v140nUIgj0mDIS8cQI8dBrFm1OdtW1yk8hvghsGDReIpf2
	S/kQd0ds39raH/Sp9AmstLQrEQ==
X-Received: by 2002:a05:620a:2781:b0:93e:8614:bbe7 with SMTP id af79cd13be357-93f57e45a64mr358244985a.12.1792584233263;
        Wed, 21 Oct 2026 05:03:53 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56e2bee2sm232953185a.42.2026.10.21.05.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:03:52 -0700 (PDT)
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
Subject: [PATCH net v4] net/sched: clamp skb->queue_mapping before indexing the tx queue
Date: Wed, 21 Oct 2026 08:03:48 -0400
Message-Id: <QDISC-MD1X.v4.r0.20261021042722-1@mojatatu.com>
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
cap.

The issue:
The tx queue is picked and capped in netdev_core_pick_tx(), before the
__dev_xmit_skb() qdisc enqueue path. A tc BPF program running inside
egress qdisc (not clsact) can then change __sk_buff->queue_mapping;
that store is never re-checked. bpf_convert_ctx_access() bounds it only
by NO_QUEUE_MAPPING, not by the device's queue count.

On dequeue, qdisc_restart() calls netdev_get_tx_queue(), which
indexes dev->_tx[] with that value. netdev_get_tx_queue() guards it with
just a DEBUG_NET_WARN_ON_ONCE, so sch_direct_xmit() takes the out-of-bounds
txq->_xmit_lock and writes txq->xmit_lock_owner past the end of the
allocation on non-lltx devices such as ifb. Drivers that index their rings
from skb_get_queue_mapping() (ex: ifb) go out of range the same way.

The Fix:
Cap the mapping at the consumer and write the capped value back, so both
the qdisc's _tx[] lookup and any later driver read stay in range. The cap
folds into the dequeue path instead of a separate walk over the returned
list: dequeue_skb() caps the head, and each bulk helper caps the element it
appends. netdev_cap_txqueue() already logs a ratelimited notice and selects
queue 0.

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

Conditions to recreate the bug:
Load a SCHED_CLS or SCHED_ACT program that stores __sk_buff->queue_mapping
(a tc BPF action is enough), attach it to a transmit qdisc (for example a
matchall filter on a prio root), and send a packet. With a 1-queue device a
store of 1 indexes one past dev->_tx[]. Under KASAN with panic_on_warn=1
the unfixed kernel faults with "BUG: KASAN: slab-out-of-bounds in
sch_direct_xmit". Loading the program needs CAP_BPF/CAP_SYS_ADMIN, so the
trigger is root.

Fixes: 74e31ca850c1 ("bpf: add skb->queue_mapping write access from tc clsact")
Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/179033713973.2160803.4914570693994398206@kernel.org/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-9R8V.v2.20260924072708%40mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v1.20261005193231%40mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-MD1X.v3.r0.20261015165943-1%40mojatatu.com
Link: https://lore.kernel.org/netdev/20261015125822.GH83879@horms.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
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

 net/sched/sch_generic.c | 48 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 6f6a6f0d5eb0..fdd070840cb5 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -96,9 +96,37 @@ static void qdisc_maybe_clear_missed(struct Qdisc *q,
 
 #define SKB_XOFF_MAGIC ((struct sk_buff *)1UL)
 
+/* A tc BPF program may change skb->queue_mapping after the tx queue
+ * was picked, so re-cap it before use. A TCQ_F_ONETXQUEUE qdisc is
+ * bound to a single tx queue, so pin the mapping to q->dev_queue.
+ */
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
 
@@ -110,7 +138,8 @@ static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
 	skb = skb_peek(&q->skb_bad_txq);
 	if (skb) {
 		/* check the reason of requeuing without tx lock first */
-		txq = skb_get_tx_queue(txq->dev, skb);
+		/* re-cap: real_num_tx_queues may have shrunk */
+		txq = skb_cap_tx_queue(q, skb);
 		if (!netif_xmit_frozen_or_stopped(txq)) {
 			skb = __skb_dequeue(&q->skb_bad_txq);
 			if (qdisc_is_percpu_stats(q)) {
@@ -216,6 +245,10 @@ static void try_bulk_dequeue_skb(struct Qdisc *q,
 		if (!nskb)
 			break;
 
+		/* The cap pins every element of a TCQ_F_ONETXQUEUE qdisc to
+		 * q->dev_queue, so the list stays on the head's tx queue.
+		 */
+		qdisc_cap_skb_tx_queue(q, nskb);
 		bytelimit -= nskb->len; /* covers GSO len */
 		skb->next = nskb;
 		skb = nskb;
@@ -233,7 +266,6 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
 				      struct sk_buff *skb,
 				      int *packets)
 {
-	int mapping = skb_get_queue_mapping(skb);
 	struct sk_buff *nskb;
 	int cnt = 0;
 
@@ -241,7 +273,11 @@ static void try_bulk_dequeue_skb_slow(struct Qdisc *q,
 		nskb = q->dequeue(q);
 		if (!nskb)
 			break;
-		if (unlikely(skb_get_queue_mapping(nskb) != mapping)) {
+		/* A tc BPF store may have changed the mapping after
+		 * pick; cap it and keep the list on one tx queue.
+		 */
+		if (unlikely(qdisc_cap_skb_tx_queue(q, nskb) !=
+			     skb_get_queue_mapping(skb))) {
 			qdisc_enqueue_skb_bad_txq(q, nskb);
 			break;
 		}
@@ -286,7 +322,7 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
 		if (xfrm_offload(skb))
 			*validate = true;
 		/* check the reason of requeuing without tx lock first */
-		txq = skb_get_tx_queue(txq->dev, skb);
+		txq = skb_cap_tx_queue(q, skb);
 		if (!netif_xmit_frozen_or_stopped(txq)) {
 			skb = __skb_dequeue(&q->gso_skb);
 			if (qdisc_is_percpu_stats(q)) {
@@ -322,6 +358,8 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
 	skb = q->dequeue(q);
 	if (skb) {
 bulk:
+		/* cap the head; the bulk helpers cap every appended element */
+		qdisc_cap_skb_tx_queue(q, skb);
 		if (qdisc_may_bulk(q))
 			try_bulk_dequeue_skb(q, skb, txq, packets, budget);
 		else
-- 
2.43.0

