Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D671A6809;
	Fri, 17 Jul 2026 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784248233; cv=none; b=Ud5I333kSR5eILbz7Grrp/SO9fXN5a5Ge6NdM6tp3tI+lLYliQehcZD4H+Mf6+9u8vMHt/OohTXqWEd1riv/mwhPgCxAULvdOt7FFO901LXTflmZ1KHJn80YJZ8YRMvEh3JZUFPCWiGxQKC0/KXsMDU8/e4O9LzVq9/gOCnsUnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784248233; c=relaxed/simple;
	bh=A6BGFjnrb0sGxm4ySrgUnFdjJrEj1Y+uBT36j939Xnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgCUwpRSwKHKXKDfUKMgX65uFUJf2H6atU66rI6Gk34Zx8UkHk87Gx5F3ZqGf8dJrmAp1YB+/yRn+OiEVnmUjX3pxbGeigYvozumBv2wkYCDxQMwXGsq87sBtW3Bzy6Jedui7FLvnbjqI66apFfrY5jh/ppXSO33146MXGqqY4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHxLEGKU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHxLEGKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF641F00A3A;
	Fri, 17 Jul 2026 00:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784248232;
	bh=KyQzh9cAgWHiv+f51XfecFAFsLqN9MeOR+zzeRidaFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SHxLEGKUEqPS/uTbTfuN0+qoZkrJv6a4zhRpq3omfyZC+J08m/+oglJROCBSlTPzj
	 GKfzXuVdY+UrmQ0QmzR+DcJ1sz88rBYUBXIRhoDmTzBz/lqVDQi70d5TENIWU5/qWA
	 wNqIyFi4BR0LKY3XxamQaNoR/KSHKrc+4Ms8ahKc5vkqBByi9J1sebsrFO9yLwwQWE
	 qp3OH09VIleBYy7kqp2GfgU+uw9f/j14TPaRWPY1yco9K/FETGTKjbhqrfkVg+V6Kk
	 1v/BWQhr3AkWothaxP5dv0O1hvWwDwFGT//y4AiT2iYwO42eWM0mVjDlIa+LdbxUWi
	 6Ks/fxHQlMIpg==
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
Subject: [PATCH 2/7] mm/damon/core-kunit: check region count before testing in split_at()
Date: Thu, 16 Jul 2026 17:30:16 -0700
Message-ID: <20260717003022.119437-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717003022.119437-1-sj@kernel.org>
References: <20260717003022.119437-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_test_split_at() test next region that is assumed to be created by
damon_split_region_at() invocation.  But the split might fail.  In this
case, the succeeding test may dereference invalid pointers returned by
damon_next_region().

The invalid pointer may not cause a really bad user impact, because of
the implementation detail.  It would only read wrong contents in the
belonging damon_target struct.  Depending on the future change of the
offset from the link header to the accessing field, this could also be
really dangerous, though.  Still, the realistic user impact would be
limited.  It would affect only test run setups.

Fix it by testing if the number of regions was also changed as expected
and exit early for the failure.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org

Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index eba643762132f..322a295ac2cec 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -155,6 +155,10 @@ static void damon_test_split_at(struct kunit *test)
 	r->age = 10;
 	damon_add_region(r, t);
 	damon_split_region_at(t, r, 25);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	if (damon_nr_regions(t) != 2)
+		goto out;
+
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
 
@@ -166,6 +170,7 @@ static void damon_test_split_at(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->last_nr_accesses, r_new->last_nr_accesses);
 	KUNIT_EXPECT_EQ(test, r->age, r_new->age);
 
+out:
 	damon_free_target(t);
 }
 
-- 
2.47.3
