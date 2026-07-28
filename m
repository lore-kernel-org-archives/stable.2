Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98DA3B992C
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277063; cv=none; b=KWUbDN5Bx5hQzKfF0jxuIpXUnHCxS2QORbMUKPT6fzaNuBNRau87WsIMFFSLfQU9Mv0UvD7wQXwfYLDCfeqtvdjr7VRZzN15q2OFxzg3mnKu/I6POG1cMgG7V0lVBSOWKvomh97V6km4EE4x1y0/ij3+Ic0czPzBPkQ5d1zZDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277063; c=relaxed/simple;
	bh=lIE0eak4UMyQWfbDefr95FH/rBKiDyyiSVwL3upfkPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArCRkGCK8+NDgWF8QlcrhKmnfd2NvlMocrIres1c1Nrq1zlx66PJD9JXoFFmOwL8NATaZLryVvygHLhAfPAzOMTjEMQSZqG/ZDpVw5zuFW1G+A9mTH9PgCDE8USml+Z/+atpvYg2x+uoc0Yzmf1zlkENibQoaO5+M93QbgFoDIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBmjNX9h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBmjNX9h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159211F00A3D;
	Tue, 28 Jul 2026 22:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277061;
	bh=/PvClSVNwBh1HwYnVk5Ssu+1qEkAv32ouYxM2Dhj5H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IBmjNX9h+SRID1jRiHKhLj0cVcrzWFUQZWMY3oQcJdPHf+um0a0ImbTHvJ6f8Xfny
	 mFzePHqV9ZTsMXxh9s9Op7AZY3yxTNK4Pp1vHVPA1Eo/FZfWxe9qF2GnbYhAGuQ9Yd
	 OpcbVnMk33txD9FZT0piXa8bJ+RH3h33hYsjmfvgcBMtqw6IoSyldPWGrOG2PSm6ot
	 U6fMmYYzFu02xgk6O1GFHAsHtBuTtRFb0Zywi10RMQgf4g1G5KLBpC2XqRZGWvul+H
	 IEXfZaACh2zP/JiwtyUoPE5lIHKjwZFYUcH3D3jodSkPAw8wpLkACgbdMwZVYwzSPc
	 pb5iaB4f5q1Dw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] net/sched: sch_taprio: Replace direct dequeue call with peek and qdisc_dequeue_peeked
Date: Tue, 28 Jul 2026 18:17:38 -0400
Message-ID: <20260728221738.745743-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728221738.745743-1-sashal@kernel.org>
References: <2026072146-reclusive-rocky-a67e@gregkh>
 <20260728221738.745743-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_taprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 237e4a16a0e505..d0b25ab5ff9aa1 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -588,7 +588,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 		return NULL;
 
 skip_peek_checks:
-	skb = child->ops->dequeue(child);
+	skb = qdisc_dequeue_peeked(child);
 	if (unlikely(!skb))
 		return NULL;
 
-- 
2.53.0

