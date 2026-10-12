Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5D4BB298
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791828994; cv=none; b=PDGWT3XUZGxCma3qPUaswkbbG4l7+Ruf02tVedqqiFHq13e5DU6RjrzCIi5btJ/Ndt0W9SqBctQGq8SFWJUoFeEoPZS49x1N5KgO/wZ9l8xxPCJaiZI4kUhPLKX9/eiQLK83RN4+1YbPEq7pL3Z22ZHIfVdVpZxRpILMvB993yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791828994; c=relaxed/simple;
	bh=R4czRHpqwLeUZCPylEueOPeNfThjw1mBU4SAe0owvEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PtaMF8YlWwrFGXpQGuhHFG9SLZuAByXv5n/fLUFeT9Rsr/RoDsDLbeOV9LqjQKZ1n7D4vSNaAsE+EnXfwZ3lzdnmmY5iPCBrRPcO4eqiguJrXyhLf0jQPnrHg2rs/bCPczvhSgRfQdaQ+ttCV2PHRH5s7XicYpLDdlJOt6zZ7QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=q8RGuPAU; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="q8RGuPAU"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91054f537ccso26281856d6.1
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 11:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791828991; x=1792433791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fzChrc19jcQoCQovxW6S7a9HWkv0j2zGCifMcuBL9m8=;
        b=q8RGuPAUgb6Pf7e61M9ql+15pOZAEDvyEUQqQ+GNm6ogAAOSFxRJMrQbqxkcZVytrv
         J2zEc8VJrxmusqvSvVuCu/UmrPWan2nanOxHwBE0LCkCORSfZUoFxJFkvRz7t7TmIMPT
         gfblN8xv0N0eREKDwYHtmMuiI7TVYBgV6XsvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791828991; x=1792433791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzChrc19jcQoCQovxW6S7a9HWkv0j2zGCifMcuBL9m8=;
        b=QNvMKPzsWpgp5ipdd9RSmGhRQIY0cJfePv4ETTIw110AewSEFxm9o7oDkTEfWDnVuA
         jrDIHqE7/JXwVTUcVLX1+vegxIye4/1M2i9lNJ3HuX0b/6jwbleL/+3K2dkisz71Ww8c
         /MGi/ybZQuL6LAUpMHp0fzzNQT10/8L4JxrpeIPLng6Q3Hj70/TFG7OuqpmHtJXfOcLm
         NNQZQUSwZTzgk/U9LXMxO0m2lWsKa26ncFAjUoCPtaMmDDiiB9HGRY3V8+uxv68YBxOJ
         Gpbg1EG6u4iKJHPMfJiTMz5KZrxs//leR2zwbicxmZpMg0+TBT4NpvV+cYaMx7EM1/Kp
         RZeQ==
X-Forwarded-Encrypted: i=1; AKwUvByvYiXJps43kNicJp7kS3Lhhgk/HYr93JVfQ/W/uAJneT3Kas5n+hafan/ZcpsSpoaGpYYCphY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIh1hwYJO0TRC5BPFdw34Pr9NlwutItwvv1W9A4p1iMHVTZzGw/
	/F8VI6XU1wOAR+RPoiaDKYCYf9zcfabGgvX7ECM4uEM8mwYwtNcnXQaU4ZrAQ1Z6Tw==
X-Gm-Gg: AYBFou2JY3yCJ4Ce0sovoyFdWmV8EOZvBun2Ufk8te9xboJfgT+SfpJtuIAjBEVGltV
	lcipBz5Q+HW2lTnSHiH921lpcRy2+Z6Ub0Yq9A7/bTVzYOmJxycajxfGWSsRJQdi7ELqGzKnUS8
	bLdeOkC47dU3P/DQBEz4mPYltYfjJJhZyLgyETuj48Z854DdiJjtYBXXGAj34Jb1XwM7L+KDkeZ
	HI085hAF0FHLzgUkK/RSQjPRvfLSs1KmaDoIMnn4w3qZ3JAdhKbmsvVQmvJvF/IQlmBh0t90E0/
	Hw8vvvADR7i7sHRQRh2CCaRJ1AaoeDLKjfhKD7xoJj81sSL/Qs5v40xqLwWv5qUfKeJEVKShr9u
	Vs+AmBsSZFNAX/YuyUbndLFqaUxjZs23lwNIPmoQzug6NQ0ksXjImMAqUmodJ/GTSaRRj4FBb1Q
	OI7h1mKRLt/qCppie/LlD8811JI6yKOOR/ey53QwVNas0YxIJ/DPiINuMKfP9xs5sXD6SyLb8Ui
	ihvsBZEwsiZ1XNcQl7I+ormAYViZyfHCucrGP6DnlV8
X-Received: by 2002:a05:6214:62d:b0:917:86e7:1129 with SMTP id 6a1803df08f44-91b5530cc04mr185091566d6.6.1791828990980;
        Mon, 12 Oct 2026 11:16:30 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b383dasm3956626d6.8.2026.10.12.11.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:16:30 -0700 (PDT)
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
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2 repost1] net/sched: sch_teql: fix shared headroom and header strip on slave retry
Date: Mon, 12 Oct 2026 14:16:27 -0400
Message-Id: <QDISC-6HS9.v1.r1.20261012134711-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

