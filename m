Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713431;
	b=5bCRnI34aRF7+gftYdpGxAVmb+IyYfg+9+1wTu/xQw3ZWk/yyCcaQIHxqK7SDg+TTQgE
	 b6CFxgKV2okIzBUnTo9dGaDYB5tlrRjUjngskF70h2xjMO2zWWBW3nX8hN19IqOGCueC6
	 P+wVxL45DZvidGsmqkzlOxuJJqIdkfP9fnidBBHZfF2R+ZWDGeyM+P7Huyf1LJ33H8JqI
	 cHiGgSykYrS/BL3tBG8VVpm0Yt4YkAc3a+3Y02cWIjFvSHTiWsOCZFBUpT79JY8bPdFtQ
	 uIrkFR7LfQM8O1m7aN/lz5NDLdZsMzXj4MFHEpl4LN8oFGQ+ZoYr8uWvnUrkC3kbZQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713431;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dR6KO4nW0tTae5QWVyu59hA1+lkU/4NucYgvcOJZiQY=;
	b=pmLzeOEZqq9ilBJ8uLeZVQVIyPNtCsaOWE6N58IUvTJVfkEnReVdvLSTVgLx2xhod+jM
	 oDUWlHe5XQwH6EL4yEV7ZRmj4J0OU1phLgzWx4XAfmOIwGNW/GO31FUUSxwyTgfctJCaL
	 f0NWIDrlG4CWbHUO4+o4Ope6YOjN1x4bXerPvLLgWF0KCPrinhi1AMoqR86mKeUp1X34D
	 AuMW887Z3mQEOUzgMIpbjKNv/VrdbPyrjH32mhhyI7I4U1konLW/U7RixA3DPrcPtBUvA
	 XlT0G/wWN36cLSYaLOjh9qZiTcNFaphANGj7n8pA+rADKhfTkuvUAuj8mSDn8y/xfJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mkt6tTOs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD80606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mkt6tTOs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679CD1F000C1;
	Tue,  3 Nov 2026 13:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793713431;
	bh=dR6KO4nW0tTae5QWVyu59hA1+lkU/4NucYgvcOJZiQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mkt6tTOszr5q69gF0BnrfDlryJjAjvgPTjDmZGLTIGtav5kLXtgaCv76RhagiGYn5
	 LOV41U5W4CTOOT6TR1s7Nhklquhe+2ZZ0pbZiiWrkBqYs89idh3L5sx6d5FajhdF/u
	 7fKRVOE9wfjEzXj6QuV8FJxCd0x7llSPkSo0ZESTJry2Evdtncj1OAsFnJQP+BtDoM
	 Eqg4/fIpQGHRtbu9LYjCFfAcOnD3RQQDXV7rWgivRhA5zwxwH2khhfUYDrwBQQSnMk
	 0gvTD0Vt6YFhRAlnSEVMtUs1Fj6l73Wp4AY917BuaSaHw1GOp9hxZj8ATk/uDlgr+I
	 vmFOpZ26JHXaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuhang Zheng <z1652074432@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Yucheng Lu <kanolyc@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net/sched: cls_flower: avoid stale mask references after delete
Date: Tue,  3 Nov 2026 08:43:49 -0500
Message-ID: <20261103134301.3939151-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110336-surrogate-gummy-3f82@gregkh>
References: <2026110336-surrogate-gummy-3f82@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuhang Zheng <z1652074432@gmail.com>

[ Upstream commit 58f7989da6e715ce834ac861b7ba6ae9f9bdb098 ]

Flower releases a mask reference when a filter is removed from the
classifier. The filter object can remain alive while dump, walk, or
hardware reoffload paths hold a reference to it. Those paths can then
dereference f->mask after the mask has already been released.

Keep the mask reference until the filter reference count reaches zero.
Release the mask synchronously from the final __fl_put() while the caller
still holds the tcf_proto reference, and leave the existing RCU work to
free the mask. This keeps the mask available to every reader that still
holds the filter.

The filter is still removed from the classifier indexes immediately.
Therefore, a deleted filter can temporarily retain an otherwise empty
mask; fl_delete() uses the handle IDR, rather than the mask list, to
determine whether the classifier has become empty.

Failed mask assignment can leave fnew->mask as an error or borrowed
pointer without an owned mask reference. Clear it before the common
failure path so the final put cannot release an unowned reference.

This fix does not add fields, snapshots, or per-filter memory.

Fixes: 92149190067d ("net: sched: flower: set unlocked flag for flower proto ops")
Cc: stable@vger.kernel.org
Reported-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Yucheng Lu <kanolyc@gmail.com>
Signed-off-by: Yuhang Zheng <z1652074432@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Link: https://patch.msgid.link/20261012010720.2248662-2-n05ec@lzu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Adapted fl_change() error cleanup to use the existing errout path instead of unbind_filter and errout_idr. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_flower.c | 49 ++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index c6eb857bce895..ea0592b0249c3 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -508,15 +508,22 @@ static void fl_hw_update_stats(struct tcf_proto *tp, struct cls_fl_filter *f,
 				 cls_flower.stats.used_hw_stats_valid);
 }
 
