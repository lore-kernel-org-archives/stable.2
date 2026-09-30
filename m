Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BCD3101D0
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790732142; cv=none; b=hoSoARYNoTENs9OjsdBiMwm9SuK9nsr6g15gKk6rUiR681J1LUTNEavcvufz2Kv2acYH9tptDPuIwRtHDkeq4QhGW3DdcSjlQ35iCDXzFHBRKzmoPakE1/nPBztuBrRMPb7ez/9xkQxp6CwTpL8GgoBqaDpcuNxG76EHdh/jBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790732142; c=relaxed/simple;
	bh=2QxHTljYPPB1lxHZVXnCQMtaK/j8sSBkhtOgLoySQIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkLFj6hy9YF4I0zr0gQbLEitPf7QCs6taMqRI7I8WUW9rgMEmSjNl0CnuaS3dP1LHUYT/3y7e2D0qGLCWvEwocvWlWUye6eX2aBWDkZ+2EpmWuU8qXXU7cfKEv47N605ha/bZH8q0d1iQX4Dqlq/h/u8czMXTUuLEe2QVM1uGuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9B90KEW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9B90KEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1341F00893;
	Wed, 30 Sep 2026 01:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790732141;
	bh=TSMHGYfgIycUVgHGzR2sSkfFAX5AUz8mRbEVjvompGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L9B90KEWbY5EKSCtfQjpiqAMl32Wacv4v0nr9/cLGWNPWcQdo2XK1Z6DB2Zrq8XyB
	 lcgGZGj42tqK7LWbfCWlLUbIvoGU1/3Khfu8dLZwrf8qwWkW31Oc/kFB3/XyTQY/9v
	 sy4mLSb1ibMLpxW/BiyO4knCnkx1TMqfs/ooxyJJsU6NeuW7yhpB1tsWqrKxr+n+Jd
	 2jTVxFVh1Iob8skiaNmuk5j6VK+mumkuSoBfZ8yGCpYgvbHJKqPH5BjI0kdH/1PMrG
	 VZH9Vzl1l1kiMWTH4A9YywTcYHqamf0fvCLamzkyQK5rn55wn9VU7tSsDsFO/l4/r2
	 AYtYWlCyrosjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] net: openvswitch: conntrack: remove 'add_helper' dead code
Date: Tue, 29 Sep 2026 21:35:37 -0400
Message-ID: <20260930013538.3274673-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930013538.3274673-1-sashal@kernel.org>
References: <2026092936-emporium-roman-a509@gregkh>
 <20260930013538.3274673-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit 5e6c14dd42a1c1fe938e573dc6c9098145b2b0c4 ]

This variable can only become 'true' when the connection is not
confirmed, but it is only checked when it is confirmed.  So, it can be
treated as being always false and just removed.

Fixes: 3c1860543fcc ("openvswitch: add nf_ct_is_confirmed check before assigning the helper")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20260921145655.3167436-3-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 1a4151e6be57 ("net: openvswitch: conntrack: fix helper UAF due to extensions realloc")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/conntrack.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 9a43b4fea5e7c..00c499540ff38 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -767,8 +767,6 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if (ct) {
-		bool add_helper = false;
-
 		/* Packets starting a new connection must be NATted before the
 		 * helper, so that the helper knows about the NAT.  We enforce
 		 * this by delaying both NAT and helper calls for unconfirmed
@@ -800,7 +798,6 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 							    GFP_ATOMIC);
 			if (err)
 				return err;
-			add_helper = true;
 
 			/* helper installed, add seqadj if NAT is required */
 			if (info->nat && !nfct_seqadj(ct)) {
@@ -810,13 +807,10 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 		}
 
 		/* Call the helper only if:
-		 * - nf_conntrack_in() was executed above ("!cached") or a
-		 *   helper was just attached ("add_helper") for a confirmed
-		 *   connection, or
+		 * - nf_conntrack_in() was executed above ("!cached"), or
 		 * - When committing an unconfirmed connection.
 		 */
-		if ((nf_ct_is_confirmed(ct) ? !cached || add_helper :
-					      info->commit)) {
+		if ((nf_ct_is_confirmed(ct) ? !cached : info->commit)) {
 			int err = nf_ct_helper(skb, ct, ctinfo, info->family);
 
 			err = verdict_to_errno(err);
-- 
2.53.0

