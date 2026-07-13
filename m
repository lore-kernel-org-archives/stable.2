Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC3437107;
	Mon, 13 Jul 2026 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951127; cv=none; b=OkPsyd3WeZpeD4V8CZAPuhuMSTu1sWYwLoURgYJqnQ15hqHIMJNDO4D8SMfevsN6l2Pw9EDP5Idip0IQ86knA/26WlYHokMUBCMoJ5VxcYEmOSNqqFSRI9SeGCcxxne+Tf9xWaklISRJzN/cqaBK1I3Nfs+e8mIF5O9EEYD+Iiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951127; c=relaxed/simple;
	bh=2YTUi5fssLwguc0tdmj+L1Qs0tTe4BqhfdbB6oOiClA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q3022A0Kp4m9MlG3xSV+V9jEgNRESRjYVlj4mJ0w7zJ8De+xyQfUKFl/szlQfaKBwC5P6s0PfPusX/pgMuXFbMO4RNrnJN03pxJ6qv8VZeBZCginIJZJ6qu5Lo7Q7C+tuIXCq8C095ccBL782nDas+b3f5Q7I6Au5KCxCbdv538=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ/zMYiy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ/zMYiy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5565E1F00A3D;
	Mon, 13 Jul 2026 13:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951126;
	bh=SKLq7ZuoHq2BFm176pu4DfNEYfPU8F0EbpgzHa8ZXlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LQ/zMYiyDc9DBS+2PK4RjZYTpHzO2uSG2unKv5GwCgnDUqdMiXhJTqI0CAFZAa/3P
	 1VHFTEGSTxLynIIT943yFiCNPlZs2qYLlkPj5Lrfw3eveLRGKadq+v8/xT17JP2OpH
	 L82xYFFVjkghxdfAMdHlpQzTJEh9RWCz2fVa3BBJsjN/WjDZR49JoYSQ71YyYsSRaF
	 RDGRPLh6A1tTvWXaOQvf8hecqWIQ21JwhI3GXDDS4vJnPKRN/RLhDiRbTNbz5gq3Eq
	 nd1bC5m5KLvePmsUtrEd19vJxmscIWClZ9+2ZPN9UuOnMDRbSCD/38I76b4JqnZrzo
	 bKvk5Ooi9Yn2A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SeongJae Park <sjpark@amazon.de>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 2/5] mm/damon/tests/core-kunit: catch test failure in test_merge_regions_of()
Date: Mon, 13 Jul 2026 06:58:33 -0700
Message-ID: <20260713135838.32730-3-sj@kernel.org>
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

KUNIT_EXPECT_EQ() does not abort the execution of test code when the
expectation is not met.  But damon_test_merge_regions_of() code after
its initial KUNIT_EXPECT_EQ() call assumes the expectation is met.  It
does a per-region test with a hard-coded number of regions that is
correct only if the expectation was met.  As a result, __nth_region_of()
could return NULL, and the test code can dereference NULL pointers.  Fix
the issue by catching the expectation failure and skip the per-region
tests.

The user impact on realistic setups should be negligible, as it is a
unit test.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 6ad73559dd8ea..a99363720e677 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -260,11 +260,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	damon_merge_regions_of(t, 9, 9999, ctx);
 	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
+	if (damon_nr_regions(t) != 6)
+		goto out;
 	for (i = 0; i < 6; i++) {
 		r = __nth_region_of(t, i);
 		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
 		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
 	}
+out:
 	damon_free_target(t);
 	damon_destroy_ctx(ctx);
 }
-- 
2.47.3
