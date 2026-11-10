Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312640;
	b=blmMbd4pHpl4msGvXLiEKKOqReZI0A0eTzTWvqpLWEhi8ad4m3SOKc6t+n/P91C1C+R9
	 DGDZzlHAZHy1iD7DcA4hQr0d8aAbqWSb/XRH+eDhfDaJXAUwSCsSIvfXNqPbv1XiHd3Lv
	 8dvDSQrUl3ka6o1WHlwiQwRhO4mDeH9ENJ6JkCvpOlIfhxgZTKFf5WMU0Y2n4zp+Ue0N1
	 dWWAZgRxJmn5tl4Wvu0F2w2Dt61M/VmmW09LLZdp+fv8cplAnEkzMWT7HY8zHHQoM+iRL
	 uDe3kGNhyh8Tu7GHyireSarz4tnWtJBii5T0U2eJqTJUr+wvdU/lo2qNIRdErdVoSEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312640;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GdpqTiEikhpxZQCdl8mq6b+hQ/utUBQBjACruMp4bMc=;
	b=Uam5XYjK3hTetE1dKUvGhStwYSANGGi6VSSrITvPXR2y9RtIxvrVJipvh2zafxzwJFxI
	 33D74Ti2e6hvh93XQVWXB9roQNSv1Ebs96VQC6qTrM1FHYcZtsHmw6RhSiFJFlKXzZAxB
	 XJZDMtBArdERqIuC15o4vbqyo12jzwiV8td/IkE8tst0IQyQnuvS8lJXPG80bbdA31IcG
	 zk5TVg3sSIIkzu9lw9JB43nWPqA2o3O8//ZXJtcn4FQL8RmolTeEg3KmWHzi2IMo278bt
	 5eoZ6m7vkGAL+I5hwbTxflSZejFWu0/+VAf2fqj36ltxjIvnJ2AhEDHPiLrxDrAg5UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fUvcNn/8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4599606A335
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUvcNn/8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5551F008A1;
	Tue, 10 Nov 2026 12:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312639;
	bh=GdpqTiEikhpxZQCdl8mq6b+hQ/utUBQBjACruMp4bMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fUvcNn/8Js99kzg1R20idN1EubNqukf5+5Q1P5c2iGG9ZpaPwtB+4ER6vzkn7WcZ8
	 DRVotmljwD9h9/KbM22m/E5JU5SqPGu69WQwt5BrFRSetnNfwszbBeD8//qzZGl3rC
	 +j32g4c37GmN56vpEQeUQlsmblB6Ii/jkgG5eqbNQpUrL34dNWXjBKyY1LrBi3Hmjv
	 RiMIIMbFi179YEXg1hdCib+Tex7A0BT51Fg3kHmiMJCAzqgAAOLm0KFGWpoRqL1lYp
	 BiwmGAh2skLSE6/cw7+xV1MNbPt2Aj1sTZrDMX4OPZFeN9SHaC03OiGc4H9IHJebvU
	 XlDtHoe01LRew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Robert Morris <rtm@csail.mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] udf: Avoid invalid LVID used on mount
Date: Tue, 10 Nov 2026 07:10:36 -0500
Message-ID: <20261110121023.978616-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055724-failed-5.15-a61fb39759d7@kernel.org>
References: <20261107055724-failed-5.15-a61fb39759d7@kernel.org>
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

From: Jan Kara <jack@suse.cz>

[ Upstream commit c8f1140cb82dc843e72697dc6f8c7ee1acce5d28 ]

udf_load_logicalvolint() loads logical volume integrity descriptors.
Since there can be multiple blocks with LVIDs, we verify the contents of
only the last (prevailing) LVID found. However if we fail to load the
last LVID (either due to IO error or because it's checksum fails to
match), we never perform the verification of validity of the LVID we are
going to use. If such LVID contains invalid data, we can hit
out-of-bounds access or similar issues. Fix the problem by verifying
each LVID we are potentially going to accept.

Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
Stable-dep-of: a61fb39759d7 ("udf: Make sure there's enough space for LVID implementation use field")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/super.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index afdc0f50a5f00..f9fe3f950de85 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1575,6 +1575,20 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
 	return ret;
 }
 
+static bool udf_lvid_valid(struct super_block *sb,
+			   struct logicalVolIntegrityDesc *lvid)
+{
+	u32 parts, impuselen;
+
+	parts = le32_to_cpu(lvid->numOfPartitions);
+	impuselen = le32_to_cpu(lvid->lengthOfImpUse);
+	if (parts >= sb->s_blocksize || impuselen >= sb->s_blocksize ||
+	    sizeof(struct logicalVolIntegrityDesc) + impuselen +
+	    2 * parts * sizeof(u32) > sb->s_blocksize)
+		return false;
+	return true;
+}
+
 /*
  * Find the prevailing Logical Volume Integrity Descriptor.
  */
@@ -1585,7 +1599,6 @@ static void udf_load_logicalvolint(struct super_block *sb, struct kernel_extent_
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct logicalVolIntegrityDesc *lvid;
 	int indirections = 0;
-	u32 parts, impuselen;
 
 	while (++indirections <= UDF_MAX_LVID_NESTING) {
 		final_bh = NULL;
@@ -1607,32 +1620,27 @@ static void udf_load_logicalvolint(struct super_block *sb, struct kernel_extent_
 		if (!final_bh)
 			return;
 
-		brelse(sbi->s_lvid_bh);
-		sbi->s_lvid_bh = final_bh;
-
 		lvid = (struct logicalVolIntegrityDesc *)final_bh->b_data;
+		if (udf_lvid_valid(sb, lvid)) {
+			brelse(sbi->s_lvid_bh);
+			sbi->s_lvid_bh = final_bh;
+		} else {
+			udf_warn(sb, "Corrupted LVID (parts=%u, impuselen=%u), "
+				 "ignoring.\n",
+				 le32_to_cpu(lvid->numOfPartitions),
+				 le32_to_cpu(lvid->lengthOfImpUse));
+		}
+
 		if (lvid->nextIntegrityExt.extLength == 0)
-			goto check;
+			return;
 
 		loc = leea_to_cpu(lvid->nextIntegrityExt);
 	}
 
 	udf_warn(sb, "Too many LVID indirections (max %u), ignoring.\n",
 		UDF_MAX_LVID_NESTING);
-out_err:
 	brelse(sbi->s_lvid_bh);
 	sbi->s_lvid_bh = NULL;
-	return;
-check:
-	parts = le32_to_cpu(lvid->numOfPartitions);
-	impuselen = le32_to_cpu(lvid->lengthOfImpUse);
-	if (parts >= sb->s_blocksize || impuselen >= sb->s_blocksize ||
-	    sizeof(struct logicalVolIntegrityDesc) + impuselen +
-	    2 * parts * sizeof(u32) > sb->s_blocksize) {
-		udf_warn(sb, "Corrupted LVID (parts=%u, impuselen=%u), "
-			 "ignoring.\n", parts, impuselen);
-		goto out_err;
-	}
 }
 
 /*
-- 
2.53.0

