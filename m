Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2EF331ED1;
	Wed,  9 Sep 2026 03:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788925120; cv=none; b=tD0di6eZeHh7nd3dSDV/Go3KGecEyJOxmyPGlntxbzTpOdoSXbYJwke7ZDqM8pq6CsAft18SXO/+sPNV5XQu3HhhBlpl1QwQdI0zpDamTvygHvrT1h9kTLRkIKdHlAZf5yYGPPrCiR9vG7vQjuY9tDh6EibCkOy48QIuh2cKf4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788925120; c=relaxed/simple;
	bh=D/ddij/Vg4ff5Z1uOC5tTlo461t///okHimcNaQTFxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtSnrz45BJ8eohSKg5PvV/mH2etS7KrDVLLfg2Sr1Eu/aBxj6huMZbsKPrj1qVXB34/P2pqD/T7y3LCFO0BlGgrahxLssDMzLEjnoFdDUyBrbTBpyUZwo6cwhk4FRS70rZz1msFRrdsOk3d7nbYH/NfWec4knaU+sxmby7YugnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4VakY6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4VakY6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790141F00A3A;
	Wed,  9 Sep 2026 03:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788925119;
	bh=DTLoBPmPhawDk2X7sNrppY4vwdPisie0jrSHUyT41Ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J4VakY6Uu3Xb4BJv+bitgA42HSc00lj16jtDJaTS1ebpRNdyJRh6t7zklz8OD3Y3q
	 67P3+TkJtPgutU4fbrlmcSvFRWMlNtYdl7odgvDgq6Mlx2ytmmUrz3mZXfDyIB6nsR
	 9FKHXqGfkuPC6Rk1xwAgW1of0jTtBf+Shzc+bX8GWJi7ZzjBwlCbLwBqfrQ+ZrH7Rx
	 lV+NXdLKj8jm0oLL58bxB6RrH/gQis89SpZ2jOixYzBF+hZe0snpa5hXc0sDCW/ZoR
	 DRo+xhjMQ1hbWiGubAfrT3ME7B9EBQ8vg42IY3Dab/ijyJFc1I0a95JF92whNybSvg
	 lqXKq01gBptqw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Tue,  8 Sep 2026 20:38:32 -0700
Message-ID: <20260909033832.132107-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090808-phoniness-repaying-46f0@gregkh>
References: <2026090808-phoniness-repaying-46f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KUNIT_EXPECT_EQ() does not abort the execution of test code when the
expectation is not met.  But damon_test_merge_regions_of() code after its
initial KUNIT_EXPECT_EQ() call assumes the expectation is met.  It does a
per-region test with a hard-coded number of regions that is correct only
if the expectation was met.  As a result, __nth_region_of() could return
NULL, and the test code can dereference NULL pointers.  Fix the issue by
catching the expectation failure and skip the per-region tests.

The user impact on realistic setups should be negligible, as it is a unit
test.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260715031002.108504-3-sj@kernel.org
Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org [1]
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit b640708929aa956235866bf7717d89018c661083)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 6687778752728..c1f0be6746abd 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -264,11 +264,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	damon_merge_regions_of(t, 9, 9999);
 	/* 0-112, 114-130, 130-156, 156-170 */
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
+	if (damon_nr_regions(t) != 6)
+		goto out;
 	for (i = 0; i < 5; i++) {
 		r = __nth_region_of(t, i);
 		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
 		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
 	}
+out:
 	damon_free_target(t);
 }
 
-- 
2.47.3

