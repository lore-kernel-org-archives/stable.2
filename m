Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE293BFE5D
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970706; cv=none; b=oRGc/nKBjSuMYRNJ4sQJFbPKBpC92GN5aLLbZs0iQMQT2MRiTx8u9m3dw13cXETZi4l9rOdjKyJT7kgsxRqtn0ZFGY9mdyE9HxD1vUDNd5Bss3xb8m1msx99ch6kO21kVK2/AOEvEhzDn/0btAnKj1tWL2o9UY6Zi54u+Gpwfv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970706; c=relaxed/simple;
	bh=JJnKLc8JQW726PcjBA6iSJLe4afqd1UinyKC0ppodPE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TQM5CVNoBkV67JWyBnEWsVeJ63NPOk25xinyQbBOPzhTuXjatBfS+05LfkMPz5uP+uTz+nHVQwRldvmmFmIaJAVrCVwVghtytw057QR/GmOHLVsZpVuMw1Y5EAeOoJuSVkIJXSyYq/zRPJF7GP/WgFULNxjT9shS5QXUOZiyPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EZLOnUQN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EZLOnUQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C531F000E9;
	Mon, 17 Aug 2026 12:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786970705;
	bh=hnWP1cRzJc+wE3JNISjE1URb3Cv9G22DLHbWFXhRw6E=;
	h=Subject:To:Cc:From:Date;
	b=EZLOnUQNEwsYQMgWilYVYHo8mDgT86wrInIeQncMfg6UIg0SGm+ZWt0zamf/u4H0s
	 VrmGnKZzeRBTeQwk4+mTKqTpomVrPm6YYa3c/z1vJiclEe2RlW01O6Jd+oL1rsLcFp
	 AHwrxlQxxJNa32WsmTJvbMifvLuq16iFklcmF2EU=
Subject: FAILED: patch "[PATCH] net/sched: act_gact, act_police: range check the fallback" failed to apply to 5.10-stable tree
To: hj351016@gmail.com,jhs@mojatatu.com,kuba@kernel.org,victor@mojatatu.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:44:10 +0200
Message-ID: <2026081710-bronco-grumpily-43a9@gregkh>
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
git cherry-pick -x 883b56ae58fe657d8497806c7059646e9ba6dbd0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081710-bronco-grumpily-43a9@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 883b56ae58fe657d8497806c7059646e9ba6dbd0 Mon Sep 17 00:00:00 2001
From: Hyunjung Ko <hj351016@gmail.com>
Date: Thu, 6 Aug 2026 19:12:52 +0900
Subject: [PATCH] net/sched: act_gact, act_police: range check the fallback
 control action

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

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 20d9e55f8564..fd03f6319e88 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -270,6 +270,25 @@ int tcf_action_check_ctrlact(int action, struct tcf_proto *tp,
 struct tcf_chain *tcf_action_set_ctrlact(struct tc_action *a, int action,
 					 struct tcf_chain *newchain);
 
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
 #ifdef CONFIG_INET
 DECLARE_STATIC_KEY_FALSE(tcf_frag_xmit_count);
 #endif
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index e949280eb800..565860cccba6 100644
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
index b16468a98c55..ce08f6840ef7 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -128,6 +128,12 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 
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

