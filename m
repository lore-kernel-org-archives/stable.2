Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D6226B764
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782645190; cv=none; b=Nm+wwHrYr5TSjF0gclwc269imt0XnOEGHeeMHaP52/FtjI+RSzt9P9LqvtK91y76QIWTNJFfs3T5d/bFkADCnvoRhl89sfy19Mhvq7nfsm6Ppykc/XtHFA3vwoQeO38FteNu8xmYy4Dt8uaLUxRB16l/O2AF8tYuZQN/zX21/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782645190; c=relaxed/simple;
	bh=/HuH1IYSueDw0bo6V8qM1IOyNOcXxeTGKHvADJLStBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p+wuv7gkUqtZyk992K3rQHCIpwVT5H101AjAv3fMYC3bDfznZBHbALhyYNw40lSatwMcvvUOQTv74Id5SKp9A+8G+FElUVC+8CaGNUnY3sKEXeJjNdFPNFy5xIgcIdTQikJh3vf4O4E8MVWBc+y3e7iQEdCRjqVv28oBKwucZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=te+G3WaV; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="te+G3WaV"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92c7a0a701aso69931585a.3
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 04:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782645187; x=1783249987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3UgPg6DIBbOx8NWbHsuvFVLyMA+HywY5jsKyVEL2lB8=;
        b=te+G3WaVbugoeova3Bn0LZkjsM8Vnswvu1IlSdxTuVi4lyppAsJQHm3D4tEW3gGEhY
         VwOpS5FVhm8z4pkHH4NbSPJIMBrKWWUsv7eqgW7RDj2K2pn7MYD5f0lviygtuWCAdvq8
         /NK2M1+UDlJF7HDpQrbMTdRoK4gmwaI3haTPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782645187; x=1783249987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UgPg6DIBbOx8NWbHsuvFVLyMA+HywY5jsKyVEL2lB8=;
        b=VBJX8bSzTyvMdGzb2Jk5r/wUvayaE2nLs81jerjkFNBqNSC/BN0wB++/QUUgp5J5qr
         gO9M4V9QgrfQI56osOo2SLfcPW4YnsKr5Sn+tHYVJWvUtCma9FRJpXVwth+oBYiRyLfM
         HhmELh5003ZWeAOChf+xBw5GzA4AwMC83xAVuza4TdyJ9+jEO56QQeNk1qDkzv4a7bgi
         kjfxpYBXFU2mtFVnC01sDT5HoIymUnSQy89ZyR8HJsYZt/i5nRPCFS1QlMIBR14cvPNI
         f+j0iDsLe9SPoWN84URRpTYewTh5dlHF0MtBN1TxL4CzJkhGuaRcP2AW/9fmWcEktzVZ
         adbQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3aTjvu7qW/9RCSkZOqXU/nc9Du8hdT77rD7QV8TH2D7Z0dty5/Tnd4ymz8yrQ0ssEiDtap34=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmv7sWDzwp/aGz4dZIxU1QvNt/dLQ4C7fHyIyGKrRxq7+DW5wP
	If3rgwBgWL8a6mwQjB9KmzuvMd18w1S+/4UgO603RGJqQWVPraMd/de6jThMCNEo+Q==
X-Gm-Gg: AfdE7cnlfrGVK6s+pWp4jRdKdibaJSB76d2ALWBM9qEVfIHJ4K2FDX2iXH5/ny0KA05
	+0v/jHBWKek6wYbeP/Zp0PYVdSnW7ATBcmocczaXP8BLrb1XS6sGaJ/a3wTx/W7rrpAShhZZVDN
	kyhF3V9p1dvRLbayN5BbMmZVeF0jPGXfC/0vnefhj+Ngp2atnk0Qvgh9tXQUw82EdWr9jREpb7B
	6B/tXQqSTuoTREDg1v1NH5EfFIz1nI+LmzG+lkLS96gEwecZiSv+VCh7W6t2IwI8wBkx8VwvWMW
	Ln3WEaKBv48xAGfL6cvUShVhuZKzc0P/uo+LuOjJw5X3/0uaFyfcKkpOr0J9qpefMGrT8fs/s9T
	kzAFuICZwPqy4YnHqfUVhx5vDqOYCeav1Ltuht37RXcf9UP7DaeTcVub/QuxRXk7HJ5tYUXz0N4
	F2ObwRVQ==
