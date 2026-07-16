Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5003F166A
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202750; cv=none; b=IzfjS0MZsL3vNjdwThTZBb3DkUcG9l1VvxHkjqr5B5sQ91vTQTIiVoyZpyQsM1b9Juab7zHP4c+g24x5Enb6QoCRUo4k6R48mXkQNVpmuHtR4NUuqx28dD0EPquJBMIacgdTHOZpqUcvr7rvn75A3EE+gcR2Wgi2F3uu+moBnt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202750; c=relaxed/simple;
	bh=4Lxc4MnJZy3/n08YxZW8lZiHWOkhbTklEdbtda0F1Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h+6VPfKXk3kLVF4DEJQIkN5Z8Z0eFyvPoIjpNvZkfnV/+l7jPpkxh2iP9E3CxyvqHR3XX4hiE2i0ye5IQAIITCu81HuAv4kuUy/5v8Kb9BNo4kv6kHy1ivYDwcUPqI8L0Hbkt23dghx5nL+J/oQfsbSDItBFrUebiW24b6hQ1kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keUo6ivq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keUo6ivq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A901F000E9;
	Thu, 16 Jul 2026 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784202749;
	bh=t50SXq7A2eMWWgXTNsfthl8dwm/M/ZXorhu8/a9F8Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=keUo6ivq0R8nwHFuFRjC79TY1FXLcu4ot0XXSUlhOmnhlnD2Nwr4I2oFikJdUHUjY
	 tl2Pi3N5olF2IaC2FgON5+uDvW79TF9XF7fGCXQ+0W7ukOPRXjVpFJMmlc/BGxEQgt
	 ZSq+vmg+tP7SB6sizkcyxOYMUviSZcKjYf4Kle2y65TI20iG8QGuIM3K9L1KoMoqV/
	 /2Bkezaa1wv9K7jZPfyd9O0HUQLRPvxzp+5dnGAIaEz9r2zBcOjif/iloILq5Utct5
	 vfmBrSnxpCu08Xk/A+0jhUJHBXsZW6yTNDvFGn7hxoQwkGSdLMaTt9hmYRJYm6sRYl
	 GX1CHmAP10QRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Musaab Khan <musaab.khan@protonmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: use opener credentials for FSCTL mutations
Date: Thu, 16 Jul 2026 07:52:27 -0400
Message-ID: <20260716115227.1785304-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071404-uninjured-universe-16a4@gregkh>
References: <2026071404-uninjured-universe-16a4@gregkh>
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
index 04fa2c9bba8091..9801f8b5194726 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8165,6 +8165,7 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 	if (fp->f_ci->m_fattr != old_fattr &&
 	    test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_STORE_DOS_ATTRS)) {
+		const struct cred *saved_cred;
 		struct xattr_dos_attrib da;
 
 		ret = ksmbd_vfs_get_dos_attrib_xattr(idmap,
@@ -8173,9 +8174,11 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
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
index 820352463a06fd..c9664911df5800 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -994,15 +994,21 @@ void ksmbd_vfs_set_fadvise(struct file *filp, __le32 option)
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

