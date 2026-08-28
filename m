Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A119F3BB13A;
	Fri, 28 Aug 2026 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787942219; cv=none; b=b2Tyn+8QHecsUBmxlibuHl+K5AMdzTrQhNmfDoh6cLj3011DZkN7GEPiZmnsZNi4Jq6ql55v0oG8m1POIPXCyq6s5I8sHWtclvd20PbzniOYjh/2qfm955aRtho78GsktWMIs1g/yx2Xr4oO+r/Wga2arnm21E0ZjGhL+6uCh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787942219; c=relaxed/simple;
	bh=azib5qmdquNd2rYQczqBEfZ5DW/32eNxHM8irj0UL7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hdL33eFKg5+f/ZRIS5Cd+65Rxgs5xLxPz9hkz4wBDtg6wrqwrh2THjkf8FX+SMyzzkvj041rwUTV7T9BqIjJYk9PuGZPo7+oIoUXhsi7r1ES0HQr/RoR5EkkFgpn2mVE8swsUvpXPPy/hnqYA7DEWTDWasDJ6zWUK3kZ0Hr28V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ak/3Q/dG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ak/3Q/dG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49D81F000E9;
	Fri, 28 Aug 2026 18:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787942218;
	bh=wZbtF0IHVGj7VJcq8IonnL74GjdUD1ZBdNt3Ged28Xw=;
	h=From:To:Cc:Subject:Date;
	b=ak/3Q/dGAKBDmSkWap5l35SOzKFLEL7ad8KlNOV8/qus+ORbN0o3Eaw794B3/ZXA4
	 9uxzrXajXpH/gcawEQ9zXo4uSa6VjDstLLamoq5Xjmp7rDpYkbWmq5hBouwJPPjrlQ
	 wMedPyS0sMLTn1Rct6RBb1thKvxCXtRosu08txyl6bZLuAzCoHv7m6sVf1yPFCgXXW
	 nqD2xXgfD6By09eH4rpsEgWH2YC8o+EwRHoYiHi2xeiMo4WfPR5P8y08FuhoJeuyu/
	 yuM8N3Sd99qM4pXHSykE9B61Og3/16vd3a7iCJ+/On2ruBHffA2O3hlkRnMtCZck+r
	 cMLJng3C+UxuQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.3 0/4] mm/damon: fix misc bugs in kunit, quota goals and sysfs refresh_ms
Date: Fri, 28 Aug 2026 11:36:44 -0700
Message-ID: <20260828183649.71192-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS quota goals commit unit test is mistakenly not testing a test case
that was designed to test.  DAMOS quota goals and DAMON sysfs refresh_ms
file have bugs that can produce non critical but still unexpected
behaviors.  Fix the bugs.

Patch 1 fixes the DAMOS quota goals commit unit test to cover a
mistakenly uncovered case.  Patches 2 and 3 fix the bugs in DAMOS PSI
goal initialization and eligible_mem_bp online commit, respectively.
Patch 4 fixes the bug in DAMON sysfs refresh_ms file handling.

Changes from RFC v1.2
- RFC v1.2: https://lore.kernel.org/20260828014659.121058-1-sj@kernel.org
- Fix last_psi_total underflow.
Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260827134429.123023-1-sj@kernel.org
- Fix quota goals commit unit test that was mistakenly missing a test case.
- Initialize last_psi_total as uninitialized at the beginning.
- Correct kunit test for changed last_psi_total initialization behavior.
Changes from RFC
- RFC: https://lore.kernel.org/20260827042920.93580-1-sj@kernel.org
  (Mistakenly missed RFC tag)
- Fix build error.
- Add eligible_mem_bp nid commit fix.

SJ Park (4):
  mm/damon/tests/core-kunit: test committing psi goal to psi goal
  mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
  mm/damon/core: copy nid for eligible_mem_bp damos quota goal commit
  mm/damon/sysfs: set next refresh jiffies per sysfs context

 mm/damon/core.c             | 16 ++++++++++++++--
 mm/damon/sysfs.c            | 11 +++++------
 mm/damon/tests/core-kunit.h | 16 ++++++++++------
 3 files changed, 29 insertions(+), 14 deletions(-)


base-commit: f508ed0a3bc67ac2a17ba4eaa7f219a95f6b3954
-- 
2.47.3
