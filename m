Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D92483BCD;
	Wed, 14 Oct 2026 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007127; cv=none; b=fEo//vDnnOhNJ4SeKnok8hlaEnLIoAqzePxrQ1Q2BQ+6L6OhvYEbT33q18WpVmzev48epaqBhmdbk9i+gYUydROsCripBA49WZmAuLeHG5dLBmokho7BosszKAapjhUoZkdWlNehmfh2RgvACqerwcYrrUWAYW6Iy/sBlKysW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007127; c=relaxed/simple;
	bh=fB80VoyJ5Km8aDO7VVGaC6up1GHaBbJic0k2rSAP1pA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VCPJZAXj1AZNFUExT3as+TE3q/4ekHLFCxmpkzyxS+t48e3Md8J1l+0N47dStkj2P8e2zD0LQMaAQd0nA/UfgJP9XKWM+wzQrLwfh1GbrHK3PcbDrwCr1I07Xzunia9f5fx6G7l34H1whzIwE0WTuSCAkLJuxWalhgQEn5htU6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9ZcMxDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9ZcMxDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F211F000C4;
	Wed, 14 Oct 2026 19:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792007125;
	bh=1A2hGUazCur6Y+hdoVY3V2GDYsLGpZiUcMU5T8N8Ohg=;
	h=From:Subject:Date:To:Cc;
	b=c9ZcMxDi6x3e6YWGSYu9hcrZ0dq1xhHOnaOvL52Hl7JiTuuOxd1sBqlr8N53vGDCp
	 8963Fog2OIVGa2KGNuGaxQF4hAFtve8dwIF1ZjAhQbSuKKDM95lCJfx7IoZh2I6CX3
	 yZGgdyimfMT76uIEZgjgmrzs/fpCrFpYEUH72KIC1fgoYU1+VhEJBAi+YPpb7GBhDR
	 eqWa4oCLiaMllvFp3t5XU9g03znBGuDMV91Xrt+GOWP+RmMBTE3rhR2AElY55xcLI/
	 R/GNg3TyTe/KYh/eSWaUKVOFIHYSs68KrErzkLLViznpLI5QaTjIjp79bY4bRkP6+w
	 RxQH4HarBh5iA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] namespace: a mount that copy_tree() leaves out can't
 take over a lock
Date: Wed, 14 Oct 2026 21:45:12 +0200
Message-Id: <20261014-work-namei-locked-mnt_ns_file-v1-0-24035bd5d8e9@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMUQ6CMBAFr0L67ZqWVBK8ijGkLVtZgdZ0EU0Id
 7eVz3l5M5tgTIQsrtUmEq7EFEMGdaqEG0x4IFCfWdSybpRUGj4xjRDMjARTdCP2MIelC9x5mhD
 kBbVqtXdto0VuvBJ6+v77t/vB/LZPdEuJloc1jGCTCW4o0+r5fBj7/gN1wr7hnQAAAA==
X-Change-ID: 20261014-work-namei-locked-mnt_ns_file-05e4194fc964
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neil@brown.name>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2628; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fB80VoyJ5Km8aDO7VVGaC6up1GHaBbJic0k2rSAP1pA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSdv32h2kBi5g9RteVTpkdNZKu+cE0twTHO2mPR9r2+2
 5cuf/L+QEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEao8z/DPV526tNFR/xZ9i
 +eTam9LkJ7ecpHRqZgrIFu65nRjQIMrIsLZh252ACRt375iid0/vb8+WzvWhkndv7S1NmS6vwr2
 2nh0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Since commit c62a4766937e ("move_mount: transfer MNT_LOCKED") a mount
can be moved beneath a locked mount. The lock moves from the old cover
to the new mount which takes over the job of hiding what's under it and
the old cover can be unmounted. That works as long as the new mount
stays. But the caller picks the new mount and copy_tree() leaves a
mount of a mount namespace file out of every copy made without
CL_COPY_MNT_NS_FILE, together with everything mounted on it, and never
looks at MNT_LOCKED. unshare(CLONE_NEWNS) and mount propagation make
such copies.

So a task that is root in its own user namespace gets rid of a locked
cover on a file without a race and without touching the filesystem
below it. It makes a child with a mount namespace of its own, binds the
child's /proc/<pid>/ns/mnt beneath the cover with MOVE_MOUNT_BENEATH,
which hands the lock to that bind, and calls unshare(CLONE_NEWNS). The
new mount namespace has nothing on the file. That's the usual way to
mask a single file, a bind of /dev/null or of an empty file. With a
bind of an ordinary file the file stays covered.

copy_tree() already refuses to leave out a locked unbindable mount with
-EPERM since commit df7342b24018 ("mount: Don't allow copying
MNT_UNBINDABLE|MNT_LOCKED mounts"). Do the same for a locked mount of a
mount namespace file. That also covers a tree copied with
CL_COPY_MNT_NS_FILE and attached into a mount namespace of another user
namespace where lock_mnt_tree() locks it. Note that unshare(CLONE_NEWNS)
and clone(CLONE_NEWNS) fail with EPERM from such a mount namespace from
then on. The mount can't be left out and it can't be unmounted.

And refuse to move a mount of a mount namespace file beneath a locked
mount in the first place. Otherwise the task ends up with a mount it
can't unmount and an unshare() that fails for good.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neil@brown.name>
To: linux-fsdevel@vger.kernel.org

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      namespace: a mount that copy_tree() leaves out can't take over a lock
      selftests/filesystems: test that a mntns file can't take over a lock

 fs/namespace.c                                     |  19 +++-
 .../umount_propagation/locked_mount_test.c         | 122 +++++++++++++++++++++
 2 files changed, 139 insertions(+), 2 deletions(-)
---
base-commit: 6e1ed4690110a546ea699792ff1307decce7611c
change-id: 20261014-work-namei-locked-mnt_ns_file-05e4194fc964

