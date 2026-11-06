Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.159.188.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995387;
	b=ku8Q22hs2APVJNQnU9Mzi9LtLhI8gg7ROMhhkEd4Pmi6r+OeMQ26+fiNOlqEcQ0U23w+
	 hg2KehdypY9Ro2EzQFbCtRPc9aMCTYYJtUPFaYIxtmrn+clqBAsAp1P7+rtBB1d2KqIfo
	 El7oGJGaekDQdRTPi2QQbVtGWAhDg1Xroe65y6BvyScOy9d0DAkM+6T5j0efUgQgS6nQC
	 ssaw5NYwuv1YzAWq8mzHaQWNDU5mqujLuBt6l+XGQA5xj0vVfW8tHMkq6KlnoIljf+W3F
	 WoSkv29w7U/09dmcdt+j1H9AE21t/fE0BtxmQaDEmuHt6k2bOKt0BfIbwyE53OjuR+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995387;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Get-Message-Sender-Via:
	 X-Authenticated-Sender:X-Source:X-Source-Args:X-Source-Dir;
	bh=EZQDuZNuws1ikcoVHzG7GXK+3VfznaqQ2EHawvfd1nw=;
	b=mFYcF7uin02pJna0kvTyeHY+ObaUMtV79RQrvyB/iW4B6lZ6quaf7HIK9zYmCYjA9bOi
	 OBK8sDp6GrnmWtSUI4rCbKT3Oo3BeE7fRmdu4bjbYgLhhsoyfuitehcku6RBKWVLs8hEq
	 +Z2FpcPlOJ3nP4aYZqunaocsg2GI4N1vULjz/wq/DNVnZRJDExXPs5oKkQS+Y3e4z36vr
	 rLXtePQLXY/gGJBEulDrNTcdCDCkeUGw5JCRW8/cUGRE+l11H4r7vOPSXAt9MleH+/71y
	 DzOWWrbd05zBKqrPAtSdBaE0fpl6jJKms97MR8u2EBGW5/IyF4iUSWj4WGk0NtEX12A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.cyber.gouv.fr;
	spf=pass smtp.mailfrom=oss.cyber.gouv.fr;
	dkim=pass header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=WZqhRt+V;
	arc=none smtp.remote-ip=51.159.188.251
Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8A606A326;
	Fri,  6 Nov 2026 20:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DE8A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.a=rsa-sha256 header.s=default header.b=WZqhRt+V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=EZQDuZNuws1ikcoVHzG7GXK+3VfznaqQ2EHawvfd1nw=; b=WZqhRt+VJHP/2njNbf/QtsBVl8
	qDU8VlUBdWpv0N1miQxdsIsnJmyJpcT00O/g9Az3/K+8Bvx9Jag/1gEeZjX4G8EwvcgklYtN0W8FC
	L/ZOd2FNQmy60jG2LnviDVWi/FRxa5Nri4bkxwyZIMR5P9zB0uIjCByOHnyJt7tTTIU5iPG6ROJp5
	N0d71A3pYjjVjowYCJgjJZkkcR+6zYjkwIFDOSewLyQswuUcckRhq64DF9VJJAVl9BfS4ZucKXMUl
	W8BkuJROiEHPzgBnKSLX9G1PoSIjOJOb+EHYJ/UTR5oEvmojtN2SW+6dFSib3pgIjaI2YvkR6nN4t
	uKgzEgeA==;
Received: from [151.115.150.205] (port=49746 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xPQ9N-00000000eD1-147b;
	Fri, 06 Nov 2026 21:02:57 +0100
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH] net/sched: sch_qfq: revalidate aggregate after peek
Date: Fri,  6 Nov 2026 20:02:37 +0000
Message-ID: <20261106200236.716641-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

qfq_dequeue() keeps in_serv_agg across qfq_peek_skb(), but a child peek
can re-enter QFQ and free it. KASAN reports a UAF:

  BUG: KASAN: slab-use-after-free in qfq_dequeue+0x124/0xad0
  Read of size 4 at addr ffff88800740423c by task swapper/0/0

After each child peek, restart qfq_dequeue() if either q->in_serv_agg
or cl->agg changed. Also use cl->agg after the child peek in qfq_enqueue().

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Cc: stable@vger.kernel.org
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/sched/sch_qfq.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 6f3b7273cb160..dc813822d3825 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1100,17 +1100,24 @@ static void qfq_schedule_agg(struct qfq_sched *q, struct qfq_aggregate *agg);
 static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
-	struct qfq_aggregate *in_serv_agg = q->in_serv_agg;
+	struct qfq_aggregate *in_serv_agg;
 	struct qfq_class *cl;
 	struct sk_buff *skb = NULL;
 	/* next-packet len, 0 means no more active classes in in-service agg */
 	unsigned int len = 0;
 
+restart:
+	in_serv_agg = q->in_serv_agg;
+	skb = NULL;
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
@@ -1148,6 +1155,8 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 		 */
 		in_serv_agg = q->in_serv_agg = qfq_choose_next_agg(q);
 		skb = qfq_peek_skb(in_serv_agg, &cl, &len);
+		if (unlikely(in_serv_agg != q->in_serv_agg || cl->agg != in_serv_agg))
+			goto restart;
 	}
 	if (!skb)
 		return NULL;
@@ -1271,9 +1280,10 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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

