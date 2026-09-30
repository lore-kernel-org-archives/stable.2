Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED336B923
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 02:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790735668; cv=none; b=FLe3668bZlSXCj5dZ6dYEkmQwVh7CTQubMKmbkuVLfYF2GwlpI9xxmrhxSsUryABpnlI5rEq2WoEscZNnhz7L6K1PWnoa6P0BxOJenis6Nt9Ct5wD001zQyxC10ASCt/aQpYMAqm7hMq5fZAcNXyj8BYZigXg7kpbVzVDWesy2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790735668; c=relaxed/simple;
	bh=4iyiwZPArfq1ysGtgObgvI5dliUXFuKq4TqyutX3JsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSjA1V78cEHSt73W41ye2XLLnn7ou4raTbC/M2fIyL0H0IQEkeO29nFTfXoo9KqB7b3Vtr0n1T6bK87XVbhdD1PE0yLsjwzPwqcdfsPxS91d4Bs0ipD4XP6HtceHIv4RMktjZta2/RdMWNcpt+BMtlz/+d2PSaJn2SICoNTfnYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQflADzF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQflADzF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135141F0089C;
	Wed, 30 Sep 2026 02:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790735649;
	bh=D3igxal6UfgHpVrDyJub7tu8QsawE1eLzw/HAufZgYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OQflADzFpTIOelhddG5G998wSWyGagA5bEAhjvwSUSqc6SV+l0o4gq3a0aKeMjqKd
	 Ei4pkY5nT4WwtXsA9pdLumQ1uTKn46boVK4MTIITDkM4Zf5W3EU0GN0ZKnU26PF/LP
	 2EKUb3DPrwmIa22DaXnEqt374dLcI86256eqeP5cBBYl2jlHPee34oDKP/tbVxGONb
	 pvOrKlHro4oxuusqIXrHizLVKvBMbxwNZNpM/02b52VGOUTwh7y5VIdHZxv20m4vQq
	 sDGC9gmI5ejM7LcKxuKHRpiDy2Q/ktLRm8n5guc4g9KqINVZfValEf9otYW7JiWLOB
	 xF+COIPlkps5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] net/sched: act_ct: remove 'add_helper' dead code
Date: Tue, 29 Sep 2026 22:34:06 -0400
Message-ID: <20260930023406.3421456-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930023406.3421456-1-sashal@kernel.org>
References: <2026092940-dropout-pebbly-3736@gregkh>
 <20260930023406.3421456-1-sashal@kernel.org>
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
[ adjusted context to preserve the direct NAT flag check and goto drop error handling. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/act_ct.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 7a0dff24c5d15..bdffceeb4f34d 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -981,7 +981,6 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	bool cached, commit, clear;
 	int nh_ofs, err, retval;
 	struct tcf_ct_params *p;
-	bool add_helper = false;
 	bool skb_is_ours = false;
 	bool skip_add = false;
 	bool defrag = false;
@@ -1077,14 +1076,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
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
 		if (nf_ct_helper(skb, ct, ctinfo, family) != NF_ACCEPT)
 			goto drop;
 	}
-- 
2.53.0

