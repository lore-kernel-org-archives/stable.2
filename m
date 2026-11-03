Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793748475;
	b=KfLiWKAkLa0OvRq9cq3w72T6u3K+NVELy4E4XC3pkIxNy9xtkvgiC+ix4xx5k3MzaiPZ
	 y8KvXqw9Eh89wW7ibUYfFDKuTVubzzMWMC5lZoA/3ExUvl9IDvQ2tPTTOIaRwGx7u3gyz
	 R9sM7WWlc8iEXaH5BKZNrSHlefLAbhsFwLrN6/r5LPMnVaHO8KAw7gnHsl3N12VvK7Khj
	 QwWGqDmhKHjePSQwGJcn8dvqQ8a935tIf1haL6pp7Is7nXrXAno1WLvR1zU/tXVjRwB+f
	 APyNTskrUGIG3syKX/MDZQtnW4Dl7ryx1fkh4Gw0KbJ1qO+trO1/c0dvTwg3i8kTAcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793748475;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9YlSOqHA0gHIXM4usQLx5lxexIrsjV51TvMzaJI2TuU=;
	b=IwmhK5yzQAYBiI19c5Hilsj8hkJKzCHGl9YcomZsAWSDp7r+rCHrmd/cVLyILAoWaiS7
	 W9M8lus/kqyhOdJdFZJRmJWmIqM9z+xSeccKJU642bB0bbl/FcG+j/UkWJkCvTjVNRERm
	 rKHXBcob6D2TBuZFhT5xo3FdTzz4YS4sotwQhlb3dkbaq9zAirerXup0BkLEdd5mBmC7q
	 kaNsjNVhOnTrWseDJWesjTeHZyeX337seHloOP1cMgUN29CsvLW4Y7ieeAg+uRHVH1VYt
	 tWacYtw/pijeT04pozm8mBrS4B+c6aQiMu4CRUSB+roD5rL67vxrBmsI8fALDz3qziA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IT8PkbuM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710B2606A31B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 23:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IT8PkbuM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513EC1F00919;
	Tue,  3 Nov 2026 23:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793748474;
	bh=9YlSOqHA0gHIXM4usQLx5lxexIrsjV51TvMzaJI2TuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IT8PkbuMOmLniGkqtwJw7GnTejH5a5wsdyW58ZSxDckjIPWBApDLxT3EzuhKlIXC2
	 HdNMA7F1wHOKGfuTyhcB2yKYzRAFJYhQoxSJDaAhp60mVAjzkr9eeMDBUYlIJrOIOP
	 cNA9pLRQgZaATbFrjXoRF4H2dbve/MdXKNTYjzDgCj15JPQTBlYFns+GS1e3n1vN2F
	 FSQyzLAIr0Cmy9P+hcQbG57UNl+vzJnuQ0+sa5SrkT9CF7rFwwm12asgeLPfe90GcB
	 T1g6Cys40mV8B61Duaq1eEywSt5dOCHA250rDUgWtpLO/5a44Pp/sKOVtweBcAaD6q
	 2oIP/su1ylePw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henry Hu <huhai@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: fix invalid pointer dereference when get_inode_acl() fails
Date: Tue,  3 Nov 2026 18:27:53 -0500
Message-ID: <20261103232717.1653576-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110321-cheer-confetti-1346@gregkh>
References: <2026110321-cheer-confetti-1346@gregkh>
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

From: Henry Hu <huhai@kylinos.cn>

[ Upstream commit 19d180c7baab7126af5848ed87d5f7b5add0cef2 ]

When get_inode_acl() fails, it returns an ERR_PTR(), but
ksmbd_acls_fattr() stored that pointer in smb_fattr without
checking for errors. Later callers then passed the error pointer
to security descriptor helpers or posix_acl_release(), resulting
in an invalid pointer dereference.

This was reproduced on an XFS-backed share when xfs_get_acl()
returned ERR_PTR(-ENOMEM). Querying the SMB ACL from a CIFS client
triggered the crash:

  BUG: unable to handle page fault for address: fffffffffffffff8
  RIP: smb_acl_sec_desc_scratch_len+0x58/0x90 [ksmbd]
  Call Trace:
   smb2_query_info+0x40d/0x17c0 [ksmbd]
   handle_ksmbd_work+0x1ca/0x770 [ksmbd]

Fix this by checking the return values from get_inode_acl() in
ksmbd_acls_fattr(). Treat -EOPNOTSUPP as indicating that no ACL is
available, and propagate all other errors to the callers. Update
smb2_open() and smb2_get_info_sec() to handle these errors.

Cc: stable@vger.kernel.org
Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Assisted-by: Codex:gpt-5.6-sol
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Henry Hu <huhai@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: adapted ACL lookup and mount mapping to use get_acl() and the existing user_namespace API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 42 +++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8d2f5e4e9ae3b..1ea9ab0039120 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2709,10 +2709,11 @@ static int smb2_create_sd_buffer(struct ksmbd_work *work,
 			    le32_to_cpu(sd_buf->ccontext.DataLength), true, false);
 }
 
-static void ksmbd_acls_fattr(struct smb_fattr *fattr,
-			     struct user_namespace *mnt_userns,
-			     struct inode *inode)
+static int ksmbd_acls_fattr(struct smb_fattr *fattr,
+			    struct user_namespace *mnt_userns,
+			    struct inode *inode)
 {
+	struct posix_acl *acl;
 	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
 	vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
 
@@ -2723,10 +2724,28 @@ static void ksmbd_acls_fattr(struct smb_fattr *fattr,
 	fattr->cf_dacls = NULL;
 
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
-		fattr->cf_acls = get_acl(inode, ACL_TYPE_ACCESS);
-		if (S_ISDIR(inode->i_mode))
-			fattr->cf_dacls = get_acl(inode, ACL_TYPE_DEFAULT);
+		acl = get_acl(inode, ACL_TYPE_ACCESS);
+		if (IS_ERR(acl)) {
+			if (acl != ERR_PTR(-EOPNOTSUPP))
+				return PTR_ERR(acl);
+			acl = NULL;
+		}
+		fattr->cf_acls = acl;
+
+		if (S_ISDIR(inode->i_mode)) {
+			acl = get_acl(inode, ACL_TYPE_DEFAULT);
+			if (IS_ERR(acl)) {
+				if (acl != ERR_PTR(-EOPNOTSUPP)) {
+					posix_acl_release(fattr->cf_acls);
+					return PTR_ERR(acl);
+				}
+				acl = NULL;
+			}
+			fattr->cf_dacls = acl;
+		}
 	}
+
+	return 0;
 }
 
 /**
@@ -3219,7 +3238,10 @@ int smb2_open(struct ksmbd_work *work)
 					int pntsd_size;
 					size_t scratch_len;
 
-					ksmbd_acls_fattr(&fattr, user_ns, inode);
+					rc = ksmbd_acls_fattr(&fattr, user_ns, inode);
+					if (rc)
+						goto err_out;
+
 					scratch_len = smb_acl_sec_desc_scratch_len(&fattr,
 							NULL, 0,
 							OWNER_SECINFO | GROUP_SECINFO |
@@ -5452,7 +5474,11 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 
 	user_ns = file_mnt_user_ns(fp->filp);
 	inode = file_inode(fp->filp);
-	ksmbd_acls_fattr(&fattr, user_ns, inode);
+	rc = ksmbd_acls_fattr(&fattr, user_ns, inode);
+	if (rc) {
+		ksmbd_fd_put(work, fp);
+		return rc;
+	}
 
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_ACL_XATTR))
-- 
2.53.0

