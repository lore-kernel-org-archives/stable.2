Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1016D3370EA;
	Tue, 16 Jun 2026 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622538; cv=none; b=KIKTDaRlt+4pu6UpkrwkVo2REx49R67eZcoBvuSZG/2u1jxdc+gUAZ1jYwtJXHnDFI3fN8vMup7BUbwAA1YnmxQGKpcRjBsifNppAut3EtRxnltAkr94xKbc+4sfhizYTk01AMw60dN6y2zuA6ysRdjPv/CsoZnzji7+lxjORGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622538; c=relaxed/simple;
	bh=wKQEF0e2WWJpoZOhm/obk418ulRZucmcMVjn+DmVUw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VPhOtSitvEXG/5lmMBzeeK55dpJZK0Yoo145FrrQcmmtdvzNGmRwlpfCrCmQxeAnalLrlzsbdyKoWdjQX2xmAIOQBzAh3QhH2/Nkj/fGhwmfGBlYUr5V0g5evOdWmHNeRiZpQQjM7aQ7fu/S3bSZcCHYyS3da45ESqx4kFJkji4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4wKfY9K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4wKfY9K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF971F000E9;
	Tue, 16 Jun 2026 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781622536;
	bh=K+v9AegM+GbGImm5gCXGTgw97ToQTe1LU6DkxXMfsCY=;
	h=From:To:Cc:Subject:Date;
	b=n4wKfY9KRZTt2xCWjFtlFYZeZ/3WQp8uZlBIF5/VGT5VcgoIsVvCAHgY7Q5u4blAi
	 oZifkPAoUqq5KGWIg7KaZjLXVTWRTUjSg8ah/RJ04qDOjuVJgX8QTVigjcLj0Cpkrs
	 FibBamzkRXQ47gDhc/vVRST0N8PScF4lZ4K3kf+oqBqMR38z/8gehFMEytN+brHUNJ
	 6O4NKsTTnCM/L+kG9ah9FFpn0Gpo8ZATZ51bOJ0R4p03H2xGsEDQFfvRmbIsXpBXul
	 gvLD4cxx6mCH4rtO9/nItxciF1/W8tlgzKi1yVGmhSGEaA19pdBiShoyIu5ufO8eKY
	 i66kVczeIYeTA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/9] mm/damon/sysfs: kobject_del() directories that users can create/remove
Date: Tue, 16 Jun 2026 08:08:34 -0700
Message-ID: <20260616150844.88305-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface allows users to create and remove arbitrary number
of directories on sysfs, using a few files having 'nr_' prefix.  For
example, 'nr_kdamonds'.  When the user writes a number 'N' to the files,
directories having name starting from '0' to 'N - 1' are created in the
same directory.  The pre-existing number-named directories are removed
before creating the new directories.

For the removal of the existing directories, DAMON sysfs interface use
only kobject_put().  Because DAMON sysfs interface is the only kernel
component that manages the directories, there is no problem in normal
situations.  However, if CONFIG_DEBUG_KOBJECT_RELEASE is enabled, the
removal of dirs are delayed.  Let's suppose a user writes a non-zero
number to the 'nr_*' files while there are pre-existing number-named
directories, on the config enabled kernel.  DAMON sysfs interface
decreases the reference counts of the existing directories and
immediately creates new directories.  Because the removal of the sysfs
directories is delayed, it shows some pre-existing directories of the
same names when it tries to create the new directories, and fails.

For example, the issue can be triggered like below:

    # grep DEBUG_KOBJECT_RELEASE /boot/config-$(uname -r)
    CONFIG_DEBUG_KOBJECT_RELEASE=y
    # ls
    nr_kdamonds
    # echo 1 > nr_kdamonds
    # echo 1 > nr_kdamonds
    bash: echo: write error: File exists
    # dmesg
    [...]
    [  300.880458] kobject: kobject_add_internal failed for 0 with -EEXIST, don't try to register things with the same name in the same directory.
    [...]

This doesn't cause catastrophic issues like kernel panics or memory
corruptions.  Users can work around by removing all directories first
(write 0 to the nr_* files) and then create new directories after
confirming the old directories are gone.  But, this is definitely a bug
that causes a bad user experience.

Fix the issues by calling kobject_del() before creating new directories.

Patches Sequence
================

There are eleven kobject_del() lacking nr_* files that are introduced by
nine different commits.  Fix each of the commits in the introduced
order.

SeongJae Park (9):
  mm/damon/sysfs: kobject_del() target, context and kdamond dirs
  mm/damon/sysfs: kobject_del() region dirs
  mm/damon/sysfs-schemes: kobject_del() scheme dirs
  mm/damon/sysfs-schemes: kobject_del() scheme region dirs
  mm/damon/sysfs-schemes: kobject_del() scheme filter dirs
  mm/damon/sysfs-schemes: kobject_del() scheme quota goal dirs
  mm/damon/sysfs-schemes: kobject_del() scheme action destination dirs
  mm/damon/sysfs: kobject_del() probe filter dirs
  mm/damon/sysfs: kobject_del() probe dirs

 mm/damon/sysfs-schemes.c | 14 +++++++++++---
 mm/damon/sysfs.c         | 12 ++++++++++--
 2 files changed, 21 insertions(+), 5 deletions(-)


base-commit: 7e1f9f51ca3090f7268c1ae8cc5b0552e9df3a87
-- 
2.47.3
