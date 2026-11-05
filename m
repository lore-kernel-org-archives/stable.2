Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895821;
	b=bXmj+7WjsQDvSSvF+IYfARH3rPh2qlhCREKNeyzkQWSh9yltkBQmAIdXKkDUsBbt2lh/
	 2h76UKT/ZJDXfRTMV9sumlSAhWQkezXK/qEXqR23Wo4jomfqpRp9gqZYjL599ex/+I9Rp
	 HJ10Fw4DCOYbo9jcXmvUHur7LjYuovj8rvuiMSXFDUXtOW8p4xulv3q5PB8yAkpRsYxCb
	 7VT+Wz211dTnapHtjTMTEyoZF+kbOEi/Y3rZeH6ynMihw0KLtdMwcASuQCk4lE87ZpfPB
	 QYP0NR8jhbmUjgltBXamFMzY689BSVpjJCWWNjqVF3f3j3o+9BOMcN7gVwQf/NeU5eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895821;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=NiTDkopizYs4baXoHTYRa3DfhRgt0SJwxCNJUnS86I8=;
	b=0wT0hOcWolD+3Xdl/R2le4oEWTk6LqrgiziEiPpKCmKaDiFo8khB5NcCLmYcfcCi1j31
	 u0fA+iCt21CZ/tvwO6CboDUQLCJ9JmdmdP5/1Xal0WVlIOU7FyJWW0RRGtTl48BUs3DL2
	 MAVwJzyHeBOFa2z3iLxIMqqjoRdIUccoQlYrE9Ukxr0SE9gi8OuOjcUgyGS5bJFmKFLhJ
	 P/JQGOrY31EhMqznn7c/re8SOFOD1pJMHOpDeUMI7C8JhpXB2zRU1jowpchRFqxOAiqS+
	 YWxrVxANtrryZ0Nk6slQJBfPSGcawQa/OVM1/aS/Hsc5uUe1SYAgmF6xpMH+QcKy55A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXbfvdet;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD9606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XXbfvdet
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6BA1F000C1;
	Thu,  5 Nov 2026 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895820;
	bh=NiTDkopizYs4baXoHTYRa3DfhRgt0SJwxCNJUnS86I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXbfvdetkYes6IZiQEpHQ5t9/QMVLg3bZqeiyaDzaUmYfbg8JpmCNkiKfo8bx/4ST
	 5nO/BIT7SwvmmdKekPO1oqSKDEWzRRjK4aoA4tyNnGQKJ9BEuKtY1Wj6CgHS5BhFY+
	 BnEuIKh6zA4QDfxwK+lk0ZD5t3bUFoRIlFRVu1/7nQOOP2LSuPdnRStzjaRlwAmutH
	 wDt7DbdL77vcsC1vww35nSrRFWhUlxIC7QZd3nKQxf+F4yTTPeEhIdh8708hTb2jSX
	 wh8DSbbu/M3sBJGXJV81aHLEaa96XkecIC1TIuxcOWoOdYsMF3cqpWM834TkVzdtcR
	 EzQLN875rKKCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] xfs: refactor directory data block walking loops in scrub
Date: Thu,  5 Nov 2026 11:23:37 -0500
Message-ID: <20261105162325.2112487-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110438-luckless-handiwork-a5c4@gregkh>
References: <2026110438-luckless-handiwork-a5c4@gregkh>
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

[ Upstream commit 19b5653cc870788df71e7fcf2dd7b6131d8868dc ]

Hoist the inner loop code of the directory data block walking code in
the directory scrub and repair code to separate functions in preparation
for strengthening the validation in a subsequent patch.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Stable-dep-of: 5d470234d04d ("xfs: improve dirent bounds checking in scrub and repair")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/dir.c        | 56 ++++++++++++++++++++++++++----
 fs/xfs/scrub/dir_repair.c | 73 ++++++++++++++++++++++++++++-----------
 2 files changed, 102 insertions(+), 27 deletions(-)

diff --git a/fs/xfs/scrub/dir.c b/fs/xfs/scrub/dir.c
index 7b0a9d2aea3ec..2f73baee0f0b4 100644
--- a/fs/xfs/scrub/dir.c
+++ b/fs/xfs/scrub/dir.c
@@ -313,6 +313,45 @@ xchk_dir_actor(
 	return error;
 }
 
