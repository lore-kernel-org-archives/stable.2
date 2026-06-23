Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC3438B7BA
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240185; cv=none; b=J3kuk3EaJWE53lQfDl+K2+u3mmXKG4ufJ112TlBD/ce96XqjPGCdzcOGYzyBAxWu3O4V5QvcA9Spfz9oe2D8ZX7ywOSDiC8fY77ulqNuiSapBoSoY6qYxzsnuRhpf7wvAUdGrZX3rBt5qcEj2z2NwSzM52R1dUJtmkUIHNR8C+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240185; c=relaxed/simple;
	bh=LSOKCEmbln8Bsiarlr7DAKf9+v6TogPzxqdKe6GZP38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S9KmabW5iS6Cd3BU33hIFmlDPlJOI7ZKCVblpAfkKKmrCzFChWmNEyhO7uG57D3hpVKtf0LwiI849pf2UaBOYZ46/C/OtwJUPy4jxg1JgJAsouh8oE9nNLH6Zmt5JdnKMTwRocdgBnLqAgJQNKGEr0rzaD8x7/uMFHWmqfD/j2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=YXldRTr0; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="YXldRTr0"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-923220bf1d5so10044785a.0
        for <stable@vger.kernel.org>; Tue, 23 Jun 2026 11:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782240181; x=1782844981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oGuAg1NPBYxczoa/cl+Ar/EX4r3MiGf0yGELuct39mo=;
        b=YXldRTr0QAARpn/4tAXDNUsErOa2ie7O3FINAkaT1kxVt/3bTHMz7Al/AUv3uoqOaI
         GCcTFVzIoReMae01kbQrqrEaBHmJH/oBVh9FddGlZRlVV+Ljc6S8aMWGzERHvpHZes+J
         JKT1Na1q1lZe8PVHX/pWIA5vkrpHodo4cLkYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240181; x=1782844981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGuAg1NPBYxczoa/cl+Ar/EX4r3MiGf0yGELuct39mo=;
        b=kAksGaX9RQMjU29g/1neyZZ9a+ES3oaeQ8XHVsHXWB4KlkmxrDl7/mfcc7rXw7GoxK
         y1qtzwz+1FqNUhXa+wKzNdfFARuONGWcA/NZchWkZBQCW5iteR7ld9FXE0+w6FUPRKgN
         bcwoKP8HfRjE1ZuAz9TLw0OEtJskedZVtAbQ+aIIAfJqzO3Q40cOnDc7F3p83AkMCh9d
         R/cfhJf88LqM8Vxw1kE/xS9QXNn8UQyZWkr7r7xdkviLSbcAS7SSafYA9vDfC2vwxZhw
         f69JMuOjqym+OK4KAcjUbZMTXhXAJ7aWi3e355skJcipmtHRlxUjavCOi+z16vwhxOPK
         72lw==
X-Forwarded-Encrypted: i=1; AFNElJ9upSfKh4ypeDD7B3CW2FdOkwImuH4ZThz7W9xhjnmnyfsRp4NwtmS4M52I8lltGPGEYJbA0xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQWlzqa4K0H2B1bqxg1m2u4IopOKBSjG218FLt5FucbySI+e1
	SG9yvy3TltWujQxQToqPjqGA9JxlsbfXvHh9qaT0SSpLPk92mR8vFO2C/lEibK58MA==
X-Gm-Gg: AfdE7clFVolncA4C/GLVDC4EyTRzrTRjDtx/ANEDsMhIeOHfrtdp3ZKbFqSJ0WkdMdM
	4LbHts46HKRigfgZitleacAXWtGwWF7Gt4DbUnaD8VW8U1J/RZZke1ExF2FxP4msaEHhzwVVDQx
	JtxzjdJPKcRxN4BtIdw903vtzflWPqYuGN7YOpzjud6TEUEZt3ECeAu7I9Uh9OcyUOtSAU76HND
	DETh6JfY8ciJAj/4A+mXR/II5KWrt1dyy01CTl7rtSM8h8NTUpigFqRML3Snmaq8H4yDKxkGU1i
	kzU3UKxBmirCsS/aSvZKHVspzJ8fagQUEJyrPgrx6nAfXk4cjBVQFBXwUVoSFXNo5B9yEg6mQxT
	cVegI4RVTI8Ogm7Bqgh+WKVBi4j/Iz9AV83Cb1SJFxKau7fDTwZLDPYTieVuyYLdktQaFJgq7rG
	h+jQCx6A==
