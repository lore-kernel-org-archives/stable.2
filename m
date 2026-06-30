Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13539D6DD
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813751; cv=none; b=G+z0jy0iEtgtuYgWwrK8Lck36oZ78DCBoG+9dCYwKNYKZWa3nZLAoGZxFsEbIo+IVkuE9CrURcg5cnIIsV/5jIhLqaRV5tj/JVTxaGyTm/rtA4tSuUXQt6nrTE3wbAh9E15JIVr7DdDcSP6irv544DBC6cxVHhoyNzCMF8ganBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813751; c=relaxed/simple;
	bh=GJq2E5RtcINyuVAe4LEpXzR2QGu/iGyxrXpSGhX+uqI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KX6nS862AY13MPXtfTAAGwPzLXJWX0NbS96/4TKDlX85JN1Dh9XOdwR1pRLMss/0DFSlXyaMmHK87zZLG3lPF8kuKa5TR7UHbd+I3f9V7W1VW/pw6I2aDgXEtwjqUPaJtYNa8V6gXtE+dw8gUFKI9YmrPPBTZAP0Xs9mNC75PVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=eiVMczwd; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="eiVMczwd"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e5d6f35c1so167554985a.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 03:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782813748; x=1783418548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mDB6j8GEQGpPqyWMbgbz3OacXzjTFH+gXa6rpvIbRNc=;
        b=eiVMczwdRxctD+LROC9lo32HKuOxj7ThriLb3zyytIc5dVZc8lIYw+q3Mt0ydEgZTU
         YoLyNg1ZtmEWntRB8X5st9Kx2BkTsLrVCdAfOg2UR3K6MSA3CWMGlfLRS+qnUYOGIrpo
         4NJrdMgZvh8EF/Uv3fcUwynCSaYK/ggeFVyKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813748; x=1783418548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDB6j8GEQGpPqyWMbgbz3OacXzjTFH+gXa6rpvIbRNc=;
        b=BwXQrOCN1F2fXjFllEzHZzaaLHcb/06zRl+emiF36VaB6/ljW9Zf9DWusyMplSbJbs
         R6m2LS7uhU2zyczInbm7Wkn5WHfUaUmp1ZPBFXiWN7i9F/yYAQi19uhPHW3l50TMJl/G
         9eF1xqoJ0IfCW80ogmx8Mnx6eD2aM7Rs1TxgVR7Eh6zlwQEcQ4gotfl8lNsH9lz/336I
         dE0Lf12maQ3+/TvE7K2qoUr6Ec+T9RAfpswBR5AEYEqOmIuxETmh/covtORYJbSbi8hr
         oBl7nBBNcVtf+dy24uejHkU8FDXq1gZig8wcwEbavHDRS6+uQp9UOoArw/mHrNgB42YK
         W18g==
X-Forwarded-Encrypted: i=1; AFNElJ8KcdpW8s2MsnsOw/ikUUdeVBdz2jxGJtl1fh83nDHKBmuYPVyahvwUpTPYx23wn87KtTrblFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZw0RnjLLfSBL8q01y0RA55mO/wffP+wYhRAvx7h0XaK+xPL/4
	8UVdAp752XpRbA/xnjFIUgIdgdIm3/jnq+Wy/SU6kpPINde34DKCwux16/HxQDqyww==
X-Gm-Gg: AfdE7cm7lZ7TVV+xubqOf/bbTNl7cVb+D+CB1BFNAoZBWzHThT5/lFLdhBO5OxUk6Y6
	Qwawx1IMvBNPTsJi7okAX0HjeQEQijle73LcfpWCfVLBRRhGVEO9UzQo4nIytabzDBJKRiwrU9F
	ggdGdYZACixjJxhrgsgrBnGJ07P4XIPAGQ1SfGEhPo/ss+cK1Gi95NkWV8iOXTmTWt+HdkiF+P7
	XRgSYJxPNJR3VbjiGKlWi0aN3TCulsU3frqxOFYnD997UHCKZStsy09FZymoMBWyLBPiA3aFnsd
	Tcc5TZuMz3eDdHXL0GiRM0KLaiJkmPflz84lxL+1BUgC8C2oKHZFi4HzNeHhtXdWmiuxvG+bE7w
	j+yNcYf0Nmi3Y7PndXXU29ASKDub4uH9JlYP2l0A/kuwODNykPcZYvfaCdyq6UzknyPkVUUTHlp
	bV7EDZwUMsOC3qtvqV
X-Received: by 2002:a05:620a:6193:b0:92e:6cd4:5892 with SMTP id af79cd13be357-92e6d859ad7mr3004885a.40.1782813747464;
        Tue, 30 Jun 2026 03:02:27 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6213b95esm205893585a.5.2026.06.30.03.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:02:26 -0700 (PDT)
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
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v4 1/1] net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF
Date: Tue, 30 Jun 2026 06:02:07 -0400
Message-Id: <20260630100207.132250-1-jhs@mojatatu.com>
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
slaves_lock), rcu_dereference() for the loads in teql_master_xmit() and
rtnl_dereference() for the loads in teql_master_open()/teql_master_mtu(),
which run under RTNL.
Pair this with rcu_read_lock()/rcu_read_unlock() around the list
traversal in teql_master_xmit(), so that readers either observe a fully
linked list or are deferred until the in-flight mutation completes. The two
early-return paths in teql_master_xmit() are updated to release the RCU
read-side critical section before returning, since leaving it held would
keep the CPU in an RCU read-side critical section for good.

