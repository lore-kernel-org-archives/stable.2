Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE73AEB5F
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 22:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785277062; cv=none; b=UTCdsbeExetG4q9zYSLvGDG44gTh0gbqYTKAUHj1UAThv0uyvwRsJYAcpPobKjKyRhmCLYW8RTJNCs+QVIcUefhy5h3Xmh7kI7IJBkLTlgFr+874aQ6E19bNxHUmIVXpOSd9QpHIivOhX52gsW+g4wLUiUqlN5HC6R7vfiwdP6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785277062; c=relaxed/simple;
	bh=qAcuvNuBoRJ4U1f2XKunYqGrEbkPDeeBh4RNnoHBSuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHBAA1IBc9e71uszrQufP7Mk/REuQWaEnCjlQCmd7m2VxfkUlO3caTmzEUUzyK9Z2MDZb+/mRVDVtvddrSlAsBW6P1k62oijMIsoZfKkMcQm+tIsA+v8oug9Bs+7zrzDot3d3CbpZaRtIUtTbNYr4uypmJpz+nan4SzmJ6Jnj40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl5gnq24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl5gnq24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439DD1F000E9;
	Tue, 28 Jul 2026 22:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785277060;
	bh=7tFqCHXOwrOAXubGC4eoNoExD1NRwViTqqQNEJzzmvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fl5gnq242MIZbRdbiGzACAey4lL2iI8CQTNvb0vqpZHZGHSWDz0l3waHN9kkMPDJ/
	 KpQB1TfthiJbmYQypae8iZ/eNt1SBglFt67J3+9/B8hZCMwRY8iozqosjtr9Yq9P63
	 RRTiyorLT1gA88o1i7a7WQ7nbQMjj4ZqtwOoSjd0tmqfaZsIxoqQe6Mr0/b6a4f4PC
	 MWXYxKfr3WHHE8/N3Rgi43EUuHGW3r8Yv6TQPmJIODSeedodCXMlo6PKIH+JyO4hYh
	 84im/fV2a3iNljq5vl1/oJDAF0j5dI0vknFas768bzZGxIF+s0Jyhi/tVTEyKhQc//
	 F72lS1PD1ygFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] net/sched: taprio: avoid calling child->ops->dequeue(child) twice
Date: Tue, 28 Jul 2026 18:17:37 -0400
Message-ID: <20260728221738.745743-1-sashal@kernel.org>
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

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 4c22942734f0814d3c928c25a80f48df0a6ce45e ]

Simplify taprio_dequeue_from_txq() by noticing that we can goto one call
earlier than the previous skb_found label. This is possible because
we've unified the treatment of the child->ops->dequeue(child) return
call, we always try other TXQs now, instead of abandoning the root
dequeue completely if we failed in the peek() case.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: e056e1dfcddc ("net/sched: sch_taprio: Replace direct dequeue call with peek and qdisc_dequeue_peeked")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_taprio.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 50f430280337da..237e4a16a0e505 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -559,12 +559,8 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 	if (unlikely(!child))
 		return NULL;
 
-	if (TXTIME_ASSIST_IS_ENABLED(q->flags)) {
-		skb = child->ops->dequeue(child);
-		if (!skb)
-			return NULL;
-		goto skb_found;
-	}
+	if (TXTIME_ASSIST_IS_ENABLED(q->flags))
+		goto skip_peek_checks;
 
 	skb = child->ops->peek(child);
 	if (!skb)
@@ -591,11 +587,11 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 	    atomic_sub_return(len, &entry->budget) < 0)
 		return NULL;
 
+skip_peek_checks:
 	skb = child->ops->dequeue(child);
 	if (unlikely(!skb))
 		return NULL;
 
-skb_found:
 	qdisc_bstats_update(sch, skb);
 	qdisc_qstats_backlog_dec(sch, skb);
 	sch->q.qlen--;
-- 
2.53.0