+/*
+ * Deal with an unused directory entry.  Returns a positive number of bytes to
+ * advance in the directory block, zero to stop processing, or -1 if corruption
+ * was found.
+ */
+static int
+xchk_dir_check_unused(
+	struct xchk_da_btree		*ds,
+	struct xfs_buf			*bp,
+	unsigned int			iter_off,
+	unsigned int			end)
+{
+	struct xfs_dir2_data_unused	*dup = bp->b_addr + iter_off;
+
+	return be16_to_cpu(dup->length);
+}
+
+/*
+ * Check a directory entry.  Returns a positive number of bytes to advance
+ * in the directory block, zero to stop processing, or -1 if corruption was
+ * found.
+ */
+static int
+xchk_dir_check_entry(
+	struct xchk_da_btree		*ds,
+	struct xfs_buf			*bp,
+	unsigned int			iter_off,
+	unsigned int			end,
+	struct xfs_dir2_data_entry	*dent)
+{
+	struct xfs_dir2_data_entry	*dep = bp->b_addr + iter_off;
+	struct xfs_mount		*mp = ds->state->mp;
+
+	if (dep == dent)
+		return 0;
+
+	return xfs_dir2_data_entsize(mp, dep->namelen);
+}
+
 /* Scrub a directory btree record. */
 STATIC int
 xchk_dir_rec(
@@ -389,21 +428,24 @@ xchk_dir_rec(
 		goto out_relse;
 	}
 	for (;;) {
-		struct xfs_dir2_data_entry	*dep = bp->b_addr + iter_off;
 		struct xfs_dir2_data_unused	*dup = bp->b_addr + iter_off;
+		int				advance;
 
 		if (iter_off >= end) {
 			xchk_fblock_set_corrupt(ds->sc, XFS_DATA_FORK, rec_bno);
 			goto out_relse;
 		}
 
-		if (be16_to_cpu(dup->freetag) == XFS_DIR2_DATA_FREE_TAG) {
-			iter_off += be16_to_cpu(dup->length);
-			continue;
-		}
-		if (dep == dent)
+		if (dup->freetag == cpu_to_be16(XFS_DIR2_DATA_FREE_TAG))
+			advance = xchk_dir_check_unused(ds, bp, iter_off, end);
+		else
+			advance = xchk_dir_check_entry(ds, bp, iter_off, end,
+					dent);
+		if (advance < 0)
+			goto out_relse;
+		if (!advance)
 			break;
-		iter_off += xfs_dir2_data_entsize(mp, dep->namelen);
+		iter_off += advance;
 	}
 
 	/* Retrieve the entry, sanity check it, and compare hashes. */
diff --git a/fs/xfs/scrub/dir_repair.c b/fs/xfs/scrub/dir_repair.c
index 9aafe5c31cbe3..f8e88b638c43d 100644
--- a/fs/xfs/scrub/dir_repair.c
+++ b/fs/xfs/scrub/dir_repair.c
@@ -462,6 +462,52 @@ xrep_dir_salvage_data_entry(
 	return xrep_dir_salvage_entry(rd, dep->name, dep->namelen, ino);
 }
 
+/*
+ * Deal with an unused directory entry.  Returns a positive number of bytes to
+ * advance in the directory block, or zero to stop processing.
+ */
+static int
+xrep_dir_recover_unused(
+	struct xfs_buf			*bp,
+	unsigned int			offset,
+	unsigned int			end)
+{
+	struct xfs_dir2_data_unused	*dup = bp->b_addr + offset;
+
+	return be16_to_cpu(dup->length);
+}
+
+/*
+ * Salvage a directory entry.  Returns a positive number of bytes to advance
+ * in the directory block, zero to stop processing, or a negative errno.
+ */
+static int
+xrep_dir_recover_entry(
+	struct xrep_dir			*rd,
+	struct xfs_buf			*bp,
+	unsigned int			offset,
+	unsigned int			end)
+{
+	struct xfs_dir2_data_entry	*dep = bp->b_addr + offset;
+	unsigned int			advance;
+	int				error;
+
+	/* Don't walk off the end of the block. */
+	advance = xfs_dir2_data_entsize(rd->sc->mp, dep->namelen);
+	if (!advance)
+		return 0;
+	if (offset + advance > end)
+		return 0;
+
+	/* Ok, let's save this entry. */
+	error = xrep_dir_salvage_data_entry(rd, dep);
+	if (error < 0)
+		return error;
+
+	return advance;
+}
+
+
 /* Try to recover block/data format directory entries. */
 STATIC int
 xrep_dir_recover_data(
@@ -483,33 +529,20 @@ xrep_dir_recover_data(
 
 	while (offset < end) {
 		struct xfs_dir2_data_unused	*dup = bp->b_addr + offset;
-		struct xfs_dir2_data_entry	*dep = bp->b_addr + offset;
-		unsigned int			advance;
+		int				advance;
 
 		if (xchk_should_terminate(rd->sc, &error))
 			return error;
 
-		/* Skip unused entries. */
-		if (be16_to_cpu(dup->freetag) == XFS_DIR2_DATA_FREE_TAG) {
-			if (!dup->length)
-				break;
-			offset += be16_to_cpu(dup->length);
-			continue;
-		}
-
-		/* Don't walk off the end of the block. */
-		advance = xfs_dir2_data_entsize(rd->sc->mp, dep->namelen);
+		if (dup->freetag == cpu_to_be16(XFS_DIR2_DATA_FREE_TAG))
+			advance = xrep_dir_recover_unused(bp, offset, end);
+		else
+			advance = xrep_dir_recover_entry(rd, bp, offset, end);
+		if (advance < 0)
+			return advance;
 		if (!advance)
 			break;
 		offset += advance;
-		if (offset > end)
-			break;
-
-		/* Ok, let's save this entry. */
-		error = xrep_dir_salvage_data_entry(rd, dep);
-		if (error)
-			return error;
-
 	}
 
 	return 0;
-- 
2.53.0

