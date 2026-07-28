Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F13833D4F8
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262036; cv=none; b=oGj9N5xPM9h1FEr+kO1GNt9XHpy+cooKm1WHNrnF1UBna+LZqLLGcKx0gCpA4WeDiX17ksgZrXsXoJV8Jq4DuUE86unS3GUqtK1remxhlxvcmG2q/Z8PdJcZja0f6bUWeoFeEjNGf6lnzKR5U25yoIVP+TcXVCiSSU3U0q7YexI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262036; c=relaxed/simple;
	bh=tevHsckvkNw962WbEXR009cJzTdy8ZvSU5+IxodLd9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utOun27O0kQDrwwzsJg3hCeEskgGqAPoavPaUEYSdE+qsnr5D47ka5TPCAJYgUHSfye0gG8NkbSXGYJzPlawBPYJmeLHC72noqlE7sGNf0cheD73ka/WpZL7AQJayAMuNm+WFUqZ9UPgCoLv+Kvw+uxd94ZnmPAw0cCYO7L8Yxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9P9TZLs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9P9TZLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AAE1F000E9;
	Tue, 28 Jul 2026 18:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785262034;
	bh=0qtUr+1RGAITd54o0ZsrzCgc8X4p4HcX9Tcu/+8wsZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k9P9TZLsThRUnBb+a5d8EcRga4hlQklgRyadRQd3PD1liWaot2jB/TZNKEVvGhcMD
	 UZo+RprDplKSFnBG1zp4y9htR45fu57D82c+KszUt+9iQKH9N49LFKDKVxYww/xzxJ
	 Kyx5Y34Y33ZS3Sb9wb/eibTWayqWIzJKZAqtA9hoiC6FHWMukKG32WXBiGXpC5D7Ru
	 Wj18PjRKeUZJg7zJC6hi+FF+Uc/jLyHHxUS/84ixakydnEx4kBDMLqZdIvypN/llT/
	 aJXSxwRSoBRaXHSCpTBPMTu3CLuBzL4AgY80nMbwSqgGBH4fx2VmKuiT7cTUydLHKf
	 2KFZchLNk6t8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net/sched: sch_taprio: Replace direct dequeue call with peek and qdisc_dequeue_peeked
Date: Tue, 28 Jul 2026 14:07:11 -0400
Message-ID: <20260728180711.291113-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072145-tank-retrain-5dd2@gregkh>
References: <2026072145-tank-retrain-5dd2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit e056e1dfcddca877dd46d704e8ec9860cfc9ec44 ]

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
[ applied the peek/dequeue conversion to both `child->ops->dequeue(child)` call sites, since 6.1 lacks the upstream cleanup that merged them into one ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_taprio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 8da723f054f564..ea9c7aaf0885c4 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -568,7 +568,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 		return NULL;
 
 	if (TXTIME_ASSIST_IS_ENABLED(q->flags)) {
-		skb = child->ops->dequeue(child);
+		skb = qdisc_dequeue_peeked(child);
 		if (!skb)
 			return NULL;
 		goto skb_found;
@@ -599,7 +599,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 	    atomic_sub_return(len, &entry->budget) < 0)
 		return NULL;
 
-	skb = child->ops->dequeue(child);
+	skb = qdisc_dequeue_peeked(child);
 	if (unlikely(!skb))
 		return NULL;
 
-- 
2.53.0

