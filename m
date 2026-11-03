Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713414;
	b=uF0VV8kNAHq/M9fMgSN8P6UMPk1pQkg2rGLd6SgqovNau403F6wqODNLZy2RD/8mKJdf
	 Z0gAQp5P7xM1zay4g3oj+KmX+cGKsFm3swCnJAejqyCJQlFFjSMhTGRPb4raRol0wHiVQ
	 hGmIO9hB/z+bgMaFB6iPAOxF3K3Tcjs+aPXAHamw13I3nrqfJtEfTBNUy5J2Z0tjIO6F9
	 7bI9Mt8wWwzfZDoTNr/kq9UQWvFuHKFy5+tbgdvAe0BrPLXQJpzQl9wz85py8WQpuZxlJ
	 QSQsLesCSQdhqadJrWlKjv6j5VdANpZzt+5j2wh2xtqqXCizGx/XjwGkX/XOvxncvFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713414;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yZfIsC58hDG5nePhG/0L8WYWzy8KpUJsSEBr8PzIokQ=;
	b=Hs8E1g+E+omyuUwqxb1si0L4QbjhnpJ1HkJQ/WMJA6zH4nG/8pwvi7b7Le6lMa4OGJWw
	 H/MVNGY8zrGkH6VILji6ztwNG44LInbiKJCmWvKk87EKJwNLpsTveBwKGRoMlNFSt9Hxi
	 5jt+MMyd06EXBfBLSWMom4MlvZbbVlOBrzl1zplDP6Hhir872psfSBPrM0Ph1PiTd8Sag
	 EwB0C4WW6L4/QBv2PrPvGtwfxGrorC17gQ5Cjtu9k5qfze9yKuOaXS8Z1oQjknB6EExR5
	 S+3qB2AIObCFxWzImLRF+jIGnCVqJo7Ews1kM6qBtq34pOZgjq9i53DXC1hTB5aPEBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjZh6GFg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E912606D804
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjZh6GFg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B8E1F00919;
	Tue,  3 Nov 2026 13:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793713413;
	bh=yZfIsC58hDG5nePhG/0L8WYWzy8KpUJsSEBr8PzIokQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NjZh6GFgycLrO/rAyaJdt1Mc29mCSnWBp5SBQBpo0HVvabDeYK6kg5TnFi1pRmoM6
	 64JLyYeS9rB41IfmME3z06xgj04KIJ5AZ4GOjfD3CU6GZi/ybEP89hN00ZmpimGftx
	 ZOHtr/Ow3tFxA7uttWqMWExE2LPD6aBUb2R72T/kQ/SP97UGnm+J3sdyNCHwkpez4h
	 qvWhUxBuA0vH4m+RrcmjwMC+aoNd7We8VmvCZKZbH4dhG2snGknWSFimY0BSfYptmR
	 2xBEab47xWzhp43uLaiFVMW8KuLJlSGWLZuMjGGG2tZ5avJIXPFph5xSmAGwBs2b5K
	 MGkUiDBe+FVDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: owen kwan <owen@verialabs.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net/sched: sch_teql: fix use-after-free on lower qdisc drop
Date: Tue,  3 Nov 2026 08:43:31 -0500
Message-ID: <20261103134300.3967501-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110324-gown-kettle-7dce@gregkh>
References: <2026110324-gown-kettle-7dce@gregkh>
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

From: owen kwan <owen@verialabs.com>

[ Upstream commit 782d6bb8f9b8e9d8591181662222bf74cd3ecf79 ]

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
[ sashal: Omitted rcu_read_unlock() because teql_master_xmit() has no corresponding RCU read lock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_teql.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 00ac4386627c7..9057d4f2ee5c6 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -311,19 +311,23 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
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
+						return NETDEV_TX_OK;
+					}
 					master->slaves = NEXT_SLAVE(q);
 					netif_wake_queue(dev);
 					master->tx_packets++;
 					master->tx_bytes += length;
 					return NETDEV_TX_OK;
 				}
-				__netif_tx_unlock(slave_txq);
 			}
 			if (netif_xmit_stopped(netdev_get_tx_queue(dev, 0)))
 				busy = 1;
-- 
2.53.0

