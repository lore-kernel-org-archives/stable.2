Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01E3233954
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098586; cv=none; b=gcJJno0/GLEMlV1it9kqwezgIF79BIdMqndb6EI5zxzOl1QhzB48BqAzC7rsPZeD7pxhpxBjJyRxBOBoM07QluHpLbLuXxJlJcjVuusXZKgdfGxZrhovel1ltfIqAlsmvrjTQw6gZEmuHO1Pp8qteDFT4XadMnmJcg5lm41gIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098586; c=relaxed/simple;
	bh=D8TcBG0IDh5wfrLcIL4dN9WIJH4gCGhii9BmrbwIC0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jr3PvugCrzfvwa4nnHEMq6E4kmcMSMUYtFWty1TlFTu1tp3dcEXayD0w6tg4MqlwyssEJfun4MKTTXhCAR8FnEJaa6xmNpCldxmUslZYbHkK/NWXqWUaR0JOeemy+nhHHPWu2/PRbM/0b7K9h/vigFriVCo8DBMTmFY+zv0FQ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etm74Tdv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etm74Tdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589591F00893;
	Fri, 29 May 2026 23:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780098584;
	bh=K4OpqG5xUY7sWQCGlBWnEu4Lt6ipVk9BrUdry0BtZLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=etm74Tdv0aUsC/JpDj9iTHLKlZeU9VlfEwsR0ILJISmY+2u35GRA2vfEJ6zS8ooqv
	 Tw+KNMxxEBcCsCxxTbtJ+7NvuCC/t5+3MehKgDgqB62Z+4m/ZwFoam4DWm9EvdGOBr
	 OTKzlp3t88cupVHDmIyXKdTnRr8ofRyvhlH6QyFM1l+YqsdqGaqGFXeRfgh9P7pU4r
	 iicQ3uKUXTQut4MB3kl42G1n9SPsyO+aNLsuhdZD6AUqu/d9ejbptJdy6P3nJ+H6iU
	 8/WwE8tI6YUJzSXwY4sMgwaVBnknG8KcxKgyRexU8ejzSlwzf6TSgmeXDUobY1tMlG
	 SyETDOsLz/UpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yajun Deng <yajun.deng@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] net: Remove redundant if statements
Date: Fri, 29 May 2026 19:49:41 -0400
Message-ID: <20260529234942.1939638-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052832-chamomile-jazz-bc30@gregkh>
References: <2026052832-chamomile-jazz-bc30@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yajun Deng <yajun.deng@linux.dev>

[ Upstream commit 1160dfa178eb848327e9dec39960a735f4dc1685 ]

The 'if (dev)' statement already move into dev_{put , hold}, so remove
redundant if statements.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: e196115ec330 ("netfilter: nf_queue: hold bridge skb->dev while queued")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/batman-adv/bridge_loop_avoidance.c |  6 ++----
 net/batman-adv/distributed-arp-table.c |  3 +--
 net/batman-adv/gateway_client.c        |  3 +--
 net/batman-adv/multicast.c             |  9 +++------
 net/batman-adv/originator.c            | 12 ++++--------
 net/batman-adv/translation-table.c     |  9 +++------
 net/can/raw.c                          |  8 ++------
 net/core/dev.c                         |  6 ++----
 net/core/drop_monitor.c                |  6 ++----
 net/core/dst.c                         |  6 ++----
 net/core/neighbour.c                   | 15 +++++----------
 net/ethtool/netlink.c                  |  6 ++----
 net/ieee802154/nl-phy.c                |  3 +--
 net/ieee802154/nl802154.c              |  3 +--
 net/ieee802154/socket.c                |  3 +--
 net/ipv4/fib_semantics.c               |  4 +---
 net/ipv4/route.c                       |  3 +--
 net/ipv6/addrconf.c                    |  6 ++----
 net/ipv6/ip6mr.c                       |  3 +--
 net/ipv6/route.c                       |  3 +--
 net/netfilter/nf_queue.c               | 24 ++++++++----------------
 net/netlabel/netlabel_unlabeled.c      |  6 ++----
 net/netrom/nr_loopback.c               |  3 +--
 net/netrom/nr_route.c                  |  3 +--
 net/packet/af_packet.c                 | 15 +++++----------
 net/phonet/af_phonet.c                 |  3 +--
 net/phonet/pn_dev.c                    |  6 ++----
 net/phonet/socket.c                    |  3 +--
 net/sched/act_mirred.c                 |  6 ++----
 net/smc/smc_pnet.c                     |  3 +--
 net/wireless/nl80211.c                 | 16 +++++-----------
 net/wireless/scan.c                    |  3 +--
 32 files changed, 68 insertions(+), 140 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 986f707e7d973..5f5ceaab386b3 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -2352,8 +2352,7 @@ int batadv_bla_claim_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 
