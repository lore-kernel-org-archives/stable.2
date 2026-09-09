Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1512FDC28;
	Wed,  9 Sep 2026 03:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788924903; cv=none; b=Bt3X1egnqTnm9KlOHOeljhKfiV8cWt6tWU6v5jKB7QKm6MCY9NBfsU8XDYcXn6HLVXLXoN57dVROVGDIHV33AYIaeg7HObAMSftBrYs9tJSLg8AeP+troh3qCcg08bofEewmHeCMGdYZ6FKmZmUAe5hD0+1BOCSKYCJsJRSK5wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788924903; c=relaxed/simple;
	bh=0t9S+5YZVblmItpBrXlzJMnlJr1PTOfmeh1ZHnSwAjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/vVOvgS1qTmG4voYOOwbUyEcU42CaSmzBD+6nTGm50xQzzuJ7DvlI4lSe5UuXaK6YMS1VY4T094QT3+bT6xhlaZk2fhSmtdkjx4Mg/i7qOgrGN5oLbU3KT50K2CUE3vycderR8eJbTLbgGYyOKvg3Hjlv7uTrO9+V2Chd+2pTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqgO0EFm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqgO0EFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A611F00A3A;
	Wed,  9 Sep 2026 03:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788924902;
	bh=1hif4kRXGKRlv7XCaBOz5TzhPf5u9j8mx7cCV88z3fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aqgO0EFmtA1p9UshtYQOQPa5eVslosHTFEaAnn5/PVwi1ga+gCUJYZdU7eGhf16PH
	 lc00K9YKFDwRJIBZKKaK7gGNCID7QF35K3GoZYR5V1McrQG2K07QVH/RGp7co/eHvS
	 2gj+QwZH2GnhAQKqtXlY31wItlRZ61+rptqL5aEN1DJuMGFx7Yb7P2yvnrFSAxMeps
	 63wDvFHZQcDneZ4fe2YB2yt90miL5QNV2gekAB55i6ovpPK6LVm0PkImDypWNLNFfK
	 yYRpFDST0R+eix12yK7vKphWYPnEHvDXZu17azjUUzjoOynJBPZYSSoPQoNfye2mjz
	 THZlhtnsdhaNw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.6.y] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Tue,  8 Sep 2026 20:34:49 -0700
Message-ID: <20260909033449.123677-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090808-subscript-extortion-d6f9@gregkh>
References: <2026090808-subscript-extortion-d6f9@gregkh>
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
 mm/damon/core-test.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index a2aa410d6d0d0..2e191cc4a1b3d 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -253,11 +253,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	damon_merge_regions_of(t, 9, 9999);
 	/* 0-112, 114-130, 130-156, 156-170 */
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
+	if (damon_nr_regions(t) != 5)
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

