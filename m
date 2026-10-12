Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C146339370;
	Mon, 12 Oct 2026 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810925; cv=none; b=NfeJLyK3cRa3MjdkzCmY1hyrCE1XKBKaw5Z9LUjxkYyc6Na9Bm8aIpA0QUn2zliqbgvQKUvQ2sBCxYIfZ5gG9EceuGUwWa2GVvsk/fkL9YiZOcA2D9WqXQKm1T7Nyal63QnUz+1AzaZCCL6l2J3M4SmqBqmG7HMjbUoEm4VQBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810925; c=relaxed/simple;
	bh=vWWDkBKTAAuPSVvsh2ni9QQ08KjEAVx95iIEs3sBFg0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZhgUoju8nEmecNDpXRKOl2raXO62cRf+dzrVz1thPDPs1yOW0coMsvY+bz2Yg80ntLPCCl6tL9ECwIImK09qnzrFJri9RPiqTYjQA4CdxfZmMtNWgQOs9FY4o/gsJu3jv1u7AEOxGudH2S3qVzI037J5iI0VmVFOb7netkFZzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBsHWcBT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBsHWcBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EE21F0089B;
	Mon, 12 Oct 2026 13:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810923;
	bh=KHyQUP9W5Ro+6SpBnwb7Xcxts5kGQIehMGAJoMtKnk8=;
	h=From:Subject:Date:To:Cc;
	b=NBsHWcBT96sQDQsPaMAlIrcMiMZziMHQ8V4iD6xW/mXqKJc6ND3TG63GWbXtLDr/u
	 ptMsFaeNoHgB9hfc/+ad5G1ltokyR4k2d2jFejxIy0jjDaR+ONq4t23HbS49sxyMsm
	 vE1BaZGwGTTrDJIsIZwFKWX6WzAv4tUzZfg0INo6hyhPbuy4hQRofBzPccASU8Ui2X
	 vsyhCvClhU+OmXP6nmmJgi+s7+kmrHdbodY3TnNkdsEEwtCebiZvz+7YmG1kmVhtUD
	 Hag6x3VmoIyi8Pa4hR32bCJ8GtgOGO4rxJiVdo0A2hF8VV0GX3X5Bqm6J3uKoMtMBT
	 55k/Hdo2Cthow==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/4] namei: check for names that lost their mounts in every
 refwalk
Date: Mon, 12 Oct 2026 15:15:14 +0200
Message-Id: <20261012-work-namei-reval-v1-0-515664de33b5@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBBFf6XM2gltwID+iriYpFc7WlNJ6gNK/
 92kLs/l3LNQRlJkOjYLJbw16xQLdLuGwiDxCta+MNnWuq7tLH+mdOcoDygXX0aW4A89HPbOWSq
 3Z8JFv1vydP5zfvkbwlw71fCSwT5JDEOdatFsRVOKkNFUgdb1B6k3eBidAAAA
X-Change-ID: 20261012-work-namei-reval-acb9de6e5662
To: linux-fsdevel@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Neil Brown <neil@brown.name>, 
 Jan Kara <jack@suse.cz>, fuse-devel@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4289; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vWWDkBKTAAuPSVvsh2ni9QQ08KjEAVx95iIEs3sBFg0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSduZtel3yQXTjAa/28x9cDP3vMObvrg2BOmJfdyYUeo
 dzN+f9FO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyYjEjwzH2d28lJ1ydzLyl
 XmadmFieYKotn1+gjSFj6k0PjxLTs4wM7+unKTCEdnnaBRu6t3mzLGj7F6G66Ikdi4yXyRGxpHc
 8AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Chris reported that a walk with LOOKUP_REVAL still opens what a
detached mount covered. 8189ab688f5a ("namei: don't reveal overmounted
entries in refwalk") made the refwalk refuse a name that was unlinked
or renamed over after the walk had found it and skipped the check in
the LOOKUP_REVAL walk because that's the last attempt. But a FUSE
server can hand back -ESTALE from ->lookup() or ->get_link() whenever
it likes. The walk is then repeated with LOOKUP_REVAL and the race can
be won there just the same.

Chris's fix repeats the LOOKUP_REVAL walk for as long as it runs into a
removed name. I pushed back on that. Nothing bounds the loop. A FUSE
server that unlinks the name whenever it's asked to revalidate it and
has it looked up again whenever it's asked to revalidate the parent
keeps a single open() going forever. With a raw FUSE server doing that
one open() did 28452 LOOKUP_REVAL walks in 20 seconds and only came
back once the server stopped.

While looking at this I noticed that the check fires way too often.
dont_mount() is called for every name that goes away, not just for
mountpoints. So every unlink or rename that races with a refwalk sent
it through another full walk with LOOKUP_REVAL and on NFS or FUSE that
revalidates every single component again. Twelve threads opening a
name on tmpfs with O_CREAT while twelve more unlink and recreate it
hit that 463 times in 16.8 million opens.

So this does the following:

(1) Only refuse a name that actually had mounts when it went away.
    __detach_mounts() marks the dentry before it detaches the mounts
    and unlink_may_reveal() only refuses a dentry with that mark. The
    storm above goes down to zero extra walks.

(2) Make the check in every refwalk, including the one with
    LOOKUP_REVAL. The first refwalk still fails with -ESTALE and is
    repeated once with LOOKUP_REVAL. If a name loses its mounts under
    that one as well it fails with -ENOENT. That's the last attempt
    and we don't repeat anything.

    The flip side is that -ENOENT can only ever be spurious if a name
    loses its mounts under the last attempt. Without (1) the O_CREAT
    storm hit that 19 times in 15.7 million opens, with (1) it doesn't
    happen at all. I think that's the right tradeoff.

(3) A selftest with a raw FUSE server that answers the revalidation of
    a name only after it has unlinked it. That makes the race
    deterministic. It covers the LOOKUP_REVAL walk, the plain refwalk
    and the two walks that must not keep going forever.

(4) Symlinks. unlink_may_reveal() was only called when the walk steps
    onto the dentry. A symlink that the walk follows went to
    pick_link() without the check. But move_mount() without
    MOVE_MOUNT_T_SYMLINKS mounts on the symlink itself, so a symlink
    can be a mountpoint like any other non-directory, and the walk
    followed the unlinked symlink to wherever it pointed. The same
    kind of raw FUSE server reproduces that 20 out of 20 times.

Every patch carries its reproducer. All of it ran on a KASAN and
lockdep kernel in qemu: the selftest passes, the reproducers come back
with -ENOENT, and the unlink and rename storms on tmpfs never fail a
walk and never repeat one with LOOKUP_REVAL anymore.

This replaces Chris's patch that's currently sitting in vfs.fixes. And
since 8189ab688f5a is on its way to stable these need to follow it
there.

---
Christian Brauner (4):
      namei: only refuse names that lost their mounts
      namei: check for removed names in LOOKUP_REVAL walks too
      selftests/filesystems: test walks racing the unlink of covered names
      namei: don't follow a symlink that lost its mounts

 fs/namei.c                                         |  38 +-
 fs/namespace.c                                     |   8 +-
 include/linux/dcache.h                             |   3 +-
 .../testing/selftests/filesystems/fuse/.gitignore  |   1 +
 tools/testing/selftests/filesystems/fuse/Makefile  |   2 +
 .../selftests/filesystems/fuse/unlink_reval_test.c | 605 +++++++++++++++++++++
 6 files changed, 640 insertions(+), 17 deletions(-)
---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261012-work-namei-reval-acb9de6e5662

