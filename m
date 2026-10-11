Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D41933290F;
	Sun, 11 Oct 2026 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734178; cv=none; b=QTwPYDR+CvEayJbWFaft8LO7bTnWgVUmHL+RZOOnFnpc2mxVoFaFoEcRi5GFvT0o+PH8+jK1hoWiVqzm/n+YfFQPTw0NJT8d9D3BXvKzCU3AH5suDntb0bWNr3z4wRhA3WNeHSx8/GovAcixl0G6TqNpKDjKLRoTs3VakupavQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734178; c=relaxed/simple;
	bh=qsZSmgjbz63DykEfSNWhjgsM1BFvP04hZaaWy+mfIMk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sStbZuZ3uvu8ugGOIjj2hZcRBGnR+IgjIRnNNThheUEkRZswQBKXbdtsq0tafwfYxzJMWPQYQnaRdzPCwikWHhY5OEhN0MGzbjm+1a+a/8aBuUy20uNdo4XvDagp7jz6ezkkw1WDhCYkeDNZDyYcGV1cKy78YkBylie/TzphPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcIu5LPM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcIu5LPM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8791F0089B;
	Sun, 11 Oct 2026 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791734176;
	bh=8JMW+KHa+MZepV//BE2RpV3DuyFlt1GlFxEcus967FA=;
	h=From:Subject:Date:To:Cc;
	b=RcIu5LPM9BplSGj5FAxnRQJv1tbCZAScfa9D2QAxOEbOiD2Py7n4UiAWikTuSsaui
	 q4QhU4VlXYSnbVjPnisQcO9k2no70cpyhxEFp0hIqELiK1Y+bqE6NgN+68QOUpgESH
	 GTY7nHWE4akWQ6QmkHWGM1TAt1ebuUPU3XyAdp5rAp4GrHly4Xe2SwdD81OmcoUc+U
	 SaD18NrTo4ArQ0OyULjqBqgh9bYMP83C6h4LNqM68gcJZmcxhSbRCKljA3+XsILJSa
	 0NYn5WmtOL47teh+qSWzLtBXI73JLtKUnUBscTuVppcSJfn1gR0bLES/AYZhzqUWhr
	 phHKnHfnwAD8Q==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/15] super: fixes for freezing, reconfiguration and error
 reporting
Date: Sun, 11 Oct 2026 17:56:00 +0200
Message-Id: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ7CMAwEv1L5jEUToajwFcTBCYYG1CSyW0Cq+
 ncSOM7uzq6gLJEVTt0Kwq+oMacKZtdBGCndGeO1MtjeOtMbg+8sT9SlsOAtflgxZGF0x8GE4UB
 kvYPqFuFfW9Xz5c+6+AeHuZ21hSdl9EIpjC1ais7CNO0n0pkFtu0LHCELE5sAAAA=
X-Change-ID: 20261011-work-super-fixes-core-6981c84aa2b6
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4382; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qsZSmgjbz63DykEfSNWhjgsM1BFvP04hZaaWy+mfIMk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd3jj77tXnO/ebvNVnXKD14krH8su+XxUvBSQUBU+4Z
 jkxT/8eX0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEfHcy/PfKNTUyd8mNatsU
 +2RXKu+l5fwWXMpLklhmJz1mjdRZqMzIsGnhg5LLqjazS46UpF19fj184/ny1r88kiIJ397+Mw9
 bygAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A pile of fixes for super.c and friends that I found while going over
the freeze and reconfigure paths again. Most of them are old and all of
them are tagged for stable. Most come with a selftest under
tools/testing/selftests/filesystems/freeze/ that fails without the fix.

- sysrq-u deadlocks on itself if an umount races the emergency remount.
  The iterator held s_umount while the reconfigure context dropped the
  last active reference. Take s_umount in the callback instead. Nothing
  iterates with SUPER_ITER_EXCL after that so it goes away.

- Every resume while a filesystem is frozen through FIFREEZE or through
  its block device WARNs because filesystems_thaw() tries to undo a
  freeze it doesn't own. With panic_on_warn the resume panics.

- quotactl() on a frozen read-only superblock burns a cpu and can't be
  killed. freeze_super() doesn't take s_writers for a read-only
  superblock so sb_start_write() never waits. Wait on s_writers.frozen
  with wait_var_event_killable() instead.

- Two fserror fixes. The last pending error decrement wasn't fully
  ordered against the wait in fserror_unmount(). And reports were
  accepted before the superblock was born so a failed xfs or f2fs mount
  freed the superblock under a still pending worker.

- fs_bdev_freeze() returned the error of sync_blockdev() after it had
  already frozen the superblocks. bdev_freeze() takes that to mean that
  nothing is frozen so nobody ever thaws them again.

- A FITHAW behind device-mapper's back left the device frozen for good.
  fs_bdev_thaw() got -EINVAL for a freeze that was already gone and
  bdev_thaw() kept bd_fsfreeze_count elevated. qemu-guest-agent does
  exactly that on every guest-fsfreeze-thaw.

- Reconfiguring through fspick() made read-only superblocks read-write
  because most filesystems compare fc->sb_flags & SB_RDONLY with the
  superblock and ignore the mask. And vfs_clean_context() leaked the
  mask into the next reconfiguration through the same context so a
  second FSCONFIG_CMD_RECONFIGURE did the same without anyone asking
  for it.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (15):
      super: don't put the remount context under s_umount
      super: don't warn when resume thaws a userspace freeze
      quota: really wait for the thaw in quotactl_block()
      selftests/filesystems: add quotactl() tests for frozen superblocks
      fserror: fully order the last pending error decrement
      fserror: don't accept error reports before the superblock is born
      fs: don't fail fs_bdev_freeze() once a superblock is frozen
      selftests/filesystems: add a test for failed block device freezes
      fs: don't keep a device frozen when its freeze is already gone
      selftests/filesystems: add a test for thawing behind a device freeze
      super: keep the read-only state if a reconfiguration doesn't change it
      selftests/filesystems: add tests for reconfiguring through fspick()
      super: remove SUPER_ITER_EXCL
      fs: reset the flag mask in vfs_clean_context()
      selftests/filesystems: add tests for reconfiguring a reused fs_context

 fs/fs_context.c                                    |   1 +
 fs/fserror.c                                       |  16 +-
 fs/quota/quota.c                                   |  12 +-
 fs/super.c                                         | 113 ++++++---
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/filesystems/.gitignore     |   1 +
 tools/testing/selftests/filesystems/Makefile       |   4 +-
 .../selftests/filesystems/freeze/.gitignore        |   4 +
 .../testing/selftests/filesystems/freeze/Makefile  |   8 +
 .../filesystems/freeze/bdev_freeze_test.c          | 234 +++++++++++++++++++
 .../selftests/filesystems/freeze/bdev_thaw_test.c  | 251 ++++++++++++++++++++
 tools/testing/selftests/filesystems/freeze/config  |   9 +
 .../selftests/filesystems/freeze/loop_util.h       |  64 ++++++
 .../selftests/filesystems/freeze/quotactl_test.c   | 256 +++++++++++++++++++++
 .../filesystems/fspick_reconfigure_test.c          | 231 +++++++++++++++++++
 15 files changed, 1170 insertions(+), 35 deletions(-)
---
base-commit: a5ebb76233b79db01e82e061173cb73c6d2b5c6b
change-id: 20261011-work-super-fixes-core-6981c84aa2b6

