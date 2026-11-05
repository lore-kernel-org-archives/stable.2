Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901532;
	b=cIaMcOuppkjmgfWLfwrWD+np/zBdaKO9QdpL3BUx0VT4V/BZdBPrvJIRAGsXi+yNUKJb
	 7CE4hjKRhsHgxrzl6Z2mVeyCYctiEXgBMm5VyPVgm+a9iImFgYXdGJ/HhWX1NPK6FyuRo
	 IQPq/IsLOfqASKlyn9L5BgmqYF3wv91xNt3/G6YJM8dEO254W0LiTdsCIPHYV0XBDjE3D
	 F/y487+zuof4EGlehf1ghEnYk6T8n29TKAc13mk0fujhuCUMiAxkHseH6d2JQJO4buOhH
	 2+HbjNgJgUMLTijr3gQwYZPxrW9uo+ExUqDTYQWGiaSQe9Ddf2cLS+Yd+AULUzTAPLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901532;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gitrLg0xV/HR+Sh8v7Bk0M8Vba3fuNmXe6SYjFoK1yE=;
	b=SLJPisnUqi+urlGc6bzgdYjq0mwwy43C+EMS/lKptpZLoyq3ZK/XZ1JeZ/IQ21+9vMp2
	 +8tN2DIZ+Hk2vNNVC2tuCVxzWHXnWYKpKJgyD9l0lN4pIAxCYsUhErgk5Wkt4J4XDlWQz
	 79OWvRcUHJ8KmRWVLHeTsXmizvU9WEfufJLBEjEZqJkGzuK8p+do+umPjoOEIFIxAsAAV
	 NphV6WxuWlaUuzfYaEeDxuyJylHHSzSxV4pjBatyPHLfcCOjvSAaNBaLsOvOV+dlp6EA1
	 lFh3SNAk18Eaia14e4BLP50vH6y3el0H+RU4kJlX8p+nJk3JaDPosVZiF1fzypZ0eiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=COfdX8Uq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6AB606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=COfdX8Uq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66141F00A15;
	Thu,  5 Nov 2026 17:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793901532;
	bh=gitrLg0xV/HR+Sh8v7Bk0M8Vba3fuNmXe6SYjFoK1yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=COfdX8Uq2WyRKN6X+97Ch434FJqspkA6yARpT4dDkpTloH187Akxuty80oYvXnGxa
	 P9I8Tgr/zXmVFPQ7vA772ctbJfVOSk5e+aj+GxUaRbXkVpYNWRIzgEGqnwgiRc6V+D
	 VzZypbaAI2Ta2vSs+FxK7381GJh/21GiwaoQcafFSns6+iIuhPMBV+/NKdahyHCTpz
	 6/qOdnzK4Nq1k830McImJQ8WITsw4pKFSTafHGqL6oSeebkwBzNr+l5qOj8ABFD7Z/
	 TOm2YdKGQLsMMOtFKuAMlXrCJ8IpB3AKy4H+cQj7UhuBgmDf5M+jdd6GhtBCpc8vcc
	 7ultBJ8b8Ni+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: improve dirent bounds checking in scrub and repair
Date: Thu,  5 Nov 2026 12:58:50 -0500
Message-ID: <20261105175826.2184495-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110439-headpiece-prodigy-6c27@gregkh>
References: <2026110439-headpiece-prodigy-6c27@gregkh>
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
[ sashal: inlined the upstream scrub helpers’ checks into the existing xchk_dir_rec() loop because those helpers are absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/dir.c | 59 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/scrub/dir.c b/fs/xfs/scrub/dir.c
index 0b491784b7594..7231a7df4aed6 100644
--- a/fs/xfs/scrub/dir.c
+++ b/fs/xfs/scrub/dir.c
@@ -167,6 +167,7 @@ xchk_dir_rec(
 	xfs_dahash_t			hash;
 	struct xfs_dir3_icleaf_hdr	hdr;
 	unsigned int			tag;
+	bool				foundit = false;
 	int				error;
 
 	ASSERT(blk->magic == XFS_DIR2_LEAF1_MAGIC ||
@@ -211,28 +212,67 @@ xchk_dir_rec(
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
@@ -246,6 +286,13 @@ xchk_dir_rec(
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
-- 
2.53.0

