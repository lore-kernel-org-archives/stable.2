Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700635;
	b=g2a03mRPrAyYClCSxJYR1cct7lHMIbx4kLjNut5YPAxgt+fnEVHYiBj7TrFx3CnXrcKq
	 NKGZGfAuxNR94+0gpWwj9TFZVJlqJUwT2jeZeF9LBcSwYDq0qAtbmRgB3rS1exhd8Jave
	 Tj/hHF2wpY4lVqa3kzg7hIzUJ9IsJ3chXBfrdiEjlqU/QZbT35qQQtTMN8tgl/Ltivg/X
	 GRJWokVbsCPrtQ0i4Ulw/XMKTeA7gQWALHhbZTcHAh5R8c/1mumIR4+5oFq6JS7ABy8qh
	 LWMR9ba4tM/mY+wZEPmHVGahWiB25vsJ90iFZ1ZFJOWLbSyTs4OOIdw5wnBC+JKMmmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700635;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=n/a95moMhTo2V1bhlqxFOojiRsUuFnaNeAtgD+c7R2g=;
	b=uL035YyY8IPnjDoaK4I3QZkl/UfqWTlEHuoDzoEHZ/UfWcqMMzU/SKfd4oEnZ5QjKBxs
	 MPdx8gKmh++bcXw4onc1bfj3zWJUNu37oW0WPuaPuicTydmpBzEtWq9tpjZymhlpIuOhT
	 k5Yx4wAqie2fvD3XxBxuGmdr7LdTFcPortooWJ+2pvsdPnWqbQbAx98ja2TIaJ+FtMsoa
	 S3kbLXjGX4Br3aM1AuIjneu7ekXpPt9jCKz35o1rTa0HUOe24gpx8BVcm5NI1U+w1ZxPn
	 pDU7ewAIEhlehGJFm5pwPO25bdPVE2wl7Vu/+8kdjMOi5uq3rhTG/4YdT5bZHFMmwvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yu2rMxZZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A90606B12B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yu2rMxZZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59911F00919;
	Tue,  3 Nov 2026 10:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700635;
	bh=n/a95moMhTo2V1bhlqxFOojiRsUuFnaNeAtgD+c7R2g=;
	h=Subject:To:Cc:From:Date;
	b=yu2rMxZZCYJdFw+f7Oe7SL5umMwjPOzSMC5o6YVVDSZgdUowDcajL3xZYJoJkePTM
	 0+eYLGwJA/pg5M9A5Z2ixY+QpPaH6RNnnlSAynt+9Tg4Hu2ErJT+L+2oezt2963u3C
	 TqRcdjK5iNrEOlUJovqw4R7d9h/pLcJHMcXOvRC4=
Subject: FAILED: patch "[PATCH] net/sched: sch_teql: fix use-after-free on lower qdisc drop" failed to apply to 5.10-stable tree
To: owen@verialabs.com,horms@kernel.org,jhs@mojatatu.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:10:25 +0100
Message-ID: <2026110325-gauging-cupcake-40eb@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 782d6bb8f9b8e9d8591181662222bf74cd3ecf79
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110325-gauging-cupcake-40eb@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 782d6bb8f9b8e9d8591181662222bf74cd3ecf79 Mon Sep 17 00:00:00 2001
From: owen kwan <owen@verialabs.com>
Date: Sat, 24 Oct 2026 10:34:15 -0400
Subject: [PATCH] net/sched: sch_teql: fix use-after-free on lower qdisc drop

The issue: teql_master_xmit() tests the slave's ndo_start_xmit() return
value against NETDEV_TX_OK alone. A slave that consumes the skb but
returns an error code (rc < NET_XMIT_MASK, e.g. NET_XMIT_DROP) is treated
as if the skb were still owned, so the loop restores skb->dev and calls
__skb_pull() on it. A VLAN slave returns the result of dev_queue_xmit()
from its ndo_start_xmit() (propagated since cbbef5e18307), and when the
lower qdisc drops the packet that value is NET_XMIT_DROP after the skb
has been freed, giving a use-after-free in teql_master_xmit().

The Fix: test for consumption with dev_xmit_complete(), which accepts
NETDEV_TX_OK and every rc < NET_XMIT_MASK, matching other callers that
need to distinguish consumed results from busy. Only NETDEV_TX_OK keeps
the packet counted in tx_packets/tx_bytes and advances the slave; a
consumed result that is neither a success nor NET_XMIT_CN ends the
attempt and is charged to tx_dropped, so lower-qdisc drops are no longer
reported as good transmits. NET_XMIT_CN is counted like success because
it can accompany acceptance of the current packet: pfifo_head_drop drops
the old head, enqueues the current skb and returns NET_XMIT_CN.

Conditions to recreate the bug:
With CONFIG_NET_SCH_TEQL,
CONFIG_VLAN_8021Q and CONFIG_DUMMY enabled, add lkrdummy0 (dummy) and
lkrvlan0 (VLAN id 37 on lkrdummy0); set a pfifo limit 0 root on lkrdummy0
and a teql0 root on lkrvlan0; bring teql0 up with an address and send one
UDP packet to it. The VLAN xmit returns NET_XMIT_DROP from the lower
qdisc while holding a freed skb.

Fixes: 572a9d7b6fc7 ("net: allow to propagate errors through ->ndo_hard_start_xmit()")
Link: https://lore.kernel.org/netdev/179248763469.3135.1739559328868319628@kernel.org/
Link: https://lore.kernel.org/netdev/20261023162821.GN708417@horms.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: owen kwan <owen@verialabs.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/QDISC-Y0BY.v2.r0.20261024060625-2@mojatatu.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 6764f0dd38df..70c948a26f80 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -360,12 +360,18 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 		case 0:
 			if (__netif_tx_trylock(slave_txq)) {
 				unsigned int length = qdisc_pkt_len(skb);
+				int rc = NETDEV_TX_BUSY;
 
 				skb->dev = slave;
-				if (!netif_xmit_frozen_or_stopped(slave_txq) &&
-				    netdev_start_xmit(skb, slave, slave_txq, false) ==
-				    NETDEV_TX_OK) {
-					__netif_tx_unlock(slave_txq);
+				if (!netif_xmit_frozen_or_stopped(slave_txq))
+					rc = netdev_start_xmit(skb, slave, slave_txq, false);
+				__netif_tx_unlock(slave_txq);
+				if (dev_xmit_complete(rc)) {
+					if (rc != NETDEV_TX_OK && rc != NET_XMIT_CN) {
+						master->tx_dropped++;
+						rcu_read_unlock();
+						return NETDEV_TX_OK;
+					}
 					raw_spin_lock_irqsave(&master->slaves_lock, flags);
 					if (rcu_dereference_protected(master->slaves,
 								      lockdep_is_held(&master->slaves_lock)) == q)
@@ -379,7 +385,6 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 					rcu_read_unlock();
 					return NETDEV_TX_OK;
 				}
-				__netif_tx_unlock(slave_txq);
 			}
 			if (netif_xmit_stopped(netdev_get_tx_queue(dev, 0)))
 				busy = 1;

