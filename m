Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814094;
	b=bG/JuWlWdrZ1p5u+CS2A3OGuV3rnsrr/V19u5lVzwlUeV1tw279L2CwZ9KIhmhZ9r0w0
	 I4VoOMUKKh0MD6srUA3NN2uWF6TcbuDR4gwnMHJmZwpwSUik2jEWyyXFVBk+1DViF4L9R
	 uwiLeoKpG5U2OvbnCnwmHdM4AmIGL30ZvMNcBTpawGTFu5oMKAv4Figi9kT0jMwrpenLj
	 fR4zFpF/rpNf+MLlAKt27ER/UjNNB+Mdv9Ww/Un5DjuTACWkJRDGwBaSmVs5TLTLZpVI0
	 WrjuZhYvUmV6Xdl9srjwv36EmQWH6aMruG5v3ipt0gtT0VQ27lZ2qkm6tlHfmQ4lKBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814094;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2Bn9FhU93BdgOrC5pVVG0zFQslWoaSReWKy3goxIbQ4=;
	b=A18gVGKvZTEzijPNb1q8aZxgngZOZ5qRtElOx2HjDR33Svb0Ik+9uNka+m0NjU2Ge1lV
	 R7pt1gGN1y0kXCL7Dnwv/1uGbw1XBGiA+1AZ8jioxtgpYTbutCSigihQ4CuKpnMEDyN2t
	 rN8JyIdAPuZK/F5hYwQgkSCHmLiE6CSRLq/TKB2iIa5O3FUEAPu5ynvgkultWt2UUdZUh
	 xu6O8suDeRlBLCrj/YSUzHxUz2rszWzfXFDJPRVKt8JY8yaCBEJpZKPaf5T9s1CXQrqev
	 OG4ePwJF/j12ZsyZ5aAAArzML11PPJBFiQw/dQe0qOuOdFbP6mPtn8lkHgfex8J/GTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XdUKACYm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09970606A339
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XdUKACYm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBF41F000C1;
	Wed,  4 Nov 2026 17:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793814093;
	bh=2Bn9FhU93BdgOrC5pVVG0zFQslWoaSReWKy3goxIbQ4=;
	h=Subject:To:Cc:From:Date;
	b=XdUKACYmtkR1+z2mFe3urE3JvwSLRsxMazNYkJ1Fc5SWacNTtcwxcSFUgabqqs206
	 iTMRxooyqDUtLVTiX1RxxEJPTw3D5/fXiFID3nDqzEYC5p1NG100hV+pq5y95RAdPI
	 tNyff4SBkY6EQGCmv9BZ/mrzIHo+mp9ZXVolc3d0=
Subject: FAILED: patch "[PATCH] xfs: bound inode fork length against the fork size during log" failed to apply to 5.15-stable tree
To: qwe.aldo@gmail.com,cem@kernel.org,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 12:41:24 -0500
Message-ID: <2026110424-cure-criteria-18e5@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9232301894a06e664d8de2da97175cf98419bd16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110424-cure-criteria-18e5@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

