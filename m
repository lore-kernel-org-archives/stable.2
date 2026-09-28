Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D694848AD;
	Mon, 28 Sep 2026 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585925; cv=none; b=pokEMTFRu3v7QpTRPHcz9WrlCmw1llJtMYhpFJt6x3aS/JI2+dFUcgvT0PUsCLPcGXtLKzt7MSB9vFMilvEROd4ZHoUSOZSUMXz0kbbtyUVQE8MuhDWrRG6/4YnSGPR/t5TYHQRRgYBWygflDBFbVXKqxCY7waFHACU1g5xtkws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585925; c=relaxed/simple;
	bh=ZrrFxAyVJCdXgoL+/e8Tjh/ghD/eVZPbU9a4CvLBfxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgL36fptIbky2MWRlQ9ulyjJQzw8x45e3k4DELvkofdZ9PTSmdCmiAoEmpGjuPZ3onoqhHpMfDxyz8tzRi//AB1pOGQYWpo48ENfgrWLVHYmsgnvo90yGWGn7dwyK64duv8CwextTV+/DBT55QGtQbrEXW608DnFDxuHq7o92Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZFF4oHJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZFF4oHJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E791F00893;
	Mon, 28 Sep 2026 08:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585923;
	bh=DUod8Zb0jA5oad7shZhRX8ELyKjWyy4MCAFtzmUTND8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oZFF4oHJ1PNjSC8za8bNh22VNairImK4OlJfe9gDdRNsdNqV5ZeXSVVhTNZaZLf1X
	 WEDxb5ODYod3+m4aONo5mt0HOOG//POe0mj4CQlT03tW5lGUDwRJj2+ldCXimZTIMc
	 K0Q7nFx8IVgnXbmV54/fDXhaIKp89QQYtS8kAzfCmuwuCw7vQTaQd8uDZAzfJ6+Lw1
	 mpcA5vxlbEAjTbFxYLg6R3fbopaSspfe1zSK3K7V4bET43TutvoJUCshtpXlcOYq3w
	 tBkXcTHCEi439qea/+ERveasnoTb6aaxZ0F/TESENgG7c5CkF1iWULk55CuecosbXA
	 8iN0M1MmmW20w==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	stable@vger.kernel.org,
	Bijan Tabatabai <bijan311@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 1/2] mm/damon/core: preserve the quota passed to damon_new_scheme()
Date: Mon, 28 Sep 2026 01:58:33 -0700
Message-ID: <20260928085835.7675-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928085835.7675-1-sj@kernel.org>
References: <20260928085835.7675-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karl Mehltretter <kmehltretter@gmail.com>

damon_commit_ctx() first commits the running context's parameters to a
temporary context for validating proposed updates. When
damon_commit_schemes() creates the temporary schemes, it passes the
running scheme's quota as the quota parameter of damon_new_scheme().

damon_new_scheme() calls damos_quota_init() on that quota before copying
it to the new scheme. This clears the running scheme's effective quota,
feedback input and charging state. Even an update rejected with -EINVAL
loses the running quota state.

For a size quota, this discards the bytes already charged and allows the
scheme to use a fresh quota before the reset interval has elapsed. For a
goal-driven quota, the consist tuner loses its accumulated input and
restarts from its minimum input. A time quota loses its throughput
estimate and falls back to the initial estimate.

The end users will show DAMOS works more or less aggressively than
expected for online-commit updates of quotas.  DAMON provides best
efforts by default.  DAMON parameters online commit is supposed to be
executed only occasionally.  Hence, the issue wouldn't be critical on
sane setups.  For user_input type quota goals, online commit of the user
input score is expected to be frequent.  But, for the case
commit_schemes_quota_goals command is recommended for optimal execution,
and it doesn't have this bug.

Commit 60bd24f272d0 ("mm/damon/sysfs: test commit input against realistic
destination") introduced this problem in v6.19 when sysfs validation
began committing the running context's parameters to a temporary context.
Commit b90408ef1163 ("mm/damon/core: safely validate src on
damon_commit_ctx()") later moved that validation into the core API,
exposing other callers including DAMON_RECLAIM and DAMON_LRU_SORT.

Sashiko reported the same side effect [1] on the RFC of the core API
change.

Copy the quota to the new scheme first, then initialize that copy. Make
damos_quota_init() return void, since its return value is no longer needed.

Link: https://lore.kernel.org/r/20260702212143.0CB6D1F00A3D@smtp.kernel.org/ [1]
Fixes: 60bd24f272d0 ("mm/damon/sysfs: test commit input against realistic destination")
Cc: <stable@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Bijan Tabatabai <bijan311@gmail.com>
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 60e4233ed23c..5ecbea5d71e1 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -734,7 +734,7 @@ static bool damos_quota_goals_empty(struct damos_quota *q)
 }
 
 /* initialize fields of @quota that normally API users wouldn't set */
-static struct damos_quota *damos_quota_init(struct damos_quota *quota)
+static void damos_quota_init(struct damos_quota *quota)
 {
 	quota->esz = 0;
 	quota->total_charged_sz = 0;
@@ -744,7 +744,6 @@ static struct damos_quota *damos_quota_init(struct damos_quota *quota)
 	quota->charge_target_from = NULL;
 	quota->charge_addr_from = 0;
 	quota->esz_bp = 0;
-	return quota;
 }
 
 struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
@@ -776,7 +775,8 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	scheme->last_applied = NULL;
 	INIT_LIST_HEAD(&scheme->list);
 
-	scheme->quota = *(damos_quota_init(quota));
+	scheme->quota = *quota;
+	damos_quota_init(&scheme->quota);
 	/* quota.goals should be separately set by caller */
 	INIT_LIST_HEAD(&scheme->quota.goals);
 
-- 
2.47.3
