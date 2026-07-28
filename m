Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC33B442B
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262003; cv=none; b=E/zFb4YNI7z5Jp7B3UdwiAgso7b8aP10RWBEJgz0eWNSE4/WSdEZzKU5O4rNyxrrUkKHuCszgR4pKcnaw6V4ENTAHS73PWtqqns/Jsf+JGBujpU71tCXE/CMK28bevlDxN6CNq9FK5ITDY8dRsoyDMj7kVM9bNPPngBN2gt775s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262003; c=relaxed/simple;
	bh=D+ZnbpKUhAABnCbB2n826RqvdWKSyGulFPDq+Oeu62s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8tPehbIbnQGwTeESBDbdKQvlEHkvoRQQeVGXWJPq0cAfZQ2FapU8wRle9k5E9hccQcrL5XgDu7gDrfvJouQ/zVswo4G2oYipNmOBOZvCe/8YrBQ9wJ5eI65cGM5iDnLdT1mwDR9S+vcQYNQBEKkGUWjDEYb5w9klBB5U/NWyrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc+GqvYA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc+GqvYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5B01F00A3A;
	Tue, 28 Jul 2026 18:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785261998;
	bh=uxHhATtVgG2+ofiLqEF5McmvqZY5A+mF8bZ479TtWEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qc+GqvYAGMtp6IPWk3tORi/pXqcPwv1rqiG58ASeX7SSbhz0p8BYxuSFYl7eov9Uc
	 DznXmJyBQi40qzSZ9KA9vYWxL9HxPQiPTZzxkkGe+fGQjXhkUz2cxGU82vzS3qg31G
	 RAtYmDze2eXb9btBMehTuqSTSieuKMSNJYybqzB6l3+SYzpjuyMRJEtC/qmoYT780M
	 E/w0U5wuXmBAjCX1MLwgoul9pBMpOAewIgjLrNGavHNSZd+q0Q0rEFoFI6yMUPmTVQ
	 tQRYn+Dtrbj6iEXMJtqLFgJ3i1/z/WgHmMTU+2mM0n6lLZgsYJCdmXowmt0nuMGTNO
	 p9nx9DPNbtumQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] net/sched: sch_taprio: Replace direct dequeue call with peek and qdisc_dequeue_peeked
Date: Tue, 28 Jul 2026 14:06:35 -0400
Message-ID: <20260728180635.289503-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728180635.289503-1-sashal@kernel.org>
References: <2026072145-tank-retrain-5dd2@gregkh>
 <20260728180635.289503-1-sashal@kernel.org>
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
index 299cad8ece93ba..6d1c83a076cd4a 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -596,7 +596,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 		return NULL;
 
 skip_peek_checks:
-	skb = child->ops->dequeue(child);
+	skb = qdisc_dequeue_peeked(child);
 	if (unlikely(!skb))
 		return NULL;
 
-- 
2.53.0

