Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470ED437127;
	Mon, 13 Jul 2026 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951127; cv=none; b=njeQp3vYkYs2ioCL5g30YwRkda99aigHXQd7n0w2R/EMObqDKF4aKWFLBXME43C7NoDYvEjjRoJspGhLe/yypp2RIEVzN2IQUIbbd/3ILExFtDBLXapFO1hG0q03Bi48Q2MFdQLZZW0zkF84HCnwwj/or/MI8XhGFK3tdBCXiQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951127; c=relaxed/simple;
	bh=UvG3w3Q38JCvdgaSsgN+1fOmYYd1A7xQdvoEpH7rRxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qut64Mb5T7Qsd0qdqtNPAn1NGC/pV85pQqjSoV2T2s9P2g3BqeKljlL/tU5sHBChgex+hcWfDQApVzO+outjPGSu4azzAHOqJopeuYaS6iX+YKavk5MmQTUfz1s36cIFTcoS4pQGlmROlz2RK66DnniiDC/6/ki4hCnxTdSEJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEkO4cOG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEkO4cOG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C461F00A3E;
	Mon, 13 Jul 2026 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951126;
	bh=yFIQucAr4vFmOrW82XY64T561EcF6nkSnWV7DSiSLJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MEkO4cOG07NJ7HKPJXu62PXT/o98eeK7TbKkTVT+LMqWbUKy8aZygB2ygoNst2sRj
	 gzXjIFlJyFrWDM6dButP2m/w78beObSMeuDCcC6XBQN+wMUof0NDeVOkmTzOIjVsvX
	 vda83iP5GNBiHr2EWkKqMacRAYB3/h7Skld5ia18TmOZJHI90UFAaZW8mFaQN1STnB
	 Oh6nZjIWOrghkf2//6kGQBmZUUIjmUhpBCDv8RxOqziLQlsy0jcZN+1q2uTQorM0z1
	 hBb6oEjPFxvqOmnAsUZrNGVkxxl9jp56aoWwMgfZnCkNkSye/bJUUzrFwapcTh/0w+
	 /p3IkKRDDSeyA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 1/5] mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
Date: Mon, 13 Jul 2026 06:58:32 -0700
Message-ID: <20260713135838.32730-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260713135838.32730-1-sj@kernel.org>
References: <20260713135838.32730-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to online parameter update like events, the number of DAMON regions
could be higher than the user-set upper limit.  kdamond_merge_regions()
repeats merge regions until the number meets the limit, while doubling
the merge threshold up to the theoretical maximum threshold.  It is
tried only up to the theoretical maximum threshold because even the
aggressive merging can fail from reducing the number of regions under
the user-defined upper limit.  For example, there could be many
user-defined non-contiguous regions that cannot be merged.

The threshold based loop break condition is evaluated by comparing the
threshold for the next merging try against the theoretical maximum
threshold.  If max_thres is larger than UINT_MAX / 2, doubling the
threshold could make it overflow, and bypass the loop break condition.
In the case, if the number of regions cannot be reduced under the upper
limit like explained above, the loop will run infinitely.

Prevent the case by doing the break condition check before doubling the
threshold.  Also, prevent the threshold exceeding the maximum threshold,
as it could overflow and apply the wrong merge threshold.

This issue is unlikely to occur in real world, since having the
max_thres higher than UINT_MAX / 2 require unrealistically large
aggregation intervals compared to the sampling interval.  Also, it
requires an unrealistically large number of uncontiguous regions setup.
Nonetheless, the consequence is bad and the fix is simple.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260709145425.96247-1-sj@kernel.org

Fixes: 310d6c15e910 ("mm/damon/core: merge regions aggressively when max_nr_regions is unmet")
Cc: <stable@vger.kernel.org> # 6.10.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 806a67d02a6e9..f3b6a46fdaabd 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3369,15 +3369,20 @@ static void kdamond_merge_regions(struct damon_ctx *c, unsigned int threshold,
 
 	max_thres = c->attrs.aggr_interval /
 		(c->attrs.sample_interval ?  c->attrs.sample_interval : 1);
-	do {
+	while (true) {
 		nr_regions = 0;
 		damon_for_each_target(t, c) {
 			damon_merge_regions_of(t, threshold, sz_limit, c);
 			nr_regions += damon_nr_regions(t);
 		}
-		threshold = max(1, threshold * 2);
-	} while (nr_regions > c->attrs.max_nr_regions &&
-			threshold / 2 < max_thres);
+		if (nr_regions <= c->attrs.max_nr_regions ||
+				max_thres <= threshold)
+			break;
+		if (threshold < max_thres / 2)
+			threshold = max(1, threshold * 2);
+		else
+			threshold = max_thres;
+	}
 }
 
 #ifdef CONFIG_DAMON_DEBUG_SANITY
-- 
2.47.3
