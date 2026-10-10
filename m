Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C476941685B;
	Sat, 10 Oct 2026 06:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791613858; cv=none; b=RtRra0Ia28H9qZA8uBOLOe8CZDeOkIYgj+rhXJZuiJNiSNGojUC1bFYUHT6PfKvdhdS9B0DZvsz3xh6/qMnHqXkWbcyey+TNJMOELMx0QffcjVVZvstgTrf/xFbPiT86nZ0rLM3XJQ6CCPPA5cOcRllwlH1pNVXXcfF2dlMayLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791613858; c=relaxed/simple;
	bh=n9BrzX5uUuOCLCNlssOUUw6zKKIW2eRALxlywJy4x9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ef2JJjoGrpcnaozW5Ix3sI7MDOTDe8zKS91kpGjzrCFQ1kI3ZPDz0sFxYuzpgec6DqkSMY9E5bWtrs8TBsV6IuHptctysPKB0HLFOqydbQmGO79WdIPd/yCf6cbSJOvEc0Dv/MTi02ITGa98/oD9zgbF2YRtgXd/S5Iz1/obMW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RISlyRYF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RISlyRYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82FB51F000FF;
	Sat, 10 Oct 2026 06:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791613857;
	bh=sfbmDzP+jSxbqxMQfE8J+uw0sV0drSlYshTq/Oey/U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RISlyRYFSzG+E9vD8LRpSSqSHUiHZNNWa57p7hQQiDltkVD96FNxeHrowhzkUB6VK
	 0aYoU68vZvzOmvTONL3ByLmnvxVrVoXRUNjtfso/mnrHLifW9wG1FjXId3t/lFpTzS
	 AZgt5Rey6Tv23F3wMbJE0Seyvc0Xx3JHAK/qr0U4Sn0XjpfAtJvyleF2gKIYDHqoEb
	 t9UQaeuWX6LNnP+hEUFnAIwLcTu2ZovxlIKHy19T4RSgzgf25XZ6YcNKe1JgTmmWFm
	 Cly3z8/EuZdKmdpOVJcwxQjUcPEWxcIOEn+FziFhkI9pj+rFvLClbxGkVbfYEMC0Y+
	 RNqYY06yVwojw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y v3 1/2] mm/damon/core: do non-safe region walk on kdamond_apply_schemes()
Date: Fri,  9 Oct 2026 23:30:41 -0700
Message-ID: <20261010063042.8611-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261010063042.8611-1-sj@kernel.org>
References: <2026092949-surpass-thimble-02a8@gregkh>
 <20261010063042.8611-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

kdamond_apply_schemes() is using damon_for_each_region_safe(), which is
safe for deallocation of the region inside the loop.  However, the loop
internal logic does not deallocate regions.  Hence it is only wasting the
next pointer.  Also, it causes a problem.

When an address filter is applied, and there is a region that intersects
with the filter, the filter splits the region on the filter boundary.  The
intention is to let DAMOS apply action to only filtered-in address ranges.
However, it is using damon_for_each_region_safe(), which sets the next
region before the execution of the iteration.  Hence, the region that
split and now will be next to the previous region, is simply ignored.  As
a result, DAMOS applies the action to target regions bit slower than
expected, when the address filter is used.  Shouldn't be a big problem but
definitely better to be fixed.  damos_skip_charged_region() was working
around the issue using a double pointer hack.

Use damon_for_each_region(), which is safe for this use case.  And drop
the work around in damos_skip_charged_region().

Link: https://lkml.kernel.org/r/20260227170623.95384-3-sj@kernel.org
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 1745ccbd2907db2bdaa843e4abccde4fdaccbe5d)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7afbc20833ea..b5c85e648859 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -788,8 +788,7 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 					sz = DAMON_MIN_REGION;
 				}
 				damon_split_region_at(t, r, sz);
-				r = damon_next_region(r);
-				sz = damon_sz_region(r);
+				continue;
 			}
 			quota->charge_target_from = NULL;
 			quota->charge_addr_from = 0;
@@ -858,7 +857,7 @@ static void damos_set_effective_quota(struct damos_quota *quota)
 static void kdamond_apply_schemes(struct damon_ctx *c)
 {
 	struct damon_target *t;
-	struct damon_region *r, *next_r;
+	struct damon_region *r;
 	struct damos *s;
 
 	damon_for_each_scheme(s, c) {
@@ -912,7 +911,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	}
 
 	damon_for_each_target(t, c) {
-		damon_for_each_region_safe(r, next_r, t)
+		damon_for_each_region(r, t)
 			damon_do_apply_schemes(c, t, r);
 	}
 }
-- 
2.47.3
