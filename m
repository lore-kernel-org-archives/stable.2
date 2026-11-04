Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814716;
	b=IvG1c1updAZbhLnOahy8x+Z+bws7OqUZ5qlizpFCeHhdNvBiJo/C+BsUghw3ftbspoXe
	 dPJ40PRv7nzIN1d8JSgUAUpxapC3TvUdaMxnmEGWqJZzYFAhyb+I23eZT53B25WCZCVRh
	 uG1CdYnabkuWbWqZTQ3HMqa8DrPUeWJtMZ4nYmqrS2y48PV+tj25DoDe2qpkMbD+XVbJq
	 0M3kZp2ZbIP/ww0SP5BkyOvIUK8zzh5rxnMhluMmUzFA6d5f4YrOizSxaXd44bq24p/AX
	 CW9XQa6TiSjTSswQwtga+vG/KMyk27bRqtVyDwUYQCykzp3jhNTSSk0VsL8mgKcZ8ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814716;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=l0iF0FDcZIE9dcI51j7/s/6Zis6NR/Kl0/pmUP5PTI4=;
	b=xlf96ylZM+sg6GqN+AJQ4bJ8Yqossa/xUdzd99TA6haRz/wS+bPGDCjE1lD2VftbBabQ
	 IIPHacM30K2xh6XaKSmwKdrSmTYIFbsFWJ7rse2f0lnzAlxbSPrab8Gh4zUFDe8MYQj13
	 Oumnl0juL2JyuA6kMpJvzCIXrvjXPSocQHaAJQ/AqbYkDI75/Dpl+fGqTUEwrnBOH7W43
	 jm4f2O/901rsDHMChXJw7lRotdH+fZffUrSFIiEA4MgHx49Ub3WAjVzhuq2mY+ukBc5cg
	 ux5X0Zdkoj75lur/ZIhjmTUvnqyCJuCIX1EJveqMD1kCgROdCxA/GysdwsKAx2ANz0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vQ9W+AgL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F8C606D812
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=vQ9W+AgL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C062A1F00919;
	Wed,  4 Nov 2026 17:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793814715;
	bh=l0iF0FDcZIE9dcI51j7/s/6Zis6NR/Kl0/pmUP5PTI4=;
	h=Subject:To:Cc:From:Date;
	b=vQ9W+AgLgeGNBXV3/ui3jRdYxF2RXZxJpXaThIb5xeDj/74JwJYQ/wU3cuJ5AalCP
	 lwSlSWYb1YO+FqVwLQO6llklPCJZYKErn1j2bLXNBxPCuBU9YtXhgoODvVACaohonb
	 c99eaL7NV0nSjaE1ye25PwoX6GQeJiHb8jptB92A=
Subject: FAILED: patch "[PATCH] xfs: improve dirent bounds checking in scrub and repair" failed to apply to 6.1-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 12:51:40 -0500
Message-ID: <2026110440-scrambler-rants-fb16@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5d470234d04dae6fe2ca2cf4b9ef277b78c7e05a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110440-scrambler-rants-fb16@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d470234d04dae6fe2ca2cf4b9ef277b78c7e05a Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 12 Oct 2026 23:10:09 -0700
Subject: [PATCH] xfs: improve dirent bounds checking in scrub and repair

LOLLM complains that we don't do enough bounds checking of the directory
entries in directory blocks when we're looking for errors or trying to
salvage entries.  Let's improve that with more detailed checks.

Cc: stable@vger.kernel.org # v4.16
Fixes: ce92d29ddf9908 ("xfs: directory scrubber must walk through data block to offset")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/dir.c b/fs/xfs/scrub/dir.c
index 8de593c5382d..d99e2a732723 100644
--- a/fs/xfs/scrub/dir.c
+++ b/fs/xfs/scrub/dir.c
@@ -325,11 +325,24 @@ xchk_dir_check_unused(
 	struct xchk_da_btree		*ds,
 	struct xfs_buf			*bp,
 	unsigned int			iter_off,
-	unsigned int			end)
+	unsigned int			end,
+	xfs_dablk_t			rec_bno)
 {
 	struct xfs_dir2_data_unused	*dup = bp->b_addr + iter_off;
+	unsigned int			advance;
 
-	return be16_to_cpu(dup->length);
+	if (iter_off + sizeof(*dup) > end) {
+		xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
+		return -1;
+	}
+
+	advance = xfs_dir2_data_unusedsize(be16_to_cpu(dup->length));
+	if (!advance || iter_off + advance > end) {
+		xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
+		return -1;
+	}
+
+	return advance;
 }
 
 /*
@@ -343,15 +356,31 @@ xchk_dir_check_entry(
 	struct xfs_buf			*bp,
 	unsigned int			iter_off,
 	unsigned int			end,
-	struct xfs_dir2_data_entry	*dent)
+	struct xfs_dir2_data_entry	*dent,
+	xfs_dablk_t			rec_bno)
 {
 	struct xfs_dir2_data_entry	*dep = bp->b_addr + iter_off;
 	struct xfs_mount		*mp = ds->state->mp;
+	unsigned int			advance;
+
+	/* must have namelen */
+	advance = offsetof(typeof(*dep), name);
+	if (iter_off + advance >= end) {
+		xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
+		return -1;
+	}
+
+	/* Don't walk off the end of the block. */
+	advance = xfs_dir2_data_entsize(mp, dep->namelen);
+	if (!advance || iter_off + advance > end) {
+		xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
+		return -1;
+	}
 
 	if (dep == dent)
 		return 0;
 
