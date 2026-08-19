Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F923C0630
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154889; cv=none; b=SPEPB2I9Rwjr7UZypq4s6m9As2vfNl6/uPAqea/Qr84D4woBf+Iqa9dRGTIUBglX9Nch4AiwJLJXpAiW2FtXwPdo2w/zUWkgixbgCa1FK2eHrmRANfHEZS0mECBUY8or/pZspTlq3cf9feN20e5SmXNEiUQ+yC4rzTKm/QmufyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154889; c=relaxed/simple;
	bh=W4AWs+OylKOYkaaLaPEz0MJRRui7aYFqBPttuhFgdGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEUe9Mk0Dwmz8d+Wd5kuZNDv9ZdHfL3Q0cDg7RyDsrTs6Y7/7WPa1XmxyF8lhRLq9mWC9qlGbocGrSVWNYkNFOb+vvRKLO2AGq4mc7CN8D7wF4iwnZEs4rUZN5S3dgtnL2qLfYpk3pgcE9lN140yKwqiDhT71wLJbiki03gsAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HS7gUuQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HS7gUuQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774061F000E9;
	Wed, 19 Aug 2026 15:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787154888;
	bh=MBviu3D2TbI0421xkv/0ieIJMiy9U99/CtryBt5OaOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HS7gUuQe+pXzgqstr6Sl511zNVxyn2tEv/nGSM/ZUnZg2ZTeQm2larpRaxEy0P0Oe
	 mi0lQ8KnA9fuNAyjD59l9gY6TDIn3OESNA92zA6FVfXat93DefawVCcjf19H9Sc5+n
	 4bQ+APgktLGyYm9/6Gp2eE4MmVnqZhMFEWGQVQdcPNtUAbhbcQUue1gHnzFLt2RQT2
	 RS9wGCi9g9fXoQJbe3K8w5SEbnjRXwZ3MccSna13z592yrI/GOfDj6dWhoin9uxnQp
	 1HrbxJ5a8qmOEO9SKVe8RFo2LJZdlRSFBCnYCuI3onrf9y9M+LZCJlqFWHbIBzm17V
	 G+V2KJculQLkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyunjung Ko <hj351016@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net/sched: act_gact, act_police: range check the fallback control action
Date: Wed, 19 Aug 2026 11:54:45 -0400
Message-ID: <20260819155445.159777-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081710-bronco-grumpily-43a9@gregkh>
References: <2026081710-bronco-grumpily-43a9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

[ Upstream commit 883b56ae58fe657d8497806c7059646e9ba6dbd0 ]

tcf_action_check_ctrlact() range checks the primary control action:

	if (!opcode)
		ret = action > TC_ACT_VALUE_MAX ? -EINVAL : 0;

TC_ACT_VALUE_MAX is TC_ACT_TRAP, so kernel-internal verdicts above it
cannot be set that way. But act_gact and act_police each carry a second,
independent control action supplied by user space that never reaches that
helper - TCA_GACT_PROB.paction and TCA_POLICE_RESULT. Both only reject
TC_ACT_GOTO_CHAIN, so any other value is stored verbatim and returned
verbatim from the action.

In particular user space can store TC_ACT_CONSUMED, which is
TC_ACT_VALUE_MAX + 1 and is deliberately not part of the UAPI value
range. That verdict tells every caller the action took ownership of the
skb, so nobody frees it: sch_handle_ingress(), sch_handle_egress() and
tcf_qevent_handle() all deliberately skip the free for it. The result is
one leaked sk_buff plus its data buffer per packet traversing the filter,
unbounded, for all traffic on the chain including kernel-generated
packets.

Both are trivially deterministic. act_gact clamps tcfg_pval to >= 1, so
with pval = 1 gact_determ() returns the fallback for every packet.
act_police has no mandatory rate, so rate = 0 leaves tcfp_mtu = ~0 and
tcf_police_mtu_check() always passes.

