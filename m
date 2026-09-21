Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FE14A9D77;
	Mon, 21 Sep 2026 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004291; cv=none; b=Q1ls4bPI+MsKavPYmVfh1lZygyhGgRrdHKrlIlAcAbJcphBJ2HjHOULwTLCP1mjhZn5k0kJ2zWw4l9LUuGPIKPMAaPMwJycdYqw0Z6GDx37dKFnLsqSF36xncd4g53jLFE661e8jmGGg8d8lLVo9P/GsOH4UJrE1mZpR5SvyCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004291; c=relaxed/simple;
	bh=f6I4WeCmZX89GJdBEjger/KVPZXPw4NsJbEIF+v27P0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kPkrpqkBBg1bXoCxsN9Rm+Au61LyPfoJgpteqjqYTB6VR6F3D1T8dKG92YHNE3tlAW/ygD/kXwKNdeMl1wa9Y3gwyqofZmJjTxTe8Boxq6xtKPmT84W3rfn9zNpE7B7YFeLUY7QAMsxP4xp5Pf5hM4kwxdIYWTSKZnXf8VV0mf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uit04d0B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uit04d0B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDD31F000FF;
	Mon, 21 Sep 2026 15:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790004289;
	bh=rUSSPwGcAFQsl4uxClmz1BHLPOEerDOJfABfBbj2O6Q=;
	h=From:To:Cc:Subject:Date;
	b=Uit04d0BaHB0QLpCm5HJdlTak0t1YoY4/xH3Lzgvgynh6BUyis4NjWl5WTohjBs4P
	 dCjww5Eqw4wnwWNvwkcXrJu7u3FBH5S028rYTy0+86Wmgg0PUE5bj2s1P2Ulo9jhRB
	 NkWJjUa5sREFmplUXaboN9o5MnbxKueMAr20VKKttkRCgH91hPk8iYRI9ghyBoftSh
	 kw8kxTB31IwKGUVQ9SkPBYmceZBNkkQjjRFyIwgXrshwmprapOuUaLfUnS/Q084lDG
	 7OvVZkyhgXbrOPMAhJV9L5fo2XtJkqcQ+Mkt2XS5xFHOKtxIBsvS5RAuQQ+yOTDGyy
	 CP+Po3RC75LBA==
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
Subject: [PATCH v2 0/2] mm/damon/core: fix the size charged for a filter-trimmed region
Date: Mon, 21 Sep 2026 08:24:40 -0700
Message-ID: <20260921152443.80132-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

An address range DAMOS filter that partially overlaps a monitoring region
splits it, so the scheme action reaches only one side of the boundary.
damos_apply_scheme() reads the region size before that split and never
re-reads it, so the quota charge and schemes/<S>/stats/sz_tried account for
the whole original region.

Patch 1 re-reads the size after the core filters have run.  Patch 2 adds
KUnit coverage for what the function charges and reports, for the trimmed
cases and for the cases that must not change.

Changes from v1
- v1: https://lore.kernel.org/20260917003553.2465523-1-donggeunyoo.kernel@gmail.com
- Add user impact clarification to patch 1.
- Collec R-b: from SJ.
- Rebase to the latest mm-new.

Donggeun Yoo (2):
  mm/damon/core: charge only the part of a region the filter left
  mm/damon/tests/core-kunit: test the size charged for a filter-trimmed
    region

 mm/damon/core.c             |   1 +
 mm/damon/tests/core-kunit.h | 316 ++++++++++++++++++++++++++++++++++++
 2 files changed, 317 insertions(+)


base-commit: 99528f68cc4066167e5e7135c1172be1e6315102
-- 
2.47.3
