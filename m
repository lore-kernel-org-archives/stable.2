Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741853;
	b=QlD3POsQIFyelqZSFcfOy58MS5mWlG+0KbtKXkzT4Vc1+PBMmEYHKz/3KeQNK65hQXlX
	 JRSF5tQKzfG2e38vAiKaYPh7AT42UBx/2l0FljLnjQkEl6PnHnpzgZ0SVTEDG7ttPrydu
	 uWTTQzUR56UPzpsC/Q+cdNp6Ii4YVmxlNfwWniu0K625D44E90mwZ/uM2atN6cvQV0W/C
	 NJJbION8irSf5sA3/vIWIVP9tN/NFZwmQ4AoxhFbdnuxYLZzFS8XxOUj+ZikS5hdcTsZR
	 x/pHQ4tEl4G7llNDQcnBrMW8CatPQ4OMSx2KfUxK41UNP3G8DSaYJF87aDYXt4UyX2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741853;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RkDHy+t0bVXLaWUDacpDmRzamfBPlBIOF0/itQXcHbg=;
	b=XeAx+mHs8MgqmumrjrTHZborErstVqqOxEOKSSXgr7BAV3gzWhndoLqFP7t1+GuF2ADd
	 FuZlKHIc0/EgtZzT7Bgu4c2FHc+HK9N6qgHas7pFI2xB2doqNMNOHS1IjG7pav44GDgpe
	 h0rgvl4LUwfLftbHEpQ5REot6sNY9WPtWhuerTXpGFnpQGJBpxq98D8ZHKMhGaSlBDAuw
	 +VOE+LjuAmqG4/b3yKeJ9EpnMBmEW1uqbDWZJpzNDC/NCCirKfKluetYswjAUee9oVD8i
	 2kU8UAi5SBExKW84QTTQOV14BGlue5Dw/TxdMsTlf+mPW398MLXrRFkFpS6+nflIN1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RN59uWLc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8828D606A31B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RN59uWLc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714EF1F000C1;
	Tue,  3 Nov 2026 21:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741853;
	bh=RkDHy+t0bVXLaWUDacpDmRzamfBPlBIOF0/itQXcHbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RN59uWLcS1yIX8hKlmzdGLjdapvOwSfbcBfn5SLDM7D7HQChLTRCtZy40prQVkVvd
	 kR1mqice1DIdlBYROiRIJyVlXZrJ/5nytbqDVCZU+YDnYfu4B9d+wXPEDZi7dDTXLb
	 pEmGRBUHg0BXiIzXlqVE+/UzmbwmdGuTovZOrIYKY3CqqDHOAlCT5ksvtp3Q6MVXBh
	 HWwsQbT5yHKJeSaQTVn23IbfIJV5IkTBYfsHmlLc4gw0/4mCf0A7e3SmgQn2d1DheJ
	 ZFcPcg+d7fAg0laa/svGhLw4sbO6zimq1KlIG5+BdecIgI47uJ3B6ShcDegsNOw1R6
	 +FdRQfeVlMcfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henry Hu <huhai@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: fix invalid pointer dereference when get_inode_acl() fails
Date: Tue,  3 Nov 2026 16:37:31 -0500
Message-ID: <20261103213657.1420080-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110319-lumping-divided-daed@gregkh>
References: <2026110319-lumping-divided-daed@gregkh>
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
[ sashal: kept the struct mnt_idmap parameter of ksmbd_acls_fattr() non-const ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 42 +++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 5f752434be3cf..a26e4715c6b4c 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2724,10 +2724,11 @@ static int smb2_create_sd_buffer(struct ksmbd_work *work,
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
 
@@ -2738,10 +2739,28 @@ static void ksmbd_acls_fattr(struct smb_fattr *fattr,
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
@@ -3473,7 +3492,10 @@ int smb2_open(struct ksmbd_work *work)
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
@@ -5928,7 +5950,11 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 
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

