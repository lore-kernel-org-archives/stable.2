Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CBD419308
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550944; cv=none; b=Es9YD5jRfcJH0lL0tAGrHBpOa8cRLuLScB0j7Fe5UBXBVPzZKbIc2j0ZGmGkR0MubpsLcVhDYPgMGh7HMtiwPFsLDrjd1dT1d4RtrYIStsNvdB3kzLLZ2ngWs1hswfiFvfjNLtlpGiIjSE9OePWOg0OjlhNMB9C/GbV9Bin7kro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550944; c=relaxed/simple;
	bh=iHiWDaJxkPXPBXs8T0mxPCeWxl8xrGbg4iGMYfZ5DWE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Uw5N6JbyMqVdJwNOsbeifZoXTtBdw5I/y9KIVRgbg285c1jbdIh8dObSjDcPELo5CXB5o5WefiUTwJ3bEjIVRXOglQ2t57xtTbwfFOKcmoQoflEyllQfs2xlsjmI4/5oeb8BYwo0XmPktDZhuQO0H8JImVajvATaXMJT9WY6PXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ldtTF2sV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ldtTF2sV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1139C1F000E9;
	Mon, 20 Jul 2026 12:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550943;
	bh=cEThM1Vf0m3s00EGCl8mgVAM0dsVc11JwIfzFqxVZo0=;
	h=Subject:To:Cc:From:Date;
	b=ldtTF2sVsrtnShRXa36wW5TkbA2wLVZwZXjr2CIW9AEcH2rDguxBzzuzg3Md8l7dE
	 7iomJS1gebJ1SZ3+VpRdcnMR4gJ/ZF7+nJsYkAg/8EZHzskAi74ASv2lPZo3dbfNGY
	 h5uw286yo+kdItAaZoQIV0xI1dtNmdfPQstVqj7g=
Subject: FAILED: patch "[PATCH] netfilter: nf_queue: pin bridge device while NFQUEUE holds" failed to apply to 5.15-stable tree
To: royenheart@gmail.com,bird@lzu.edu.cn,n05ec@lzu.edu.cn,pablo@netfilter.org,tomapufckgml@gmail.com,yifanwucs@gmail.com,yuantan098@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:33:42 +0200
Message-ID: <2026072042-collide-upturned-2e18@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c9c9b37f8c5505224e8d206184df3bb668ee00cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072042-collide-upturned-2e18@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c9c9b37f8c5505224e8d206184df3bb668ee00cf Mon Sep 17 00:00:00 2001
From: Haoze Xie <royenheart@gmail.com>
Date: Mon, 8 Jun 2026 13:43:44 +0800
Subject: [PATCH] netfilter: nf_queue: pin bridge device while NFQUEUE holds
 fake dst

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

diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
index 3978c3174cdb..fc3e81c07364 100644
--- a/include/net/netfilter/nf_queue.h
+++ b/include/net/netfilter/nf_queue.h
@@ -18,6 +18,7 @@ struct nf_queue_entry {
 	unsigned int		id;
 	unsigned int		hook_index;	/* index in hook_entries->hook[] */
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+	struct net_device	*bridge_dev;
 	struct net_device	*physin;
 	struct net_device	*physout;
 #endif
diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index 57b450024a99..73363ceedebe 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -68,6 +68,7 @@ static void nf_queue_entry_release_refs(struct nf_queue_entry *entry)
 		nf_queue_sock_put(state->sk);
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+	dev_put(entry->bridge_dev);
 	dev_put(entry->physin);
 	dev_put(entry->physout);
 #endif
@@ -84,6 +85,8 @@ static void __nf_queue_entry_init_physdevs(struct nf_queue_entry *entry)
 {
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	const struct sk_buff *skb = entry->skb;
+	struct dst_entry *dst = skb_dst(skb);
+	struct net_device *dev = NULL;
 
 	if (nf_bridge_info_exists(skb)) {
 		entry->physin = nf_bridge_get_physindev(skb, entry->state.net);
@@ -92,6 +95,16 @@ static void __nf_queue_entry_init_physdevs(struct nf_queue_entry *entry)
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
 
@@ -108,6 +121,7 @@ bool nf_queue_entry_get_refs(struct nf_queue_entry *entry)
 	dev_hold(state->out);
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
+	dev_hold(entry->bridge_dev);
 	dev_hold(entry->physin);
 	dev_hold(entry->physout);
 #endif
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index c5e29fec419b..80ca077b81bd 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -1262,6 +1262,9 @@ dev_cmp(struct nf_queue_entry *entry, unsigned long ifindex)
 
 	if (physinif == ifindex || physoutif == ifindex)
 		return 1;
+
+	if (entry->bridge_dev && entry->bridge_dev->ifindex == ifindex)
+		return 1;
 #endif
 	if (entry->skb_dev && entry->skb_dev->ifindex == ifindex)
 		return 1;

