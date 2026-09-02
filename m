Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1614A2F3C18;
	Wed,  2 Sep 2026 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308854; cv=none; b=Fn7JN+vNJc5faj39zwJKPPstYzhmyqnNw2EF6UgLquJTYruGncnsItF8SzFlDSbZoj1qAupKJCXhehb2dXLGvVGN4zGJTtFkj7R6HcoE4dGqYvyvDf3AQIwdiGryp098JLSttKCjNgYMPVri5v3mzAoHjn5Y8dTOq1KWJJa+VRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308854; c=relaxed/simple;
	bh=h7vbIGIL6lvt6pBf3n2A0mwhmnGmbEsny/1B7JAVAkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZk8/xQzQbyT61HxB97XmbMLLOst5hLlQh7sgDHA7l2REzRUfOuUmkWMkctRMJlQ7yttIDrN+fBe8pqU7RNtboiebTg8ZymBMzEqC8w/6h96lsb8nQqJ2JlGaaS1YdVQQkog10RUZmFymhAHGZaqRMgY8zhp8o37qatPnBdJMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQUO+4NY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQUO+4NY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EA51F000E9;
	Wed,  2 Sep 2026 00:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788308852;
	bh=mbv8WxNYdZDCGISix1qH3K9oOQ8RMlyWgnMJQvHMmG0=;
	h=From:To:Cc:Subject:Date;
	b=RQUO+4NY2VU3f7MNQJs8O/9NYJxF9+lIgXvdVprklDTns8sq8MmOsoSniUPJJztqq
	 4X1/Vc1U9JgKmYoaVlRiTv+PmW3UbUPwwFR14cDhoqecuF4tC6GnL+MSJby5amyds3
	 Ro82wNH3VUssbS6IUR4QLeFk+xBekhw+ggsZbACziDlfrmMGWgd/tHH0SbacZYkMVT
	 MAMYjgj2elCLpXQZDsvpnZArX+8c0FYZrBrJwfpLvLZrahdx+Det0POhB5WtmEQC/I
	 GjC5jVmpWcCO25rvpfs0az9XePaeeMYhcI06XaTkNAa1XkuK/Wtkotj6MMXwZU1Nk4
	 bVuobnP1ICHng==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/4] mm/damon: fix misc bugs in kunit, quota goals and sysfs refresh_ms
Date: Tue,  1 Sep 2026 17:27:19 -0700
Message-ID: <20260902002725.108635-1-sj@kernel.org>
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

Changes from RFC v1.3
- RFC v1.3: https://lore.kernel.org/20260828183649.71192-1-sj@kernel.org
- Drop RFC tag.
- Rebase to latest mm-new.
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


base-commit: ee125db0b1f24a2f6b04e3143ffe1a14324176fe
-- 
2.47.3
