Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368437F316;
	Sat, 12 Sep 2026 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789240697; cv=none; b=q7VpJCbZRjNAGdgNNtohUEQaBHoPxQWv8f2Do8S2zbjrkjqDsl8gsCV3579A0AIQ0wpxOX4xlLlfDlx6t8dcwS8BmeAz/wAQ6+rjF+9GWgDRICfzP0Sw+90vEE1ZUoHz/vJ4kT7a7QLd22osEGxm1Xy+YCOqrajPVYudhVT/CQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789240697; c=relaxed/simple;
	bh=qxbwmdSBo1AepIKamHaGaUiYAH4RQkV7NDLZ2s1hytM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g4mHkC1x0rUR8xLioqdRBusQ8wuDBSplEjfsRU2s+V6OSXdzXJzs+c9QZlUBxxEC7o12ug6sMt9rxPBnRYRSI959g4tCXxZZclCUv1XHDz6aUeORh1WFSuAxz4pewGEUacS6P3Zr0Xq5rQ5CQcUKUbF5fro/+S7dAerTg+hgyYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou+P7NXI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou+P7NXI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E201F00893;
	Sat, 12 Sep 2026 19:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789240695;
	bh=vOYEln47T2FyN4vw1wuAHSZbTpeajPzH83Ujt47M+Zg=;
	h=From:To:Cc:Subject:Date;
	b=Ou+P7NXIJR/S+2iTvxe+RbilEBP2hV3MFAWs4vaegoABZ5ejRgcMjRRpmvU39AYq2
	 e09ZImxHjfuKCJwenOe1KRXV0WoMJuoUZuvGyRYkjqoIHUgqgSaTxeJo9IpKMzNvcT
	 UBZmB0rKSDjqQPIDQb6FQcXEv60mDWgpnX+12OOCrIAty9ENEIkC4whQI6D+1oVq5U
	 JszFjfGs06m+gs5szf/27ILaaFZyfBfzykinB8V0lKD8onVhNB3PyVf4Ia0OkAlnz6
	 ZDG5CmNZkDi2FGBgrMp74HCM3d635rQea8s3cqnNZlYaqdkryX43kmajDu8BVibC9l
	 USASFmlwJxXFQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/8] mm/damon: move damos filter range arguments validation to core
Date: Sat, 12 Sep 2026 12:17:58 -0700
Message-ID: <20260912191807.138502-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filter range arguments are being validated in the DAMON sysfs
interface.  Some of those have minor time-of-check to time-of-use
(TOCTOU) bugs.  In future, other callers might have duplicated
validations with similar bugs.

Fix the bugs and further refactor the code to move the validation to the
core layer.  Also add kunit test cases for the validations.

Patches 1 and 2 fix the existing TOCTOU bugs.  Patches 3 and 4 adds the
validation in the core layer.  Patch 5 drops the replicated validation
in DAMON sysfs interface.  Patch 6 further cleanup the code.  Patches 7
and 8 extends kunit tests to test the validation.

SJ Park (8):
  mm/damon/sysfs-schemes: read sysfs_filter->addr_range only once
  mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
  mm/damon/core: return an error from damos_commit_filter_arg()
  mm/damon/core: disallow max < min damos filter range arguments commit
  mm/damon/sysfs-schemes: drop centralized filter range arg validations
  mm/damon/sysfs-schemes: use switch-case in add_scheme_filters()
  mm/damon/core-kunit: extend damos_commit_filter_for() for wrong input
  mm/damon/core-kunit: test invalid damos filter commits

 mm/damon/core.c             | 24 ++++++++++++++++-------
 mm/damon/sysfs-schemes.c    | 32 +++++++++++++------------------
 mm/damon/tests/core-kunit.h | 38 ++++++++++++++++++++++++++++---------
 3 files changed, 59 insertions(+), 35 deletions(-)


base-commit: ec1b9fab95fbfd9c5dbdfb841d91929c2cb63518
-- 
2.47.3
