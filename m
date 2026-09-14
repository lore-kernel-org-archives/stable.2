Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C3D37EFFF;
	Mon, 14 Sep 2026 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395817; cv=none; b=hgmafvcNsq9HUuukMXhVrkqsz47a4ibZCEp71mJAnCoLnZnAQHZD54sb2hp1isSj08mxb5B+olMhBCOtMYBTU37NjuG7r+ZpxRrEvVThMN9qfbfn5CfUyBYumvcHklhyi71H/MaArri+uZnhILuguvMpZ+Ww4amsD9InGxP2nTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395817; c=relaxed/simple;
	bh=I9ZWIE9bmrC+l5VfJrG4++ex+edpw1ojIT8xKgAKWho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fCR87uOKC4XSPHM4ZAUcR0y/+SnLcGZ5Jzipc17c1a0IRyJXLorpY0kbLGAopQ1KqIRMPLnYlYNVgBLUWKhElfgj6uHDO6J9586rMrI3SFbjoIv3jzuy5OsJFUGEONdGjcyPdPyE3kofOwyvY5epLJrVoho/SONqFy1xzEjK1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrN7HNCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrN7HNCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86C81F000FF;
	Mon, 14 Sep 2026 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789395815;
	bh=ep919c/A8naa0L7/1EU26ygjkhlh33Hy/XJA/cnxVTQ=;
	h=From:To:Cc:Subject:Date;
	b=ZrN7HNCkhe53u8UJM+fiF2ur5cR5zGmJ5GkiXDwUSXocPzDYY+ykkqGpFcBwZjl1l
	 5oIqkZkGah2Lm4iWMs8f1RGiWsw/t2ZPNQQm/h6ayVAU/qDfiRLElRFFDeRBz898zy
	 EebHqYPujLpDBkvyHi9/aUe6XTd9o7bUVCmw/WgMreRkX2wiCur8zRhLK4CRhSbR6x
	 ZswdZvyuH5IEd4K60LNLZ5rTFr6JEtc3KbkeBVEr4CcH3th4TUOgwJSt0p3r4/BVWO
	 ruXQ9cXyNajpxI1tXy2dLST+3Cce8fCQB9nZRC1lEV9rVyDd+Hi02G6uW3qUTODXZW
	 N0f3/ppCkuJJA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/8] mm/damon: move damos filter range arguments validation to core
Date: Mon, 14 Sep 2026 07:23:17 -0700
Message-ID: <20260914142327.92510-1-sj@kernel.org>
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

Changes from RFC v2
- RFC v2: https://lore.kernel.org/20260913171706.103052-1-sj@kernel.org
- Drop RFC tag.
- Rebase to latest mm-new.
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


base-commit: 5e38c61dbb4349ff7e900d97d96f369c64678eea
-- 
2.47.3
