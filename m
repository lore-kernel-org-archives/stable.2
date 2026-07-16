Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF2327FB05
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 02:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784167563; cv=none; b=Apyp3rZ6syXpg9mKOzu8yKL0hdGhYho5yvin355E+mjXBy0Q54lmbxTf2LjRzVPg8fyl90vQYlk/0lN+JpWdF0lI/X6txrU4U/hu0pm07t04NWduZsOl583yCkFc/L+cbDU9eeUAC64Bt3pNUfjB843nd1GTzXNgUzVOhJtpc8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784167563; c=relaxed/simple;
	bh=7dUOnMmJWZzxri0/u9tiRRSVzwPoL7YueVwOqoQZGMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqZuFcti2RHmSLcNoEtkpMdAMXlYn8l6h25SpafeQA5Z4U5/uww5Axbl2C9YvscPO9cHJe5oZCG+THOD+DrjWvgV0/1JX02rCJ0LrXLNbwEWgF9L2yWusXd+bu0brk+OgCTqOFALv2OtdE+SPs1zuXnmjSPVmcqfSEbjYg2AuCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc7rFKcm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc7rFKcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707341F00A3A;
	Thu, 16 Jul 2026 02:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784167562;
	bh=L7blKCtCW5pmL8TvJKI5LqvbdU1odd6W96Y15kboxO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dc7rFKcmwKCoAtvpXoD+UI9RKBAC9q2MUlHn1mAZ3uuJIOoD9HzQlh31NVaM9gqFB
	 v4M1zjxJPoiZEzo87Kt+hAqz6NKTms48/eRuKksw8xeq39qP3BORKUMmvbTUV64qHH
	 4bNc7qtUMaSh/NX5qcTqaseeG+JhwvxWMmRweVuSz3mnc/87PM/jRot6QoLcxSQz9A
	 IKVGwpzo8T8GJ2dxXaWCN3GgCqlzaCRUA7uVqO08ApCoQKTmXy9E66FkVF/svgOkdH
	 EtD0N8rs1MisNJ9N2uNvL9eV85s69QGoppezVlSx3Jy+9/FET44EkDv3qDREmjgNv7
	 kqbtndVheRRHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Musaab Khan <musaab.khan@protonmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] ksmbd: use opener credentials for FSCTL mutations
Date: Wed, 15 Jul 2026 22:05:58 -0400
Message-ID: <20260716020558.818894-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716020558.818894-1-sashal@kernel.org>
References: <2026071403-easeful-customary-a1e2@gregkh>
 <20260716020558.818894-1-sashal@kernel.org>
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
index 95d0ea045cfb09..9aa892021d9444 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8243,6 +8243,7 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 	if (fp->f_ci->m_fattr != old_fattr &&
 	    test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_STORE_DOS_ATTRS)) {
+		const struct cred *saved_cred;
 		struct xattr_dos_attrib da;
 
 		ret = ksmbd_vfs_get_dos_attrib_xattr(idmap,
@@ -8251,9 +8252,11 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
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
index d08973b288e581..aa7562a088e303 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -919,15 +919,21 @@ void ksmbd_vfs_set_fadvise(struct file *filp, __le32 option)
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

