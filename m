Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814096;
	b=SX22+n2+xtV4TIaJGKMBoO71VdoqYfI9/dvxUObd8aaT2qFGobZ3I8zNkf08zrL2Xs5E
	 pJFU3wCHX2cId0iSS6Pj3mWeGTBTnIVymbAxBxB1noa+U7wRppvHfnEeXu1TGWZrIFmfq
	 1RfDXcK1iz4s+5LHJEm3FfRXgcg71XH3BPotyOAeTYZwUUQRYUFvpjefnWcYr9g+w99ZT
	 zmoHqcOB2FGy0hkqAp/RiFgBymg++Ug79weZdftvEjTVenqL17qPzjOv09fBe6iSLcriA
	 saW5swrj4zUsNUJtNTHqlWuzUeXA1vJsWxzWhPKYTskB9eDnattbUn6ZJgTU2bRX3GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814096;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LG8o7JxvWIxf7TmaafS3Bmpx+T9RJsN7zC1BzwTU9Zo=;
	b=r6+5pVgMW53j2LXS3sIn+05XkARLhhImFSj4AzJe3VLiqYCDDxDqxbClUNhyKUtjV8Xu
	 ph/wu1S0B/zpHM7jF67W85NfP/P/KiH7nAayyrYf6yIZwwUMBExRrhGNJ8TFoUaEwgHnB
	 awzyQGGHDNxkGXAb3DxqvvCC6nIo7vTCbcM7dYCP2jMLrSIFHPgS6ehyNTCc5gN78Y4ex
	 envahxgH1ENi+j0HRgdWZslNDV7sbA+B2yRuJzjOB2sHijqSCJhc8KmMkOmVKd2c4Bkhy
	 kmEU2t9vAK26ANBHr09unzeDv+9fulVZKARmjtwd0RrGyhdrXPnellHt3DouxB+WHTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=V90eHUvr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD07C606A338
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=V90eHUvr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8BD1F000C1;
	Wed,  4 Nov 2026 17:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793814095;
	bh=LG8o7JxvWIxf7TmaafS3Bmpx+T9RJsN7zC1BzwTU9Zo=;
	h=Subject:To:Cc:From:Date;
	b=V90eHUvrArafEwW6ByUuEQ/mstXmepH3djDvCdQqf+YR4WKzR/ASAn4fPHKHa0dIk
	 nnf93rIXxJhH6+lBWzHeoWSDkGpiBwrzUnJI+lF8p7Dgx93Zi444xH4znl4hdVCsTi
	 WhQBj/dOV110zSD+qX5VhxVt2mSxkbVhyXJt54hw=
Subject: FAILED: patch "[PATCH] xfs: bound inode fork length against the fork size during log" failed to apply to 5.10-stable tree
To: qwe.aldo@gmail.com,cem@kernel.org,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 12:41:25 -0500
Message-ID: <2026110425-badly-feeble-d2e6@gregkh>
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
git cherry-pick -x 9232301894a06e664d8de2da97175cf98419bd16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110425-badly-feeble-d2e6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9232301894a06e664d8de2da97175cf98419bd16 Mon Sep 17 00:00:00 2001
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Date: Wed, 23 Sep 2026 08:57:44 -0300
Subject: [PATCH] xfs: bound inode fork length against the fork size during log
 recovery

xlog_recover_inode_commit_pass2() copies an inode log item's data/attr
fork region into the inode buffer using the on-log region length without
bounding it against the fork capacity, e.g.:

	len = item->ri_buf[2].iov_len;
	memcpy(XFS_DFORK_DPTR(dip), src, len);

The only guard is an ASSERT, which is a no-op on production kernels
(CONFIG_XFS_DEBUG off), and xfs_dinode_verify() runs only after the copy.
A crafted image with a dirty log can therefore drive a heap out-of-bounds
write at mount time. The XFS_ILOG_DBROOT sibling already passes
XFS_DFORK_DSIZE as a bound; the DDATA/DEXT and ADATA/AEXT memcpy paths
did not.

Bound each logged fork region against the destination fork size before
copying it, and reject the log item with -EFSCORRUPTED when it does not
fit. Because the recovered inode is only verified after the fork data has
been copied in, the checks are done up front, before any memcpy into the
on-disk inode.

Fixes: 658fa68b6f34 ("xfs: refactor log recovery inode item dispatch for pass2 commit functions")
Cc: stable@vger.kernel.org # v5.8
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_inode_item_recover.c b/fs/xfs/xfs_inode_item_recover.c
index 1d2319ad15c5..8da95131ab55 100644
--- a/fs/xfs/xfs_inode_item_recover.c
+++ b/fs/xfs/xfs_inode_item_recover.c
@@ -507,6 +507,25 @@ xlog_recover_inode_commit_pass2(
 	ASSERT(!(fields & XFS_ILOG_DFORK) ||
 	       (len == xlog_calc_iovec_len(in_f->ilf_dsize)));
 
+	/*
+	 * The recovered inode is verified only after the fork data has been
+	 * copied into it, so bound each logged fork region against the size of
+	 * its fork now, before the memcpy below can overrun the on-disk inode.
+	 * The DBROOT/ABROOT cases already bound their copies against the fork
+	 * size.
+	 */
+	if ((fields & (XFS_ILOG_DDATA | XFS_ILOG_DEXT)) &&
+	    item->ri_buf[2].iov_len > XFS_DFORK_DSIZE(dip, mp)) {
+		error = -EFSCORRUPTED;
+		goto out_release;
+	}
+	if ((fields & (XFS_ILOG_ADATA | XFS_ILOG_AEXT)) &&
+	    item->ri_buf[(fields & XFS_ILOG_DFORK) ? 3 : 2].iov_len >
+	    XFS_DFORK_ASIZE(dip, mp)) {
+		error = -EFSCORRUPTED;
+		goto out_release;
+	}
+
 	switch (fields & XFS_ILOG_DFORK) {
 	case XFS_ILOG_DDATA:
 	case XFS_ILOG_DEXT:
@@ -546,7 +565,6 @@ xlog_recover_inode_commit_pass2(
 		case XFS_ILOG_ADATA:
 		case XFS_ILOG_AEXT:
 			dest = XFS_DFORK_APTR(dip);
-			ASSERT(len <= XFS_DFORK_ASIZE(dip, mp));
 			memcpy(dest, src, len);
 			break;
 

