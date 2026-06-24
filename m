Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140882517AF
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340834; cv=none; b=YOqbxbHa+jrf/jPR5Knv8EnX4wQij+3AuCwEjBnMOpMjJjPcMRsATuaNIiKZIfWSRmmMBToBf9dTnLxMpfbDEj7TJ7DcnaZQLU2FKCYmctcCCQsNqXW6+tj5Rf8HNo7rd8CkkWnP23IEBizHFIameF7ZMuq6a9MFZPbZEiE8Lrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340834; c=relaxed/simple;
	bh=3wihXAlk2zqaiyMnQua880sT4ShZNok22VdcJu+m0Vs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=goKKUmLzD3bisoxXjtbE3mZ0x0Uw02jMfZNDiAtKixAyVsRJxb2/Q/8stj/y+S2iB7gJFn5/kQSkmhrBqTh19QCQZes6Q1ThVoEUOn00MH8uPEFubd30eZYxaUtyzB2tGfSANSCx0m0g8iFTV+xA+xDVlHDhbeI7J9mmeVf32+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=T6whi/rI; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="T6whi/rI"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51a019e9ea9so15420731cf.2
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 15:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782340831; x=1782945631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ShrCq9N2eaWr2Eu4mW42vOQni+stuP9/ZUI2U6Tccg=;
        b=T6whi/rIJZWa2iezkGHCJbqQAFzuohrsq6O/4iIfKOcnzzlwhT6352+N2rjFdPYJ+5
         KXMhpcCIWFjcprVjNV8Pc3zZe8ZV2+9kjfl8AsxoB3YvcOU2b2Q2sOzwNUfUg98tHXYv
         Fi07mMk1FltdpighYl0e217hz5gf3UblWhxGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782340831; x=1782945631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ShrCq9N2eaWr2Eu4mW42vOQni+stuP9/ZUI2U6Tccg=;
        b=XthS99zeChtGomQXOM4NAtqhXW0tQ7AsrUg1yFgD1Y0hBVokvaQvCugmTlClrSL1dJ
         DTSR1bc4HX797/Cst+X+L8M4JaS1kP8PKEbIlakVjO94RMo5V/pV4Ebbns4EVGJRTvXb
         4WZAPU2DsK6hnstP2SLrlajsbKedTYNEP5R8H9sbxOqTdbgW1M3vBxSTRDXvOI/uENeD
         +eRgrMxE9L0xpTCqwAslGxeilmXMtkoYWkTbKbMXLsGGU6V0bBr2aHdlNZS32FSXCoIf
         is7vJmRKi36CdAtwioLmR/3qwnVXE4SxucrAsY1NjMD7N1A0FdYcRr3j8YgI1rqSVzAt
         3f5w==
X-Forwarded-Encrypted: i=1; AFNElJ+NdJTUvofOrwM7AV7j9pOQiv83m1H7ko2uLuHFTu6CoTtHqvcAw8QcLH51c8kmbbpRaKL5WJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTT08qF4kJNEGA3+3mxFmlJVGn7FGEmoaot0cSNG2+Alv0kQYE
	0RXpPZPnNbTIAF7/JXzZquykKoUiEKAmi6WOg0wiM2B8is6ybLbdZO86il60UGPZQw==
X-Gm-Gg: AfdE7cnF1qHoObLI1GMGZX4WAKbPR12FetvpzlNnYtrRcNUdzjnPuF//PiFbH/ZkOhL
	wlqeyQB5V4CYVxuLRPOY7MFnFo/qTvUiqia7vQm+rtQWl4HsbWaXegQdFiAAdqkxKXsztFVdiuN
	47uNmde9+X+OVoDPQpBPWvN0kskvN3UNppuXzgZZXYbfE6dSGmVIgthBoEiiviu/ZCNBMJh/VC0
	d7VdLekOxOx0JXaru8fWPWmM4vOBApiusqCNoo60r1hwclB+eY3kpCGMsgLWTwJdoQntzPPbI7i
	loW2Usl0RpqjRIEi8ZfpK5dELmyfRpnmt+sb96TTR7EswaI0D6B9Mp+X5kZLk6eAcuRhSzvXhIv
	d/+SljN7vN2Hv683JFn71hylk1WEGrxRCuRUIEIMJwnTl6LAEpkuE4rzR9GjP9HxZHypqGEPI7/
	Z41xHeWg==