-	return xfs_dir2_data_entsize(mp, dep->namelen);
+	return advance;
 }
 
 /* Scrub a directory btree record. */
@@ -379,6 +408,7 @@ xchk_dir_rec(
 	xfs_dahash_t			hash;
 	struct xfs_dir3_icleaf_hdr	hdr;
 	unsigned int			tag;
+	bool				foundit = false;
 	int				error;
 
 	ASSERT(blk->magic == XFS_DIR2_LEAF1_MAGIC ||
@@ -423,33 +453,44 @@ xchk_dir_rec(
 	dent = bp->b_addr + off;
 
 	/* Make sure we got a real directory entry. */
-	iter_off = geo->data_entry_offset;
 	end = xfs_dir3_data_end_offset(geo, bp->b_addr);
 	if (!end) {
 		xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
 		goto out_relse;
 	}
-	for (;;) {
+	iter_off = geo->data_entry_offset;
+	while (iter_off < end) {
 		struct xfs_dir2_data_unused	*dup = bp->b_addr + iter_off;
 		int				advance;
 
-		if (iter_off >= end) {
+		/* must have freetag */
+		advance = offsetof(typeof(*dup), length);
+		if (iter_off + advance >= end) {
 			xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
 			goto out_relse;
 		}
 
 		if (dup->freetag == cpu_to_be16(XFS_DIR2_DATA_FREE_TAG))
-			advance = xchk_dir_check_unused(ds, bp, iter_off, end);
+			advance = xchk_dir_check_unused(ds, bp, iter_off, end,
+					rec_bno);
 		else
 			advance = xchk_dir_check_entry(ds, bp, iter_off, end,
-					dent);
+					dent, rec_bno);
 		if (advance < 0)
 			goto out_relse;
-		if (!advance)
+		if (!advance) {
+			foundit = true;
 			break;
+		}
 		iter_off += advance;
 	}
 
+	/* Hash tree must point to the exact dirent */
+	if (!foundit) {
+		xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
+		goto out_relse;
+	}
+
 	/* Retrieve the entry, sanity check it, and compare hashes. */
 	ino = be64_to_cpu(dent->inumber);
 	hash = be32_to_cpu(ent->hashval);
@@ -461,6 +502,13 @@ xchk_dir_rec(
 		goto out_relse;
 	}
 
+	/* Name must not overflow end of block */
+	if ((char *)dent->name + dent->namelen >
+	    (char *)bp->b_addr + BBTOB(bp->b_length)) {
+		xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
+		goto out_relse;
+	}
+
 	/* Does the directory hash match? */
 	dname.name = dent->name;
 	dname.len = dent->namelen;
diff --git a/fs/xfs/scrub/dir_repair.c b/fs/xfs/scrub/dir_repair.c
index ea4e729ec036..518e15d93d3b 100644
--- a/fs/xfs/scrub/dir_repair.c
+++ b/fs/xfs/scrub/dir_repair.c
@@ -473,8 +473,16 @@ xrep_dir_recover_unused(
 	unsigned int			end)
 {
 	struct xfs_dir2_data_unused	*dup = bp->b_addr + offset;
+	unsigned int			advance;
 
-	return be16_to_cpu(dup->length);
+	if (offset + sizeof(*dup) > end)
+		return 0;
+
+	advance = xfs_dir2_data_unusedsize(be16_to_cpu(dup->length));
+	if (!advance || offset + advance > end)
+		return 0;
+
+	return advance;
 }
 
 /*
@@ -492,11 +500,14 @@ xrep_dir_recover_entry(
 	unsigned int			advance;
 	int				error;
 
+	/* must have namelen */
+	advance = offsetof(typeof(*dep), name);
+	if (offset + advance >= end)
+		return 0;
+
 	/* Don't walk off the end of the block. */
 	advance = xfs_dir2_data_entsize(rd->sc->mp, dep->namelen);
-	if (!advance)
-		return 0;
-	if (offset + advance > end)
+	if (!advance || offset + advance > end)
 		return 0;
 
 	/* Ok, let's save this entry. */
@@ -534,6 +545,11 @@ xrep_dir_recover_data(
 		if (xchk_should_terminate(rd->sc, &error))
 			return error;
 
+		/* must have freetag */
+		advance = offsetof(typeof(*dup), length);
+		if (offset + advance >= end)
+			break;
+
 		if (dup->freetag == cpu_to_be16(XFS_DIR2_DATA_FREE_TAG))
 			advance = xrep_dir_recover_unused(bp, offset, end);
 		else
@@ -565,6 +581,19 @@ xrep_dir_recover_sf(
 	hdr = ifp->if_data;
 	end = (unsigned char *)ifp->if_data + ifp->if_bytes;
 
+	/* sf header must be big enough for count/i8count */
+	if (!hdr || ifp->if_bytes < 2)
+		return 0;
+
+	/* and large enough for the parent inumber */
+	if (hdr->i8count) {
+		if (ifp->if_bytes < offsetof(struct xfs_dir2_sf_hdr, parent[8]))
+			return 0;
+	} else {
+		if (ifp->if_bytes < offsetof(struct xfs_dir2_sf_hdr, parent[4]))
+			return 0;
+	}
+
 	ino = xfs_dir2_sf_get_parent_ino(hdr);
 	trace_xrep_dir_salvaged_parent(rd->sc->ip, ino);
 

