Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC8731280C;
	Sun, 11 Oct 2026 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734193; cv=none; b=DvL5WBl08OXM2NWFU4mcQq9c1cHjlb1P6l6/Lr8kuksGQZLPjObu8Am1CRM2unhIpYQwq+auDpfbS3w1JjodrJR0Ttz8t7rjJXcUb4uuZwqxe95IwsqeGty0dJ3Rcb2aAA3gkHYVAIgkt9EzRU8PK02DIOf5nUqkB9ruNCcOvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734193; c=relaxed/simple;
	bh=gp5L9cDtTd4mqQjDdR4ZrS6jU2yXiEEVUUteA59hMlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUA46itgBH1gt3rt8/GvOLQS5t1ZCV1xwLYB79Yq+1rx+nSJclEzAIACMztLNjruBTc2cXK7CEZOMqxTWLk5KZUeKZ7Y2fTwCgo3P7z9uZ58+rl0kgbGDXxq+0N2ysoOjFZ+sm8HtymObKiEg8fcC4Ti0vvT2vN44DBOi1f3eNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4cCpcC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4cCpcC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464931F0089D;
	Sun, 11 Oct 2026 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791734191;
	bh=Hnz/cK5XE5xm/+ataBhwKuQGRyJwRuji8SpWChYhuqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L4cCpcC1i7GgRtoDQ8xkB0P5drbkaERicw2sNzCnQz4YiT7chv2pcznfUxzYwIvVB
	 Og3zEXWnH2ifZZEbZVbuVZj6tlaO3NTXH02l7CnGmWUYhNTUc1TEaK2ONf32t4bzkn
	 XNG/AB+3lgkSV725GOWh5W4DRv9dl64I8FkCyALa7q4uuNEjJFqXt6cucoTjI5SkSm
	 /453o7J3J/2tmnlQ1OwOEGUugsjw41nFP2gL2LFljUVfIsu4AaosySedGRGp6v0kGa
	 brFioz/DY3CeRiJMy7KxkAuz+xF2uCkBktjukiu1ekTDhtIE0qlxBnT2oGyG8y/dfD
	 NyeTdqGrBAabw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:56:09 +0200
Subject: [PATCH 09/15] fs: don't keep a device frozen when its freeze is
 already gone
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-super-fixes-core-v1-9-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3444; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gp5L9cDtTd4mqQjDdR4ZrS6jU2yXiEEVUUteA59hMlE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd3jjnueKnAxfvO5YZB/3ivmb4/srKuhdCqs8O3Hm57
 8/KL+fmGnSUsDCIcTHIiimyOLSbhMst56nYbJSpATOHlQlkCAMXpwBMJEaF4Qt3R6rK6+h/n+7w
 NRgeUfjPsGiXf1+Fyuki1ZXmD3h7ehj+h3/an8C9WeD8VfOXLovvrWf9mbFr38F/zxsf/JncpC1
 gzwQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Device-mapper and the filesystem shutdown ioctls freeze the filesystems
on a device through bdev_freeze() and fs_bdev_freeze() freezes each
superblock with FREEZE_HOLDER_USERSPACE | FREEZE_MAY_NEST. That's the
same holder FIFREEZE uses. So FITHAW can drop that freeze while the
device is still suspended. qemu-guest-agent's guest-fsfreeze-thaw does
just that as it issues FITHAW on every mount until it fails. An
emergency thaw does the same. do_thaw_all_callback() only thaws the
device freezes of sb->s_bdev and then drops the remaining userspace
freeze of the superblock which may belong to any other device of the
filesystem, an external log or journal device or another btrfs member.

The device's bdev_thaw() then calls fs_bdev_thaw() which gets -EINVAL
from thaw_super() since there's nothing left to thaw. bdev_thaw() takes
that to mean that the device is still frozen and keeps
bd_fsfreeze_count elevated and device-mapper ignores the error. So the
device stays frozen for good and every later mount of it fails:

  dm-0: Can't mount, blockdev is frozen

fe967191e585 ("fs: don't return -EINVAL for successful nested thaw")
fixed the same outcome for a freeze that nested with FIFREEZE. A freeze
that lost its hold behind the device's back still ends up there.

Treat -EINVAL from thaw_super() in fs_bdev_thaw() as the freeze being
gone already. There's nothing left to thaw for the device then. Before
fs_bdev_thaw() existed thaw_bdev() kept the count on the same error.

Fixes: 49ef8832fb1a ("bdev: implement freeze and thaw holder operations")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 82290d094c03..ac4c4d067509 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1494,10 +1494,29 @@ static int fs_super_freeze(struct super_block *sb)
 
 static int fs_super_thaw(struct super_block *sb)
 {
-	if (sb->s_op->thaw_super)
-		return sb->s_op->thaw_super(sb,
+	int error;
+
+	if (sb->s_op->thaw_super) {
+		error = sb->s_op->thaw_super(sb,
 				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
-	return thaw_super(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
+		/* -EINVAL means the freeze is gone already. */
+		if (error == -EINVAL)
+			return 0;
+		return error;
+	}
+
+	/* The caller holds an active reference. */
+	if (WARN_ON_ONCE(!super_lock_excl(sb)))
+		return 0;
+
+	/* FITHAW or an emergency thaw may have dropped the freeze already. */
+	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE ||
+	    !sb->s_writers.freeze_ucount) {
+		super_unlock_excl(sb);
+		return 0;
+	}
+	return thaw_super_locked(sb, FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE,
+				 NULL);
 }
 
 static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
@@ -1610,7 +1629,8 @@ static int fs_bdev_freeze(struct block_device *bdev)
  * frozen more than once (by the kernel or via another device).
  *
  * Return: 0, or the first error on a single-fs device; a shared device swallows
- *         per-superblock errors, as fs_bdev_freeze() does.
+ *         per-superblock errors, as fs_bdev_freeze() does. A superblock that
+ *         lost the freeze already, e.g., to FITHAW, counts as thawed.
  */
 static int fs_bdev_thaw(struct block_device *bdev)
 {

-- 
2.53.0

