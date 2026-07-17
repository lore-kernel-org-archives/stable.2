Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E63175A7E;
	Fri, 17 Jul 2026 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784248232; cv=none; b=dO8HWKUGBFy+aIC32VHHKyn+gWKLsmZIovQ328l1v3POvzuhbvnWqinwtW5AAa/hxkEzWnZy6rkMj3lQ3j+0n4egaNW0QXQYy16f5iL1PMWfxgMYzfzArF1wXa/hL/zcVEv1FypqAufFc+Pw1j+c9ITBqc1j12Jkn5zjQkzwqUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784248232; c=relaxed/simple;
	bh=bCQC2Q9MKCS3P93oZ/w9/HKpPdBZiG6cBaRE49rt4Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqeScimj/Hl5VFkJFszah1K7Nia0tNsiuZIyC2oubix7MKTwfSY+pgMoc24v9thsAY0m7zBCa+R2WWjdQfPbvt6K7WnYVpaiETR/HDPSw/N6FUHXT7cIW6DLNjPqgbFopM3C8UxF5EtuhT/9hQ4Hz//4x9aNjnaMuDpL2Vlykw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RuglQjDn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuglQjDn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3C11F000E9;
	Fri, 17 Jul 2026 00:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784248231;
	bh=xM5gDQraqqXBT37mFYIx8WuUHVtDjm2kQWuZX7uenPU=;
	h=From:To:Cc:Subject:Date;
	b=RuglQjDn3bYdgeg6ncYPVDXHbOj7ciTiM64J4RZbSLqjMtlMwvz7yMWrfYdvIeOm5
	 eFVRrwi8/McVixBoxsMIiXdjVOjlGsM0Y+Q1U3XRa7w6FWMExDLA04lNLgFrQrUO32
	 Xd7InuA11qiY1xvn82GQyp/+Jb1HXcYkfLhLdsIj0laRWtfP1M/NgMeZbqnbSUN2EC
	 +hWsHlRvOG92a7vu5kBIExeAVzDq8gPaD6TQpOfqzl1ELHDdVs9FivdGYlql5ATWFx
	 T4cNEgTzw7xp0YXRNQ+BpOZJ6LpLKlSH9a1Blg/OYlLMwfK0MZghXQ3PchL3oDcEQX
	 oA1Ovv72fRKgw==
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
Subject: [PATCH 0/7] mm/damon: fix uninitialized DAMOS field and kunit exec expectation bugs
Date: Thu, 16 Jul 2026 17:30:14 -0700
Message-ID: <20260717003022.119437-1-sj@kernel.org>
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
 mm/damon/tests/core-kunit.h  | 28 ++++++++++++++++++++++++++--
 mm/damon/tests/vaddr-kunit.h |  5 +++++
 3 files changed, 32 insertions(+), 2 deletions(-)


base-commit: 1ce4cbd62f48552188b3f6fac8a14b709e97b7be
-- 
2.47.3
