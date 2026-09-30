Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E6625B099
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728223; cv=none; b=HrUCd2Kq6bkeY8HBgGmPCsLzTyyfOG/cstNVrRfgkmko0R4bhx5g1aMRCG/HT1Bn4jHYorNNxZ0qVcKcfy/L/hVNJCwIsg4riqV5xslSRcc8mJ5u7iHWmjd5HZYg8pZps8gti+0v6u+Hpn9drfSaGPqa0PIaI6sODQcaCxdcO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728223; c=relaxed/simple;
	bh=OwUvQDNxyGejg9nt8X2fNGtcxSpmYhak+aYK9nG6mMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQjXA8/Md0sO2gSfEXMP+tehOrVaztikDUGFd1fH4aYRHdX1I+SdTqC1FVSy4UUag08jGPhIPLh3rc8fdxVRR5CYaOd60Lfg1U6RUO2p0MKNsa2Wb0YCQpU2bODKburdA/K9mWTKzphAYM2G+dmdQ/rhwNRfhXQFGkQCI4UtNy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7ToaEDA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7ToaEDA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D536E1F00893;
	Wed, 30 Sep 2026 00:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790728221;
	bh=ehFdptjm0GT7ekNfxRxOdrRqEwe8KvEqjKIqNz/uZyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F7ToaEDAKE/ciKswGOl0JHUZoml88o9UwXyh+h0gPeZms1Qhqj+ENredVvgJIyc8+
	 Dqn2oOfC38e7Nk1IMBkB7v3Os2FMEibpXDsAjcnK34MzR4yzhwcp3jjGyGgkVAlD0h
	 SyotwyeZDejFFbvsgeZNG/YfjXqeuzAHmDsKTe4rGztXWy4JWF0x3JLmXbmR7V7pev
	 unhLFSdv9Ue2meZCcg4BKhyo2FNEySX8hw7VXptrViEPer73MGdoLY9nhq6iBHXwhL
	 bz4tIoif3hnOYd/WfVFfGEB6RoN6z1MgFbQI+0zpOQvuN5RjZUeE8xvjFTxGlYn9bx
	 cQse3Uz3+JZBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] net/sched: act_ct: fix helper UAF due to extensions realloc
Date: Tue, 29 Sep 2026 20:30:18 -0400
Message-ID: <20260930003018.2941699-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930003018.2941699-1-sashal@kernel.org>
References: <2026092924-carve-arrogant-1991@gregkh>
 <20260930003018.2941699-1-sashal@kernel.org>
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
index 8aed25cad9eef..98fc71fdf4292 100644
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

