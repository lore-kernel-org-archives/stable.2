Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34AD24E4B5;
	Fri, 17 Jul 2026 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784248236; cv=none; b=k5mTaeTlb3efpgF7wAu1B4+ZgjPcHtm3JuI9p5HmQSZvAi6Y5IE3pPbzr4yazKFhu2oeLtWgj893BmImzkiwQ6BETn+S9oXXhewhWFu9cA6GUmOfvuZb3gIiJKKw7Gh52Or2X5tOewB5dvnuequ6BPnViZWo4xLIaTR9hEfY7Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784248236; c=relaxed/simple;
	bh=GbtijrXS/fJksQBpv1ckRL+HADLq3+tvv+Z07G1PhJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0ZGFIR1ZzGRLKsMh7gBVfAykK2cFjiAIA7e3+WDZeviM/0GVVLRU7tDhHZShx+IrAGghUHBnYN4NQ2nR+8bYbVPzOasGqWvjYr5e1N3jKftuFcbOwvOfLSaIsHYhev23uXbmkXT+/6XTgP3R0kTTdzudNKQUSEvmdgxBuZfZ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb0lKWnj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb0lKWnj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486031F00A3D;
	Fri, 17 Jul 2026 00:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784248234;
	bh=bm88riwVWukBM9Hpj1tl+kCGJPZuHznDRrppgwqi3X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fb0lKWnjC7Lhue4mwWOJ3RaPskTLAAMn9qqA+kBPqmElzRq20exd/6JHMh/NhsoS/
	 CGp0Mi9k6iFwW0p+TjGqvMaGUMl4Nkv33jeh8pZnlvQFAvPGZC8mlU3iMR3CluiwFv
	 fr6Sz/AMrTcxsGfQa4mXnC3/kkwIfoj2m1j+B1yq4+Y9Xw3/1uO1txgfxwHQZRzXXq
	 BbzzzmILhLFqz60w9/7H0IMjC800EajT13tq0ny+KqU5uOsJuIObjf3pZ8DtM9bbg5
	 ihYJl8mIYnssBcN+NL9A8ITLcAnsCReeYAfrR5YXQi1Axq6pdvA6JBe2rPoFFd4j6p
	 vJYWkATu5BJ6w==
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
Subject: [PATCH 6/7] mm/damon/core-kunit: skip wrong quota goal walk in commit_quota_goals()
Date: Thu, 16 Jul 2026 17:30:20 -0700
Message-ID: <20260717003022.119437-7-sj@kernel.org>
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
index ca6ac12a15b24..c0fc903a6a259 100644
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
