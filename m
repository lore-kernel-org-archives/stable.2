Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752357;
	b=HO3JrgLEKd4jTmcymQEb0CLlYheI7xSnI1/tk3z0BCKPCjB1ENZouqMKm+nuG5W9SdNJ
	 BM7ilF/a+dYY9n/47DAjNJOyUaQYGOIWvVL5w82sXrsIKmtmYAZ1nK274yI6NSQiIbOzT
	 dU30V7Seq2kAxsjJQhGFuyLApy5mXex1s7GV2oFbDvxTV0nSfC8DRjOfagMceOUAEF/7G
	 XVKCZwXAJU71gsAgbQW/ROZCdC2YwCSuJpyU+x/bn0clwcssw2WpGkWSf/FR0eqqPsUdS
	 oXTKvnBOCaB6tIAZh+q701v8DTmiB9lXq2hooDVTHH8XL9MgA3ENTIe9CUIXRZl1zmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752357;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mb3CB6qJDKu5QRzsIctm9N+SbqQivArh/RJkDo3osqI=;
	b=wsjTTPB+gRnfYFi6+rfct0kCmxIYDxhKTpxF8x1YIoTYX/0cc8gat15bcmstSTJVxy/k
	 gLnVLjKNl1VB/mhyIQIDEro9V37nnf31HDa+wQEfbGRP+ij9zDmhuqXhSx8Yk8vGnmXzU
	 Dt+ueZ1NIgnu7L5KwJ/g4qLNib6dAjvo8/cSLrxSM5aC6zXxgWHQS/sPQUqNfnHl8XQ8Q
	 PJWWOqZJsgT7n0syyeckdIlejaYRhOrBk0BtY/r9B1eWTzqV4aJNzXq6Y/iwPmrmUyxtq
	 ioC8F+jYYQnGI3cAHHvrFzDgKlhp4Ux9YKOusMvVwRCo2AsHatf2jq/nRr8Ve/UPgpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M24SvAMx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161D606A31D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M24SvAMx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AD71F000C5;
	Sun, 15 Nov 2026 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794752357;
	bh=mb3CB6qJDKu5QRzsIctm9N+SbqQivArh/RJkDo3osqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M24SvAMxf8XTGZLfhAfL2iO6twQ9zr7dgZpj1lDmso2mSxRanHpxhUdadAi/ZvvPk
	 tMzv1DPR66n7Yv7qQCX5ZBH25r8MAniuGCXkskzjWvDyk3VGMSmVtT7DhDCFAmPvbQ
	 +3PdY515fvmxhQ7+EigcX9xrBBRVXvT+hghV9BHtDrtEaEmcXHa2ysM4bgGPkn0Q87
	 uQ58EcCIedcKAhrau7pJgLfcZWrHWy9XEtqTVyVLQ+ld2F57OW3G7nvgUpW3SecYmr
	 kta05Ia+ZD7TLT1W8Uobq+DiBnSY2fdmiXXB3y6J/YA7uwdp56FYozftImYe83quSn
	 dELzund9hayOg==
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
Subject: [PATCH 5.15.y 3/3] ocfs2: validate move extents against a stable EOF
Date: Sun, 15 Nov 2026 09:19:12 -0500
Message-ID: <20261115013217.675970-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115013217.675970-1-sashal@kernel.org>
References: <20261109202229-failed-5.15-84db6619cb70@kernel.org>
 <20261115013217.675970-1-sashal@kernel.org>
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

A truncate after clamping can also leave the range extending beyond EOF.
Conversely, the cached size may be smaller than the size refreshed when
the cluster inode lock is acquired.  Early validation can then reject a
valid start or permanently shorten the requested length and threshold.
The me_start + me_len comparison can also wrap for a large input length.

Validate and adjust the original request once, after inode_lock(), the
exclusive rw lock and ocfs2_inode_lock() have stabilized and refreshed the
size.  Read EOF once, reject a start beyond it, and bound the length by
EOF minus start.  Normalize the threshold using the same EOF snapshot.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/move_extents.c | 70 +++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index 32364234ae66d..96d9e78e5f547 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -903,6 +903,30 @@ static int __ocfs2_move_extents_range(struct buffer_head *di_bh,
 	return ret;
 }
 
+static int ocfs2_validate_and_adjust_move_range(struct inode *inode,
+						struct ocfs2_move_extents *range)
+{
+	u64 i_size = i_size_read(inode);
+
+	if (range->me_start > i_size)
+		return -EINVAL;
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
+	return 0;
+}
+
 static int ocfs2_move_extents(struct ocfs2_move_extents_context *context)
 {
 	int status;
@@ -932,6 +956,21 @@ static int ocfs2_move_extents(struct ocfs2_move_extents_context *context)
 		goto out_rw_unlock;
 	}
 
+	status = ocfs2_validate_and_adjust_move_range(inode, context->range);
+	if (status) {
+		mlog_errno(status);
+		goto out_inode_unlock;
+	}
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
 	 * remember ip_xattr_sem also needs to be held if necessary
 	 */
@@ -1024,27 +1063,8 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
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
-	 * ok, the default threshold for the defragmentation
-	 * is 1M, since our maximum clustersize was 1M also.
-	 * any thought?
-	 */
-	if (!range.me_threshold)
-		range.me_threshold = 1024 * 1024;
-
-	if (range.me_threshold > i_size_read(inode))
-		range.me_threshold = i_size_read(inode);
-
 	if (range.me_flags & ~(OCFS2_MOVE_EXT_FL_AUTO_DEFRAG |
 			       OCFS2_MOVE_EXT_FL_PART_DEFRAG)) {
 		status = -EINVAL;
@@ -1056,23 +1076,11 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
 
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

