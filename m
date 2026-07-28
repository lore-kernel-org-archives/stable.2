Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B2E472F84
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785267016; cv=none; b=bWkgmk/unzR8dGT4XTZa/ZMwA5wQkWlJDxnFfpPQntvaYN9Y/iicM5qywO1m2HoUQCtNSPRmjDoBkQfHtERPusqKlF1+zIT7eIxPp9rtTKLw7bYKKMWphy0daenCNZyfEvvQXIbqVYQP+DG4B2nZUxyNVS8BzA5aViPEW/eqrJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785267016; c=relaxed/simple;
	bh=VdCWUJ/YxkIBcNvrV0RiQWa+3YST+f6YPaQybCzN8DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bny4vX0bBZqk1SnTzsDm8hkGTMqWKrsqM0Tj3jDGOOz7oIchiknM8l3qt4qjgDzfDNUDZ3a6dpqqmUrzFfh6Kk2Cnne/PqVsm8scBL+Ds59wApUWCyvnSgpfTFS11QJ2MvuTfkxjA3mZTTy/TpsXm0yoiSCQISIAN5K122AzMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LX6XPhOs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LX6XPhOs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD9A1F000E9;
	Tue, 28 Jul 2026 19:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785267014;
	bh=DDy6Up9001HScfFZjHJLoG9N2CxhJIA/Q83kh4JAPcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LX6XPhOsTGiJ67gdCo9gL7SZ5+dPazzVpZLjhZKL43UXOIu/82qyD/pbUpVSSGK1D
	 XYk/nV9d7vWXjwFjkmW0roNl8WpdphfsKIErncNBFPACqYD3w0uXQ7Y5pgvg9qQruv
	 wrcZGHbtsB084Ng2Ea88qo0mr4BAWghe4akYeL6wk0T1LgVKG5VThJa5r2GGJXbqgN
	 fRYK7bMgQpUP+8zJ1H20ZrtRbMeSnbjBTeOhG8LNPYImOb7LHCJi9j8NGj5UuPnOgT
	 D9f0CmNj4jMT+1wHCmPB+1ayjfCim6kFZRwU+nEIZZ0oxMoqOgsPFshnVVJEGSuKNH
	 zod36+ZzU+eig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] net/sched: taprio: avoid calling child->ops->dequeue(child) twice
Date: Tue, 28 Jul 2026 15:30:11 -0400
Message-ID: <20260728193012.455558-1-sashal@kernel.org>
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
index 8e7c0a3034cc41..0fd5f79288b431 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -557,12 +557,8 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
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
@@ -589,11 +585,11 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
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

