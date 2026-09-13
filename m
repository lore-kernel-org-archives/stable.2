Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09313264D2;
	Sun, 13 Sep 2026 17:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319835; cv=none; b=Bi/ZvYWYW8oH85nKCulMKL1zFdWNql3QEgMJhIE8Pltc3cAz48Bzz01jsqowh3ZmcaE2JC+eeHmStp3ZUNFs6slIhXWe0aONSNz2J7WUd1gsUjkseXGm6pyL2bCIO3KJjRlioOCNQwutrVuTEkGYqIM7VTYf9sOyL2bSWC0iST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319835; c=relaxed/simple;
	bh=OXgHvPbDzpbQ6EYzpFVYwrgHlTluI9ZoSCMWF67VqDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lhxUrmFLmFKmiXS+NO6yv1xTtIl4SslndkwMpHxaukq1e3SaZ9BH7ioIMWIM9sONBpgsHlEf6Z79R7YCRiVEWriys5NDZr1BcVzo4ml0OnOHGD4KbuwdaFkWa+++YkBphknFet6oA9/KU2Pi/5usHzYvwuJAAp1p2fW8vIwXvH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMds8Aov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMds8Aov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB1B1F000FF;
	Sun, 13 Sep 2026 17:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319834;
	bh=3+8k6ainblVJ8ZQoxyR4ldMO4in1kOwavTyrKMtf2jU=;
	h=From:To:Cc:Subject:Date;
	b=gMds8AovhvmAXMi8//pmO+kS6q3uU+kD619aoEYC220mBOHKi4sqsINPF1x8qhsjq
	 7Q26+jswgTXjbcMiw6cPjaidfAZflaDU/Ch65TEel9omyqF1K8LeTTZ9yqZBtYNIyy
	 oO7IlFC56ZqCm7nFVZN60K2CooGs+SuqA4Np9EiCF4ZFIOwrvZDE+QkqCEhsECVF9l
	 8wFKK41WSbjXmHUOplf8chlJxt/DO4aghUm6yeGYY9KzbZhaRZy4WxY3uTHzyIFX7m
	 JmtgFJqr75P6MXGZdtsKr7S/jLsK2DhrWazdm2gA1mBtC3PRVoIh46uhafQLgxULB+
	 Gzau5nf5wsg7w==
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
Subject: [RFC PATCH v2 0/8] mm/damon: move damos filter range arguments validation to core
Date: Sun, 13 Sep 2026 10:16:57 -0700
Message-ID: <20260913171706.103052-1-sj@kernel.org>
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

Changes from RFC
- RFC: https://lore.kernel.org/20260912191807.138502-1-sj@kernel.org
- Handle error from damos_commit_filter_arg() on all call sites.

SJ Park (8):
  mm/damon/sysfs-schemes: read sysfs_filter->addr_range only once
  mm/damon/sysfs-schemes: read sysfs_filter->sz_range only once
  mm/damon/core: return an error from damos_commit_filter_arg()
  mm/damon/core: disallow max < min damos filter range arguments commit
  mm/damon/sysfs-schemes: drop centralized filter range arg validations
  mm/damon/sysfs-schemes: use switch-case in add_scheme_filters()
  mm/damon/core-kunit: extend damos_commit_filter_for() for wrong input
  mm/damon/core-kunit: test invalid damos filter commits

 mm/damon/core.c             | 47 +++++++++++++++++++++++++++----------
 mm/damon/sysfs-schemes.c    | 32 ++++++++++---------------
 mm/damon/tests/core-kunit.h | 38 +++++++++++++++++++++++-------
 3 files changed, 76 insertions(+), 41 deletions(-)


base-commit: 9b2df9f07a4a7a5d9f625d26f9482486859d64aa
-- 
2.47.3