X-Received: by 2002:a05:620a:45ac:b0:915:cf88:1e26 with SMTP id af79cd13be357-92b3e676792mr974760985a.48.1782645187131;
        Sun, 28 Jun 2026 04:13:07 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926005a2530sm1736607385a.39.2026.06.28.04.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 04:13:05 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	victor@mojatatu.com,
	jiri@resnulli.us,
	security@kernel.org,
	zdi-disclosures@trendmicro.com,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v3 1/1] net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF
Date: Sun, 28 Jun 2026 07:12:29 -0400
Message-Id: <20260628111229.669751-1-jhs@mojatatu.com>
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

BUG: KASAN: slab-use-after-free in teql_master_xmit+0xf0f/0x16b0
Read of size 8 at addr ffff888013fb0440 by task poc/332
Freed 512-byte region [ffff888013fb0400, ffff888013fb0600) (kmalloc-512)

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
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v2->v3
1) Thanks to Simon's persistence:
 The writeback in teql_master_xmit() should not blindly write NEXT_SLAVE(q)
 into master->slaves. It should re-read master->slaves under slaves_lock and
 only update it if q is still the current head
2) Appease sashiko by mentioning teql_dequeue() on the commit and ensuring
 consistency on rcu_dereference_bh()/rcu_dereference_protected()
---

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index e7bbc9e5174d..78c74c1182d7 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -52,7 +52,8 @@
 struct teql_master {
 	struct Qdisc_ops qops;
 	struct net_device *dev;
-	struct Qdisc *slaves;
+	struct Qdisc __rcu	*slaves;
+	spinlock_t		slaves_lock; /* serializes writes to ->slaves */
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
@@ -317,10 +345,17 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				    netdev_start_xmit(skb, slave, slave_txq, false) ==
 				    NETDEV_TX_OK) {
 					__netif_tx_unlock(slave_txq);
-					master->slaves = NEXT_SLAVE(q);
+					spin_lock_bh(&master->slaves_lock);
+					if (rcu_dereference_protected(master->slaves,
+								      lockdep_is_held(&master->slaves_lock)) == q)
+						rcu_assign_pointer(master->slaves,
+								   rcu_dereference_protected(NEXT_SLAVE(q),
+											     lockdep_is_held(&master->slaves_lock)));
+					spin_unlock_bh(&master->slaves_lock);
 					netif_wake_queue(dev);
 					master->tx_packets++;
 					master->tx_bytes += length;
+					rcu_read_unlock_bh();
 					return NETDEV_TX_OK;
 				}
 				__netif_tx_unlock(slave_txq);
@@ -329,14 +364,21 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				busy = 1;
 			break;
 		case 1:
-			master->slaves = NEXT_SLAVE(q);
+			spin_lock_bh(&master->slaves_lock);
+			if (rcu_dereference_protected(master->slaves,
+						      lockdep_is_held(&master->slaves_lock)) == q)
+				rcu_assign_pointer(master->slaves,
+						   rcu_dereference_protected(NEXT_SLAVE(q),
+									     lockdep_is_held(&master->slaves_lock)));
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
@@ -345,29 +387,32 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 
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
 
@@ -389,7 +434,7 @@ static int teql_master_open(struct net_device *dev)
 			flags &= ~IFF_BROADCAST;
 		if (!(slave->flags&IFF_MULTICAST))
 			flags &= ~IFF_MULTICAST;
-	} while ((q = NEXT_SLAVE(q)) != m->slaves);
+	} while ((q = rtnl_dereference(NEXT_SLAVE(q))) != first);
 
 	m->dev->mtu = mtu;
 	m->dev->flags = (m->dev->flags&~FMASK) | flags;
@@ -417,14 +462,15 @@ static void teql_master_stats64(struct net_device *dev,
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
@@ -444,6 +490,7 @@ static __init void teql_master_setup(struct net_device *dev)
 	struct teql_master *master = netdev_priv(dev);
 	struct Qdisc_ops *ops = &master->qops;
 
+	spin_lock_init(&master->slaves_lock);
 	master->dev	= dev;
 	ops->priv_size  = sizeof(struct teql_sched_data);
 
