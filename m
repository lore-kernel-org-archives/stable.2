Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B09C3ADBA5;
	Sun,  2 Aug 2026 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688002; cv=none; b=fWzDFt29MiPyaq9+PqYlmQOSX7P/SFupivSaOUHGnB0H5Pu33LTsd6MjA5PQQ3dCLUgCms+XraXO8EzMgNfpiwds82Ayz2YcTmwzlFhv19Hd++VNzWTvGhbXrkEhcPuU8c3VKVfnXAAcV6OpKOj5UvlBJVYdZSccz1J0s55hCsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688002; c=relaxed/simple;
	bh=ZKIT6xnY2oY0e92eMERMwBiCQNJeROh6kYo/rMQan28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYEdUJP8BxjzEiz0BD7oUbhHf9lS4wjE6cR1np++muIv8YvhmkjMqvoaMoVRFFrXBCaKNLrAM8HHodlbsv+5HLr2oE1kMiFiT9eHwETOcK1Mgau6OrJEmnP7oTBz+7PSW002DswRJ5XT+2nS+c35jXv34BF+2tTPqb27x9+NlLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCxkL/p+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCxkL/p+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7841F00A3A;
	Sun,  2 Aug 2026 16:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785688001;
	bh=u3Yai1oWYsB5IJ1T8UFXb8F9ZG0QK/4CFjudJQO8wtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OCxkL/p+39Bi9iTZV0NqYw2G6YyiSqoQ5a0QvVf2YzJYLXd7z66X1o8vR+uygnJOX
	 t+Mdv4nmbfTaf4kOf2GMcVYF5kwgK/85UucUwmPbvlsSoHSGv4LeAVmgNi1qR/YfjH
	 cYtxRmJk4DNfbk1AUHLA5v9oBcCuRhl1eq22EFv8SWoHB1ho95Ei6AVuqpQyJ66bgm
	 uK2OdcXhUr2o9gFbECJpC9Ovd1O3MaL67hQUygvSPpfClq+kVb7YZelkPD9OhGUbqf
	 F3tJ5D5lkwnU0oaw2aB79xrxpVyngzDkF7syF6nDk6wnjdaNvLuN/WmsFiMNzjPw4f
	 G7sshIzQWpK6Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 2/9] mm/damon/core: initialize damos_quota_goal->last_psi_total
Date: Sun,  2 Aug 2026 09:26:23 -0700
Message-ID: <20260802162631.90304-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802162631.90304-1-sj@kernel.org>
References: <20260802162631.90304-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DAMOS_QUOTA_SOME_MEM_PSI_US metric damos quota goal is set, the PSI
delta for the feedback loop is calculated using
damos_quota_goal->last_psi_total.  It is not initialized at the
beginning.  So the first iteration of the feedback loop uses the
uninitialized value and makes an unexpected starting point quota.
Initialize the value at the beginning of kdamond.

The user impact would be trivial because the issue impacts only the
initial iteration of the feedback loop.  The feedback loop also has an
internal cap of the quota adjustment.  The wrong adjustment will soon be
corrected over a few iterations.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org

Fixes: 2dbb60f789cb ("mm/damon/core: implement PSI metric DAMOS quota goal")
Cc: <stable@vger.kernel.org> # 6.9.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e2900d0c984c9..3bdbf4fbf7147 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3728,6 +3728,17 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 	return -EBUSY;
 }
 
+static void damos_init_quota_goal_last_psi(struct damos *s)
+{
+	struct damos_quota_goal *goal;
+
+	damos_for_each_quota_goal(goal, &s->quota) {
+		if (goal->metric != DAMOS_QUOTA_SOME_MEM_PSI_US)
+			continue;
+		goal->last_psi_total = damos_get_some_mem_psi_total();
+	}
+}
+
 static void kdamond_init_ctx(struct damon_ctx *ctx)
 {
 	unsigned long sample_interval = ctx->attrs.sample_interval ?
@@ -3744,6 +3755,7 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 	damon_for_each_scheme(scheme, ctx) {
 		damos_set_next_apply_sis(scheme, ctx);
 		damos_set_filters_default_reject(scheme);
+		damos_init_quota_goal_last_psi(scheme);
 	}
 }
 
-- 
2.47.3