-	if (soft_iface)
-		dev_put(soft_iface);
+	dev_put(soft_iface);
 
 	return ret;
 }
@@ -2590,8 +2589,7 @@ int batadv_bla_backbone_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 
-	if (soft_iface)
-		dev_put(soft_iface);
+	dev_put(soft_iface);
 
 	return ret;
 }
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index ddd3b4c70a516..cae9cf3bff3f8 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1042,8 +1042,7 @@ int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	if (primary_if)
 		batadv_hardif_put(primary_if);
 
-	if (soft_iface)
-		dev_put(soft_iface);
+	dev_put(soft_iface);
 
 	return ret;
 }
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 62f6f13f89ffd..e612721576185 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -586,8 +586,7 @@ int batadv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb)
 out:
 	if (primary_if)
 		batadv_hardif_put(primary_if);
-	if (soft_iface)
-		dev_put(soft_iface);
+	dev_put(soft_iface);
 
 	return ret;
 }
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index c8a341cd652c7..36f2e84817095 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -92,8 +92,7 @@ static struct net_device *batadv_mcast_get_bridge(struct net_device *soft_iface)
 		upper = netdev_master_upper_dev_get_rcu(upper);
 	} while (upper && !(upper->priv_flags & IFF_EBRIDGE));
 
-	if (upper)
-		dev_hold(upper);
+	dev_hold(upper);
 	rcu_read_unlock();
 
 	return upper;
@@ -541,8 +540,7 @@ batadv_mcast_mla_softif_get(struct net_device *dev,
 	}
 
 out:
-	if (bridge)
-		dev_put(bridge);
+	dev_put(bridge);
 
 	return ret4 + ret6;
 }
@@ -2386,8 +2384,7 @@ batadv_mcast_netlink_get_primary(struct netlink_callback *cb,
 	}
 
 out:
-	if (soft_iface)
-		dev_put(soft_iface);
+	dev_put(soft_iface);
 
 	if (!ret && primary_if)
 		*primary_if = hard_iface;
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index cbebe3aa1f604..aa2b61054128d 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -823,12 +823,10 @@ int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb)
  out:
 	if (hardif)
 		batadv_hardif_put(hardif);
-	if (hard_iface)
-		dev_put(hard_iface);
+	dev_put(hard_iface);
 	if (primary_if)
 		batadv_hardif_put(primary_if);
-	if (soft_iface)
-		dev_put(soft_iface);
+	dev_put(soft_iface);
 
 	return ret;
 }
@@ -1502,12 +1500,10 @@ int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb)
  out:
 	if (hardif)
 		batadv_hardif_put(hardif);
-	if (hard_iface)
-		dev_put(hard_iface);
+	dev_put(hard_iface);
 	if (primary_if)
 		batadv_hardif_put(primary_if);
-	if (soft_iface)
-		dev_put(soft_iface);
+	dev_put(soft_iface);
 
 	return ret;
 }
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 73f1ab4f008c4..a64e6d3d30669 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -815,8 +815,7 @@ bool batadv_tt_local_add(struct net_device *soft_iface, const u8 *addr,
 out:
 	if (in_hardif)
 		batadv_hardif_put(in_hardif);
-	if (in_dev)
-		dev_put(in_dev);
+	dev_put(in_dev);
 	if (tt_local)
 		batadv_tt_local_entry_put(tt_local);
 	if (tt_global)
@@ -1310,8 +1309,7 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
  out:
 	if (primary_if)
 		batadv_hardif_put(primary_if);
-	if (soft_iface)
-		dev_put(soft_iface);
+	dev_put(soft_iface);
 
 	cb->args[0] = bucket;
 	cb->args[1] = idx;
@@ -2231,8 +2229,7 @@ int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb)
  out:
 	if (primary_if)
 		batadv_hardif_put(primary_if);
