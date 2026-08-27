Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE97347140B;
	Thu, 27 Aug 2026 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838282; cv=none; b=vGUzGm9o8+szSbCDA6zurDGxRw5Giy5b8sGSKS11KdQ7DUMKvz62PWZ3SKLSLCJU3NkSsJtL8JcYW3uDMfli4VFi3oKDSSEOEDbRSkuu6RscdAMphrWWKOJIripV8s9SbhG9QOwcLSLrup7ktrtRQnzNakKj4lQaa/AQepyijSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838282; c=relaxed/simple;
	bh=fVFLkhzANZFV+pW0lm+qtfKNlza7qQdqLZv1gNZFGIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxzCQWEKzIykvlf3jTEbW24vxjqTdKLaX2wkxcdlzUjG3x1MkkrL0zJOcWNYBTKRJPozewPNVv6aPjw3hjEjZVMOrwE5SGTTz8APIkmwfTrxF8cKhATqQ2i5ZvNatGX4poUpBr/9hBzsrT+GMPuMXcl/6XHCAjccg0Qbl1Mxivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jX5woQMX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jX5woQMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC931F00A3E;
	Thu, 27 Aug 2026 13:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787838277;
	bh=R6N7NhpJ1BNkiL5rB15BJSeHfYTylJVAOauFDB7Ic14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jX5woQMXyglCLMJmWu7VohkJQfCZyylp4B4oKtWyfmvnMhZ6bdPickxD8wmutLsre
	 QpdS/6ucicxyye6iCqYjDlSQVu4RBu1TAWf2ecxjESh8wgB/a8BDKAuq447Xu4qcK2
	 H6GFY6ohRj05L4fFRM0tSVhqd4n5TTg3aDowOOuflhA+6vKUdf3Pjlo3B26z/gepbJ
	 71dUFx4rjnY3CiF2X44WQWz0OoU4ucAS3GmLDhT4sgzLEh5PB8ZOaBuRQL5xMOVQJk
	 Rjgg4DdLufmlKIx31ul+MKsQapuKPAgcMRhGujDiVK4kwiGwiBw4FIhytkCxvDyvbQ
	 6Wd/JTQ9B+pWA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 1/3] mm/damon/core: initialize damos_quota_goal->last_psi_total
Date: Thu, 27 Aug 2026 06:44:26 -0700
Message-ID: <20260827134429.123023-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827134429.123023-1-sj@kernel.org>
References: <20260827134429.123023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DAMOS_QUOTA_SOME_MEM_PSI_US metric damos quota goal is set, the PSI
delta for the feedback loop is calculated using
damos_quota_goal->last_psi_total.  However, it is initialized only after
the first feedback loop.  The first iteration of the loop uses the
uninitialized value.  As a result, the feedback loop can change the
effective quota in an unexpected way at the first iteration.

The user impact of the issue is not big, because the issue impacts only
the first iteration of the feedback loop.  The feedback loop also has an
internal cap of the quota adjustment.  The wrong adjustment will soon be
corrected over a few iterations.  For this reason, doing no
initialization at commit time was intentional.  It is also explicitly
commented.  That said, nobody likes behaviors that are unexpected or
difficult to be expected.  Fixing it is also simple and not expensive.

Initialize the field at the beginning of kdamond and each commit of
SOME_MEM_PSI_US type quota goals.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260718005316.89585-1-sj@kernel.org

Fixes: 2dbb60f789cb ("mm/damon/core: implement PSI metric DAMOS quota goal")
Cc: <stable@vger.kernel.org> # 6.9.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f8dddbff74a77..e5b6b1c6bb7b2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1118,10 +1118,15 @@ static struct damos_quota_goal *damos_nth_quota_goal(
 	return NULL;
 }
 
+static u64 damos_get_some_mem_psi_total(void);
+
 static void damos_commit_quota_goal_union(
 		struct damos_quota_goal *dst, struct damos_quota_goal *src)
 {
 	switch (dst->metric) {
+	case DAMOS_QUOTA_SOME_MEM_PSI_US:
+		dst->last_psi_total = damos_get_some_mem_psi_total();
+		break;
 	case DAMOS_QUOTA_NODE_MEM_USED_BP:
 	case DAMOS_QUOTA_NODE_MEM_FREE_BP:
 		dst->nid = src->nid;
@@ -1143,7 +1148,6 @@ static void damos_commit_quota_goal(
 	dst->target_value = src->target_value;
 	if (dst->metric == DAMOS_QUOTA_USER_INPUT)
 		dst->current_value = src->current_value;
-	/* keep last_psi_total as is, since it will be updated in next cycle */
 	damos_commit_quota_goal_union(dst, src);
 }
 
@@ -3741,6 +3745,17 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
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
@@ -3757,6 +3772,7 @@ static void kdamond_init_ctx(struct damon_ctx *ctx)
 	damon_for_each_scheme(scheme, ctx) {
 		damos_set_next_apply_sis(scheme, ctx);
 		damos_set_filters_default_reject(scheme);
+		damos_init_quota_goal_last_psi(scheme);
 	}
 }
 
-- 
2.47.3
