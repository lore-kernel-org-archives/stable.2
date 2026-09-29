Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C40435AC14
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674674; cv=none; b=OhvJaub69bclVICmuP09UvlWmrVVjfEyurZFXYHZ9lzFAK9Yydsg/L4d+DxWHvOC79YcbbyxM7iGOidNc8zv2ycnhHKT3CBK0Oe48otV6uoDpDFtwKLEh1LhNeELpkHlr+VM9l1YXaGFivvcs1paU48zPyd+ol5mLXObabl+1A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674674; c=relaxed/simple;
	bh=TnPqAQuqguTGw+UOlpXH7dF95+lVUYDYK/Y2zf8nm58=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HVWoCgWPX/oC6kMfap37J66i02AjanP68tsuNFSR9oRraejud7jYMnaasHYYSnttRCwTERC48x5FKJazTuueR7vr1nWzhkwNJ8h5svXkUaS+YrXMpgXgSWNYbhA1QZgBq7C7E4OvGcJ08rhyn7BXiR1KZQecRQ9nNN9OesiIaiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yoD7LOYv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yoD7LOYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F65D1F000FF;
	Tue, 29 Sep 2026 09:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790674672;
	bh=hnJyHS/C9jwVSuSyqHgZ5ukyuQbHDJJHCuiXwlfcrP0=;
	h=Subject:To:Cc:From:Date;
	b=yoD7LOYvGghWYqgfJPuiUOT/2iAvp6N82wdV1+bZCZl24Lm9FgQqRlzTSg78hkYVW
	 97sobeMa3hLJQHFEE9/NBIWIyUmGPHj+/ESNH90LS/6uo/dFoxqgsRXhGHO6lDdprJ
	 tpVZx3LxLNAZ+cOj+gdUgXsAezq25i4bkvYewoHI=
Subject: FAILED: patch "[PATCH] net: openvswitch: conntrack: fix helper UAF due to extensions" failed to apply to 5.10-stable tree
To: i.maximets@ovn.org,aconole@redhat.com,axel.mierczuk@1password.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 11:37:37 +0200
Message-ID: <2026092937-camera-idiom-4390@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1a4151e6be57b098b7a5ebfbde58585e83200cdc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092937-camera-idiom-4390@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

