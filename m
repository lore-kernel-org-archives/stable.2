Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312239;
	b=j5m+FRKv2xBVgyXymWwgl0yq7ZSQHFDtEqa4u83jGDRHCf4mgll6iQfRsDHT7kqsM0Vr
	 zA4hoGeOh+UU/lTyHr9O+OQF3pZWYhh5Bn/uN716rxgElltzD6Pi70nbTxSfqfdQ4yh+W
	 d/J3+IwnOYcIrcfGJY2sM3/CpFnur1ZnVTNRK88U/h+5/MA6UBVuzYQK5nhiWFT6S4S65
	 SuoZl0vFeDYT4QAJI0Xb92lS8d+zvAl+FlPleKsYveXAKxRntRWNIQEWQzhjhOLYWQ+Pw
	 D9p7TEKA7fgkCOfSqhYgxPVKpHoUPQB6+tULi/mumXb0gMq2t7jwmQ19kSGfGJefe3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312239;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lJvNVZo7Fc4tz6yuvq5QFAlkwypvQxj4QOEbQH03rPY=;
	b=Rxh1V0t/OvFNNY+AU22JuWqVvZGKFOtbtUQH+fwKtjfr3vxgLRvBKp03N9lQrX6Xm6Pf
	 OAIMZ2mPvhrsxDlp7WYEfvZUv4gv/8q8HMRCC1JNp8uqPrQAoPreQXa6Hy06A5YOunkLV
	 xcNAAwRXCD5uVsYEYbYkf1ByBWSurb9sdxK/hDeMjkdZgcmMA6oWgka/46YjHIqNFVMUN
	 b2ZCsKBLYrOifSj07fRwDOIeWwxdJOqXZDMbV5gS2iybrdkprEMTKKvSl4qsrIR7TohLT
	 kRbZeKW+jkvYA80SA3rWgHurJE8J7YKGc7Gcjv9hEkWY4ndM2d95Z4zJ7TUipZ8ljcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cE2/H1dF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6460A260F
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cE2/H1dF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5341F008A2;
	Tue, 10 Nov 2026 12:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312239;
	bh=lJvNVZo7Fc4tz6yuvq5QFAlkwypvQxj4QOEbQH03rPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cE2/H1dFtbD8L2sXiYc0tcdrMrB7nRdNFWK+ZmZ84Kt5SE8T02bH4tYGUrLogB692
	 dPqzk7OGDCmk0XysS5GPEDs4cLcAWqDhDHgwTWqqHMe2qnTYPemNiwyExCioSFW8Km
	 VEfZEvsbjeJ4LP0FJdZvZZPrgTA2UcrtjFjB0YKZQ/dizUJBN49lOSZYpKzWkz+eI/
	 RUDlOwc4Fueq3r5+snscmDIpXcxwOZ/GNJk5SgdAMCXfscgs5lb2DPjqGCtHge+4f/
	 J82d2gfJLb3m+8JbCKeAqzoDsbp597KSVwaZaDbtpQIBQax0vl4zZFCDAuG3VqvXKL
	 XOdQ6eJl4jc6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Robert Morris <rtm@csail.mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] udf: Avoid invalid LVID used on mount
Date: Tue, 10 Nov 2026 07:03:56 -0500
Message-ID: <20261110120351.946680-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054056-failed-6.1-a61fb39759d7@kernel.org>
References: <20261107054056-failed-6.1-a61fb39759d7@kernel.org>
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
index 48ffcfd287eab..b091cc98406b4 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1574,6 +1574,20 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
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
@@ -1584,7 +1598,6 @@ static void udf_load_logicalvolint(struct super_block *sb, struct kernel_extent_
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct logicalVolIntegrityDesc *lvid;
 	int indirections = 0;
-	u32 parts, impuselen;
 
 	while (++indirections <= UDF_MAX_LVID_NESTING) {
 		final_bh = NULL;
@@ -1606,32 +1619,27 @@ static void udf_load_logicalvolint(struct super_block *sb, struct kernel_extent_
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

