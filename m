Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701290;
	b=5p8WS7sYCidnAAfMPFytbve5nTuPfbSYIkqvFub9JKTcGe9I5LgqYKytv8V6ipr72hMG
	 6S18dhY6jcYXVlYTpw3CJkGbpqF4vFmVsOPBP1zgLsHdAXwl/bGlxibgavIXFE+N2F5yD
	 yr9loFE8J4Lcr/YBqL4JDM0bANIm2RfOlXfJwWUMd7Dt25cgL4dluP65oPVMnpXjIBiBD
	 KCtcJH3Tv7RYHrF7OgydhD+7k0vS3Q80RRX912ZLzpd7EKprOBvnmSTkqyA2NgEiA0+9y
	 CcxSY05cqQ+iKIkIas/keFd1xxL3XKhA4QYRNux12HMagOSt0RYLhFiW7hD2DgPoYoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701290;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bgVTCHKAWTAHv9byrjZQ6HwT1XBuQADjdRbyCCQEdM8=;
	b=DLqxtdiszrbt8Qr1VW2XW/+LBEI+3uPStBySKysDJwuZYwrCoh1xDnMYoTKCj3LGamRD
	 wZNL0Ygp6QeKk+3mBgzoko5gfm9OcBttrSXXoP7n22br5gh252YruzHzn/BkXq/Hho9OZ
	 dHWFcZTysEPnEoCqABC4egEEzRuYwCoqrO1pMKeD7RqpZeM2/LQAcUmfRXed7DwyDraQB
	 6AVj+QK5XNmidMahLmquFrQwD1TMCfsXHYRd2KKAlKdBaTbGP7qs51/38VjtHJwQkxzws
	 fmB7pHFZF5FQE+M1y1WHpwfY0jBCT7/aZ7LmBX8GwsF4pB0pSnFdCET2fkRAOkO7hEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2LJTu9Eh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB75606C560
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=2LJTu9Eh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC8F1F00A1B;
	Tue,  3 Nov 2026 10:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793701290;
	bh=bgVTCHKAWTAHv9byrjZQ6HwT1XBuQADjdRbyCCQEdM8=;
	h=Subject:To:Cc:From:Date;
	b=2LJTu9EhVkT90ImsA2JqsIg/1zSyRodc1A2b9/TSeqCsLYDVOSwM2aP8KNytcskyz
	 OcyZyoWu7+AF9IHkVqKaGfQxZ76SlErcMVjiqrsIGHgpKbNhzmekCRta92BQP3CeIX
	 0IWRSYG660cpvF1grabKHuk5sIwOowPUeaxjGS6Q=
Subject: FAILED: patch "[PATCH] ksmbd: fix invalid pointer dereference when get_inode_acl()" failed to apply to 6.1-stable tree
To: huhai@kylinos.cn,chenxiaosong@kylinos.cn,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:21:21 +0100
Message-ID: <2026110321-cheer-confetti-1346@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 19d180c7baab7126af5848ed87d5f7b5add0cef2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110321-cheer-confetti-1346@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 19d180c7baab7126af5848ed87d5f7b5add0cef2 Mon Sep 17 00:00:00 2001
From: Henry Hu <huhai@kylinos.cn>
Date: Wed, 9 Sep 2026 11:38:54 +0800
Subject: [PATCH] ksmbd: fix invalid pointer dereference when get_inode_acl()
 fails

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

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index c792ed5ebbd3..05a3388a3453 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3647,10 +3647,11 @@ static int smb2_create_sd_buffer(struct ksmbd_work *work,
 			    le32_to_cpu(sd_buf->ccontext.DataLength), true, false);
 }
 
-static void ksmbd_acls_fattr(struct smb_fattr *fattr,
-			     const struct mnt_idmap *idmap,
-			     struct inode *inode)
+static int ksmbd_acls_fattr(struct smb_fattr *fattr,
+			    const struct mnt_idmap *idmap,
+			    struct inode *inode)
 {
+	struct posix_acl *acl;
 	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
 	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
 
@@ -3661,10 +3662,28 @@ static void ksmbd_acls_fattr(struct smb_fattr *fattr,
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
@@ -4791,7 +4810,10 @@ int smb2_open(struct ksmbd_work *work)
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
@@ -7652,7 +7674,11 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 
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

