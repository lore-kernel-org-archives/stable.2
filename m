Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498812DCF6C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784624287; cv=none; b=a8vCcwbk+zu4ZdFI1zvEF2ZmTcV/sLuwQa7+Hw61D4OEK6XfR8002rt5JpQL2xlw/LZIlj0+I5WVQnvflaXi4eZ5XhVdqU1E3HWj+fc8P6RgIMA+7ADGQiS+9fYtPahC0tJxdLywEvFBC9dzgpLEqkY02ExdyozaqTDbyn0DRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784624287; c=relaxed/simple;
	bh=iw+IgWGH6EFAj2zbx3RNbP/fdZ70aClnMHQRR8/ogco=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K+RTOuh0hw9zWi+lnUNWYUU34rc6Y5HgqNilQe3sL9GuofRvaVUMZUGuZ4N6JMrQ45iSjcs8diMfmydgkiHBoVMC0mCpEGHZw7CwblGMI11E81TvmKdVNO1QI8721CCNpYGA4R2RtQtPZGgWwA5prAsabkqeVqZIFSMubM79RsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E55WSGtz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E55WSGtz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF16C1F000E9;
	Tue, 21 Jul 2026 08:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784624286;
	bh=VOc/Dh4Jgr6k1LkuKxkYGzXdsMILj2uQtOwkpS/+NoA=;
	h=Subject:To:Cc:From:Date;
	b=E55WSGtzlWsDOyoqYxYKU1f3yhvAN9ynZwJkAUcCX+n5ay+0aoMio6koVhOnQ/agD
	 pf/WI0XIWB/lMS3INXA6CBarkk0wqFwOgXw+MpJKKuBeiZiNlNGXftAmWwe2Lignik
	 E4c70o8aKL8zjJmrbuZxFYMBsNOT+5cTNjmX0dyc=
Subject: FAILED: patch "[PATCH] net/sched: sch_taprio: Replace direct dequeue call with peek" failed to apply to 5.15-stable tree
To: hexlabsecurity@proton.me,jhs@mojatatu.com,kuba@kernel.org,victor@mojatatu.com,vladimir.oltean@nxp.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 10:57:46 +0200
Message-ID: <2026072146-curable-untreated-02d2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e056e1dfcddca877dd46d704e8ec9860cfc9ec44
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072146-curable-untreated-02d2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

