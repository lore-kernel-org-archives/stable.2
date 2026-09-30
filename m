Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5392BEFEE
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766880; cv=none; b=H6zJn8pCbi/L2U0pGtBYZqX4iCEULtleiwuIFuguV1i6Lh8niLPUNHzL1cKSuxpBUTOijuCV8lYQGcp7Y9Ok3JfP5ftMl4lk7l73/4oFy+Hjp+26l/CXjvtrWxgzZkXOH4paOEOu9JsPOttE74PXdGvKEQepYVjPU/9TeBDsKtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766880; c=relaxed/simple;
	bh=ZUAgMNV5rnvEF61SNjiPMRSY7TVmQTmSSJelIgGGN/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8AgdKosZM7dkv8hk2J+411f5USAvYVd/gU1nymyGsqCcupfNXPHiXsEkMr6CsDO9VTiQDCd20vxHN25OFni708IrXtpJxV2oioy9W8m/ygxWA9IHGrAHYhok7a6lPL1P01tsVJmXR584KNLy7tyeXAa1A6IaCZmhESkR6yK78o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0uGx1NR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0uGx1NR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B871F000FF;
	Wed, 30 Sep 2026 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766878;
	bh=wwF466jl/RWwwNr1RFjajht4D07CqlDoE19jCPLLeR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R0uGx1NRrF0SOIl7fW5xHdpZd5TY8utifqXOEzgRu2DcWiq1eEgMZjEUSbLE4Bfe7
	 Qb3YNKkgcWE6k1Aq4M0vqpXK9WCFWGVXfUqD4CC3RdpFiGD/BQW1Cxhs8vspe5Yi6m
	 qDJHCjvOByfOdBuoUIT0KvyQBzuCFg6TPpYgWZPGyvN/VpPgOz5iXai5Crt9f9xq4/
	 A1Z+GJY9bhlbPL5il/5FnxphSf0OtAAt2C1vLJv34QazrIuIfRik6aOo4RqGH1xi1B
	 ki7uYPV8pOTPlg1W79BWSFtJtO3w8MFiMj76O6Bb7E4UKxUmiVm7iF9wq5B4PRlk1g
	 IAaSW/Z0xH3pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Aaron Conole <aconole@redhat.om>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] openvswitch: prepare for stolen verdict coming from conntrack and nat engine
Date: Wed, 30 Sep 2026 07:14:35 -0400
Message-ID: <20260930111436.1209293-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092936-lizard-mockup-ae46@gregkh>
References: <2026092936-lizard-mockup-ae46@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit c7f79f2620b7776586c626edf21eb6ed6ed3d1eb ]

At this time, conntrack either returns NF_ACCEPT or NF_DROP.
To improve debuging it would be nice to be able to replace NF_DROP
verdict with NF_DROP_REASON() helper,

This helper releases the skb instantly (so drop_monitor can pinpoint
precise location) and returns NF_STOLEN.

Prepare call sites to deal with this before introducing such changes
in conntrack and nat core.

Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Aaron Conole <aconole@redhat.om>
Signed-off-by: David S. Miller <davem@davemloft.net>

[Stable 6.1 adaptation: retain the local NAT implementation, which already
updates the flow key only on NF_ACCEPT, and return before restoring skb
headers on NF_STOLEN. Rename the existing OVS helper and pass its existing
connection and ctinfo explicitly so the following helper-UAF fix can use
the upstream call signature without importing the shared-helper refactor.
Use a single-evaluation verdict_to_errno macro instead of adding a function.
Remove the dead add_helper flag and align the helper-call condition with
1a4151e6be57; the flag was set only for unconfirmed connections but tested
only for confirmed ones. The helper relocation itself remains in the target.]

Stable-dep-of: 1a4151e6be57 ("net: openvswitch: conntrack: fix helper UAF due to extensions realloc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/conntrack.c | 56 ++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 5f52d409a2af7..dc5cdbf2d125f 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -435,16 +435,14 @@ static int ovs_ct_set_labels(struct nf_conn *ct, struct sw_flow_key *key,
 }
 
 /* 'skb' should already be pulled to nh_ofs. */
