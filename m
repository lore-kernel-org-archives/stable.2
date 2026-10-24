Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.126.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792840181;
	b=Mcu3qpYajXezhwbx/2aGu32eaY4noMKU1VUsHsh5VFwAE5NeRAeNA70Mc0lijhjJajde
	 zUm0NDtmxooW1c7JnI5U0EzMvmrRBCu7vi/286HsxQzV0nMIwD6tsfDc8GXAl3gcc/6ZT
	 Zjk9fUgmJup094VgLVgFWV/IJK05ulfQfdK0Iaf81ePZig3CwPM6b3Lp5sPWHpO9z/0xn
	 gvu5oKeevUD6pFzai4q7DI6APhLQb8N6DZlTMd0NlWHToO8zkpBHStCty3lTJmb0nV2Zu
	 GYdsos9QSkZEadvnKJAhX7FWv9R4cJI+52V9j1+jxq0XBTTNw1kOtEwP86tlM74Hr3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792840181;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=UPAv9d1T+NKBfd7KTcOtP0zpC8MhO7AiTIoJ2ie3NwQ=;
	b=lzHZDTZg31TEXZZWuykeeTUmf1zL3UgH9bmKPPsCCJpMN9btdKOex83Q08bVKFglAXF4
	 eRHWoPgIuzNHkLLFm/v2wK92MQblZbNxjKGcs3prdv/pejstU0BF7g3mDklwy71+yjuFs
	 qyPLN0mx2qcpk19TN0c/OyREwbstSMq6dO26sqZpUTSNHhnQB9oCPAZPkUtWUJLUZU5o5
	 CrAtBpYbQzMp1wWc+s/9E8AGybRWsPxxLO/xI77LsbKfbukph/bVRsFGRIitlXnTMmQmJ
	 3Pmq7sCpIzxoYnK2ubpbT+wbH3RpVSQqM0ALjqCScKE5LnmVGXPatrwUv+mEo6548aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelscan.io;
	spf=pass smtp.mailfrom=kernelscan.io;
	arc=none smtp.remote-ip=212.227.126.131
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D34606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 11:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07D34606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernelscan.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelscan.io
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MP2zs-1wvL6m1Ymy-00IylD; Sat, 24
 Oct 2026 13:09:32 +0200
From: Steffen Pfendtner <steffen.pfendtner@kernelscan.io>
To: stable@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	bridge@lists.linux.dev
Subject: [PATCH 5.15.y] bridge: mcast: Fix use-after-free during router port configuration
Date: Sat, 24 Oct 2026 13:09:29 +0200
Message-ID: <20261024110929.47253-1-steffen.pfendtner@kernelscan.io>
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
X-Provags-ID: V03:K1:otaAU5hrSZhT4ov8L45qmn8yQsdWFSOngRrUbxxsTuESDzsQMuF
 BegP62/vZlgB3A0foR7j95cDUKzqy1ov4nCCMGIjg1/BnX7wLxhQNj1i7cM4G95u2Ed4AKT
 H/yVmYsxpgc9Y/v0uldwNEtMasuXv9nMczAVvijZBHKJGwVVawMggG+BaYJTZmHJF/NS84h
 49wL83P+nt00q/F13dacQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:c0hNBqVZAsE=;+vT9BBDwLhd3dh+yYtq1o9sErgL
 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
 grGQYsmlVDKIMOC6eHxa2LUppZMZg==

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 7544f3f5b0b58c396f374d060898b5939da31709 ]

The bridge maintains a global list of ports behind which a multicast
router resides. The list is consulted during forwarding to ensure
multicast packets are forwarded to these ports even if the ports are not
member in the matching MDB entry.

When per-VLAN multicast snooping is enabled, the per-port multicast
context is disabled on each port and the port is removed from the global
router port list:

 # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1
 # ip link add name dummy1 up master br1 type dummy
 # ip link set dev dummy1 type bridge_slave mcast_router 2
 $ bridge -d mdb show | grep router
 router ports on br1: dummy1
 # ip link set dev br1 type bridge mcast_vlan_snooping 1
 $ bridge -d mdb show | grep router

