Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5552435AC14
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674672; cv=none; b=dCTjLr+VZCxcTLcWY7Ib+qJQnLk7m/taMPVHPsH62EKnS6NSgRxRnHYlaS7fuLocX/SGbpcYujFBmGT8IirYLbSKVUlmAcAQtLak1l3b0hPG6+iXNPxF5Z/SOvTcQzZA6LJCV274cTMYFR3Snw+919agWWVq3hu67ODG/qe6lSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674672; c=relaxed/simple;
	bh=uQkIYeGRn6s+uW4Bv1bhBHXB8n2TM3/E74TCxSilh3I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PMhxnc73o616Td3jOHrMhzEiUHm6FxgiKuYc5y+9ij1ECjXB2OCe/XlGLZi6NOwrklgMvUY0M3kGVYFhA+1yqVDJHmvkZzFukbEmPKJxTV/z8lr2Kl7sIFAulyzeqR+vYY4zd8x2R6MoXYJByg4UVtnrp3cs0UbCmt3sA55pQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ls8v2vOl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ls8v2vOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABAE1F00893;
	Tue, 29 Sep 2026 09:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790674670;
	bh=noP5xaTtbS4W7elqG+5bfKZ0fpiG3Jc24rUDx21ylCQ=;
	h=Subject:To:Cc:From:Date;
	b=Ls8v2vOlFifw94EbXhztIbefYFYdCVr3lEj6RJ+1Gp0ElqcRusEgJYb4LMhf701i4
	 KGWNPoZCh+0GXiXhZCZ7XCXebmbTjK7jUtYzZ8TbmcgJqEDNbvH3xIvhJQuvV9uZTX
	 VetLBqFELJeokzmqb5KDsitE4vpa+rU/ivTaw6gw=
Subject: FAILED: patch "[PATCH] net: openvswitch: conntrack: fix helper UAF due to extensions" failed to apply to 5.15-stable tree
To: i.maximets@ovn.org,aconole@redhat.com,axel.mierczuk@1password.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:37:37 +0200
Message-ID: <2026092937-subprime-mulch-2753@gregkh>
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
git cherry-pick -x 1a4151e6be57b098b7a5ebfbde58585e83200cdc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092937-subprime-mulch-2753@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1a4151e6be57b098b7a5ebfbde58585e83200cdc Mon Sep 17 00:00:00 2001
From: Ilya Maximets <i.maximets@ovn.org>
Date: Mon, 21 Sep 2026 16:55:45 +0200
Subject: [PATCH] net: openvswitch: conntrack: fix helper UAF due to extensions
 realloc

While calling the helpers, a raw pointer to the extensions area is
wired into expectations list:

  -> nf_ct_helper()
   -> helper->help()
    -> nf_ct_expect_related_report()
     -> nf_ct_expect_insert()
      -> hlist_add_head_rcu(&exp->lnode, &master_help->expectations)

In case the connection is not confirmed yet, more extensions can be
added afterwards with *_ext_add() calls reallocating the extension
space and leaving the now invalid pointer in the expectations list
that is later accessed while removing the expectation.

Make sure that helpers are called at the end after all the other
extensions are already added.

Note that the helper rejection now leaves the mark and labels set,
but that's not different from how the NAT was handled before or how
the mark and the labels were handled on confirmation failure.  And
there are no atomicity guarantees provided by the API anyway.

Fixes: cae3a2627520 ("openvswitch: Allow attaching helpers to ct action")
Cc: stable@vger.kernel.org
Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20260921145655.3167436-4-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index c20f096eef40..d3326edcabf7 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -817,11 +817,14 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 			}
 		}
 
-		/* Call the helper only if:
-		 * - nf_conntrack_in() was executed above ("!cached"), or
-		 * - When committing an unconfirmed connection.
+		/* Call the helper only if nf_conntrack_in() was executed
+		 * above ("!cached").
+		 *
+		 * For unconfirmed connections it will be called later during
+		 * commit as we need to have all the other extensions allocated
+		 * before the call.
 		 */
-		if ((nf_ct_is_confirmed(ct) ? !cached : info->commit)) {
+		if (nf_ct_is_confirmed(ct) && !cached) {
 			int err = nf_ct_helper(skb, ct, ctinfo, info->family);
 
 			err = verdict_to_errno(err);
@@ -1025,6 +1028,14 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
 			return err;
 
 		nf_conn_act_ct_ext_add(skb, ct, ctinfo);
+
+		/* Call the helpers now.  We couldn't do this before as
+		 * all the extensions must be allocated before the call.
+		 */
+		err = nf_ct_helper(skb, ct, ctinfo, info->family);
+		err = verdict_to_errno(err);
+		if (err)
+			return err;
 	} else if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
 		   labels_nonzero(&info->labels.mask)) {
 		err = ovs_ct_set_labels(ct, key, &info->labels.value,

