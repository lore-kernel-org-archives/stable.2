Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297104BE43D;
	Fri,  2 Oct 2026 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949239; cv=none; b=gjaDCxd/uNfcs9vne6DGaYIl/2o/K4LUlnmSI28xrUG8bAT2hlH9uPEq7PwPv764d2B3I79UFY9JbkG4C7xkHJFNCspBUc07mPe4Qyr2t4WbEMO3HTOQi8MolEokslB3tF1jTA8Bp4SiKbbVC50orC8YH8QURaqQn8s5ZwemEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949239; c=relaxed/simple;
	bh=Rw6uI/ifdDHr+gkp+6V7jfIynd26cOc+rXpMydM4j2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Badaq9+FtxJezZhufaMMi9PH/IQNIRET/5Mr7mfU9Hm7YZRbxUge6++Hei9RoEDY/iUrLYUE0PsnwwcvbkaEP4M+jsKWD4NuOMWNFVK8I5EFBXcLZD0exKrzNtDJWBQtphX0/n2rTXUg8tNIXhLeZTAu4CDmunWajReVGk7+COI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+EBxs+o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+EBxs+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFC21F00893;
	Fri,  2 Oct 2026 13:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949235;
	bh=ZOA2Kcgb8Qw0J9oRsc577paFlpXQEG9eq0unvALi3O0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d+EBxs+otmn4yVodYXPU+7SllLpBy4+r3wfmdo5np8mERSi2JiJ3Uqv6SP82ydw20
	 fi1qbnzA8Pn+WAfp7n+05g9eYeuEkSnGaf2FTQufbmem/jj47M/LMJP9wMIoN6Kqnm
	 narQS86mh/TraDR1znB7wxZ3TDEP+VzYJOEOEpGjQXPjLoDg1IugTuWxaMLMahXoxz
	 d9mH0gRO1QmNawW98dvYPkumx5BYWsw6SSiCm+E2qVkHfHGCghNXJhH5AHMyPlqDfP
	 0xceVQcLB2h2FmtKbC6KJ91ii733jDZ2NdnLbhg8BLLJ1BYSStBcjfVRIEoCfb/nJ5
	 4uWPCY0IBXTxw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:39 +0200
Subject: [PATCH 08/21] namespace: never expire a locked mount
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-8-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2440; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Rw6uI/ifdDHr+gkp+6V7jfIynd26cOc+rXpMydM4j2I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x55LVr2pxZnyNpHCYs61wZs4du56m6szub+LXI+7
 y89rON70lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARFy6G/9k9TNuETpwK9V26
 5iFDveqyinNNhd+27bf6csdistaDTi9GhjXHNN9u6QyZcWz+27N3d3C+ZDxy9+zmLct+VISb82/
 zY2cEAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Locked mounts are special. They protect the underlying files and
directories from being revealed. do_umount() refuses to unmount locked
mounts but shrink_submounts() doesn't.

A shrinkable mount can become locked once the owner of a user namespace
puts it beneath a locked mount with MOVE_MOUNT_BENEATH. The locked
property now moves to the mount at the bottom making it possible to
unmount the top mount.

So umount() of an unlocked ancestor now expires the bottom mount first
and the covered directory is revealed:

  move_mount(c -> x/hidden, MOVE_MOUNT_BENEATH) = 0
  the cover after the lock moved:  umount2(x/hidden) = 0
  the holder of the lock:          umount2(x/hidden) = EINVAL
  the root of the copy, busy:      umount2(x) = EBUSY
  reads x/hidden/secret: "covered-by-root"

So leave a locked mount alone as it dies together with its parent. A
plain umount() of an unlocked mount with a locked one below it is EBUSY
from now on. It's the same for any other locked child. A lazy umount
still takes the whole tree.

mark_mounts_for_expiry() never sees a locked mount. lock_mnt_tree()
leaves a mount on an expiry list alone and nothing else puts a locked
one on such a list. Add an assert for this.

Fixes: 5ff9d8a65ce8 ("vfs: Lock in place mounts from more privileged users")
Fixes: c62a4766937e ("move_mount: transfer MNT_LOCKED")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 27bf8665ed58..e74e63466c24 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4032,6 +4032,8 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 	list_for_each_entry_safe(mnt, next, mounts, mnt_expire) {
 		if (!is_mounted(&mnt->mnt))
 			continue;
+		/* lock_mnt_tree() leaves expirable mounts alone */
+		VFS_WARN_ON_ONCE(IS_MNT_LOCKED(mnt));
 		if (!xchg(&mnt->mnt_expiry_mark, 1) ||
 			propagate_mount_busy(mnt, 1))
 			continue;
@@ -4058,7 +4060,8 @@ EXPORT_SYMBOL_GPL(mark_mounts_for_expiry);
  */
 static bool shrink_submount(struct mount *mnt)
 {
-	if (propagate_mount_busy(mnt, 1))
+	/* not the kernel's to remove either */
+	if (IS_MNT_LOCKED(mnt) || propagate_mount_busy(mnt, 1))
 		return false;
 	touch_mnt_namespace(mnt->mnt_ns);
 	umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);

-- 
2.53.0

