Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492352E7F39
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 00:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790815600; cv=none; b=K1t5Sd4PDC5RkiPrvj+xZB2CZBUTzAlBUvxOQBhg+eu9Hbm64zo+EgCTKN7UJlSgZdKMi3goeZphSUBgsDWBn+Td21SQh1oi6VqLB8b8Hl1g/WHgNoPI2fCoFIoG3M6i+JW3lHecOwbkcyPmE/0yyHuqmBoNdUs3cO36wXGrHAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790815600; c=relaxed/simple;
	bh=2zPAlUSss7Skn6Baep2fXRul7cXQr5gxgireIbJ9bSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khr0nXzkW171MK3vTypI6dT61L4GUt/ImC2nLKFia4gpvYHED3PW5W6CSv1yrzp7ydYOuWwhlI3kK1f88Yqmgzm7prlfyq/egdT6gkQ0K0wcZ1dEqzc5Akpg58X3b80pxxqAJ0yYjXtbD45P0xpLtxNPpvLlkQ5jX8/bsKOYlxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XljqrOj9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XljqrOj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E05C1F000FF;
	Thu,  1 Oct 2026 00:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790815598;
	bh=FHBe9EPErAsh9pRddjSyRxCvme5WMDeMW1QtuB4SkBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XljqrOj9lkxWDluS0IHp9Qc+bTTysRTC21tTyNVPiGm7HmC8LdSsELgUN2e/VJ45H
	 BT5ArzZnatDqG8xr4mwbXEO3Qhfvl3tOHKE9DhW+zmFloP9LLQTPqLaPH6FxSIZ5tU
	 zm5FrxhHbKNYE7qhxFG8eHhtax9i80IsHOubjqE79vajcp6H0wPEfxISwfL2dfHfv+
	 4F8nuhrkUltGsAPF1kDChvFDNcSykxlBqqBt5I30+wyjBdCbiOK7AjO6NYyXGwlB5o
	 R8O4r6oCyF38u6nD37wnp6WJ0Bz7Pm92QIodvaPG6VKm2BX6RsKBUYvt8ol1o7KzKq
	 h3Q2NE6ss4m3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] smb/client: use stack-allocated smb2_file_all_info in smb3_query_mf_symlink()
Date: Wed, 30 Sep 2026 20:46:34 -0400
Message-ID: <20261001004636.2232529-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092945-vendor-cesarean-fd29@gregkh>
References: <2026092945-vendor-cesarean-fd29@gregkh>
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
index 4308b27ba3464..ec1b9cd44b511 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -384,7 +384,7 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	int buf_type = CIFS_NO_BUFFER;
 	__le16 *utf16_path;
 	__u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
-	struct smb2_file_all_info *pfile_info = NULL;
+	struct smb2_file_all_info file_info = {};
 
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
@@ -398,20 +398,12 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
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
@@ -429,7 +421,6 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 qmf_out_open_fail:
 	kfree(utf16_path);
-	kfree(pfile_info);
 	return rc;
 }
 
-- 
2.53.0

