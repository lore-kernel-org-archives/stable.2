Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC74F6465
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781243; cv=none; b=tJZGl1183kfcPHACXcStmFbkmnBGL8jPGlF0z47DFbx4xde1S/PCZeDL/SLRWPpmWR4/L9oWkYUOv+f5DC/NuOItZcv+if5Cv2eAkQiwJc2uByPrbeSVnZlhHEEDzpyeaKLafrn5l3V1tU3hu6GdljpaxX/OAwXeSkEVR6lo220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781243; c=relaxed/simple;
	bh=eyrtkw7NqwmlJmgFhCRT2nZ245DH5RpgmflfwlUTfgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFWnSMmI0vm7cUJ6faINTUIvwPRoatfBUqryYcb34kkZkZzRct7/5zjVcrDtXPdFbVtgWvkOcyRR9E8agJgU6rHHkKmwvRubuhgj0EveXBI4JFn+/mgc3G+ViCYiJ1kHeANLxzHRH6QP+NYwnz0DZ6LD8v2enQDBIMom98wJqk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lk+WLUDB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lk+WLUDB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088621F0089B;
	Wed, 30 Sep 2026 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790781230;
	bh=iXdRKWNucMsAbrT8DD7IsgDir+EITd2Vrt0d/Cw/VNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lk+WLUDB8ugJ8MNVm0e6Go6CGX3hhODVcZDoXVMlVUxkt/o0aPnoVwdN6uKbWTQb5
	 xkQoYtU9hj0HZwVG9KGEVB32Sc1ZYYXJIoV+6JThdnfX5Yl8t/aa1HbqE5ilJpLuCt
	 u7jSq4i0C49vXkc1j6SYYlQcfqSnfzoyYdgLPalvPoN4s70saQmnGbSWoj+TUSkvRJ
	 5kev5SsHPldkpppuPvnvGrynwgA2qLpKN2yALivulkxIO+TFyCxokFsoLNt5h/UYH7
	 btjHtym65YMkwVnOQnK6aPNrRBLtDnUZp7n6yl1EBsAJ4rLmzF/qxdZ5eAW1kDfQWT
	 JymL/kDpZuf2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] smb/client: use stack-allocated smb2_file_all_info in smb3_query_mf_symlink()
Date: Wed, 30 Sep 2026 11:13:45 -0400
Message-ID: <20260930151347.2502416-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930151347.2502416-1-sashal@kernel.org>
References: <2026092944-consensus-idealism-4247@gregkh>
 <20260930151347.2502416-1-sashal@kernel.org>
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
index ac31564ce9265..8654b03637347 100644
--- a/fs/smb/client/link.c
+++ b/fs/smb/client/link.c
@@ -320,7 +320,7 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	int buf_type = CIFS_NO_BUFFER;
 	__le16 *utf16_path;
 	__u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
-	struct smb2_file_all_info *pfile_info = NULL;
+	struct smb2_file_all_info file_info = {};
 
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
@@ -336,20 +336,12 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
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
@@ -367,7 +359,6 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 qmf_out_open_fail:
 	kfree(utf16_path);
-	kfree(pfile_info);
 	return rc;
 }
 
-- 
2.53.0

