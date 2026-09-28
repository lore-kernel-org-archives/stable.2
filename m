Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCC2364E89;
	Mon, 28 Sep 2026 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585923; cv=none; b=q8z6eZbHRmA8Tl7rPZdoeuG6wZog5kyjIE68/HPnPOtmkvFmLPsa5ChnFoW9rYPgcTZrFiKw4CFPKG3XWNa24gONa1suyJFXJq7AYemM3O2S7vIwjKjuJB/GmI41fFksAAc6qNPat/A+dvbrxF32miUWCrfx4U8fgG9hAliC0PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585923; c=relaxed/simple;
	bh=41GXnO9AcaWtEJEkMCaWzHi2unS5XNYEPSNT92WHJ38=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=poWIfQ5ps7n2AQqWDmC5q8TpMKPd+AOxWwTVr3G5newanQX23kRgpHgxYEgGUs45ko/mOLXBswjjFW4bCz6q2o8C/KHa/UrEwEKp+Xr7jGbNzr8Bidy5l3GBuNPgNTvCY8Ya6gtpom3yupaQa5yskNLwItoLfO5/2YNWzhDLYxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCC4hCff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCC4hCff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2581F000FF;
	Mon, 28 Sep 2026 08:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585921;
	bh=zRvkh9OOneOJqU2wdlUkVFuqM0bBnkKnmh6zryJNhBo=;
	h=From:To:Cc:Subject:Date;
	b=KCC4hCffLBTujGpfM0vlV61kHxmWeskmD3ttbzKJjZY2I+VEJPl5/cj2RW7iVcoc0
	 eVAd0MSWliugM0IG22R9sE/iFWlNFTKqYx1uVvHytkzrOV7mGA7jKwoXnf8SKsLJxX
	 GGUih1gIZGCQMvReXH5//OymbfyH3okQQ1mK5ADkDJkV+1W8fPjmsMQxrNtQXkl5F+
	 1s4KbS8sGm24J0M5nBhlFTjdg3DhDcSJQTzCdhjK2GKQpP2yPvQPxJ+VlsfaNwfmGY
	 rf00wrgn7Y7B/52hdoKo5rg5MF2hvvSBsxOwQHxOHoxBJZG4A6aMc4hWoEur2z/rg+
	 g7uZYPeeDljLA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Bijan Tabatabai <bijan311@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/2] mm/damon/core: preserve quota state when constructing schemes
Date: Mon, 28 Sep 2026 01:58:32 -0700
Message-ID: <20260928085835.7675-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karl Mehltretter <kmehltretter@gmail.com>

damon_commit_ctx() first commits the running context's parameters to a
temporary context for validating proposed updates. Constructing the
temporary schemes clears the running schemes' quota state because
damon_new_scheme() initializes the quota passed as a parameter before
copying it to the new scheme. Even an update later rejected with -EINVAL
loses the running quota state.

Initialize the new scheme's copy instead, and add KUnit tests for the
constructor and for accepted and rejected context updates.

Note: below are test results and changelogs that could be removed from
the final commit log.

In the v1 live test with damo, a scheme with a plain 64 KiB size quota and
a 60-second reset interval uses its quota, and a full "damo tune" with
unchanged parameters then lets it try another 64 KiB within the same
window. With the fix, sz_tried stays at 64 KiB.

KUnit was rerun after the rebase on x86-64 and i386. With only patch 2
applied, the two new tests fail. With the fix, all 46 DAMON KUnit tests
pass on both architectures.

The v1 DAMON selftests showed no new failures (QEMU TCG guest; the
wss_estimation test missed its accuracy bounds with and without the fix).

Changes from v2
- v2: https://lore.kernel.org/20260924201615.4478-1-kmehltretter@gmail.com
- Collect R-b: from SJ for patch 1.
- Rebase to latest mm-new.
- Add a note for starting point of test results and changelogs.
- Fix typos in patch 1: s/detault/default/ s/occationally/occasionally/.
- Update series subject prefix.
Changes from v1
- v1: https://lore.kernel.org/r/20260921003047.12041-1-kmehltretter@gmail.com/
- Collect SJ's Reviewed-by for patch 2.
- Explain the running-context validation in the opening paragraph.
- Clarify which quota is passed as a parameter and use "commit" for the
  context operation.
- Point Fixes to commit 60bd24f272d0 ("mm/damon/sysfs: test commit input
  against realistic destination"). Drop the redundant stable version
  comment.
- Rebase onto mm-new. No changes to the fix or test logic.

Karl Mehltretter (2):
  mm/damon/core: preserve the quota passed to damon_new_scheme()
  mm/damon/tests/core-kunit: test preservation of quota state

 mm/damon/core.c             |   6 +-
 mm/damon/tests/core-kunit.h | 107 ++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 3 deletions(-)


base-commit: 0fa0454423ab5bbe40db5783aab8ae29b40adf89
-- 
2.47.3
