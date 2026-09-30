Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCCC4E2F05
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773646; cv=none; b=styeKn+RsmSLIkI3q8dO+UvjqiWGj8M/s6JeRAnDGD0obNaxgh+mNz02lLguoNiXaxzyp145htHakFQLfrN8L9zm8+iMlTqIDJLHHkL6hXv2obprjFaE1MJhfpmAnoBGlzG0kV1rWn9ZFynwmnd4hZ7Hyrk5AoLZSsGZtOg7Ju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773646; c=relaxed/simple;
	bh=GHkuGoVjXPPM5ETetQoBRIIASZBxZYDDe4sdbS4PyLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5HMz9BaEZSa5PZxO9c3RfD2aK5uGHMbOTDfcOUOBpGKF5On7Vpi26FvaBDgp6dBvegw++Kh9PX5rRdR5F11zSZ6YwYQijeR6Nlj5w8T4Mfqk4xAjrin9kOX8Z87CTHMtQxRLZjze9vIyBeTgTL995B+bNZtetqJoeXCq3jDUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jshMjPbt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jshMjPbt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DDB1F00898;
	Wed, 30 Sep 2026 13:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773632;
	bh=2BeySd5RSCq9XcjtthlodS5n8mHQcSwspNS4l8cY0Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jshMjPbtG7cr8SNjJB9v4OAmLbu/d/T1Fa2sDa4+haLUzDKPrfvmdTy9hWGvFro6o
	 K+G1nm2K1wb7D61oaR+rox6F9z5esvGQyCcB7cBd8NTGIsQ6GNY9APXmdVlyd2+VTK
	 Isit181vcRzogjelRxbQzdLP9OiFIvyGlyvo6V9SveUkfLAgE+KM/6cTLoG1CkhjB3
	 X7suT7pCfgQsa16k058nX7MPTGv3krbCJKabQIJhr826mxgxW5hIITA+7Ps9/FB17C
	 N4T2davcTnD5MPDXYPr3MHUFl7dkdBXwcvJuYoyzg+6vkKl21YcM1PAkd46vfLiV1t
	 aQ8xtlqzzAUGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: openvswitch: conntrack: fix helper UAF due to extensions realloc
Date: Wed, 30 Sep 2026 09:07:09 -0400
Message-ID: <20260930130709.1705026-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092937-subprime-mulch-2753@gregkh>
References: <2026092937-subprime-mulch-2753@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit 1a4151e6be57b098b7a5ebfbde58585e83200cdc ]

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
[ adapted nf_ct_helper() calls to the existing ovs_ct_helper() API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/openvswitch/conntrack.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 0645ec3d96b8b..699d259653dfd 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1039,14 +1039,14 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 			}
 		}
 
-		/* Call the helper only if:
-		 * - nf_conntrack_in() was executed above ("!cached") or a
-		 *   helper was just attached ("add_helper") for a confirmed
-		 *   connection, or
-		 * - When committing an unconfirmed connection.
+		/* Call the helper only if nf_conntrack_in() was executed
+		 * above ("!cached") or a helper was just attached ("add_helper").
+		 *
+		 * For unconfirmed connections it will be called later during
+		 * commit as we need to have all the other extensions allocated
+		 * before the call.
 		 */
-		if ((nf_ct_is_confirmed(ct) ? !cached || add_helper :
-					      info->commit) &&
+		if (nf_ct_is_confirmed(ct) && (!cached || add_helper) &&
 		    ovs_ct_helper(skb, info->family) != NF_ACCEPT) {
 			return -EINVAL;
 		}
@@ -1262,6 +1262,12 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
 					 &info->labels.mask);
 		if (err)
 			return err;
+
+		/* Call the helpers now.  We couldn't do this before as
+		 * all the extensions must be allocated before the call.
+		 */
+		if (ovs_ct_helper(skb, info->family) != NF_ACCEPT)
+			return -EINVAL;
 	} else if (IS_ENABLED(CONFIG_NF_CONNTRACK_LABELS) &&
 		   labels_nonzero(&info->labels.mask)) {
 		err = ovs_ct_set_labels(ct, key, &info->labels.value,
-- 
2.53.0

