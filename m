Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A47442A15A;
	Fri, 17 Jul 2026 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298894; cv=none; b=QfG1isb20AnDjgzxNmIh3ACFYgKJeL9Pgc1FCvLjFY6b2lxp0WJgB1KiCZujEgmlklSCKG/NLae+Hsho8CZqK0nXjyqwQGzg82mOLueaRPGAaycpfZ4WXjhiFyoaMAqiv9v4VLJngT8eEPrsAwgP0u3YdHKBuex59jG/FDtgM8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298894; c=relaxed/simple;
	bh=ioC4eodbAR+1Uyfpuko2Zd0ZkrM7igoZy/SFuML6ORE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsndIAC2OkgLSsj9yhs+WYT8BQcCRuGvBEorLBqtf0ocl3AL4Sol7bHZw8HCfLjb2pO+tjqBfquyUWiMtHDpM4NR0PJFDEYogzSbQxdFj/2VjNHaYsB9iBbWBVi5Ihbj8EwsEAYkEHtc+Uam3EE/WTZpj6zXBJRs68bivjc20VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1VkfEE7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1VkfEE7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50911F00A3D;
	Fri, 17 Jul 2026 14:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784298893;
	bh=jqlH4wneWbMAf8JjBiLX1bTl/sVQqX7skPWoj8yoesY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E1VkfEE73Ld52yTp8XyAQnrJXqTiZfuPBrpHJg+wQgO+3sNQ0Iyu8PFiSyJKuDbfW
	 3LWPnW+dMyu7SVgLfgHiFoaZGVFY8xNd8VJu2HvUcIds2AT64Af4X2wpvGjjAIlYWr
	 CLrl4T0i7m2CYniO15KQb6ZXzke4uxN7QXT/oY2PnJYdnfys+nwsgv85juPh4Gh1Dl
	 ZGuVYrxhMsoNjjfaeFcQpFodyLIDvCoIsJDoyIgBeDLnLsDS68WGxSyzPhsTDCixx5
	 BFb0yKZ04XxR4H3Ii52aoGoEW7pZF983iz5p3Rmu7pdCgZ9Fi8s6OdJ93u6AalQbzP
	 r6ZQ95HO5A2CA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 1/7] mm/damon/core: initialize damos->last_applied
Date: Fri, 17 Jul 2026 07:34:38 -0700
Message-ID: <20260717143445.91207-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717143445.91207-1-sj@kernel.org>
References: <20260717143445.91207-1-sj@kernel.org>
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
