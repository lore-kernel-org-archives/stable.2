Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE94071CC
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197105; cv=none; b=kxABJPG1crGOkVPaDuOtqlD1NIRIQgThQ+kAYkuOJv2RYTrVsL2y4BC2aNdbqdub8FioIWlLr0QZ/CfmQ+1SqYvSgRTMBPL9P+GZwHNopPHa9hD/Gx7fRTOl4i41CLl/XQeHOXuHiffYSUzDbYAf5WCmTNzCCW8OOs+AndkcNYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197105; c=relaxed/simple;
	bh=5gv/YBNpVOOfIh0HtrjH0EfksuL5XK6qljxB7sbv5qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NB1SV/1ds6xR5NgFvbqHE0OFs8jfsuzQfhk7fNBfZKY/vT7ZUCogUGbfndQlGa8hWc7o3ofrzKolQ+y6VMZRlIIUJPNdZ9ajL/ZGuHeXyVowCttEyETjpgji7TWBab2dFXkRhifccOm6encfaG9dWT8Xpxyp0Vq1IThcEKoZ4r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOgWN2HZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOgWN2HZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3D31F000E9;
	Thu, 16 Jul 2026 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784197104;
	bh=ePG8aN1a1eqA0zjDZTt7HCGwu7UkWm9IYWvM/trdNUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TOgWN2HZB63ORbe0V3SHpGFN0kAWmTD6KvVbc/UF6LrmCXyY2Tz/Y9ZjIiRlhlsYy
	 WKUEW7t7SVoU32nxRHsLUbjy/uunAYGd6b/Z0Lhwmfw4+exuPP05Y6Hm3saSxVcPpI
	 5I7bgcQ2WO7/2EQE9k/BheKcu5d6tYhD3/ryfPsinxBolLZTb/NQPzAI2fHbVS4UAq
	 1NFwiHaFDO+8af2jUHkAfi9leEDYUI/JortV9hT4FaK6MBeRDrtLmlyBb2ADDodTxm
	 dmIXQLxV8prf0juLrCEod84Vn/2I5PZmWskMkIj+zzTpmP2CyBLGZQzStrAM88ole+
	 7Rl655XRk3sbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Musaab Khan <musaab.khan@protonmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] ksmbd: use opener credentials for FSCTL mutations
Date: Thu, 16 Jul 2026 06:18:19 -0400
Message-ID: <20260716101819.1461638-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716101819.1461638-1-sashal@kernel.org>
References: <2026071403-ferris-hydroxide-5531@gregkh>
 <20260716101819.1461638-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit c6394bcaf254c5baf9aff43376020be5db6d3316 ]

SET_SPARSE, SET_ZERO_DATA and SET_COMPRESSION operate on an open SMB
handle but call VFS xattr, fallocate or fileattr helpers with the current
ksmbd worker credentials. Those helpers can revalidate inode permissions,
ownership and LSM policy independently of the SMB handle access mask.

Run each operation with the credentials captured in the target file when
the handle was opened. Keep credential handling local to these single-file
FSCTLs rather than applying session credentials to the complete IOCTL
handler, which also contains handle-less and multi-handle operations.

Cc: stable@vger.kernel.org
Reported-by: Musaab Khan <musaab.khan@protonmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c |  3 +++
 fs/smb/server/vfs.c     | 20 +++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index c012c5a93cc61f..e7ff03afed76f0 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8244,6 +8244,7 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 	if (fp->f_ci->m_fattr != old_fattr &&
 	    test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_STORE_DOS_ATTRS)) {
+		const struct cred *saved_cred;
 		struct xattr_dos_attrib da;
 
 		ret = ksmbd_vfs_get_dos_attrib_xattr(idmap,
@@ -8252,9 +8253,11 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 			goto out;
 
 		da.attr = le32_to_cpu(fp->f_ci->m_fattr);
+		saved_cred = override_creds(fp->filp->f_cred);
 		ret = ksmbd_vfs_set_dos_attrib_xattr(idmap,
 						     &fp->filp->f_path,
 						     &da, true);
+		revert_creds(saved_cred);
 		if (ret)
 			fp->f_ci->m_fattr = old_fattr;
 	}
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 90e693e4e41497..1062dc7f3fef64 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -988,15 +988,21 @@ void ksmbd_vfs_set_fadvise(struct file *filp, __le32 option)
 int ksmbd_vfs_zero_data(struct ksmbd_work *work, struct ksmbd_file *fp,
 			loff_t off, loff_t len)
 {
+	const struct cred *saved_cred;
+	int err;
+
 	smb_break_all_levII_oplock(work, fp, 1);
+	saved_cred = override_creds(fp->filp->f_cred);
 	if (fp->f_ci->m_fattr & FILE_ATTRIBUTE_SPARSE_FILE_LE)
-		return vfs_fallocate(fp->filp,
-				     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				     off, len);
-
-	return vfs_fallocate(fp->filp,
-			     FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE,
-			     off, len);
+		err = vfs_fallocate(fp->filp,
+				    FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				    off, len);
+	else
+		err = vfs_fallocate(fp->filp,
+				    FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE,
+				    off, len);
+	revert_creds(saved_cred);
+	return err;
 }
 
 int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
-- 
2.53.0

