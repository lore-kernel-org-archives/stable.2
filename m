Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855B649DBA1
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290909; cv=none; b=MiurDTQDjml0QJefkSdsTZa75cyhuPp/GQicXAQKF8PkH3pxaG/FtlkvmVK6Vm6bdZF479ebg0cXc9G3w30NTcpkIze7SA2134nY2X4w6bk7LgvA+SQUPPWQovVRYATY6WP5uFZzqsCla1w6Pjd/nXfOwaXVtYxBRIQ9pCc50hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290909; c=relaxed/simple;
	bh=F+UBunQUYVFiNN0hRK1QBMeljI74mO+GzJpDLm6C2ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p66NQW5m2cl0HOD9VJ28KkJ8KIbUB9XRJ9thGxG1iRbaT4GNVls9mBtuzhBetSxho2xW3UMI0zn/pow4gYrPeocM6VXAMK2ol249dfpmXIEaeVe2IW1tqyR5B0C+i4JAVs9Mm8dmtFZQ1XCbGCdMDDflpOc2MfcnL+KQqzkT4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpHINDFg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpHINDFg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486D71F000E9;
	Tue,  1 Sep 2026 19:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788290908;
	bh=JtQCJ5+z0jTAtMHU0cmgXDuYeDIQ1ZxKpQf/XLlMfyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WpHINDFgJ43E0UExgFYaVSjuitnvfYPt/adHzSK1gfkRmULn1mY7uAySzWJ4NgNn4
	 uzJTYXUtfxeoWz0PPjmeresxB6zXX909VWe6SGzt/8ixyfJodyR0/JKcN6F7bnQfk/
	 swnC2nF+nJfhCWwKccnY4LCarYI3JojBiYYdMB8JowAHbceFfJBxmPg/CoM0eZq8HH
	 bxattTIhGJ5sETCAG9w/HPPbInFZ8tbBtWQNJqewmy9+6TgQH0RKpTCZFj3bexNObU
	 fAMZEYAOtGwdklDy2e4OOIjG64rMPf32kZT6PnxaWUL8joJJ/ba/uEJUXYltr4+jOH
	 WVV07DSZkUhUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com,
	syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com,
	syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] vlan: defer real device state propagation to netdev_work
Date: Tue,  1 Sep 2026 15:28:24 -0400
Message-ID: <20260901192825.1439307-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083120-prayer-ricotta-053a@gregkh>
References: <2026083120-prayer-ricotta-053a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit cd1c188db1091991fc1d7f565824d077d659425b ]

vlan_device_event() generates nested UP/DOWN, MTU and feature
change events. It executes an event for the VLAN device directly
from the notifier - while the locks of the lower device are held.

This causes deadlocks, for example:

  bond    (3) bond_update_speed_duplex(vlan)
    |           ^                v
  vlan    (2) UP(vlan)    (4) vlan_ethtool_get_link_ksettings()
    |           ^                v
  dummy   (1) UP(dummy)   (5) __ethtool_get_link_ksettings()

The dummy device is ops locked, vlan creates a nested event (2),
then bond wants to ask vlan for link state (3). bond uses the
"I'm already holding the instance lock" flavor of API. But in
this case the lock held refers to vlan itself. We hit vlan's
link settings trampoline (4) and call __ethtool_get_link_ksettings()
which tries to lock dummy. Deadlock. There's no clean way for us
to tell the vlan_ethtool_get_link_ksettings() that the caller
is already in lower device's critical section.

Defer the propagation to the per-netdev work facility instead:
the notifier only schedules netdev_work_sched(vlandev, VLAN_WORK_*),
and ndo_work (vlan_dev_work) applies the change later. Hopefully
nobody expects the VLAN state changes to be instantaneous.

If someone does expect the changes to be instantaneous we will
have to do the same thing Stan did for rx_mode and "strategically"
place sync calls, to make sure such delayed works are executed
after we drop the ops lock but before we drop rtnl_lock.

Stan suggests that if we need that down the line we may
consider reshaping the mechanism into "async notifications".
AFAICT only vlan does this sort of netdev open chaining,
so as a first try I think that sticking the complexity into
the vlan code makes sense.

One corner case is that we need to cancel the event if user
explicitly changes the state before work could run. Consider
the following operations with vlan0 on top of dummy0:

  ip link set dev dummy0 up    # queues work to up vlan0
  ip link set dev vlan0 down   # user explicitly downs the vlan
  ndo_work                     # acts on the stale event

