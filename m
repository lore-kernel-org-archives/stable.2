Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8353637BE93
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166523; cv=none; b=G1cwMGWJHft/tB+6V3yta+4093s8ec0jThUZdTpoZxCZkqCATMbVfkYojcFCvzz65Z/wP72BaNBNvKqyit4wi10UmOeMET6qdPR21pzKLf8Wt0nxpVo8K8sQXPNEcHvjgk9ov2Q49+YHt+gBL3DyWm6RatrHi0q3AELYmpdhlZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166523; c=relaxed/simple;
	bh=aDmrK+0rpaAYnbVjb38UFvFKPBjzp22oUr411dJ7NEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRnWym3m65r7D3I4HIGUDeezpI/23filkM5wPE7sm2WxCIzc+iZKFbaUPI95CA9vi2oShCaH3DOgpP1lfCv9XXaq6zu0hDxA1+sTDyS+nCDoSMpJOJO9NujajFm8ABv0W55DsXW/8Bo6qZC4eW9FXPJuzpWDvcLa6BTByXrMSCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJou0Rcq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJou0Rcq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A941F00A3F;
	Wed, 19 Aug 2026 19:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787166522;
	bh=ByAAC6NynRLx7QaqWGFxh+EWEZGvldHxLDwutnckGFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZJou0RcqsfaT6U20D2SYNQQIHOu0NUuayZUXl98o5nqLwtT7AWdRgBbYe2zYIvTCE
	 DtpcKaC5+PAFceAZr/UB+EBGS5GIKcomyo9iwRn3KTyg0fKRMaaLgJUbyUrNFJueHG
	 uAacJVn7osWJhgZkrae+mH/XI5wdRQUCVq2INOJW9RNlIBYC+0aGx8TZYuf0E+rc4+
	 iMe6TbXVTHh0kxY+4iXmWcua6g/5zQF4X1wDeb4v2IAjFkG2vVPUU64EELhqV0Ac96
	 RuSMlMOfUH95XVjAfq7HQSbJUTy0aE+buHtOiky7CS7eYxjtn4mDelKi22FwrY1Xuq
	 m9KR+Zc/eQKWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	Simon Horman <simon.horman@corigine.com>,
	Aaron Conole <aconole@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] openvswitch: move key and ovs_cb update out of handle_fragments
Date: Wed, 19 Aug 2026 15:08:35 -0400
Message-ID: <20260819190836.561493-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819190836.561493-1-sashal@kernel.org>
References: <2026081753-suffix-dill-686c@gregkh>
 <20260819190836.561493-1-sashal@kernel.org>
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
index 3bb361e70cdd4..0085e87f10f63 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -496,13 +496,12 @@ static int ovs_ct_helper(struct sk_buff *skb, u16 proto)
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
@@ -510,9 +509,9 @@ static int handle_fragments(struct net *net, struct sw_flow_key *key,
 		if (err)
 			return err;
 
-		ovs_cb.mru = IPCB(skb)->frag_max_size;
+		*mru = IPCB(skb)->frag_max_size;
 #if IS_ENABLED(CONFIG_NF_DEFRAG_IPV6)
-	} else if (key->eth.type == htons(ETH_P_IPV6)) {
+	} else if (family == NFPROTO_IPV6) {
 		enum ip6_defrag_users user = IP6_DEFRAG_CONNTRACK_IN + zone;
 
 		memset(IP6CB(skb), 0, sizeof(struct inet6_skb_parm));
@@ -523,22 +522,35 @@ static int handle_fragments(struct net *net, struct sw_flow_key *key,
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
@@ -1318,7 +1330,8 @@ int ovs_ct_execute(struct net *net, struct sk_buff *skb,
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

