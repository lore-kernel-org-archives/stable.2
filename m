Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FB2415F20
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 23:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790810037; cv=none; b=mL9q9uIacKPDr6mym7l/mmTbixPO/l/59nSzV3dV43IPNR8G5n/RBDtO9iGnMvI1Vv8UrEtOgdmtNNZz4P2rsG84dsVGMP+QD38xxGgBU3J6uuPQNtCH6TcaAy4EolDv5sU2nbY2vebqTdoGsPTmGxvtx6OoHJWN45VPTB6G9GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790810037; c=relaxed/simple;
	bh=t7uuR+W9i2YGNWa5HHdEn8jUiqkHcG8l4ynJspZETIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqXiRAsi1vqTS4nfwZLw/oP8UAM+83EkKqEKL9BPFz5lFlKrmF3ZU1+Gh75UVzn6Z21czo2EIswA7zyxdGbCERzZGbVYYGLDDdz558x5rr6X4SuIvnsv/yYOS4XZArTxKbr/+Fp+yndTZLvSDsdcc9yJ+scl40AEJko1uppFsdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmQZS3zD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmQZS3zD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740F51F000FF;
	Wed, 30 Sep 2026 23:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790810033;
	bh=sxMxGOHaGYpE+8gLg1Z5X97KT/ICQc7hUje564wmw9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TmQZS3zDzdHUWdwUhfFS0pNSMXZyQAa+LsYJ6NdIsGYapk1ezFX/db3XhG5EFU9T1
	 a1URK6s54S108QGeFwP0+zxVPQwMlJWcQXlzJdZvJPERTdtqVW0R+Mdpc1ncT0xM+0
	 b3PBcqDTev1XisDVq0bnIhs4Oab2ZpPwI6QvIHuSFoFDHR5mNmoSQIf7ardfEKDEfD
	 veciH0Od7Oj2tqjrWnU9WebYf2ntkvANG798yFz+n5qH1dcHg+BDFoXAQV31MaIwtG
	 P89BDgd/3zmxqXXwTOV90cSxGNLMDbQUyMmGgdf0M5gcg1DWyr/GV5XlEvKkTNiL1i
	 haxKEHr172nSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] smb/client: use stack-allocated smb2_file_all_info in smb3_query_mf_symlink()
Date: Wed, 30 Sep 2026 19:13:47 -0400
Message-ID: <20260930231349.590269-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092945-conclude-congrats-b326@gregkh>
References: <2026092945-conclude-congrats-b326@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

[ Upstream commit fc8789bb57e625e5f32ac57ca2e7d3e7b7fda225 ]

SMB2_open() only fills the fixed fields, so a stack-allocated
smb2_file_all_info is sufficient here.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 566820af017e ("smb: client: close handle after create-context parsing failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/link.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/smb/client/link.c b/fs/smb/client/link.c
index d71feb3fdbd2c..ce76807cfe915 100644
--- a/fs/smb/client/link.c
+++ b/fs/smb/client/link.c
@@ -355,7 +355,7 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	int buf_type = CIFS_NO_BUFFER;
 	__le16 *utf16_path;
 	__u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
-	struct smb2_file_all_info *pfile_info = NULL;
+	struct smb2_file_all_info file_info = {};
 
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
@@ -371,20 +371,12 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	if (utf16_path == NULL)
 		return -ENOMEM;
 
-	pfile_info = kzalloc(sizeof(struct smb2_file_all_info) + PATH_MAX * 2,
-			     GFP_KERNEL);
-
-	if (pfile_info == NULL) {
-		kfree(utf16_path);
-		return  -ENOMEM;
-	}
-
-	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, pfile_info, NULL,
+	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, &file_info, NULL,
 		       NULL, NULL);
 	if (rc)
 		goto qmf_out_open_fail;
 
-	if (pfile_info->EndOfFile != cpu_to_le64(CIFS_MF_SYMLINK_FILE_SIZE)) {
+	if (file_info.EndOfFile != cpu_to_le64(CIFS_MF_SYMLINK_FILE_SIZE)) {
 		/* it's not a symlink */
 		rc = -ENOENT; /* Is there a better rc to return? */
 		goto qmf_out;
@@ -402,7 +394,6 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 qmf_out_open_fail:
 	kfree(utf16_path);
-	kfree(pfile_info);
 	return rc;
 }
 
-- 
2.53.0

