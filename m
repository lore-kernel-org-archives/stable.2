Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E772D9EE4;
	Thu, 18 Jun 2026 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795729; cv=none; b=KyvHG16SEBBZZL3kZS7ZT8Z6vmHFm+efoMg90kZ3Ugi6OAuKpbuoz/SgvZJEwqzo5Ij0qsdQ0j4IciNvkPg+21YEuGSHJdtq+nDM2nqBSAmZJN8XnbusOjQo70XgSzlpKV6FwTdtA2sFxY+0XI4+UiwsHenJW9UfYaaEXIui9Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795729; c=relaxed/simple;
	bh=lcUnEqhWTXGgFsnJ2GHSPjx/+5r2ez9z5eZ3Sg9Kwo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HKgxPsQAGVhBIBmDKuZmHAjeGynqNuzn0HtGN84wLNM6nT3hibswl1oD+EkukVkDI/mhwjIYdXDHrc49qEOatSlmP/MyukJwVEBsTGFOdj7XZVkq8u+N2Hu5drESyO6DdFgNrjkn+p7m63ODszWds194IxMieyZO7dw0S5oBsm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+ABRFxj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+ABRFxj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C251F000E9;
	Thu, 18 Jun 2026 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795728;
	bh=TV4CqNhL96y47BkvUr+Vh2gUi09twBlCDxYoSxWN5Fg=;
	h=From:To:Cc:Subject:Date;
	b=I+ABRFxjLtSSQZOvjMDFRYRmy2ivQODBZl39LW7V/1yKoNLOB3it9SlE4vXHN4oJ/
	 vbia9Gyo7xHYxafNmddewCNvUkLxEpK7EdIE3jRuhwmoqaYLmBgMP1wQ8ieh9bsGiu
	 vUH1rf1hQulzRnCX4cKqyDkwLm5ak7kDWsTnOci5/XCbJPSFvjCIzwJ+CH9mlaLRWl
	 FMuHDMswaSBc6suPqFG7+5q4ghJ5fidoyMPf41IFPCdEEg3fiUR19/G1/xFyWpVVY0
	 TnlUm3dp/YLuGhMcB4WniAlN3frykeJ7KxXa6kR0odhumq3JhZ8JDnFOrvQo707L7U
	 F56wIoGDM76ng==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 00/11] mm/damon/sysfs: kobject_del() directories that users can create/remove
Date: Thu, 18 Jun 2026 08:15:04 -0700
Message-ID: <20260618151517.5366-1-sj@kernel.org>
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

Some of the error handling paths of the directories also lack the
kobject_del() call.  If the user uses nr_* file right after the errors,
similar issues can happen.

This doesn't cause catastrophic issues like kernel panics or memory
corruptions.  Users can work around by removing all directories first
(write 0 to the nr_* files) and then create new directories after
confirming the old directories are gone.  But, this is definitely a bug
that causes a bad user experience.

Fix the issues by calling kobject_del() before creating new directories.

Patches Sequence
================

There are a number of bugs of this class that are introduced by eleven
different commits.  The fixes are grouped and ordered for the
introducing commits.

Changes from RFC v1.1
- RFC v1.1: https://lore.kernel.org/20260617144807.91441-1-sj@kernel.org
- Add error path fix for damon_sysfs_schemes_add_dirs().
- Rebase to latest mm-new.
Changes from RFC v1
- RFC v1: https://lore.kernel.org/20260616150844.88305-1-sj@kernel.org
- Add error path fixes.

SeongJae Park (11):
  mm/damon/sysfs: kobject_del() target (normal), context and kdamond
    dirs
  mm/damon/sysfs: kobject_del() region and target (error) dirs
  mm/damon/sysfs-schemes: kobject_del() scheme dirs
  mm/damon/sysfs-schemes: kobject_del() scheme region dirs
  mm/damon/sysfs-schemes: kobject_del() scheme filter dirs
  mm/damon/sysfs-schemes: kobject_del() scheme quota goal dirs
  mm/damon/sysfs-schemes: kobject_del() scheme action destination dirs
  mm/damon/sysfs: kobject_del() probe dirs
  mm/damon/sysfs: kobject_del() probe filter dirs
  mm/damon/sysfs: kobject_del() probe dirs in probes_addd_dir error path
  mm/damon/sysfs-schemes: kobject_del() region for populate_region error

 mm/damon/sysfs-schemes.c | 22 +++++++++++++++++-----
 mm/damon/sysfs.c         | 25 ++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 10 deletions(-)


base-commit: 30941f0c4e32b31d4dcf2956491c5a3ac9c5beb4
-- 
2.47.3
