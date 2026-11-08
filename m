Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135380;
	b=k+scrzsLKOQb6TVCJpw29j2h7/ndFjgjlV43VCbU2sCaVy2TW13IXM1NstWF22vB+CQc
	 gq9v0FAuo7tHcDD/vsRxKIt9HOjwyacZDMmYJ/W4qtGB8vs9LpMAMqev3SCtKLRs981NQ
	 smECXMOZRX1xcUb04dVh9x6VFU+jnTVuyKmin1DDAinUmIalFW/by8JLsxgr71JpxVbvm
	 lJJaauz5aRgQ0wBT7OWLnu1Y0m/w+nkHFEDJrX4dm5pCuuurrwzdjgrii2kDvyZ7qU6wl
	 wS2DNit49yyFjd6Nt4RgeZgnzwGfnGy64njt0KxeMKFv9mCjS8Wa0yT0r4YUgd8o4uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135380;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=Lx5FdCJ2eSvmPiOnGEExcuHYOPXDEBy3PEtwkjj7EwY=;
	b=Bwork02K8/+crasMPW44LTT+G1FZc8/UZpa8L1odBUYUe8o8vuuVLhPbACCplvfXI+Ge
	 A4QeFit/zsvVYvNUJnWdV2ZwSEImjBJBoRkm/NS8JfbaMsrq52rtrne2Hk2YavmAU2uUR
	 7L/A3q6Xytz2NB+x0mV/2lcGnpXf1qGjNLwGDXo2X/Go5k9NYYMrYHp7k7lGp4vXcV2lF
	 EqtYiA9RBAiNxaffR7ZgLWsZKOirEON7N1HIim5gEeQ2qzVB6lw1sVKsbg0WnHC2KY7j7
	 Glo3LEPxHo0UtRG/OqLLBL5DqNftHIV8rioZtq0AddNyI1McMidOxDHp3eZW5gO3ACQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=BK4xzZgn;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30256606A31C;
	Sun,  8 Nov 2026 10:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30256606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=BK4xzZgn
