Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC64B3A83AC;
	Sat, 26 Sep 2026 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790430304; cv=none; b=PNpmfpivI2T5HQZ/VBewMhu+ZzYlAmjEYHjrQK2/PwPvWWJ0UJ31Skpnwf1fxl01uiuJ7qlFfqt5Vfeai8xpLLHRRFNvMY9uk8r3fDh8xS08i9R0if/63vyo6FbnrkTQ6owQ0YMp2E5UBh7iLvWdTdmP3VErP07SXSYsUVkdbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790430304; c=relaxed/simple;
	bh=/C5QXtDLRTbLHMUCJfGd05w9YRXxfuMpEZAmIVNhpoo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NX3jTFpR63E2GAPMNEunoCQyn0CyDJBQNQhTV5E6rzhlHTzAIUW48juPP02h5WNM45UVYT76ZDJ2QpQnXYGPt5RwhpIQ08vTvfFmRaM6FQ3FmOSDxwFlMZoBAwXB5n49R3+SkSh2fXo51LpZ3mnjNylLk051M3YdFjb32tbNb5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeCvV289; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeCvV289"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59E21F000FF;
	Sat, 26 Sep 2026 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790430303;
	bh=/t1FR5Y5rekdhRya/JoXfVqsLJa7kPHc9pIVl/iR8dk=;
	h=From:Subject:Date:To:Cc;
	b=HeCvV289GzC3wzvr5b7RFWkrHz1820qmbHP5Po7ho2cx8nVlwY863FUWPim9RbB00
	 +xGTQabILj4AxEVt/IfLeU1t63uGGAWJ1LHt8p575YIyR4lxWGqaG7jhVS5clSj347
	 UZKg68iwehPNnscoCIVo1HW2n31ULYJRNZB3x3E0mGDzcUWU58UMfKV/VuMZNj+DSd
	 wLqiY4paZyJ9I3FxyIt9DtCSIXUaaLwXLqJySbcooLPzCpsdwdY64Bx7J4y9inn7nV
	 lxYyQAm6/143+EdBX7+mJhhU4zkfMzcNBeLcVIN8itNtVtL1diqns/jSnb+lRna8IF
	 Vqeztu7qoZgQA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/10] mount: a few additional bugfixes
Date: Sat, 26 Sep 2026 15:44:23 +0200
Message-Id: <20260926-work-mount-fixes-2-v1-0-f357abf3d17b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMwQ7CIBBEf6XZs9sANRj8FeMB6NaiEQzb1iZN/
 12oxzczbzZgyoEYrs0GmZbAIcUC8tSAH218EIa+MCihtDBK4zflF77THCccwkqMCo3otTTWk9Q
 dFPGT6aiKd7v/mWf3JD/Vp7pwlgldttGPNVoGxkt7bo9b2Pcf17EHIpYAAAA=
X-Change-ID: 20260926-work-mount-fixes-2-90d619ace163
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/C5QXtDLRTbLHMUCJfGd05w9YRXxfuMpEZAmIVNhpoo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPxOldtmtZnpdao37hDWHVrAlmwS89WxISTM/0LUu8
 hu/79KMjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn0vWJkmDb7zMr1C4WLNMwO
 cOy3M6vSmvE1413upSXHHi5ct9dkxQlGhmvBW2d+CX5xkq1p4ouJ7QzcdzUbUr4Z3l3g9fP3pih
 TQ34A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Here's a set of additional mount fixes that fell out of my recent look
at the mount code:

- Fix a UAF in mnt_change_mountpoint().
- Fix a UAF in statmount().
- FIX a UAF and various associated bugs in clone_mnt()
- Prevent copying an unmounted mount tree.
- Avoid pointless work in mount_setattr().
- Refuse fspick() on kernel internal superblocks.
- Simplify dissolve_on_fput() and unshare().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (10):
      namespace: reset the old parent's ->overmount in mnt_change_mountpoint()
      statmount: read the parent of an unmounted mount under mount_lock
      namespace: don't inherit MNT_UMOUNT in clone_mnt()
      namespace: don't copy an unmounted mount tree
      namespace: check the target before walking it in do_mount_setattr()
      fs: refuse fspick() on internal superblocks
      fs: put the old fs_struct before the old namespaces in unshare()
      namespace: drop the file's reference first in dissolve_on_fput()
      selftests/filesystems: check that an unmounted mount tree isn't walked
      selftests/filesystems: check that a dead mount's overmount isn't followed

 fs/file_table.c                                    |   3 +-
 fs/fsopen.c                                        |   3 +
 fs/namespace.c                                     |  37 +-
 include/linux/mount.h                              |   2 +-
 kernel/fork.c                                      |   9 +-
 tools/testing/selftests/Makefile                   |   1 +
 .../selftests/filesystems/mount_cycle/.gitignore   |   3 +
 .../selftests/filesystems/mount_cycle/Makefile     |   6 +
 .../mount_cycle/overmount_reparent_test.c          | 181 ++++++++
 .../filesystems/mount_cycle/unmounted_tree_test.c  | 484 +++++++++++++++++++++
 10 files changed, 719 insertions(+), 10 deletions(-)
---
base-commit: 762a6411a5a7aa4119570bae590662312ccb4be3
change-id: 20260926-work-mount-fixes-2-90d619ace163

