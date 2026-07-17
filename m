Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91DF429CFB;
	Fri, 17 Jul 2026 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784298893; cv=none; b=NqnVTFtZ1w4lKs7cnRrR0s47attiJLS9IH92Ook0BBS+/wGKJaBWoHhjx4zqlGKtPogvn8T5jOWLmlxN35fibg83aMIhL+ncs92wj36qLAn4DGjeH2lCCcjiUQB9tXNj9/Kip6A3uLsRWASBC/aNgQZffdjwqDFVPYBbyk50Rfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784298893; c=relaxed/simple;
	bh=tAXZEgU4HeB5T1vrBF2X2eHVAxmAbOuRpIDg8ZB/6b0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rNgx4AzIb+ZMVA2gXxHhVTax8DUMz1ZSJhwJ/Py7+ByVvv6kugbDhfc6G0oTb6VR2/G1aTa5ETtPFc4K97Or1YBeqd7FwT/RkpYPGakKblhoZel4elbOwY7SZut0Ey6SBULCYKtFtG2jM4SmSey4BvvPScBQJRWUE4PFEU7yEf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTRec0dP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTRec0dP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B26E1F000E9;
	Fri, 17 Jul 2026 14:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784298892;
	bh=A/mmTeERdzSAVoQzcIz3XDmSQeXAl6NdcuOV37Pow6A=;
	h=From:To:Cc:Subject:Date;
	b=VTRec0dPg80nAAyIMFhmHkd5UkN6eOfRhFAMEakqLgiQ2cXKlsP82+lq1yYOUblJN
	 4Mhpo/I8BzTBnby2y7JTcHjSyA1biNes2vjvAT+7M0AbkiWGQ96YczjNB3JQ5Y55ke
	 /rsW9SheDsdKcCVb3tQUzs1IA2BiBGg4Jj6x+KTL/SvHNlmmlOt5iVe5bZ3lgJyJLZ
	 VYngAbFVxR2B6n2TzgwTmZoF4bi5nUnHkyFxI6UZxZSYhzprteTlAEhshnLNC+3sjh
	 m8bIGyOw6bGq6s/egfMSAbkzoa/7dwj24XMatAKdmhK5io0HwuupNUG0blI49vBN4h
	 2X45gKJ2I/I8g==
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
Subject: [RFC PATCH v1.1 0/7] mm/damon: fix uninitialized DAMOS field and kunit exec expectation bugs
Date: Fri, 17 Jul 2026 07:34:37 -0700
Message-ID: <20260717143445.91207-1-sj@kernel.org>
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

Changes from RFC
- RFC: https://lore.kernel.org/20260717003022.119437-1-sj@kernel.org
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


base-commit: 0ad94b65c75dc6c6c3fa742f0a6213ed578c771a
-- 
2.47.3
