Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584E2F7F06
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757418; cv=none; b=azVaZ+mgve7ayCum5O/pA0JB82D3VEOzGezfr6CQ0YsS3/G3/3B3GQOibIqq4tiIle8AZjRrZjZrVK1hicJUlvGHxl0N6zSx0aE+PvUwcWDKqI0LEe4RYWwrpKZsnxLRwlJYvKZ6WmQsy5bYFjx/dt97oRmgR1conGsG8PPGDL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757418; c=relaxed/simple;
	bh=EYnu0xzCrVXt/wre/Qt81uWli/pNSNuKw4qF45U+4H4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pM/gSG11dST36w8W+Y4cnPLTlq7yLTgngcrwaI95HfKLte+K2KZhzQi6IwY+S+MWHGnxfUX+S7p+VSK9p2bk1Fda1PCTYNse2uxdwy4bj2gDB7GPw4Uu5KWfpcrT8ADSDxyvVok4JCVHfB4IvQJ1g3KE9PLK9LhdnQBlYNJruRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WZm7+X09; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WZm7+X09"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781757382;
	bh=YcyzU/a09dhsc/WTc9eeoW4OxUBYi9lxkRjBL6yCMpw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=WZm7+X09UzOj2X+Lyx41ZieSyweaO3B6D/7WkIZIhdmm61x+Q+AV7jXE8/RuL7OOM
	 DXroXDrTnAKM5+9epMHt55Ibn8vlKuwyfEG58y67SE+zdaqVFH1BjxgseL5giT+wXA
	 GGmUIvsNoVSWl4HYtNZkuWUtaEuSjLeb/9z4+6+U=
X-QQ-mid: zesmtpsz6t1781757363t4d697998
X-QQ-Originating-IP: uOUjjAA4iLe+mplZOG3C8pZaWni1zANMLr7SaAYToSg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 12:35:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1071775823135304684
EX-QQ-RecipientCnt: 17
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com
Cc: stable@vger.kernel.org,
	2045gemini@gmail.com,
	dcaratti@redhat.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com,
	Pedro Tammela <pctammela@mojatatu.com>,
	Simon Horman <simon.horman@corigine.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y 2/8] net/sched: transition act_pedit to rcu and percpu stats
Date: Thu, 18 Jun 2026 12:35:34 +0800
Message-Id: <20260618043539.1557035-3-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618043539.1557035-1-guanwentao@uniontech.com>
References: <20260618043539.1557035-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M3ziZXKDk+iOqeEUYBzwnSOpyZo3uDVYTufUbyC5YbWkaMBF7e7LPVjx
	ug67nakSKS/Fey7yKiocjk3Agg5mD+ar6FYPuBJYmjhEzwz4K/RJNynHyWrTEOCR92xOHJ8
	ITU0fX6vmblNVxUzTMQA5c34zt/heTUnte0xmqPdIHKOqay6eglr2wWW3BBJFJvZ4eMikaj
	AIMypI+lvxSt5bQFeZdT/dDiHw9kIBwrlc7xWf8rwj0boctP+lGgPpsydZErQQjUeM45SPM
	uPOIwTREr6TcdG88FrZBe6CqVEa2dnLlJwyiO7+c0HmVuXsSk36kM9E1kayNCeeDGuOYVdu
	o+DnbL151JtyW5Sf1JIyN9gum6GJUrpxBi8BmaFLdakVvdpC49tVxZP/L2lhnA0sxLKGmGA
	7NvIJLqwsrdZHXQDWIiSMbHR/ieL8kNOkaequMhLL2qsnUPIVr80j+NFbIaKhaxpaKxsfO4
	23Yw8LLUyDfGiERJgtELHMTusJHthBHSwtbyXbpJNT3yR18Ub0zOL3PDzIno7f6o2zo/l5d
	XyYBTx0LLiNSpc1ZaPXYawsa+86Ldd0ryld7+VqADCJ1YUJCg26QMwwe5vaMNir1RBdcs0g
	YauenYBi1aRoUzHZOeh8W3iZVx3LWVrtlaa4dKFYoosDkCa/loKxgerE7SS4PQs+VQjQK5o
	vsO0ev3NLuSrCO2bFOA+ww/y02SwL8P5X6+1S3ZR6iXtVkCbehF6KhBiznBrzkCEvySkwNt
	2DkMKJmvq0oRL13vtY2A/if9K3kVYhMrfOBJLfyDSv8XkFeM6Fs9K5syWi/vUa7ba0JeFCX
	/7LFaYTNpe+MkKYDsbhNcbQcDlY70nX3H33qbUswjtEO+0LVOViFUjwpqih9GALazX35F6o
	3fCvCCozrSnJPZsrMkifmn6AMknN8nT/78ytTCZaYpHOMHckKNgZgHhw94QGWOUfh8U1tPd
	pAf0tj6ra47j/0wupQEJVTAafg+FXEw8ej539uyonBhufNW+5jbf4G5pHCmt0eymnvUEf2H
	o6VbEgPnSCJecoffVnDrJk6WHq+SeGVZymGBZJa2BSunJ4n7rSl10NlgfO7uATinKVjPfgo
	Q==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit 52cf89f78c01bf39973f3e70d366921d70faff7a ]