X-Received: by 2002:ac8:5f88:0:b0:509:3cd:b22f with SMTP id d75a77b69052e-51a0675f987mr308710821cf.23.1782340830694;
        Wed, 24 Jun 2026 15:40:30 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8e231613af9sm104838306d6.38.2026.06.24.15.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 15:40:29 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	victor@mojatatu.com,
	security@kernel.org,
	zdi-disclosures@trendmicro.com,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net v2 1/1] net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF
Date: Wed, 24 Jun 2026 18:40:16 -0400
Message-Id: <20260624224016.24018-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The teql master->slaves singly linked list is not protected against
multiple writes. It can be mod'ed concurently from teql_master_xmit(),
teql_dequeue(), teql_init() and teql_destroy() without holding any list
lock or RCU protection.

zdi-disclosures@trendmicro.com has demonstrated that the qdisc is freed
after an RCU grace period, but teql_master_xmit() running on another
CPU can still hold a stale pointer into the list, resulting in a
slab-use-after-free:

BUG: KASAN: slab-use-after-free in teql_destroy+0x3ca/0x440 linux/net/sched/sch_teql.c:142
Read of size 8 at addr ffff88802923aa80 by task ip/10024

The zdi-disclosures@trendmicro.com repro created concurrent AF_PACKET
senders on a teql device against a thread that repeatedly adds/deletes the
slave qdisc, together with a SLUB spray that reclaims the freed slot; the
resulting UAF is controllable enough to be turned into a read/write
primitive against the freed qdisc object.

The fix?
Add a per-master slaves_lock spinlock that serializes all mutations of
master->slaves and the NEXT_SLAVE() links in teql_destroy() and
teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock
around those updates.
Annotate master->slaves and the per-slave ->next pointer with __rcu and
use the appropriate RCU accessors everywhere they are touched:
rcu_assign_pointer() on the writer side (under slaves_lock),
rcu_dereference_protected() for the writer-side loads (also under
slaves_lock), rcu_dereference_bh() for the loads in teql_master_xmit() and
rtnl_dereference() for the loads in teql_master_open()/teql_master_mtu(),
which run under RTNL.
Pair this with rcu_read_lock_bh()/rcu_read_unlock_bh() around the list
traversal in teql_master_xmit(), so that readers either observe a fully
linked list or are deferred until the in-flight mutation completes. The two
early-return paths in teql_master_xmit() are updated to release the RCU-bh
read-side critical section before returning, since leaving it held would
disable BH on that CPU for good.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: zdi-disclosures@trendmicro.com
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202606241501.XQBMu4b8-lkp@intel.com/
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
Changes in v2:
Address sparse issues found by kernel test robot <lkp@intel.com>
 - rcu annotated struct teql_master->slaves and struct teql_sched_data->next
 - teql_destroy/teql_qdisc_init: replace all READ/WRITE_ONCE() with rcu_dereference_protected()/rcu_assign_pointer()
