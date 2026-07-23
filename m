Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8DB33BBC0
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806635; cv=none; b=maM8vS1/fpzJXW4KVypD3ZReAEw3QJIFOs/3UxU1I/uTdzrfqiqEenwrMOcBjhuujt3IQ8Gcr2tfw47Ulo/zwtJ2JLsYSOmoAOxNfs5nejSOxF3/JkcRBHSbOMEP95ron9aT9MofoGuQjJF+8+QvT4DoHBJAGdPHEtbQ3UaPSpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806635; c=relaxed/simple;
	bh=cENZXmpNOk12JSD2uaVw9nc5WV5mrLeHdak6KBHmyPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IOk7BXVFsU0bEZuWuZR6I6w/nQnt4bUD/TXhehJxni4P7K1MhvfWIYABlTQc8cxp7hXKelAi4t3EOmuHws1Ax+Agj3vAQSSznqOPsK4V0C//MKTYHFlENllcwWI431rXzjwe8liYd1wOBKLbux/U3+WbdDD6ifBTl8m/7WXF0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceMZLW2V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceMZLW2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6C71F00ADB;
	Thu, 23 Jul 2026 11:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806634;
	bh=isG4qN8Zrb2BjFXYPWgtJMRstOX2SEroAveXh7/knJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ceMZLW2VHvxv5c/ULmIauKcCY6Zng/pQU2vNIpjqpbdmot4ujxxlxez58g5o5FTey
	 oxmsdUKYQez+lAF8xdeOxzrB74UMQ+zXEe9IkKFluPHBZlIFlwyZcWzHQ1jfy5rSJp
	 Mun6N3DEv9u1Y/GroCi5+KMR1792FAskDlOJ8GhqwlJoM2iVm+hj7yYTceReGu0kaG
	 rgRktt9FnazE13vloshU3fU+Jl/y2EkzExjlh5QJHQFH4bEwrMGw684hDKK5PEN5lc
	 tuJ4eAKJCycOiFeFcBy7woIQsA8rUDFJ0O7CG7zoKwv4hi2rSjPHOSBG3cdE4ic37Z
	 BIXo5GTORRA+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoze Xie <royenheart@gmail.com>,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/6] netfilter: nf_queue: pin bridge device while NFQUEUE holds fake dst
Date: Thu, 23 Jul 2026 07:37:02 -0400
Message-ID: <20260723113702.3035088-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723113702.3035088-1-sashal@kernel.org>
References: <2026072042-collide-upturned-2e18@gregkh>
 <20260723113702.3035088-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoze Xie <royenheart@gmail.com>

[ Upstream commit c9c9b37f8c5505224e8d206184df3bb668ee00cf ]

The br_netfilter fake rtable is embedded in struct net_bridge and is
attached to bridged packets with skb_dst_set_noref(). If such a packet is
queued to NFQUEUE, __nf_queue() upgrades that fake dst with
skb_dst_force().

At that point the queued skb can hold a real dst reference after bridge
teardown has started. The problem is not that every bridged packet needs
its own dst reference. The problem is that NFQUEUE can keep the bridge
private fake dst alive after unregister begins.

Fix this by keeping the bridge fake dst model unchanged and pinning the
bridge master device only while the packet sits in NFQUEUE. Record the
bridge device in nf_queue_entry when the queued skb carries a bridge fake
dst, take a device reference for the queue lifetime, and drop it when the
queue entry is freed.

Also make sure queued entries are reaped when that bridge device goes
down, and drop the redundant nf_bridge_info_exists() test from the fake
dst detection.

This keeps netdev_priv(br->dev) alive until verdict completion, so the
embedded fake rtable and its metrics backing storage cannot be freed out
from under dst_release(). It also avoids the constant refcount bump and
avoids using ipv4-specific dst helpers for IPv6 bridge traffic.

Fixes: 34666d467cbf ("netfilter: bridge: move br_netfilter out of the core")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Haoze Xie <royenheart@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_queue.h |  1 +
 net/netfilter/nf_queue.c         | 14 ++++++++++++++
 net/netfilter/nfnetlink_queue.c  |  3 +++
 3 files changed, 18 insertions(+)

diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index 9c25e7af2ce825..3e0b166747516a 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -16,6 +16,7 @@ struct nf_queue_entry {
 	unsigned int		id;
 	unsigned int		hook_index;	/* index in hook_entries->hook[] */
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+	struct net_device	*bridge_dev;
 	struct net_device	*physin;
 	struct net_device	*physout;
 #endif
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index 8695e99976cc50..74d85f7a4f5572 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -67,6 +67,7 @@ static void nf_queue_entry_release_refs(struct nf_queue_entry *entry)
 		nf_queue_sock_put(state->sk);
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+	dev_put(entry->bridge_dev);
 	dev_put(entry->physin);
 	dev_put(entry->physout);
 #endif
@@ -83,6 +84,8 @@ static void __nf_queue_entry_init_physdevs(struct nf_queue_entry *entry)
 {
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	const struct sk_buff *skb = entry->skb;
+	struct dst_entry *dst = skb_dst(skb);
+	struct net_device *dev = NULL;
 	struct nf_bridge_info *nf_bridge;
 
 	nf_bridge = nf_bridge_info_get(skb);
@@ -93,6 +96,16 @@ static void __nf_queue_entry_init_physdevs(struct nf_queue_entry *entry)
 		entry->physin = NULL;
 		entry->physout = NULL;
 	}
+
+	if (entry->state.pf == NFPROTO_BRIDGE &&
+	    dst && (dst->flags & DST_FAKE_RTABLE))
+		dev = dst_dev_rcu(dst);
+
+	/* Must hold a reference on the bridge device: dst_hold() protects
+	 * the dst itself, but the fake rtable is embedded in bridge-private
+	 * storage that netdevice teardown can free independently.
+	 */
+	entry->bridge_dev = dev;
 #endif
 }
 
@@ -109,6 +122,7 @@ bool nf_queue_entry_get_refs(struct nf_queue_entry *entry)
 	dev_hold(state->out);
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+	dev_hold(entry->bridge_dev);
 	dev_hold(entry->physin);
 	dev_hold(entry->physout);
 #endif
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index cb98afc2de5a52..4967fc7ddb12f0 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -943,6 +943,9 @@ dev_cmp(struct nf_queue_entry *entry, unsigned long ifindex)
 
 	if (physinif == ifindex || physoutif == ifindex)
 		return 1;
+
+	if (entry->bridge_dev && entry->bridge_dev->ifindex == ifindex)
+		return 1;
 #endif
 	if (entry->skb_dev && entry->skb_dev->ifindex == ifindex)
 		return 1;
-- 
2.53.0

