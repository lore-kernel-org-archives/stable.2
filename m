Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904253;
	b=cqNIirRDI9qf6L+kLuSh8ki/xn2Z6Vgcnu+4OStjj6eS9Hfzg29XlSIFo9akQ+hJEESH
	 2sLoh4lXaiLcAL5fYL3amngLW07oLma81KazfdcClkgUr8v0N2WGY5VOLdW+V24b9KJN8
	 XI6ovs5dV6aUAyO548O8y+ikUDyAkG4EefAJL0GR4KYdtmQmiSJuOat5i+Y3Gytg+1Utr
	 dZPslaCqwxLp4Zdx21AxyFP11fvBIxqPNuNbsS/IsB2ZAytOdmJJHSUMdWQ+cjD40BGwA
	 Y/afsDwbpGcu1+9sMQNb65lrGo9afL73x81Yyjk5gpJvF/zi/VE9GgAA2Cfup9MoDmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904253;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=c7ReC2jztjZEV5viZi62bX5jXswhcxntgwOBonNP1Os=;
	b=l/W2hdLalYXDOtyS2FoP2pSfk6JAYAS5j/IAPuezX/96kPmlOma2kcJEc0PmZePWD0p/
	 sgN3Q86Ju4W4MoglgdKAqd1qtCfeXOtuI4TTG/X7NIbhDb7rL4h9SUjZiNOkeH65XiAcg
	 Moem7w3LqZzN7Nwn6osvptqlSYGyiKBVyhMgXuMJnNFe9PsnbKghItlQPdDw0mJo5NgzO
	 DZevGI6BdjKVToxTZEm2ETTOh35aSOKw142pIcjGKf389MnFawzx925wmIM4oW4KFkuV5
	 FaqSWRmMVrhywLdZkTHXWq0yRwMqQTZ2aMjjoxpTvk/xXBQ6wWDWpZaYDEdGIa+HHHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ov5CvrJC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E9606A331
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ov5CvrJC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647801F0093A;
	Thu,  5 Nov 2026 18:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904253;
	bh=c7ReC2jztjZEV5viZi62bX5jXswhcxntgwOBonNP1Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ov5CvrJC5e3e6oiZEAYTbtJ3ua+rDwclHVPJ0fwHoywpPklUHA13gtYF3L1iAKIyg
	 1lCTeFcfnSq8/Fc6gd5eY7ZlOMMf9yM3HcEWlmX9quMIweK6XxcY2PaQtMcPWtD21n
	 b2+UA712f5pXPH4MK4xHzdeYdLIJJm6dD6teQOSx+wEMwMZBI0FpE+v9DVl8su3AgJ
	 CZIBjEmiTI/5xTqbN/yQwLDM9u1Zd1Xnuk/mJ6no4c5mRrLnWiDcvMY7mYTdtffnqw
	 wSLb+SNDiDsoqQ1I8DIBbxSTklh6DnZz+JwPsCU+2wdSKriD5OL26YabI1iZPskC1+
	 XRYQLuwtMBUJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: improve dirent bounds checking in scrub and repair
Date: Thu,  5 Nov 2026 13:44:11 -0500
Message-ID: <20261105184242.2288878-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110440-scrambler-rants-fb16@gregkh>
References: <2026110440-scrambler-rants-fb16@gregkh>
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
[ sashal: Inlined upstream helper checks into the existing xchk_dir_rec() loop because the helper refactor is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/dir.c | 60 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/scrub/dir.c b/fs/xfs/scrub/dir.c
index 5c87800ab223d..73f8449caa9d0 100644
--- a/fs/xfs/scrub/dir.c
+++ b/fs/xfs/scrub/dir.c
@@ -219,6 +219,7 @@ xchk_dir_rec(
 	xfs_dahash_t			hash;
 	struct xfs_dir3_icleaf_hdr	hdr;
 	unsigned int			tag;
+	bool				foundit = false;
 	int				error;
 
 	ASSERT(blk->magic == XFS_DIR2_LEAF1_MAGIC ||
@@ -263,28 +264,67 @@ xchk_dir_rec(
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
+			advance = xfs_dir2_data_unusedsize(be16_to_cpu(dup->length));
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
@@ -297,6 +337,14 @@ xchk_dir_rec(
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

