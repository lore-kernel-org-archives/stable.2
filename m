Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281C323BD17
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199702; cv=none; b=USktXg9JYntX7nVEjVZrNNxQbV5tJ/CH4mbiuTMTFzNtkMjQqoT2ia3o76wZNzTOP871IwYRclQpEIpsJm6z4dRGARd592hasZb6AlNq4L3/3j1Ppux6WSp5ULEF15Y7teyX4B+e644Ahg8R0/4+pKs1htNTr6F63e81ccydbiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199702; c=relaxed/simple;
	bh=lDwo0zlIsjJwRPcFIwSF+FjaAmoWyCj5KJ+xYO9Z7oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcKlTiNF3fnRtilR6L4GX8AudgvAtQ3xK1LZq1pqhQ6EcmywMmCw//kGxBjarCyaLJyTGKjb0tsiYs3fLNv26tFld1JXY0n31gmq/evIcDMzkAgsmLusCopCoyMhMzlmt3hyE4cguGg75TcbxlyZlXnwxbnClkmb/RYBqTOBQiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9pY4bKx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9pY4bKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B701F00A3F;
	Thu, 20 Aug 2026 04:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787199701;
	bh=GyISr73KJ+EH32SWJ8PpylvsC2Kn7VAOljoG5AOvhS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e9pY4bKx4XsvAzUNDBkYpETKcimEEigzlpaQFeO8BlJwV6OfOUy7M8uEzGeG29BoC
	 MVmo6fa5iIU3v4qoqm5S5zrH7b27vbKzlLHzy+Hm/VuGKea1CT2wiarK8P6+bGWY+P
	 BDfFkfW/SmmB7TEYK7ixFrsGU+y4GrdjkEIsyOoBN7I98ZU6Ft3bQwnL+pyAe22JCT
	 BmTNG5JbpgdT3fWMYvoCbUlGl487vktrPP0Bp53aEx/nr8y58nQDVm1fVErRO3rI8/
	 0K2YLZEl5/k2a3N+G27zNg9uRTaxDgMnBUna4nI+KnxCq0kGOiCIzhpARi5Vau9dFN
	 1dnNjmPdGoqMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	Simon Horman <simon.horman@corigine.com>,
	Aaron Conole <aconole@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/5] openvswitch: move key and ovs_cb update out of handle_fragments
Date: Thu, 20 Aug 2026 00:21:34 -0400
Message-ID: <20260820042135.1376434-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820042135.1376434-1-sashal@kernel.org>
References: <2026081754-splendid-scabby-9156@gregkh>
 <20260820042135.1376434-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 1b83bf4489cbc47d88976291cc967a17adb8e118 ]

This patch has no functional changes and just moves key and ovs_cb update
out of handle_fragments, and skb_clear_hash() and skb->ignore_df change
into handle_fragments(), to make it easier to move the duplicate code
from handle_fragments() into nf_conntrack_ovs later.

Note that it changes to pass info->family to handle_fragments() instead
of key for the packet type check, as info->family is set according to
key->eth.type in ovs_ct_copy_action() when creating the action.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 8a7ed561671a ("net/sched: act_ct: fix sk_buff leak when the header checks reject a packet")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/conntrack.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index f401de5e8b386..747ba60afe0a7 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -494,13 +494,12 @@ static int ovs_ct_helper(struct sk_buff *skb, u16 proto)
 /* Returns 0 on success, -EINPROGRESS if 'skb' is stolen, or other nonzero
  * value if 'skb' is freed.
  */
-static int handle_fragments(struct net *net, struct sw_flow_key *key,
-			    u16 zone, struct sk_buff *skb)
+static int handle_fragments(struct net *net, struct sk_buff *skb,
+			    u16 zone, u8 family, u8 *proto, u16 *mru)
 {
-	struct ovs_skb_cb ovs_cb = *OVS_CB(skb);
 	int err;
 
-	if (key->eth.type == htons(ETH_P_IP)) {
+	if (family == NFPROTO_IPV4) {
 		enum ip_defrag_users user = IP_DEFRAG_CONNTRACK_IN + zone;
 
 		memset(IPCB(skb), 0, sizeof(struct inet_skb_parm));
@@ -508,9 +507,9 @@ static int handle_fragments(struct net *net, struct sw_flow_key *key,
 		if (err)
 			return err;
 
-		ovs_cb.mru = IPCB(skb)->frag_max_size;
+		*mru = IPCB(skb)->frag_max_size;
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
-	} else if (key->eth.type == htons(ETH_P_IPV6)) {
+	} else if (family == NFPROTO_IPV6) {
 		enum ip6_defrag_users user = IP6_DEFRAG_CONNTRACK_IN + zone;
 
 		memset(IP6CB(skb), 0, sizeof(struct inet6_skb_parm));
@@ -521,22 +520,35 @@ static int handle_fragments(struct net *net, struct sw_flow_key *key,
 			return err;
 		}
 
-		key->ip.proto = ipv6_hdr(skb)->nexthdr;
-		ovs_cb.mru = IP6CB(skb)->frag_max_size;
+		*proto = ipv6_hdr(skb)->nexthdr;
+		*mru = IP6CB(skb)->frag_max_size;
 #endif
 	} else {
 		kfree_skb(skb);
 		return -EPFNOSUPPORT;
 	}
 
+	skb_clear_hash(skb);
+	skb->ignore_df = 1;
+
+	return 0;
+}
+
+static int ovs_ct_handle_fragments(struct net *net, struct sw_flow_key *key,
+				   u16 zone, int family, struct sk_buff *skb)
+{
+	struct ovs_skb_cb ovs_cb = *OVS_CB(skb);
+	int err;
+
+	err = handle_fragments(net, skb, zone, family, &key->ip.proto, &ovs_cb.mru);
+	if (err)
+		return err;
+
 	/* The key extracted from the fragment that completed this datagram
 	 * likely didn't have an L4 header, so regenerate it.
 	 */
 	ovs_flow_key_update_l3l4(skb, key);
-
 	key->ip.frag = OVS_FRAG_TYPE_NONE;
-	skb_clear_hash(skb);
-	skb->ignore_df = 1;
 	*OVS_CB(skb) = ovs_cb;
 
 	return 0;
@@ -1311,7 +1323,8 @@ int ovs_ct_execute(struct net *net, struct sk_buff *skb,
 		return err;
 
 	if (key->ip.frag != OVS_FRAG_TYPE_NONE) {
-		err = handle_fragments(net, key, info->zone.id, skb);
+		err = ovs_ct_handle_fragments(net, key, info->zone.id,
+					      info->family, skb);
 		if (err)
 			return err;
 	}
-- 
2.53.0

