Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB604C92;
	Sat, 18 Jul 2026 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784333685; cv=none; b=HoFxAA8kt+j/oNOmyD+QS8b/iY10qdQjKAOJdDkJd8N7V/7/5P74zXi4GZMFkAO/GTQC9RayQ7S7ktbz0WHn5PDm7TrLoPf5I7JRxvhu80gIjzv83pgX6aj2IthQJxOdqjFXhVzVCN49fjWo4nkH5/n0D98zFDzAqXJIashijjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784333685; c=relaxed/simple;
	bh=3448GkA1t6Jl6X21pfqGd/NvX+4HQAakoG2dBo3KndQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n7DMgu+7ftBy70C9Bq8QlMehbxOWNxaf2cYBgIVEc0NnSGS1nBO5H0pFXlhQU4dizynAf+I5dA9jeAaqS+l5JmxhzqhF1UcZ6tP/DbYI3w9s2MRhzcl+0rXHnTtSwu/LCB4oqNUCbpJLQq8Ugf8h6eAH+/bOGfvvCyqx0nW3Fy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYGnmLe4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYGnmLe4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209751F000E9;
	Sat, 18 Jul 2026 00:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784333684;
	bh=C59WxJAx9LrXUNDaNGJL5jVA+tsD6SkqhBTrog+cChA=;
	h=From:To:Cc:Subject:Date;
	b=aYGnmLe4GTa1XTkI3KjkuzAlDHG2WXvP/qtcnwrbqJHj5X8E5ODcXjEZh1HOmN02b
	 wHawkjJwEa7LwqPithsVfBy6DG/TxZkgtOwHjHcofj841fcp50GRRHcV698lkdzv/q
	 rQqG/HOOztBgMbHkzZEb/NOLst5V7yFarDCkJxkFYUZ1OGoMrTvUEbuPsdLadhMkHd
	 s7CGmR7xuZKbldqLrRe3VZoH0/ZVv2vL7cajP60L3asB78KNocXYQeBuBDVukm8aol
	 uiKSYYYn0QIIixb1+GAuULmHtnUycSo/Sih5xfXeY3TowhyAD7YRvQVdtrcGyqaUsZ
	 33hONYUS3r3SQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	SeongJae Park <sjpark@amazon.de>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/7] mm/damon: fix uninitialized DAMOS field and kunit exec expectation bugs
Date: Fri, 17 Jul 2026 17:14:34 -0700
Message-ID: <20260718001442.87129-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a few Sashiko-found unurgent bugs.  Patch 1 fixes use of
uninitialized damos->last_applied field.  Patches 2-7 fix DAMON kunit
tests that do invalid memory access under test failures.

The bugs are better to be fixed and eventually merged into stable@
kernel.  That said, the fixes are arguably not urgent.  Patch 1 only
introduces negligible DAMOS efficiency degradation in occasional
cases.  Kunit fixes could introduce quite bad consequences but those
are test code that affect only test run setups.

Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260717143445.91207-1-sj@kernel.org
- Drop RFC.
Changes from RFC
- RFC: https://lore.kernel.org/20260717003022.119437-1-sj@kernel.org
  (Was not having RFC tag on the subject by a mistake)
- Add missed region split failure check in filter_out() test.
- Rebase to latest mm-new.

SJ Park (7):
  mm/damon/core: initialize damos->last_applied
  mm/damon/core-kunit: check region count before testing in split_at()
  mm/damon/vaddr-kunit: check region count in three_regions test
  mm/damon/core-kunit: handle region split failure in filter_out()
  mm/damon/core-kunit: skip wrong dest walk in commit_dests_for()
  mm/damon/core-kunit: skip wrong quota goal walk in
    commit_quota_goals()
  mm/damon/core-kunit: skip wrong region walk in commit_target_regions()

 mm/damon/core.c              |  1 +
 mm/damon/tests/core-kunit.h  | 30 ++++++++++++++++++++++++++++--
 mm/damon/tests/vaddr-kunit.h |  5 +++++
 3 files changed, 34 insertions(+), 2 deletions(-)


base-commit: 6bb81496f18939ccbc5f16840d5b2cf1af6c995e
-- 
2.47.3
