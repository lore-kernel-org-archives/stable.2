Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D2D2D5C7A;
	Wed, 30 Sep 2026 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775136; cv=none; b=E+bTc7eKoRVuuwxtiuhZABLgyDZr3JmI5ajjPABGFtAFwcw9BTM1Mgds5YkRQpAxpg6rQrXJn3bx49Oeq4dyWjG1viA4BRRoEL4SNSk7Zx3TLcM5PXGFWkW/HYxEAw4Xt28ZprWPb5pkbDURwIekIiGsRCsijGSHxux2vgLO6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775136; c=relaxed/simple;
	bh=Y+Pwxfmndt9G40KqCDgCygYltzarZZeNi6VrEi2HXiA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rzq2wDwdVe8TQj/2lWt0jMITE8Hz9ZWtHx8PTGSWQwyR1maHCwYAfifFTtHEsxIsaFxFGxZ23qhgW5rn9C6Ya89/D4H0NNaaLDlaMl4H/Nrtp96Esj6Aw4wD3t/U6i4fXSCztIq4phPOFA4uCcHgbAIFVYjiB/uIXEaLPRah+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgc18Brn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgc18Brn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3351E1F000FF;
	Wed, 30 Sep 2026 13:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775124;
	bh=h5TBTLn7Y/mbpM5Ly+GoCUBzzklB61RltcAhIaiTUkI=;
	h=From:Subject:Date:To:Cc;
	b=bgc18BrnEIVfRdwcjd5nDUj0e2I0FnPfjmyDcKrhjTak3Nf+A3BuqmHD6uJZwJ8fD
	 mEvCZ7qi9loBK1KEyWuUVQOzcOyCxE65tlb6RE+tQ6tccCLnPSfgfupH2TgCDXqxF4
	 k2nENToTwgQTvKb3DLY2cTCdkydB08WRsKrMaIS46Gdz3Z9ON+Qsfp8jfpNMsG+U00
	 ZRMbTDB2S+2fgyZNg29TYY9oJEJNmQoLkOmnjMzjetxcs1mRQuOaNCrg0q+eM0D4OP
	 rJRIV0XCFRlXYPoD7sSr+qDGJMQJGHZZyuIHEQ8eiKHaRbQc/CzoqaXuoh6MsYH2FM
	 jp1uihHcnlq9A==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/17] mount: more bugfixes, the Oprah edition
Date: Wed, 30 Sep 2026 15:31:52 +0200
Message-Id: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMXQ7CIBAGr9Lss0sQtFqvYnwAulo0gmH7Y9L07
 gI+zu43swJT8sRwaVZINHv2MWTY7xpwgwkPQt9nBiVVKzstcYnphe84hRHv/kuMGg+nY6scdfY
 se8jiJ1F9Ze96+zNP9kluLKWysIYJbTLBDeVUmqI2RRWFFmUB2/YDPU1Q6KAAAAA=
X-Change-ID: 20260930-work-mount-fixes-3-47562ce9b80d
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, 
 bpf@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3764; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Y+Pwxfmndt9G40KqCDgCygYltzarZZeNi6VrEi2HXiA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5ffjy/TfPLHG6dXp6Wv+FLzxaHJ4suWH7W7vI30F1
 54/8Yw63FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRjnuMDK3xj8601aQfflT+
 Q9nVV3C21b+8z407ZX/tnH17+8rfh8UY/gfuKJzAvL/49uSMz38Y/mbkdtlrbvc967Oy/sviyhX
 BXvwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Yet more bugfixes falling out of my recent work in this area:

- don't let a pseudo dentry become the root of a mount
- don't drop active namespace references that were never taken
- don't put a mountpoint on a dentry that's being removed
- detach the fsnotify connector before destroying its marks
- remove the fsnotify marks of a mount namespace in process context
- don't reconfigure internal superblocks via remount and umount
- check the mounts before reading their parents in pivot_root()
- look at the topmost mount for a mount namespace file
- keep covered mounts covered in OPEN_TREE_NAMESPACE
- check a recursive bind mount for mount namespace loops
- check a submount for references right before unmounting it
- queue a mount only once for mount notifications

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (17):
      namespace: queue a mount only once for mount notifications
      namespace: check a submount for references right before unmounting it
      selftests/filesystems: check that a busy submount survives a synchronous umount
      namespace: check a recursive bind mount for mount namespace loops
      selftests/filesystems: check that a recursive bind mount can't pin the caller's mount namespace
      namespace: keep covered mounts covered in OPEN_TREE_NAMESPACE
      selftests/filesystems: check that OPEN_TREE_NAMESPACE keeps mounts covered
      namespace: look at the topmost mount for a mount namespace file
      selftests/filesystems: check that a mount namespace file on top doesn't bury a mount
      namespace: check the mounts before reading their parents in pivot_root()
      namespace: don't reconfigure internal superblocks via remount and umount
      selftests/filesystems: check that the nullfs root can't be reconfigured
      namespace: remove the fsnotify marks of a mount namespace in process context
      fsnotify: detach the connector before destroying its marks
      dcache: don't put a mountpoint on a dentry that's being removed
      unshare: don't drop active namespace references that were never taken
      namespace: don't let a pseudo dentry become the root of a mount

 fs/dcache.c                                        |   4 +-
 fs/fs_context.c                                    |   4 +
 fs/fsopen.c                                        |   3 -
 fs/mount.h                                         |   3 +
 fs/namespace.c                                     | 133 +++++++++----
 fs/notify/mark.c                                   |  16 +-
 include/linux/nsproxy.h                            |   1 +
 kernel/fork.c                                      |   3 +-
 kernel/nsproxy.c                                   |   2 +-
 .../selftests/filesystems/empty_mntns/.gitignore   |   1 +
 .../selftests/filesystems/empty_mntns/Makefile     |   2 +
 .../empty_mntns/internal_sb_reconfigure_test.c     | 108 +++++++++++
 .../selftests/filesystems/mount_cycle/.gitignore   |   2 +
 .../selftests/filesystems/mount_cycle/Makefile     |   1 +
 .../filesystems/mount_cycle/nsfs_rbind_loop_test.c | 193 +++++++++++++++++++
 .../mount_cycle/overmount_ns_file_test.c           | 187 +++++++++++++++++++
 .../selftests/filesystems/open_tree_ns/.gitignore  |   1 +
 .../selftests/filesystems/open_tree_ns/Makefile    |   2 +-
 .../open_tree_ns/open_tree_ns_covered_test.c       | 183 ++++++++++++++++++
 .../filesystems/umount_propagation/Makefile        |   2 +-
 .../umount_propagation/shrink_submounts_test.c     | 205 +++++++++++++++++++++
 21 files changed, 1008 insertions(+), 48 deletions(-)
---
base-commit: b4698e50d4601f43d21759203be5b0b3c123e383
change-id: 20260930-work-mount-fixes-3-47562ce9b80d

