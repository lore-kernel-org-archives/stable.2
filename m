Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6565E4734D1
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785267020; cv=none; b=t2syAOl0C/jRUJCmmgiRSr14hwE08HotJfs3vSlHv8xNiA7lkJnf76KWZ1poDKR3HZ99Cx0k/7j3Wmpz4vvqx4mqMNBAqZKpphR7ub8fdkdwVP49CV2E/g1ndaa0+hVFVALgWCX2pAw11L3RFJNIFF+G7Ejh9WwNjLD2rcqDCx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785267020; c=relaxed/simple;
	bh=atp5mKZcKsncNUtpWiwXNHcC3usGLAAaFjxcYJKubfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dw5NKvndHpGWyHHoC5I4sp/9X1jOLLVySTpzrY9lqk0fBXw1+6Skek1JfLACPFJfVYIWe4TiT9dPgLJWnWzMbXLn7xSJgVgln9qRcoatA+J9w5O1s9gTadA8tsvADOODT2EVowzO8A/bZGVPlBR7422Tyc3TiB4kjk4JkBRS7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvcFSv/n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvcFSv/n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957641F00A3A;
	Tue, 28 Jul 2026 19:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785267019;
	bh=zjQ/M95/KYNv2ReDL4CU08Zlbb+/HlJrGdSlx7WxaFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QvcFSv/nTTMCQIf6eTHoh8rO5bmLux05Mi7RljAvFibHhivd1dzGlvFmCSnyHU1fp
	 nDW/yYPBB5qGCik8qblyH2qPz8uEZyP19TPGS3vB/HCN7BHgUFCrlmGC2Hx8oJlpb2
	 iv5vb179pmm3OgoKDHhsVHoVklNc6pu6CVlW2z930aMXbddw/ds8ZR+gkCONXvaymN
	 8dxWypSKlMCL4paF4rfhTtNdPxrjKuL8vy1L+ECwkTbNHTzNAxl21sSSb7gZm1PTyO
	 bC5FNowVougMRhWlj2mNfpNJJPmKT+91yaF6Cp2ErpIF8/DNIo6KVLiccvoV9NCwpg
	 O6dX3eEgv/zbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net/sched: sch_taprio: Replace direct dequeue call with peek and qdisc_dequeue_peeked
Date: Tue, 28 Jul 2026 15:30:17 -0400
Message-ID: <20260728193017.455869-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072146-curable-untreated-02d2@gregkh>
References: <2026072146-curable-untreated-02d2@gregkh>
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
index 8e7c0a3034cc41..9e6a1e0f075e94 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -558,7 +558,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 		return NULL;
 
 	if (TXTIME_ASSIST_IS_ENABLED(q->flags)) {
-		skb = child->ops->dequeue(child);
+		skb = qdisc_dequeue_peeked(child);
 		if (!skb)
 			return NULL;
 		goto skb_found;
@@ -589,7 +589,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 	    atomic_sub_return(len, &entry->budget) < 0)
 		return NULL;
 
-	skb = child->ops->dequeue(child);
+	skb = qdisc_dequeue_peeked(child);
 	if (unlikely(!skb))
 		return NULL;
 
-- 
2.53.0

