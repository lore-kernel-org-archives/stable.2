Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502263;
	b=YRrtIukgBufIpB99POOs/Aa437Ct2WQJMJhGvpZrI2JJi8S6pvowL+EVnV8ad2YhVxT8
	 4z4tQOqlI+3DADENvfX2whoO4zd1j6bqAGHr+KqHfvam1xzdMo7qkhC2Mt4ZfX7zExX6i
	 TuD3j1cSQA3E4vWCd6iLvBxUaLpqiNzYwZthyn75/mMJND5DFNpOA9ckbpVVO8sf2ufYZ
	 kL/2/DfOANhcQ2xlzwET4I6UeTLV4MayZ+OqUACspcU5ZKKyJ5vo+jZoIuAJow1jD9xTf
	 Zrh6yVyBk/67ZSn+S49Yxr+eYSxOSU979AdiIuzsvgeCiM1UUtPrvRawBlA5Ssu7Zqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502263;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=fcDmgM+WdSVeyRrYA0BelcCi40y6yErNRBziadhevds=;
	b=Yxo1/fs6Fwc+GzM/ZpkiusrofnROl4AIpkMNQDOfdyVQ6bvEt1kaKhrEFDtSkARqKUC1
	 F+qmteWbdlVQOAtrFiI5YFc6udk+sU25xTjVdh1fcq1m47/QiYKsCgv3WjvXFAAHaxjI6
	 R1gF3+elNQufTJTHMP/VTxXhbbyNyvCjwInFNIO4Ds5w+FpL0HdiqJ17MCsjLAcnQZZXI
	 38lUcJJRx4E0h3KUhdjk4/86UtMna4g7lbezJOLHJ4fuV9FXifHB85W9kAHBLbEojlKeF
	 rWfsE38BnGmosDsiZw7tILkVYmdYUtd00/rwq87sjeyKxAE14LPkPRLYl/RIPDzX8kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=rBQs8gup;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD22606A321;
	Thu, 12 Nov 2026 16:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FD22606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=rBQs8gup
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=fcDmgM+WdSVeyRrYA0BelcCi40y6yErNRBziadhevds=; b=rBQs8gupgzlpl2CNVWFcmOlocq
	YmASQjnAPWe0t5e/LqjADeB8nre2zlZ2eardykOa5cs3GtVE/qCy9jbX/NRHa4HpbCn3aI5BrEhA7
	p9PVyoyQbDBPEWDLS4C/sq9KZE8dlQAqYK6MFydUDyJLnFvEYWH7f6nfFxh4MoT1hVO8fnm08C8p1
	F9X7ijA5ocddkra8DR5hoseQubD4zCI+9CWRMdg2ZPYgschu427lMoe0CE0bgMfgVyk6vIwd59ZEV
	7THwETJKXpa7ltf/mnROGoni4WHt2djJ/QAHT7Djo2QbgSuN4GsaxeIsagSkaeOmeGIAV9tFnoiH/
	KgcbbcQQ==;
Received: from [151.115.150.205] (port=59116 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xRY0r-00000008X8w-297n;
	Thu, 12 Nov 2026 17:50:59 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net v3] net/sched: sch_qfq: revalidate aggregate after peek
Date: Thu, 12 Nov 2026 16:49:55 +0000
Message-ID: <20261112164954.2786444-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

A QFQ child callback can re-enter qfq_enqueue() during a peek or
dequeue. qfq_enqueue() can then move the class and free its
aggregate. This can cause a UAF or corrupt the active lists and
service accounting.

Restart qfq_dequeue() after a selection change. Defer recursive root
enqueues through agg_dequeue() and replay them after service
accounting. Keep replay drops on the same root. Correct ancestor
counts after failures. Recheck activity and use the current aggregate
in qfq_enqueue(). Keep declarations before the retry label.

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
Changes in v3 after review from Sashiko:
- Keep native child peeks. Defer recursive enqueues until agg_dequeue() returns.
- Keep replay drops on the stable root. Repair ancestor accounting on failure.
- Keep retry declarations before the label.

Changes in v2 after review from Sashiko:
- Cover the post-dequeue peek.
- Clarify the trigger.

