Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833D2BB13;
	Wed,  9 Sep 2026 04:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788926680; cv=none; b=gRf4Ucv5qbPUazeDg6RXvJ3AWVDszOEfgl9KgLsyG7PWx8Z6Y5ijej83f6jG7yBcdGq8uQoAhR48tiLUBnAq1qrISYcCH3w737QgT9a7zj8Li+MxbPDdL3osKnVmG6C0kjamWsL24K0PxhlbrXnlqv6ifm994LJJQs3UcqtB+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788926680; c=relaxed/simple;
	bh=PYZ+PNvw3K9DHj4qV3lJuHfssXeUvBrx/KRpbN9ogJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4gaZ/OyAO8GfahK4mcFY5kozGY18jQI9lmTCoX80bLqxSdHkxUvIub5gaq5An00gNxevJDs7k5V/s9Zkwl9d5hb42E7dNhXsS3Ds2Ndn4OlqDNVNblQ+fxAm1FpxXHWiBM2TB18lAERJmuxs9AcgK2z6qEgV2f+HTXhhnYi2NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVbcHgS4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVbcHgS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C212B1F00A3A;
	Wed,  9 Sep 2026 04:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788926679;
	bh=zyNiAICHBw3DWYftkk0LJOlG6tRmin3KFcDAWF09ZaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CVbcHgS47Nc+x6f9IGYQ2LhRvPfv7RZVvHXYY8fxchf1dJGipRf+2q6XFVcrFEEMS
	 bB0lUSp3r8EF2Oa5IiyzG44GIdMuN//mh6sb3xKNAE54J1KVvpadvsN5YtwG7V86LW
	 a4zhpHcEQGiC1nGIy9G/Io3Tuqrr3uTbAl58YP/x8HRMmovyEZtHBrFlqlZD96S+nV
	 vkwQjnVnXFdZ1Gu4iBQV1nBCaI8g7hyQurx00gVlwZpgf82LuklDXqflBPxaj2wCRi
	 t4NtrYGBR2h+1fBZWT4S7affHS4tbheYa8b01+kdkU5Qx1koffw721tCLyBVyWTaLW
	 0xiaTG+sSDt7g==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.18.y] mm/damon/core-kunit: handle region split failure in filter_out()
Date: Tue,  8 Sep 2026 21:04:31 -0700
Message-ID: <20260909040431.171803-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090830-think-magical-cf80@gregkh>
References: <2026090830-think-magical-cf80@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_test_filter_out() test checks if damos_filter_match() of an address
filter splits the region as expected under a given condition.  But, the
test continued regardless of the split successes.  As a result, the later
part of the test could dereference invalid pointers that returned from
damon_next_region().  Further, it could corrupt memory from
damon_destroy_region().

The consequent user impact (memory corruption) is quite bad.  The
realistic user impact would be limited, though.  It would affect only test
run setups.

Fix it by exiting early for the number of regions test failure.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260718001442.87129-5-sj@kernel.org
Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org [1]
Fixes: 26713c890875 ("mm/damon/core-test: add a unit test for __damos_filter_out()")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: <stable@vger.kernel.org> # 6.6.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 3423fe70395210e2f0cd795270292f6a27cd57b5)
---
 mm/damon/tests/core-kunit.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 6687778752728..801407b481cdc 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -588,6 +588,8 @@ static void damos_test_filter_out(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 1);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 2);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	if (damon_nr_regions(t) != 2)
+		goto out;
 	r2 = damon_next_region(r);
 	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 2);
 	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 4);
@@ -602,11 +604,14 @@ static void damos_test_filter_out(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->ar.start, DAMON_MIN_REGION * 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, DAMON_MIN_REGION * 6);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	if (damon_nr_regions(t) != 2)
+		goto out;
 	r2 = damon_next_region(r);
 	KUNIT_EXPECT_EQ(test, r2->ar.start, DAMON_MIN_REGION * 6);
 	KUNIT_EXPECT_EQ(test, r2->ar.end, DAMON_MIN_REGION * 8);
 	damon_destroy_region(r2, t);
 
+out:
 	damon_free_target(t);
 	damos_free_filter(f);
 }
-- 
2.47.3

