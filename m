Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582481;
	b=O+IxYZXs/9B3QF7DhhVdcAlIbKJvI7Cacl/rHIrg8Yv0iCgkUSBYzdsE1m4FiooDoyKF
	 4F0ClXIyuoUIG+mHNt3W9wNZ9fZHGLfBTvCtyC0hGVVSecgnec0krrNCiDkODYLkM6+XT
	 krxIGRJWhCNytVwJ5raCQT3lgywcB1XffgZJfVYzdu9w1ryGq8//SpZ/4VAZifPzIG+1A
	 X30m6C/SMeJO5Y7O4J1VkBxh/xOY6Zrf5rstrwg1zDHJA02UcwVx68pgx44ImwCN4XE/b
	 9YNITunvoxkAofCkZ6HPcWBaiq1wNGf5/1MymR50bKYgI6UX6y1q9lL5bvDdbxsA/Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582481;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R0fnhx5z/2RjXybqLtkKhuTwGuopHil9mZ/rtejlAEY=;
	b=XI098AYxnkHgSIrmBW7H5uysvnmgDptJ2fXm1mdVrsQ4UTLjQtl3xXNia2QUKNOCeJBT
	 sFJLWmUpqjzr181HEAXWcqCsBawPKJ/6b1efQ6RU3mcZD8nSvD6teHt8VV5sm6ok1xGhj
	 gcX7+idW1+jhvSrS1NY0dMgr028rub0tp0aGfenB5sw26Iiytbq4U66aAxkDVpGOblonz
	 aPzvJHXvDrUtKsSqBInsa7QHq2/7mcbpuOS48cDxsr9eZ7/Y0O9zI9JxdyF9gj+/G9Ewv
	 Bs0jWg0uDhHONc0grCEJu8RI4NsmBNjWOinXQuBLagyoaL6vosZudpk3DBUDJ+xos/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBncaMmp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8A7606A89F
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBncaMmp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B277B1F000C4;
	Fri, 13 Nov 2026 15:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582480;
	bh=R0fnhx5z/2RjXybqLtkKhuTwGuopHil9mZ/rtejlAEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RBncaMmpjFGeIy+ees0uBDA2zXh4jGS2bHKvZlD/Gh35i9a5i/LkNHfzqy6J5Hmtb
	 HsRW6kt16G228G3muHOck6g4JV+OzqtrGwxFILMSTWZ76B8HFHMa1NVpA9W0j3NA5H
	 Nv/7N28ldmWRMJ7y6E6y+VFngd6GltT8KLwAuDiumU1aHAzzqylu0H1qaVyok0RDr2
	 dUZ34FoNJHXqmUEz8a9ec088SrU0TQ9Bxk575i+ZMCZVf8ECkupFohkQ3AHk8vDBCB
	 kr3rZTAojVd4m2MPIoc0HwnVG8mv8jHAe4Tao2sowsEgpkxJSByIkp0w/GO9pNNhMB
	 UhP6XSQdKh3gQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cen Zhang <zzzccc427@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Heming Zhao <heming.zhao@suse.com>,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	jjzuming@gmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ocfs2: validate move extents against a stable EOF
Date: Fri, 13 Nov 2026 10:07:58 -0500
Message-ID: <20261113150736.1856589-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200821-failed-6.12-84db6619cb70@kernel.org>
References: <20261109200821-failed-6.12-84db6619cb70@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cen Zhang <zzzccc427@gmail.com>

[ Upstream commit 84db6619cb702c37cf848b450c21b9c9706b0775 ]

The move-extents range must be bounded by the inode size used for extent
movement.  ocfs2_ioctl_move_extents() checks and clamps the request before
taking the local inode and cluster locks in ocfs2_move_extents().  It also
uses separate i_size_read() calls for the range check and subtraction.

A concurrent truncate can invalidate the first check and make the later
unsigned subtraction underflow:

  Move-extents ioctl                  Truncate
  ------------------                  --------
  check me_start <= i_size
                                      take inode and cluster locks
                                      shrink EOF below me_start
                                      release locks
  compare me_start + me_len with EOF
  set me_len = EOF - me_start
    [unsigned underflow]
  acquire inode and cluster locks
  select extents using the bad range

A truncate after clamping can also leave the range extending beyond EOF.
Conversely, the cached size may be smaller than the size refreshed when
the cluster inode lock is acquired.  Early validation can then reject a
valid start or permanently shorten the requested length and threshold.
The me_start + me_len comparison can also wrap for a large input length.