The software pedit action didn't get the same love as some of the
other actions and it's still using spinlocks and shared stats in the
datapath.
Transition the action to rcu and percpu stats as this improves the
action's performance dramatically on multiple cpu deployments.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: e9e42292ea76 ("net/sched: act_pedit: fix action bind logic")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Conflicts:
	net/sched/act_pedit.c
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 include/net/tc_act/tc_pedit.h |  81 +++++++++++++++----
 net/sched/act_pedit.c         | 148 ++++++++++++++++++++--------------
 2 files changed, 153 insertions(+), 76 deletions(-)

diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h
index 3e02709a1df65..83fe399317818 100644
--- a/include/net/tc_act/tc_pedit.h
+++ b/include/net/tc_act/tc_pedit.h
@@ -4,22 +4,29 @@
 
 #include <net/act_api.h>
 #include <linux/tc_act/tc_pedit.h>
+#include <linux/types.h>
 
 struct tcf_pedit_key_ex {
 	enum pedit_header_type htype;
 	enum pedit_cmd cmd;
 };
 
-struct tcf_pedit {
-	struct tc_action	common;
-	unsigned char		tcfp_nkeys;
-	unsigned char		tcfp_flags;
-	u32			tcfp_off_max_hint;
+struct tcf_pedit_parms {
 	struct tc_pedit_key	*tcfp_keys;
 	struct tcf_pedit_key_ex	*tcfp_keys_ex;
+	u32 tcfp_off_max_hint;
+	unsigned char tcfp_nkeys;
+	unsigned char tcfp_flags;
+	struct rcu_head rcu;
+};
+
+struct tcf_pedit {
+	struct tc_action common;
+	struct tcf_pedit_parms __rcu *parms;
 };
 
 #define to_pedit(a) ((struct tcf_pedit *)a)
+#define to_pedit_parms(a) (rcu_dereference(to_pedit(a)->parms))
 
 static inline bool is_tcf_pedit(const struct tc_action *a)
 {
@@ -32,37 +39,81 @@ static inline bool is_tcf_pedit(const struct tc_action *a)
 
 static inline int tcf_pedit_nkeys(const struct tc_action *a)
 {
-	return to_pedit(a)->tcfp_nkeys;
+	struct tcf_pedit_parms *parms;
+	int nkeys;
+
+	rcu_read_lock();
+	parms = to_pedit_parms(a);
+	nkeys = parms->tcfp_nkeys;
+	rcu_read_unlock();
+
+	return nkeys;
 }
 
 static inline u32 tcf_pedit_htype(const struct tc_action *a, int index)
 {
-	if (to_pedit(a)->tcfp_keys_ex)
-		return to_pedit(a)->tcfp_keys_ex[index].htype;
+	u32 htype = TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK;
+	struct tcf_pedit_parms *parms;
+
+	rcu_read_lock();
+	parms = to_pedit_parms(a);
+	if (parms->tcfp_keys_ex)
+		htype = parms->tcfp_keys_ex[index].htype;
+	rcu_read_unlock();
 
-	return TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK;
+	return htype;
 }
 
 static inline u32 tcf_pedit_cmd(const struct tc_action *a, int index)
 {
-	if (to_pedit(a)->tcfp_keys_ex)
-		return to_pedit(a)->tcfp_keys_ex[index].cmd;
+	struct tcf_pedit_parms *parms;
+	u32 cmd = __PEDIT_CMD_MAX;
 
-	return __PEDIT_CMD_MAX;
+	rcu_read_lock();
+	parms = to_pedit_parms(a);
+	if (parms->tcfp_keys_ex)
+		cmd = parms->tcfp_keys_ex[index].cmd;
+	rcu_read_unlock();
+
+	return cmd;
 }
 
 static inline u32 tcf_pedit_mask(const struct tc_action *a, int index)
 {
-	return to_pedit(a)->tcfp_keys[index].mask;
+	struct tcf_pedit_parms *parms;
+	u32 mask;
+
+	rcu_read_lock();
+	parms = to_pedit_parms(a);
+	mask = parms->tcfp_keys[index].mask;
+	rcu_read_unlock();
+
+	return mask;
 }
 
 static inline u32 tcf_pedit_val(const struct tc_action *a, int index)
 {
-	return to_pedit(a)->tcfp_keys[index].val;
+	struct tcf_pedit_parms *parms;
+	u32 val;
+
+	rcu_read_lock();
+	parms = to_pedit_parms(a);
+	val = parms->tcfp_keys[index].val;
+	rcu_read_unlock();
+
+	return val;
 }
 
 static inline u32 tcf_pedit_offset(const struct tc_action *a, int index)
 {
-	return to_pedit(a)->tcfp_keys[index].off;
+	struct tcf_pedit_parms *parms;
+	u32 off;
+
+	rcu_read_lock();
+	parms = to_pedit_parms(a);
+	off = parms->tcfp_keys[index].off;
+	rcu_read_unlock();
+
+	return off;
 }
 #endif /* __NET_TC_PED_H */
diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 510a3b5b8c0c1..0fbffebfbdc9d 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -130,6 +130,17 @@ static int tcf_pedit_key_ex_dump(struct sk_buff *skb,
 	return -EINVAL;
 }
 
+static void tcf_pedit_cleanup_rcu(struct rcu_head *head)
+{
+	struct tcf_pedit_parms *parms =
+		container_of(head, struct tcf_pedit_parms, rcu);
+
+	kfree(parms->tcfp_keys_ex);
+	kfree(parms->tcfp_keys);
+
+	kfree(parms);
+}
+
 static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 			  struct nlattr *est, struct tc_action **a,
 			  int ovr, int bind, bool rtnl_held,
@@ -137,10 +148,9 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 			  struct netlink_ext_ack *extack)
 {
 	struct tc_action_net *tn = net_generic(net, pedit_net_id);
-	struct nlattr *tb[TCA_PEDIT_MAX + 1];
 	struct tcf_chain *goto_ch = NULL;
-	struct tc_pedit_key *keys = NULL;
-	struct tcf_pedit_key_ex *keys_ex;
+	struct tcf_pedit_parms *oparms, *nparms;
+	struct nlattr *tb[TCA_PEDIT_MAX + 1];
 	struct tc_pedit *parm;
 	struct nlattr *pattr;
 	struct tcf_pedit *p;
@@ -177,18 +187,25 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		return -EINVAL;
 	}
 
-	keys_ex = tcf_pedit_keys_ex_parse(tb[TCA_PEDIT_KEYS_EX], parm->nkeys);
-	if (IS_ERR(keys_ex))
-		return PTR_ERR(keys_ex);
+	nparms = kzalloc(sizeof(*nparms), GFP_KERNEL);
+	if (!nparms)
+		return -ENOMEM;
+
+	nparms->tcfp_keys_ex =
+		tcf_pedit_keys_ex_parse(tb[TCA_PEDIT_KEYS_EX], parm->nkeys);
+	if (IS_ERR(nparms->tcfp_keys_ex)) {
+		ret = PTR_ERR(nparms->tcfp_keys_ex);
+		goto out_free;
+	}
 
 	index = parm->index;
 	err = tcf_idr_check_alloc(tn, &index, a, bind);
 	if (!err) {
-		ret = tcf_idr_create(tn, index, est, a,
-				     &act_pedit_ops, bind, false, flags);
+		ret = tcf_idr_create_from_flags(tn, index, est, a,
+						&act_pedit_ops, bind, flags);
 		if (ret) {
 			tcf_idr_cleanup(tn, index);
-			goto out_free;
+			goto out_free_ex;
 		}
 		ret = ACT_P_CREATED;
 	} else if (err > 0) {
@@ -200,7 +217,7 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		}
 	} else {
 		ret = err;
-		goto out_free;
+		goto out_free_ex;
 	}
 
 	err = tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