TC_ACT_CONSUMED was added by commit 720f22fed81b ("net: sched: refactor
reinsert action"), after both goto-chain guards were written:
commit 9469f375ab09 ("net/sched: act_gact: disallow 'goto chain' on
fallback control action") and
commit c08f5ed5d625 ("net/sched: act_police: disallow 'goto chain' on
fallback control action"). Neither guard was widened when the new
verdict appeared.

Factor the existing range test out of tcf_action_check_ctrlact() as
tcf_action_valid() and apply it to both fallbacks. The helper cannot call
tcf_action_check_ctrlact() directly because that also allocates a
goto_chain, which is exactly what these two sites must not do.

Reproduced on v7.2-rc6: kmemleak reports one leaked 232-byte
skbuff_head_cache object plus its 704-byte data buffer per packet. With
this patch both configurations are rejected with -EINVAL and kmemleak
reports none.

Fixes: 720f22fed81b ("net: sched: refactor reinsert action")
Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Link: https://patch.msgid.link/20260806101252.809593-1-hj351016@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Kept only the new helper lines and dropped the surrounding upstream-only context (CONFIG_INET/tcf_frag_xmit_count block) absent in 5.10. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/act_api.h  | 20 ++++++++++++++++++++
 net/sched/act_gact.c   |  5 +++++
 net/sched/act_police.c |  6 ++++++
 3 files changed, 31 insertions(+)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index bbc4ab5e04f7..fcf5ac9faf19 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -240,6 +240,26 @@ int tcf_action_check_ctrlact(int action, struct tcf_proto *tp,
 			     struct netlink_ext_ack *newchain);
 struct tcf_chain *tcf_action_set_ctrlact(struct tc_action *a, int action,
 					 struct tcf_chain *newchain);
+
+/* Range check for a control action supplied by user space.
+ *
+ * This is the same test tcf_action_check_ctrlact() applies to the primary
+ * control action, factored out for the *fallback* control actions
+ * (act_gact's TCA_GACT_PROB.paction and act_police's TCA_POLICE_RESULT),
+ * which must not reach tcf_action_check_ctrlact() because they have no
+ * goto_chain to allocate.  Without it, user space can store kernel-internal
+ * verdicts such as TC_ACT_CONSUMED, which is TC_ACT_VALUE_MAX + 1 and is
+ * deliberately not part of the UAPI value range.
+ */
+static inline bool tcf_action_valid(int action)
+{
+	int opcode = TC_ACT_EXT_OPCODE(action);
+
+	if (!opcode)
+		return action <= TC_ACT_VALUE_MAX;
+	return opcode <= TC_ACT_EXT_OPCODE_MAX || action == TC_ACT_UNSPEC;
+}
+
 #endif /* CONFIG_NET_CLS_ACT */
 
 static inline void tcf_action_stats_update(struct tc_action *a, u64 bytes,
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index 73c3926358a0..f8a62a5c8cdd 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -89,6 +89,11 @@ static int tcf_gact_init(struct net *net, struct nlattr *nla,
 		p_parm = nla_data(tb[TCA_GACT_PROB]);
 		if (p_parm->ptype >= MAX_RAND)
 			return -EINVAL;
+		if (!tcf_action_valid(p_parm->paction)) {
+			NL_SET_ERR_MSG(extack,
+				       "invalid fallback control action");
+			return -EINVAL;
+		}
 		if (TC_ACT_EXT_CMP(p_parm->paction, TC_ACT_GOTO_CHAIN)) {
 			NL_SET_ERR_MSG(extack,
 				       "goto chain not allowed on fallback");
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index c30cd3ecb391..35868e2a406b 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -134,6 +134,12 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 
 	if (tb[TCA_POLICE_RESULT]) {
 		tcfp_result = nla_get_u32(tb[TCA_POLICE_RESULT]);
+		if (!tcf_action_valid(tcfp_result)) {
+			NL_SET_ERR_MSG(extack,
+				       "invalid fallback control action");
+			err = -EINVAL;
+			goto failure;
+		}
 		if (TC_ACT_EXT_CMP(tcfp_result, TC_ACT_GOTO_CHAIN)) {
 			NL_SET_ERR_MSG(extack,
 				       "goto chain not allowed on fallback");
-- 
2.53.0

