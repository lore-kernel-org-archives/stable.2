Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70393F105D;
	Fri, 28 Aug 2026 01:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881628; cv=none; b=gHiNt6EBDPemZH0jsbE1+rPqLtT8fx6YOgu/7vzhdYsPSzRWBnipB5/2pG5P9qS0Wi/UT3fYHBI6Tqg/ye05623cpW2pZYE8F1I7E6YxLkoiL93Iw9w2N37LdALy9O/BpWK6z+9fKQ/VsNkeiSFURlc2JrCNFKooVyc/2ycvruY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881628; c=relaxed/simple;
	bh=z16+4AlADTXIim2vspJwnwfTOHgUBAYpejuztOP0yro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ko6Cml5zMzf0y4b/bpWhooHNKNlLBqKAj7CwB60sMk4OuaHV+/cVbZ2wWNyRtcQ8ztZPPq+D2gPOl+MaUAU1ASpjBsTUE3QsKV3sPk9wATbK7HUKTg/VVCKbTFbzxT7cNrAALkb0DDJSB0t9Jb8otgztXfMHH1rgJuzVJWPrMIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFM1RiFj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFM1RiFj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1FD1F000E9;
	Fri, 28 Aug 2026 01:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881627;
	bh=jwAE0OKmOfKjtRIOtQSeb+A90V4Qlobxr/nJmHJ07Bs=;
	h=From:To:Cc:Subject:Date;
	b=DFM1RiFjlPKAiVHZKRyNpMjRnMZaU+0bhHwt8VgyM3ahTgyRwY86zfxDIC+qDlW0N
	 00plNta7loMbT82IqQpuFmLlXIba1+sdGnJjPp8Uyc0lgJ9BFR6jPbBYZNpgW/5e0d
	 gETy9US/QVDEA2/d2DSTU46c1TQrUQy/TtUBomkEwbF/T/xKc1+XmECIMSwkEqvhin
	 ZAUJaYnRKGTeW9EeuAJUOTtnD916AIKRGAfmxwrjHh05tkPVuOsaou9k9v536vVnBY
	 f/64bKivZ+k5SJSMQMrfF3EOChSx6UYF5CyYqqZIMoW5UnD1m1HBnprIVFpCx3B25C
	 GXlYBq7PJNS+A==
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
Subject: [RFC PATCH v1.2 0/4] mm/damon: fix misc bugs in kunit, quota goals and sysfs refresh_ms
Date: Thu, 27 Aug 2026 18:46:54 -0700
Message-ID: <20260828014659.121058-1-sj@kernel.org>
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

 mm/damon/core.c             | 13 ++++++++++++-
 mm/damon/sysfs.c            | 11 +++++------
 mm/damon/tests/core-kunit.h | 16 ++++++++++------
 3 files changed, 27 insertions(+), 13 deletions(-)


base-commit: 90e1725f175e19e191adc6e1b0f0317feeddd268
-- 
2.47.3
