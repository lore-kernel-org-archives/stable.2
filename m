Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5719B22D7A9
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 00:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727628; cv=none; b=q9B08NhzGplPVAZ7maujxkkLg4HrsWrmReUrIyusmRfu9kuiCp3Jh5E6trLpqI2bV9P4KwiaDFM3TIQeEUHHDXnYMcGNDraySWHTJxb7qotLaz4JtFK+m46F2NIG4Bz3T7tQhC4iWQ7MYtrRPAky3s6knghjsPUKI+8lOZQo0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727628; c=relaxed/simple;
	bh=HN6aY62HL0mzhO7h8Ek8QLh0xzodnNtJts0uT+Z0T5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1Ilno/I1MPQs+cXvCygbDqViwc4A9GOA9vuvnlFZywI03PJT3uAzshbB3Fy6JNS6M7mxRhqJAw/LlmrDnugqfx+VF0TP/fpn1klgNw0tOTpMhDJ6lVL9bqE03Olsa8Jpr9B23e7iXSHPg1jTd67q+bo5isvcfR6ZTeVDXDDLyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1F78+pu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1F78+pu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756901F00893;
	Wed, 30 Sep 2026 00:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790727627;
	bh=dBzu8kRyb+vEX74ISOw0Z9EYk8/aknUVh1MqozJRfBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l1F78+puIWP6SaTcYPvxtRIrIuUDEPkQ+EbFxTJjaprSXh6Xddlal0NF+P+ZLDTkR
	 SGR4ylxraCjDECp/ZtXidoCzXejyDKf+xBlT2nRpZvO2DgwPIJeAh17n3q9Bdph25b
	 w8qqOM+o0hG5UPGohiNKcqnieolDmCPctM92asXxBrdVr/mdyfDGKSDgz9/Xei18yd
	 15edC1tfnJ59xJkO8/LYpkKmmKLDNwg8c4CfecA2g1Mu581wsBIT22+fbqTzVUsqbz
	 xtx592QiU/KosUUr3vSQoY4cpSKp8twoUUEG0npkZBBXrRQwQjazE2Z5XvnjqJsKvA
	 2vBQKniwcwHdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] net/sched: act_ct: remove 'add_helper' dead code
Date: Tue, 29 Sep 2026 20:20:24 -0400
Message-ID: <20260930002024.2934218-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930002024.2934218-1-sashal@kernel.org>
References: <2026092956-avalanche-oversized-b625@gregkh>
 <20260930002024.2934218-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit 00df72e39f306e2f7adb68528a5c92109da6a0a9 ]

This variable can only become 'true' when the connection is not
confirmed, but it is only checked when it is confirmed.  So, it can be
treated as being always false and just removed.

Fixes: a21b06e73191 ("net: sched: add helper support in act_ct")
Cc: stable@vger.kernel.org
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Reviewed-by: Aaron Conole <aconole@redhat.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260921145655.3167436-6-i.maximets@ovn.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Retained `p->ct_action & TCA_CT_ACT_NAT` in place of the unavailable `nat` variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ct.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index cbac27ba76afc..a9ed504a9d020 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -985,7 +985,6 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	bool cached, commit, clear;
 	int nh_ofs, err, retval;
 	struct tcf_ct_params *p;
-	bool add_helper = false;
 	bool skb_is_ours = false;
 	bool skip_add = false;
 	bool defrag = false;
@@ -1081,14 +1080,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		err = __nf_ct_try_assign_helper(ct, p->tmpl, GFP_ATOMIC);
 		if (err)
 			goto drop;
-		add_helper = true;
+
 		if (p->ct_action & TCA_CT_ACT_NAT && !nfct_seqadj(ct)) {
 			if (!nfct_seqadj_ext_add(ct))
 				goto drop;
 		}
 	}
 
-	if (nf_ct_is_confirmed(ct) ? ((!cached && !skip_add) || add_helper) : commit) {
+	if (nf_ct_is_confirmed(ct) ? (!cached && !skip_add) : commit) {
 		err = nf_ct_helper(skb, ct, ctinfo, family);
 		if (err != NF_ACCEPT)
 			goto nf_error;
-- 
2.53.0

