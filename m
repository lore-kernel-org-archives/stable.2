Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03292437465;
	Mon, 13 Jul 2026 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951128; cv=none; b=Q3ufc94JJZdi3ITXqRrEFK+N9OC8XM3TifoTpZWIZoEkQfxHRwfpNDmAsGKIFegqtJtmm82IzlVn6LVkS2IjQ+PHsGrKOalS5EK9Mmez0pfNY8rU0ZlPg4OzZaJ6F1D1m/sQZGvgZOonBuLXtVTf2K93RfyV/meDTHF4hGZU7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951128; c=relaxed/simple;
	bh=NMKcm1pkCs64lfIHYa2THibb8WzHVI8aMRYFrV5tuv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c3gr9jE+00ENba2MuQL2IktcD7lu0GjIOyFphrELgsR9lSoY3I/j1ObITTh1uRYPWDHjY47ebruGVGiiBPSq+8BwFJLPmI2O/LYsqr7/BSknEsGak3FiVSFmkE83+FMF+X0vYcrgPgTFp8+9QUyMKlkE+tWWHiRNsCeuddtqxyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5R975aO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5R975aO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A171F00A3A;
	Mon, 13 Jul 2026 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951125;
	bh=kw48eNAzxFRXO6yZLVXQ5NvQIurCQHZvh9V8CBG541c=;
	h=From:To:Cc:Subject:Date;
	b=Y5R975aOCRLNoN4CCClsQVWkZ2zFMRMZznKjqildidyehZoUelNcs6ATVc3mjonKW
	 A18YnBR5cIur/f3whvlhNNuah1hRPblBSy1hd3uqGawgTIQFjpK+WXqn/lFZmdHfA2
	 hZEcSj/xhioRp4fTT47PJGTQHhCt1xIcGj91Jo1AhY21n675b+mlSokY3/0KnQNC1i
	 PlifB5A1j0TlHIPDT47wu/8VYo+584fQQ68909KnlC4UIHGc5BQ06b41eVdHz1xi7b
	 E7s5eufe1vv68EP5xHYuv3576UvvEuz4n1x4kIaCmpuFtoH7tt5JQutxxgYLpKfgCO
	 BRMhdprJ47juw==
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
Subject: [RFC PATCH v1.2 0/5] mm/damon: unurgent fixes for infinite loop, NULL de-ref and races
Date: Mon, 13 Jul 2026 06:58:31 -0700
Message-ID: <20260713135838.32730-1-sj@kernel.org>
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


base-commit: 9d192aa422c3f9c503a40e5eb98093df671accf8
-- 
2.47.3