-	if (soft_iface)
-		dev_put(soft_iface);
+	dev_put(soft_iface);
 
 	cb->args[0] = bucket;
 	cb->args[1] = idx;
diff --git a/net/can/raw.c b/net/can/raw.c
index 069657f681afa..5532fae4ce30f 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -592,9 +592,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		ro->count  = count;
 
  out_fil:
-		if (dev)
-			dev_put(dev);
-
+		dev_put(dev);
 		release_sock(sk);
 		rtnl_unlock();
 
@@ -638,9 +636,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 		ro->err_mask = err_mask;
 
  out_err:
-		if (dev)
-			dev_put(dev);
-
+		dev_put(dev);
 		release_sock(sk);
 		rtnl_unlock();
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 9e1e87536c1ee..9183fbc434d22 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -906,8 +906,7 @@ struct net_device *dev_get_by_name(struct net *net, const char *name)
 
 	rcu_read_lock();
 	dev = dev_get_by_name_rcu(net, name);
-	if (dev)
-		dev_hold(dev);
+	dev_hold(dev);
 	rcu_read_unlock();
 	return dev;
 }
@@ -980,8 +979,7 @@ struct net_device *dev_get_by_index(struct net *net, int ifindex)
 
 	rcu_read_lock();
 	dev = dev_get_by_index_rcu(net, ifindex);
-	if (dev)
-		dev_hold(dev);
+	dev_hold(dev);
 	rcu_read_unlock();
 	return dev;
 }
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index c8a3d6056365f..66112797f1aac 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -854,8 +854,7 @@ net_dm_hw_metadata_copy(const struct devlink_trap_metadata *metadata)
 	}
 
 	hw_metadata->input_dev = metadata->input_dev;
-	if (hw_metadata->input_dev)
-		dev_hold(hw_metadata->input_dev);
+	dev_hold(hw_metadata->input_dev);
 
 	return hw_metadata;
 
