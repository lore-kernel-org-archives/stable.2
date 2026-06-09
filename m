Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8395407CE4
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006411; cv=none; b=ONojQzHzL/XS1SUUEQ0yTHlix85rSgTJ+aSS03MtfpDPCfvj36XDl+GPR8ksVMjh9QpwieGNbFJHNbDxUgweMSIeIx/7h7NmuRRj40E05/JxtlRaL8cj0kHJPrpp7oJpIpGroAHXLTd1PQL4NITsFC+biFrmdhL26FMPHGLaf0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006411; c=relaxed/simple;
	bh=Vomw9OlHRuAZaMfduu22dTOFBZHcQjMkmss46Pn+7h4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rGu0BidWjUdO3HXK6Xg8qzcO5+RfnUWs5ZkrJcUY/D11GFrQ2L984z0emCNF9TTlNBxuTn350XkO1JdWoa5y2UdR4Rg3W84yCD2kfY0OZDEfYPijTCw+yx4ek+qEqxIVJEg2R9A7jpKrXPw+gJcAnyP3T4Y0rRLmtZ+r9Y8DhL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AJMK5Aio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AJMK5Aio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4751F00893;
	Tue,  9 Jun 2026 12:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781006407;
	bh=iOYRKiVJiXZawKpsMQpe8ydzQLLweaQ5wvxkQ4zEwmg=;
	h=Subject:To:Cc:From:Date;
	b=AJMK5Aio8wpRsvvxMGrSo8ZHo9rF9dwvuJDstTUQeIuWm62sWxjSfZzKyZ6zpElnw
	 Lk8/K1Pf9eaSgHX7l7KWSs1r5Wp2k8JUI/qNQFJRhVAbws1cxOBzALJPKeiByAz6Fp
	 upqad6COVmD3Q+SOz83fALXM1koDzgMj45mHki+c=
Subject: FAILED: patch "[PATCH] ipv6: mcast: Fix use-after-free when processing MLD queries" failed to apply to 5.10-stable tree
To: idosch@nvidia.com,dahern@nvidia.com,edumazet@google.com,jiayuan.chen@linux.dev,kuba@kernel.org,leo@depthfirst.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 09 Jun 2026 13:59:07 +0200
Message-ID: <2026060907-blurry-monetary-1fa3@gregkh>
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
git cherry-pick -x 791c91dc7a9dfb2457d5e29b8216a6484b9c4b40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060907-blurry-monetary-1fa3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 791c91dc7a9dfb2457d5e29b8216a6484b9c4b40 Mon Sep 17 00:00:00 2001
From: Ido Schimmel <idosch@nvidia.com>
Date: Wed, 3 Jun 2026 13:18:11 +0300
Subject: [PATCH] ipv6: mcast: Fix use-after-free when processing MLD queries

When processing an MLD query, a pointer to the multicast group address
is retrieved when initially parsing the packet. This pointer is later
dereferenced without being reloaded despite the fact that the skb header
might have been reallocated following the pskb_may_pull() calls, leading
to a use-after-free [1].

Fix by copying the multicast group address when the packet is initially
parsed.

[1]
BUG: KASAN: slab-use-after-free in __mld_query_work (net/ipv6/mcast.c:1512)
Read of size 8 at addr ffff8881154b8e90 by task kworker/4:1/118

Workqueue: mld mld_query_work
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
print_address_description.constprop.0 (mm/kasan/report.c:378)
print_report (mm/kasan/report.c:482)
kasan_report (mm/kasan/report.c:595)
__mld_query_work (net/ipv6/mcast.c:1512)
mld_query_work (net/ipv6/mcast.c:1563)
process_one_work (kernel/workqueue.c:3314)
worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
</TASK>

[...]

Freed by task 118:
kasan_save_stack (mm/kasan/common.c:57)
kasan_save_track (mm/kasan/common.c:78)
kasan_save_free_info (mm/kasan/generic.c:584)
__kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
kfree (./include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
pskb_expand_head (net/core/skbuff.c:2335)
__pskb_pull_tail (net/core/skbuff.c:2878 (discriminator 4))
__mld_query_work (net/ipv6/mcast.c:1495 (discriminator 1))
mld_query_work (net/ipv6/mcast.c:1563)
process_one_work (kernel/workqueue.c:3314)
worker_thread (kernel/workqueue.c:3397 kernel/workqueue.c:3478)
kthread (kernel/kthread.c:436)
ret_from_fork (arch/x86/kernel/process.c:158)
ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

Fixes: 97300b5fdfe2 ("[MCAST] IPv6: Check packet size when process Multicast")
Reported-by: Leo Lin <leo@depthfirst.com>
Reviewed-by: David Ahern <dahern@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://patch.msgid.link/20260603101811.612594-1-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 3330adcf26db..d9b855d5191b 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1424,9 +1424,9 @@ void igmp6_event_query(struct sk_buff *skb)
 static void __mld_query_work(struct sk_buff *skb)
 {
 	struct mld2_query *mlh2 = NULL;
-	const struct in6_addr *group;
 	unsigned long max_delay;
 	struct inet6_dev *idev;
+	struct in6_addr group;
 	struct ifmcaddr6 *ma;
 	struct mld_msg *mld;
 	int group_type;
@@ -1458,8 +1458,8 @@ static void __mld_query_work(struct sk_buff *skb)
 		goto kfree_skb;
 
 	mld = (struct mld_msg *)icmp6_hdr(skb);
-	group = &mld->mld_mca;
-	group_type = ipv6_addr_type(group);
+	group = mld->mld_mca;
+	group_type = ipv6_addr_type(&group);
 
 	if (group_type != IPV6_ADDR_ANY &&
 	    !(group_type&IPV6_ADDR_MULTICAST))
@@ -1509,7 +1509,7 @@ static void __mld_query_work(struct sk_buff *skb)
 		}
 	} else {
 		for_each_mc_mclock(idev, ma) {
-			if (!ipv6_addr_equal(group, &ma->mca_addr))
+			if (!ipv6_addr_equal(&group, &ma->mca_addr))
 				continue;
 			if (ma->mca_flags & MAF_TIMER_RUNNING) {
 				/* gsquery <- gsquery && mark */

