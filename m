Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745575;
	b=lPTXO18T5j26nfGhgRXzCv/hQw525Atraxl+eoRmhDiTXdw7rNWZXJNADFMGKLDEmqOA
	 4o5BRU2UUyDrz401ReuIS3MplN62cJ6cSJNvXRAUupY+oeSniJVD8u/ED8GqPnhNwBPox
	 bGHHv5pXE3R/VRDfHFzxbr5ZVHowtQGgk45J9xSTV1L9y4c+McVTv5P7iFhKUrjZEPvRK
	 NafyDKGE+mVI3lkYncyYn6Fd7q1W9ITDWDc+l3FiukVqU+1W/LoF+05KYXF6XC+LutIFs
	 bCfzlSBsOX8aQ3Q3vbfk26ZSryGMlfJcO0g8/IjzzAkCbnpIp2Nj6q2P68EsLa1A+vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745575;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J2AMHa3hASkzJq1pQt2qLr4jbamNJFcltEZGfKdU4MQ=;
	b=xyuBJw9GWPtDHGnOWiud4ZBug6O+a6Tp3VDSeQObED0p4bgzrkD/OgfmDOtavEYmCPuh
	 4t9K5kG8wDgzhWKxfVbAjJIYNmhotBJ6MsMjcQNjtacE5GPKepWDaEH/qskwCSF5+4XGm
	 en5aIxzhVh82MU7KbqUnPxyy8tfCqO+/8QmLuoknMm8zLJD5ujSM8skUUtScArU2yl54O
	 C2qNAALKLye4wObaoG3c55GZ/5yFaOCg/V0Wt//nA8eqP0BoCU7WS9lsz4ixE9FkeLdM8
	 bksEj2LnTOZ9ao77K82bj8+Zp0ZyzNEtN3SEIvzEOhc4ZhQqChZImDt7hHkBdTNDrTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdTc62Lg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A93606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdTc62Lg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F771F000C1;
	Tue,  3 Nov 2026 22:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745575;
	bh=J2AMHa3hASkzJq1pQt2qLr4jbamNJFcltEZGfKdU4MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jdTc62Lgy3UqntLaMBEL9OfcZf2FCV9ig7EJkvs1SGeUEJVQIG7ZoywdLOOCBz9nO
	 UkxYVhaVOp1XuqIm0sr3H7BfO8hhEEShRrpnSiKeQegzVjxi+9ZCxb55jDO42K9UZH
	 C09uDM0lZrMqZ7J3I3FnQD0Rpb/0Eke0bPOfEYc8rjKQRwr1R8LW8FvNYlLHmR38OJ
	 r3t0QbryYrKKxWPUIvHTw6q5OYXHUiHTlBp2I8px9p/q8Kmtw7xB5Wd3a7jTmZlSTL
	 ATpzsJs72tcEtk3VS2b02XY6VLAr1qpvhvh+lsby6lNTsF1EV9vZnFvyPhqc1ADBFo
	 T7N+Rd+t+4Lpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henry Hu <huhai@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: fix invalid pointer dereference when get_inode_acl() fails
Date: Tue,  3 Nov 2026 17:39:33 -0500
Message-ID: <20261103223846.1547932-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110320-hydration-wreath-8606@gregkh>
References: <2026110320-hydration-wreath-8606@gregkh>
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
[ sashal: adapted ksmbd_acls_fattr() to use a non-const mnt_idmap parameter ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 42 +++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index aaccef2e3f3bb..b6af38af337dd 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2696,10 +2696,11 @@ static int smb2_create_sd_buffer(struct ksmbd_work *work,
 			    le32_to_cpu(sd_buf->ccontext.DataLength), true, false);
 }
 
-static void ksmbd_acls_fattr(struct smb_fattr *fattr,
-			     struct mnt_idmap *idmap,
-			     struct inode *inode)
+static int ksmbd_acls_fattr(struct smb_fattr *fattr,
+			    struct mnt_idmap *idmap,
+			    struct inode *inode)
 {
+	struct posix_acl *acl;
 	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
 	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
 
@@ -2710,10 +2711,28 @@ static void ksmbd_acls_fattr(struct smb_fattr *fattr,
 	fattr->cf_dacls = NULL;
 
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
-		fattr->cf_acls = get_inode_acl(inode, ACL_TYPE_ACCESS);
-		if (S_ISDIR(inode->i_mode))
-			fattr->cf_dacls = get_inode_acl(inode, ACL_TYPE_DEFAULT);
+		acl = get_inode_acl(inode, ACL_TYPE_ACCESS);
+		if (IS_ERR(acl)) {
+			if (acl != ERR_PTR(-EOPNOTSUPP))
+				return PTR_ERR(acl);
+			acl = NULL;
+		}
+		fattr->cf_acls = acl;
+
+		if (S_ISDIR(inode->i_mode)) {
+			acl = get_inode_acl(inode, ACL_TYPE_DEFAULT);
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
 
 enum {
@@ -3446,7 +3465,10 @@ int smb2_open(struct ksmbd_work *work)
 					int pntsd_size;
 					size_t scratch_len;
 
-					ksmbd_acls_fattr(&fattr, idmap, inode);
+					rc = ksmbd_acls_fattr(&fattr, idmap, inode);
+					if (rc)
+						goto err_out;
+
 					scratch_len = smb_acl_sec_desc_scratch_len(&fattr,
 							NULL, 0,
 							OWNER_SECINFO | GROUP_SECINFO |
@@ -5900,7 +5922,11 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 
 	idmap = file_mnt_idmap(fp->filp);
 	inode = file_inode(fp->filp);
-	ksmbd_acls_fattr(&fattr, idmap, inode);
+	rc = ksmbd_acls_fattr(&fattr, idmap, inode);
+	if (rc) {
+		ksmbd_fd_put(work, fp);
+		return rc;
+	}
 
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_ACL_XATTR))
-- 
2.53.0

