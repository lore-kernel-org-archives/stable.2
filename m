Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4CE3B71CC;
	Sat,  1 Aug 2026 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785605766; cv=none; b=OLCXvxS38R5aGvAR7eqmThxd1AiEByHBkjXzf5MoW+8Pg6t59l1CxbP2fX+Hro9Hd4zLxKuJZe62jI7bDtNUBuW9V6n26hq3flQiG/D/VDlGrGyMYBFgDppROxLqGkZSZ1N0Gf/FUOZPj0rhF32UAvvLWbu9KpaK6S2LEjkSxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785605766; c=relaxed/simple;
	bh=ZKIT6xnY2oY0e92eMERMwBiCQNJeROh6kYo/rMQan28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zcqh0xZglgxDFMS8em63xo8wirA40Actn+PkBJAd9E964vblH30HToi/iZcraKPAtkuM2Q3iLEmZ5fvl/GaGDS7Pg7V+heGznDxWGJ5+xFKScNoj3LI47e+vRf8KaZhHQpQH8tbaMFAhro8Ybi6cF7Jh1QHiE/Gb+AXGqEJBZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIlnGYbl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIlnGYbl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E491F00ACF;
	Sat,  1 Aug 2026 17:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785605765;
	bh=u3Yai1oWYsB5IJ1T8UFXb8F9ZG0QK/4CFjudJQO8wtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LIlnGYblIdAJF2L9ANrF/LWWjqlMRNw0pyblGdwP+H0Y0oNSeuaXfWqnRatJ1P8jP
	 3V7rmoYiqRnGONnpuCaK0KT2FVuVPlEnwCSTGHZtDwkDiP9i2efZAZorGcPskdfVvC
	 vcTwwzppVg6859yhqMlgowY8ZzTeL6KEB8RctiOy3yxsvPExbA5AF/dEWIGObwl33v
	 nA5qztxHlIASYkZGam7SLdh44jv8LmnGPDugdf22fRA6SSZq9fOcrGR5Gp4mWtYi+L
	 cTDaolvHBd80EjG7lBftVS5gpN/l0YZk2v5Hnr/woUVfGnd/FWWZCVGkJvLyFvDeqf
	 NhbnPy6Qa21lQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/9] mm/damon/core: initialize damos_quota_goal->last_psi_total
Date: Sat,  1 Aug 2026 10:35:45 -0700
Message-ID: <20260801173554.94710-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801173554.94710-1-sj@kernel.org>
References: <20260801173554.94710-1-sj@kernel.org>
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