-static void __fl_put(struct cls_fl_filter *f)
+static bool __fl_put(struct tcf_proto *tp, struct cls_fl_filter *f)
 {
+	bool last = false;
+
 	if (!refcount_dec_and_test(&f->refcnt))
-		return;
+		return false;
+
+	if (f->mask)
+		last = fl_mask_put(fl_head_dereference(tp), f->mask);
 
 	if (tcf_exts_get_net(&f->exts))
 		tcf_queue_work(&f->rwork, fl_destroy_filter_work);
 	else
 		__fl_destroy_filter(f);
+
+	return last;
 }
 
 static struct cls_fl_filter *__fl_get(struct cls_fl_head *head, u32 handle)
@@ -553,11 +560,10 @@ static int __fl_delete(struct tcf_proto *tp, struct cls_fl_filter *f,
 	list_del_rcu(&f->list);
 	spin_unlock(&tp->lock);
 
-	*last = fl_mask_put(head, f->mask);
 	if (!tc_skip_hw(f->flags))
 		fl_hw_destroy_filter(tp, f, rtnl_held, extack);
 	tcf_unbind_filter(tp, &f->res);
-	__fl_put(f);
+	*last = __fl_put(tp, f);
 
 	return 0;
 }
@@ -598,7 +604,7 @@ static void fl_put(struct tcf_proto *tp, void *arg)
 {
 	struct cls_fl_filter *f = arg;
 
-	__fl_put(f);
+	__fl_put(tp, f);
 }
 
 static void *fl_get(struct tcf_proto *tp, u32 handle)
@@ -2229,12 +2235,14 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 		goto errout;
 
 	err = fl_check_assign_mask(head, fnew, fold, mask);
-	if (err)
+	if (err) {
+		fnew->mask = NULL;
 		goto errout;
+	}
 
 	err = fl_ht_insert_unique(fnew, fold, &in_ht);
 	if (err)
-		goto errout_mask;
+		goto errout;
 
 	if (!tc_skip_hw(fnew->flags)) {
 		err = fl_hw_replace_filter(tp, fnew, rtnl_held, extack);
@@ -2288,7 +2296,6 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 
 		spin_unlock(&tp->lock);
 
-		fl_mask_put(head, fold->mask);
 		if (!tc_skip_hw(fold->flags))
 			fl_hw_destroy_filter(tp, fold, rtnl_held, NULL);
 		tcf_unbind_filter(tp, &fold->res);
@@ -2296,7 +2303,7 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 		 * after this.
 		 */
 		refcount_dec(&fold->refcnt);
-		__fl_put(fold);
+		__fl_put(tp, fold);
 	} else {
 		if (handle) {
 			/* user specifies a handle and it doesn't exist */
@@ -2341,17 +2348,15 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	if (in_ht)
 		rhashtable_remove_fast(&fnew->mask->ht, &fnew->ht_node,
 				       fnew->mask->filter_ht_params);
-errout_mask:
-	fl_mask_put(head, fnew->mask);
 errout:
-	__fl_put(fnew);
+	__fl_put(tp, fnew);
 errout_tb:
 	kfree(tb);
 errout_mask_alloc:
 	tcf_queue_work(&mask->rwork, fl_uninit_mask_free_work);
 errout_fold:
 	if (fold)
-		__fl_put(fold);
+		__fl_put(tp, fold);
 	return err;
 }
 
@@ -2364,8 +2369,10 @@ static int fl_delete(struct tcf_proto *tp, void *arg, bool *last,
 	int err = 0;
 
 	err = __fl_delete(tp, f, &last_on_mask, rtnl_held, extack);
-	*last = list_empty(&head->masks);
-	__fl_put(f);
+	spin_lock(&tp->lock);
+	*last = idr_is_empty(&head->handle_idr);
+	spin_unlock(&tp->lock);
+	__fl_put(tp, f);
 
 	return err;
 }
@@ -2387,12 +2394,12 @@ static void fl_walk(struct tcf_proto *tp, struct tcf_walker *arg,
 		rcu_read_unlock();
 
 		if (arg->fn(tp, f, arg) < 0) {
-			__fl_put(f);
+			__fl_put(tp, f);
 			arg->stop = 1;
 			rcu_read_lock();
 			break;
 		}
-		__fl_put(f);
+		__fl_put(tp, f);
 		arg->count++;
 		rcu_read_lock();
 	}
@@ -2443,7 +2450,7 @@ static int fl_reoffload(struct tcf_proto *tp, bool add, flow_setup_cb_t *cb,
 		cls_flower.rule =
 			flow_rule_alloc(tcf_exts_num_actions(&f->exts));
 		if (!cls_flower.rule) {
-			__fl_put(f);
+			__fl_put(tp, f);
 			return -ENOMEM;
 		}
 
@@ -2461,7 +2468,7 @@ static int fl_reoffload(struct tcf_proto *tp, bool add, flow_setup_cb_t *cb,
 		if (err) {
 			kfree(cls_flower.rule);
 			if (tc_skip_sw(f->flags)) {
-				__fl_put(f);
+				__fl_put(tp, f);
 				return err;
 			}
 			goto next_flow;
@@ -2477,11 +2484,11 @@ static int fl_reoffload(struct tcf_proto *tp, bool add, flow_setup_cb_t *cb,
 		kfree(cls_flower.rule);
 
 		if (err) {
-			__fl_put(f);
+			__fl_put(tp, f);
 			return err;
 		}
 next_flow:
-		__fl_put(f);
+		__fl_put(tp, f);
 	}
 
 	return 0;
-- 
2.53.0

