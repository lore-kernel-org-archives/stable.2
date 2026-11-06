Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926166;
	b=pvgSc4zOVvfYkKLJRIiRsLmz2Y4WI4eX0VGwgmcIt6Yi9SSLIVtv/sQ3kdePC/c4LwlO
	 fNgHCWy9WJSx//PJ38B+uspjDs5HHhJlZSmAUyd5OaLp9vHJg/GDuWG8nZ4NrKzZNqQEc
	 zefgP2qoQ9UZKHGCLEMEe7KBGeJjxseFmej0dxXflpU+4y82LsLmTA67PENc5Zq+iB+Jj
	 EXsHZ1SOPcpT6TUrkUc601Ys5RjPoJtRKEAL1K8C0mqzoSU34GFRMjifiQt0lsPiuSAQV
	 ckrWDfjcbl4doIfyH51skL9mF9mNPnYPLBDLkW3uXdkO2EggzPin1kH2vTUS1d0roPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926166;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e/CKaamN63mav+oujDoPII5pMeo1llHlYOUk81ohVSs=;
	b=Y7kIatbMWr5upVjbMl6U8hUzJzO0VolZ4d36k5mE5+EjjR4y/IiGEh6RrGRjEP4HByCj
	 dJLmh30Q3Nt20X1LVepSe8E2MgOkL59LLzQbR1B/hkQImNoRcytTaUBwG5rpSFpR3DxAZ
	 bRcY4tmMiJ6YR3etjmkiH5vO1LZcMlRLVxEU2zsOcVDEq2GiD59TisyBqc2PvvuFWJycp
	 yxlx8OH/Eoo8hUAXBakqEX1dSDaQqreaV/AC2AmvenO/LTytCUAsPjrJZiH+WxoE+xiz4
	 ROwQc+xbUdEPJLg4WK0AKSwR0PJLsBR6MzkQauju8fpukUecWgvevZ2afpFDep5/LCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dB/XClcI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5CC606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dB/XClcI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A48F1F0089F;
	Fri,  6 Nov 2026 00:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926165;
	bh=e/CKaamN63mav+oujDoPII5pMeo1llHlYOUk81ohVSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dB/XClcIkgy/CHhOPpkEB1nLrQx/ARdrJWdeNgZ9fpG70B2B5t0QKXS5IKkLLiTK8
	 SzAVz15Ijed0zWElxx5ieHtwn9qeV8kjnQAtU6swZCIOWW9UEfnTeyoeLDAuddLUDD
	 hOS9coqyYKz35w+QVco9DYNhUIG8hmuduF9dHsYjZT04jo4wfibTevqgdIYM9Cf3Jz
	 0ID+aGYUeVx0Fwp8RciRHBZqzBWmhEFgpP0tgwT4oDuYBTy8zorxojDYLyHCHFEHIJ
	 bzICsxtSlvp/kxDZj1sUMgx/4UCVtKqlGJ529ywKXudAI5gJMwb4URW2F0eMKLQmwE
	 RJzHcUYAKncvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: improve dirent bounds checking in scrub and repair
Date: Thu,  5 Nov 2026 19:49:23 -0500
Message-ID: <20261106004452.2787464-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110440-huff-stamp-6660@gregkh>
References: <2026110440-huff-stamp-6660@gregkh>
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 5d470234d04dae6fe2ca2cf4b9ef277b78c7e05a ]

LOLLM complains that we don't do enough bounds checking of the directory
entries in directory blocks when we're looking for errors or trying to
salvage entries.  Let's improve that with more detailed checks.

Cc: stable@vger.kernel.org # v4.16
Fixes: ce92d29ddf9908 ("xfs: directory scrubber must walk through data block to offset")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: adapted helper-based checks to the existing inline xchk_dir_rec() loop ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/dir.c | 61 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/scrub/dir.c b/fs/xfs/scrub/dir.c
index b045e95c2ea73..5b6263e8a956d 100644
--- a/fs/xfs/scrub/dir.c
+++ b/fs/xfs/scrub/dir.c
@@ -205,6 +205,7 @@ xchk_dir_rec(
 	xfs_dahash_t			hash;
 	struct xfs_dir3_icleaf_hdr	hdr;
 	unsigned int			tag;
+	bool				foundit = false;
 	int				error;
 
 	ASSERT(blk->magic == XFS_DIR2_LEAF1_MAGIC ||
@@ -249,28 +250,68 @@ xchk_dir_rec(
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
 		struct xfs_dir2_data_entry	*dep = bp->b_addr + iter_off;
 		struct xfs_dir2_data_unused	*dup = bp->b_addr + iter_off;
+		unsigned int			advance;
 
-		if (iter_off >= end) {
+		/* must have freetag */
+		advance = offsetof(typeof(*dup), length);
+		if (iter_off + advance >= end) {
 			xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
 			goto out_relse;
 		}
 
 		if (be16_to_cpu(dup->freetag) == XFS_DIR2_DATA_FREE_TAG) {
-			iter_off += be16_to_cpu(dup->length);
+			if (iter_off + sizeof(*dup) > end) {
+				xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK,
+						rec_bno);
+				goto out_relse;
+			}
+
+			advance = round_up(be16_to_cpu(dup->length),
+					XFS_DIR2_DATA_ALIGN);
+			if (!advance || iter_off + advance > end) {
+				xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK,
+						rec_bno);
+				goto out_relse;
+			}
+
+			iter_off += advance;
 			continue;
 		}
-		if (dep == dent)
+
+		/* must have namelen */
+		advance = offsetof(typeof(*dep), name);
+		if (iter_off + advance >= end) {
+			xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
+			goto out_relse;
+		}
+
+		/* Don't walk off the end of the block. */
+		advance = xfs_dir2_data_entsize(mp, dep->namelen);
+		if (!advance || iter_off + advance > end) {
+			xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
+			goto out_relse;
+		}
+
+		if (dep == dent) {
+			foundit = true;
 			break;
-		iter_off += xfs_dir2_data_entsize(mp, dep->namelen);
+		}
+		iter_off += advance;
+	}
+
+	/* Hash tree must point to the exact dirent */
+	if (!foundit) {
+		xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
+		goto out_relse;
 	}
 
 	/* Retrieve the entry, sanity check it, and compare hashes. */
@@ -283,6 +324,14 @@ xchk_dir_rec(
 		xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
 		goto out_relse;
 	}
+
+	/* Name must not overflow end of block */
+	if ((char *)dent->name + dent->namelen >
+	    (char *)bp->b_addr + BBTOB(bp->b_length)) {
+		xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
+		goto out_relse;
+	}
+
 	calc_hash = xfs_da_hashname(dent->name, dent->namelen);
 	if (calc_hash != hash)
 		xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
-- 
2.53.0