X-Received: by 2002:a05:620a:4147:b0:912:a170:265c with SMTP id af79cd13be357-927823ed80emr43125185a.20.1782240181509;
        Tue, 23 Jun 2026 11:43:01 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fda62ef3sm354779285a.16.2026.06.23.11.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 11:43:00 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	victor@mojatatu.com,
	andrew+netdev@lunn.ch,
	zdi-disclosures@trendmicro.com,
	security@kernel.org,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 1/1] net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF
Date: Tue, 23 Jun 2026 14:42:47 -0400
Message-Id: <20260623184247.508956-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The teql master->slaves singly linked list is not protected against multiple
writes. It can be mod'ed concurently from teql_master_xmit(), teql_dequeue(),
teql_init() and teql_destroy() without holding any list lock or RCU protection.

zdi-disclosures@trendmicro.com has demonstrated that the qdisc is freed
after an RCU grace period, but teql_master_xmit() running on another
CPU can still hold a stale pointer into the list, resulting in a
slab-use-after-free:

BUG: KASAN: slab-use-after-free in teql_destroy+0x3ca/0x440 linux/net/sched/sch_teql.c:142
Read of size 8 at addr ffff88802923aa80 by task ip/10024

CPU: 1 UID: 0 PID: 10024 Comm: ip Not tainted 7.1.0-rc5 #1 PREEMPT(lazy)
Hardware name: QEMU Ubuntu 25.10 PC v2 (i440FX + PIIX, + 10.1 machine, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack linux/lib/dump_stack.c:94
 dump_stack_lvl+0x100/0x190 linux/lib/dump_stack.c:120
 print_address_description linux/mm/kasan/report.c:378
 print_report+0x139/0x4ad linux/mm/kasan/report.c:482
 kasan_report+0xe4/0x1d0 linux/mm/kasan/report.c:595
 teql_destroy+0x3ca/0x440 linux/net/sched/sch_teql.c:142
 __qdisc_destroy+0x109/0x540 linux/net/sched/sch_generic.c:1100
 qdisc_put+0xad/0xf0 linux/net/sched/sch_generic.c:1128
 dev_shutdown+0x1cd/0x450 linux/net/sched/sch_generic.c:1493
 unregister_netdevice_many_notify+0xd30/0x24b0 linux/net/core/dev.c:12409
 rtnl_delete_link linux/net/core/rtnetlink.c:3552
 rtnl_dellink+0x476/0xb50 linux/net/core/rtnetlink.c:3594
 rtnetlink_rcv_msg+0x954/0xe80 linux/net/core/rtnetlink.c:6997
 netlink_rcv_skb+0x156/0x420 linux/net/netlink/af_netlink.c:2550
 netlink_unicast_kernel linux/net/netlink/af_netlink.c:1318
 netlink_unicast+0x58d/0x860 linux/net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x89a/0xd80 linux/net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec linux/net/socket.c:787
 __sock_sendmsg linux/net/socket.c:802
 ____sys_sendmsg+0x9d9/0xb70 linux/net/socket.c:2698
 ___sys_sendmsg+0x194/0x1e0 linux/net/socket.c:2752
 __sys_sendmsg+0x171/0x220 linux/net/socket.c:2784
 do_syscall_x64 linux/arch/x86/entry/syscall_64.c:63
 do_syscall_64+0xff/0x890 linux/arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f linux/arch/x86/entry/entry_64.S:121
[..]

The zdi-disclosures@trendmicro.com repro created concurrent AF_PACKET senders
on a teql device against a thread that repeatedly adds/deletes the slave qdisc,
together with a SLUB spray that reclaims the freed slot; the resulting
UAF is controllable enough to be turned into a read/write primitive against the
freed qdisc object.

The fix?
Add a per-master slaves_lock spinlock that serializes all mutations of
master->slaves and the NEXT_SLAVE() links in teql_destroy() and
teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock around
those updates.
Pair this with READ_ONCE()/WRITE_ONCE() on the shared pointers and
rcu_read_lock_bh()/rcu_read_unlock_bh() around the list traversal in
teql_master_xmit() and teql_dequeue(), so that readers either observe a fully
linked list or are deferred until the in-flight mutation completes. The two
early-return paths in teql_master_xmit() are updated to release the RCU-bh
read-side critical section before returning, since leaving it held would disable
BH on that CPU for good.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: zdi-disclosures@trendmicro.com
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_teql.c | 71 +++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index e7bbc9e5174d..dacdc46637df 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -53,6 +53,7 @@ struct teql_master {
 	struct Qdisc_ops qops;
 	struct net_device *dev;
 	struct Qdisc *slaves;
+	spinlock_t		slaves_lock;	/* serializes writes to ->slaves */
 	struct list_head master_list;
 	unsigned long	tx_bytes;
 	unsigned long	tx_packets;
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
@@ -132,34 +135,37 @@ teql_destroy(struct Qdisc *sch)
 	struct Qdisc *q, *prev;
 	struct teql_sched_data *dat = qdisc_priv(sch);
 	struct teql_master *master = dat->m;
+	struct netdev_queue *txq = NULL;
+	bool reset_master_queue = false;
 
 	if (!master)
 		return;
 
-	prev = master->slaves;
+	spin_lock_bh(&master->slaves_lock);
+	prev = READ_ONCE(master->slaves);
 	if (prev) {
 		do {
-			q = NEXT_SLAVE(prev);
+			q = READ_ONCE(NEXT_SLAVE(prev));
 			if (q == sch) {
-				NEXT_SLAVE(prev) = NEXT_SLAVE(q);
-				if (q == master->slaves) {
-					master->slaves = NEXT_SLAVE(q);
-					if (q == master->slaves) {
-						struct netdev_queue *txq;
-
+				WRITE_ONCE(NEXT_SLAVE(prev), READ_ONCE(NEXT_SLAVE(q)));
+				if (q == READ_ONCE(master->slaves)) {
+					WRITE_ONCE(master->slaves, READ_ONCE(NEXT_SLAVE(q)));
+					if (q == READ_ONCE(master->slaves)) {
 						txq = netdev_get_tx_queue(master->dev, 0);
-						master->slaves = NULL;
-
-						dev_reset_queue(master->dev,
-								txq, NULL);
+						WRITE_ONCE(master->slaves, NULL);
+						reset_master_queue = true;
 					}
 				}
 				skb_queue_purge(&dat->q);
 				break;
 			}
 
-		} while ((prev = q) != master->slaves);
+		} while ((prev = q) != READ_ONCE(master->slaves));
 	}
+	spin_unlock_bh(&master->slaves_lock);
+
+	if (reset_master_queue)
+		dev_reset_queue(master->dev, txq, NULL);
 }
 
 static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
@@ -184,7 +190,8 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 
 	skb_queue_head_init(&q->q);
 
-	if (m->slaves) {
+	spin_lock_bh(&m->slaves_lock);
+	if (READ_ONCE(m->slaves)) {
 		if (m->dev->flags & IFF_UP) {
 			if ((m->dev->flags & IFF_POINTOPOINT &&
 			     !(dev->flags & IFF_POINTOPOINT)) ||
@@ -192,8 +199,10 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
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
@@ -204,14 +213,15 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 			if (dev->mtu < m->dev->mtu)
 				m->dev->mtu = dev->mtu;
 		}
-		q->next = NEXT_SLAVE(m->slaves);
-		NEXT_SLAVE(m->slaves) = sch;
+		WRITE_ONCE(q->next, READ_ONCE(NEXT_SLAVE(m->slaves)));
+		rcu_assign_pointer(NEXT_SLAVE(m->slaves), sch);
 	} else {
-		q->next = sch;
-		m->slaves = sch;
+		WRITE_ONCE(q->next, sch);
+		rcu_assign_pointer(m->slaves, sch);
 		m->dev->mtu = dev->mtu;
 		m->dev->flags = (m->dev->flags&~FMASK)|(dev->flags&FMASK);
 	}
+	spin_unlock_bh(&m->slaves_lock);
 	return 0;
 }
 
@@ -285,7 +295,9 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 	int subq = skb_get_queue_mapping(skb);
 	struct sk_buff *skb_res = NULL;
 
-	start = master->slaves;
+	rcu_read_lock_bh();
+
+	start = rcu_dereference_bh(master->slaves);
 
 restart:
 	nores = 0;
@@ -317,10 +329,14 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -329,14 +345,18 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -345,12 +365,14 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 
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
@@ -444,6 +466,7 @@ static __init void teql_master_setup(struct net_device *dev)
 	struct teql_master *master = netdev_priv(dev);
 	struct Qdisc_ops *ops = &master->qops;
 
+	spin_lock_init(&master->slaves_lock);
 	master->dev	= dev;
 	ops->priv_size  = sizeof(struct teql_sched_data);
 
-- 
2.54.0

