Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA9F2DCF6C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624276; cv=none; b=kcYPGCHV6Nzh5okWE1T6Nu/dv349qKx/3MXp9RSsQ6/Vng5OX89ck0QFQORTtcLWG7h3X0Z/JzLqGAtt4PniQ4LRhpYATM8smkZZBxB1q11jXoMML9oG9A9U6xujI9pxEgq284RETLSB1k3p1HSz0l9FQBg34U4AoMry0iuEHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624276; c=relaxed/simple;
	bh=75zmsZ15Vo1TyWdnHyZboHrxcM/eNpDW93IOVj9Edms=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QkT9hG/yyPZB2amx0ejvLbxSxjO+PZq4tpAKTRaujLr/OasOR88kF7jzQxIYZg6slasDXidMu51Jxz7aNTUKm3IZbTGreUjFbuRwTV5riJZLVMApMdjOaVNMoCKHN8BtLFTS1Hkc8xu9P+C1aQF0ZQkZLOcBEMoh0+LGZ2so6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dd8xSmsX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dd8xSmsX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9391F000E9;
	Tue, 21 Jul 2026 08:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784624275;
	bh=IbTmeQxlErHz0qI8PKzcpIi00/s00sOgK9zhP8/NPIY=;
	h=Subject:To:Cc:From:Date;
	b=dd8xSmsX+X+foJ9AF+mpq4ckc8FfQZIhaa5opaB/BYEvB9KVKz9KZqWSpuONH/HJe
	 wr1sGmlHD5phHgiUiXby6jbA4SyMwjt036vfzjFavBl+zzNaC5XxVvLmCApxyi3HYQ
	 teIBPOztauQpeW3wuqetq9wK6qH4sv0pusYzPaBY=
Subject: FAILED: patch "[PATCH] net/sched: sch_taprio: Replace direct dequeue call with peek" failed to apply to 6.1-stable tree
To: hexlabsecurity@proton.me,jhs@mojatatu.com,kuba@kernel.org,victor@mojatatu.com,vladimir.oltean@nxp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 10:57:45 +0200
Message-ID: <2026072145-tank-retrain-5dd2@gregkh>
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
git cherry-pick -x e056e1dfcddca877dd46d704e8ec9860cfc9ec44
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072145-tank-retrain-5dd2@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e056e1dfcddca877dd46d704e8ec9860cfc9ec44 Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Thu, 25 Jun 2026 04:51:19 -0500
Subject: [PATCH] net/sched: sch_taprio: Replace direct dequeue call with peek
 and qdisc_dequeue_peeked

When taprio's software path peeks a non-work-conserving child qdisc, the
child stashes the peeked skb in its gso_skb; taprio_dequeue_from_txq()
then takes the packet with a direct child ->dequeue() call, which ignores
that stash, orphans the peeked skb and desyncs the child's qlen/backlog.
With a qfq child this re-enters the child on an emptied list and
dereferences NULL, panicking the kernel from softirq on ordinary egress.

Take the packet through qdisc_dequeue_peeked(), as sch_red and sch_sfb
now do. The helper returns the child's stashed skb first and is a no-op
when there is none, so a work-conserving child is unaffected and the
gated path now consumes the skb whose length was charged to the budget.

Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")
Cc: stable@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://patch.msgid.link/20260625-b4-disp-31bcb279-v1-1-85c40b83c529@proton.me
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 558987d9b977..299234a5f0fe 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -749,7 +749,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 		return NULL;
 
 skip_peek_checks:
-	skb = child->ops->dequeue(child);
+	skb = qdisc_dequeue_peeked(child);
 	if (unlikely(!skb))
 		return NULL;
 

