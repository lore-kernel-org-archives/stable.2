Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2924293C
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732142; cv=none; b=iq/SvNQIy/LD328nICeQqi7mStGS4mfQ3PSPhGWwySisyG+YwEqZmpgPAsMQhoODDJ5+K27HvHuFng2uPwRyORe20l/ApudT5TSCvFRtWfhkaXfxvXC7tbrOZLxZouAvmtKvAmAIdnGWQ7jtSXJVXSK0a3L9UyYN7QzcHVi7ab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732142; c=relaxed/simple;
	bh=w04uoCH4au3cSoDP6y+cvKquewizv6glgwlxoTk0S64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAOpizyC8II7lcRml8y3zQWOGlySXBVxrkm1PWpXN2nsA0+5JWDzBC6m6L7tKE1nlyFRd6emasDTeBYkT2RSYkwsX0CWChg4OEhMJox3j249uiuL2FGWLH4V4L/LGeqQ35pDiukRNtx7Pd1dEb3XKWL2m1H8ZhCPPp8ptmwcB5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Biu25pcR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Biu25pcR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9951F000FF;
	Wed, 30 Sep 2026 01:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790732140;
	bh=E7uLgOt1EPb4E5f0MXK1Ny/VzO2NVB6Jt4QgMumBHXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Biu25pcRwN0mgSXVIIwnkr23ssnKbqJSo0oPCzKGX8DCtNrGDKfrkLY0Eqo5M9tOc
	 ghUX8TMDhwyoypnWBPe5TPAGjMFCwgNIeH+mNekwps0r9Ngd6uYUinSe0A1UcKo2oz
	 G5E6vkW9Gaflg3OmROw+LdaMTmp0WItiDiP+uRlEOhbS0TlBWvKLf4euCl9SOkO9lG
	 YLKn5Lt5LA1HWML12VhyCFjhUG+UKvDwFr6Dj9fUnXIAUZU2xD49yS/0sax/vypcXf
	 ykBEQs0QY6WOOD/o1W4gsB+iJ/Aw8TZujop9faD1z2lDrvJbTENKZkFKFgl36D6u0Y
	 QMoV1aA31YocQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Aaron Conole <aconole@redhat.om>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] openvswitch: prepare for stolen verdict coming from conntrack and nat engine
Date: Tue, 29 Sep 2026 21:35:36 -0400
Message-ID: <20260930013538.3274673-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092936-emporium-roman-a509@gregkh>
References: <2026092936-emporium-roman-a509@gregkh>
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
Stable-dep-of: 1a4151e6be57 ("net: openvswitch: conntrack: fix helper UAF due to extensions realloc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/conntrack.c | 47 +++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 6ceec146e694f..9a43b4fea5e7c 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -679,6 +679,8 @@ static int ovs_ct_nat(struct net *net, struct sw_flow_key *key,
 		action |= BIT(NF_NAT_MANIP_DST);
 
 	err = nf_ct_nat(skb, ct, ctinfo, &action, &info->range, info->commit);
+	if (err != NF_ACCEPT)
+		return err;
 
 	if (action & BIT(NF_NAT_MANIP_SRC))
 		ovs_nat_update_key(key, skb, NF_NAT_MANIP_SRC);
@@ -697,6 +699,22 @@ static int ovs_ct_nat(struct net *net, struct sw_flow_key *key,
 }
 #endif
 
+static int verdict_to_errno(unsigned int verdict)
+{
+	switch (verdict & NF_VERDICT_MASK) {
+	case NF_ACCEPT:
+		return 0;
+	case NF_DROP:
+		return -EINVAL;
+	case NF_STOLEN:
+		return -EINPROGRESS;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 /* Pass 'skb' through conntrack in 'net', using zone configured in 'info', if
  * not done already.  Update key with new CT state after passing the packet
  * through conntrack.
@@ -735,7 +753,7 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 
 		err = nf_conntrack_in(skb, &state);
 		if (err != NF_ACCEPT)
-			return -ENOENT;
+			return verdict_to_errno(err);
 
 		/* Clear CT state NAT flags to mark that we have not yet done
 		 * NAT after the nf_conntrack_in() call.  We can actually clear
@@ -762,9 +780,12 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
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
@@ -795,9 +816,12 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 		 * - When committing an unconfirmed connection.
 		 */
 		if ((nf_ct_is_confirmed(ct) ? !cached || add_helper :
-					      info->commit) &&
-		    nf_ct_helper(skb, ct, ctinfo, info->family) != NF_ACCEPT) {
-			return -EINVAL;
+					      info->commit)) {
+			int err = nf_ct_helper(skb, ct, ctinfo, info->family);
+
+			err = verdict_to_errno(err);
+			if (err)
+				return err;
 		}
 
 		if (nf_ct_protonum(ct) == IPPROTO_TCP &&
@@ -1005,10 +1029,9 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
 	/* This will take care of sending queued events even if the connection
 	 * is already confirmed.
 	 */
-	if (nf_conntrack_confirm(skb) != NF_ACCEPT)
-		return -EINVAL;
+	err = nf_conntrack_confirm(skb);
 
-	return 0;
+	return verdict_to_errno(err);
 }
 
 /* Returns 0 on success, -EINPROGRESS if 'skb' is stolen, or other nonzero
@@ -1043,6 +1066,10 @@ int ovs_ct_execute(struct net *net, struct sk_buff *skb,
 	else
 		err = ovs_ct_lookup(net, key, info, skb);
 
+	/* conntrack core returned NF_STOLEN */
+	if (err == -EINPROGRESS)
+		return err;
+
 	skb_push_rcsum(skb, nh_ofs);
 	if (err)
 		ovs_kfree_skb_reason(skb, OVS_DROP_CONNTRACK);
-- 
2.53.0

