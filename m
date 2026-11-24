Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541961;
	b=ngShSimP+mOPPCJ9aHnasJhVLukm9lPUAZ/Uc/s3HHqkASRsRDnwwIEzp2Dr6P59alFk
	 yUwhraIanXWLyM7RPEgm5g1ABpIuoBmCrT/IyV0b7EySRhJsEOwgb1jWfWFhdbkwtkiLO
	 fIcK9BmZI5noZ4C3olbhnFInSClJhJXQ367ujWL/jXRworxMvdjyRh9Y9KZLHyTzZH1Tn
	 ToYwCBhXGJxHb+OVZBEX3M7nQOMBKyOufHN38nfKi5WM0/jLncI9IsOkBBa5ygQFLc8Hz
	 /4i78yNAgEhxGMyPy/lOmGG86B6ctf+f0YojewvI8HCZwtrzFa2AzLylq/pt2fp3nWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/5aXYZOiCfmZpepVU5XcntNHJrd4O0PtQpD5cOGvrlc=;
	b=4anJ4h3oJax98Vn58LUL06rBrFKroZTEwU5o3YJ1yS7OHUnTZgkHPu1GQJpO1I4nutSN
	 4zzdXYGMqXOEiVDOlauKdBFNmIZzgjnD34MGJXr+gAp4yZCfEIr8dnGFAqQ78UQaCXpT2
	 j5N9ZKxOLeCvMBCic5bhXC/lRYQQfi56WkKe1xlSW1Rt0qAoviIQskdOgphS6pLc5hn9H
	 BBdKFqrkZaOJwFaQ1UvmcDGLoab/KlCoEqPxsrMaaJjY2vaQP6J1gP3FtJvWuVgABQDhK
	 i6M/bJJ6X7dlXfHteL8zZ0k64L6LyhpsHtdMinQg0sqOFPKQUSCgV1nH7vMaoy0gnAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=g+CsQD8V;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553F2606A32A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 553F2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=g+CsQD8V
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-862df509d48so3780067a34.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1795541959; x=1796146759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/5aXYZOiCfmZpepVU5XcntNHJrd4O0PtQpD5cOGvrlc=;
        b=g+CsQD8V54qVIAt0fMSF2JLjZB8Sc4FGlKFaOY5d7F2cewuRxg+oUU33m11Wik04mv
         fUdwoV7+IT54bov+7BscT4T32vEdrx469i6HpM5behQbrPVUtatpMt5d4eLCq2ATbe9j
         x+uSFvGL+C9r81egeAdaDvlG6cM+XdqG239n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541959; x=1796146759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/5aXYZOiCfmZpepVU5XcntNHJrd4O0PtQpD5cOGvrlc=;
        b=wXvZGn+xkEDMvRwBKesYl10q+wg4gzKawRbmbejhBGJ0dJ5ytkbkIXsOmro6VVul13
         2lZTOiWRlPs0oZCJ9aNeBNerWPgdGHXAAInz32vLOzmggi9SXUckiHitH7g9LkeL99lN
         0I6EWFmMn2e8F1jpzTJ8CfnFtMdRM99euphKOofyi7fSMdwMpKZbv7sBCZnBswUPt3sm
         aoszS2zboDRB4XoAO/Ykq5dN+jHYtB3phZfivRhcNg9j4Yp8d8W00u3zvKKwWGPaKNvk
         YDVY9Vn7N5kIJD1plf+KoAbKeItPovjPGvWEy8WNIT9Csvi8GtwTnPMHucCx1lEmIHf9
         ZPLg==
X-Forwarded-Encrypted: i=1; AL+hErHtWWJjLv8ztwPo1/tUJB17EonjNNqyG5TgBjnV5g83FHoPtRwSKW8KDUq6qi3KR6A98gOyuyI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tDLdkZBqjGSSqMD+KFGDqHywee0a3a+Uu/nDMUb5H+TmbhpuT
	OdDmZ05ZD6Wm9JefesK3PcDS2Vn/s4xzrMXlx1xGPBUuOPvuZ01LF+8RHcdfMxuFGO8=
