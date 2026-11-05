Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898837;
	b=tDPZ1jmIgH9foheUnlIijsi4P3v1OEZTZAN588+KwL8d2MV0dbdzH2wE/WfvlOkS0PrH
	 AVBfBWfl6BGfYGUo6uPVhaDsTA2cgUBhyG+obsOsi16RtHlRPRaDIOLOHxGjPzMmh/9eA
	 sY/cpe5+wtMoQEy6VdMYfYmh7dyBhuxYBdBgHhywsbbmtBc7sBH12M8wIa/I5wmPxPaa5
	 q4eQ1u+w6h4/9ROoiuYA4rvdZjL7uXppUuucRSLDMKzu2uovmaQbF5gUDmR27tWYOY5Kn
	 dff0ukPbKnZuDTByLji6AVZRow2omt+yhBT49+S1bUD9vKkSO7UR1Y1jFFczaCanv3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898837;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eNA0USDL3lQ0+LX0uHo+mtnYCDUR2u4stH5L/5FmRaI=;
	b=yEqbycmX7i1dfpgmw3CQB22C7yi0RU6yzjIGnoGJxgzXfIdVv7jJDtIx1kzwTC2C1bcR
	 5R4ubyq7Oow0vNVCw6aot/og43njUSzxx7hgQbpzKpAacpyuW2twOOYYTatWcx54x64IU
	 /IFjjcKk3tHzgdItSbBRCTF51ShLG5UR9Qq2Pgi8nrV8f8CfCAQs4m+Cx3zBggcFRL9eE
	 SZ0QhOhpcNxblhOppoPX/XXuuruVnfyWxTRZHK7MiIuaiMyqyWJ/ZDtzINnifdnf83reI
	 Zu/YVZ36EinU3mRM9fO8uh88i8etNOlIkod0e7vUamnYiLorjyYRMl3Fgqs2WVv63ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WVxgtaJu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358FB606A334
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WVxgtaJu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F66D1F000C1;
	Thu,  5 Nov 2026 17:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898836;
	bh=eNA0USDL3lQ0+LX0uHo+mtnYCDUR2u4stH5L/5FmRaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WVxgtaJujuMHpjRqXSELRh9x3YAKnQLQar2xJaU504Vu2W7GVCfN5O5vrSZtCk1By
	 NqB2oCIPS8rbWvD7BNf5tUjLTxqJHwCo+YtyU0fgqJ9ekfPWc89Us/Tk1laoOrKIb4
	 F+iDH8p4ZJBiassnZ7PU39OOalwFAUOvc29AsQT0OEW2JBXGlq8KCZnoJ1V0Tto0qp
	 ghPE8VGtyDSrwzlE7CD/A6NLeTEsWJGRJJEBvIdQGEQPshEYVzZGK6N04N/b07Cs7J
	 /6RyQMej8hAohgPasRoEuFSNGNdCrD+X0hGwh+07YvsJs+MohovrQayxIRbmGBN4T+
	 Yeoh4YpJ6TwrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] xfs: refactor directory data block walking loops in scrub
Date: Thu,  5 Nov 2026 12:13:54 -0500
Message-ID: <20261105171319.2146310-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110439-earlobe-retract-6b7b@gregkh>
References: <2026110439-earlobe-retract-6b7b@gregkh>
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
index 284f72ef2b584..7928dbe221d58 100644
--- a/fs/xfs/scrub/dir.c
+++ b/fs/xfs/scrub/dir.c
@@ -305,6 +305,45 @@ xchk_dir_actor(
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
@@ -381,21 +420,24 @@ xchk_dir_rec(
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
index 2bc2354cd85d4..4c565f7bcd290 100644
--- a/fs/xfs/scrub/dir_repair.c
+++ b/fs/xfs/scrub/dir_repair.c
@@ -456,6 +456,52 @@ xrep_dir_salvage_data_entry(
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
@@ -477,33 +523,20 @@ xrep_dir_recover_data(
 
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

