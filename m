Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396674FDE70
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773981; cv=none; b=A2SZ/1QLIKXUZh32Kbt72qMTSKlKVEplqcI5IEQYGkYIYY4PsNQuoxeZRM83BVfcNzPerCRNgkI9pMSEe8KEB5gtF+cEI18yd8PSu6eeveFVzmOiWGZFsiCb7DjE6KnprXLi9GluNH8dM5VHx4dVKp7jonniMLJi8hxvp3ZDt8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773981; c=relaxed/simple;
	bh=/bgsH/+GB7rlHcErhPuRDiwrXXnAx1GBQVfd7Qby9yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4HLGD74K1JmCeXeC6PM7TAyB6zB0NQkdIYR8QGuXL9vXO5ZndlmEkIX0jHivilfeZrT9a5x5m8hjicoaDsfeMYwUd2H8WHE2Htmm1ZIN5wGdbm8M0nQqAuebb7IToI2iwiM8zqGip5981140RBGe1KTMlr2JriZQL/gvTAEBuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIdItA9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIdItA9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575841F000FF;
	Wed, 30 Sep 2026 13:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790773968;
	bh=83u/aicJGsyhw5MyBgvJtOx3l6WAXG8sFN0rDYsJrRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jIdItA9CnusEa1o5Mt96omAjUfDjctfQ2K8OizQxjuqgTrNubPUm3QctQ4YSm8eEi
	 9n0oqN049vcBD3tvXkY7I6gI5KcB5UMkJ1a5k1lH2XQfRqqBUktI4D+eXdD7fDEt67
	 yec+ba4WyqjjLy/1nZS816XH/AWqjwPSHTO9g/18/o6vU9eWvSH83RnOBx0kLFmMdE
	 Ce/JUDUPA3MLHJU1DBJs44qZzrBqT8Rkwjnn8I8lfTxTm6vUjBwHRBxkXXv0KTPAj1
	 3b+jhBfKEbttmPMTicYTZMTxw8bjq4lAtkWbSBrmN8RMqg5Mr+Rt0lkspLKAoaxP6d
	 yNlRB7ymKGgmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: openvswitch: conntrack: fix helper UAF due to extensions realloc
Date: Wed, 30 Sep 2026 09:12:45 -0400
Message-ID: <20260930131245.1728178-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092937-camera-idiom-4390@gregkh>
References: <2026092937-camera-idiom-4390@gregkh>
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
index 45a4e39d8bcb7..fbec6c3dcd4e8 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1026,14 +1026,14 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
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
@@ -1241,6 +1241,12 @@ static int ovs_ct_commit(struct net *net, struct sw_flow_key *key,
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

