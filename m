Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203DD3DDDDE
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787180968; cv=none; b=M7Q273brbM+z13ErNX9K4MugNzlhhjU1UyFXBn64+TrDbSug1EkMo5lYqSO4h60FTneANuBdZBvMAphUxaJpl462U2BtX7Z18OQBjrOfvByGCUntozOhyg1QJimC/KdDVVuFT570PIvGxhSml3i8mMTIQsAwTkKtBDMAjSAsxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787180968; c=relaxed/simple;
	bh=lPEUQcsoQHXVmi6zF7F2k5Rm/FT83OcuA904PR6RW+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UETVtB/EOuTIQZQO7urKSWeXf5wfXJGQ6hNvaUGWyLyoYKE7dBboPkUdsNUbVIX/D8Ipv2rVYUpvx99x6/PgoE0ICMmLnm5fu2AU2yUID88Pab2FzdFnNM+ouSmcP+2iJ2BZhwB0RgdwxQx1CV33Y2oOLzOVwLZ8H51O1wjW1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwF6s5xp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwF6s5xp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C7F1F000E9;
	Wed, 19 Aug 2026 23:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787180967;
	bh=JFKZ2ejpA+PVmfIAUfxecCgw/v0Ngjmphds7NCBgqWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bwF6s5xpbXHIvgAhsLq2Icg5keajf7GOwuAeHCLGpGViqZ8Jj8dQFsrnVT9I4Gejh
	 gSavMQFvyKvIWMoaobiA6bcUJYfubUwuRIhvobLvZsUfAl3EXK2c4yYKut0XnTiLZO
	 8yuuhPqDwYqGXwvFdvJBJGtVOcWUJaZS3bjG9dC0CYzPlgbpq2sButsr3bf3fkmBvZ
	 SGY/iaK2dPIUO+0jpvp0Di2KJDdrWcis21dLdMzabKBpITl7m20B+nRJYRy7KS3ZK6
	 HJZHRYCsjQ+J5g3JgJ1V0ruOy8vLJH6BHjnYKDWGpGqZG8K4NETY0vTT5z2mcBsFBg
	 wZaHdW4/HE9Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] net: rename netdev_ops_assert_locked()
Date: Wed, 19 Aug 2026 19:09:24 -0400
Message-ID: <20260819230925.944372-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081708-gracious-yard-1b78@gregkh>
References: <2026081708-gracious-yard-1b78@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 251bc9db88fb351ea2dfbd976c4e6aaae6507a91 ]

Jakub suggests renaming the existing assert to match
the netdev_lock_ops_compat() semantics.

We want netdev_assert_locked_ops() to mean - if the driver
is ops locked - check that it's holding the device lock.

The existing helper check for either ops lock or rtnl_lock,
which is the locking behavior of netdev_lock_ops_compat().

The reason for naming divergence is likely that
netdev_ops_assert_locked() predated the _compat() helpers.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Link: https://patch.msgid.link/20260603012840.2254293-2-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 92465f46f3c3 ("net: expect instance lock in netdev_queue_get_dma_dev()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  2 +-
 include/net/netdev_lock.h                 |  6 +++---
 net/core/dev.c                            | 26 +++++++++++------------
 net/core/dev_addr_lists.c                 |  2 +-
 net/core/link_watch.c                     |  2 +-
 net/core/lock_debug.c                     |  2 +-
 net/core/netdev_queues.c                  |  2 +-
 net/ethtool/netlink.c                     |  4 ++--
 net/ipv6/addrconf.c                       |  2 +-
 net/xdp/xsk_buff_pool.c                   |  2 +-
 10 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1cd6e88d4e814..f0625c2fb2aa0 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16854,7 +16854,7 @@ int bnxt_restore_pf_fw_resources(struct bnxt *bp)
 {
 	int rc;
 
-	netdev_ops_assert_locked(bp->dev);
+	netdev_assert_locked_ops_compat(bp->dev);
 	bnxt_hwrm_func_qcaps(bp);
 
 	if (netif_running(bp->dev))
diff --git a/include/net/netdev_lock.h b/include/net/netdev_lock.h
index 3d3aef80beac1..8e84d29b0bfb0 100644
--- a/include/net/netdev_lock.h
+++ b/include/net/netdev_lock.h
@@ -64,7 +64,7 @@ static inline void netdev_unlock_full_to_ops(struct net_device *dev)
 		netdev_unlock(dev);
 }
 
