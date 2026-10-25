Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792917917;
	b=NIntE1CiXdV9E4Y1Rg9r0t7ruDkH5vxWn48SizJkdJV+sRpAgndknEmUcu/iGNnHEbDD
	 EIcQXB1l49jse9CXBkUyFLlWdwW1C+IjO+u37F5mcmSMitLSUo2/UhYR6MB0bpL9uPop3
	 7vaJJtKscYCH554AB/xLnl5izQpT6wZ6ZoKIWP3zkj3u9JA7raXWOaPp29bOYXf8ENzWX
	 61YU6P6Ck+fwIyMWhckxjKjsIe/nzQKB+5xYtjfnrhhn+IWZNmLFdhXSBLkfEm3xkTXcW
	 B+WWhXNKgIDlkMSdoSFQ7TevBCSO7RVXAIGAitt4BsQZCG5HBrRanQcJCg937qiPuHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792917917;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=VhZfVcQygCMC0ZHdNZny2y1fLz3444mS/i8C+iIKAzg=;
	b=b2jaBMqwWjhVGBF5VOl0gb49pl6APm0WMI8T0FurHYxvqwvmkVe2HboehjMeOlQu4Ht2
	 VoAfJgNBMa1HhD6GLTBYzldvxtzRQF1jytBwi31Sosn0mFc+k7XAIFI1OjG43YRvHqW9B
	 SVlNje8d+3veb4WrQQk5OCIBlAI9q7ttM0/fCDOYuQgSa9VsAOzr7gBp7sfsiLaUjfmBc
	 EK9m60/0GwDFu5GISJU5EzWsuThoGgdCM+IBgST4UYsxzgc5XoGpYf/Whq3hsMd8yny9v
	 ibeeJYn5qgr8cs7sNErhSMzLCC23x45tVPlpWAh6G56GUXhWOCXhAAeRwpVc7DJubBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelscan.io;
	spf=pass smtp.mailfrom=kernelscan.io;
	arc=none smtp.remote-ip=212.227.126.130
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB5B606A326
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 08:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DB5B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernelscan.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelscan.io
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MRVy9-1wxThw2ROf-00KuIz; Sun, 25
 Oct 2026 09:45:09 +0100
From: Steffen Pfendtner <steffen.pfendtner@kernelscan.io>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2 5.10.y] net: bonding: fix use-after-free in bond_xmit_broadcast()
Date: Sun, 25 Oct 2026 09:45:05 +0100
Message-ID: <20261025084505.83046-1-steffen.pfendtner@kernelscan.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261024124932.5507-1-steffen.pfendtner@kernelscan.io>
References: <20261024124932.5507-1-steffen.pfendtner@kernelscan.io>
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
X-Provags-ID: V03:K1:R9dWAYPKqkq6wdhDwjuYVlYdh9JknLTyFktWZNSX5d651mrQOCp
 UrXWLZ5Zm/7wGwBN6AIn8AcuWV5tAG/0IaaiDKGs/+BVFVEc/VtSt4plFesKD8fzFz2NqY7
 /uCvB0YEC8zUhbBnEuFQrdjoolSSFQCU0xE2vRUqm+l+n8yzAZgCauixTOb/z30BlHtjtaL
 E2ebHPUMT8pQoetfM5pWw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Jt5uGXuqEnk=;pXCh6uPFcR+mI+hR7LmVAUI/PwZ
 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
 4d/1w6y/NHHynGP+atyDaVPori+g==

From: Xiang Mei <xmei5@asu.edu>

[ Upstream commit 2884bf72fb8f03409e423397319205de48adca16 ]

bond_xmit_broadcast() reuses the original skb for the last slave
(determined by bond_is_last_slave()) and clones it for others.
Concurrent slave enslave/release can mutate the slave list during
RCU-protected iteration, changing which slave is "last" mid-loop.
This causes the original skb to be double-consumed (double-freed).

Replace the racy bond_is_last_slave() check with a simple index
comparison (i + 1 == slaves_count) against the pre-snapshot slave
count taken via READ_ONCE() before the loop.  This preserves the
zero-copy optimization for the last slave while making the "last"
determination stable against concurrent list mutations.

The UAF can trigger the following crash:

==================================================================
BUG: KASAN: slab-use-after-free in skb_clone
Read of size 8 at addr ffff888100ef8d40 by task exploit/147

