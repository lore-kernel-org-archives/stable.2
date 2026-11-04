Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752903;
	b=WQ/o4ouYtVJiJHc1KN7lSoiDFme5ir+ydFicpL8onUDLyn6wiTE92WaSrVriuc9MquoI
	 Pr7BSdVTIjnPBmcIs9yKf7xbXELzv4UDp+U9u/6hY5PNmC9NP6QRKjFJ/ThXjyxiBF+L0
	 Dyhur6HUn8SkbAGhJALqMaddFci82Hy8SQJlMrj8tYbcqqhM876CDusLIxhWRCtoaqdGl
	 r6vURmTUTtlrKWwgXa56zIvkssVhZrU+7xaPNP8caDiGTLY48paGZ8+F/yQbB4UsnySeI
	 sNXawRwU+lg2haBLJ0cFi9/aJwenV7dfkZSpOr5uEFY99GzJyx/u5gHPNmF2zlYZYNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752903;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=19xl7fcvQ3PRDXDs19M+uQXk3TXZX7+z7U0spFpWAT4=;
	b=2mZOuq6rqRRXFnDMMIT/fy5wa59ocgdSipSd20SKnZ04+vn8W7xNkrdHG9Jbl/MZkE/i
	 P+2uCzDQSfbCRd9H2xr4xgJTIzpNKpnkkFN3YHE3FvgYMbPYZi72JDehesz85pBwgcfxZ
	 Vx/dtx6A/cj9wyMv/QeZNyuAjisZpB6PHpbdpHyYN7q1FA9DUJUw9E2PNL3Z4bWpnbOph
	 qMDvdNx423HysWPW92SFkpDRr5hRl0vT7eaFV0bre/DPmjEmTCj4fr0Slm6OP6sMquYyc
	 dhRQkZXJfiT04mM4zoBrDXEvxiqNjP9gqOqAyzpEsLSiTche/XjCpUdhTbbpgEztSLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfnZO75s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FABB606A324
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfnZO75s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC8B1F00919;
	Wed,  4 Nov 2026 00:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793752902;
	bh=19xl7fcvQ3PRDXDs19M+uQXk3TXZX7+z7U0spFpWAT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MfnZO75sjB8uYI4C95l/hP9sHj1C+kMOQ/4FgTlVSs6MC20XfKgsLhhqG6rL3znti
	 9iBsq9Cb6BvCJ4hZ6oQhwU1n7NhDB36HmoZEWP55knwBokqMtDkzlwOnH69LfLXhha
	 jPoupFdrnxnR9DUrwTdA2IeqKyl8/m+t/b3JOtOJ0kw3M8+MfUiti+rs7+uUX/Q0AY
	 Sob4OrqnzTm2RsYsTqxHBEquaWfz/GUUJIy/fAT5I1L2BO/6dwQdzQy2g5OBpFgJcZ
	 FLS5gAYDmeBxbxyve/k+rkLZf+1opKZbf9+JZBBBWvEcMHifeohBmUrvfWjXsOmzTJ
	 6Bz4/5VySf1hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henry Hu <huhai@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: fix invalid pointer dereference when get_inode_acl() fails
Date: Tue,  3 Nov 2026 19:41:41 -0500
Message-ID: <20261104004113.1931761-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110321-overstuff-recoil-e280@gregkh>
References: <2026110321-overstuff-recoil-e280@gregkh>
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
[ sashal: changed get_inode_acl() calls to get_acl() for the older ACL API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 4c42205fe5261..31dd82c8eb228 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2686,10 +2686,12 @@ static int smb2_create_sd_buffer(struct ksmbd_work *work,
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
+
 	fattr->cf_uid = i_uid_into_mnt(mnt_userns, inode);
 	fattr->cf_gid = i_gid_into_mnt(mnt_userns, inode);
 	fattr->cf_mode = inode->i_mode;
@@ -2697,10 +2699,28 @@ static void ksmbd_acls_fattr(struct smb_fattr *fattr,
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
@@ -3189,7 +3209,10 @@ int smb2_open(struct ksmbd_work *work)
 					struct smb_ntsd *pntsd;
 					int pntsd_size, ace_num = 0;
 
-					ksmbd_acls_fattr(&fattr, user_ns, inode);
+					rc = ksmbd_acls_fattr(&fattr, user_ns, inode);
+					if (rc)
+						goto err_out;
+
 					if (fattr.cf_acls)
 						ace_num = fattr.cf_acls->a_count;
 					if (fattr.cf_dacls)
@@ -5366,7 +5389,11 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 
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

