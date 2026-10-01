Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6020043F4AF
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852466; cv=none; b=ZpQxTFvnr8lAXkp9A9J7mNuNYvtNtwQcXrpER0EeAfVp/Gye3jsXJX4sPOeCSplb+NU6LIHih5OxOwdcX5PNMukuQ8WhrfE9kf7c67cJv7b2sn66+3HYh2NBegFoe52v1iinvVXk7bb+9HNgab+4flmn9CccYvgQJYv6F7Ghmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852466; c=relaxed/simple;
	bh=CUPeFSPzYi61cALedgsbsv0FPJr+k7NK/gCzmgpaOaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwrDwqhzpefvvmX+K2QdEGz1pZVMfpr+yyigr5yKOu59K1dkUyUqwGtzOkVEc9PA3ymZCVndS+JEt/QFP0rzdtJ8yW8OnbrX0l9kwB7PvWsE0sUpENKywo6zodB6C0J5tqaADCztscT7Z7CM3XPBCyUvzCkEq0cCSGthP1lLQLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8XnhrYV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8XnhrYV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA371F00898;
	Thu,  1 Oct 2026 11:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790852464;
	bh=oK4eIRRENX6/qOsEAOzMDWVdDmofERXyesv23e73H+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q8XnhrYVfcEhMWJNWsjjj2AyvkW3VicUYBs7rjtSTgdEW5vTOOl5/YSZsqdKEK6KQ
	 u+praF/ddkNzyhTySeIjDBubtmR4AWNU2W/k9oMWRQUt8RL3BBu/NTP8AOJ37dPTng
	 3hOHNLXWypSBCptooqEq7JMpui2AoiJQzjmLujAfX4t+Dy0rysJ5QZSEjlHaJ+SSuK
	 95wtZQBDyPwodq+e3nppINL5rH7IVlTmSRMmoY2u+SIZT4pDtZTSjJHo2CMJ6HqdZk
	 5FTB1R5b49TjJl1v/pG0GZt3ynyQy8/8gK2oUEDhN2Kx6JjtXgi+dhxd4TtXWNK1W7
	 EFmRrOz65KJOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] smb/client: use stack-allocated smb2_file_all_info in smb3_query_mf_symlink()
Date: Thu,  1 Oct 2026 07:01:00 -0400
Message-ID: <20261001110102.3713269-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092946-apron-radio-67f9@gregkh>
References: <2026092946-apron-radio-67f9@gregkh>
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
 fs/cifs/link.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index 4fc6eb8e786d4..0779fd9a70594 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -396,7 +396,7 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	int buf_type = CIFS_NO_BUFFER;
 	__le16 *utf16_path;
 	__u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
-	struct smb2_file_all_info *pfile_info = NULL;
+	struct smb2_file_all_info file_info = {};
 
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
@@ -410,20 +410,12 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
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
@@ -441,7 +433,6 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 qmf_out_open_fail:
 	kfree(utf16_path);
-	kfree(pfile_info);
 	return rc;
 }
 
-- 
2.53.0