CPU: 1 UID: 0 PID: 147 Comm: exploit Not tainted 7.0.0-rc3+ #4 PREEMPTLAZY
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:123)
 print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
 kasan_report (mm/kasan/report.c:597)
 skb_clone (include/linux/skbuff.h:1724 include/linux/skbuff.h:1792 include/linux/skbuff.h:3396 net/core/skbuff.c:2108)
 bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5334)
 bond_start_xmit (drivers/net/bonding/bond_main.c:5567 drivers/net/bonding/bond_main.c:5593)
 dev_hard_start_xmit (include/linux/netdevice.h:5325 include/linux/netdevice.h:5334 net/core/dev.c:3871 net/core/dev.c:3887)
 __dev_queue_xmit (include/linux/netdevice.h:3601 net/core/dev.c:4838)
 ip6_finish_output2 (include/net/neighbour.h:540 include/net/neighbour.h:554 net/ipv6/ip6_output.c:136)
 ip6_finish_output (net/ipv6/ip6_output.c:208 net/ipv6/ip6_output.c:219)
 ip6_output (net/ipv6/ip6_output.c:250)
 ip6_send_skb (net/ipv6/ip6_output.c:1985)
 udp_v6_send_skb (net/ipv6/udp.c:1442)
 udpv6_sendmsg (net/ipv6/udp.c:1733)
 __sys_sendto (net/socket.c:730 net/socket.c:742 net/socket.c:2206)
 __x64_sys_sendto (net/socket.c:2209)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
 </TASK>

Allocated by task 147:

Freed by task 147:

The buggy address belongs to the object at ffff888100ef8c80
 which belongs to the cache skbuff_head_cache of size 224
The buggy address is located 192 bytes inside of
 freed 224-byte region [ffff888100ef8c80, ffff888100ef8d60)

Memory state around the buggy address:
 ffff888100ef8c00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888100ef8c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888100ef8d00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                                    ^
 ffff888100ef8d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888100ef8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Fixes: 4e5bd03ae346 ("net: bonding: fix bond_xmit_broadcast return value error bug")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Link: https://patch.msgid.link/20260326075553.3960562-1-xmei5@asu.edu
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Backport to 5.10.y: 5.10's bond_xmit_broadcast() walks the live slave
  list, not the all_slaves array upstream indexes into (that walk came
  with ce7a381697cb "net: bonding: add broadcast_neighbor option for
  802.3ad"), so there is no index/count pair that stays consistent
  while the list changes. Instead of choosing the "last" slave up
  front, defer it: clone the skb for each up slave as the next one is
  found, and transmit the original skb to the last up slave seen only
  after the walk has finished. The original skb is consumed exactly
  once and not touched afterwards, however the list changes during
  the RCU walk; slave pointers stay valid under rcu_read_lock() since
  __bond_release_one() does synchronize_rcu() before freeing. ]
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Steffen Pfendtner <steffen.pfendtner@kernelscan.io>
---
v2: v1 had the same flaw Sasha found in the 5.15.y version (a list
index compared against a slave_cnt snapshot does not bound the walk,
since bond_enslave() links the slave before it bumps slave_cnt). v2
uses the same approach as the 5.15.y v2: defer the original skb until
the list walk is over, see the bracketed note.

Build-tested on arm64 (W=1) on top of queue-5.10. Boot-tested under QEMU
with KASAN: several CPUs flood broadcasts through a broadcast-mode bond
while slaves are enslaved and released in a tight loop; no KASAN report,
and afterwards every up slave transmits every broadcast.

 drivers/net/bonding/bond_main.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e977fd528d75..ec712fdeaa4c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4607,35 +4607,36 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 				       struct net_device *bond_dev)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
-	struct slave *slave = NULL;
+	struct slave *slave = NULL, *last = NULL;
 	struct list_head *iter;
 	bool xmit_suc = false;
-	bool skb_used = false;
 
+	/* The slave list can change under us during the RCU walk, so which
+	 * slave is "last" is only known once the walk is over: clone for
+	 * every up slave but the last one seen, then hand the original skb
+	 * to that one after the loop.
+	 */
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		struct sk_buff *skb2;
 
 		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
 			continue;
 
-		if (bond_is_last_slave(bond, slave)) {
-			skb2 = skb;
-			skb_used = true;
-		} else {
+		if (last) {
 			skb2 = skb_clone(skb, GFP_ATOMIC);
-			if (!skb2) {
+			if (!skb2)
 				net_err_ratelimited("%s: Error: %s: skb_clone() failed\n",
 						    bond_dev->name, __func__);
-				continue;
-			}
+			else if (bond_dev_queue_xmit(bond, skb2, last->dev) == NETDEV_TX_OK)
+				xmit_suc = true;
 		}
-
-		if (bond_dev_queue_xmit(bond, skb2, slave->dev) == NETDEV_TX_OK)
-			xmit_suc = true;
+		last = slave;
 	}
 
-	if (!skb_used)
+	if (!last)
 		dev_kfree_skb_any(skb);
+	else if (bond_dev_queue_xmit(bond, skb, last->dev) == NETDEV_TX_OK)
+		xmit_suc = true;
 
 	if (xmit_suc)
 		return NETDEV_TX_OK;
-- 
2.39.5