On feedback from Sashiko[1]: The core network stack already invokes
ndo_start_xmit with BH disabled, so plain rcu_read_lock() and spin_lock()
suffice in the transmit path and avoid the in_hardirq() warnings that
rcu_read_unlock_bh()/spin_unlock_bh() would trigger when xmit is reached
through netpoll or a softirq xmit path with hard IRQs disabled.

[1]https://sashiko.dev/#/patchset/20260628111229.669751-1-jhs%40mojatatu.com

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: zdi-disclosures@trendmicro.com
Tested-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: Jamal Hadi Salim <jhs@mojatatu.com> 
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v2->v3
1) Thanks to Simon's persistence:
 The writeback in teql_master_xmit() should not blindly write NEXT_SLAVE(q)
 into master->slaves. It should re-read master->slaves under slaves_lock and
 only update it if q is still the current head
2) Appease sashiko by mentioning teql_dequeue() on the commit and ensuring
 consistency on rcu_dereference_bh()/rcu_dereference_protected()

v3->v4 (feedback from sashiko[1])
1) Use plain rcu_read_lock()/spin_lock() in teql_master_xmit() instead of
 the _bh variants, since ndo_start_xmit is already invoked with BH
 disabled by the core stack and the _bh primitives can warn in_hardirq()
 when xmit is reached through netpoll or a softirq xmit path with hard
 IRQs disabled.
2) Fix pre-existing condition:
 The list traversal in teql_master_xmit() no longer caches "start"
 as the loop sentinel. If teql_destroy() concurrently unlinks that
 node we end up in soft/hard lockup. To resolve, re-read master->slaves
 at each iteration and terminate when q wraps around to the
 current head or the list becomes empty.

 [1]https://sashiko.dev/#/patchset/20260628111229.669751-1-jhs%40mojatatu.com
---

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index e7bbc9e5174d..ff0f712b8246 100644
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
 
@@ -279,19 +305,19 @@ static inline int teql_resolve(struct sk_buff *skb,
 static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct teql_master *master = netdev_priv(dev);
-	struct Qdisc *start, *q;
+	struct Qdisc *q, *head;
 	int busy;
 	int nores;
 	int subq = skb_get_queue_mapping(skb);
 	struct sk_buff *skb_res = NULL;
 
-	start = master->slaves;
-
-restart:
+ restart:
 	nores = 0;
 	busy = 0;
 
-	q = start;
+	rcu_read_lock();
+
+	q = rcu_dereference(master->slaves);
 	if (!q)
 		goto drop;
 
@@ -317,10 +343,17 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				    netdev_start_xmit(skb, slave, slave_txq, false) ==
 				    NETDEV_TX_OK) {
 					__netif_tx_unlock(slave_txq);
-					master->slaves = NEXT_SLAVE(q);
+					spin_lock(&master->slaves_lock);
+					if (rcu_dereference_protected(master->slaves,
+								      lockdep_is_held(&master->slaves_lock)) == q)
+						rcu_assign_pointer(master->slaves,
+								   rcu_dereference_protected(NEXT_SLAVE(q),
+											     lockdep_is_held(&master->slaves_lock)));
+					spin_unlock(&master->slaves_lock);
 					netif_wake_queue(dev);
 					master->tx_packets++;
 					master->tx_bytes += length;
+					rcu_read_unlock();
 					return NETDEV_TX_OK;
 				}
 				__netif_tx_unlock(slave_txq);
@@ -329,45 +362,58 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				busy = 1;
 			break;
 		case 1:
-			master->slaves = NEXT_SLAVE(q);
+			spin_lock(&master->slaves_lock);
+			if (rcu_dereference_protected(master->slaves,
+						      lockdep_is_held(&master->slaves_lock)) == q)
+				rcu_assign_pointer(master->slaves,
+						   rcu_dereference_protected(NEXT_SLAVE(q),
+									     lockdep_is_held(&master->slaves_lock)));
+			spin_unlock(&master->slaves_lock);
+			rcu_read_unlock();
 			return NETDEV_TX_OK;
 		default:
 			nores = 1;
 			break;
 		}
 		__skb_pull(skb, skb_network_offset(skb));
-	} while ((q = NEXT_SLAVE(q)) != start);
+		q = rcu_dereference(NEXT_SLAVE(q));
+		head = rcu_dereference(master->slaves);
+	} while (q && head && q != head);
 
 	if (nores && skb_res == NULL) {
 		skb_res = skb;
+		rcu_read_unlock();
 		goto restart;
 	}
 
 	if (busy) {
 		netif_stop_queue(dev);
+		rcu_read_unlock();
 		return NETDEV_TX_BUSY;
 	}
 	master->tx_errors++;
 
 drop:
 	master->tx_dropped++;
+	rcu_read_unlock();
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
 
@@ -389,7 +435,7 @@ static int teql_master_open(struct net_device *dev)
 			flags &= ~IFF_BROADCAST;
 		if (!(slave->flags&IFF_MULTICAST))
 			flags &= ~IFF_MULTICAST;
-	} while ((q = NEXT_SLAVE(q)) != m->slaves);
+	} while ((q = rtnl_dereference(NEXT_SLAVE(q))) != first);
 
 	m->dev->mtu = mtu;
 	m->dev->flags = (m->dev->flags&~FMASK) | flags;
@@ -417,14 +463,15 @@ static void teql_master_stats64(struct net_device *dev,
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
@@ -444,6 +491,7 @@ static __init void teql_master_setup(struct net_device *dev)
 	struct teql_master *master = netdev_priv(dev);
 	struct Qdisc_ops *ops = &master->qops;
 
+	spin_lock_init(&master->slaves_lock);
 	master->dev	= dev;
 	ops->priv_size  = sizeof(struct teql_sched_data);
 