@@ -871,8 +870,7 @@ net_dm_hw_metadata_copy(const struct devlink_trap_metadata *metadata)
 static void
 net_dm_hw_metadata_free(const struct devlink_trap_metadata *hw_metadata)
 {
-	if (hw_metadata->input_dev)
-		dev_put(hw_metadata->input_dev);
+	dev_put(hw_metadata->input_dev);
 	kfree(hw_metadata->fa_cookie);
 	kfree(hw_metadata->trap_name);
 	kfree(hw_metadata->trap_group_name);
diff --git a/net/core/dst.c b/net/core/dst.c
index 5bb1438573367..6d74b4663085f 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -49,8 +49,7 @@ void dst_init(struct dst_entry *dst, struct dst_ops *ops,
 	      unsigned short flags)
 {
 	dst->dev = dev;
-	if (dev)
-		dev_hold(dev);
+	dev_hold(dev);
 	dst->ops = ops;
 	dst_init_metrics(dst, dst_default_metrics.metrics, true);
 	dst->expires = 0UL;
@@ -111,8 +110,7 @@ struct dst_entry *dst_destroy(struct dst_entry * dst)
 #endif
 	if (dst->ops->destroy)
 		dst->ops->destroy(dst);
-	if (dst->dev)
-		dev_put(dst->dev);
+	dev_put(dst->dev);
 
 	lwtstate_put(dst->lwtstate);
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 37f7bcbc2adcc..e99accbf8db1d 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -743,12 +743,10 @@ struct pneigh_entry * pneigh_lookup(struct neigh_table *tbl,
 	write_pnet(&n->net, net);
 	memcpy(n->key, pkey, key_len);
 	n->dev = dev;
-	if (dev)
-		dev_hold(dev);
+	dev_hold(dev);
 
 	if (tbl->pconstructor && tbl->pconstructor(n)) {
-		if (dev)
-			dev_put(dev);
+		dev_put(dev);
 		kfree(n);
 		n = NULL;
 		goto out;
@@ -780,8 +778,7 @@ int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 			write_unlock_bh(&tbl->lock);
 			if (tbl->pdestructor)
 				tbl->pdestructor(n);
-			if (n->dev)
-				dev_put(n->dev);
+			dev_put(n->dev);
 			kfree(n);
 			return 0;
 		}
@@ -814,8 +811,7 @@ static int pneigh_ifdown_and_unlock(struct neigh_table *tbl,
 		n->next = NULL;
 		if (tbl->pdestructor)
 			tbl->pdestructor(n);
-		if (n->dev)
-			dev_put(n->dev);
+		dev_put(n->dev);
 		kfree(n);
 	}
 	return -ENOENT;
@@ -1677,8 +1673,7 @@ void neigh_parms_release(struct neigh_table *tbl, struct neigh_parms *parms)
 	list_del(&parms->list);
 	parms->dead = 1;
 	write_unlock_bh(&tbl->lock);
-	if (parms->dev)
-		dev_put(parms->dev);
+	dev_put(parms->dev);
 	call_rcu(&parms->rcu_head, neigh_rcu_free_parms);
 }
 EXPORT_SYMBOL(neigh_parms_release);
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 25a55086d2b66..fc969d1206366 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -356,8 +356,7 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 		ops->cleanup_data(reply_data);
 
 	genlmsg_end(rskb, reply_payload);
-	if (req_info->dev)
-		dev_put(req_info->dev);
+	dev_put(req_info->dev);
 	kfree(reply_data);
 	kfree(req_info);
 	return genlmsg_reply(rskb, info);
@@ -369,8 +368,7 @@ static int ethnl_default_doit(struct sk_buff *skb, struct genl_info *info)
 	if (ops->cleanup_data)
 		ops->cleanup_data(reply_data);
 err_dev:
-	if (req_info->dev)
-		dev_put(req_info->dev);
+	dev_put(req_info->dev);
 	kfree(reply_data);
 	kfree(req_info);
 	return ret;
diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 88215b5c93aa4..dd5a45f8a78a0 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -340,8 +340,7 @@ int ieee802154_del_iface(struct sk_buff *skb, struct genl_info *info)
 out_dev:
 	wpan_phy_put(phy);
 out:
-	if (dev)
-		dev_put(dev);
+	dev_put(dev);
 
 	return rc;
 }
diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index a493965f157f2..e5156a92186d8 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -2230,8 +2230,7 @@ static void nl802154_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		if (ops->internal_flags & NL802154_FLAG_NEED_WPAN_DEV) {
 			struct wpan_dev *wpan_dev = info->user_ptr[1];
 
-			if (wpan_dev->netdev)
-				dev_put(wpan_dev->netdev);
+			dev_put(wpan_dev->netdev);
 		} else {
 			dev_put(info->user_ptr[1]);
 		}
diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index c8b9efc92b45a..5ea87f4f76c83 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -41,8 +41,7 @@ ieee802154_get_dev(struct net *net, const struct ieee802154_addr *addr)
 		ieee802154_devaddr_to_raw(hwaddr, addr->extended_addr);
 		rcu_read_lock();
 		dev = dev_getbyhwaddr_rcu(net, ARPHRD_IEEE802154, hwaddr);
-		if (dev)
-			dev_hold(dev);
+		dev_hold(dev);
 		rcu_read_unlock();
 		break;
 	case IEEE802154_ADDR_SHORT:
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 48516a403a9bb..e1a8e00658ba5 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -210,9 +210,7 @@ static void rt_fibinfo_free_cpus(struct rtable __rcu * __percpu *rtp)
 
 void fib_nh_common_release(struct fib_nh_common *nhc)
 {
-	if (nhc->nhc_dev)
-		dev_put(nhc->nhc_dev);
-
+	dev_put(nhc->nhc_dev);
 	lwtstate_put(nhc->nhc_lwtstate);
 	rt_fibinfo_free_cpus(nhc->nhc_pcpu_rth_output);
 	rt_fibinfo_free(&nhc->nhc_rth_input);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f260253fed8d3..023a3a0c84a7a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2782,8 +2782,7 @@ struct dst_entry *ipv4_blackhole_route(struct net *net, struct dst_entry *dst_or
 		new->output = dst_discard_out;
 
 		new->dev = net->loopback_dev;
-		if (new->dev)
-			dev_hold(new->dev);
+		dev_hold(new->dev);
 
 		rt->rt_is_input = ort->rt_is_input;
 		rt->rt_iif = ort->rt_iif;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 758cea239e618..251164ee64698 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -693,8 +693,7 @@ static int inet6_netconf_get_devconf(struct sk_buff *in_skb,
 errout:
 	if (in6_dev)
 		in6_dev_put(in6_dev);
-	if (dev)
-		dev_put(dev);
+	dev_put(dev);
 	return err;
 }
 
@@ -5469,8 +5468,7 @@ static int inet6_rtm_getaddr(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 errout_ifa:
 	in6_ifa_put(ifa);
 errout:
-	if (dev)
-		dev_put(dev);
+	dev_put(dev);
 	if (fillargs.netnsid >= 0)
 		put_net(tgt_net);
 
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 926baaf8661cc..c6fc951b01476 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -561,8 +561,7 @@ static int pim6_rcv(struct sk_buff *skb)
 	read_lock(&mrt_lock);
 	if (reg_vif_num >= 0)
 		reg_dev = mrt->vif_table[reg_vif_num].dev;
-	if (reg_dev)
-		dev_hold(reg_dev);
+	dev_hold(reg_dev);
 	read_unlock(&mrt_lock);
 
 	if (!reg_dev)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 27736b5847378..9726c5002dbdf 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3521,8 +3521,7 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 		fib_nh_common_release(&fib6_nh->nh_common);
 		fib6_nh->nh_common.nhc_pcpu_rth_output = NULL;
 		fib6_nh->fib_nh_lws = NULL;
-		if (dev)
-			dev_put(dev);
+		dev_put(dev);
 	}
 
 	return err;
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index bb8607ff94bc7..d7542c5c4ae61 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -60,18 +60,14 @@ static void nf_queue_entry_release_refs(struct nf_queue_entry *entry)
 	struct nf_hook_state *state = &entry->state;
 
 	/* Release those devices we held, or Alexey will kill me. */
-	if (state->in)
-		dev_put(state->in);
-	if (state->out)
-		dev_put(state->out);
+	dev_put(state->in);
+	dev_put(state->out);
 	if (state->sk)
 		nf_queue_sock_put(state->sk);
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
-	if (entry->physin)
-		dev_put(entry->physin);
-	if (entry->physout)
-		dev_put(entry->physout);
+	dev_put(entry->physin);
+	dev_put(entry->physout);
 #endif
 }
 
@@ -107,16 +103,12 @@ bool nf_queue_entry_get_refs(struct nf_queue_entry *entry)
 	if (state->sk && !refcount_inc_not_zero(&state->sk->sk_refcnt))
 		return false;
 
-	if (state->in)
-		dev_hold(state->in);
-	if (state->out)
-		dev_hold(state->out);
+	dev_hold(state->in);
+	dev_hold(state->out);
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
-	if (entry->physin)
-		dev_hold(entry->physin);
-	if (entry->physout)
-		dev_hold(entry->physout);
+	dev_hold(entry->physin);
+	dev_hold(entry->physout);
 #endif
 	return true;
 }
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index 3049fff0b7f86..ea22487d3d3ca 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -492,8 +492,7 @@ static int netlbl_unlhsh_remove_addr4(struct net *net,
 		netlbl_af4list_audit_addr(audit_buf, 1,
 					  (dev != NULL ? dev->name : NULL),
 					  addr->s_addr, mask->s_addr);
-		if (dev != NULL)
-			dev_put(dev);
+		dev_put(dev);
 		if (entry != NULL &&
 		    security_secid_to_secctx(entry->secid,
 					     &secctx, &secctx_len) == 0) {
@@ -553,8 +552,7 @@ static int netlbl_unlhsh_remove_addr6(struct net *net,
 		netlbl_af6list_audit_addr(audit_buf, 1,
 					  (dev != NULL ? dev->name : NULL),
 					  addr, mask);
-		if (dev != NULL)
-			dev_put(dev);
+		dev_put(dev);
 		if (entry != NULL &&
 		    security_secid_to_secctx(entry->secid,
 					     &secctx, &secctx_len) == 0) {
diff --git a/net/netrom/nr_loopback.c b/net/netrom/nr_loopback.c
index a880dd33e901c..511819fbfa679 100644
--- a/net/netrom/nr_loopback.c
+++ b/net/netrom/nr_loopback.c
@@ -59,8 +59,7 @@ static void nr_loopback_timer(struct timer_list *unused)
 		if (dev == NULL || nr_rx_frame(skb, dev) == 0)
 			kfree_skb(skb);
 
-		if (dev != NULL)
-			dev_put(dev);
+		dev_put(dev);
 
 		if (!skb_queue_empty(&loopback_queue) && !nr_loopback_running())
 			mod_timer(&loopback_timer, jiffies + 10);
diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 9ea038b5d6ca2..f8896c6cfa61c 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -573,8 +573,7 @@ struct net_device *nr_dev_first(void)
 			if (first == NULL || strncmp(dev->name, first->name, 3) < 0)
 				first = dev;
 	}
-	if (first)
-		dev_hold(first);
+	dev_hold(first);
 	rcu_read_unlock();
 
 	return first;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 1c9b2d67c3ed4..ece5f09876f02 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -249,8 +249,7 @@ static struct net_device *packet_cached_dev_get(struct packet_sock *po)
 
 	rcu_read_lock();
 	dev = rcu_dereference(po->cached_dev);
-	if (likely(dev))
-		dev_hold(dev);
+	dev_hold(dev);
 	rcu_read_unlock();
 
 	return dev;
@@ -3098,8 +3097,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 out_free:
 	kfree_skb(skb);
 out_unlock:
-	if (dev)
-		dev_put(dev);
+	dev_put(dev);
 out:
 	return err;
 }
@@ -3236,8 +3234,7 @@ static int packet_do_bind(struct sock *sk, const char *name, int ifindex,
 		}
 	}
 
-	if (dev)
-		dev_hold(dev);
+	dev_hold(dev);
 
 	proto_curr = po->prot_hook.type;
 	dev_curr = po->prot_hook.dev;
@@ -3274,8 +3271,7 @@ static int packet_do_bind(struct sock *sk, const char *name, int ifindex,
 			packet_cached_dev_assign(po, dev);
 		}
 	}
-	if (dev_curr)
-		dev_put(dev_curr);
+	dev_put(dev_curr);
 
 	if (proto == 0 || !need_rehook)
 		goto out_unlock;
@@ -4211,8 +4207,7 @@ static int packet_notifier(struct notifier_block *this,
 				if (msg == NETDEV_UNREGISTER) {
 					packet_cached_dev_reset(po);
 					WRITE_ONCE(po->ifindex, -1);
-					if (po->prot_hook.dev)
-						dev_put(po->prot_hook.dev);
+					dev_put(po->prot_hook.dev);
 					po->prot_hook.dev = NULL;
 				}
 				spin_unlock(&po->bind_lock);
diff --git a/net/phonet/af_phonet.c b/net/phonet/af_phonet.c
index ca6ae4c59433f..65218b7ce9f94 100644
--- a/net/phonet/af_phonet.c
+++ b/net/phonet/af_phonet.c
@@ -275,8 +275,7 @@ int pn_skb_send(struct sock *sk, struct sk_buff *skb,
 
 drop:
 	kfree_skb(skb);
-	if (dev)
-		dev_put(dev);
+	dev_put(dev);
 	return err;
 }
 EXPORT_SYMBOL(pn_skb_send);
diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index ac0fae06cc153..7e0752f34ce77 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -122,8 +122,7 @@ struct net_device *phonet_device_get(struct net *net)
 			break;
 		dev = NULL;
 	}
-	if (dev)
-		dev_hold(dev);
+	dev_hold(dev);
 	rcu_read_unlock();
 	return dev;
 }
