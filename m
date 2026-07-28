Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF554657CD
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785267017; cv=none; b=dcHip0rdbQNpVsoYnFcE4ND4KUd6XidGuIA0O8Msk60UPMiIR3EDNg2Qmvt0pihcURyKTx9PBuBV/lMbarXcdOF4P2Ys5SibbQyntw4SKePtqx74Ot75NyfN4PQeOrXM8CybNtyDFwNIpzOuyObKir64atrPH5jmZCICmFQkbBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785267017; c=relaxed/simple;
	bh=g4N5x7N911ceRp3Sa8oJRtOHvRFk++So3z1DZ1oEh54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aavhEMG9AYnqiM+Z8QYXcCRPE8yms/FmCKM4mCTqKShhF790RDuiR5zWIMJUiAN1/ZdHYjuP8q75UU/gphaUhXM3I7U37nDNJzsNIwsgtSanNLhLNBHbLaw+1m1sQL8p9fm3jZlcAzFYVln2Fyg6YDXCYp7ONcvzQH10ISvQPcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xl3lrP2z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xl3lrP2z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338DC1F00A3E;
	Tue, 28 Jul 2026 19:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785267015;
	bh=5sE/XGAwHZdgZp3sCF9eRIJ2I0isiA4oMQnB22NxJBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xl3lrP2znErtJuaBJK8kym4FeLsptkWdTOZQCxP3A763CWpbTyf4i9/RD/qa8FD2A
	 tDpo2/h/wo42I8fGyWZxRwWOLkXfLEyEhLEluCMA4OYP3a+wYvFiHU6qDH3d4El4w4
	 rm7nzzZhRXen7er8hBpgbxz1xHVR044m58kuXHaVp3RIDiArtQIErqGcN5B0CZOZWn
	 Bnt91vLSxB8n5ZgbdDAdLcwSxgr78b6BTxxCkKZ1MS3ZzmdCAmV60ke4nQqDWbJLMC
	 Cxp4IplfIR+IMKNrfHfj8RQbR+1Kov2x/tgQfen6IfBAncMCK7iblHHmmcLrYil10g
	 goTXqiUhexviw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] net/sched: sch_taprio: Replace direct dequeue call with peek and qdisc_dequeue_peeked
Date: Tue, 28 Jul 2026 15:30:12 -0400
Message-ID: <20260728193012.455558-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728193012.455558-1-sashal@kernel.org>
References: <2026072146-curable-untreated-02d2@gregkh>
 <20260728193012.455558-1-sashal@kernel.org>
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
index 0fd5f79288b431..32521be54c6e99 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -586,7 +586,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 		return NULL;
 
 skip_peek_checks:
-	skb = child->ops->dequeue(child);
+	skb = qdisc_dequeue_peeked(child);
 	if (unlikely(!skb))
 		return NULL;
 
-- 
2.53.0

