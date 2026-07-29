Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7AA48D895
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333178; cv=none; b=tHpmgXkadux1S+BDMLSBS5Dla4xD5QEJXHJM9pKkb/7E6LIQG2+O8CzIs7zxFTY8exH0CKnwv05RI00M/JDjBXKijIT04ZP2NKrFOC/faZhoOATbPwM9NYejAO2AU499vhYyYESY5sMK83V4SaDG2leSoB3HkCOFEFxPyogrGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333178; c=relaxed/simple;
	bh=XWyE+4VLcyYADwDVWEBkIfslGgeYewqmXEfBnS4Vntg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I1xENoAdUnIH3zD5FkiiQa/4Z8lqDhCjvAK1a8FDlFLrVVy4XTdLMD4gKaWhGGiEtk9FOit7I9x2hUYm/6qaOJ6/qx3Az3i06vytzBBsbd03LAsjv/Ub/bkQciNNKckx9tNymMWg1ZBFJsF6ezrMpFdGpdRU3mBRLqnpP0j++/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WQK0XH/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WQK0XH/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA871F000E9;
	Wed, 29 Jul 2026 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333169;
	bh=EOrn3vBG4cIHlWesC1rXAWh95ktYD8+kVpoCpiVupbk=;
	h=Subject:To:Cc:From:Date;
	b=WQK0XH/ikaoAx0KKsHNH6prVo9eWaf4lBptxNpFMjy3ci5B4Vp/URW4AoNAR4u/44
	 FzAa9J3XIhvTFK9GCyFitGNtkjgXsXpTp2bvOaUEdJFusmvWFNtvfFXltCY1ovPa50
	 nF+qm7Ln3CSQWCHEIKv4t19a0US+hk3MaGEG+KNc=
Subject: FAILED: patch "[PATCH] net/sched: serialize qdisc_rtab_list against concurrent" failed to apply to 6.1-stable tree
To: qwe.aldo@gmail.com,edumazet@google.com,jhs@mojatatu.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:52:26 +0200
Message-ID: <2026072926-deflected-unvaried-0a4a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f43ee0c0730d6191629b5ee1ceae27b1ebfdc047
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072926-deflected-unvaried-0a4a@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f43ee0c0730d6191629b5ee1ceae27b1ebfdc047 Mon Sep 17 00:00:00 2001
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Date: Wed, 15 Jul 2026 08:41:14 -0300
Subject: [PATCH] net/sched: serialize qdisc_rtab_list against concurrent
 get/put

qdisc_get_rtab() and qdisc_put_rtab() mutate the process-global singly
linked list qdisc_rtab_list and a plain non-atomic 'int refcnt' with no
lock. This was only safe because every caller historically held the RTNL
mutex, which serialized all rate-table lookups, inserts and frees.

That invariant no longer holds. cls_flower sets
TCF_PROTO_OPS_DOIT_UNLOCKED, so tc_new_tfilter() keeps rtnl_held == false
for it and sets TCA_ACT_FLAGS_NO_RTNL. That flag propagates through
tcf_exts_validate_ex() -> tcf_action_init() -> tcf_action_init_1() ->
tcf_police_init(), which calls qdisc_get_rtab()/qdisc_put_rtab() with the
RTNL mutex NOT held. Two RTM_NEWTFILTER requests on different CPUs, each
adding a flower filter with a police action carrying the same rate, then
race on qdisc_rtab_list and on the non-atomic refcnt, leading to a
use-after-free / double-free of the kmalloc-2k struct qdisc_rate_table.
qdisc_rtab_list is a single global (not per-netns), so the corrupted
object is shared system-wide.

  BUG: KASAN: slab-use-after-free in qdisc_put_rtab+0x12f/0x160
   qdisc_put_rtab+0x12f/0x160
   tcf_police_init+0xda9/0x1590
   tcf_action_init_1+0x460/0x6b0
   tcf_action_init+0x439/0xa40
   tcf_exts_validate_ex+0x42d/0x550
   fl_change+0xddd/0x7da0
   tc_new_tfilter+0xaa7/0x2420
   rtnetlink_rcv_msg+0x95e/0xe90
  which belongs to the cache kmalloc-2k of size 2048

Protect qdisc_rtab_list and the refcount with a dedicated spinlock. The
(sleeping, GFP_KERNEL) allocation in qdisc_get_rtab() is performed before
taking the lock; if a concurrent inserter added an identical table in the
meantime the freshly allocated one is freed under the lock, so no
duplicate is leaked. qdisc_put_rtab() now decrements the refcount and
unlinks under the same lock.

Fixes: 470502de5bdb ("net: sched: unlock rules update API")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: stable@vger.kernel.org
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20260715114114.446841-1-qwe.aldo@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 8a3236456db4..668bcd60d183 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -415,12 +415,13 @@ static __u8 __detect_linklayer(struct tc_ratespec *r, __u32 *rtab)
 }
 
 static struct qdisc_rate_table *qdisc_rtab_list;
+static DEFINE_SPINLOCK(qdisc_rtab_lock);
 
 struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 					struct nlattr *tab,
 					struct netlink_ext_ack *extack)
 {
-	struct qdisc_rate_table *rtab;
+	struct qdisc_rate_table *rtab, *new_rtab;
 
 	if (tab == NULL || r->rate == 0 ||
 	    r->cell_log == 0 || r->cell_log >= 32 ||
@@ -429,15 +430,20 @@ struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 		return NULL;
 	}
 
+	new_rtab = kmalloc_obj(*new_rtab);
+
+	spin_lock(&qdisc_rtab_lock);
 	for (rtab = qdisc_rtab_list; rtab; rtab = rtab->next) {
 		if (!memcmp(&rtab->rate, r, sizeof(struct tc_ratespec)) &&
 		    !memcmp(&rtab->data, nla_data(tab), TC_RTAB_SIZE)) {
 			rtab->refcnt++;
+			spin_unlock(&qdisc_rtab_lock);
+			kfree(new_rtab);
 			return rtab;
 		}
 	}
 
-	rtab = kmalloc_obj(*rtab);
+	rtab = new_rtab;
 	if (rtab) {
 		rtab->rate = *r;
 		rtab->refcnt = 1;
@@ -449,6 +455,7 @@ struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 	} else {
 		NL_SET_ERR_MSG(extack, "Failed to allocate new qdisc rate table");
 	}
+	spin_unlock(&qdisc_rtab_lock);
 	return rtab;
 }
 EXPORT_SYMBOL(qdisc_get_rtab);
@@ -457,18 +464,25 @@ void qdisc_put_rtab(struct qdisc_rate_table *tab)
 {
 	struct qdisc_rate_table *rtab, **rtabp;
 
-	if (!tab || --tab->refcnt)
+	if (!tab)
 		return;
 
+	spin_lock(&qdisc_rtab_lock);
+	if (--tab->refcnt) {
+		spin_unlock(&qdisc_rtab_lock);
+		return;
+	}
+
 	for (rtabp = &qdisc_rtab_list;
 	     (rtab = *rtabp) != NULL;
 	     rtabp = &rtab->next) {
 		if (rtab == tab) {
 			*rtabp = rtab->next;
-			kfree(rtab);
-			return;
+			break;
 		}
 	}
+	spin_unlock(&qdisc_rtab_lock);
+	kfree(tab);
 }
 EXPORT_SYMBOL(qdisc_put_rtab);
 

