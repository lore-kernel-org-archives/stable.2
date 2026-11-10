Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325442;
	b=tcmK+b2J/ADY7q1z575AB0vXrF71659nEiEx+7g7+LCfYF2FVqiSxtE/K0XeNNXYPTXt
	 QKf58+9YF7UWPDIYYD88R9ii7O/HlRpzQE9fu0Sk6Zybh8v9Fqwg7mxkAr9/RKQGeZrrX
	 cO+5Bp4eqWBeAGfve0Bro+MonzPQ1bx039G6z63dW4F3c7O6Fs8uux28smoBmrxPrSm9k
	 VWG0SKvuO3GR+SiP2qRKDqyQinka6ScGCoQPI6xaQelEL/K7uGzwJdx6Sg8Zstrg8T8AY
	 ECWNoL0vNrIHtCWkcfjHtrRkhmxQQAqmCLjHkK7E6TfCSUzLBAogz/bROlZ42jhWWdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325442;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NFzbKR1BzjRcOigbHcd7SaSLPyCWEMzqsFmKX44LJ5w=;
	b=niiPfARawl9z6f13lq3KNaNQtsfTDQHTFv3ODIyF3w8QpA+BFDN5h/cEue0tKrmgF/Qo
	 ChaY63QU4i9z5u3UeRiaBkxOFzAkYrRlX1tDdFMw6d24EOoV4qnaC1LuS2OqpMqfRAcKP
	 0zGzPSNwPU8LlCVjBlptshNGsbafN59roulWECY51PyZtjizxvDCp2UzzOWghy1tvfwhe
	 wEQBeQ3FeIWw7zsymNH086uAOs6sWR6/FcBiH2MSpAOgDt5s/7TADf6HjCec+lmAgpiXc
	 LuZG5oR8GNbnl//q7CNRgf8QZrEIyHCNl48K6V7h/iKQ9wzENG0NXaOQaY+M40flwiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6BzTA2J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E26606AB6C;
	Tue, 10 Nov 2026 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6BzTA2J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E571F0089F;
	Tue, 10 Nov 2026 15:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794325441;
	bh=NFzbKR1BzjRcOigbHcd7SaSLPyCWEMzqsFmKX44LJ5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T6BzTA2JTc1cIvcS9Sl4G+IKA3KNe0wXULhkywst5Fqk30JG5NrxvvHXzxtKZpRqA
	 uDFfXT2GAMhhIorI+o9x2xWN/ogvB5zd8aTDmuCzulLWNHT+2pNMhFqzTiKmuVZ0so
	 d/0gfOJn+4GXPtO8Mz2fejyAInC8ivozdpmkPcoM8xqoOBG/giI6PODGpbn4AWmUfG
	 wYP4HQQGkDa1Y33YxCfDAcsDWSbfcYeOWvPhKte3vMlf6rc5fqjMHPlBINOvA03WhD
	 Z/A2aIt90Xd6PSZDn+wr9lIyZM1R3QDMSx5xh29A4yWvMPvzXkzhPEMlfL0YMvBn2P
	 lYrZb0VIFpwlg==
Date: Tue, 10 Nov 2026 16:43:57 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev
Subject: Re: [PATCH 09/15] fs: don't keep a device frozen when its freeze is
 already gone
Message-ID: <20261110-innenansicht-lohnen-rupfen-dec970baed12@brauner>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
 <20261011-work-super-fixes-core-v1-9-c727176c5b53@kernel.org>
 <yl2umpbk6fnz2soh7fi5xellmovarx6ouxrvf4ki5xxledmihx@gjldiqbxpufn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <yl2umpbk6fnz2soh7fi5xellmovarx6ouxrvf4ki5xxledmihx@gjldiqbxpufn>

On Thu, Oct 22, 2026 at 12:33:29PM +0200, Jan Kara wrote:
> I'd just note that interpretting EINVAL from ->thaw_super is a bit of
> an adventure but so far only gfs2 implements that and that looks safe.
> Using some less abused error code to mean "already thawed" would be
> probably more robust in the long run...

Something like the below?

From: Christian Brauner <brauner@kernel.org>
Date: Tue, 10 Nov 2026 16:39:31 +0100
Subject: [PATCH] super: return -EALREADY for a thaw that finds nothing to drop

