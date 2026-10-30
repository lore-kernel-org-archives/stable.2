Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=154.59.88.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400692;
	b=X3eTQ1Ni3sb7BgyfaAiC1tWwydAV24oPWbGjSomUbacTATXvLS5mtYk/chB9ySVix9Tk
	 HHfYCPfnXmtaMl0gT689m6vKODlFQtL9TYaaSp0tV+ugH3PVY59IOP2HkrQsDESibOEUx
	 6awHVKFzr6uf5q+1AL8Fhzb4NDgLmLckXwhnp1hPRQo4u8S5fT66fUKU4b1V6cLkgtAzz
	 vTMuBPntGS61KCwjotx+4UujMP7SNJ4LQus9YMJxnpePaNNe+KqkLN15SuuAtViISvQBY
	 9A6kxaOnxirgoC99MhMzZ5bdgzxDAmk7cDUrxxKMFYgXF+k/7+5v1tGvVJgTvtK7qkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400692;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6Mg2aJBzbEbEcz1P0YwREZPwOD2OZ4Jz3XOrMOHGQAU=;
	b=PUrtEhdgqx9ZfeQfSPPBfWLksK512SZz/uMrlnyQg+sz9xuMkNulW4R/MTJPWHFUKhPr
	 sKETjwJhridlK6G/xN5fod725TVqDirZcb9CHVyg3WKkLTKf7p38oARmkJ5msnqG2Ldgn
	 3pZB77syGcN283mVg3vy23Hi3LX545g0qOSv4BLtBv4rfeyAnoTwKwJUFuI76H5pTdnBu
	 kdGcF76CtLgLYuQHCwIMVgd229deN3FLJj/URaH4kh6R5gWTjsAWoR4T9WBHqOPAR8S99
	 sh0U3Ev+8L5IO1sTE4dkH1vigbOvFcvVDwJgoq5mxx4/n5nLlMDgjdsUoaP7f0H9DXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=newsnow.co.uk;
	spf=pass smtp.mailfrom=newsnow.co.uk;
	dkim=pass header.d=newsnow.co.uk header.i=@newsnow.co.uk header.a=rsa-sha256 header.s=20160728 header.b=SXI4GXPQ;
	arc=none smtp.remote-ip=154.59.88.225
