Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8159815E5BB;
	Sat, 18 Jul 2026 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784333688; cv=none; b=e00GuLrabFD1XBqQ8ds/uGXtOYKt2quTLBgcyWCrfa94E7LmbyhDLnOoI0gLr44L7WG/ODJTeUGBsgbLfk89CXI/3eMIObs5+xSwp1ndtp0cDaCjsdwklE7TanjQum74vKQc5AXY7H3fK3sHPhA+ahdN/vdAC81zh11SuGlG60I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784333688; c=relaxed/simple;
	bh=/06b+9vkLyMtIlYwJJ5CAsugFD9d6Cp+S7GNYmLUxDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oj9uVijRLPOMpeeJxvdNhLqy+k5IrQT0rEfACNWkpRwBGMHRAAUcbop9CLiTzhtyQ36IBbgL7Vgka1YrAz4euDmaMdYWYpExAaGKsxmTnaM+0LEckC1aJMOq/3TVrYFsOuLG4LPNdIdKVxbCMicFRycwvB9HHpKacmOnkaVreBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdUsS8ZX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdUsS8ZX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCE41F00A3E;
	Sat, 18 Jul 2026 00:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784333687;
	bh=+jhCayPhKdoEPi4hYEuWhN+ktJFpA3DV4gThbyJ2nDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bdUsS8ZXnttW3GnYu1ABomdOLnq+jg3jHJG/BCjbz4e748+3cYBwH8weP9YAFgIyR
	 U2pqINgBD41IX6f5UdR20qv0wC/DOPgKXgff1L7470+Stu+Jc/SPTu8SJXP2ADT8pw
	 7uU6q+UBncqf2/DSD5oB03y+AH9dJzznTdQNLNKsFy5Euz+D4cJyPWfFRGaTN9kY91
	 4OCRKPWi+mAHicPo21tfSdOT2FFCmAh0UgnnR+rtGogBG1PuJUMafsYiqK5R3528EU
	 BQ4+6Z+DEorzNYkl2gc9MlfR/WwmasRXOVi9mKN2pJMKwe97lIvzdSB+mcq1xIUv+x
	 6pCYOmjLZgH1A==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/7] mm/damon/core-kunit: skip wrong quota goal walk in commit_quota_goals()
Date: Fri, 17 Jul 2026 17:14:40 -0700
Message-ID: <20260718001442.87129-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260718001442.87129-1-sj@kernel.org>
References: <20260718001442.87129-1-sj@kernel.org>
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
