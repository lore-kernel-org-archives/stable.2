Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D80481648;
	Mon, 28 Sep 2026 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585303; cv=none; b=RTt0d64Zm++tH5wAQPgXyf3bIK+Y3GeaMtCJ/zdAuJ8NWp/wddt+CFBsaXxEu4VtUhcJHINaaFTD6r6hOI0IVQNuIKR8EpAoM0zFHOnVfkmDhFqEStk1fv/mtHdH4rDAZywjaaQxpIuQPuPPF6nHIQZSOPsxnQUzfIjZjoA7mIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585303; c=relaxed/simple;
	bh=X9hpWD/8au3zSMoad2aznIEfJeIMxtia6g6FOjrIjK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yw0hmU4OE7A+mpsumhYTyD9+1axGIdjixc1s1YRD2CuLL+SSRmim7OZF0r0xkkKWAF6PR9w5+5iSlVeJJTGPLEHAxDo93EymLo2Do7GcN6W9HCPsz0etDu8J3H0aDECQoVhyI73jwxawisK/gSzExxZKuvEKGusBRt6bGNvdMe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHumC8vX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHumC8vX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335E21F000FF;
	Mon, 28 Sep 2026 08:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585301;
	bh=NBdiz7HaIMQ0kv1HYgvd7Hd/nQ/wzhey31vNxMDWYvY=;
	h=From:To:Cc:Subject:Date;
	b=ZHumC8vXAhibmcN/uapBiw/qdKiYPrCEPDB59apHbTjT1y4+gdEUwpI0g/KuA/TX/
	 8nP6OHJNlHhwI4O9/fg69dqQyLa5cgfawO19hUkbhOrYFQn910zW7/KcFIhIVhDFSt
	 QgI7nvhie651Okgyb58Hg/LV0zXyzubmkSAXhWmFO8Y/5ocJn3HwTfud4+G7nsG5Xh
	 tPlzeyrWbXjXtksnFY2M5eIOG6BIdG3eR1bVR6l3WUfIz9CIIlk0/zrrA5JXHFihiI
	 sVNNxy3rs9d1eD+Sdu1nkWOuVvGOCVHzhE45A5A289T2yW4Pe6A4595QhorQdrrQeK
	 NWJWvJF281HxQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v5 0/2] mm/damon: fix the temporal goal tuner's size quota conversion
Date: Mon, 28 Sep 2026 01:48:13 -0700
Message-ID: <20260928084816.5575-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

damos_goal_tune_esz_bp_temporal() hands the size quota to
damos_set_effective_quota() through quota->esz_bp in basis points, and
the multiply that gets it there is unchecked.  On 32-bit it wraps above
429496 bytes, and a wrapped product below 10000 divides to a zero
effective quota.  damos_quota_is_full() is then true on the first test
of every charge window, so the scheme makes no progress for as long as
the goal is unachieved.

Patch 1 bounds the conversion.  Patch 2 pins the boundary in the core
kunit suite, where the new test would fail without patch 1 on any word
size.

Changes in v5
- v4: https://lore.kernel.org/20260923002600.1825448-1-donggeunyoo.kernel@gmail.com
- Collec R-b: from SJ for patch 1.
- Rebase to the latest mm-new.
Changes in v4, from SJ Park's review of v2; the code is unchanged:
- patch 1: drop the 256 MiB mention
- patch 1: say what the user sees before saying the setup is unlikely
- patch 1: cut the closing paragraph to "Bound the multiply."
- patch 2: unchanged, and carries the Reviewed-by
v3: https://lore.kernel.org/damon/20260920122411.610213-1-donggeunyoo.kernel@gmail.com/
v2: https://lore.kernel.org/damon/20260920023111.2466265-1-donggeunyoo.kernel@gmail.com/

v3 was posted before the discussion on v2 had finished.  My mistake;
this version was held until the thread settled.

DAMON kunit on x86_64: 39 tests, all passing with both patches; 38
passing and damos_test_esz_goal_temporal failing with patch 2 alone.

Donggeun Yoo (2):
  mm/damon/core: prevent size quota overflow in the temporal goal tuner
  mm/damon/tests/core-kunit: test the temporal tuner's size quota
    conversion

 mm/damon/core.c             |  2 +-
 mm/damon/tests/core-kunit.h | 48 +++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)


base-commit: 2fbc36fcb37d79b22b904066065952050a7ea307
-- 
2.47.3