v1: https://lore.kernel.org/all/20261106200236.716641-2-Jeremy.Jean@oss.cyber.gouv.fr/
v2: https://lore.kernel.org/all/20261110222946.2147440-2-Jeremy.Jean@oss.cyber.gouv.fr/

 net/sched/sch_qfq.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index e900890..d867d3b 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -182,6 +182,7 @@ struct qfq_sched {
 
 	u64			oldV, V;	/* Precise virtual times. */
 	struct qfq_aggregate	*in_serv_agg;   /* Aggregate being served. */
+	struct sk_buff_head	*deferred_enqueues;
 	u32			wsum;		/* weight sum */
 	u32			iwsum;		/* inverse weight sum */
 
@@ -1103,17 +1104,25 @@ static void qfq_schedule_agg(struct qfq_sched *q, struct qfq_aggregate *agg);
 static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
-	struct qfq_aggregate *in_serv_agg = q->in_serv_agg;
+	struct qfq_aggregate *in_serv_agg;
 	struct qfq_class *cl;
-	struct sk_buff *skb = NULL;
+	struct sk_buff_head deferred_enqueues;
+	struct sk_buff *skb, *next;
 	/* next-packet len, 0 means no more active classes in in-service agg */
-	unsigned int len = 0;
+	unsigned int len;
+
+restart:
+	in_serv_agg = q->in_serv_agg;
+	len = 0;
 
 	if (in_serv_agg == NULL)
 		return NULL;
 
-	if (!list_empty(&in_serv_agg->active))
+	if (!list_empty(&in_serv_agg->active)) {
 		skb = qfq_peek_skb(in_serv_agg, &cl, &len);
+		if (unlikely(in_serv_agg != q->in_serv_agg || cl->agg != in_serv_agg))
+			goto restart;
+	}
 
 	/*
 	 * If there are no active classes in the in-service aggregate,
@@ -1151,17 +1160,23 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 		 */
 		in_serv_agg = q->in_serv_agg = qfq_choose_next_agg(q);
 		skb = qfq_peek_skb(in_serv_agg, &cl, &len);
+		if (unlikely(in_serv_agg != q->in_serv_agg || cl->agg != in_serv_agg))
+			goto restart;
 	}
 	if (!skb)
 		return NULL;
 
 	qdisc_qlen_dec(sch);
 
+	qdisc_root_sleeping(sch)->flags |= TCQ_F_DEQUEUE_DROPS;
+	__skb_queue_head_init(&deferred_enqueues);
+	q->deferred_enqueues = &deferred_enqueues;
 	skb = agg_dequeue(in_serv_agg, cl, len);
+	q->deferred_enqueues = NULL;
 
 	if (!skb) {
 		qdisc_qlen_inc(sch);
-		return NULL;
+		goto replay_deferred;
 	}
 
 	qdisc_qstats_backlog_dec(sch, skb);
@@ -1181,6 +1196,11 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 		 len, (unsigned long long) in_serv_agg->F,
 		 (unsigned long long) q->V);
 
+replay_deferred:
+	while ((next = __skb_dequeue(&deferred_enqueues)) != NULL)
+		if (qdisc_enqueue(next, sch, &qdisc_root_sleeping(sch)->to_free))
+			qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(next));
+
 	return skb;
 }
 
@@ -1236,6 +1256,11 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct qfq_aggregate *agg;
 	int err = 0;
 
+	if (unlikely(q->deferred_enqueues)) {
+		__skb_queue_tail(q->deferred_enqueues, skb);
+		return NET_XMIT_SUCCESS;
+	}
+
 	cl = qfq_classify(skb, sch, &err);
 	if (cl == NULL) {
 		if (err & __NET_XMIT_BYPASS)
@@ -1274,9 +1299,10 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	/* if the class is active, then done here */
 	if (cl_is_active(cl)) {
 		if (unlikely(skb == cl->qdisc->ops->peek(cl->qdisc)) &&
-		    list_first_entry(&agg->active, struct qfq_class, alist)
+		    cl_is_active(cl) &&
+		    list_first_entry(&cl->agg->active, struct qfq_class, alist)
 		    == cl && cl->deficit < len)
-			list_move_tail(&cl->alist, &agg->active);
+			list_move_tail(&cl->alist, &cl->agg->active);
 
 		return err;
 	}
-- 
2.47.3

