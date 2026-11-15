Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743278;
	b=FHmDy/4qKTg7+Teabj+mOMtbaLGG+MtmtgQ5vaVKiH3w/ShTQxadLu0bLG/9VmAH1MOA
	 xRkDdIyCZ9nJ7mFWqxFBH0Fe6Sr+Ih2pM2leIGDd2tEr8mKHSMHpXz89lSrhzogoEBY8Z
	 aOmVIAOPt6LAW65Hn8Hr8T8pJfqVqGxU+qelCGi4+sBnO26nHoq7YhZfJgHfuLTSx6a0y
	 iibvYVJ4mK+egXxQhR4qcAgoJ46vGj5Yq5GWY9fO12cHzihstQWPB+xJ1S8oauYmPtZaT
	 tHZ/3YatgwO60+RKRogHAZxmn2FphEkYnkVNsl1naSUgP+A9LhCoAxWP9apWw+UjzvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743278;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=VbMCdBMC51dswZ0iB2igKCow9I2aNhICTuXCg6TbMTk=;
	b=eAIwjqbYjokw96mz32jmxBASUhrGE8cM1GLyuj3yVYkI4jNlH6zKTVEBsmzMvCSF64kS
	 WO6TDZmKf7O4oigRahI7rg84YqccIioWYgdUb2Qtfcc5U4owNBUOvL8R8u6Xh4sorQmhZ
	 WflPwyNumqOP0yJyPwdyHSpAVwmQfo6E2YGtdHgfi6G0SLtmj+Q/YJaICHZbv+tdGzs3w
	 5WvPHTnggQdMEbmZ0yFpKw3GFN6nO7tNZEmF8e9ySCBfSj09IgZLLo8QaVxHZ5FrCvWNX
	 QePnx40Rtlf8V0bXHHh5H8id2QsX7k0OJ5vDyejWTxALkEfOSIe764IrAlNvJRgjZAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=dGLAnL+o;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F80606A896;
	Sun, 15 Nov 2026 11:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5F80606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=dGLAnL+o
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04db;
	Sun, 15 Nov 2026 19:47:48 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, oss-drivers@corigine.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v2] nfp: flower: protect offloaded MAC lifetime and
 preserve its index
Date: Sun, 15 Nov 2026 19:47:46 +0800
Message-ID: <179474326638.103840.8229494258385415595@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df08f65a03a1kunmbac61c98bf77a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEtLVhoaTU0dTUIdS0wZHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	JKVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=dGLAnL+o6d+82yJlfmGp9M2uvJ31CEch04s/k9fR3K/JRsu/bV4c4krfwt1QdX2NmRfn29dLJNrNznKasVYWF9kmzWkJbqpYXhYJbpyQY9Ij2zP8NkE2MXj+xb3I43YUXINn3cW5nk1ZX1eeJWhHQ8JopEVQh28nVtkjtPC3/aM=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=VbMCdBMC51dswZ0iB2igKCow9I2aNhICTuXCg6TbMTk=;
	h=date:mime-version:subject:message-id:from;

The flower offload path uses nfp_fl_lock rather than RTNL. A MAC-table
lookup's internal RCU critical section ends before returning its entry,
while the RTNL notifier can remove that entry and immediately free it.

Add an rcu_head and introduce kfree_rcu() in both the deletion path and
the add rollback path: rollback can remove an entry already visible in
the hash. Hold an outer RCU read lock through copying the index, and
keep the sleeping firmware-message allocation outside it.

Apply the per-rule IPv6 bit to the local copy only. Writing that flag
back into the shared index races with the notifier and breaks the
global-index test that decides whether to release an IDA ID. The flow
already saves the payload index for deletion, so delete retains the
required IPv6 bit without modifying the table. Pair the snapshot's
READ_ONCE with WRITE_ONCE at the three RTNL-serialized index updates.

Found by the author's in-house static analysis tool.

Fixes: 14690995c141 ("nfp: flower: avoid rmmod nfp crash issues")
Fixes: 5c4f5e19d6a8 ("nfp: flower: add ipv6 bit to pre_tunnel control message")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20261108105605.1668-1-getshell@seu.edu.cn/
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 .../netronome/nfp/flower/tunnel_conf.c        | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index 46b6cda..0b1f872 100644
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
@@ -1136,7 +1138,7 @@ nfp_tunnel_add_shared_mac(struct nfp_app *app, struct net_device *netdev,
 		goto err_free_ida;
 	}
 