-static int ovs_ct_helper(struct sk_buff *skb, u16 proto)
+static int nf_ct_helper(struct sk_buff *skb, struct nf_conn *ct,
+			enum ip_conntrack_info ctinfo, u16 proto)
 {
 	const struct nf_conntrack_helper *helper;
 	const struct nf_conn_help *help;
-	enum ip_conntrack_info ctinfo;
 	unsigned int protoff;
-	struct nf_conn *ct;
 	int err;
 
-	ct = nf_ct_get(skb, &ctinfo);
 	if (!ct || ctinfo == IP_CT_RELATED_REPLY)
 		return NF_ACCEPT;
 
@@ -799,7 +797,7 @@ static void ovs_nat_update_key(struct sw_flow_key *key,
 
 /* Modelled after nf_nat_ipv[46]_fn().
  * range is only used for new, uninitialized NAT state.
- * Returns either NF_ACCEPT or NF_DROP.
+ * Returns NF_ACCEPT, NF_DROP or NF_STOLEN.
  */
 static int ovs_ct_nat_execute(struct sk_buff *skb, struct nf_conn *ct,
 			      enum ip_conntrack_info ctinfo,
@@ -874,6 +872,9 @@ static int ovs_ct_nat_execute(struct sk_buff *skb, struct nf_conn *ct,
 
 	err = nf_nat_packet(ct, ctinfo, hooknum, skb);
 push:
+	if ((err & NF_VERDICT_MASK) == NF_STOLEN)
+		return err;
+
 	skb_push_rcsum(skb, nh_off);
 
 	/* Update the flow key if NAT successful. */
@@ -951,6 +952,14 @@ static int ovs_ct_nat(struct net *net, struct sw_flow_key *key,
 }
 #endif
 
+/* Translate netfilter verdicts without evaluating the argument twice. */
+#define verdict_to_errno(verdict) ({					\
+	unsigned int __verdict = (verdict) & NF_VERDICT_MASK;		\
+									\
+	__verdict == NF_ACCEPT ? 0 :					\
+	__verdict == NF_STOLEN ? -EINPROGRESS : -EINVAL;			\
+})
+
 /* Pass 'skb' through conntrack in 'net', using zone configured in 'info', if
  * not done already.  Update key with new CT state after passing the packet
  * through conntrack.
@@ -989,7 +998,7 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 
 		err = nf_conntrack_in(skb, &state);
 		if (err != NF_ACCEPT)
-			return -ENOENT;
+			return verdict_to_errno(err);
 
 		/* Clear CT state NAT flags to mark that we have not yet done
 		 * NAT after the nf_conntrack_in() call.  We can actually clear
@@ -1003,8 +1012,6 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if (ct) {
-		bool add_helper = false;
-
 		/* Packets starting a new connection must be NATted before the
 		 * helper, so that the helper knows about the NAT.  We enforce
 		 * this by delaying both NAT and helper calls for unconfirmed
@@ -1016,9 +1023,12 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 		 * the key->ct_state.
 		 */
 		if (info->nat && !(key->ct_state & OVS_CS_F_NAT_MASK) &&
-		    (nf_ct_is_confirmed(ct) || info->commit) &&
-		    ovs_ct_nat(net, key, info, skb, ct, ctinfo) != NF_ACCEPT) {
-			return -EINVAL;
+		    (nf_ct_is_confirmed(ct) || info->commit)) {
+			int err = ovs_ct_nat(net, key, info, skb, ct, ctinfo);
+
+			err = verdict_to_errno(err);
+			if (err)
+				return err;
 		}
 
 		/* Userspace may decide to perform a ct lookup without a helper
@@ -1033,7 +1043,6 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 							    GFP_ATOMIC);
 			if (err)
 				return err;
-			add_helper = true;
 
 			/* helper installed, add seqadj if NAT is required */
 			if (info->nat && !nfct_seqadj(ct)) {
@@ -1043,15 +1052,15 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 		}
 
 		/* Call the helper only if:
-		 * - nf_conntrack_in() was executed above ("!cached") or a
-		 *   helper was just attached ("add_helper") for a confirmed
-		 *   connection, or
+		 * - nf_conntrack_in() was executed above ("!cached"), or
 		 * - When committing an unconfirmed connection.
 		 */
-		if ((nf_ct_is_confirmed(ct) ? !cached || add_helper :
-					      info->commit) &&
-		    ovs_ct_helper(skb, info->family) != NF_ACCEPT) {
-			return -EINVAL;
+		if ((nf_ct_is_confirmed(ct) ? !cached : info->commit)) {
+			int err = nf_ct_helper(skb, ct, ctinfo, info->family);
+
+			err = verdict_to_errno(err);
+			if (err)
+				return err;
 		}
 
 		if (nf_ct_protonum(ct) == IPPROTO_TCP &&
@@ -1279,10 +1288,9 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
 	/* This will take care of sending queued events even if the connection
 	 * is already confirmed.
 	 */
-	if (nf_conntrack_confirm(skb) != NF_ACCEPT)
-		return -EINVAL;
+	err = nf_conntrack_confirm(skb);
 
-	return 0;
+	return verdict_to_errno(err);
 }
 
 /* Trim the skb to the length specified by the IP/IPv6 header,
@@ -1345,6 +1353,10 @@ int ovs_ct_execute(struct net *net, struct sk_buff *skb,
 	else
 		err = ovs_ct_lookup(net, key, info, skb);
 
+	/* conntrack core returned NF_STOLEN */
+	if (err == -EINPROGRESS)
+		return err;
+
 	skb_push_rcsum(skb, nh_ofs);
 	if (err)
 		kfree_skb(skb);
-- 
2.53.0