@@ -208,48 +225,50 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		ret = err;
 		goto out_release;
 	}
-	p = to_pedit(*a);
-	spin_lock_bh(&p->tcf_lock);
 
-	if (ret == ACT_P_CREATED ||
-	    (p->tcfp_nkeys && p->tcfp_nkeys != parm->nkeys)) {
-		keys = kmalloc(ksize, GFP_ATOMIC);
-		if (!keys) {
-			spin_unlock_bh(&p->tcf_lock);
-			ret = -ENOMEM;
-			goto put_chain;
-		}
-		kfree(p->tcfp_keys);
-		p->tcfp_keys = keys;
-		p->tcfp_nkeys = parm->nkeys;
+	nparms->tcfp_off_max_hint = 0;
+	nparms->tcfp_flags = parm->flags;
+	nparms->tcfp_nkeys = parm->nkeys;
+
+	nparms->tcfp_keys = kmalloc(ksize, GFP_KERNEL);
+	if (!nparms->tcfp_keys) {
+		ret = -ENOMEM;
+		goto put_chain;
 	}
-	memcpy(p->tcfp_keys, parm->keys, ksize);
-	p->tcfp_off_max_hint = 0;
-	for (i = 0; i < p->tcfp_nkeys; ++i) {
-		u32 cur = p->tcfp_keys[i].off;
+
+	memcpy(nparms->tcfp_keys, parm->keys, ksize);
+
+	for (i = 0; i < nparms->tcfp_nkeys; ++i) {
+		u32 cur = nparms->tcfp_keys[i].off;
 
 		/* sanitize the shift value for any later use */
-		p->tcfp_keys[i].shift = min_t(size_t, BITS_PER_TYPE(int) - 1,
-					      p->tcfp_keys[i].shift);
+		nparms->tcfp_keys[i].shift = min_t(size_t,
+						   BITS_PER_TYPE(int) - 1,
+						   nparms->tcfp_keys[i].shift);
 
 		/* The AT option can read a single byte, we can bound the actual
 		 * value with uchar max.
 		 */
-		cur += (0xff & p->tcfp_keys[i].offmask) >> p->tcfp_keys[i].shift;
+		cur += (0xff & nparms->tcfp_keys[i].offmask) >> nparms->tcfp_keys[i].shift;
 
 		/* Each key touches 4 bytes starting from the computed offset */
-		p->tcfp_off_max_hint = max(p->tcfp_off_max_hint, cur + 4);
+		nparms->tcfp_off_max_hint =
+			max(nparms->tcfp_off_max_hint, cur + 4);
 	}
 
-	p->tcfp_flags = parm->flags;
+	p = to_pedit(*a);
+
+	spin_lock_bh(&p->tcf_lock);
 	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
+	oparms = rcu_replace_pointer(p->parms, nparms, 1);
+	spin_unlock_bh(&p->tcf_lock);
 
-	kfree(p->tcfp_keys_ex);
-	p->tcfp_keys_ex = keys_ex;
+	if (oparms)
+		call_rcu(&oparms->rcu, tcf_pedit_cleanup_rcu);
 
-	spin_unlock_bh(&p->tcf_lock);
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
+
 	return ret;
 
 put_chain:
@@ -257,19 +276,22 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		tcf_chain_put_by_act(goto_ch);
 out_release:
 	tcf_idr_release(*a, bind);
+out_free_ex:
+	kfree(nparms->tcfp_keys_ex);
 out_free:
-	kfree(keys_ex);
+	kfree(nparms);
 	return ret;
-
 }
 
 static void tcf_pedit_cleanup(struct tc_action *a)
 {
 	struct tcf_pedit *p = to_pedit(a);
-	struct tc_pedit_key *keys = p->tcfp_keys;
+	struct tcf_pedit_parms *parms;
 
-	kfree(keys);
-	kfree(p->tcfp_keys_ex);
+	parms = rcu_dereference_protected(p->parms, 1);
+
+	if (parms)
+		call_rcu(&parms->rcu, tcf_pedit_cleanup_rcu);
 }
 
 static bool offset_valid(struct sk_buff *skb, int offset)
@@ -320,28 +342,30 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 			 struct tcf_result *res)
 {
 	struct tcf_pedit *p = to_pedit(a);
+	struct tcf_pedit_parms *parms;
 	u32 max_offset;
 	int i;
 
-	spin_lock(&p->tcf_lock);
+	parms = rcu_dereference_bh(p->parms);
 
 	max_offset = (skb_transport_header_was_set(skb) ?
 		      skb_transport_offset(skb) :
 		      skb_network_offset(skb)) +
-		     p->tcfp_off_max_hint;
+		     parms->tcfp_off_max_hint;
 	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
-		goto unlock;
+		goto done;
 
 	tcf_lastuse_update(&p->tcf_tm);
+	tcf_action_update_bstats(&p->common, skb);
 
-	if (p->tcfp_nkeys > 0) {
-		struct tc_pedit_key *tkey = p->tcfp_keys;
-		struct tcf_pedit_key_ex *tkey_ex = p->tcfp_keys_ex;
+	if (parms->tcfp_nkeys > 0) {
+		struct tc_pedit_key *tkey = parms->tcfp_keys;
+		struct tcf_pedit_key_ex *tkey_ex = parms->tcfp_keys_ex;
 		enum pedit_header_type htype =
 			TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK;
 		enum pedit_cmd cmd = TCA_PEDIT_KEY_EX_CMD_SET;
 
-		for (i = p->tcfp_nkeys; i > 0; i--, tkey++) {
+		for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
 			u32 *ptr, hdata;
 			int offset = tkey->off;
 			int hoffset;
@@ -417,11 +441,10 @@ static int tcf_pedit_act(struct sk_buff *skb, const struct tc_action *a,
 	}
 
 bad:
+	spin_lock(&p->tcf_lock);
 	p->tcf_qstats.overlimits++;
-done:
-	bstats_update(&p->tcf_bstats, skb);
-unlock:
 	spin_unlock(&p->tcf_lock);
+done:
 	return p->tcf_action;
 }
 
@@ -440,30 +463,33 @@ static int tcf_pedit_dump(struct sk_buff *skb, struct tc_action *a,
 {
 	unsigned char *b = skb_tail_pointer(skb);
 	struct tcf_pedit *p = to_pedit(a);
+	struct tcf_pedit_parms *parms;
 	struct tc_pedit *opt;
 	struct tcf_t t;
 	int s;
 
-	s = struct_size(opt, keys, p->tcfp_nkeys);
+	spin_lock_bh(&p->tcf_lock);
+	parms = rcu_dereference_protected(p->parms, 1);
+	s = struct_size(opt, keys, parms->tcfp_nkeys);
 
-	/* netlink spinlocks held above us - must use ATOMIC */
 	opt = kzalloc(s, GFP_ATOMIC);
-	if (unlikely(!opt))
+	if (unlikely(!opt)) {
+		spin_unlock_bh(&p->tcf_lock);
 		return -ENOBUFS;
+	}
 
-	spin_lock_bh(&p->tcf_lock);
-	memcpy(opt->keys, p->tcfp_keys, flex_array_size(opt, keys, p->tcfp_nkeys));
+	memcpy(opt->keys, parms->tcfp_keys,
+	       flex_array_size(opt, keys, parms->tcfp_nkeys));
 	opt->index = p->tcf_index;
-	opt->nkeys = p->tcfp_nkeys;
-	opt->flags = p->tcfp_flags;
+	opt->nkeys = parms->tcfp_nkeys;
+	opt->flags = parms->tcfp_flags;
 	opt->action = p->tcf_action;
 	opt->refcnt = refcount_read(&p->tcf_refcnt) - ref;
 	opt->bindcnt = atomic_read(&p->tcf_bindcnt) - bind;
 
-	if (p->tcfp_keys_ex) {
-		if (tcf_pedit_key_ex_dump(skb,
-					  p->tcfp_keys_ex,
-					  p->tcfp_nkeys))
+	if (parms->tcfp_keys_ex) {
+		if (tcf_pedit_key_ex_dump(skb, parms->tcfp_keys_ex,
+					  parms->tcfp_nkeys))
 			goto nla_put_failure;
 
 		if (nla_put(skb, TCA_PEDIT_PARMS_EX, s, opt))
-- 
2.30.2

