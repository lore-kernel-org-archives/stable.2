Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D4043BDA1
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797758; cv=none; b=S5e8EQ+l4OHNAGyEm8agGkfgMnAkArG+xYN4x1Dj6lBNPIlsKejB0JlRPz11Pemr1NNR36z4x1o6B/0B8kH5FlLFGaM+0YkjD5BcIqB3d7OBchXuzFFlRbhmrlZfIoqSwLThItf77lqu7Pg1lTd+S3rx42qW+nvaoM0LZQZGDPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797758; c=relaxed/simple;
	bh=G1q19Fz4srqjASXl9ngZdhnvGIHBAOKwWNVkwBZ2jX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXuZ/QcMZ6f8e5D6fS7A9qOh9sceetwXC0tIGxXGG7Vrix6QcoEjGKPU6vuJFWGwTtAXrRkbG50EhxkNth2qRt4vcByMglPu+WsEnbJBjxRoeDbnUdtj49qFaicP5Dmqb5Garajc0m+vJM7e7NkZ6DF4ki6FIbiVm0ZTQnSNhKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuGF77+U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuGF77+U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F031F00898;
	Wed, 30 Sep 2026 19:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790797754;
	bh=t+TQfCeRfG7Ls9GonPglrSSpYuNirlOmq5q39bEMEXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GuGF77+Ug6i8WEp/Il/XYmEEFFYVZ2zBzDt/9+VyRfB04z1snj1CD4S1EXu0Nzrjp
	 X31Q0RoUiu4+ZvLHfCKfFCyD6jJoozlXBPrfttnAQtQVAzi8EeEweOkJx1dtsgP5Ls
	 yXTkBdDSNc2z/QeZ1/EGscAj5125lb61R27Tqge+TAQtF4PBmtlLE2zYEh70ordPiF
	 LXmgoXARRC85hpDCqyVI66fm4kVFdvNqy/diRgmd4QHk0wyiYWMhanQw+hrRh8qoq9
	 3kgCDmVygclHn0XAfi3adjZAeD0t7duKtW1t52lX5JoVXtkLvvtlSm6ES0P2Lra6DF
	 cLDV7CuEiCuXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] smb/client: use stack-allocated smb2_file_all_info in smb3_query_mf_symlink()
Date: Wed, 30 Sep 2026 15:49:09 -0400
Message-ID: <20260930194911.886968-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092945-chowder-rearview-c340@gregkh>
References: <2026092945-chowder-rearview-c340@gregkh>
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
index 007da0a699cb0..e1b23e7bd1b61 100644
--- a/fs/smb/client/link.c
+++ b/fs/smb/client/link.c
@@ -343,7 +343,7 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	int buf_type = CIFS_NO_BUFFER;
 	__le16 *utf16_path;
 	__u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
-	struct smb2_file_all_info *pfile_info = NULL;
+	struct smb2_file_all_info file_info = {};
 
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
@@ -359,20 +359,12 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
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
@@ -390,7 +382,6 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 qmf_out_open_fail:
 	kfree(utf16_path);
-	kfree(pfile_info);
 	return rc;
 }
 
-- 
2.53.0