teql_master_xmit() writes the link header of the current slave directly
into the skb via teql_resolve(), and on retry undoes it with
__skb_pull(skb, skb_network_offset(skb)).  Two problems exist on the
retry path:

1. When the skb is shared (for example a packet tap installed on the
   master makes xmit_one() clone it before teql_master_xmit()),
   dev_hard_header() writes into memory shared with the other clones and
   corrupts them.  The headroom must be made private before the write.

2. The pull blindly removes skb_network_offset() bytes.  For a frame
   that carries its own link header in the payload (AF_PACKET/SOCK_RAW
   with no dst entry), teql_resolve() returns 0 without adding a header,
   so the retry strips the userspace-supplied header and pushes a frame
   whose first bytes are payload.

Fix this by calling skb_cow_head() before dev_hard_header(), and by
pulling back only the header length that this slave actually added,
tracked per iteration.  An AF_PACKET/SOCK_RAW frame is then retried on
the next slave with its header intact, and a shared skb is unshared
before it is modified.

This is a follow-up to commit dc4b95b8fee9 ("net/sched: sch_teql: restore
skb->dev on the slave failure path"), which restored skb->dev to the
master on the slave failure path but left these pre-existing defects on
the same teql_resolve()/retry path.

Conditions to recreate the bug: a teql master with at least two slaves,
the first of which does not consume the skb, then send an
AF_PACKET/SOCK_RAW frame (no dst entry) through the master: the frame
arriving on the second slave's peer has its MAC header stripped.  The
shared-headroom write needs a packet tap on the master so the skb is
cloned before teql_master_xmit().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260824115928.4099988-1-victor@mojatatu.com
Link: https://lore.kernel.org/netdev/20260824115928.4099988-1-victor@mojatatu.com/
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_teql.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 409ce50cc0db..acd03f9afc6b 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -245,7 +245,7 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 static int
 __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	       struct net_device *dev, struct netdev_queue *txq,
-	       struct dst_entry *dst)
+	       struct dst_entry *dst, int *hlen)
 {
 	struct neighbour *n;
 	int err = 0;
@@ -265,15 +265,28 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	}
 
 	if (neigh_event_send(n, skb_res) == 0) {
+		int off = skb_network_offset(skb);
 		char haddr[MAX_ADDR_LEN];
 
 		neigh_ha_snapshot(haddr, n, dev);
+		/* The skb may be shared (e.g. a packet tap clone); make the
+		 * headroom private before dev_hard_header() writes into it.
+		 */
+		if (skb_cow_head(skb, LL_RESERVED_SPACE(dev)) < 0) {
+			err = -ENOMEM;
+			goto out;
+		}
 		if (dev_hard_header(skb, dev, ntohs(skb_protocol(skb, false)),
 				    haddr, NULL, skb->len) < 0)
 			err = -EINVAL;
+		/* The header, if any, is prepended above skb->data, so the
+		 * network offset grew by exactly the bytes to undo later.
+		 */
+		*hlen = skb_network_offset(skb) - off;
 	} else {
 		err = (skb_res == NULL) ? -EAGAIN : 1;
 	}
+out:
 	neigh_release(n);
 	return err;
 }
@@ -281,11 +294,13 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 static inline int teql_resolve(struct sk_buff *skb,
 			       struct sk_buff *skb_res,
 			       struct net_device *dev,
-			       struct netdev_queue *txq)
+			       struct netdev_queue *txq,
+			       int *hlen)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	int res;
 
+	*hlen = 0;
 	if (rcu_access_pointer(txq->qdisc) == &noop_qdisc)
 		return -ENODEV;
 
@@ -293,7 +308,7 @@ static inline int teql_resolve(struct sk_buff *skb,
 		return 0;
 
 	rcu_read_lock();
-	res = __teql_resolve(skb, skb_res, dev, txq, dst);
+	res = __teql_resolve(skb, skb_res, dev, txq, dst, hlen);
 	rcu_read_unlock();
 
 	return res;
@@ -305,6 +320,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct Qdisc *start, *q;
 	int busy;
 	int nores;
+	int hlen;
 	int subq = skb_get_queue_mapping(skb);
 	struct sk_buff *skb_res = NULL;
 
@@ -332,7 +348,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			continue;
 		}
 
-		switch (teql_resolve(skb, skb_res, slave, slave_txq)) {
+		switch (teql_resolve(skb, skb_res, slave, slave_txq, &hlen)) {
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
@@ -374,8 +390,14 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 			nores = 1;
 			break;
 		}
+		/* Undo only the header teql_resolve() pushed for this slave.
+		 * Pulling skb_network_offset() instead would strip a
+		 * userspace-supplied header when the slave added none, e.g.
+		 * an AF_PACKET/SOCK_RAW frame with no dst entry.
+		 */
+		if (hlen > 0)
+			__skb_pull(skb, hlen);
 		skb->dev = dev;
-		__skb_pull(skb, skb_network_offset(skb));
 	} while ((q = rcu_dereference(NEXT_SLAVE(q))) != start);
 
 	if (nores && skb_res == NULL) {
-- 
2.43.0