@@ -411,8 +410,7 @@ struct net_device *phonet_route_output(struct net *net, u8 daddr)
 	daddr >>= 2;
 	rcu_read_lock();
 	dev = rcu_dereference(routes->table[daddr]);
-	if (dev)
-		dev_hold(dev);
+	dev_hold(dev);
 	rcu_read_unlock();
 
 	if (!dev)
diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index 2599235d592e0..71e2caf6ab859 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -379,8 +379,7 @@ static int pn_socket_ioctl(struct socket *sock, unsigned int cmd,
 			saddr = PN_NO_ADDR;
 		release_sock(sk);
 
-		if (dev)
-			dev_put(dev);
+		dev_put(dev);
 		if (saddr == PN_NO_ADDR)
 			return -EHOSTUNREACH;
 
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 07b9f8335f05a..270b9fc07ee0f 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -79,8 +79,7 @@ static void tcf_mirred_release(struct tc_action *a)
 
 	/* last reference to action, no need to lock */
 	dev = rcu_dereference_protected(m->tcfm_dev, 1);
-	if (dev)
-		dev_put(dev);
+	dev_put(dev);
 }
 
 static const struct nla_policy mirred_policy[TCA_MIRRED_MAX + 1] = {
@@ -181,8 +180,7 @@ static int tcf_mirred_init(struct net *net, struct nlattr *nla,
 		mac_header_xmit = dev_is_mac_header_xmit(dev);
 		dev = rcu_replace_pointer(m->tcfm_dev, dev,
 					  lockdep_is_held(&m->tcf_lock));
-		if (dev)
-			dev_put(dev);
+		dev_put(dev);
 		m->tcfm_mac_header_xmit = mac_header_xmit;
 	}
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 7824b32cdb66c..83ab8e293c67f 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -395,8 +395,7 @@ static int smc_pnet_add_eth(struct smc_pnettable *pnettable, struct net *net,
 	return 0;
 
 out_put:
-	if (ndev)
-		dev_put(ndev);
+	dev_put(ndev);
 	return rc;
 }
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9d84e7c845bcf..33e2c29fbd3fd 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6356,8 +6356,7 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	err = rdev_change_station(rdev, dev, mac_addr, &params);
 
  out_put_vlan:
-	if (params.vlan)
-		dev_put(params.vlan);
+	dev_put(params.vlan);
 
 	return err;
 }