---
 net/sched/sch_teql.c | 119 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 39 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index e7bbc9e5174d..f4654f1b1200 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -52,7 +52,8 @@
 struct teql_master {
 	struct Qdisc_ops qops;
 	struct net_device *dev;
-	struct Qdisc *slaves;
+	struct Qdisc __rcu	*slaves;
+	spinlock_t		slaves_lock;	/* serializes writes to ->slaves */
 	struct list_head master_list;
 	unsigned long	tx_bytes;
 	unsigned long	tx_packets;
@@ -61,7 +62,7 @@ struct teql_master {
 };
 
 struct teql_sched_data {
-	struct Qdisc *next;
+	struct Qdisc __rcu	*next;
 	struct teql_master *m;
 	struct sk_buff_head q;
 };
@@ -101,7 +102,9 @@ teql_dequeue(struct Qdisc *sch)
 	if (skb == NULL) {
 		struct net_device *m = qdisc_dev(q);
 		if (m) {
-			dat->m->slaves = sch;
+			spin_lock_bh(&dat->m->slaves_lock);
+			rcu_assign_pointer(dat->m->slaves, sch);
+			spin_unlock_bh(&dat->m->slaves_lock);
 			netif_wake_queue(m);
 		}
 	} else {
@@ -132,34 +135,49 @@ teql_destroy(struct Qdisc *sch)
 	struct Qdisc *q, *prev;
 	struct teql_sched_data *dat = qdisc_priv(sch);
 	struct teql_master *master = dat->m;
+	struct netdev_queue *txq = NULL;
+	bool reset_master_queue = false;
 
 	if (!master)
 		return;
 
-	prev = master->slaves;
+	spin_lock_bh(&master->slaves_lock);
+	prev = rcu_dereference_protected(master->slaves,
+					 lockdep_is_held(&master->slaves_lock));
 	if (prev) {
 		do {
-			q = NEXT_SLAVE(prev);
-			if (q == sch) {
-				NEXT_SLAVE(prev) = NEXT_SLAVE(q);
-				if (q == master->slaves) {
-					master->slaves = NEXT_SLAVE(q);
-					if (q == master->slaves) {
-						struct netdev_queue *txq;
-
-						txq = netdev_get_tx_queue(master->dev, 0);
-						master->slaves = NULL;
-
-						dev_reset_queue(master->dev,
-								txq, NULL);
-					}
-				}
-				skb_queue_purge(&dat->q);
-				break;
+			struct Qdisc *head, *next;
+
+			q = rcu_dereference_protected(NEXT_SLAVE(prev),
+						      lockdep_is_held(&master->slaves_lock));
+			if (q != sch) {
+				prev = q;
+				continue;
 			}
 
-		} while ((prev = q) != master->slaves);
+			next = rcu_dereference_protected(NEXT_SLAVE(q),
+							 lockdep_is_held(&master->slaves_lock));
+			rcu_assign_pointer(NEXT_SLAVE(prev), next);
+
+			head = rcu_dereference_protected(master->slaves,
+							 lockdep_is_held(&master->slaves_lock));
+			if (q == head) {
+				rcu_assign_pointer(master->slaves, next);
+				if (q == next) {
+					txq = netdev_get_tx_queue(master->dev, 0);
+					rcu_assign_pointer(master->slaves, NULL);
+					reset_master_queue = true;
+				}
+			}
+			skb_queue_purge(&dat->q);
+			break;
+		} while (prev != rcu_dereference_protected(master->slaves,
+							   lockdep_is_held(&master->slaves_lock)));
 	}
+	spin_unlock_bh(&master->slaves_lock);
+
+	if (reset_master_queue)
+		dev_reset_queue(master->dev, txq, NULL);
 }
 
 static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
@@ -168,6 +186,7 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 	struct net_device *dev = qdisc_dev(sch);
 	struct teql_master *m = (struct teql_master *)sch->ops;
 	struct teql_sched_data *q = qdisc_priv(sch);
+	struct Qdisc *first;
 
 	if (dev->hard_header_len > m->dev->hard_header_len)
 		return -EINVAL;
@@ -184,7 +203,9 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 
 	skb_queue_head_init(&q->q);
 
-	if (m->slaves) {
+	spin_lock_bh(&m->slaves_lock);
+	first = rcu_dereference_protected(m->slaves, lockdep_is_held(&m->slaves_lock));
+	if (first) {
 		if (m->dev->flags & IFF_UP) {
 			if ((m->dev->flags & IFF_POINTOPOINT &&
 			     !(dev->flags & IFF_POINTOPOINT)) ||
@@ -192,8 +213,10 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 			     !(dev->flags & IFF_BROADCAST)) ||
 			    (m->dev->flags & IFF_MULTICAST &&
 			     !(dev->flags & IFF_MULTICAST)) ||
-			    dev->mtu < m->dev->mtu)
+			    dev->mtu < m->dev->mtu) {
+				spin_unlock_bh(&m->slaves_lock);
 				return -EINVAL;
+			}
 		} else {
 			if (!(dev->flags&IFF_POINTOPOINT))
 				m->dev->flags &= ~IFF_POINTOPOINT;
@@ -204,14 +227,17 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 			if (dev->mtu < m->dev->mtu)
 				m->dev->mtu = dev->mtu;
 		}
-		q->next = NEXT_SLAVE(m->slaves);
-		NEXT_SLAVE(m->slaves) = sch;
+		rcu_assign_pointer(q->next,
+				   rcu_dereference_protected(NEXT_SLAVE(first),
+							     lockdep_is_held(&m->slaves_lock)));
+		rcu_assign_pointer(NEXT_SLAVE(first), sch);
 	} else {
-		q->next = sch;
-		m->slaves = sch;
+		rcu_assign_pointer(q->next, sch);
+		rcu_assign_pointer(m->slaves, sch);
 		m->dev->mtu = dev->mtu;
 		m->dev->flags = (m->dev->flags&~FMASK)|(dev->flags&FMASK);
 	}
+	spin_unlock_bh(&m->slaves_lock);
 	return 0;
 }
 
