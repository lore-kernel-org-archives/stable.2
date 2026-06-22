Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8F33B7B7D;
	Mon, 22 Jun 2026 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782137442; cv=none; b=aGarQAdn8WV21YJT+8PdT49mZ86AGnCOoW6XOiSXNEl26hk3lk1c6UMiBNStggBsexgsDptybpyQ2FUSyJ7V+FozvuHgxeio/ieGuThGdWgeqtL8fVaqHQ5Wb4fhBET+AJx6Um3npjnwrBy7UDfcQeIFbdglHg/xe4EyhgxSv2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782137442; c=relaxed/simple;
	bh=OOUNiPc0YFi3U6tqHjBq24RtvvXF3rGtt39m2q5mqRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSI5aPF3snRPSKbjhT4Fo/Olgwg9edzte2tzUYQQ3hOriGSCgsDkm8hOEKwctA5d7wn0KMV1F0v2/glGnRRJ0hPqvXTNW/ZjmxBe71GljqQv/i8yTTv68NNvSCqqlBXudLOOwcJka9YnL2JNI7/FDh4ps8C5kch5KBpcehBIFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcv08X6g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcv08X6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7891F000E9;
	Mon, 22 Jun 2026 14:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782137441;
	bh=J9rAqV+BtrJJS3bA6hXAT31xn9dA5LK7yhOjyVOIFTU=;
	h=From:To:Cc:Subject:Date;
	b=gcv08X6g+i3LbrmFn2qQmBt8NVRzGcb4Q8CY7KbQ/jd26MwiQqtKCDJ/rcrAupG35
	 Qq6NQ33NLOmy/DVUyS4OXRoHQweV8dgowskar4kXyD4fWUgO3rdjPqw8CaqM5SVsSo
	 YCq3PHQFmNpv40lgnjtlGKkUgKp6V8ltuADGJEg3r8XERIm1snV0mzCmq63/PW4/eL
	 hrenBujrrOs/KW5WQSSBQlPXPccbyVaW2vtpKSe2bMxLdw8sHSND3ZNlbexQVOC2Pc
	 s+8ys4Qd9W/7bVWJBmjWVhG7GfLFDljJZczYkahTJQLpUv4ku/Xbs/wIBssdVu/skW
	 3IvOnE+NNA8mw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 0/2] mm/damon: handle zero {sample,aggr} intervals for DAMOS quota score
Date: Mon, 22 Jun 2026 07:10:23 -0700
Message-ID: <20260622141027.29145-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the intervals are zero, divide-by-zero can happen during DAMOS
quota score calculation.  Fixing it alone enables out-of-bound array
access.  Fix those.

Changes from v1
- v1: https://lore.kernel.org/20260621154808.86431-1-sj@kernel.org
- Add out-of-bound array access bug fix as patch 2.
- Add the RFC tag again.
Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260620171413.89555-1-sj@kernel.org
- Wordsmith commit message.
- Drop RFC tag.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260619205144.150664-1-sj@kernel.org
- Handle zero aggr_interval case.

SeongJae Park (2):
  mm/damon/core: handle zero intervals in damon_max_nr_accesses()
  mm/damon/ops-common: prevent >DAMON_MAX_SUBSCORE freq_subscore

 include/linux/damon.h | 8 ++++++--
 mm/damon/ops-common.c | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)


base-commit: 42306d32afd75f28e3f13a1259c3b52191b4ff2c
-- 
2.47.3
