Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311796;
	b=351I6jlhiE3txgGlXO6rnn1eLID6KJPBA9gDCGbFMlPA6KPrmjeSIvEgMQ0OG3dERi84
	 JEy9e37YOuaL0a0uYAOCgz1lMlK8tqS9hLLQMJLluNgeOaQyiVfUwcS1XVBWZJ3j62DvY
	 NnjvL8eZNcFKlENbzsQz5imIB3Z2gK4AHswC6g0etmlAU2LLEr/3tSaxOqH4ZhboWNl5k
	 eOlgzT5Rdqplqa/WlvdA+kqW/aDe3ZetiviFE77Vnd/wSMWB2vmaMXbSvvC8j5uGeN5r7
	 zEiHx3TEqF42Jdf/mu2UmkN9cdURvt8T2AxiF4aHbgYuaqR5Rl/ppmKa+JTjqydjxLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311796;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=H1w5JJE4xsmMqV+dsFVUrTRIaN5v84Iy7CPPvG27Ow8=;
	b=vhuS50zt21PPgeiopVoy0C2WTFE+RBaQAdZbNRtd02GS8xavf50or81t/7LTUKDKek9Q
	 sMPyUKBRlmRrnw0QcggleV9+BNxjw36U2a6JZSIEr1AKad7s1P1qGay1S3BISjMN2V8So
	 2aisAh2V3P5aKvQiceK2yV7yqcj2/P7O4rndtlRqdFQih/q+An6CwBxZ9qxHET550ej47
	 UphFKfzJW7HNws1VIHJ7cGlJ0q5ARvAJj1GJeUm5nRYrN7n43VvchMvfEUBBkXUfLm86u
	 ghcw+aEoBC/e1xxW8fcJqV75dDz933IoS0YurMxSjkw2oP97gT4DZQOD5oGWju21Ueg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQvYDzWy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F58606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQvYDzWy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1BE1F008A3;
	Tue, 10 Nov 2026 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311796;
	bh=H1w5JJE4xsmMqV+dsFVUrTRIaN5v84Iy7CPPvG27Ow8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aQvYDzWyHMcM0dd+6+NjAqmfHfGXIB9S/vbAkErPBmAjXoJ+/UePaF80CRzuHXWHs
	 7elhgBlAfc2nf/5cBodFvvBcvSk+S0xIUOZJb0IamtJPP/10pbZsA4cfyvfyVJyfSS
	 rKJWSgpSTXqCZ4w/i6UQlfbpjGk41sISmJkGO9fJOjXo//1pOxuLxe8pVCThicaFDZ
	 ftbrvh5utJEYwzqbWSi0e4ckiyVxfWuaTy8PW+57LSc8j6gOkgh31enbVLMTWhSCtG
	 j/9lKsENi0m4wkcmeWJ80gTRHb1v+75HAW5p6rSV/vSfCN1LoibGLc4IOQi2FeiAtc
	 zGXezaBUy7esQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Robert Morris <rtm@csail.mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] udf: Avoid invalid LVID used on mount
Date: Tue, 10 Nov 2026 06:56:33 -0500
Message-ID: <20261110115625.906950-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052823-failed-6.6-a61fb39759d7@kernel.org>
References: <20261107052823-failed-6.6-a61fb39759d7@kernel.org>
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
index 8da1e24ed599d..67c9111624d84 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1650,6 +1650,20 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
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
@@ -1660,7 +1674,6 @@ static void udf_load_logicalvolint(struct super_block *sb, struct kernel_extent_
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct logicalVolIntegrityDesc *lvid;
 	int indirections = 0;
-	u32 parts, impuselen;
 
 	while (++indirections <= UDF_MAX_LVID_NESTING) {
 		final_bh = NULL;
@@ -1682,32 +1695,27 @@ static void udf_load_logicalvolint(struct super_block *sb, struct kernel_extent_
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