X-Gm-Gg: AZFdTZf46pk9eMStLM7vcVLZgn6KTt7DCaTHdiYhF19NNt4ZEM13VfaaefekHwX4jOf
	beLnGXOX/DXmGty6YxdnC0u51F1Q5aOFinZplYlj5l5BXZ3JbFFRg5NEnn70dQAoeNpFfO4gAML
	S8idAZpJcIscHVppzwcV8pnXh+zVn2O5sPjodi1az3ry9U8dfZPmEZlh7d1xq2wLSUWd+rnqaL7
	rpX2NiPsyV6khC+nJRlZfqfL4sm6LHBjsEwk2DDcBs08NVY/45H/eESBinnfg3AiIjlg9brp4W8
	tb5nEZtS0kXNLF2EF/L/S0efs/pNCr/hR1B6+bPr4N5Y3wgpk0AGM2Q7mz3zGi81TbllbuSUs3T
	iBcSjGp6XpKG34sPNhl2FLgca86Ol/lgKZgIVNXrW+I5NXJbySE2M+I2/rqQM4u6vVxT2twfciN
	loH4zucyogyVT+eSA4fz9GX/FoiuUakk76uDJNnU4ejfVyKC25Vvrdhz5G7I09pJgFNGl7rGdJR
	jm/8X+xZJtukkab/3ulXVIHPn83PJld3FSpmF66mqujXiL15Cj9+jthTbAEAF+R/RJyx4MDDGiN
	Xg9gxDXKYg34TLPyjGUg/LDxIT55u+arJXR71UOyPVQNL36bpujFdhT4rNjK1c+YmmFnmknTuNh
	hqSjEUR98plDbtRwzPz9R4Sfc2Cr0cg==
X-Received: by 2002:a05:6830:82ee:b0:85b:895:a015 with SMTP id 46e09a7af769-86309065b5amr12447788a34.4.1795541959275;
        Tue, 24 Nov 2026 09:39:19 -0800 (PST)
Received: from com-75606.corp.openai.org ([199.47.143.1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168bdaf7sm11667094a34.5.2026.11.24.09.39.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 09:39:19 -0800 (PST)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	edumazet@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	Kyle Zeng <kylebot@openai.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3 2/2] net/sched: sfq: perturb the hash from the enqueue path
Date: Tue, 24 Nov 2026 09:38:14 -0800
Message-ID: <f2f59b9b0f7391a3b4c366cb0b04252af8e94eaa.1795540952.git.kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795540952.git.kylebot@openai.com>
References: <20261110044450.51921-1-kylebot@openai.com> <cover.1795540952.git.kylebot@openai.com>
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

A backlogged SFQ can remain alive after its root is unpublished. Its
perturbation timer takes the current sleeping-root lock, but rehashing
can still resolve the old parent handles through the live device. A
missing parent triggers a warning; a reused handle can make
qdisc_tree_reduce_backlog() subtract packets from a replacement tree.

Perform a due perturbation before classifying the next enqueued packet.
The packet path holds the queue's lock, so the key change and rehash
happen together without an autonomous callback. Preserve the initial
perturbation interval and pass dropped skbs through enqueue's
deferred-free list. Idle queues keep their key until another packet
arrives.

An AI review found this path.

Fixes: 18cb809850fb ("net_sched: sfq: extend limits")
Fixes: 47e8dbb6e763 ("net/sched: do not reset queues in graft operations")
Cc: <stable@vger.kernel.org> # d6f81fd6abe2: net: sched: prevent scheduling deactivated qdiscs
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 net/sched/sch_sfq.c | 49 ++++++++++++++-------------------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 2bd3fc65053a..5810c458586e 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -130,11 +130,10 @@ struct sfq_sched_data {
 					 * dep[X] : list of flows with X packets
 					 */
 
+	unsigned long	perturb_time;	/* next hash perturbation */
 	unsigned int	maxflows;	/* number of flows in flows array */
 	int		perturb_period;
 	unsigned int	quantum;	/* Allotment per round: MUST BE >= MTU */
-	struct timer_list perturb_timer;
-	struct Qdisc	*sch;
 };
 
 /*
@@ -340,6 +339,8 @@ static int sfq_headdrop(const struct sfq_sched_data *q)
 	return q->headdrop;
 }
 
+static void sfq_perturbation(struct Qdisc *sch, struct sk_buff **to_free);
+
 static int
 sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 {
@@ -351,6 +352,10 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	struct sk_buff *head;
 	int delta;
 
+	if (q->perturb_period &&
+	    unlikely(time_after_eq(jiffies, q->perturb_time)))
+		sfq_perturbation(sch, to_free);
+
 	hash = sfq_classify(skb, sch, &ret);
 	if (hash == 0) {
 		if (ret & __NET_XMIT_BYPASS)
@@ -531,7 +536,7 @@ sfq_reset(struct Qdisc *sch)
  * We dont use sfq_dequeue()/sfq_enqueue() because we dont want to change
  * counters.
  */
-static void sfq_rehash(struct Qdisc *sch)
+static void sfq_rehash(struct Qdisc *sch, struct sk_buff **to_free)
 {
 	struct sfq_sched_data *q = qdisc_priv(sch);
 	struct sk_buff *skb;
@@ -569,7 +574,7 @@ static void sfq_rehash(struct Qdisc *sch)
 drop:
 				qdisc_qstats_backlog_dec(sch, skb);
 				drop_len += qdisc_pkt_len(skb);
-				kfree_skb(skb);
+				__qdisc_drop(skb, to_free);
 				dropped++;
 				continue;
 			}
@@ -601,29 +606,14 @@ static void sfq_rehash(struct Qdisc *sch)
 	qdisc_tree_reduce_backlog(sch, dropped, drop_len);
 }
 