-	entry->index = nfp_mac_idx;
+	WRITE_ONCE(entry->index, nfp_mac_idx);
 	nfp_tunnel_offloaded_macs_inc_ref_and_link(entry, netdev, mod);
 
 	return 0;
@@ -1145,7 +1147,7 @@ nfp_tunnel_add_shared_mac(struct nfp_app *app, struct net_device *netdev,
 	rhashtable_remove_fast(&priv->tun.offloaded_macs, &entry->ht_node,
 			       offloaded_macs_params);
 err_free_entry:
-	kfree(entry);
+	kfree_rcu(entry, rcu);
 err_free_ida:
 	if (ida_idx != -1)
 		ida_free(&priv->tun.mac_off_ids, ida_idx);
@@ -1188,7 +1190,7 @@ nfp_tunnel_del_shared_mac(struct nfp_app *app, struct net_device *netdev,
 				return 0;
 			}
 
-			entry->index = nfp_mac_idx;
+			WRITE_ONCE(entry->index, nfp_mac_idx);
 			return 0;
 		}
 	}
@@ -1212,7 +1214,7 @@ nfp_tunnel_del_shared_mac(struct nfp_app *app, struct net_device *netdev,
 
 		ida_idx = nfp_tunnel_get_ida_from_global_mac_idx(entry->index);
 		ida_free(&priv->tun.mac_off_ids, ida_idx);
-		entry->index = nfp_mac_idx;
+		WRITE_ONCE(entry->index, nfp_mac_idx);
 		return 0;
 	}
 
@@ -1234,7 +1236,7 @@ nfp_tunnel_del_shared_mac(struct nfp_app *app, struct net_device *netdev,
 		ida_free(&priv->tun.mac_off_ids, ida_idx);
 	}
 
-	kfree(entry);
+	kfree_rcu(entry, rcu);
 
 	return __nfp_tunnel_offload_mac(app, mac, 0, true);
 }
@@ -1426,6 +1428,7 @@ int nfp_flower_xmit_pre_tun_flow(struct nfp_app *app,
 	struct nfp_flower_meta_tci *key_meta;
 	struct nfp_tun_pre_tun_rule payload;
 	struct net_device *internal_dev;
+	u16 mac_idx;
 	int err;
 
 	if (app_priv->pre_tun_rule_cnt == NFP_TUN_PRE_TUN_RULE_LIMIT)
@@ -1441,21 +1444,26 @@ int nfp_flower_xmit_pre_tun_flow(struct nfp_app *app,
 	 * Note that because the device is always an internal port, it will
 	 * have a constant global index so does not need to be tracked.
 	 */
+	rcu_read_lock();
 	mac_entry = nfp_tunnel_lookup_offloaded_macs(app,
 						     internal_dev->dev_addr);
-	if (!mac_entry)
+	if (!mac_entry) {
+		rcu_read_unlock();
 		return -ENOENT;
+	}
+	mac_idx = READ_ONCE(mac_entry->index);
+	rcu_read_unlock();
 
 	/* Set/clear IPV6 bit. cpu_to_be16() swap will lead to MSB being
 	 * set/clear for port_idx.
 	 */
 	key_meta = (struct nfp_flower_meta_tci *)flow->unmasked_data;
 	if (key_meta->nfp_flow_key_layer & NFP_FLOWER_LAYER_IPV6)
-		mac_entry->index |= NFP_TUN_PRE_TUN_IPV6_BIT;
+		mac_idx |= NFP_TUN_PRE_TUN_IPV6_BIT;
 	else
-		mac_entry->index &= ~NFP_TUN_PRE_TUN_IPV6_BIT;
+		mac_idx &= ~NFP_TUN_PRE_TUN_IPV6_BIT;
 
-	payload.port_idx = cpu_to_be16(mac_entry->index);
+	payload.port_idx = cpu_to_be16(mac_idx);
 
 	/* Copy mac id and vlan to flow - dev may not exist at delete time. */
 	flow->pre_tun_rule.vlan_tci = payload.vlan_tci;
-- 
2.50.1.windows.1
