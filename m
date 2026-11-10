Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272681;
	b=2PT/iI9E+o/Wy+Xd/Xy7O3YvsNqFECmZQupkgbPYtwmQDNt60BMyRLBavc/48k4fEG8k
	 sONNXQmg1XWlW9F6XnEzenwLLiFInjCAdZf2uNXFHBVua5v5huNUmaWf1RuW6cLzRo5e2
	 texHWdatnzzr/VfI6IYOizkRq+m1uCGXFdvwX6pT7r804yqMUNtwKaRDaKJtcgQqv1JUe
	 72fd8Dx2vkhTXROBS9wIijjAX/naAjVrejaJ7ZDNpd1N9kXHVmmgGWnCTkSaPqUgae0gI
	 CoYK/7dVWMUTOQROaKz/GBw6kp6IRUNUjx3WtdeyyMIpR3rYi6Y6J6XRZkB70EtEOVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272681;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6xr/3Ef7UBLna/FFLPRP/baBG1tmFnds3X//aV1e330=;
	b=JUYXNtrHtXZFki4UFueha9yqtysPiLy9vJaLbksq5YDX9Q6KevRpoWTIg359aigEuXrB
	 sWXvpN1k7HSDyo3nRjfkRgaFUJfkzxbaVrVpEh7JPXNECfv9LLtWCgwFqeEkTxENK5j7e
	 stbusBCFw8CnHSAOb8uCqjZznNcXomhPAvOW3WfEhHTzX9gyOgTOguyiIigcGpXQakX1F
	 dR+FtANWKz1rRhaxmK768WnJdpLk2+0+u4lxgHJJyKlG8BxFFFJUsrlAn/MCYR9sGkm18
	 AVeSOZoDLlrA8LpOIFrNeFzsJLSHwg89avjwAYSXtGMAb4ahx9bDM+ZrD++ESb65hCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ar6zHPKu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285BF606A333
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ar6zHPKu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FE21F008A1;
	Tue, 10 Nov 2026 01:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272680;
	bh=6xr/3Ef7UBLna/FFLPRP/baBG1tmFnds3X//aV1e330=;
	h=From:To:Cc:Subject:Date;
	b=ar6zHPKuMNRM8qallQeuJx+BXTepl+YpGMRLCkxFO4YkDTlvY23SCDPuXQqZWB9cu
	 sWXl+/2tC1DyG2M1qG1zS1pdGQcOj6hwGivhvoN+XQ9/CVaWTgph98NZDbKGBNUADk
	 MlONvYh1Z4At2MnkQdgkI87Vwl0Km+uO/73u+w7D3MwKuP/+o3WNcuSkdiwQ2VJOMO
	 LITzUUWcQykeFq6MmZ9boKX4e4GGK2eP9sIsGc3B5EskQfJ2I0b1y1oE+yb52F8ur/
	 mkM0A+qdQqZ+JSX36NeUMwGvxKD4Ue4/hMuIbXqwkTTlZWIpFV5eRPiarWQRVLkYcz
	 SJrSX2/tisp0w==
From: Sasha Levin <sashal@kernel.org>
To: zzzccc427@gmail.com,
	akpm@linux-foundation.org,
	joseph.qi@linux.alibaba.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	heming.zhao@suse.com,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ocfs2: validate move extents against a stable EOF" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:04:38 -0500
Message-ID: <20261109200438-failed-6.18-84db6619cb70@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 84db6619cb702c37cf848b450c21b9c9706b0775
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200438-failed-6.18-84db6619cb70@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 84db6619cb702c37cf848b450c21b9c9706b0775 Mon Sep 17 00:00:00 2001
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 26 Oct 2026 19:04:00 +0800
Subject: [PATCH] ocfs2: validate move extents against a stable EOF

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
---
 fs/ocfs2/move_extents.c | 70 +++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index ad1678ee7cc46..93b45531bf7d8 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -907,6 +907,30 @@ static int __ocfs2_move_extents_range(struct buffer_head *di_bh,
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
@@ -936,6 +960,21 @@ static int ocfs2_move_extents(struct ocfs2_move_extents_context *context)
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
@@ -1028,27 +1067,8 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
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
@@ -1060,23 +1080,11 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
 
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




