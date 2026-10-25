Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792918053;
	b=jsXnvwVUBArb/TW1tbgMk/VcYGX9UoWJx/Fyba0Juxb3+49qsWwCLT34il7VMCP9l1LN
	 uhQy0zhUR0zA2hqraRRZPHVLnZB7c5ya5LRwvR0ULmoNTJ/R1EYkOPOWudPRzFqLZm4ck
	 HfHL6KyP/KarPJtoweNE3kiTigKf2xu4x7yG2tEsHOQFw53taLzoocKbhGlh/Hb44Yb3S
	 f7WHqXtcyWxF9KVUJsdHjvqBx3XGDc/UgYFg+e1NGFyHGQLEaPFMLUW+jmpODlcr2VCDh
	 6ESvdrw3raaFklq+pn4U4y+0/POMnG8CPilWAq69oBJ3e118TMCt1kL+03yTShZGpsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792918053;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=YzwpBMMqrS4/XdfV+MvYVyS8ZMKplxOS4Xa9LypSppA=;
	b=EYzAZB6u/peIx0XtRwj4S8UEqC/SnzmDZ73vA3gpjZ3hSRHoF0IJ4lon/cYNQGpyLzDM
	 Z2Ig+LRNRaKVSZZ7m9lYUOGRIwJ0K5U8sD/tWFbySTgeGj+2ua4t+d+2gaca4m3aMJOrg
	 UEhzqSoITBhBoENhstNpCTII+XWN7OpiTbPL6zNAaiy7Rc6VkaZsl9FwNEfUsdxXBpquW
	 F4CHzL7kebDA/T/Htk7yg5xF9VtLSzZa2Yh78X5cu1gPGBRq8T2yC7VBvwnAVzW8o2vs3
	 a66yCUd+iPvCGmGpezWZPxhCmqRv1FHa6BOHRMvcanKv7Z3C0H/5LpcU6IIrImqiKQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelscan.io;
	spf=pass smtp.mailfrom=kernelscan.io;
	arc=none smtp.remote-ip=212.227.126.130
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81A606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 08:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E81A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernelscan.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelscan.io
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue010
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MPXta-1wzOlM1f74-00SqEi; Sun, 25
 Oct 2026 09:47:30 +0100
From: Steffen Pfendtner <steffen.pfendtner@kernelscan.io>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2 5.15.y] net: bonding: fix use-after-free in bond_xmit_broadcast()
Date: Sun, 25 Oct 2026 09:47:25 +0100
Message-ID: <20261025084725.84254-1-steffen.pfendtner@kernelscan.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2026-10-24-1-daily-reply-0013-bonding-xmit-broadcast-5-15-bounce@kernel.org>
References: <2026-10-24-1-daily-reply-0013-bonding-xmit-broadcast-5-15-bounce@kernel.org>
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
X-Provags-ID: V03:K1:z4YJ/UKclBmZOpHGzZviP0zGMtdMAHhhwStnDEm7bYFgR6XZlIu
 e6x37yf776oFuREe/T6L8lGxU5FDBCl5QjZtx3jU2kSwEcO8umNzg18c+YSonyDS4Pd1FlX
 FSfgM/Av3HJ9KVt6oL/2AGnnv7+lcBC4BhWhf6DpjusLAa0gZp1DSb6PlH6TlYuQkbJzfGY
 +yf9HVsoZ/5EYwJZRaoFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SeXdyQlSmX4=;wO8hXV9D9QOTUghsGcYfhcdlE3n
 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
 kXmm1wb2A+meyp1uR8I/SqDx7oQw==

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
[ Backport to 5.15.y: 5.15's bond_xmit_broadcast() walks the live slave
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
v2: v1 compared a running list index against a READ_ONCE() snapshot of
bond->slave_cnt, which does not bound the walk: bond_enslave() links the
new slave into the list before it increments slave_cnt, so a walk in
that window (or one that sees a slave appended mid-walk) hands the
original skb out and then skb_clone()s it on the next slave (Sasha).
The upstream index check relies on the all_slaves array walk from
ce7a381697cb, which 5.15 does not have, and pulling in that feature
plus its follow-up e0caeb24f538 seemed too much for 5.15. v2 instead
defers the original skb until the list walk is over, see the bracketed
note. Happy to send the 3-patch variant (ce7a381697cb + e0caeb24f538 +
this fix, as in 6.1.y) instead if that is preferred.

Build-tested on arm64 (W=1) on top of queue-5.15. Boot-tested under QEMU
with KASAN: several CPUs flood broadcasts through a broadcast-mode bond
while slaves are enslaved and released in a tight loop; no KASAN report,
and afterwards every up slave transmits every broadcast.

 drivers/net/bonding/bond_main.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b74732d2924b..12dc1d3c6e2b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4915,35 +4915,36 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
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