-static inline void netdev_ops_assert_locked(const struct net_device *dev)
+static inline void netdev_assert_locked_ops_compat(const struct net_device *dev)
 {
 	if (netdev_need_ops_lock(dev))
 		lockdep_assert_held(&dev->lock);
@@ -73,11 +73,11 @@ static inline void netdev_ops_assert_locked(const struct net_device *dev)
 }
 
 static inline void
-netdev_ops_assert_locked_or_invisible(const struct net_device *dev)
+netdev_assert_locked_ops_compat_or_invisible(const struct net_device *dev)
 {
 	if (dev->reg_state == NETREG_REGISTERED ||
 	    dev->reg_state == NETREG_UNREGISTERING)
-		netdev_ops_assert_locked(dev);
+		netdev_assert_locked_ops_compat(dev);
 }
 
 static inline void netdev_lock_ops_compat(struct net_device *dev)
diff --git a/net/core/dev.c b/net/core/dev.c
index 58ec448e83574..9f83a3c1315a2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1593,7 +1593,7 @@ EXPORT_SYMBOL(netdev_features_change);
 
 void netif_state_change(struct net_device *dev)
 {
-	netdev_ops_assert_locked_or_invisible(dev);
+	netdev_assert_locked_ops_compat_or_invisible(dev);
 
 	if (dev->flags & IFF_UP) {
 		struct netdev_notifier_change_info change_info = {
@@ -1693,7 +1693,7 @@ static int __dev_open(struct net_device *dev, struct netlink_ext_ack *extack)
 
 	set_bit(__LINK_STATE_START, &dev->state);
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	if (ops->ndo_validate_addr)
 		ret = ops->ndo_validate_addr(dev);
@@ -1770,7 +1770,7 @@ static void __dev_close_many(struct list_head *head)
 		 *	event.
 		 */
 
-		netdev_ops_assert_locked(dev);
+		netdev_assert_locked_ops_compat(dev);
 
 		if (ops->ndo_stop)
 			ops->ndo_stop(dev);
@@ -3198,7 +3198,7 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 
 	if (dev->reg_state == NETREG_REGISTERED ||
 	    dev->reg_state == NETREG_UNREGISTERING) {
-		netdev_ops_assert_locked(dev);
+		netdev_assert_locked_ops_compat(dev);
 
 		rc = netdev_queue_update_kobjects(dev, dev->real_num_tx_queues,
 						  txq);
@@ -3247,7 +3247,7 @@ int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
 		return -EINVAL;
 
 	if (dev->reg_state == NETREG_REGISTERED) {
-		netdev_ops_assert_locked(dev);
+		netdev_assert_locked_ops_compat(dev);
 
 		rc = net_rx_queue_update_kobjects(dev, dev->real_num_rx_queues,
 						  rxq);
@@ -7313,7 +7313,7 @@ void netif_queue_set_napi(struct net_device *dev, unsigned int queue_index,
 
 	if (WARN_ON_ONCE(napi && !napi->dev))
 		return;
-	netdev_ops_assert_locked_or_invisible(dev);
+	netdev_assert_locked_ops_compat_or_invisible(dev);
 
 	switch (type) {
 	case NETDEV_QUEUE_TYPE_RX:
@@ -9608,7 +9608,7 @@ int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 	kuid_t uid;
 	kgid_t gid;
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	promiscuity = dev->promiscuity + inc;
 	if (promiscuity == 0) {
@@ -9667,7 +9667,7 @@ int netif_set_allmulti(struct net_device *dev, int inc, bool notify)
 	unsigned int old_flags = dev->flags, old_gflags = dev->gflags;
 	unsigned int allmulti, flags;
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	allmulti = dev->allmulti + inc;
 	if (allmulti == 0) {
@@ -9735,7 +9735,7 @@ int __dev_change_flags(struct net_device *dev, unsigned int flags,
 	unsigned int old_flags = dev->flags;
 	int ret;
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	/*
 	 *	Set the flags on our device.
@@ -9883,7 +9883,7 @@ int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
 {
 	int err, orig_mtu;
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	if (new_mtu == dev->mtu)
 		return 0;
@@ -10317,7 +10317,7 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 	struct netdev_bpf xdp;
 	int err;
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
 	    prog && !prog->aux->xdp_has_frags) {
@@ -10769,7 +10769,7 @@ u32 dev_get_min_mp_channel_count(const struct net_device *dev)
 {
 	int i;
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	for (i = dev->real_num_rx_queues - 1; i >= 0; i--)
 		if (dev->_rx[i].mp_params.mp_priv)
@@ -10997,7 +10997,7 @@ int __netdev_update_features(struct net_device *dev)
 	int err = -1;
 
 	ASSERT_RTNL();
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	features = netdev_get_wanted_features(dev);
 
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index d73fcb0c67853..6b493af8dc8be 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -1260,7 +1260,7 @@ static void netif_rx_mode_run(struct net_device *dev)
 	int err;
 
 	might_sleep();
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	__hw_addr_init(&uc_snap);
 	__hw_addr_init(&mc_snap);
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index ff2c1d4538efb..9c35aac8b2e98 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -277,7 +277,7 @@ static bool linkwatch_clean_dev(struct net_device *dev)
 
 void __linkwatch_sync_dev(struct net_device *dev)
 {
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	if (linkwatch_clean_dev(dev)) {
 		linkwatch_do_dev(dev);
diff --git a/net/core/lock_debug.c b/net/core/lock_debug.c
index 9e9fb25314b9c..14fd8fcdcd562 100644
--- a/net/core/lock_debug.c
+++ b/net/core/lock_debug.c
@@ -24,7 +24,7 @@ int netdev_debug_event(struct notifier_block *nb, unsigned long event,
 	case NETDEV_CHANGE:
 	case NETDEV_REGISTER:
 	case NETDEV_UP:
-		netdev_ops_assert_locked(dev);
+		netdev_assert_locked_ops_compat(dev);
 		fallthrough;
 	case NETDEV_DOWN:
 	case NETDEV_REBOOT:
diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
index 73fb28087a93d..4d6864bb4f6bc 100644
--- a/net/core/netdev_queues.c
+++ b/net/core/netdev_queues.c
@@ -40,7 +40,7 @@ struct device *netdev_queue_get_dma_dev(struct net_device *dev,
 	struct netdev_rx_queue *hw_rxq;
 	struct device *dma_dev;
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	/* Only RX side supports queue leasing today. */
 	if (type != NETDEV_QUEUE_TYPE_RX || !netif_rxq_is_leased(dev, idx))
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 7d45f9a884e50..8d5ee7987530c 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -98,7 +98,7 @@ int ethnl_ops_begin(struct net_device *dev)
 	if (dev->dev.parent)
 		pm_runtime_get_sync(dev->dev.parent);
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	if (!netif_device_present(dev) ||
 	    dev->reg_state >= NETREG_UNREGISTERING) {
@@ -1003,7 +1003,7 @@ static void ethnl_default_notify(struct net_device *dev, unsigned int cmd,
 		       ops->req_info_size - sizeof(*req_info));
 	}
 
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	ethnl_init_reply_data(reply_data, ops, dev);
 	ret = ops->prepare_data(req_info, reply_data, &info);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index defa4277e783f..ba4f80fd3db88 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -380,7 +380,7 @@ static struct inet6_dev *ipv6_add_dev(struct net_device *dev)
 	int err = -ENOMEM;
 
 	ASSERT_RTNL();
-	netdev_ops_assert_locked(dev);
+	netdev_assert_locked_ops_compat(dev);
 
 	if (dev->mtu < IPV6_MIN_MTU && dev != blackhole_netdev)
 		return ERR_PTR(-EINVAL);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index f720422607771..78c14f1063957 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -244,7 +244,7 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
 	bpf.xsk.pool = pool;
 	bpf.xsk.queue_id = queue_id;
 
-	netdev_ops_assert_locked(netdev);
+	netdev_assert_locked_ops_compat(netdev);
 	err = netdev->netdev_ops->ndo_bpf(netdev, &bpf);
 	if (err)
 		goto err_unreg_pool;
-- 
2.53.0

