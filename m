Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792846192;
	b=fHuHqhw/BlodbzJJQ95MxONB24omKg6jazz9Mjaje90G7zVnd7Ejy6WMrU1L3n9pHXyG
	 F8oqBvqNkzWT4AfW1rDSZDR/KTd4/SeTRPdaEfF9stEvPYW/Ml/dFK+UA606DekVIkNUD
	 vL9WtWqo8OiJHEafHcMhmOpfBHY1fl9dZ+YMnJOpQoBwlFbdg3NpgxqMxEyvDVMW9DbOc
	 mbsKabF0aqAnGfY4qVCxQWduwWUSEbHF1NyWv3NVKL3xvy7IE4EhOWiKDmyobHlmMugmx
	 Ft0aGCN1ZLcWpfQvHRehuLqUXUFAb+PiiZ2/0jWS4XwJ3V698c/yoITP2QSNhuctmNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792846192;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=90nCaBzhOW1F8+h1aWVbR1EBebBzrovbu1/KSdPp1RQ=;
	b=gT8fvgxGrOjpptGfqunpL1w0h4D1d946L5WhMoXaT9fD5vWFoA41ISkCqAqgqKa7/P4l
	 TSZdxPr/W5rk8gUPe3ZqJTqA7Q82I9KXtELhyWyzPGqJh44av27c9D+FLF/3pWGSpf+4m
	 YxKv/LLSmOIzcqSj16Rz5UqCp+KglqDSykBdGcUVU/WkttCDA1Q/BWHFrTNl+lMoCTx07
	 mqyOURB7t5oLGPpd3BbLNop6Xjqoa7v8n7x/aapqanxCVcM1LJsyCUOjqPbRym02ncqs+
	 8QSks20lZkf4tSp1lH4dCdRzSyu+sDWboUwayT57hElQeeQyk2NYduKXuMG83jvnSWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelscan.io;
	spf=pass smtp.mailfrom=kernelscan.io;
	arc=none smtp.remote-ip=212.227.126.130
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5B606A31F
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 12:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFC5B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernelscan.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelscan.io
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue010
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MaIrN-1x6d4q3G1F-00LxO3; Sat, 24
 Oct 2026 14:49:33 +0200
From: Steffen Pfendtner <steffen.pfendtner@kernelscan.io>
To: stable@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y] net: bonding: fix use-after-free in bond_xmit_broadcast()
Date: Sat, 24 Oct 2026 14:49:32 +0200
Message-ID: <20261024124932.5507-1-steffen.pfendtner@kernelscan.io>
X-Mailer: git-send-email 2.50.1
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
X-Provags-ID: V03:K1:tUz1tCRa1wcVIbiovO+YMEj9JW//bkr9Ps6MhoAfzW1dQgzJLwZ
 rNROq5bKdBXh3U2l7RRq9jdG+MAzUNk2m21RL0vlEG8lSBeOA1tiCyf59AFobwLGkhNDpsL
 n8EeFsf/Sd5hiWimXt1pIAgONVMZeigMZOmkOZcbV0ebo6kBfc76LwTBuRYZP35+NSkIrUe
 GDrB9OuohuwZmwhKlb3VQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QzhhMZwwtag=;n3dxO5ZN1MgRD/sAqJi6TSky0i4
 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
 iEzTG6NRjYcqNbyN2eyV78EzcFtA==

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
[ Backport to 5.10.y: bond_xmit_broadcast() here walks the slave list,
  not a slave array, so there is no array index or slaves_count to
  compare. Count the list entries instead and compare against a
  READ_ONCE() snapshot of bond->slave_cnt taken before the loop. The two
  can match on at most one iteration, so the original skb is consumed at
  most once even if the list changes during the RCU walk; if a slave
  goes away mid-walk, the original skb is freed at the end as before. ]
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Steffen Pfendtner <steffen.pfendtner@kernelscan.io>
---
Not a clean cherry-pick (see the bracketed note): 5.15's
bond_xmit_broadcast() walks the slave list rather than an array, so the
"last slave" test counts list position against a READ_ONCE() snapshot of
bond->slave_cnt taken before the loop, instead of the array index the
upstream commit uses. Please review this adaptation closely.

Build-tested on arm64; boot-tested under QEMU with KASAN: a broadcast
bond transmitting while slaves are enslaved/released shows no
double-free or KASAN report.

 drivers/net/bonding/bond_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index e977fd528d75..ce1d3be917f6 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4611,14 +4611,17 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 	struct list_head *iter;
 	bool xmit_suc = false;
 	bool skb_used = false;
+	int slaves_count, i = 0;
 
+	slaves_count = READ_ONCE(bond->slave_cnt);
 	bond_for_each_slave_rcu(bond, slave, iter) {
 		struct sk_buff *skb2;
 
+		i++;
 		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
 			continue;
 
-		if (bond_is_last_slave(bond, slave)) {
+		if (i == slaves_count) {
 			skb2 = skb;
 			skb_used = true;
 		} else {
-- 
2.50.1 (Apple Git-155)

