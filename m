Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45273DF6C;
	Sat, 18 Jul 2026 00:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784333686; cv=none; b=k5sVAOG7rsI3JVqtVdn7ZEWRtB25vRd5TytjHuko+fdVlhvy5rJByGuIlHy9ZAggKoQmUW9FDvCaE0tTecFl4gpYDjgkKZiY6weCHDh203IK+cZf4fdMswPiljMr3syDf/dNoVtgzwynxgmcxhp3ebYTPioPVmvdo9etWD9nCfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784333686; c=relaxed/simple;
	bh=ioC4eodbAR+1Uyfpuko2Zd0ZkrM7igoZy/SFuML6ORE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxAvxexIVlrTp+fmHoWyl25Z8D0qHmFtbYhydvesak7279gonFXnE0G5AAaqmC76bBTBNUmOj8McLmFUgc5JHRQt4OWZcO+NeeV0xgKLl+85eOgfElXNNuoqr4Qz5xDNUOps8iTNoafgAhpyKVYfTWcgTmWpcCogzh5MBcioH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOruMsKP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOruMsKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24751F00A3D;
	Sat, 18 Jul 2026 00:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784333685;
	bh=jqlH4wneWbMAf8JjBiLX1bTl/sVQqX7skPWoj8yoesY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FOruMsKPL/U3XY9juZDN9avo76TDPTcJuXwXWUDQNx8Yz+18QegNmp+QCoET+Rve+
	 NwhddX+KuULp9o1ExaNTrovDAYYumb1NZqg8DK9VqS2FPbLqkQmSfprMv1KCNig6wl
	 bIMbznAwMck0z+azzhMkY6wFQsVOqXylEfvwS7yRD1epID098fb2au4ckVpiHgZSLY
	 gdY3MVjga6mdI5W/oGjg400pFHzJSzXGqNof9sO9SnMNbe9WLzPlNY4o3bMKI0FadV
	 BuAguxsV+avV1NBkQMuskVRVYFKBmApqU5rAR9oViuufNM+2UKc2GkJl2D6HU05OS5
	 Zp/Yw4rUuDYQw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/7] mm/damon/core: initialize damos->last_applied
Date: Fri, 17 Jul 2026 17:14:35 -0700
Message-ID: <20260718001442.87129-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718001442.87129-1-sj@kernel.org>
References: <20260718001442.87129-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple DAMON regions could exist across a folio.  If they fulfill the
condition to apply a DAMOS scheme, the scheme could be applied multiple
times to the folio.  To avoid this, each DAMOS scheme stores the folio
that the scheme was applied to last time in the damos->last_applied
field and skips repeatedly applying the same scheme to the same folio.

The field is being used without initialization, though.  Hence, the
mechanism could wrongly skip applying a scheme to a folio at the very
first time of DAMOS run.

The user impact is trivial.  DAMON might unexpectedly skip applying
DAMOS action for one folio for the first time per scheme.  In the
DAMON's best-effort world, this is never a real problem.  No critical
consequences such as kernel panic or memory corruption happen.

It is a clear bug, though, and the fix is straightforward.  Fix the
issue by initializing the field in DAMOS scheme creation function,
damon_new_scheme().

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260714055436.120034-1-sj@kernel.org

Fixes: 94ba17adaba0 ("mm/damon: avoid applying DAMOS action to same entity multiple times")
Cc: <stable@vger.kernel.org> # 6.15.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index f464b4f0976c3..60255f5cd715e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -705,6 +705,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	INIT_LIST_HEAD(&scheme->ops_filters);
 	scheme->stat = (struct damos_stat){};
 	scheme->max_nr_snapshots = 0;
+	scheme->last_applied = NULL;
 	INIT_LIST_HEAD(&scheme->list);
 
 	scheme->quota = *(damos_quota_init(quota));
-- 
2.47.3
