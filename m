Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349833;
	b=oJ9vN3uJQKMkmYW66fcDwClKAVeaUocdj+iTyKTXUFlnMmYEaudqezS98HfJHXINl5/m
	 5KSJHyZEkmbbDlr+eh2oJFNB2FCB/eXJhCjI97Z/KE6RhXF0QkdpJvQ7a1Xz8H+g2QHiW
	 v3gMzi32n/NcaoQWb0ADffSaK6H2EliYLwVQNFnYXi2J/idGFv2NErvFFHB03DwImd/wG
	 zlP8oja/MFCRXIklwEekEQpk7TxyVPKRlXwSeb1qlGjc/zW8Z4yx9pnNwGsU6+cU6nL8N
	 PGb07IGuM9SUkkK+eyQEqT82rzwmcQehgbOV9FmiQdXq7caBCgvMjSoqghVJYRwxEGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349833;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=z7FiR8aYlJ/B/h48kT0MY6E1EuyBPljuK907hwXFxOM=;
	b=fxWYEH8pXoYE0o1P9PPm3aYZosCwJNwwQU1RDsV7W4/vdIxMRP8uTrTnJR2sydu0MYFx
	 vdp7XMzVsvVAJGsrEkB/n5YdvlcU6YNm4YxE6btSEMJhpEgBIZIYKDjH4BpGbZcub5fRe
	 9LhvNbFksxSxCd3cW6zQ23G8uLVrVN6py86eFQWfaRbymWsrL0IE2kYgB57FojUJu+ECT
	 tD4RLrzsryFQb/46ijgJ8gCbZekyJ36sE7GqOZMV8b4GcnHNIllkJrxUjBhGaf6xw1yiO
	 XcPjNSuUcsPmSNNf6Ah0AG5fbcKEunz9c3TFDkfqrIBzFNw3qS32raeQgHj7KOx1SlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Zm3zYVY1;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB7606A321;
	Tue, 10 Nov 2026 22:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFEB7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=Zm3zYVY1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=z7FiR8aYlJ/B/h48kT0MY6E1EuyBPljuK907hwXFxOM=; b=Zm3zYVY19mC2K1jfIZmHe0WYOJ
	+2vXpSVKUabQcSTOLxoNuVasPCbnifelYbUEAcvv9YAt/nO3ZURkUfX5mI21hhZhGJt/9gfP7qgo+
	IJHIxRe6GenkJzMX9pvkmhXuLVsZtgZRK26KyFYBfkk/TWdPlmdIICanZuqx30Rync8LpLGNx+h4T
	4pUtkpivb+6Lc3XMj8wOQR6l+XNOtRxft1hd6Xvba+XpzbvJajHJ5noguxLP6D86fwaNxGXy3clPR
	viZQEkhd3HdoaYhTAS1HqHhMCWF+LVx5MH+D++bqFurMFgDSko5Zzrwlnllnd5I64hNrpyac3gRbE
	HdBsyDOA==;
Received: from [151.115.150.205] (port=60782 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xQuMC-00000006Xkc-2vLj;
	Tue, 10 Nov 2026 23:30:24 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/sched: sch_qfq: revalidate aggregate after peek
Date: Tue, 10 Nov 2026 22:29:47 +0000
Message-ID: <20261110222946.2147440-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

A netem child can re-enter qfq_enqueue() through a duplicating netem.
If lmax was lowered with packets queued, qfq_change_agg() can move the
class and free its old aggregate. This can cause a UAF or put the
class on the wrong active list.

Restart qfq_dequeue() if a selection peek changes the aggregate. Charge
the serving aggregate before the post-dequeue peek. After this peek,
requeue only an active class using cl->agg. Recheck activity and use
cl->agg after the peek in qfq_enqueue().

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
Changes in v2 after review from Sashiko:
- Cover the post-dequeue peek without moving service accounting.
- Clarify the trigger.

v1: https://lore.kernel.org/all/20261106200236.716641-2-Jeremy.Jean@oss.cyber.gouv.fr/
Sashiko: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106200236.716641-2-Jeremy.Jean%40oss.cyber.gouv.fr

 net/sched/sch_qfq.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index e900890..82903f9 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -992,8 +992,7 @@ static void qfq_update_eligible(struct qfq_sched *q)
 }
 
 /* Dequeue head packet of the head class in the DRR queue of the aggregate. */
-static struct sk_buff *agg_dequeue(struct qfq_aggregate *agg,
-				   struct qfq_class *cl, unsigned int len)
+static struct sk_buff *agg_dequeue(struct qfq_class *cl, unsigned int len)
 {
 	struct sk_buff *skb = qdisc_dequeue_peeked(cl->qdisc);
 
@@ -1002,13 +1001,6 @@ static struct sk_buff *agg_dequeue(struct qfq_aggregate *agg,
 
 	cl->deficit -= (int) len;
 
-	if (cl->qdisc->q.qlen == 0) /* no more packets, remove from list */
-		list_del_init(&cl->alist);
-	else if (cl->deficit < qdisc_peek_len(cl->qdisc)) {
-		cl->deficit += agg->lmax;
-		list_move_tail(&cl->alist, &agg->active);
-	}
-
 	return skb;
 }
 
@@ -1103,6 +1095,7 @@ static void qfq_schedule_agg(struct qfq_sched *q, struct qfq_aggregate *agg);
 static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
+restart:;
 	struct qfq_aggregate *in_serv_agg = q->in_serv_agg;
 	struct qfq_class *cl;
 	struct sk_buff *skb = NULL;
@@ -1112,8 +1105,11 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
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
@@ -1151,13 +1147,15 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 		 */
 		in_serv_agg = q->in_serv_agg = qfq_choose_next_agg(q);
 		skb = qfq_peek_skb(in_serv_agg, &cl, &len);
+		if (unlikely(in_serv_agg != q->in_serv_agg || cl->agg != in_serv_agg))
+			goto restart;
 	}
 	if (!skb)
 		return NULL;
 
 	qdisc_qlen_dec(sch);
 
-	skb = agg_dequeue(in_serv_agg, cl, len);
+	skb = agg_dequeue(cl, len);
 
 	if (!skb) {
 		qdisc_qlen_inc(sch);
@@ -1181,6 +1179,13 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 		 len, (unsigned long long) in_serv_agg->F,
 		 (unsigned long long) q->V);
 
+	if (cl->qdisc->q.qlen == 0) /* no more packets, remove from list */
+		list_del_init(&cl->alist);
+	else if (cl->deficit < qdisc_peek_len(cl->qdisc) && cl_is_active(cl)) {
+		cl->deficit += cl->agg->lmax;
+		list_move_tail(&cl->alist, &cl->agg->active);
+	}
+
 	return skb;
 }
 
@@ -1274,9 +1279,10 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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

