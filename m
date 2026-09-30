Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C175E4DD3B3;
	Wed, 30 Sep 2026 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775143; cv=none; b=citfgR68SXAOjrLO6oTgdreWOEEmbyMfv+EEOi+vZ4jEdV3lh7Bf3jCCH8jynCaUBtSRAuZeTvOpeVFT9Km48caAYUUzlqye0K/+kIU8gT4xMMxh/EifuZQySCQzLaAAv0WNsXl/QWAJ22lI62C94LWzVMNyCLwzFGcffG/aPVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775143; c=relaxed/simple;
	bh=+67AVe5ElD3UBqSlav4fSxNB8JZZlmunUgcf14fm1EE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=njGpKaN6XtGTOs4G76CV9GSeEu7Xqz3+ITTNAL8EK0BMf0kFqeDFZZu4OArfS98ah1yF/BYUru3Ywb1Z6xQWBNlytm4MJRbbn0PcXXuO/X0Inz/gaCdEXY0JaYgh2kpr5malCeb8MGq3vKB1nxSCf6LxcQCU36Dlgt/SOhsmC40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZLU3G64; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZLU3G64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0544B1F0089A;
	Wed, 30 Sep 2026 13:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775135;
	bh=7DJ0W00xWEifFk6h4thYf3rvLOHkivC3kcWn3M6xvf0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LZLU3G64T9m70Csb6hLl7a5mCfw7DsSje69w4bY+OThb5jBhbwoDAt/Nq9HXm/EEn
	 tvLIUPs3D34xtga/FWvJpjYgaEJIVy2x6LMfxk4VF/jwBLrkXR+bL1zEti38FrOpvr
	 lmRDq/qhUiCz+bnOqqpythqlHPueB3zUFfX5WkW/llr69nQjkGVnYKRsy5HAMUWXQq
	 Z7ZIBRwI8aKobKCwpmXOXoXxzg9zGk1qMLKNABH9Tmx3ffvMOc1/cEbh+9rrGhxyOW
	 A1w1ANG5JC1u9RGvns9X+1iYVig0W8E/ZUKsGgi+z/6/lmKNhymxlAyxq3lLUUceyW
	 cQqn4riFbpyxA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Sep 2026 15:31:56 +0200
Subject: [PATCH 04/17] namespace: check a recursive bind mount for mount
 namespace loops
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-work-mount-fixes-3-v1-4-be34c83956ae@kernel.org>
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
In-Reply-To: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>, Amir Goldstein <amir73il@gmail.com>, 
 bpf@vger.kernel.org, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2546; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+67AVe5ElD3UBqSlav4fSxNB8JZZlmunUgcf14fm1EE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt5ff3XHn4mebx+/HnMvbejP8/x/Cpzo2UxtInB2Y8X
 LBE83D2kY5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJSK9j+Cs4jbFglTmvWdnr
 TysPX1B+fsui9JFZhXVdxXp9oa2cp/Yz/I/d8uKEwD0uX4neaW3Tvn76fyvq4z/nsunv3pv18Ha
 preMDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

do_loopback() refuses to bind mount the file of a mount namespace that
is as old as the caller's or older because a mount namespace that holds
a mount of its own file, or of an ancestor's, would cause a cycle. But
it only checks the dentry the bind mount starts from. With MS_REC
everything below it is copied and do_loopback() passes
CL_COPY_MNT_NS_FILE so mount namespace files below the source are
copied.

That's fine for a source in the caller's own mount namespace. Every
mount namespace file in there passed the same check when it was
bind-mounted. It isn't fine for a source in another mount namespace.
may_copy_tree() accepts a bind mount of any nsfs or pidfs file no matter
what mount namespace it lives in so that /proc/<pid>/ns/<ns> and pidfds
can be bind mounted. If we create a bind-mount stack of mount namespaces
file descriptors the kernel will copy them irrespective of their
ancestoral relationship to the mount namespace in question:

  151 146 0:7 net:[4026531833] /tmp/nrc/y rw - nsfs nsfs rw
  152 151 0:7 mnt:[4026532293] /tmp/nrc/y rw - nsfs nsfs rw

Mount 152 is a mount of the mount namespace file of mount namespace
4026532293 inside mount namespace 4026532293. That namespace and every
mount in it are leaked... All it takes is a process in an older mount
namespace that stacks the file and repeating it leaks without limit:

  after control: Shmem:               380 kB
  child: mount(/proc/self/fd/6, MS_BIND|MS_REC): ok
  after cycle: Shmem:             65916 kB

do_move_mount() runs check_for_nsfs_mounts() over a detached tree for
exactly that reason. Do the same for the copy before it is grafted.

Fixes: e149ed2b805f ("take the targets of /proc/*/ns/* symlinks to separate fs")
Fixes: ef4144ac2dec ("pidfs: allow bind-mounts")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 23d3bfa9c14d..c2f54636ec9d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3055,7 +3055,11 @@ static int do_loopback(const struct path *path, const char *old_name,
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
-	err = graft_tree(mnt, &mp);
+	/* the copy may carry mount namespace files from below the source */
+	if (recurse && !check_for_nsfs_mounts(mnt))
+		err = -EINVAL;
+	else
+		err = graft_tree(mnt, &mp);
 	if (err) {
 		lock_mount_hash();
 		umount_tree(mnt, UMOUNT_SYNC);

-- 
2.53.0

