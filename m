Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CB542A15F;
	Fri, 17 Jul 2026 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298894; cv=none; b=LGmSt8awKWgKS4mZ9d5NOx1jIiAIyL7EO8cw+XAJyvoCUQGcYd6IKrSB9CfYNCP9ocKRXVls8glrItrmJJbLee87hD3+vlzqWnU99KjByBcEVmKkbsLPSV1tiDQfw9Mcf7UdZ4OsY0rdtHhYpKXt3A/uWnpIf52CyJkUhJ7jFa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298894; c=relaxed/simple;
	bh=A6BGFjnrb0sGxm4ySrgUnFdjJrEj1Y+uBT36j939Xnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6Cv38lTjDWipxVco9cdQ5JHgBjcWNMC0vpxWhZPq1a2VLNMMhbgzZQV37pG0UTSaLS7BDVbcCURjDcpBmi3cwe90XO7SSDBEDbWGhJj38ZlSTaFTEgQyj8in4EjI1Ea0NGXQVamYsIV4Bntq3lWENeBjBj9eEsm2rQaOElOnzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmloB99Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmloB99Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DEE1F00A3E;
	Fri, 17 Jul 2026 14:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784298893;
	bh=KyQzh9cAgWHiv+f51XfecFAFsLqN9MeOR+zzeRidaFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bmloB99Ybx1WKgtIc+yxyRNZ4NVfaVa99uMGlmbik1P6sKwLzzUKxIgu2TG7hBFGt
	 b7LMPjVozz0aZO5ICLqo1dC4+SHxox5Psc1/35wBHfgOelF9IiBkCrNr4DLLXat385
	 JbLTB6ejQXMC1x0uNT/Vta7tNeePtD7wpZ4433zw6NochFM0OsU1ZrkTnLthIGXnY0
	 afENsGXcK2SmtGyIAhqITzppKGuXMhYWRV3mHtdjKhwGOFnrMpfJjl/ge439/BwRXg
	 vnLNrWh1dCNWKiy765pLRjX9qCXndU8tRfbhDUyx51IOHtATOwyMEJdW2Dqrz2fYMd
	 PyRkMzt54ATXA==
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
Subject: [RFC PATCH v1.1 2/7] mm/damon/core-kunit: check region count before testing in split_at()
Date: Fri, 17 Jul 2026 07:34:39 -0700
Message-ID: <20260717143445.91207-3-sj@kernel.org>
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
