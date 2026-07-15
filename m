Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920B757EA;
	Wed, 15 Jul 2026 03:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784085013; cv=none; b=AYmLwX3VtLlfrVdsQjVabNlJ62A/cr+FocuBJPuAOFOgQLSsxT1lUvrV8xDSJE6AwqklCVsDjCnvcdX1gdTR6U5H1LyrB57c7p01/BUL6o7VMVkT7twf3VrE/BPmolopTnnwzidAEYAgSihg2hMt1iVRgCiSOCyVlcBHfn4t8D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784085013; c=relaxed/simple;
	bh=8FLrvyXbypcB7/NYujxfjOGZbZPVW048/ercppBGBe4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EU5VsiulFhJgowwqMsEBStX7mZKnBgxDWfO29N/ibzL5ArHC+RMVVOwFTxq2WNVxE6I5lLC2VO3tQw2jt2Edfh//QgbM4LlRJ6NGGMDpy68ZQkJkEivHeVX4vdIOVYX+t8pCIDWvrpdPmpc2/HoROHA4QIpK/u189uaEnjiXNAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N74Od/Ek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N74Od/Ek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2FC1F000E9;
	Wed, 15 Jul 2026 03:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784085012;
	bh=zX5F+4lmbeae1CeGb/wxT1HGr47P+pAaJ2W/OiCCHm8=;
	h=From:To:Cc:Subject:Date;
	b=N74Od/EkYRy+y+m8B+GCPqq9csaIQ4tdN+b70jJHtcQ6Ip5IN6BCNhhd8eM9oGIYR
	 2z7A7HDv7NksiEeb6yv5knT0aVbUNdvOJ4NusC7po080ymGjZRsNZ7Gd5baBh6F6nV
	 V1e6zzjHjGlhki4F8gLUEWX9NgbwNQjgKHRBmyuRJ5ajc7qjHdBhtJQg6y33Lw+2pJ
	 iWq0bIsk2Qu21W40SJX579OPlGhA8UfhYjaC10DcD6HOhGRgDBG2Zp+mpVR9aM3gb5
	 PZQIxBLd3cSMaXJauJC/xj6HWwS5jG9/oz/3UYd69n+/zlOIx7sIQVQ8JAINn6Qfos
	 OsjEzZF2G0xIQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	SeongJae Park <sjpark@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1 0/6] mm/damon: unurgent fixes for infinite loop, NULL de-ref and races
Date: Tue, 14 Jul 2026 20:09:55 -0700
Message-ID: <20260715031002.108504-1-sj@kernel.org>
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

Changes from v1
- v1: https://lore.kernel.org/20260714135236.92699-1-sj@kernel.org
- Add addr_unit race fix.
- Add Fixes: tags to the race fixes.
- Wordsmith subjects.
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

SJ Park (6):
  mm/damon/core: avoid infinite kdamond_merge_regions() internal loop
  mm/damon/tests/core-kunit: catch test failure in
    test_merge_regions_of()
  mm/damon/vaddr: drop last same folio access check optimization
  mm/damon/paddr: drop last same folio access check reuse optimization
  mm/damon/sysfs: read addr_unit only once in damon_sysfs_apply_inputs()
  mm/damon/sysfs: read ops_id only once in damon_sysfs_apply_inputs()

 mm/damon/core.c             | 13 +++++++++----
 mm/damon/paddr.c            | 20 ++++----------------
 mm/damon/sysfs.c            | 10 ++++++----
 mm/damon/tests/core-kunit.h |  3 +++
 mm/damon/vaddr.c            | 33 ++++++---------------------------
 5 files changed, 28 insertions(+), 51 deletions(-)


base-commit: 52d335d2c1de60b6184b9de5ecec634892a3e136
-- 
2.47.3
