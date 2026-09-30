Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9493C1B808
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729050; cv=none; b=szIETrtxQx/trsT/5QynesmkTy9B8U8QFVH4d15W2rpSK2VVOJm+tiCoBTNpYWoP+WQmAKSwbF9UuZckM2ITtFb1v7kiTzDn8D9SLa3PhjIv63agp4yfoJd2M4Dd1kBRlT/TQPBnrU1+Ezkqiz0Jkwyw7VgogDHd0KvtYNCjSbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729050; c=relaxed/simple;
	bh=D3iCd2qMxHWTB0KVg/3ZtQi4Vbtwfb5bQl9VfE01h7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtpFqBXTJlpb5fL/hDTYM5+qUs+6yVYeYBITTNbLyF9RYX+Gg+kOBWPglI5a7zDNJGPvrAyx/tC1O91z7q3EttZeIxjxcVaOLd0TzCjn9quh/uLxCiId38S1Wpn9F2K8RvlxevdeJbQXTSmxWviLH3ZTVhmRfPx66QEfDz0+F9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEo2WrUc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEo2WrUc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0561F000FF;
	Wed, 30 Sep 2026 00:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729049;
	bh=jaWR9bhqQ9ATv5o4JxHvR2D02+2VPh0d4lubvb/IGM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MEo2WrUcwaTJU8wEke3jQjHiIVav3C69kXZqgS43mE+KPKlrwUgy5KvCYETGpUwwu
	 xIhMPPh4OGqIWY+NYrPQy42z73d0B61P5Xs7Xdwr4aGgmUMb+RwsI3LUW3gsVmARIt
	 vS4OjZhTOzj74pLcXsA/zmqC5KJaDnyQ7nUXeQujgKYOY+BPUvhnOR+aKty7BvQloC
	 ZsIaCefDSyea9ziC/Zt3OM/cHa2nc8WNygIE6v0d6M4UQpQ9IhhUjyEa96b/b0vkws
	 6pEsOCZA4q8adgULkpr312rWVmmlf538c4AhxCOW3fDKAfcuHGeJpdM327zso2fST9
	 NTTB9R9MrSSMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] net/sched: act_ct: fix helper UAF due to extensions realloc
Date: Tue, 29 Sep 2026 20:44:06 -0400
Message-ID: <20260930004406.2953452-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930004406.2953452-1-sashal@kernel.org>
References: <2026092949-ceremony-whomever-76f9@gregkh>
 <20260930004406.2953452-1-sashal@kernel.org>
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
 net/sched/act_ct.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 7a0dff24c5d15..3a114f35edc3f 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1084,18 +1084,24 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		}
 	}
 
-	if (nf_ct_is_confirmed(ct) ? ((!cached && !skip_add) || add_helper) : commit) {
-		if (nf_ct_helper(skb, ct, ctinfo, family) != NF_ACCEPT)
-			goto drop;
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
+		if (nf_ct_helper(skb, ct, ctinfo, family) != NF_ACCEPT)
+			goto drop;
+	}
+
+	if (commit) {
 		/* This will take care of sending queued events
 		 * even if the connection is already confirmed.
 		 */
-- 
2.53.0

