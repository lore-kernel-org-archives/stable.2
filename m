Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313001;
	b=phK612st5oQ6cOIfOLJ5259hlqQ7RPrAbXahHlPP6UzzJ0+3+PI8n40BrBGEFcGrZ5vL
	 lEyeqYU1t7W4IdoK/2ZtPcyxSESoaZYAbcgw7VSb6iV3HpDEE5iKIj59ilXudQwOCoIov
	 5IekwWWtZPUtE/or265Z/7o/pzZ+HFdf8NQVUS1snhCOL2a6Cag+T4Vrciing+blQdunv
	 P1hF87TxtCXuHtGE1iz1MLSMKkgNB4q66UWawBFAfb/FX3lDPxbJT7ewTCD+718P4TLqB
	 000TJ9DDu5V2b+IVSOYigAu8OmMcpp4mTRbyLvZL3meyUT+eB9Qa4YpTQZvHMPmXGxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313001;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fGS/Mc6KRxSiL2kYXvC8eU9MaMaIJXo+XgBO8bzxN7o=;
	b=oz6nNx4Qkzf6ALnTs3eLRgR32EdwEseoTHDvPNGsgDRkpShb2A9caTkxz6gt9QmTd92m
	 kEDjEiQhVHW7sSm5oqpSwpC+Vi7fUa5a0+QaSRF3nn+3IwwI7yKrQVKfef3I2ky794elv
	 ZwhV4rB7QOJ3df+/IjNuNtXdkY7mDkYxVUaVe13zIcsGpTPa0BxkqXX05u1P/vLGdi92d
	 IMTQr44XwTNchVqg+qjUJxPwQhVIAQDuiH43saC0kP1Fcb/9XKGAazfWjTZtcEARG29/W
	 EJJSJ7eFQt8/o2NQ8OieHJjKw+S72EKNXz8m+Z0L6sYhnF606sYG81xGCS4Je1H9Fgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jESQ3Vfi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDDB606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jESQ3Vfi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C0A1F0089F;
	Tue, 10 Nov 2026 12:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313000;
	bh=fGS/Mc6KRxSiL2kYXvC8eU9MaMaIJXo+XgBO8bzxN7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jESQ3VfiHCfhI4+MaVXn6+7EB/tz7HDqdmuAKmrWdHU/QvtPQDVbS+QfswrbUqGKD
	 B1Lb3zhIlQC0DpV19D51ebLbZQP37VbsavRWBHAgG7pQNo0KT/rCpJdu8c7pNMrm/H
	 oW4ML7Suo5hf/ttavkVg4hh1GVEHDxlm2KQZaHtfeWZrl81VSYfMNEuptIqzGhBGnA
	 nnWHLA4oz3T2kKlCDU/vv/CQDECXCDTKQiCDDKed1a1QD0AiUf90G3Q79TFc+QVCoD
	 Pc//VMS8gJS1j8ZeaXy2Yg/VyfEs737gSdz2gK5vrPyVPTSGsafFRIH3F7EciQ1Xds
	 0IJpaNAHxr8NA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Robert Morris <rtm@csail.mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] udf: Avoid invalid LVID used on mount
Date: Tue, 10 Nov 2026 07:16:38 -0500
Message-ID: <20261110121632.1067415-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061427-failed-5.10-a61fb39759d7@kernel.org>
References: <20261107061427-failed-5.10-a61fb39759d7@kernel.org>
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
index 467e760863486..58bc19b82afa4 100644
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