Validate and adjust the original request once, after inode_lock(), the
exclusive rw lock and ocfs2_inode_lock() have stabilized and refreshed the
size.  Read EOF once, reject a start beyond it, and bound the length by
EOF minus start.  Normalize the threshold using the same EOF snapshot.
This keeps zero as the default-threshold sentinel until validation uses
the size that will govern extent movement.

Move goal validation after range adjustment as well.  Its allocation-group
capacity check uses me_len and must see the EOF-clamped length.  Both
validation failures use the existing inode-lock unwind path before any
extent movement or transaction starts.

Range errors now reach the ioctl's normal copyout path, as goal errors
already did.  Unlike the old early rejection, a failed copyout can
therefore override -EINVAL with -EFAULT.

Link: https://lore.kernel.org/pm-ocfs2-move-extents-isize-rrw-v6-395bdee84ea81149068e@gmail.com
Fixes: 53069d4e7695 ("Ocfs2/move_extents: move/defrag extents within a certain range.")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Assisted-by: LLM
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: <jjzuming@gmail.com>
Cc: <stable@vger.kernel.org>
[ sashal: inlined the upstream range-validation helper into ocfs2_move_extents() to avoid adding a new function ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/move_extents.c | 62 ++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index decf14ea21478..279726e5f7cfe 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -906,8 +906,10 @@ static int __ocfs2_move_extents_range(struct buffer_head *di_bh,
 static int ocfs2_move_extents(struct ocfs2_move_extents_context *context)
 {
 	int status;
+	u64 i_size;
 	handle_t *handle;
 	struct inode *inode = context->inode;
+	struct ocfs2_move_extents *range = context->range;
 	struct ocfs2_dinode *di;
 	struct buffer_head *di_bh = NULL;
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
@@ -932,6 +934,35 @@ static int ocfs2_move_extents(struct ocfs2_move_extents_context *context)
 		goto out_rw_unlock;
 	}
 
+	i_size = i_size_read(inode);
+	if (range->me_start > i_size) {
+		status = -EINVAL;
+		mlog_errno(status);
+		goto out_inode_unlock;
+	}
+
+	if (range->me_len > i_size - range->me_start)
+		range->me_len = i_size - range->me_start;
+
+	/*
+	 * The default threshold for defragmentation is 1 MiB, which
+	 * matches the maximum OCFS2 cluster size.
+	 */
+	if (!range->me_threshold)
+		range->me_threshold = 1024 * 1024;
+
+	if (range->me_threshold > i_size)
+		range->me_threshold = i_size;
+
+	/* The goal check depends on the adjusted range length. */
+	if (!context->auto_defrag) {
+		status = ocfs2_validate_and_adjust_move_goal(inode, context->range);
+		if (status) {
+			mlog_errno(status);
+			goto out_inode_unlock;
+		}
+	}
+
 	/*
 	 * rememer ip_xattr_sem also needs to be held if necessary
 	 */
@@ -1024,49 +1055,18 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
 		goto out_free;
 	}
 
-	if (range.me_start > i_size_read(inode)) {
-		status = -EINVAL;
-		goto out_free;
-	}
-
-	if (range.me_start + range.me_len > i_size_read(inode))
-			range.me_len = i_size_read(inode) - range.me_start;
-
 	context->range = &range;
 
-	/*
-	 * ok, the default theshold for the defragmentation
-	 * is 1M, since our maximum clustersize was 1M also.
-	 * any thought?
-	 */
-	if (!range.me_threshold)
-		range.me_threshold = 1024 * 1024;
-
-	if (range.me_threshold > i_size_read(inode))
-		range.me_threshold = i_size_read(inode);
-
 	if (range.me_flags & OCFS2_MOVE_EXT_FL_AUTO_DEFRAG) {
 		context->auto_defrag = 1;
 
 		if (range.me_flags & OCFS2_MOVE_EXT_FL_PART_DEFRAG)
 			context->partial = 1;
-	} else {
-		/*
-		 * first best-effort attempt to validate and adjust the goal
-		 * (physical address in block), while it can't guarantee later
-		 * operation can succeed all the time since global_bitmap may
-		 * change a bit over time.
-		 */
-
-		status = ocfs2_validate_and_adjust_move_goal(inode, &range);
-		if (status)
-			goto out_copy;
 	}
 
 	status = ocfs2_move_extents(context);
 	if (status)
 		mlog_errno(status);
-out_copy:
 	/*
 	 * movement/defragmentation may end up being partially completed,
 	 * that's the reason why we need to return userspace the finished
-- 
2.53.0

