Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81504373BE6
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191134; cv=none; b=YqqUgGCQocVe2S/vxfe0h+p9DYmuoAe1GjuvgFXWirxjcUnlsU6y22biTjZZyxHgVeoPdIlVIyEIJ/I12arFOJwcZgC65Gxgd+VqpxnFGfZn3PlY5uvFgetGKR7TyNTrwVdR9JJ1oTKol7oSbe2bVORLFGA1zcoWW4kmLmTF1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191134; c=relaxed/simple;
	bh=rHwLWonz+1injjqxTfDFfwRSMrefk4mN8dVu9gpBkas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYjgCkcnuiqv38DGwrmYMTeNbOggtz4czf8dvvm9qo/2q9swe+r0j7xwcWu7SyQT4SrcebGWk6TT/OvFpL8kvgsDUfvsReM3DCwuEJD4BdT1EAVT2al+bxg52KpKy6PtB3ShtmDKhCvcHQOCHcS9CgUhe/Zl8CVZT0VKuwavG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPeLDBWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPeLDBWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDCC1F000E9;
	Sat,  8 Aug 2026 12:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786191133;
	bh=mT3yiKAy2sDqKW4xH7qmpfZB6nOPFbZT1iqW5zCt1SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RPeLDBWGc6vykuTFPphgbGEFXgc7+n9NZdBp2LKPmsEZat/Fq5JMDvQUF8R5Zfyps
	 gtjnd+ySvqk1ZgPvviW4ovMvyYUv6+CHQlKC2qbJBoatceoCtweI4FW7dMdqMzTuX5
	 u4RCzyYqmF65PzbKsQ6Hg7luSowqsTqSvOopG3pVM9o2VTGjkAzWJw+XII2xnSdFyX
	 EkmGMymJd1L8+bqL/vDkJWNlnV9JjDFPh8gAVhB+nnDNucE5HJZbuCtCV0RRXkF388
	 Q5EFqJkqIBqBilPokeKoqIH95KLwqdExBGtKawBpXXXsBFMhYh41Wtkup8JZ8Yk7Aq
	 cB80Nbf0nzzHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net/sched: serialize qdisc_rtab_list against concurrent get/put
Date: Sat,  8 Aug 2026 08:12:10 -0400
Message-ID: <20260808121210.222033-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072925-democracy-struggle-c5e9@gregkh>
References: <2026072925-democracy-struggle-c5e9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

[ Upstream commit f43ee0c0730d6191629b5ee1ceae27b1ebfdc047 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_api.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 709d851d0b1e8..cc979ecc6b78b 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -413,12 +413,13 @@ static __u8 __detect_linklayer(struct tc_ratespec *r, __u32 *rtab)
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
@@ -427,15 +428,20 @@ struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 		return NULL;
 	}
 
+	new_rtab = kmalloc_obj(*new_rtab);
+
+	spin_lock(&qdisc_rtab_lock);
 	for (rtab = qdisc_rtab_list; rtab; rtab = rtab->next) {
 		if (!memcmp(&rtab->rate, r, sizeof(struct tc_ratespec)) &&
 		    !memcmp(&rtab->data, nla_data(tab), 1024)) {
 			rtab->refcnt++;
+			spin_unlock(&qdisc_rtab_lock);
+			kfree(new_rtab);
 			return rtab;
 		}
 	}
 
-	rtab = kmalloc(sizeof(*rtab), GFP_KERNEL);
+	rtab = new_rtab;
 	if (rtab) {
 		rtab->rate = *r;
 		rtab->refcnt = 1;
@@ -447,6 +453,7 @@ struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
 	} else {
 		NL_SET_ERR_MSG(extack, "Failed to allocate new qdisc rate table");
 	}
+	spin_unlock(&qdisc_rtab_lock);
 	return rtab;
 }
 EXPORT_SYMBOL(qdisc_get_rtab);
@@ -455,18 +462,25 @@ void qdisc_put_rtab(struct qdisc_rate_table *tab)
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
 
-- 
2.53.0

