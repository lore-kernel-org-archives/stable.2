Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA85327BEC
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785267342; cv=none; b=V8Rz4cBZ8GY6zlSJO3IpIxA4iqOB04hq3xvbFwpOxAcoFWNEZVqqruI6VeDyXrFfdEvDhfGgB52SkIAe4RUw/XEPkCgaR0szRu8J1I3c9Wd7CQ6vRIZ7LvymetXxPIQDe6rA9Rp9m5591jm5DYRtFl9dVSxustReB9BCxM11tBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785267342; c=relaxed/simple;
	bh=huWQCjwH7ud7alEZkZYrDjp6tb4bTY2V/PVs8K0rXC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oi8P7MWm/6EV0FecyYeTeVlQdDsnBrXDqE4WA58uLNrNYYCOCe58ovQayr9Z/HZNicVVkWA+d5rJsB9YoceqhhtCZrdYp55TqcDt/uOc7+imKZZY6HsGhPcVTCahaQFnAjCC41I34TL7kAd8LgEhrb+Jr6/VDif0WCkCLn33bTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpvJ2pza; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpvJ2pza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B451F000E9;
	Tue, 28 Jul 2026 19:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785267340;
	bh=il47b62GkFLJfwbHScmQTKQcAJLUKzbQgu2UueBRY2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mpvJ2pzaM7/J5GXRX/BhDEDp/OHJSGixsb5Yz05sAZy5Hah554AhLVhRAAgjc8XKP
	 OKf9jSpxTVk7ujazzVG7lZN5q6NJEhQw1qR8o6Q14pUabZEOAP2gJbz8vfUlrW8qlI
	 CiIvSXZM2A5ITE/f7nSWiMfkDZppz8/xcic8ERp4nz5wFTfsItyDmMWOIFtjqHtTU4
	 ieJtGnD6IHWgJb1MM9OYvtDZmHyP2B890QHN4uSXf05yEMu1avdPRoPp5iiUbfIGIK
	 ewvYAs08UH5yorAo1dbPb+wiKWkF/0OS/AmAJjDmEFbdcLlDjsKPErKOoOytaqc0eS
	 27Xw3gzs/EJ0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net/sched: sch_taprio: Replace direct dequeue call with peek and qdisc_dequeue_peeked
Date: Tue, 28 Jul 2026 15:35:38 -0400
Message-ID: <20260728193538.541335-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072146-reclusive-rocky-a67e@gregkh>
References: <2026072146-reclusive-rocky-a67e@gregkh>
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
index 50f430280337da..298106e7bcf644 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -560,7 +560,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 		return NULL;
 
 	if (TXTIME_ASSIST_IS_ENABLED(q->flags)) {
-		skb = child->ops->dequeue(child);
+		skb = qdisc_dequeue_peeked(child);
 		if (!skb)
 			return NULL;
 		goto skb_found;
@@ -591,7 +591,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 	    atomic_sub_return(len, &entry->budget) < 0)
 		return NULL;
 
-	skb = child->ops->dequeue(child);
+	skb = qdisc_dequeue_peeked(child);
 	if (unlikely(!skb))
 		return NULL;
 
-- 
2.53.0

