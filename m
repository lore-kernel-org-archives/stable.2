Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717941;
	b=Egv7YYJZr4VDCXdgC6H5TeDvttz1h98a2YMLEgBjeaZzkQR9eLM7fLLNyLbr1Vp3n/mw
	 4LKheGEUC36un7iR64Jbg9tKofuiCsLKGmW0hf4dDvGFHHKyg8PhMHzUVTEol8m2X1vRv
	 C+u4gW4p0BKJGyUP3M3dsvJAx0YdSPzUR2P9lGfVUEUXv7E5UwpuhjxIhGeBNudi20TtZ
	 C+Bfktyg12ZL5KKPmpsmj08QeGednZWySpZYmRnaspfJg4OGi3Fb1jOo/oNvznFRYIADY
	 LUR7eKURwiP6IJr73PYgxoWMmD2rggehqpTuhrbPkNkNBDLEuS5ksZfWg8Qa1t/xNmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717941;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=biHQPh0o+AiSCsLyfeS4hnYw1Z0H3pXw2ddQU2f0nEU=;
	b=C1NcyqXiXpkhxTbNTbB3blZC4ZKdSfX/LCM6JE+6YIDOQbXcDjVQetNCs26w+7bRkiwG
	 mA/E6ormInbg9ptXzwU6kMwtQscc2w4vFFbw42oGieyiHHC+kDqEP4KiBG5FSny8NGqD2
	 MhFWfMMJWPwNA20yfr8SCBeoVQbZb0fLKjWXQa1PHwm1LSA5URkesQSYg/rjKYXuIKdJ5
	 ny7nowO8L1ZhK7DG21SBagtecvpYWQ0kkBgPzZod95c9kOcdrbgS1H1nL3Hgq0h0BsoJj
	 zI3j7buovEo8W0Q2xeP4J84lhff/SvK76nZ+rFXAVaL/AfNFyi7Nq6r6E9HltEKz74w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CzML/aMk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20673606C829
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CzML/aMk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006071F000C1;
	Tue,  3 Nov 2026 14:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717940;
	bh=biHQPh0o+AiSCsLyfeS4hnYw1Z0H3pXw2ddQU2f0nEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CzML/aMkQVM6pIfPELieMXoh/xH7uUTao9r/ObUpS463iFpGGjDY8sYeQtJHvOXLn
	 cXcwubPdsRjX7D4UXnGTQnzFf+fGYdIUlNJCmRYLvGHIAHd2SMhHYSAleWvVv2m/wU
	 ZT03h8FMtcYiqoSwiqy6GzkWvsrzLfi0hVbMnQPbPEaOqjUf7jtuSGfYPptuidAv/h
	 RGeOCcqZ5nfRPkp1rbS/6bjlXyMODyZcXBZS/iAJ3AugoDilhPrQDZjQhz+7zk3scB
	 sQ85uXFgU1kGQIMouf+hzINgC7HWMG3CImt3Gn09ocPuZZLm++6mx60QPpbo5vUMN+
	 X0Z3PSHwd9fdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuhang Zheng <z1652074432@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Yucheng Lu <kanolyc@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net/sched: cls_flower: avoid stale mask references after delete
Date: Tue,  3 Nov 2026 09:58:58 -0500
Message-ID: <20261103145823.4110887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110337-dynasty-fanciness-0b19@gregkh>
References: <2026110337-dynasty-fanciness-0b19@gregkh>
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
[ sashal: Changed jumps to unbind_filter to use the existing errout cleanup label. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_flower.c | 49 ++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index d4fa6fe2560f3..b44a3a2d724fb 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -504,15 +504,22 @@ static void fl_hw_update_stats(struct tcf_proto *tp, struct cls_fl_filter *f,
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
@@ -549,11 +556,10 @@ static int __fl_delete(struct tcf_proto *tp, struct cls_fl_filter *f,
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
@@ -594,7 +600,7 @@ static void fl_put(struct tcf_proto *tp, void *arg)
 {
 	struct cls_fl_filter *f = arg;
 
-	__fl_put(f);
+	__fl_put(tp, f);
 }
 
 static void *fl_get(struct tcf_proto *tp, u32 handle)
@@ -2063,12 +2069,14 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
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
@@ -2120,7 +2128,6 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 
 		spin_unlock(&tp->lock);
 
-		fl_mask_put(head, fold->mask);
 		if (!tc_skip_hw(fold->flags))
 			fl_hw_destroy_filter(tp, fold, rtnl_held, NULL);
 		tcf_unbind_filter(tp, &fold->res);
@@ -2128,7 +2135,7 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 		 * after this.
 		 */
 		refcount_dec(&fold->refcnt);
-		__fl_put(fold);
+		__fl_put(tp, fold);
 	} else {
 		if (handle) {
 			/* user specifies a handle and it doesn't exist */
@@ -2173,17 +2180,15 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
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
 
@@ -2196,8 +2201,10 @@ static int fl_delete(struct tcf_proto *tp, void *arg, bool *last,
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
@@ -2219,12 +2226,12 @@ static void fl_walk(struct tcf_proto *tp, struct tcf_walker *arg,
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
@@ -2275,7 +2282,7 @@ static int fl_reoffload(struct tcf_proto *tp, bool add, flow_setup_cb_t *cb,
 		cls_flower.rule =
 			flow_rule_alloc(tcf_exts_num_actions(&f->exts));
 		if (!cls_flower.rule) {
-			__fl_put(f);
+			__fl_put(tp, f);
 			return -ENOMEM;
 		}
 
@@ -2293,7 +2300,7 @@ static int fl_reoffload(struct tcf_proto *tp, bool add, flow_setup_cb_t *cb,
 			kfree(cls_flower.rule);
 			if (tc_skip_sw(f->flags)) {
 				NL_SET_ERR_MSG_MOD(extack, "Failed to setup flow action");
-				__fl_put(f);
+				__fl_put(tp, f);
 				return err;
 			}
 			goto next_flow;
@@ -2309,11 +2316,11 @@ static int fl_reoffload(struct tcf_proto *tp, bool add, flow_setup_cb_t *cb,
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

