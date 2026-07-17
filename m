Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F75642B337;
	Fri, 17 Jul 2026 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298897; cv=none; b=e5wUKKVdU74RtqRP7mJ9U1tfUqwsFIaxVfuRSWNAUGHqPcLqOAe9U44nZ+He8r6JVsTH/BAW8wuvurorUE/Rct+DDvya/XDXYUq8dkoPDGwhCjYerihDzMu6cInoElXCPy70CSkMkb+7rONYZ5bHCuA0z0Nwd8Veys5spEAU2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298897; c=relaxed/simple;
	bh=/06b+9vkLyMtIlYwJJ5CAsugFD9d6Cp+S7GNYmLUxDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKLwY7NEz8XRXAmTdhkfUlbvANeidAmoMICerBEKOkAzJhnAN86tWNkyvXnRGNyo5qIPnJIinQpt5vESt8AZgFEuYxeO1majphbVst5gKMcNAgfHT2Cp1XDwjng0huvAjonsLN96c/xPjeJhDXKvzolTKW6+jyFKlCIe6v8t+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mndZPh2a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mndZPh2a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2951F00A3E;
	Fri, 17 Jul 2026 14:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784298895;
	bh=+jhCayPhKdoEPi4hYEuWhN+ktJFpA3DV4gThbyJ2nDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mndZPh2aTUGOcNVi3fwU81/mclnJQsIzCc2t/4ib1q5L04yxf1/pEBkgLBHgvDm7w
	 7iRlFpsSgxEjL4DjMxixjgPlnXDNGZgdioe6JtUlujg67bPnVuHa+KgCj9uUZMVSjM
	 kPnC+n6zitVgYGxw3F1jGWbZqlnmemQxoA7g1FIxBZxX7FS9MBdyP1zctfRlgHReqR
	 mGvBqM5IrYquz9rP/d0QvnAMK5LLSdLtw7Bfygy1aU5R8nGvSMKm/60dT1NzoHcC6b
	 6w2J0XFioG9Nql2VbIbqNL9CT2FlMTonxIpkfkFxVJ++SXjGT7yjmcKhKLVqp1+33B
	 lHUWLF2aiIyEA==
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
Subject: [RFC PATCH v1.1 6/7] mm/damon/core-kunit: skip wrong quota goal walk in commit_quota_goals()
Date: Fri, 17 Jul 2026 07:34:43 -0700
Message-ID: <20260717143445.91207-7-sj@kernel.org>
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

damos_test_commit_quota_goals_for() traverses damos quota goals after
damos_commit_quota_goals() call.  It assumes damos_commit_quota_goals()
made expected numbers of goals.  It might not.  Because the traversal is
made based on destination struct length, it could do out of bounds
access for source expectation value array.

The consequent user impact (out-of-bound access ) is quite bad.  The
realistic user impact would be limited though.  It would affect only
test run setups.

Fix it by testing if the number of goals was also changed as expected
and exit early for the failure.

The issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org

Fixes: d9adfb8a28e7 ("mm/damon/tests/core-kunit: add damos_commit_quota_goals() test")
Cc: <stable@vger.kernel.org> # 6.19.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/tests/core-kunit.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 9b8c20a50ad53..fbf986aee2dea 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -839,6 +839,7 @@ static void damos_test_commit_quota_goals_for(struct kunit *test,
 	struct damos_quota_goal *goal, *next;
 	bool skip = true;
 	int i;
+	int nr_dst = 0, nr_src = 0;
 
 	INIT_LIST_HEAD(&dst.goals);
 	INIT_LIST_HEAD(&src.goals);
@@ -861,6 +862,14 @@ static void damos_test_commit_quota_goals_for(struct kunit *test,
 
 	damos_commit_quota_goals(&dst, &src);
 
+	damos_for_each_quota_goal(goal, &dst)
+		nr_dst++;
+	damos_for_each_quota_goal(goal, &src)
+		nr_src++;
+	KUNIT_EXPECT_EQ(test, nr_dst, nr_src);
+	if (nr_dst != nr_src)
+		goto out;
+
 	i = 0;
 	damos_for_each_quota_goal(goal, (&dst)) {
 		KUNIT_EXPECT_EQ(test, goal->metric, src_goals[i].metric);
-- 
2.47.3
