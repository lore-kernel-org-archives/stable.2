Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B6733BBC0;
	Tue, 14 Jul 2026 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037161; cv=none; b=TWWq/suevW5EhpN6ycE4Jjq+CDC6Pi5wvq71eDOv3zvC8l+Ycpam8eIil99zUTtFhohkRDSstyoy04UXDylXxNA5NxXHxDmY68B/QYY1c7v8DVWnENpttS5ot4uxDV+N5RaA+OuV0VcUbCGnmhR0liREylQpdXSVQjJa6kkqAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037161; c=relaxed/simple;
	bh=sqe+5u2N1kXnS6cszHDs7ETVGganvxQMd5Lvm1u2Ruo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rhotn6gTfJQz7D4GKHGaJDIz1N/iQURBPCbFy2xqdvmbQYK531HZYt1mzoPFpn3kll5P+DKGSgQ51UkDIBbGROGDuwA+qwtuX3R/gjXPC2x+RotMB0QahYhbUDA4d/57npVknOC4XvMCKEHAMwkOOk1G9eAoJZX+yx/XHfRkh8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AP6xYBIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AP6xYBIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78341F000E9;
	Tue, 14 Jul 2026 13:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037160;
	bh=jjskXBnVaUyXXYcnlZnqyVF8f035p6ceF7P+7PjCvJw=;
	h=From:To:Cc:Subject:Date;
	b=AP6xYBIt+ngQ5f2uJQXzbHbTwF1QdRUmts7VqVey0zvhy7l7Bqzfs7Mv5f1Ar8prc
	 lY8fe7ehEjlSQvWVnDTcHw9d2pRNM0DcnrErXSIfB1yrCi0WCYn7AtHVemQOrFxqZi
	 +DCiRfp9a2V4fgRxJawmpNheBzQfO/jy85c7mLYTkKof2ytKqp5ikvHXrhdQFTyC2S
	 crwadMUvqebK5GrLXDWrc8pUFU7Ldo4r+D6qMjWNkdqqFEy7FhBWzqwykV0AqEt5tY
	 8avdoWxJtKOKY2vb12l3doaZiYWiNNImeZTlnGoNwfhM2GBEsKHkju6FNytz0yePCE
	 u12yXtdVwwziQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
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
Subject: [PATCH 0/5] mm/damon: unurgent fixes for infinite loop, NULL de-ref and races
Date: Tue, 14 Jul 2026 06:52:28 -0700
Message-ID: <20260714135236.92699-1-sj@kernel.org>
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

Changes from RFC v1.2
- RFC v1.2: https://lore.kernel.org/20260713135838.32730-1-sj@kernel.org
- Drop RFC tag.
- Rebase to latest mm-new.
Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260712170328.91144-1-sj@kernel.org
- Remove same_target param from __damon_va_check_access().
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
 mm/damon/vaddr.c            | 33 ++++++---------------------------
 5 files changed, 26 insertions(+), 49 deletions(-)


base-commit: 93cecef8d85fe01bc004e07591501e85c132b343
-- 
2.47.3
