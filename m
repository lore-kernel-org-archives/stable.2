Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E293BCD11
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210870; cv=none; b=DVe3M3zAkveEKaq3ELu79pYh3fUuOF8t9TI363u4EnCE93209cktgDy9uo8GCEFsRRJ/kxE9N6R4Qe3GD74klmg8PcJt31Ohq0ng/SvUGLvgEgGIn2zvURG2nS3z0WoHSyfwaxxLNdnwzRQAuUHdeFlkyfeh/fwa/CtDsv7KgtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210870; c=relaxed/simple;
	bh=fThGjJOJ8f0DWLoEyF4hGVM3moP3zmrcdgySF9cPdsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOJxD1hcUWNoGd0zmjNgkVyf9k4wTpsuhr0mUe3GHZHSCo+nOcigL/pwGoLD80eWlmFZS6H11Knb58d7sZD4fEU2dkd+Oq86wpr/2QhQDb09IMpS75iJcJd1tn99I01nBe+Cjt1veaPF50S/3cMLwMBDYYDPaHVbjdA07pDF9aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+SGQYb5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+SGQYb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E381F00A3A;
	Thu, 16 Jul 2026 14:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784210869;
	bh=ga2pH/3HRLUzY7302gjfBc5xIf4Axoatff518rTt5RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n+SGQYb5j3dewJ6VmDxWN7ji28/kGYnonAsBxpoOb/k/ZvlSnJi/SSSVzMH29fvYM
	 UyH2WDBv1oYzp6GHfhqsqTzdK9JJmgggXANy45lXc04SowOQKhTuepxtCW0sxOr70R
	 mI9rd1FNVlncxilFgqqYzrTpHyxcuvhF5JweKVhiktx+n5auUCJYrtoP6C9U5xSNXb
	 9zBLw5xfZTR7C3OT+pjovDnyxWXtV2cHIAA8tasm8uCEVGLL13mfknXuOrbf688URx
	 kGDI5BbFBWRYCk4oxK6ApOTNDZ1DEGeXKebLQCt/QnZc8119rtFOTmsKhvAUq/Qdbf
	 DWCizJWJkiv3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Musaab Khan <musaab.khan@protonmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: use opener credentials for FSCTL mutations
Date: Thu, 16 Jul 2026 10:07:47 -0400
Message-ID: <20260716140747.405713-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071404-shirt-hesitant-d526@gregkh>
References: <2026071404-shirt-hesitant-d526@gregkh>
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
index 1d49439035d22f..f6fb391178b8c6 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7716,6 +7716,7 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 	if (fp->f_ci->m_fattr != old_fattr &&
 	    test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_STORE_DOS_ATTRS)) {
+		const struct cred *saved_cred;
 		struct xattr_dos_attrib da;
 
 		ret = ksmbd_vfs_get_dos_attrib_xattr(user_ns,
@@ -7724,9 +7725,11 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 			goto out;
 
 		da.attr = le32_to_cpu(fp->f_ci->m_fattr);
+		saved_cred = override_creds(fp->filp->f_cred);
 		ret = ksmbd_vfs_set_dos_attrib_xattr(user_ns,
 						     &fp->filp->f_path,
 						     &da, true);
+		revert_creds(saved_cred);
 		if (ret)
 			fp->f_ci->m_fattr = old_fattr;
 	}
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 723f090458e7f8..1834dd4f255ec9 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -991,15 +991,21 @@ void ksmbd_vfs_set_fadvise(struct file *filp, __le32 option)
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

