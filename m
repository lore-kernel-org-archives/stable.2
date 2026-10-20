Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492715;
	b=YhQ1z/YNExuCABkXO4ol7M6OdpHOd5PFZnJfVvxQpizcFGD8RH9aZMxwDr/fJ5ZV0Zzb
	 4GLmeTZPuHYPLE/xMWoC7m4vKzZjFJCcYbODwEiauM5MMkeq6YU59g1B20neo8J80y+mb
	 eHf5BXSdbSI7icwdJPQtx34SbSoqNv82r7HcVjzNH9WRmI9qJLPePnArhB6I1UtPEOvyV
	 zkRRb6BCXTRPWPSJAS5eiB1tsPhdtfTuof+5kp5rktKqJHfHTARMedfV3mZb94BOQAMZt
	 u+gxRrOMfTjqV4zCJBGGazGfaZsTsgmHQMnjEk3OQ6Y/Uc95FuksavAxUzNT8Jy6d+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fzChrc19jcQoCQovxW6S7a9HWkv0j2zGCifMcuBL9m8=;
	b=2Aqq4fXS+pujmYvl5dckQ2ILNWGxjjYbGpJr8rNstUDLm6cN18dibfkYyS2cWulwKFAH
	 eGmq7X8JptKToW8dZbw3aXZGAhwdkeiI5Qu/vEgTfLU93bk7eQ9zr/4wE0uErKTc/KVHl
	 L3xvFguJs0g6/0GAKCQKLxdxW8raJQ6Rw7SU65J225pIBMkCxlgqaT2RuvHw3WkJQjVw1
	 mmby3gYKf+kG+M69zwSQx3nMVx9M7aUbTKY47ff8v89Cu4cYhawXAP090SjfVQNtjO/5i
	 bS0VvSCVjGwOf3VyMD7mQd40W5ZgLThx8zpzYNgArS/0X8A1L80LiHnoYv9LUnY5OBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=whbZwAFJ;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876C6606A31C
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 876C6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=whbZwAFJ
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e7ad9f78dso348368685a.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792492713; x=1793097513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzChrc19jcQoCQovxW6S7a9HWkv0j2zGCifMcuBL9m8=;
        b=whbZwAFJq3Zz9ZCqcJlOm970YpraVN0BDNHHlNozw2UAqpjGCUO7hVhi9GjcXFgIfQ
         Kf6jkv55rkNsY7Q7vl/AMHqTuWD63fsXw7GGLfX6nCa4nE5Di1vDec8gZ6kkTxTwGUDn
         0Xd32cbc+CSvmhqYNqH3e3Fz+Aa2IpRvex3zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792492713; x=1793097513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fzChrc19jcQoCQovxW6S7a9HWkv0j2zGCifMcuBL9m8=;
        b=yHn3zBdg9vCJCg42Yl41UmVEr78XZRFzVA027yYpbKqmFYAy92QC25eh+MMlnrTy9T
         HFsuCnuOTe0+e1w+0pV84pxfJNnnLjDQReeOUUOGNVQmoOqjyMo9D8hhmBBV8q/Fgy2S
         byLbdNoo9/oswrpGn5/KK+gvI20N2Sb91EePlLWcq0brecZrec0nucOZbCcUky7w1dCy
         JSSF68g6Mtjp+azH77w4e1gMiiIotbopmKp2WqPwsPL0RWa2XLoULOU2qMMdMnxu4Km6
         t5HuKKts+goyKx438yd6U+M0GESvW+8jaLu+zG5MdcW3YWjEu/2JfiNjICshktfnGMas
         m4Ww==
X-Forwarded-Encrypted: i=1; AKwUvBxHKzTQHLgnK+s1mS4vO1cgeR80rgGBcOxhGpkNwbEg1PsU6SQMWFSQKou+Gubaw4jdOWjKYhM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmVdnbgcMhCBaHU8ekH9ZdDvehMxGwq9Zpu2y+zm5H12doYSc/
	37kmrBKBGmvKdx/6M5BdKhN2Lm6nF41yPcAiCfTf3RhJPLr2Nm+7MpYkrCx0IF0ALg==
X-Gm-Gg: AYBFou2/vk/C42G4/RnR4cWSZ6D6qQ0igLenzuuM1wixZh5Lu5lZ9YlSg3GE01XROYy
	mCwcSMdsUONAy8SO+D3a6+nW2Q0oMvBrmp+5oUzZ1ZcZnMjU4MDvuSkcL+gLPeFiaG0jUAfIx+r
	66bKa/ODT37/R3EQmCiAIChI/upztGVerR4tC6ImIC5PFzaaAC3eupeo2vOqDTQSnslidN0hcLe
	bnXIcw4NqWsS3dFguA7QA50LbQYgA06tIySOg8Z2BjtTnlrGVv2/1JfA8jqmr+tz49NUR+TibL9
	+EwNBU+09K0bsz8J+VyGVXcFUCUAPBh2ma6UhSnI0a1t4P+qp+b2XnkgmbEzrZmsDfHIMOfM/dO
	IT/xdZW/IvwqmNpcLPp4kPhmiy0/MX0+YuFd3b2pjtVDEB26Ko0Zhqqkg3HgL5FEK/8jZlLp8Sx
	9oJAeN4BfQVCWSrt/ggeY7ohRdrQg/sbdsnia3iFZJdM/FEwjuhjxCPhgMlw1SOZEFG9vrseE0I
	UTvGhZoRodhe5D6YurXD9gJ271OMT/9NCl9xNwM3h+2
X-Received: by 2002:a05:620a:7106:b0:93b:db80:e0cf with SMTP id af79cd13be357-93f29db7f0fmr1693123485a.60.1792492713316;
        Tue, 20 Oct 2026 03:38:33 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c040b4915sm23275556d6.26.2026.10.20.03.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:38:32 -0700 (PDT)
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
Subject: [PATCH net 1/2 repost2] net/sched: sch_teql: fix shared headroom and header strip on slave retry
Date: Tue, 20 Oct 2026 06:38:26 -0400
Message-Id: <QDISC-6HS9.v1.r2.20261020051718-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-6HS9.v1.r2.20261020051718@mojatatu.com>
References: <QDISC-6HS9.v1.r2.20261020051718@mojatatu.com>
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

