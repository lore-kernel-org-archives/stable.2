Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7232C22D7A9
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728220; cv=none; b=NpiK1UtzEj7S/SdpUR9M2hn5xvMDkKJsSdKQ8T503/k7oin2uf7C/WbhaIR7IAUVsoEzdfSzvap4nwlmpBe5c4SW6S3xHHfr4+mKv0j78Gu/aHSGKQ3Wr/oLJL/+h6v5yVcgGiwd0ASWJrzcnhDe4Rb8KZcg3uz6GOAEq6LED04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728220; c=relaxed/simple;
	bh=OwUvQDNxyGejg9nt8X2fNGtcxSpmYhak+aYK9nG6mMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rHFczjHjJHCcfDwbBTRPO++DLPfbvAeIX8C43gteeHkH1Eqoen5kY88554D1Z0HYV+RAXOR2OVATAjidXvXV//qwgu5dPXu22ROUPXBEihboKjcnY90kfeh/6QhovwLcRSahDYthp54IC7RGcR3OlJ0RPIxjzvaoRfmQRV3tQLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVKkaQCf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVKkaQCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF451F00893;
	Wed, 30 Sep 2026 00:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790728219;
	bh=ehFdptjm0GT7ekNfxRxOdrRqEwe8KvEqjKIqNz/uZyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OVKkaQCfU2WAMrU18SoBl4H0HvQz8eaIh1Fxoz/1NLA/d9O3KJewqb1C6ladNGoRK
	 fg3KWQDsPLaL0G+OBXYu1yZ/cP1pu31K6TYYCOas8kyYlKEYy65uEgGNw8fdTgtJSy
	 qDdWXy/JxP5SH9Ej+zCTENiFgxk6WdJ4L3VA1hS7bPIUfHmb1bPocUyPpE1VkXzd2q
	 GAYkEp0TM29iR7NzIB2A7K52FjhWMLIQME/SAuYd3RDQTYonL7QWgLrNBjvUb/dGPT
	 ee8FJ+KKexRv1T7s132fl9oAN5LM+e5tGSuAekyRQlLi8zcXB2p0P6aVenPIemmuVZ
	 fjbBRajRcGsJQ==
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
Date: Tue, 29 Sep 2026 20:30:15 -0400
Message-ID: <20260930003015.2941506-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930003015.2941506-1-sashal@kernel.org>
References: <2026092924-carve-arrogant-1991@gregkh>
 <20260930003015.2941506-1-sashal@kernel.org>
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