Reported-by: syzbot+09da62a8b78959ceb8bb@syzkaller.appspotmail.com
Reported-by: syzbot+cb67c392b0b8f0fd0fc1@syzkaller.appspotmail.com
Reported-by: syzbot+9bb8bd77f3966641f298@syzkaller.appspotmail.com
Fixes: 9f275c2e9020 ("net: ethtool: make sure __ethtool_get_link_ksettings() is ops-locked")
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Link: https://patch.msgid.link/20260624182018.2445732-4-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ sashal: Reduced backport -- upstream cd1c188db1091 touches 5 file(s), this
  backport carries 3. Not backported here:
  Documentation/networking/netdevices.rst
  net/core/dev.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 447cbe95ebb9 ("vlan: fix skb_under_panic and races when toggling HW VLAN offload")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/8021q/vlan.c     | 24 ------------------------
 net/8021q/vlan.h     |  3 +++
 net/8021q/vlan_dev.c | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 7be41986001bb..375321be0bf06 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -314,30 +314,6 @@ static void vlan_sync_address(struct net_device *dev,
 	ether_addr_copy(vlan->real_dev_addr, dev->dev_addr);
 }
 
-static void vlan_transfer_features(struct net_device *dev,
-				   struct net_device *vlandev)
-{
-	struct vlan_dev_priv *vlan = vlan_dev_priv(vlandev);
-
-	vlandev->gso_max_size = dev->gso_max_size;
-	vlandev->gso_max_segs = dev->gso_max_segs;
-
-	if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
-		vlandev->hard_header_len = dev->hard_header_len;
-	else
-		vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
-
-#if IS_ENABLED(CONFIG_FCOE)
-	vlandev->fcoe_ddp_xid = dev->fcoe_ddp_xid;
-#endif
-
-	vlandev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
-	vlandev->priv_flags |= (vlan->real_dev->priv_flags & IFF_XMIT_DST_RELEASE);
-	vlandev->hw_enc_features = vlan_tnl_features(vlan->real_dev);
-
-	netdev_update_features(vlandev);
-}
-
 static int __vlan_device_event(struct net_device *dev, unsigned long event)
 {
 	int err = 0;
diff --git a/net/8021q/vlan.h b/net/8021q/vlan.h
index 2633b7616526f..a399ed215519d 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -120,6 +120,9 @@ static inline netdev_features_t vlan_tnl_features(struct net_device *real_dev)
 int vlan_filter_push_vids(struct vlan_info *vlan_info, __be16 proto);
 void vlan_filter_drop_vids(struct vlan_info *vlan_info, __be16 proto);
 
+void vlan_transfer_features(struct net_device *dev,
+			    struct net_device *vlandev);
+
 /* found in vlan_dev.c */
 void vlan_dev_set_ingress_priority(const struct net_device *dev,
 				   u32 skb_prio, u16 vlan_prio);
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index c134f8210b21b..cd3f214cc3f8c 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -487,9 +487,13 @@ static void vlan_dev_set_lockdep_class(struct net_device *dev)
 	netdev_for_each_tx_queue(dev, vlan_dev_set_lockdep_one, NULL);
 }
 
+/* 5.10 does not have the VLAN protocol parser used by newer kernels. */
+#define vlan_parse_protocol NULL
+
 static const struct header_ops vlan_header_ops = {
 	.create	 = vlan_dev_hard_header,
 	.parse	 = eth_header_parse,
+	.parse_protocol = vlan_parse_protocol,
 };
 
 static int vlan_passthru_hard_header(struct sk_buff *skb, struct net_device *dev,
@@ -509,9 +513,10 @@ static int vlan_passthru_hard_header(struct sk_buff *skb, struct net_device *dev
 static const struct header_ops vlan_passthru_header_ops = {
 	.create	 = vlan_passthru_hard_header,
 	.parse	 = eth_header_parse,
+	.parse_protocol = vlan_parse_protocol,
 };
 
-static struct device_type vlan_type = {
+static const struct device_type vlan_type = {
 	.name	= "vlan",
 };
 
@@ -764,6 +769,30 @@ static const struct ethtool_ops vlan_ethtool_ops = {
 	.get_ts_info		= vlan_ethtool_get_ts_info,
 };
 
+void vlan_transfer_features(struct net_device *dev,
+			    struct net_device *vlandev)
+{
+	struct vlan_dev_priv *vlan = vlan_dev_priv(vlandev);
+
+	vlandev->gso_max_size = dev->gso_max_size;
+	vlandev->gso_max_segs = dev->gso_max_segs;
+
+	if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
+		vlandev->hard_header_len = dev->hard_header_len;
+	else
+		vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
+
+#if IS_ENABLED(CONFIG_FCOE)
+	vlandev->fcoe_ddp_xid = dev->fcoe_ddp_xid;
+#endif
+
+	vlandev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
+	vlandev->priv_flags |= (vlan->real_dev->priv_flags & IFF_XMIT_DST_RELEASE);
+	vlandev->hw_enc_features = vlan_tnl_features(vlan->real_dev);
+
+	netdev_update_features(vlandev);
+}
+
 static const struct net_device_ops vlan_netdev_ops = {
 	.ndo_change_mtu		= vlan_dev_change_mtu,
 	.ndo_init		= vlan_dev_init,
-- 
2.53.0

