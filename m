Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132923C1D43
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273114; cv=none; b=pausuamYsnoqm/7+tyiqIhGJjDFa8+/IODjo8QK5NeDNP9oMSD/emTx3Ku7oPdnhoE0qNJ1FnSiJD08pEXJbNZyAJSvH5nYw8fpzNlMYxyZtAZZQQyy75CX0KIhB0s7tPF1pyItLSgjvgIVOJAiN0jlegeQ/LSzez37PlcXaFTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273114; c=relaxed/simple;
	bh=fyw1qQlXcBDlEccOwqKO15ZoBc9m8StgyDqtxZqpBEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOCC4cQsldAIrIexkt7IBUSuX4YLxKcrSU1kB/57lVQvRQYqsfg1BW18Ci1vL7B6LeiuHo974pVAlkPqO3r+Jjx1BeMLGWOzqouHhA2jZbCYfelkv+uAbaB9oQWNQ7RrnRhbHdQjumGn1NciZ8Uhj32lDwUPGeCII0HId378+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0zKWWER; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0zKWWER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30141F000E9;
	Tue,  1 Sep 2026 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788273112;
	bh=Qo0bk9c4q6cqUGQ4/RRDniHpAC0ZX0kh7q8jiUvq6SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S0zKWWER7CIswHA5G30bMAlUOtzrCCoG5dgd1n2TDGHHAJPvrcfAABa/gG8hgN9sI
	 7BYg+leIgBbBClBhYczXCRZKzb8vSqUB2xN/cdjkGl9BpwooZQ1KkuIbY9SE8LfMN/
	 nEuDq8i6JLKyHpWz+dlvK15s8YCf5ihA1oLj2xVr9G64zRAFqP6hvd8RzQA0+/ndhL
	 kL5zvVb9WMf8bbPnA5iSargE96+g+oJUbD4Z/2FyVcE0tisO7oPJPhyk7gOt6F0+LP
	 R61uHl3wJ3a8KCmhc0ObjrzmgfnPardf5q0p6GBJVyo53MbRb25KrdK7Wn/qeTc6DH
	 KhJtXLUhDU4FQ==
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
Subject: [PATCH 6.1.y 1/2] vlan: defer real device state propagation to netdev_work
Date: Tue,  1 Sep 2026 10:31:49 -0400
Message-ID: <20260901143150.1081831-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083119-eldest-saucy-a3c3@gregkh>
References: <2026083119-eldest-saucy-a3c3@gregkh>
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
 net/8021q/vlan.c     | 23 -----------------------
 net/8021q/vlan.h     |  2 ++
 net/8021q/vlan_dev.c | 25 ++++++++++++++++++++++++-
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 7c77482f31594..3744333b5e85f 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -317,29 +317,6 @@ static void vlan_sync_address(struct net_device *dev,
 	ether_addr_copy(vlan->real_dev_addr, dev->dev_addr);
 }
 
-static void vlan_transfer_features(struct net_device *dev,
-				   struct net_device *vlandev)
-{
-	struct vlan_dev_priv *vlan = vlan_dev_priv(vlandev);
-
-	netif_inherit_tso_max(vlandev, dev);
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
index c7ffe591d5936..b493a8c0721c7 100644
--- a/net/8021q/vlan.h
+++ b/net/8021q/vlan.h
@@ -126,6 +126,8 @@ int vlan_filter_push_vids(struct vlan_info *vlan_info, __be16 proto);
 void vlan_filter_drop_vids(struct vlan_info *vlan_info, __be16 proto);
 
 /* found in vlan_dev.c */
+void vlan_transfer_features(struct net_device *dev,
+			    struct net_device *vlandev);
 void vlan_dev_set_ingress_priority(const struct net_device *dev,
 				   u32 skb_prio, u16 vlan_prio);
 int vlan_dev_set_egress_priority(const struct net_device *dev,
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index c08228d488346..14908b8f5b0da 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -520,7 +520,7 @@ static const struct header_ops vlan_passthru_header_ops = {
 	.parse_protocol = vlan_parse_protocol,
 };
 
-static struct device_type vlan_type = {
+static const struct device_type vlan_type = {
 	.name	= "vlan",
 };
 
@@ -787,6 +787,29 @@ static const struct ethtool_ops vlan_ethtool_ops = {
 	.get_ts_info		= vlan_ethtool_get_ts_info,
 };
 
+void vlan_transfer_features(struct net_device *dev,
+			    struct net_device *vlandev)
+{
+	struct vlan_dev_priv *vlan = vlan_dev_priv(vlandev);
+
+	netif_inherit_tso_max(vlandev, dev);
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