@@ -285,7 +311,9 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 	int subq = skb_get_queue_mapping(skb);
 	struct sk_buff *skb_res = NULL;
 
-	start = master->slaves;
+	rcu_read_lock_bh();
+
+	start = rcu_dereference_bh(master->slaves);
 
 restart:
 	nores = 0;
@@ -317,10 +345,14 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				    netdev_start_xmit(skb, slave, slave_txq, false) ==
 				    NETDEV_TX_OK) {
 					__netif_tx_unlock(slave_txq);
-					master->slaves = NEXT_SLAVE(q);
+					spin_lock_bh(&master->slaves_lock);
+					rcu_assign_pointer(master->slaves,
+							   rcu_dereference_bh(NEXT_SLAVE(q)));
+					spin_unlock_bh(&master->slaves_lock);
 					netif_wake_queue(dev);
 					master->tx_packets++;
 					master->tx_bytes += length;
+					rcu_read_unlock_bh();
 					return NETDEV_TX_OK;
 				}
 				__netif_tx_unlock(slave_txq);
@@ -329,14 +361,18 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				busy = 1;
 			break;
 		case 1:
-			master->slaves = NEXT_SLAVE(q);
+			spin_lock_bh(&master->slaves_lock);
+			rcu_assign_pointer(master->slaves,
+					   rcu_dereference_bh(NEXT_SLAVE(q)));
+			spin_unlock_bh(&master->slaves_lock);
+			rcu_read_unlock_bh();
 			return NETDEV_TX_OK;
 		default:
 			nores = 1;
 			break;
 		}
 		__skb_pull(skb, skb_network_offset(skb));
-	} while ((q = NEXT_SLAVE(q)) != start);
+	} while ((q = rcu_dereference_bh(NEXT_SLAVE(q))) != start);
 
 	if (nores && skb_res == NULL) {
 		skb_res = skb;
@@ -345,29 +381,32 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	if (busy) {
 		netif_stop_queue(dev);
+		rcu_read_unlock_bh();
 		return NETDEV_TX_BUSY;
 	}
 	master->tx_errors++;
 
 drop:
 	master->tx_dropped++;
+	rcu_read_unlock_bh();
 	dev_kfree_skb(skb);
 	return NETDEV_TX_OK;
 }
 
 static int teql_master_open(struct net_device *dev)
 {
-	struct Qdisc *q;
+	struct Qdisc *q, *first;
 	struct teql_master *m = netdev_priv(dev);
 	int mtu = 0xFFFE;
 	unsigned int flags = IFF_NOARP | IFF_MULTICAST;
 
-	if (m->slaves == NULL)
+	first = rtnl_dereference(m->slaves);
+	if (!first)
 		return -EUNATCH;
 
 	flags = FMASK;
 
-	q = m->slaves;
+	q = first;
 	do {
 		struct net_device *slave = qdisc_dev(q);
 
@@ -389,7 +428,7 @@ static int teql_master_open(struct net_device *dev)
 			flags &= ~IFF_BROADCAST;
 		if (!(slave->flags&IFF_MULTICAST))
 			flags &= ~IFF_MULTICAST;
-	} while ((q = NEXT_SLAVE(q)) != m->slaves);
+	} while ((q = rtnl_dereference(NEXT_SLAVE(q))) != first);
 
 	m->dev->mtu = mtu;
 	m->dev->flags = (m->dev->flags&~FMASK) | flags;
@@ -417,14 +456,15 @@ static void teql_master_stats64(struct net_device *dev,
 static int teql_master_mtu(struct net_device *dev, int new_mtu)
 {
 	struct teql_master *m = netdev_priv(dev);
-	struct Qdisc *q;
+	struct Qdisc *q, *first;
 
-	q = m->slaves;
+	first = rtnl_dereference(m->slaves);
+	q = first;
 	if (q) {
 		do {
 			if (new_mtu > qdisc_dev(q)->mtu)
 				return -EINVAL;
-		} while ((q = NEXT_SLAVE(q)) != m->slaves);
+		} while ((q = rtnl_dereference(NEXT_SLAVE(q))) != first);
 	}
 
 	WRITE_ONCE(dev->mtu, new_mtu);
@@ -444,6 +484,7 @@ static __init void teql_master_setup(struct net_device *dev)
 	struct teql_master *master = netdev_priv(dev);
 	struct Qdisc_ops *ops = &master->qops;
 
+	spin_lock_init(&master->slaves_lock);
 	master->dev	= dev;
 	ops->priv_size  = sizeof(struct teql_sched_data);
 