Received: from LAPTOP-99KJFSET (unknown [223.75.64.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 53e3dfdce;
	Sun, 8 Nov 2026 18:56:07 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	oss-drivers@corigine.com,
	linux-kernel@vger.kernel.org,
	Hongyan Xu <getshell@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] nfp: flower: hold an RCU read lock while using an offloaded MAC entry
Date: Sun,  8 Nov 2026 18:56:05 +0800
Message-ID: <20261108105605.1668-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
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
X-HM-Tid: 0aa1bacd1c1203a1kunma22588dace61d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSB1PVh9JSBgdTR8eS00eH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVTE5VTU9VQ0lZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0
	xVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=BK4xzZgnNxjjLBR7jvrhOG6fV0JQvthPob0XLsYf9ulIX0ZOoawSQh6/3xhonRDsS4Mn2XW6UVBaHM/PwJZ8jS05SzVa2p47sIwKyocxMZDNd+uvA1Mum+tBUaO0KF3iXJPsURHrVPYZOd04d4LxqA2qV4a6Ve5iw+W0W0WdCCU=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=Lx5FdCJ2eSvmPiOnGEExcuHYOPXDEBy3PEtwkjj7EwY=;
	h=date:mime-version:subject:message-id:from;

nfp_flower_xmit_pre_tun_flow() keeps using the entry the lookup returned.

nfp_tunnel_lookup_offloaded_macs() wraps rhashtable_lookup_fast(), which
takes an RCU read lock and drops it again before returning the pointer
(include/linux/rhashtable.h:708-719), as its kerneldoc (:703-704) warns,
so kfree_rcu() alone is not enough: a grace period only protects readers
still inside an RCU read-side critical section. The writer is the netdev
notifier chain under rtnl, freeing in nfp_tunnel_del_shared_mac() with
rhashtable_remove_fast() + kfree_rcu(); the reader is the tc flower
offload path, which holds no rtnl, only priv->nfp_fl_lock.

Take rcu_read_lock() before the lookup and rcu_read_unlock() after the
last use of mac_entry, so only the lookup and the read-modify-write of
mac_entry->index are inside the section, with the index copied into a
local variable and nfp_flower_xmit_tun_conf() (GFP_KERNEL) called after
the unlock: the firmware payload is unchanged and kfree_rcu() is kept.

The other two callers run on the notifier chain under rtnl, unchanged.

Fixes: 14690995c141 ("nfp: flower: avoid rmmod nfp crash issues")
Cc: stable@vger.kernel.org
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 .../netronome/nfp/flower/tunnel_conf.c        | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index 0cef0e2b85d0..e1cd75f0af3c 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -188,6 +188,7 @@ enum nfp_flower_mac_offload_cmd {
  * @ref_count:		Number of devs using this MAC address
  * @repr_list:		List of reprs sharing this MAC address
  * @bridge_count:	Number of bridge/internal devs with MAC
+ * @rcu:		RCU head used when freeing the entry
  */
 struct nfp_tun_offloaded_mac {
 	struct rhash_head ht_node;
@@ -196,6 +197,7 @@ struct nfp_tun_offloaded_mac {
 	int ref_count;
 	struct list_head repr_list;
 	int bridge_count;
+	struct rcu_head rcu;
 };
 
 static const struct rhashtable_params offloaded_macs_params = {
@@ -1152,7 +1154,7 @@ nfp_tunnel_add_shared_mac(struct nfp_app *app, struct net_device *netdev,
 	rhashtable_remove_fast(&priv->tun.offloaded_macs, &entry->ht_node,
 			       offloaded_macs_params);
 err_free_entry:
-	kfree(entry);
+	kfree_rcu(entry, rcu);
 err_free_ida:
 	if (ida_idx != -1)
 		ida_free(&priv->tun.mac_off_ids, ida_idx);
@@ -1241,7 +1243,7 @@ nfp_tunnel_del_shared_mac(struct nfp_app *app, struct net_device *netdev,
 		ida_free(&priv->tun.mac_off_ids, ida_idx);
 	}
 
-	kfree(entry);
+	kfree_rcu(entry, rcu);
 
 	return __nfp_tunnel_offload_mac(app, mac, 0, true);
 }
@@ -1433,6 +1435,7 @@ int nfp_flower_xmit_pre_tun_flow(struct nfp_app *app,
 	struct nfp_flower_meta_tci *key_meta;
 	struct nfp_tun_pre_tun_rule payload;
 	struct net_device *internal_dev;
+	u16 mac_idx;
 	int err;
 
 	if (app_priv->pre_tun_rule_cnt == NFP_TUN_PRE_TUN_RULE_LIMIT)
@@ -1447,11 +1450,19 @@ int nfp_flower_xmit_pre_tun_flow(struct nfp_app *app,
 	/* Lookup MAC index for the pre-tunnel rule egress device.
 	 * Note that because the device is always an internal port, it will
 	 * have a constant global index so does not need to be tracked.
+	 *
+	 * rhashtable_lookup_fast() releases its own RCU read lock before it
+	 * returns, so the entry has to be kept alive by a critical section of
+	 * our own. nfp_flower_xmit_tun_conf() allocates an skb with GFP_KERNEL
+	 * and must stay outside of it.
 	 */
+	rcu_read_lock();
 	mac_entry = nfp_tunnel_lookup_offloaded_macs(app,
 						     internal_dev->dev_addr);
-	if (!mac_entry)
+	if (!mac_entry) {
+		rcu_read_unlock();
 		return -ENOENT;
+	}
 
 	/* Set/clear IPV6 bit. cpu_to_be16() swap will lead to MSB being
 	 * set/clear for port_idx.
@@ -1462,7 +1473,10 @@ int nfp_flower_xmit_pre_tun_flow(struct nfp_app *app,
 	else
 		mac_entry->index &= ~NFP_TUN_PRE_TUN_IPV6_BIT;
 
-	payload.port_idx = cpu_to_be16(mac_entry->index);
+	mac_idx = mac_entry->index;
+	rcu_read_unlock();
+
+	payload.port_idx = cpu_to_be16(mac_idx);
 
 	/* Copy mac id and vlan to flow - dev may not exist at delete time. */
 	flow->pre_tun_rule.vlan_tci = payload.vlan_tci;
-- 
2.50.1.windows.1

