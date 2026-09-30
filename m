Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB46022D7A9
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727623; cv=none; b=rbljo8xSfwYHcpnvpeUXww9ezMzxodrYI9mId9ui388lIvF3eKMa2gLW5RIUrNntZ5V9b4RzPxJN/NHvTNz5F+B5MnsnRjw0uobXwnvbDHMVaBaT69UiFPHZCmSTHAkH0fRytbltVldZbltE2AemG0dTMd/CS6zc7ebF7FH23SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727623; c=relaxed/simple;
	bh=grZ5hJlWe7OAftg+o9KETGwJiXX7n6A0NX1qpNG1GDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAGMvMWmkxV2gt7h6TN2b3JCb7ibYf+nm7JNLFLS0RwkNotHPOnLsRqXm+A0nJUWv7ioPWJLfjYieOcijLHyXMiFji0K2x8Sh7g/7GWK1Cbj8iDNSxGXtjK1MbzwOErfjt7iY8iFAP2w38GaphgxKofotAKUCGBRrbb+KEujBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrxJUcmc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrxJUcmc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5061F00893;
	Wed, 30 Sep 2026 00:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790727621;
	bh=H4o9xKkLiA/6PLFyNGVpD8W1FYdgmNfXn9QsBGn+7kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mrxJUcmcH5MBzXu0sqp5p/W8PXab4XbBn0CB2Azg3zUKap2iolv46BqMYcS6D1mex
	 8qGE9mDAVOyRAg/r2fpyYbz+nvuaF1Tf+JSKtZkGNkthxFUvLJW6UWKNjZe8cv//kC
	 8EOdwIljF+u17hSg8ZYtRbYY+NELce8pZp7VxQloRtJV0GoU3+kZWlV1wmhcWpaJoE
	 a2f9v8O0Enx/ukX1hpGPALA/AePtcr4GQY+a4eEOVhEFli1EyQh1pGjDNYUyBYqRcM
	 Nm02FNbMm/ktgua4Lg2KF3I79x9R66oah7FqvAp9hwKTRi8rqE1KT+UNtCm4vtlvHS
	 uSLjx0rjBLuAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] net/sched: act_ct: fix helper UAF due to extensions realloc
Date: Tue, 29 Sep 2026 20:20:18 -0400
Message-ID: <20260930002018.2933978-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930002018.2933978-1-sashal@kernel.org>
References: <2026092923-during-buffalo-09b7@gregkh>
 <20260930002018.2933978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit dad19b59da050cb60d3f7023dac2a042a84bf0bd ]

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

Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
Cc: stable@vger.kernel.org
Reported-by: Axel Mierczuk <axel.mierczuk@1password.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20260921145655.3167436-7-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Preserved the existing add_helper condition that upstream had removed. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ct.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index cbac27ba76afc..c6085b06ec279 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1088,19 +1088,25 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		}
 	}
 
-	if (nf_ct_is_confirmed(ct) ? ((!cached && !skip_add) || add_helper) : commit) {
-		err = nf_ct_helper(skb, ct, ctinfo, family);
-		if (err != NF_ACCEPT)
-			goto nf_error;
-	}
-
 	if (commit) {
 		tcf_ct_act_set_mark(ct, p->mark, p->mark_mask);
 		tcf_ct_act_set_labels(ct, p->labels, p->labels_mask);
 
 		if (!nf_ct_is_confirmed(ct))
 			nf_conn_act_ct_ext_add(skb, ct, ctinfo);
+	}
 
+	/* Run helpers for the connection if nf_conntrack_in() was executed
+	 * or if we're about to commit.  This has to be done after all the
+	 * extensions are already added.
+	 */
+	if (nf_ct_is_confirmed(ct) ? ((!cached && !skip_add) || add_helper) : commit) {
+		err = nf_ct_helper(skb, ct, ctinfo, family);
+		if (err != NF_ACCEPT)
+			goto nf_error;
+	}
+
+	if (commit) {
 		/* This will take care of sending queued events
 		 * even if the connection is already confirmed.
 		 */
-- 
2.53.0