@@ -6592,8 +6591,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 
 	err = rdev_add_station(rdev, dev, mac_addr, &params);
 
-	if (params.vlan)
-		dev_put(params.vlan);
+	dev_put(params.vlan);
 	return err;
 }
 
@@ -8308,8 +8306,7 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 		goto out_free;
 
 	nl80211_send_scan_start(rdev, wdev);
-	if (wdev->netdev)
-		dev_hold(wdev->netdev);
+	dev_hold(wdev->netdev);
 
 	return 0;
 
@@ -14661,9 +14658,7 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 			return -ENETDOWN;
 		}
 
-		if (dev)
-			dev_hold(dev);
-
+		dev_hold(dev);
 		info->user_ptr[0] = rdev;
 	}
 
@@ -14677,8 +14672,7 @@ static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		if (ops->internal_flags & NL80211_FLAG_NEED_WDEV) {
 			struct wireless_dev *wdev = info->user_ptr[1];
 
-			if (wdev->netdev)
-				dev_put(wdev->netdev);
+			dev_put(wdev->netdev);
 		} else {
 			dev_put(info->user_ptr[1]);
 		}
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index a09fb52910082..aeb40ec867656 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1057,8 +1057,7 @@ void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
 	}
 #endif
 
-	if (wdev->netdev)
-		dev_put(wdev->netdev);
+	dev_put(wdev->netdev);
 
 	kfree(rdev->int_scan_req);
 	rdev->int_scan_req = NULL;
-- 
2.53.0

