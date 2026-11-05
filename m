Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893639;
	b=TTBiJHpqYyQYidolhnHKgr8Yy6qA9ft7VW2Ia+ad13ES+doq4fn24EJv1dF0X8wOB1D2
	 qNGeCWwNDGWk1FwPYqnnVLn3RNNO1zdrVK/yzoQjmaOE169lV7rGmhuSGwrfXPsVOaI40
	 mvOtUkkwqFAP8QVHpa4XzsmUE2DKGRsK3l0sRAr4sL7Q+6cR+XMwt6jrdaV9OGDkTtlbh
	 EFos/P6oLqFL1GW1ldaXxU0Pmw3fM9WwnkRJlpAhUh54ue+YAUsnkpm60bBz+TTlfHsA0
	 IlmMkQEZx6NR/yGP6U7fqOYzbdl817bO6mVU5fPHzjW9Ua+7XWgpkbF66Gccf0oeiVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893639;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y9a4C97KoCj/PT0+jZJvXLEEuHbBPFrE3OqyAc2/aQE=;
	b=0+puNe8VybXOuNQCqIjj46y6A7SPREWgd93JwY5+ngsJzNDhRb+/qZCF9VUhHgAYLjTp
	 PJ04cuNU3K1amB5Uc4gNCdddoTUMfI3DDw85cB8luV7R+uLwNLfriB5DsMHS763k9ILXX
	 xmhPfY9J1LqhYALi/P6A6g6Da2TLs1yhLHUcjysM1DTn/W1D9qKl2HrTmXyvg8nilQsLC
	 e4Tuw3hXMtiIBzEjlYzhRIQoI2xhpMVAjHbT9n9w35+7BmK4Q/J+e0D/BD70oX2+Ia1xR
	 AV675xmuWV12KK+ts0WGEnUhgpjnMydrUiJ2QCEZrjKtLRfQYXHFEowNuptcjGB52jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHXHtAwU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8D3606D828
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KHXHtAwU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18381F00A15;
	Thu,  5 Nov 2026 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893639;
	bh=Y9a4C97KoCj/PT0+jZJvXLEEuHbBPFrE3OqyAc2/aQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KHXHtAwUo9XfjbCstsU5Y9CUCtZIj5uzBd70JLkMMgO6Sfygd4Hp+TxD7PnaBnZ/5
	 hfvDJhfZTVUyRySvD35BpkKUybxkkXEMXJVhQXOV8ZsDavLKAGKAju3OGZSE4/Chug
	 eOBho1n1CkSCl5qiKi7yrgCmJop6Yrhi1RChVN0Fma8bkCVLBf1JLEJy8HPFJt7f0H
	 YN/fRyg9gNGW1Rg+jnceDr//3afXUK2xh+Hfaru1AItYZgirNxogS4kClVss83JKv0
	 4M8sK/6lgXtLKOeD3rOmCVyPCYnJjIB6JjAeefLB0pBWUrgFyg0Fbjx51aOEf0rr5i
	 9Ocyb8gt2eAHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] xfs: refactor directory data block walking loops in scrub
Date: Thu,  5 Nov 2026 10:47:16 -0500
Message-ID: <20261105154711.2078714-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110438-devouring-spool-0e9a@gregkh>
References: <2026110438-devouring-spool-0e9a@gregkh>
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
index 4ab7e64692482..e35631e00ddec 100644
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
index bb3f2f462bde5..1169a2ad26876 100644
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

