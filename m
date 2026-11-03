Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725423;
	b=B1o3AAiHrE8na+LWTVVOdO5UFHBa62gjZktGheXR1OR1sR2ix08nbDv+kxtzzdnqf+3R
	 PQfJVmyU+f9DXEGAlowjzYAYcQkuvIwORsKX3AF9CsGOiU/m+eHm3Vsjv9XE8XkcNpn8l
	 5X6VdulQAL/BapFt2q6pf/jQEsG/GANV4a6xk9IcGPHRqiyN+aFoMTTxHsUSZr3QTlfjb
	 Nz5A+s+cDBVtezxK00y3VR54WqLgJy6fBXCEG+DRAl720rjxKT4Uix0pY2yJp9KzXDf19
	 hhSRHu2AEPYmIU6s57Ef0aqWhRaYYBVxNF4US3pz2R8bt7FOFR2Gt1sqGKndQayyHPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725423;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gI17ypq4SD4nHjtvyfp4iawtzPSCiCClx2/ALF6wklU=;
	b=bnvISNNK+wji5/B31BqUsSFzVVqmpgA1+SKoVcYPL/bIePKhEeeybsbL3Vr/n9iFVNLu
	 +QT7QqQJ+t/DPULaMwEStzS1oqCexcbi94lcwGOwaDk8Zh05NIIwFsocBEZc76f7xBwlG
	 DhSohs/kzktc0eenkLw9UUrpWT6jlOsBG+zgMBdmKoWIk026aC4Gh6fj1aNiQBeGAYKvb
	 fe2XsT0ZXDUfgfb3iDwwwAkSsoY4SvwDOc0cyl+2Vm5ACscG9KOys0aEiP9H/33MMNEVV
	 zuQRSUN/zhPYX6ExAHQcFLZB1UNfbIRuug1yhbVLmtmVO/BlEDPVm0Fvt19D0JUqieA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxWxEQdX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2564606EE8F
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HxWxEQdX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26A01F00A18;
	Tue,  3 Nov 2026 17:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725422;
	bh=gI17ypq4SD4nHjtvyfp4iawtzPSCiCClx2/ALF6wklU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HxWxEQdXIiY4LNzZXB6CngJ1tLQPgCnNSwyIX4PsKv3L8HFhC6KtmmdvcJS7D0H35
	 mGkY4+ALUtSV/kWRjWn3u1rQDMP5T1RPrZBe4MxfQh3nWpZLpEWPqDXUGwiYoXM+Ca
	 HT56Ny6DtP7puJbi/HmVksU5Yns4YMn6YZt5lTXuAVxuzh32SdAuXgUTt7xjl9GfVy
	 yqzZyLWgwBNeWSMg1naOz1XbRQmEI+6ZZvz1DtFRf4G8F1TgEhDSa2A+HD137XMBQb
	 kp/zV5fMTn9IJWeD3T+y8urAu0pJBMRrf45h/CeKbPN4IWr3M53ROgBdJqTDkhZGPB
	 U8x0BJ8/aSCZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henry Hu <huhai@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] ksmbd: fix invalid pointer dereference when get_inode_acl() fails
Date: Tue,  3 Nov 2026 12:03:40 -0500
Message-ID: <20261103170316.641894-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110317-decimeter-fool-f1db@gregkh>
References: <2026110317-decimeter-fool-f1db@gregkh>
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
[ sashal: Retained the non-const struct mnt_idmap * parameter in ksmbd_acls_fattr() to match the existing UID/GID mapping helpers. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 42 +++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index b3743e17aa3c1..61c44f992ca75 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3683,10 +3683,11 @@ static int smb2_create_sd_buffer(struct ksmbd_work *work,
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
 
@@ -3697,10 +3698,28 @@ static void ksmbd_acls_fattr(struct smb_fattr *fattr,
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
@@ -4920,7 +4939,10 @@ int smb2_open(struct ksmbd_work *work)
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
@@ -7782,7 +7804,11 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 
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

