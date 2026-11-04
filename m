Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814710;
	b=ERLj0kebx5lcnaroJ9sb48RDoi7R561QE68gKDa5LBeMBZX37JMtHsrRRdbk80dV5J4T
	 B1GZnLQ9HYb8RA5aLcRs/ztcVaopoM7/b7k+F0Of3YtnSmiWuzkr9DlCGlE3jgtCGHroW
	 Uc/B/wFfvrS5viyKvIvlgAmJSiRN4TxjmxMfa6og3BAVsR+xORuEMvezQIxlq1Sqs47me
	 gZtkUFv7nXnDNzgHGkA3u3PhYsPQ4uY1JPlmkgc0zzHRnvb2J+EtWDmwLm1DoEzfg7WRf
	 XCGWezjRRPmBVi5mCDH+A3/aGEfdyNol4OivTKBIaRSnQd1TyJUNFUEpvt8YFey583Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814710;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Y4sO/M6VRKnpiapJP64PJBFRS3RFMzOMGfki4KoiJ08=;
	b=1W4jni66kO4QxDBoRnz/o8eVuPJHaJZMM9b784HEvN+6qcFzZWWVMli0JY+2QaPX2olz
	 hzM8GFJOpMOsReEvzCt0HbI0doR7Ea9NAGjxJh4B0xyfAHI+YXsDwiN9hjeJWwXoLZ3ET
	 z3yHQ8+UQnV7edqPg2O/7z0el0JQcXvlWCo0gjs30r/xduJIVYBgc1KcW8OmHxbRzq+gJ
	 IhLnrhkNlv0uV/9g/KxWLY4RmIDQA76xble/IwHo2X57TWNmVFqjdkjo4b64154YVC1Bh
	 EKE3zc3Ruf27rEJp+elB/qAinPD4871mpe0zjn3mefdiJ6KmRjLNe5r8k58tnfYpqmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="Ukd/Kw2m";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25060703F3
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Ukd/Kw2m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6118F1F000C1;
	Wed,  4 Nov 2026 17:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793814709;
	bh=Y4sO/M6VRKnpiapJP64PJBFRS3RFMzOMGfki4KoiJ08=;
	h=Subject:To:Cc:From:Date;
	b=Ukd/Kw2mmeLAx+IpYWtfbfQgNJVQJiKkGoAbiz0lt46rg9EKycIAr1Yx17GbcFXBw
	 H8iqjcsFb71MPGKv3PG2UkDybIpRkzOU1YRcrkCnn6ke7x7aj40kJWzsDJ8jMN6iMS
	 uh3LbEUczLO0Tpr7I3h+PK7kQO9I7SzAsKlAe99w=
Subject: FAILED: patch "[PATCH] xfs: improve dirent bounds checking in scrub and repair" failed to apply to 6.6-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 12:51:39 -0500
Message-ID: <2026110439-headpiece-prodigy-6c27@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5d470234d04dae6fe2ca2cf4b9ef277b78c7e05a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110439-headpiece-prodigy-6c27@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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
 

