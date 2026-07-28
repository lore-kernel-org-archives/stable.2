Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229AA3B5F48
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262001; cv=none; b=VnsPetlCiJhO1vz49fdmH+hyuV2Bs1N/o5I8XUSYqg3Nri9wtbCH+FtRCFrd5dTdFnSyok7QnvyiJE1QgNYAi4txPjSxcUGazBQaaE0DVIAJQ/3kuye8zmqaZkuzwVI4EzZB2TZqV5szB8kGavqy76m9de3LkWAEsEOHOokXTA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262001; c=relaxed/simple;
	bh=oFnlfOd2zrSSTovRqgujFbEGRjfj0c98VqK8+wfDo9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dw/1NVZyImJ49eT4QObtCoAUXAWOZYp9w7fSycwaqiL/sZClrEPL6yPNpdJnwKv2bvfb6AWMz6ip8BBb/PizXqFR4SdcXQZ7Ozi95HHuhTXtKtqgUjMJEyS9Ib7u2EhFBvPjYC1LvqnksYEfIuDvIm+Ecro2Uh2vq6wROiMoqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpLxt1yW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpLxt1yW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1341F000E9;
	Tue, 28 Jul 2026 18:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785261997;
	bh=kBGH+9g6E2YJUZMu3vsjZA6jPj9eumRl5ZeSu5ELjt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MpLxt1yWZkXG9SlQJIY3GhOooum2ztpNfOxsb91j09JF8QPNuCUR3UKYfUG1pZLBZ
	 SPZROOkKK540Laq6BFTPRyuaHCOpaawr88NwJyskZwAK485aREItJ7s8gDFLkSdEMy
	 1ZyKjPwkYW/EaF1D2psVb7pewsnDQ+4pyQb2k/FdGESAL+rRv922QunGqHz2l2TZCM
	 ROu6LOjB/oix2mLOunCFZ1Cd1jdhLCGf18fOHg+dEqmmikoNifQP7BThnQLyzgoyXR
	 Ux4hKHfrFi+6ZKijThuEM1kqv4LohIGWzEf0GnimFfCBAhc2rMBpoUuwgoZpngq5g2
	 nl/oE8leW6BDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] net/sched: taprio: avoid calling child->ops->dequeue(child) twice
Date: Tue, 28 Jul 2026 14:06:34 -0400
Message-ID: <20260728180635.289503-1-sashal@kernel.org>
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
index 8da723f054f564..299cad8ece93ba 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -567,12 +567,8 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
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
@@ -599,11 +595,11 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
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

