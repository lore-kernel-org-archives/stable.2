Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720856;
	b=z35FuPFKpEf7zh/HMRTzsZTd+JzrFGBG98Cgik7GiyTDKiaZl1xTNm8d7/6NwYobi+BS
	 SJIpV/2Ac7FW0IyBFWNl19vQOqoLUN1iRsIcUer5EmOI3Fr670XwxC62VaduroRp4p93b
	 795OkgtX7X1cyzRR+/ygEOMNG7DpzjOJE1MC9Z8X+SsyNxFsd6Wc6X+5muobxHufk5Nbl
	 Se+s/l8OQVICI62dzxAQzy1cxYX/9Y3meowzJRq1ViaQ/TG2MVCSzQFDI5HBkCl6/RME2
	 fFekzA67sa2iWxZPSUmyb+OJLyhrTic4GhsiPo4YjJ2sK0TfDh4PxIjRH4GHYUjr94Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720856;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gBZu26fG293hKiFGORRUpZ2tXpXZ+J1+ce8OuNiTKGY=;
	b=rBfawnQPcP3B7Tq1yy+8gi6n/c1ks8ITTcG5orOronj17Vzu0WEtXVUOX3+g+npkvSAt
	 6v+BRbSritmJQ99q44TfqT1LTuuqMVxCVqoiwPmanOfRA1IfjnQmO/52BSa0eK3QIECGg
	 kDsnY/m3hG7drbtDbxvZEUKrSfToLEkD+u2jbaXiToMKmzmmgTgWiUzlLwadHI3YTOEvD
	 rR+qCoNlKyjw84qyTlv9Ba4XDaQ7GFrUtzMdrtK9l/hy1wsObP+nV6EZ3UVOQdYWs0jfr
	 GgDFU0u+RgCocnr4JMUUCDMmiwDqEqYzzOvQgeq0JhKOr+DaavvtkKpergRrCF/R0YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZWWuTtx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC8A606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZWWuTtx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDAF1F000C1;
	Tue,  3 Nov 2026 15:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793720856;
	bh=gBZu26fG293hKiFGORRUpZ2tXpXZ+J1+ce8OuNiTKGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HZWWuTtxHIgiyOM0qzs3e5BsjrbJ2YSFW5X1BuNZiD5NvF43uNMF3lpMGEHunTaeE
	 E8losfKgZ2roKUKIArN3FPxo6cvnzZxELIhoauKEe6kDzMl+Kygem9piwtpCl2qp4m
	 f9dI8Y5uJwRYqrSfXmfjdAMK4pv2sGNgYvyOAPomt7ofAFh1tlAA4pM7yYOGuj6/rb
	 rb7LAfZmSkUGbNEnV3T/MRtAv+PStDyj52n4ig6qRsiph3nNPioSPGtNtN+zBSr8WJ
	 d5CrdDe6QNhQIYqLcptLTMXoJN/P+URwWZNs5URMwC0IKQdO802QG1L1f1hRY5Uo/0
	 5/4r4R9yQRRfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuhang Zheng <z1652074432@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Yucheng Lu <kanolyc@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net/sched: cls_flower: avoid stale mask references after delete
Date: Tue,  3 Nov 2026 10:47:34 -0500
Message-ID: <20261103154704.243889-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110338-reassign-lapdog-d1ae@gregkh>
References: <2026110338-reassign-lapdog-d1ae@gregkh>
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
[ sashal: adapted error cleanup to use the existing errout label instead of unbind_filter ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_flower.c | 49 ++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 01d5903596aa0..2d6087f52340b 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -498,15 +498,22 @@ static void fl_hw_update_stats(struct tcf_proto *tp, struct cls_fl_filter *f,
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
@@ -543,11 +550,10 @@ static int __fl_delete(struct tcf_proto *tp, struct cls_fl_filter *f,
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
@@ -588,7 +594,7 @@ static void fl_put(struct tcf_proto *tp, void *arg)
 {
 	struct cls_fl_filter *f = arg;
 
-	__fl_put(f);
+	__fl_put(tp, f);
 }
 
 static void *fl_get(struct tcf_proto *tp, u32 handle)
@@ -2042,12 +2048,14 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
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
@@ -2099,7 +2107,6 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 
 		spin_unlock(&tp->lock);
 
-		fl_mask_put(head, fold->mask);
 		if (!tc_skip_hw(fold->flags))
 			fl_hw_destroy_filter(tp, fold, rtnl_held, NULL);
 		tcf_unbind_filter(tp, &fold->res);
@@ -2107,7 +2114,7 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 		 * after this.
 		 */
 		refcount_dec(&fold->refcnt);
-		__fl_put(fold);
+		__fl_put(tp, fold);
 	} else {
 		if (handle) {
 			/* user specifies a handle and it doesn't exist */
@@ -2152,17 +2159,15 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
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
 
@@ -2175,8 +2180,10 @@ static int fl_delete(struct tcf_proto *tp, void *arg, bool *last,
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
@@ -2198,12 +2205,12 @@ static void fl_walk(struct tcf_proto *tp, struct tcf_walker *arg,
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
@@ -2254,7 +2261,7 @@ static int fl_reoffload(struct tcf_proto *tp, bool add, flow_setup_cb_t *cb,
 		cls_flower.rule =
 			flow_rule_alloc(tcf_exts_num_actions(&f->exts));
 		if (!cls_flower.rule) {
-			__fl_put(f);
+			__fl_put(tp, f);
 			return -ENOMEM;
 		}
 
@@ -2272,7 +2279,7 @@ static int fl_reoffload(struct tcf_proto *tp, bool add, flow_setup_cb_t *cb,
 			kfree(cls_flower.rule);
 			if (tc_skip_sw(f->flags)) {
 				NL_SET_ERR_MSG_MOD(extack, "Failed to setup flow action");
-				__fl_put(f);
+				__fl_put(tp, f);
 				return err;
 			}
 			goto next_flow;
@@ -2288,11 +2295,11 @@ static int fl_reoffload(struct tcf_proto *tp, bool add, flow_setup_cb_t *cb,
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