Received: from coen-mx.newsnow.co.uk (gw1.mail.newsnow.co.uk [154.59.88.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C1606A31C;
	Fri, 30 Oct 2026 22:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D2C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=newsnow.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=newsnow.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=newsnow.co.uk header.i=@newsnow.co.uk header.a=rsa-sha256 header.s=20160728 header.b=SXI4GXPQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=newsnow.co.uk; s=20160728; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6Mg2aJBzbEbEcz1P0YwREZPwOD2OZ4Jz3XOrMOHGQAU=; b=SXI4GXPQ6zrCIJD7G0gcUG4QF4
	zzwoQPb7tQ17dLhldlcBWuJcSECltVAigTfL07sn2qkBKgVqATja3uJUzI8Qw2+VbUtuq+phxKam3
	SDmknVzrTsXEpbYWXgseUE6Puo6XfEVmXnDJa2NocUW5HJVy3JVU+g77h8U5TR7ipfnXGRICrF+od
	tJFPRqtMo3oPfc9mSQDuidLgdlLOVpFfCmYqUfSi2TSeqdaDYju6K9GCmo/FQse4sjrGHZQNbxw4F
	JVOKXGusILC7e/jq2KvkwQrwPtTWTObELXYqppoWnaj+VrEMqWr3ZSolkvc5UXrUCQ67CEXbMP/j1
	0X13x/uA==;
Received: from weber.dc.lan ([192.168.3.220] helo=amd64build.webcluster.newsnow.co.uk)
	by coen-mx.newsnow.co.uk with esmtp (Exim 4.96)
	(envelope-from <struan.bartlett@newsnow.co.uk>)
	id 1xMvRP-00073D-0n;
	Fri, 30 Oct 2026 22:51:19 +0000
From: Struan Bartlett <struan.bartlett@newsnow.co.uk>
To: stable@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Tonghao Zhang <tonghao@bamaicloud.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH 6.12.y] bonding: re-check pending peer notification under RTNL in ARP monitor
Date: Fri, 30 Oct 2026 22:51:19 +0000
Message-Id: <20261030225119.40765-2-struan.bartlett@newsnow.co.uk>
X-Mailer: git-send-email 2.39.5
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

commit 70fc6649b36cf22167bbd7e2a6cc0960b746316e upstream.

This is not a backport of that commit but a minimal equivalent of it
for 6.12.y, as explained below.

In active-backup mode with the ARP monitor, if bond_ab_arp_commit()
fails over while a peer notification is pending,
bond_activebackup_arp_mon() decrements send_peer_notif twice and wraps
it:

1. A failover sets send_peer_notif to num_peer_notif (1 by default).
   If the notification cannot be sent at once, for example because the
   new active slave still has __LINK_STATE_LINKWATCH_PENDING, it stays
   pending.
2. The next run of bond_activebackup_arp_mon() sets
   should_notify_peers from bond_should_notify_peers() before calling
   bond_ab_arp_inspect(). If bond_ab_arp_commit() then fails over
   again, for example to the primary as its link comes up,
   bond_change_active_slave() resets send_peer_notif to 1, sends the
   notification and decrements send_peer_notif to 0.
3. The monitor then acts on its earlier should_notify_peers under
   RTNL: send_peer_notif-- wraps from 0 to UINT_MAX, and it sends a
   second notification.

bond_should_notify_peers() is then true on every run, so the bond
sends NETDEV_NOTIFY_PEERS every arp_interval until the counter runs
down, which takes years. At boot this happens whenever a backup
slave's link comes up shortly before the primary's. Every listener
sees the notifications: FRR's zebra counts each one as the bond's link
coming up, and ntpd postpones its interface rescan for as long as they
continue (which can lead to the clock being unsynchronised).

Fix it by checking bond_should_notify_peers() again once RTNL is held,
before decrementing the counter and sending the notification.
bond_change_active_slave() runs under RTNL, so the re-check sees any
failover made since should_notify_peers was set.

Upstream, commit 70fc6649b36c ("net: bonding: move
bond_should_notify_peers, e.g. into rtnl lock block") also checks
send_peer_notif again under RTNL before decrementing it, in both
monitors, using bond_peer_notify_may_events() from
commit 11ea9b8a88dd ("net: bonding: use workqueue to make sure peer
notify updated in lacp mode"). Neither commit applies to 6.12.y, and
together they also change when the counter is decremented. This patch
adds only the re-check, to the ARP monitor, and otherwise keeps
6.12.y's behaviour: the ARP monitor still sends and counts a
notification only when bond_should_notify_peers() allows it. The MII
monitor in 6.12.y already checks send_peer_notif under RTNL before
decrementing it, so it cannot wrap, and is left unchanged.

Fixes: 7a9214f3d88c ("bonding: ARP monitor spams NETDEV_NOTIFY_PEERS notifiers")
Assisted-by: claude-opus-5-5
Signed-off-by: Struan Bartlett <struan.bartlett@newsnow.co.uk>
---

Notes:
    Please apply to 6.12.y. Newer stable trees: 7.x has 70fc6649b36c, and
    for 6.18.y, where both upstream commits apply cleanly, I have asked
    separately for them to be applied.
    
    The same change also applies to 6.6.y, 6.1.y, 5.15.y and 5.10.y, which
    have the same ARP monitor code; I have not tested it on them.
    
    Testing: each kernel below is Debian's, booted in a VM. The bonding
    module was built from the matching stable sources against Debian's
    headers with the compiler Debian used, and loaded in place of Debian's
    own. A fuller version of the reproducer below counted the bond's
    NETDEV_NOTIFY_PEERS events for 3 s just after the failback to the
    primary and, if there were any, for 3 s again 30 s later, after the
    255 set before the failover would have run out. With arp_interval
    100, a bond that notifies on every ARP monitor run sends about 30 in
    3 s:
    
      kernel             bonding module                       after  30 s later
      6.12.95-1~bpo12+1  Debian's                               29     28
      6.12.95-1~bpo12+1  v6.12.95, unchanged                    29     29
      6.12.95-1~bpo12+1  v6.12.95 + this patch                   0      -
      6.18.9-1~bpo13+1   Debian's                               29     28
      6.18.9-1~bpo13+1   v6.18.9, unchanged                     29     29
      6.18.9-1~bpo13+1   v6.18.9 + this patch                    0      -
      6.18.9-1~bpo13+1   v6.18.9 + 11ea9b8a88dd + 70fc6649b36c   0      -
    
    The reproducer below, exactly as given, printed 29 with Debian's
    6.12.95 module and 0 with this patch. The patch applies to v6.12.115
    with an offset of one line; the code it touches is the same as in
    6.12.95.
    
    We found this on a Dell R630 server (igb) running 6.12.95 with:
    mode active-backup, miimon 0, arp_interval 250, arp_validate all,
    six arp_ip_targets, primary set, num_grat_arp 1. At boot a backup
    port's link came up 0.3 s before the primary's, and from then on
    "ip -d monitor link" showed "bond0: ... event NOTIFY PEERS" every
    256 ms. A kprobe on call_netdevice_notifiers for NETDEV_NOTIFY_PEERS
    showed each one coming from bond_arp_monitor. Moving the active slave
    away and back through sysfs (active_slave) stops it, as that failover
    happens outside the ARP monitor.
    
    Reproducer (as root; it uses two new network namespaces, so it does
    not touch the host's own interfaces). It prints the number of
    NETDEV_NOTIFY_PEERS events the bond sends in 3 s, 30 s after the last
    failover: about 30 (one per 100 ms ARP monitor run) on an affected
    kernel, 0 on a fixed one.
    
    	ip netns add h; ip netns add s
    	ip -n s link add br0 type bridge
    	ip -n s addr add 10.255.0.1/24 dev br0; ip -n s link set br0 up
    	ip -n h link add bond0 type bond mode active-backup arp_interval 100 \
    		arp_ip_target 10.255.0.1 arp_validate all num_grat_arp 1
    	for i in 1 2; do
    		ip -n h link add p$i type veth peer name s$i netns s
    		ip -n s link set s$i master br0 up
    		ip -n h link set p$i master bond0
    	done
    	ip -n h link set bond0 type bond primary p1
    	ip -n h addr add 10.255.0.2/24 dev bond0; ip -n h link set bond0 up
    	sleep 5		# p1 active, both slaves up
    	# Fail over to p2 with 255 notifications to send: one is pending at
    	# every ARP monitor run for the next ~25 s.
    	ip -n h link set bond0 type bond num_grat_arp 255
    	ip -n s link set s1 down; sleep 2	# p2 active
    	# The ARP monitor fails back to the primary while a notification is
    	# pending.
    	ip -n h link set bond0 type bond num_grat_arp 1
    	ip -n s link set s1 up; sleep 30	# p1 active; the 255 have run out
    	timeout 3 ip -n h -d monitor link | grep -c 'bond0: .*NOTIFY PEERS'
    	ip netns del h; ip netns del s
    
    An AI coding assistant (Claude, model claude-opus-5-5) helped trace
    the fault, wrote this patch, its changelog and the reproducer, and
    built and ran the tests above under my direction. I have reviewed the
    patch and changelog.

 drivers/net/bonding/bond_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a6f3ed0..e8bb50f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3937,7 +3937,12 @@ re_arm:
 		if (!rtnl_trylock())
 			return;
 
-		if (should_notify_peers) {
+		/* A failover in bond_ab_arp_commit() may have reset and used
+		 * send_peer_notif since should_notify_peers was set, so check it
+		 * again now that RTNL is held; decrementing it unconditionally
+		 * could wrap it and send a notification on every probe.
+		 */
+		if (should_notify_peers && bond_should_notify_peers(bond)) {
 			bond->send_peer_notif--;
 			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
 						 bond->dev);
-- 
2.39.5

