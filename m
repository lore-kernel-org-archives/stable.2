Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF12471CED
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766849; cv=none; b=rjPoVVHttn/HYw1nBRtfjFEuDX5lwca5NKui+xQ2H7WWGujtnWIzpYDEIVFHIOY/fTYzySbv30D7f+dbXXfq7j7F4mYKe6n6jn5Ttrqah9WgCbMQeea84N/jrwS6Kl4jM3lkOl1MnjiANR3phSX01KGQsM0ArgXASEZi1l9yMTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766849; c=relaxed/simple;
	bh=hAlF/3RJV7DsIAbyo2eJ/vpqluXPrPWKqkM/ypr/UOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SH1FdzGSXalMlF5sUBsCUu+FrX/+N3J3o7jyz2Q3gFAwACliY7RdX2x3wXA/4VikDnATQxfupdxtHUQ83xm6dv2Fvz0uKQVx0rqrtkMUJY/5xNgwzYkEgz8gVkB464RoTFUj2b1UMIQG9jWvDouTVfD+aPH/5UUmcNjem/dZNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9Qi5UyR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9Qi5UyR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6951F00899;
	Wed, 30 Sep 2026 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766848;
	bh=97rPNqTu8R/7WHI9d6NEAiFzFdg8Rs1uJyoZ1K5MAOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D9Qi5UyRWKbN5xGXFVZen2hGyWweqtb/GGkB6iE/rfXG9LkiPJ3qPJ0aGK/rZKt/s
	 bwW7eQx6QqmyRTlnR9EGPl2l4XqvvUL3xheejwCph6TUfOrF2XbF6/ylG2T+ptUhZd
	 dZc6Bjvs8pzN2De92oTptVXtPVnkNfJemFkVbg5eIxR0BCGhevmMvJPfdoGODO28aH
	 97Jog40k5IFX7CSZyOftzFh7u2tXnnild72T1kYcG2ErWAKbn44U2cIjauTtJXWvVh
	 86BqyXe2QRDSQbPsmgqa2h6HqEgnh//gxWCzCL3L1xQsjbTpAu3OwLaOYD8IQkJE4j
	 Vvb0bxeKVdM6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Enze Li <lienze@kylinos.cn>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] mm/damon/core: fix wasteful CPU calls by skipping non-existent targets
Date: Wed, 30 Sep 2026 07:14:04 -0400
Message-ID: <20260930111406.1206660-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092948-moonrise-persecute-3597@gregkh>
References: <2026092948-moonrise-persecute-3597@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Enze Li <lienze@kylinos.cn>

[ Upstream commit 6e4930e33329eec80dd245f28b52202271f5fb28 ]

Currently, DAMON does not proactively clean up invalid monitoring targets
during its runtime.  When some monitored processes exit, DAMON continues
to make the following unnecessary function calls,

  --damon_for_each_target--
  --damon_for_each_region--
      damon_do_apply_schemes
        damos_apply_scheme
          damon_va_apply_scheme
            damos_madvise
              damon_get_mm

it is only in the damon_get_mm() function that it may finally discover the
target no longer exists, which wastes CPU resources.  A simple idea is to
check for the existence of monitoring targets within the
kdamond_need_stop() function and promptly clean up non-existent targets.

However, SJ pointed out that this approach is problematic because the
online commit logic incorrectly uses list indices to update the monitoring
state.  This can lead to data loss if the target list is changed
concurrently.  Meanwhile, SJ suggests checking for target existence at the
damon_for_each_target level, and if a target does not exist, simply skip
it and proceed to the next one.

Link: https://lkml.kernel.org/r/20251210052508.264433-1-lienze@kylinos.cn
Signed-off-by: Enze Li <lienze@kylinos.cn>
Suggested-by: SeongJae Park <sj@kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: b3723b596b54 ("mm/damon/core: fix unconditionally skip last region")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0713fda22682c..2990367d849eb 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1156,6 +1156,9 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		return;
 
 	damon_for_each_target(t, c) {
+		if (c->ops.target_valid && c->ops.target_valid(t) == false)
+			continue;
+
 		damon_for_each_region_safe(r, next_r, t)
 			damon_do_apply_schemes(c, t, r);
 	}
-- 
2.53.0

