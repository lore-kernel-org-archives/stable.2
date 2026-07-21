Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C412E0B5C;
	Tue, 21 Jul 2026 05:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611974; cv=none; b=Fjf7gGJXqJkq78fhcPOgoZP2Djt2NcUiGW2Jaj/Pi+FH/MVJVGzo8iI97oxNd11sh5sN7veZXQ5Q3yDGI+xXHPWuDix4uGhEIch7OaywsTPmwnibZ1+uvMvOpGdLnR75NXTgTyKuAmIMAhSm9Txl5tPOMjVjGFw1fyfflsR8dtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611974; c=relaxed/simple;
	bh=CGK5HTm8bFHhLkEVUk10PDNjv3Pr4nQWcP+h26SQZgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IU+uxzrfOXyn8vsKCnR2Mo9yFd5EekvZgnDc6DPMGl5NDrgK5NP5o7FW2rsWvqPwm/3ka4pgQEhuIwKDtYM1pXZ+0lg9uRujer8cSoi2cetk6jwqz2nIus8bzWqdblf+sIM0PgBkojfYnBInFe1cRoVKFZr4aLRJH1b3IxN7AdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtKXyWFq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtKXyWFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B6B1F000E9;
	Tue, 21 Jul 2026 05:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784611973;
	bh=jrCXFGbkOZaG/yTdaX+t+E66GT1LRjtb5moqLtp/1Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DtKXyWFq1e2i1tXg991qGLLXXCQTN0lLfKdc1EMmm3BI2QBKEsUthc/Yh+FpKlQtP
	 txTmVOsxynUQ5nrKchLl7odI9MVgtzq3ihM8Ojyytl4GAEM0OiH0cTmPS2fL2KP2Qd
	 TKSoEr6AT8YAhtLNzpXb1L2mViJEWlzLX8afG/p3qxHhNA2TzmhTFBllgvPIjDS890
	 c3Mootc5CRGaQeyV6HHlb+Xq9bcuV+uYaUb5tmnLnBMtL7f971c4R58tEe7gcdYzmO
	 S+HQqham4fM8wNRa9SsYi4rcIZkj14D+/qIEPAU0nRI9D3+PBxTtxUCKkox7epyJrM
	 NnOYjB/83uV5A==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 7.1.y] mm/damon/core: trace esz at first setup
Date: Mon, 20 Jul 2026 22:32:37 -0700
Message-ID: <20260721053237.171833-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026072015-wilder-coastland-ba7c@gregkh>
References: <2026072015-wilder-coastland-ba7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

DAMON traces effective size quota from the second update, only if a change
has been made by the update.  Tracing only changed updates was an
intentional decision to avoid unnecessary same value tracing.  Always
skipping the first value is just an unintended mistake.

The mistake makes the tracepoint based investigation incomplete, because
the first effective size quota is never traced.  It is not a big issue
when the 'consist' quota tuner is used, because it keeps changing the
quota in the usual setup.

However, when the 'temporal' tuner is used, the quota value is not changed
before the goal achievement status is completely changed.  For example, if
the DAMOS scheme is started with an under-achieved goal, the quota is set
to the maximum value, and kept the same value until the goal is achieved.
Because DAMON skips the first value, the user cannot know what effective
quota the current scheme is using.  Only after the goal is achieved, the
effective quota is changed to zero, and traced.

Unconditionally trace the initial quota value to fix this problem.

Note that the 'temporal' quota tuner was introduced by commit af738a6a00c1
("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL"), which was
added to 7.1-rc1.  But even with the 'consist' quota tuner, the tracing is
unintentionally incomplete.  Hence this commit marks the introduction of
the trace event as the broken commit.

Link: https://lore.kernel.org/20260520150311.80925-1-sj@kernel.org
Fixes: a86d695193bf ("mm/damon: add trace event for effective size quota")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 7e6cc35f5283eab81a14231a64ecd640b690c48c)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3dbbbfdeff719..f993d5a92df25 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2453,6 +2453,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
 		damos_set_effective_quota(quota, c);
+		if (trace_damos_esz_enabled())
+			damos_trace_esz(c, s, quota);
 	}
 
 	/* New charge window starts */
-- 
2.47.3

