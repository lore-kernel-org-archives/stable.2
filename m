Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700589;
	b=2MCV1uiIuUimXzd9qdG1md/+fEZcFVFDBPyoW6GwCX+zbXxPO3n3sUYO2z5hSRxSG59s
	 F6r/osWGmyO25foboefgGmX6sgDHcGp36lGEmtAscim4Tb4z7Gl3vkUrpER6pnmvKDxzw
	 PT/2e/nno+P8e8S+X4ZE322JVnl6HEteG1e86N/l9NBvs5XtCfHj8AX3DVmXLBGIJpk6E
	 A7t9DOd+m6h4yzVpuRnBMGrbBIKTOqw7PEmunXPJbFiIiPADeoCdUK1SF+p3RvoF5BwVc
	 2bWFu/xm/2qLfTysiTp0zuVtcIFRenkG8iDqlFeTqJtmDkg+/uhb4EhPSsWzrRirzSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700589;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fR7KahIHeMz/udWde6/4QZIugPd+/1MY0X6xorzoLUU=;
	b=2zMcO88a0cFifmtsAAxoagpnTVe4BFvGHlL3cgv02IUkJM7wr5xgqcE8Mf9R+3WHDmCa
	 Xukkmsst98VRK+pqFP8vTfxvLKN1HpSyebTAddO/g7DPA4Dk4f47gDVDXkyqSw5fFEGVB
	 1WYlWxPhM/DOt5HIxt2dgsum95bsG91BykQgKThl7ADSrWjwf8Gx0YbdJBX545bBpXS5P
	 5XZ/2ZKopPKMv4EYLPcNjff00Em52ptvffE87azCqTYr8hPyKYDPpPgdcwYnhiehIrzTu
	 rNciiKo+jl5mlL9GqqIGOv6EmI31EQciQyHxKnJesVjDBvQmStY57KmHDreBAEhsH5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CsIUeM5x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC7606A828
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CsIUeM5x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672731F000C1;
	Tue,  3 Nov 2026 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700588;
	bh=fR7KahIHeMz/udWde6/4QZIugPd+/1MY0X6xorzoLUU=;
	h=Subject:To:Cc:From:Date;
	b=CsIUeM5xWMEtKBbfuouaXH9rO++MSBP35sLno2552tarLPKRaOSv/coJLfGWYsrXa
	 wdfP+RUWGGn2+DEOVzlCKylibCW4+WF6/VQaxagVW4Y95UuCQtCsmJUmZORADkIYuK
	 mErGmzHT2a4PGT/A+Ud7vXSg5puacOjxTPKvyUzY=
Subject: FAILED: patch "[PATCH] net/sched: cls_flower: avoid stale mask references after" failed to apply to 5.10-stable tree
To: z1652074432@gmail.com,bird@lzu.edu.cn,kanolyc@gmail.com,kuba@kernel.org,n05ec@lzu.edu.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:09:38 +0100
Message-ID: <2026110338-reassign-lapdog-d1ae@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 58f7989da6e715ce834ac861b7ba6ae9f9bdb098
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110338-reassign-lapdog-d1ae@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 58f7989da6e715ce834ac861b7ba6ae9f9bdb098 Mon Sep 17 00:00:00 2001
From: Yuhang Zheng <z1652074432@gmail.com>
Date: Mon, 12 Oct 2026 09:07:19 +0800
Subject: [PATCH] net/sched: cls_flower: avoid stale mask references after
 delete

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

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 1cefea571efd..92a7f2d6efc0 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -518,15 +518,22 @@ static void fl_hw_update_stats(struct tcf_proto *tp, struct cls_fl_filter *f,
 	tcf_exts_hw_stats_update(&f->exts, &cls_flower.stats, cls_flower.use_act_stats);
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
@@ -572,11 +579,10 @@ static int __fl_delete(struct tcf_proto *tp, struct cls_fl_filter *f,
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
@@ -617,7 +623,7 @@ static void fl_put(struct tcf_proto *tp, void *arg)
 {
 	struct cls_fl_filter *f = arg;
 
-	__fl_put(f);
+	__fl_put(tp, f);
 }
 
 static void *fl_get(struct tcf_proto *tp, u32 handle)
@@ -2488,12 +2494,14 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	}
 
 	err = fl_check_assign_mask(head, fnew, fold, mask);
-	if (err)
+	if (err) {
+		fnew->mask = NULL;
 		goto unbind_filter;
+	}
 
 	err = fl_ht_insert_unique(fnew, fold, &in_ht);
 	if (err)
-		goto errout_mask;
+		goto unbind_filter;
 
 	if (!tc_skip_hw(fnew->flags)) {
 		err = fl_hw_replace_filter(tp, fnew, rtnl_held, extack);
@@ -2547,7 +2555,6 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 
 		spin_unlock(&tp->lock);
 
-		fl_mask_put(head, fold->mask);
 		if (!tc_skip_hw(fold->flags))
 			fl_hw_destroy_filter(tp, fold, rtnl_held, NULL);
 		tcf_unbind_filter(tp, &fold->res);
@@ -2555,7 +2562,7 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 		 * after this.
 		 */
 		refcount_dec(&fold->refcnt);
-		__fl_put(fold);
+		__fl_put(tp, fold);
 	} else {
 		idr_replace(&head->handle_idr, fnew, fnew->handle);
 
@@ -2580,9 +2587,6 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	if (in_ht)
 		rhashtable_remove_fast(&fnew->mask->ht, &fnew->ht_node,
 				       fnew->mask->filter_ht_params);
-errout_mask:
-	fl_mask_put(head, fnew->mask);
-
 unbind_filter:
 	if (bound_to_filter) {
 		if (flags & TCA_ACT_FLAGS_NO_RTNL)
@@ -2598,14 +2602,14 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 		idr_remove(&head->handle_idr, fnew->handle);
 		spin_unlock(&tp->lock);
 	}
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
 
@@ -2618,8 +2622,10 @@ static int fl_delete(struct tcf_proto *tp, void *arg, bool *last,
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
@@ -2641,12 +2647,12 @@ static void fl_walk(struct tcf_proto *tp, struct tcf_walker *arg,
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
@@ -2697,7 +2703,7 @@ static int fl_reoffload(struct tcf_proto *tp, bool add, flow_setup_cb_t *cb,
 		cls_flower.rule =
 			flow_rule_alloc(tcf_exts_num_actions(&f->exts));
 		if (!cls_flower.rule) {
-			__fl_put(f);
+			__fl_put(tp, f);
 			return -ENOMEM;
 		}
 
@@ -2715,7 +2721,7 @@ static int fl_reoffload(struct tcf_proto *tp, bool add, flow_setup_cb_t *cb,
 		if (err) {
 			kfree(cls_flower.rule);
 			if (tc_skip_sw(f->flags)) {
-				__fl_put(f);
+				__fl_put(tp, f);
 				return err;
 			}
 			goto next_flow;
@@ -2731,11 +2737,11 @@ static int fl_reoffload(struct tcf_proto *tp, bool add, flow_setup_cb_t *cb,
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