However, the port can be re-added to the global list even when per-VLAN
multicast snooping is enabled:

 # ip link set dev dummy1 type bridge_slave mcast_router 0
 # ip link set dev dummy1 type bridge_slave mcast_router 2
 $ bridge -d mdb show | grep router
 router ports on br1: dummy1

Since commit 4b30ae9adb04 ("net: bridge: mcast: re-implement
br_multicast_{enable, disable}_port functions"), when per-VLAN multicast
snooping is enabled, multicast disablement on a port will disable the
per-{port, VLAN} multicast contexts and not the per-port one. As a
result, a port will remain in the global router port list even after it
is deleted. This will lead to a use-after-free [1] when the list is
traversed (when adding a new port to the list, for example):

 # ip link del dev dummy1
 # ip link add name dummy2 up master br1 type dummy
 # ip link set dev dummy2 type bridge_slave mcast_router 2

Similarly, stale entries can also be found in the per-VLAN router port
list. When per-VLAN multicast snooping is disabled, the per-{port, VLAN}
contexts are disabled on each port and the port is removed from the
per-VLAN router port list:

 # ip link add name br1 up type bridge vlan_filtering 1 mcast_snooping 1 mcast_vlan_snooping 1
 # ip link add name dummy1 up master br1 type dummy
 # bridge vlan add vid 2 dev dummy1
 # bridge vlan global set vid 2 dev br1 mcast_snooping 1
 # bridge vlan set vid 2 dev dummy1 mcast_router 2
 $ bridge vlan global show dev br1 vid 2 | grep router
       router ports: dummy1
 # ip link set dev br1 type bridge mcast_vlan_snooping 0
 $ bridge vlan global show dev br1 vid 2 | grep router

However, the port can be re-added to the per-VLAN list even when
per-VLAN multicast snooping is disabled:

 # bridge vlan set vid 2 dev dummy1 mcast_router 0
 # bridge vlan set vid 2 dev dummy1 mcast_router 2
 $ bridge vlan global show dev br1 vid 2 | grep router
       router ports: dummy1

When the VLAN is deleted from the port, the per-{port, VLAN} multicast
context will not be disabled since multicast snooping is not enabled
on the VLAN. As a result, the port will remain in the per-VLAN router
port list even after it is no longer member in the VLAN. This will lead
to a use-after-free [2] when the list is traversed (when adding a new
port to the list, for example):

 # ip link add name dummy2 up master br1 type dummy
 # bridge vlan add vid 2 dev dummy2
 # bridge vlan del vid 2 dev dummy1
 # bridge vlan set vid 2 dev dummy2 mcast_router 2

Fix these issues by removing the port from the relevant (global or
per-VLAN) router port list in br_multicast_port_ctx_deinit(). The
function is invoked during port deletion with the per-port multicast
context and during VLAN deletion with the per-{port, VLAN} multicast
context.

Note that deleting the multicast router timer is not enough as it only
takes care of the temporary multicast router states (1 or 3) and not the
permanent one (2).

[1]
BUG: KASAN: slab-out-of-bounds in br_multicast_add_router.part.0+0x3f1/0x560
Write of size 8 at addr ffff888004a67328 by task ip/384
[...]
Call Trace:
 <TASK>
 dump_stack_lvl+0x6f/0xa0
 print_address_description.constprop.0+0x6f/0x350
 print_report+0x108/0x205
 kasan_report+0xdf/0x110
 br_multicast_add_router.part.0+0x3f1/0x560
 br_multicast_set_port_router+0x74e/0xac0
 br_setport+0xa55/0x1870
 br_port_slave_changelink+0x95/0x120
 __rtnl_newlink+0x5e8/0xa40
 rtnl_newlink+0x627/0xb00
 rtnetlink_rcv_msg+0x6fb/0xb70
 netlink_rcv_skb+0x11f/0x350
 netlink_unicast+0x426/0x710
 netlink_sendmsg+0x75a/0xc20
 __sock_sendmsg+0xc1/0x150
 ____sys_sendmsg+0x5aa/0x7b0
 ___sys_sendmsg+0xfc/0x180
 __sys_sendmsg+0x124/0x1c0
 do_syscall_64+0xbb/0x360
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

[2]
BUG: KASAN: slab-use-after-free in br_multicast_add_router.part.0+0x378/0x560
Read of size 8 at addr ffff888009f00840 by task bridge/391
[...]
Call Trace:
 <TASK>
 dump_stack_lvl+0x6f/0xa0
 print_address_description.constprop.0+0x6f/0x350
 print_report+0x108/0x205
 kasan_report+0xdf/0x110
 br_multicast_add_router.part.0+0x378/0x560
 br_multicast_set_port_router+0x6f9/0xac0
 br_vlan_process_options+0x8b6/0x1430
 br_vlan_rtm_process_one+0x605/0xa30
 br_vlan_rtm_process+0x396/0x4c0
 rtnetlink_rcv_msg+0x2f7/0xb70
 netlink_rcv_skb+0x11f/0x350
 netlink_unicast+0x426/0x710
 netlink_sendmsg+0x75a/0xc20
 __sock_sendmsg+0xc1/0x150
 ____sys_sendmsg+0x5aa/0x7b0
 ___sys_sendmsg+0xfc/0x180
 __sys_sendmsg+0x124/0x1c0
 do_syscall_64+0xbb/0x360
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 2796d846d74a ("net: bridge: vlan: convert mcast router global option to per-vlan entry")
Fixes: 4b30ae9adb04 ("net: bridge: mcast: re-implement br_multicast_{enable, disable}_port functions")
Reported-by: syzbot+7bfa4b72c6a5da128d32@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/684c18bd.a00a0220.279073.000b.GAE@google.com/T/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20250619182228.1656906-1-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Backport to 5.15.y: resolved a context conflict in
  br_multicast_port_ctx_deinit() where mainline uses the post-6.15
  timer_delete_sync() name; 5.15 still spells it del_timer_sync().
  The three rport-del helpers already exist in 5.15 (since 4b30ae9adb04),
  so the fix applies unchanged otherwise. ]
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Steffen Pfendtner <steffen.pfendtner@kernelscan.io>
---
The 6.1.y backport of this fix is already in the stable queue; this is the
5.15.y counterpart. The only conflict was the timer_delete_sync() rename.

Build-tested on arm64, and boot-tested under QEMU with KASAN: bridge
multicast router-port configuration (global and per-VLAN, including port
and VLAN deletion followed by re-adding a router port) works as before,
with no KASAN reports.

 net/bridge/br_multicast.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index a91c133ce296..cc832477f290 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1859,10 +1859,19 @@ void br_multicast_port_ctx_init(struct net_bridge_port *port,
 
 void br_multicast_port_ctx_deinit(struct net_bridge_mcast_port *pmctx)
 {
+	struct net_bridge *br = pmctx->port->br;
+	bool del = false;
+
 #if IS_ENABLED(CONFIG_IPV6)
 	del_timer_sync(&pmctx->ip6_mc_router_timer);
 #endif
 	del_timer_sync(&pmctx->ip4_mc_router_timer);
+
+	spin_lock_bh(&br->multicast_lock);
+	del |= br_ip6_multicast_rport_del(pmctx);
+	del |= br_ip4_multicast_rport_del(pmctx);
+	br_multicast_rport_del_notify(pmctx, del);
+	spin_unlock_bh(&br->multicast_lock);
 }
 
 int br_multicast_add_port(struct net_bridge_port *port)
-- 
2.50.1 (Apple Git-155)