thaw_super_locked() returns -EINVAL when the superblock isn't frozen and
also when it is frozen but not by the holder that asks to thaw it. gfs2's
->thaw_super() returns -EINVAL as well when this node never initiated the
freeze. So when fs_super_thaw() thaws the superblocks of a block device
whose freeze is gone already -EINVAL from ->thaw_super() is all it has
to go on and it has to guess that this is what happened.

Use -EALREADY for a thaw that has nothing to drop. Nothing in the freeze
and thaw code returns it so far and it clearly communicates what
happened. A freeze that is held by someone else keeps returning -EINVAL.

FITHAW has always reported an unfrozen filesystem as -EINVAL and
fsfreeze and qemu-guest-agent rely on that, so ioctl_fsthaw()
translates. The other in-kernel callers thaw their own kernel freezes
and pass the error on without looking at it.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/yl2umpbk6fnz2soh7fi5xellmovarx6ouxrvf4ki5xxledmihx@gjldiqbxpufn
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 Documentation/filesystems/vfs.rst |  4 +++-
 fs/gfs2/super.c                   |  2 +-
 fs/ioctl.c                        | 10 ++++++++--
 fs/super.c                        | 11 ++++++++---
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 1824462a43711..e6d332fa17be9 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -294,7 +294,9 @@ or bottom half).
 
 ``thaw_super``
 	called when VFS is unlocking a filesystem and making it writable
-	again after ->freeze_super. Optional.
+	again after ->freeze_super. Optional. Return -EALREADY if there is
+	no freeze to drop. The VFS relies on that when it thaws the
+	filesystems of a block device.
 
 ``unfreeze_fs``
 	called when VFS is unlocking a filesystem and making it writable
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 04bb4cf787d4d..ce0eb4d1a7031 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -806,7 +806,7 @@ static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who,
 		return -EBUSY;
 	if (!test_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags)) {
 		mutex_unlock(&sdp->sd_freeze_mutex);
-		return -EINVAL;
+		return -EALREADY;
 	}
 
 	atomic_inc(&sb->s_active);
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 1c152c2b1b67d..56acaa122ec4d 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -402,14 +402,20 @@ static int ioctl_fsfreeze(struct file *filp)
 static int ioctl_fsthaw(struct file *filp)
 {
 	struct super_block *sb = file_inode(filp)->i_sb;
+	int error;
 
 	if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/* Thaw */
 	if (sb->s_op->thaw_super)
-		return sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE, NULL);
-	return thaw_super(sb, FREEZE_HOLDER_USERSPACE, NULL);
+		error = sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE, NULL);
+	else
+		error = thaw_super(sb, FREEZE_HOLDER_USERSPACE, NULL);
+	/* FITHAW has always reported an unfrozen filesystem as -EINVAL. */
+	if (error == -EALREADY)
+		error = -EINVAL;
+	return error;
 }
 
 static int ioctl_file_dedupe_range(struct file *file,
diff --git a/fs/super.c b/fs/super.c
index cd6f57ababe08..72ffa5527dda2 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1640,8 +1640,8 @@ static int fs_super_thaw(struct super_block *sb)
 	if (sb->s_op->thaw_super) {
 		error = sb->s_op->thaw_super(sb,
 				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
-		/* -EINVAL means the freeze is gone already. */
-		if (error == -EINVAL)
+		/* The freeze is gone already. */
+		if (error == -EALREADY)
 			return 0;
 		return error;
 	}
@@ -2587,8 +2587,11 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
 {
 	int error = -EINVAL;
 
-	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
+	/* There's no freeze to drop. */
+	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
+		error = -EALREADY;
 		goto out_unlock;
+	}
 
 	if (!may_unfreeze(sb, who, freeze_owner))
 		goto out_unlock;
@@ -2652,6 +2655,8 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
  * A filesystem may hold multiple devices and thus a filesystems may
  * have been frozen through the block layer via multiple block devices.
  * The filesystem remains frozen until all block devices are unfrozen.
+ *
+ * Returns -EALREADY if the filesystem isn't frozen.
  */
 int thaw_super(struct super_block *sb, enum freeze_holder who,
 	       const void *freeze_owner)
-- 
2.53.0


-- 
