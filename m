Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F4FEACD;
	Sun, 12 Jul 2026 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783875820; cv=none; b=KOP5EDYOVF7kevTQJCEP6FFvVwBGGWV3c7aGO06ZyYhuFchvPrFjTng24rjf0GdCeFW3YQswkjDfbu+VgYarWbrfMiA3j6wJd2iNo2iAA9J7YRpLOQpCsE4llKeZUGb6xeUsCVDgIE4XBuJRtzGe2r6aQ2F5lHGTB/guS7vB2Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783875820; c=relaxed/simple;
	bh=lKaWi+20BOmLoPajgqIaqRve11K4Tne/sbx0HkpztWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucniy+VOnDR21rA32IesgoFsrCu5a4er0GhKqmqGkODl6K1PWdDH24DG3/anUlIjoiYx5D7qplWgNDkEvbc2RXf2XpMDs+DdWQbps2LyqkApI/ZTSi/OJ1xV+cTph9xcEla7VFPBSgfZoh+RvXb2fjnjQu9C4AXWawaKXI+6bsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPADvE44; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPADvE44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505A81F000E9;
	Sun, 12 Jul 2026 17:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783875818;
	bh=b6Hje91CDtF95cA1GOS8FiqBgZ9D0LGrk6SOQDgcIRA=;
	h=From:To:Cc:Subject:Date;
	b=DPADvE44OdGjcfTQ/fQBi4gUAEwzjHBOqoGlpFqaw13QV/7IKHEMRAwEgDomyjuDN
	 Yj7OoSXF+QkhqjwJ23cWxn+yMSVUCgvdhO24kOgWUCVRaQLeEA6pE3XAbjYfQmQ5+l
	 RSRvqAwR0TSRQhXIn1AlmiG54MAOnjGhNmXBQgFNLgrfbEqeF8FHLFLiEL7rZorx8n
	 otDZkK2LjgPDstNoG0jQGvB5S0XW33BH57GkZicrXvT3HyR+UkTX8cbRDCKU/scJ3q
	 IQKT7RcEdLS6yMLqpdavfBZ/0U0RubpyKG3Ra88sk3kdVMqT7+K8MVYG5U/cprbNjV
	 AucIoElM6yn1g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	SeongJae Park <sjpark@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 0/5] mm/damon: unurgent fixes for infinite loop, NULL de-ref and races
Date: Sun, 12 Jul 2026 10:03:22 -0700
Message-ID: <20260712170328.91144-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko found a few issues in DAMON that could cause infinite loop, NULL
dereference and monitoring results degradation.  The first two sounds
scary but the infinite loop happens only under unreasonable user setup.
The NULL dereference is only in a unit test.  Monitoring results
degradation is trivial since it is only best-effort, and those happens
from only unlikely races.  Still those are bugs that better to fix if
possible. Fix those.

Changes from RFC
- RFC: https://lore.kernel.org/20260711180409.82093-1-sj@kernel.org
- Rebase to mm-new.

SJ Park (5):
  mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
  mm/damon/tests/core-kunit: catch test failure in
    test_merge_regions_of()
  mm/damon/vaddr: drop last same folio access check optimization
  mm/damon/paddr: drop last same folio access check reuse optimization
  mm/damon/sysfs: read ops_id only once

 mm/damon/core.c             | 13 +++++++++----
 mm/damon/paddr.c            | 20 ++++----------------
 mm/damon/sysfs.c            |  6 ++++--
 mm/damon/tests/core-kunit.h |  3 +++
 mm/damon/vaddr.c            | 26 ++++----------------------
 5 files changed, 24 insertions(+), 44 deletions(-)


base-commit: df701015aac3c13b1ecff311fda1a2ada2b9c1b2
-- 
2.47.3
