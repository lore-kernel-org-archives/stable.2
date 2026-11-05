Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908428;
	b=3c2ifbL+V6PTz8bY4IAo6N6ZLdxJDUjh+MO18TqxRL8O5mbvnt+F0wadPUtwSHR7Khau
	 CDx9ngl5I4cTPfAFpxM8G7u8gBqg7Kdc3UlmBGA58xd5Msf9Uxgh4NH2MAH7QfFrLdUgN
	 gPRAN9jBrPoSVblpeCIQO0CKJR9FyO7zBL2cQ7D3x57hmzvRE/pOMYuOlcZ7xoGLYn/o+
	 0ELcy/UVW7g98mv8+L2OZQLmI93cuLS7zg058RCI7fNlfms7W2W2O6dbsGjqRcPSAyV6u
	 oWAY7wUrfT/YdhNDsgvVT5sPWjk5NmlZKtVNyhtT0PZNtDTR8UPrIiDnUqGGwocgbPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908428;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T4fLGPkNodTuneM5ZZSr/zdktEFhYRATX92J5jzoQyU=;
	b=zr1IiDIEU0GnPj2wWjo+CYFrcakPwU/rQKgNv+lxuYvblwwiQMKyWMbITo6vm3X8gHoy
	 X8TYd/Y2Wnw4GgPP1vFg8tdMYIejemy0IoNpOLAkawzV7/IG1Gih60goezsEZRPEQBK9F
	 KD41L+6jvf6r/Gj0Uc6vzqEip4qazNWh7e8mQo/MSXJEBkzD+10LR/I2e6y/RdtiaeURW
	 kCSaEl81UZ2NtPFA9n5R+G7S7wDsvNSgLPWnCVUwhpisnnr61EOPNaFPN4HmvFlDg3H+F
	 etnpvmxXDiPRsMXWuQYxYteQuPbp8YmMrGT1va0Dn47T6eGTh3/g0tWw8bxHqCWGS6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5L6sCc+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C2C606B9C3
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j5L6sCc+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B801F0089F;
	Thu,  5 Nov 2026 19:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908428;
	bh=T4fLGPkNodTuneM5ZZSr/zdktEFhYRATX92J5jzoQyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j5L6sCc+krgbiMN1xpnONLbUwDq/P5Vr2zrcN/wyA+I2sRhaAqwabkqa5tByOMMSz
	 k7aqEG14N5LUSObHwa6gzPCFUIpCMOnXg03TJavliMhNP/psXz1wq6uhpvndVAl4Tr
	 HZZbuikY+AhFpPo0+PgduFdHKfvJ1Clfl56eP5g5utM8R10TTMMR+TvZ11eamoGYaL
	 n7k2Y2KpXvLluF4AgfwwDLveXL6VKYcY84zKwpEF2wjKo63nRqbUGvKOP6Xmhx1Fpb
	 gf1rL7C37RB2UhBVc3l2SZZP1dti4PIY5DwvMlMShjl5UhXuGElVKQ54TVC0Py6Zkk
	 QMJm1ePHMBy5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: improve dirent bounds checking in scrub and repair
Date: Thu,  5 Nov 2026 14:53:46 -0500
Message-ID: <20261105195322.2630214-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110440-amino-parsnip-8b09@gregkh>
References: <2026110440-amino-parsnip-8b09@gregkh>
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
[ sashal: inlined checks in the existing xchk_dir_rec() loop because the upstream directory-walking helpers are absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/dir.c | 61 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/scrub/dir.c b/fs/xfs/scrub/dir.c
index 200a63f58fe7c..7119eb0bb7d78 100644
--- a/fs/xfs/scrub/dir.c
+++ b/fs/xfs/scrub/dir.c
@@ -219,6 +219,7 @@ xchk_dir_rec(
 	xfs_dahash_t			hash;
 	struct xfs_dir3_icleaf_hdr	hdr;
 	unsigned int			tag;
+	bool				foundit = false;
 	int				error;
 
 	ASSERT(blk->magic == XFS_DIR2_LEAF1_MAGIC ||
@@ -263,28 +264,68 @@ xchk_dir_rec(
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
@@ -297,6 +338,14 @@ xchk_dir_rec(
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

