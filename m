Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00344968F3
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674652; cv=none; b=TmBJlCaM9/I+2rEBjsVMq+myHx634lm/ymEJi5WutBkb0ejOygQ0UhGPL79A6dCCMvj0p9cOcADK00k5Fb7OoSjStZocE3p0EIzBAwk/fseDxepitWzXTD6X/QcI3YtQuhDH8uEHeT8Z2dtufJv5esIHVEX4zDZoR9MGOJiEUoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674652; c=relaxed/simple;
	bh=DzYGx4ygNQvP6IrdnTfLDfJD6DJcyfvXvScclEQepX8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MSUJ3XGaTAcnmluaCUhlUGVGhnQmH8OzIGzBdDSZBZT3bWiSVXaA8nfzlkMSLu4B0tUrE5V4rctlSDXOJuOrys9//FWxO5QbdRuCL6fLcLw8otATs5Lw54kJPtV9c/K0UUzLuK+tZIe4f8Abv569Wk+9+rf8dCfGLSqwMXyk5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HuxHDdPK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HuxHDdPK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09281F00893;
	Tue, 29 Sep 2026 09:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790674651;
	bh=Sbf9GZC4+ub6uzKRurwsHC5BfsWAT2dJJW+wSB5I2KA=;
	h=Subject:To:Cc:From:Date;
	b=HuxHDdPK0/68DOcbbXREgxnogMy9/s0jSWK7yqyCGVgHBOXpQj7BrMgA7/wMbHGgl
	 3batycqqab38zT9sb8nu4Esym3PanNSWgYrJUw+ORTX48emoeAPxR+aDJ4VQfRQv/L
	 56tml4JhC7XTpiUS8HtNnTorNzwfePSI1W4/QaFk=
Subject: FAILED: patch "[PATCH] net: openvswitch: conntrack: remove 'add_helper' dead code" failed to apply to 6.6-stable tree
To: i.maximets@ovn.org,aconole@redhat.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:37:26 +0200
Message-ID: <2026092926-sweep-chaste-9989@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5e6c14dd42a1c1fe938e573dc6c9098145b2b0c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092926-sweep-chaste-9989@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5e6c14dd42a1c1fe938e573dc6c9098145b2b0c4 Mon Sep 17 00:00:00 2001
From: Ilya Maximets <i.maximets@ovn.org>
Date: Mon, 21 Sep 2026 16:55:44 +0200
Subject: [PATCH] net: openvswitch: conntrack: remove 'add_helper' dead code

This variable can only become 'true' when the connection is not
confirmed, but it is only checked when it is confirmed.  So, it can be
treated as being always false and just removed.

Fixes: 3c1860543fcc ("openvswitch: add nf_ct_is_confirmed check before assigning the helper")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20260921145655.3167436-3-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index a733029c28dd..c20f096eef40 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -778,8 +778,6 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if (ct) {
-		bool add_helper = false;
-
 		/* Packets starting a new connection must be NATted before the
 		 * helper, so that the helper knows about the NAT.  We enforce
 		 * this by delaying both NAT and helper calls for unconfirmed
@@ -811,7 +809,6 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 							    GFP_ATOMIC);
 			if (err)
 				return err;
-			add_helper = true;
 
 			/* helper installed, add seqadj if NAT is required */
 			if (info->nat && !nfct_seqadj(ct)) {
@@ -821,13 +818,10 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
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

