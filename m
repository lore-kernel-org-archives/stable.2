Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794705536;
	b=IhpP7nq9RXwWym4gar0xb4JqF22GlrZdUhm081d2wfxvyiBTKafZ9vNQyShe4tpfT+7h
	 waROehAPzQFJ+7aLQ7c3UIzV0c+HfXOohOjXTYMLK2Sr6Pc9xYTjqwAxawDKwVGGuM0Yi
	 grzPbgBXPpIL52LUVPayZVOpfa/2TwsO9Lga4xCG4h9lqYR9Mzrx6aaKYYBl+laZgMHIV
	 ugKHZ1bYFrMOBWQ1AJ/+3nMdKJL3ZRfJWXMiW6kZNgWeMfQ9wHNX/PLWT3/6S265hd0FV
	 6poSVrGtLfyM2Vpa0IIIvqaN9qlabrn7lWLY5HA0eW2kbBs5BSNGF1cx9IgD2EfqyBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794705536;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=I6TUikNARU1D8kg86XCW293m8lA/2MrDlsV/EcIKQ+I=;
	b=ZNBTh4UuInDGitqN2y/BPuVGG026sur5FqRI6ZL1zZoAE2g7OO6YmyRObiQdosVSQm5S
	 J0gXTC6a+Ggr7ojZvlF7qc/Mk09KKjCxDA/x+nBB2IMrcLhNcCDym3sfXtS4z3cLyJHml
	 CLLdGu8gBwDtdY3TOiChAgtoVphogbjkTJbPi2Xxa9/m2jS6MNqs2+wc3LlBQ1BFdKtkS
	 5HikNPMuhXRwTbxK8aG0P4+BvsW7Pmk3EfIbcJSMEEI6yM9OFqebbsAi2W49q+i7gHIPF
	 g3u9Ak+1O0qxsxTBqBnF1gW7mTNr3kpDgfBO+a++anu+IypnvjCUHblV85Sk80gUnjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEkrTFtS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D910606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 01:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bEkrTFtS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842131F000C4;
	Sun, 15 Nov 2026 01:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794705535;
	bh=I6TUikNARU1D8kg86XCW293m8lA/2MrDlsV/EcIKQ+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bEkrTFtSBiviKZCPBn0rsUOi879sk4jzTYmBbygItjGvhbowpKViWsPYSNcXywfYD
	 uDxqcdtGLr3+U9Y/qBofNdW5GsRACl60geTCMbyq1Md9Qe6Fq8PA3jZfC3/UlCzXAG
	 gda+BAnqnHF0tBFVCv0e8DMkmpdfUg5e4qYYVnsh12PhAsC4J58afzRbvuoq/lS9/Z
	 x9/ypOv480bk2rTISoQkm6IhunURv1jqhjLci8Ru08lB4s7RQgZWwob0IbcQPwBead
	 C6NWXRF3TG9Z3bwkllfn9NfFY/R4BWE5gPNcpyX0q+V8huXVdwXpQHoWO9XdNY0FK+
	 iwDIhgOqPleww==
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
Subject: [PATCH 6.1.y] ocfs2: validate move extents against a stable EOF
Date: Sat, 14 Nov 2026 20:18:52 -0500
Message-ID: <20261115011436.640663-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201732-failed-6.1-84db6619cb70@kernel.org>
References: <20261109201732-failed-6.1-84db6619cb70@kernel.org>
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

[ sashal: inlined range validation into ocfs2_move_extents() instead of adding a separate helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/move_extents.c | 62 ++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index 32b4271f3deb6..e3a9404c71bda 100644
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

