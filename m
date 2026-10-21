Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595570;
	b=0FMK3rlJ65z1s9+jadTbJp7VeJxPWfC+3+I3jVkgO/pvGNwxk2dTEU7ViGZjfrvGc+kR
	 QzBnUBqGfHoJPkm5mok1Sb9Pf+SHyI/WU8dtWKRjrHz0S8Mxzhk16p6fyKO9SgL1UDUs5
	 P07DhE7eGIvOdG6emhikcbfO+sVvx7n3r1otqdCRq+GsvTdHoHN51nA+JsyBl5q0Rzj6B
	 kSeAIzH+Q8PPNdA9iiObj5Z8mrxZzFDFDacAIqJlnD9lj9NE02KUqiOl9rgaD5PuBN4Qd
	 11VxomZwr/s++9aUmp4CWHWp8IlddkMkIxXoBaLnZqM4J3etv+scylW4bIW0Nn2JcSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595570;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QLcQ1tBqS5DinI5f3P7TjIdaPybeySgnXNS3tmIeGxc=;
	b=rDWEjFr1fALTU6bbgQVm8sKtS3p982kY2zTbGz+SEXjv0RHf7wRW2o/vnHmhvOcW2RmA
	 IVgo/O28U2wL4/BJfmkieKmLpLpuYOwnkNhpM5/OuhttXZBBFY/I0RUHOxei+7oaCzOKh
	 XUm2i8VBM/Zpmrs0lyIxAm3Dv7MMZv7WMq6a9QvmKMtpdj43fYFJIY/iPr9utgUKnSBe+
	 ZZlBckPrRqTPEqDzv525euGE/1EAf0Yc2Kpzp8vXEU6RdthhhhWTYzvsUXq65Ka+qxRbH
	 B2URLYPo7dwJXCLBNfkxkwZqWb8LFqs9C7DQFcZLeBJNVRjXtqiA9X3M4xKPqss3iXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zwIdS70K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B91C606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zwIdS70K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992231F000C1;
	Wed, 21 Oct 2026 15:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792595570;
	bh=QLcQ1tBqS5DinI5f3P7TjIdaPybeySgnXNS3tmIeGxc=;
	h=Subject:To:Cc:From:Date;
	b=zwIdS70KFotAwcZUnFom6ruOlz2NKGbOJMd92P0t7kCsPg1U3eI+HzXsiD/1ERqns
	 AOqXKM6cPiuj+5EgwerlR3C7uaOSQsPrec6gghcDkQMqA2ssgd3wim6tc44G9M+Jha
	 gzkDYgUkDNtohAW3T+ZdYL00qxM9/4kYD/AQY5JU=
Subject: FAILED: patch "[PATCH] xfs: don't hold buffer locks across sync transaction commit" failed to apply to 5.10-stable tree
To: yun.zhou@windriver.com,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 17:08:22 +0200
Message-ID: <2026102122-mural-modulator-6339@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 41a28c865d1d5843f8cb9e0af17a8f4d9e2961ff
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102122-mural-modulator-6339@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 41a28c865d1d5843f8cb9e0af17a8f4d9e2961ff Mon Sep 17 00:00:00 2001
From: Yun Zhou <yun.zhou@windriver.com>
Date: Fri, 31 Jul 2026 11:10:10 +0800
Subject: [PATCH] xfs: don't hold buffer locks across sync transaction commit
 in xfs_sync_sb_buf

xfs_sync_sb_buf() holds sb/rtsb buffer locks across a synchronous
xfs_trans_commit(), which flushes the CIL push workqueue internally.
If shutdown occurs during the CIL push, xfs_buf_item_unpin() needs to
lock these buffers to fail them, causing a deadlock:

  setlabel:          holds buf lock -> flush_workqueue(xfs-cil)
  CIL push worker:   xfs_buf_item_unpin -> xfs_buf_lock(same buf)

Remove the xfs_trans_bhold() calls so that commit releases the buffer
locks normally.  After the sync commit, re-acquire the buffers via
mp->m_sb_bp / mp->m_rtsb_bp for the on-disk writeback.

Fixes: f7664b31975b ("xfs: implement online get/set fs label")
Reported-by: syzbot+837bcd54843dd6262f2f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=837bcd54843dd6262f2f
Cc: stable@vger.kernel.org
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/libxfs/xfs_rtgroup.h b/fs/xfs/libxfs/xfs_rtgroup.h
index c0b9f9f2c413..fca2eb74908c 100644
--- a/fs/xfs/libxfs/xfs_rtgroup.h
+++ b/fs/xfs/libxfs/xfs_rtgroup.h
@@ -359,7 +359,11 @@ static inline int xfs_initialize_rtgroups(struct xfs_mount *mp,
 # define xfs_rtgroup_unlock(rtg, gf)		((void)0)
 # define xfs_rtgroup_trans_join(tp, rtg, gf)	((void)0)
 # define xfs_update_rtsb(bp, sb_bp)	((void)0)
-# define xfs_log_rtsb(tp, sb_bp)	(NULL)
+static inline struct xfs_buf *xfs_log_rtsb(struct xfs_trans *tp,
+		const struct xfs_buf *sb_bp)
+{
+	return NULL;
+}
 # define xfs_rtgroup_get_geometry(rtg, rgeo)	(-EOPNOTSUPP)
 #endif /* CONFIG_XFS_RT */
 
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 75f2a021ee6d..f0341adbb879 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1470,36 +1470,33 @@ xfs_sync_sb_buf(
 	bool			update_rtsb)
 {
 	struct xfs_trans	*tp;
-	struct xfs_buf		*bp;
-	struct xfs_buf		*rtsb_bp = NULL;
 	int			error;
 
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_sb, 0, 0, 0, &tp);
 	if (error)
 		return error;
 
-	bp = xfs_trans_getsb(tp);
 	xfs_log_sb(tp);
-	xfs_trans_bhold(tp, bp);
-	if (update_rtsb) {
-		rtsb_bp = xfs_log_rtsb(tp, bp);
-		if (rtsb_bp)
-			xfs_trans_bhold(tp, rtsb_bp);
-	}
+	if (update_rtsb)
+		xfs_log_rtsb(tp, xfs_trans_getsb(tp));
 	xfs_trans_set_sync(tp);
 	error = xfs_trans_commit(tp);
 	if (error)
-		goto out;
-	/*
-	 * write out the sb buffer to get the changes to disk
-	 */
-	error = xfs_bwrite(bp);
-	if (!error && rtsb_bp)
-		error = xfs_bwrite(rtsb_bp);
-out:
-	if (rtsb_bp)
-		xfs_buf_relse(rtsb_bp);
-	xfs_buf_relse(bp);
+		return error;
+
+	/* Re-acquire and write the sb and rtsb to disk. */
+	xfs_buf_lock(mp->m_sb_bp);
+	error = xfs_bwrite(mp->m_sb_bp);
+	xfs_buf_unlock(mp->m_sb_bp);
+	if (error)
+		return error;
+
+	if (update_rtsb && mp->m_rtsb_bp) {
+		xfs_buf_lock(mp->m_rtsb_bp);
+		error = xfs_bwrite(mp->m_rtsb_bp);
+		xfs_buf_unlock(mp->m_rtsb_bp);
+	}
+
 	return error;
 }
 