-static void sfq_perturbation(struct timer_list *t)
+static void sfq_perturbation(struct Qdisc *sch, struct sk_buff **to_free)
 {
-	struct sfq_sched_data *q = timer_container_of(q, t, perturb_timer);
-	struct Qdisc *sch = q->sch;
-	spinlock_t *root_lock;
-	siphash_key_t nkey;
-	int period;
+	struct sfq_sched_data *q = qdisc_priv(sch);
 
-	get_random_bytes(&nkey, sizeof(nkey));
-	rcu_read_lock();
-	root_lock = qdisc_lock_root_sleeping(sch);
-	q->perturbation = nkey;
+	q->perturb_time = jiffies + q->perturb_period;
+	get_random_bytes(&q->perturbation, sizeof(q->perturbation));
 	if (!q->filter_list && q->tail)
-		sfq_rehash(sch);
-	spin_unlock(root_lock);
-
-	/* q->perturb_period can change under us from
-	 * sfq_change() and sfq_destroy().
-	 */
-	period = READ_ONCE(q->perturb_period);
-	if (period)
-		mod_timer(&q->perturb_timer, jiffies + period);
-	rcu_read_unlock();
+		sfq_rehash(sch, to_free);
 }
 
 static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
@@ -746,11 +736,7 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 	rtnl_kfree_skbs(to_free, tail);
 	qdisc_tree_reduce_backlog(sch, qlen - sch->q.qlen, dropped);
 
-	timer_delete(&q->perturb_timer);
-	if (q->perturb_period) {
-		mod_timer(&q->perturb_timer, jiffies + q->perturb_period);
-		get_random_bytes(&q->perturbation, sizeof(q->perturbation));
-	}
+	q->perturb_time = jiffies + q->perturb_period;
 	sch_tree_unlock(sch);
 	kfree(p);
 	return 0;
@@ -771,8 +757,6 @@ static void sfq_destroy(struct Qdisc *sch)
 	struct sfq_sched_data *q = qdisc_priv(sch);
 
 	tcf_block_put(q->block);
-	WRITE_ONCE(q->perturb_period, 0);
-	timer_delete_sync(&q->perturb_timer);
 	sfq_free(q->ht);
 	sfq_free(q->slots);
 	kfree(q->red_parms);
@@ -785,9 +769,6 @@ static int sfq_init(struct Qdisc *sch, struct nlattr *opt,
 	int i;
 	int err;
 
-	q->sch = sch;
-	timer_setup(&q->perturb_timer, sfq_perturbation, TIMER_DEFERRABLE);
-
 	err = tcf_block_get(&q->block, &q->filter_list, sch, extack);
 	if (err)
 		return err;
-- 
2.55.0.openai.911.g06873a30d2f3

