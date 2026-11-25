Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636320;
	b=zE0E2bCDF1tdIc/GeMaVt0FTD3MACIvWjG1YtzSSFInglfuuAXKC32CZ0soeJ4CB8px/
	 2+RxmH9nAlsU+v0Cr81aoYMyV2WAK38RTFiLGysUd4KtdIQGPIW60KoBu3K9RrLsLlf46
	 IEhl5AQ208f21vWRbEWni0MBbxXpgtmAy+rz0RbDCp6dBRcwD5V1k2zsSyiEq5ULm5NkW
	 vvDhtY2xw4NAh/aRS/Tsp19vNwyRR52SDWC9qMGUMDHoIIzt2+DmvGVCD0FXJc3CMe6IS
	 qS8kUvgM+G0L6OydXPkADwdSFlObf38odruWb2TOzzK4rlfDQ+tC76zUdMn5oKwKFug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636320;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OpspEMXb1tk5lPSLu8kW8I6k0IEzm+zQ2o2v+fqM0Ig=;
	b=3fVXXWaBimpAOYC96/KTJHFD2r7/rHa3+l74R/6NakIQtciCVCiG70f4sb1ZCuI+cubr
	 qMR93mX+Eo5xPgYBUvGkAKJJ+T8lQVPY7DuSxTLZ0VUho8vOLQTzKWVhTyox6zzPtzfTt
	 eFdZ+LswLEhKaU8Z4zLzOC4U8WOeZ0R4F0iVYrtF7PKdIm6/u6Uk4rVOIKyUQ/TSuup2q
	 +kmXMKgDXloqyNTkr1Rz7+VpWmWAELlJ++abG2GOokd4m8tcp9fwlT7j/bgtTwpTYLons
	 vVTyrJV+rN9kVrpwF0yJtZM+wxJbAogMQ/VSapkfilsFsd/pkyGNIK3v6yW/2gtltYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvbvR4Cw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF90606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvbvR4Cw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392621F000C6;
	Wed, 25 Nov 2026 19:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795636319;
	bh=OpspEMXb1tk5lPSLu8kW8I6k0IEzm+zQ2o2v+fqM0Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LvbvR4Cwl41xJh0QREOeuLQsMUcXV/jYxU/jnvQ0KhiVnklGIjJEeG6MGpcrC3yxv
	 FK5f7R50VG+y2YqRlMuDnegQmI3bnZDBf7PKZcnsOnmTFiBQetjIPy03uSBDOBO1Tu
	 dY/qOLnuK7JHMeh0A6K/9dKY3A5kaAUCnNBjVXrx/eyDXYL1OsJgNxpsIjW5RjPtGz
	 HScvgNgFp1awV7AiY+KfH/IwDUxl7hhn6jrfquk6goZNYntLXmVKTeRa4z0bCn/QD9
	 gvakZtVlbgE4I5hNuBa/hbK+pbY0dGu1CuvClrIhaHn7Kkg8xLUPiUdqCCS9XQb1wl
	 ojI0R8CKCYPqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiwoo Kim <arpe1618@gmail.com>,
	stable@kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: pin parent dentries in SMB2 CREATE ACL path
Date: Wed, 25 Nov 2026 14:51:57 -0500
Message-ID: <20261125195133.1297528-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112520-subheader-ship-7f49@gregkh>
References: <2026112520-subheader-ship-7f49@gregkh>
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

From: Jiwoo Kim <arpe1618@gmail.com>

[ Upstream commit 0383a66dabd7aa06237b9b24713c03656abeffe4 ]

smb2_open() and smb_inherit_dacl() read a child's d_parent without a
dentry reference. A concurrent SMB request can move the child and
remove the parent while CREATE uses its inode for permission, status,
and ACL inheritance work. A remote SMB race with concurrent opener and
mover connections on a writable KSMBD acl_xattr share triggered an
8-byte slab-use-after-free read in get_cached_acl on tmpfs and ext4
KASAN guests. With oops=panic, it also caused an Oops and kernel panic
on an ext4 guest.

Take a parent dentry reference around each parent inode or ACL access
in these paths and release it when the operation completes. Treat a
negative parent dentry as -ENOENT for the affected operation.

On a tmpfs KASAN QEMU guest, two 3,000-round reproducer instances
completed without a KASAN report or Oops; SMB remained reachable. On
an ext4 non-KASAN QEMU guest with oops=panic, a 2,000-operation no-race
control and two 5,000-round reproducer instances completed without an
Oops or panic. An SMB health probe still succeeded.

OpenAI Codex assisted with finding the bug, generating the SMB race
reproducer, drafting this fix and changelog, and running the tests.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: Replaced raw d_parent accesses with dget_parent()/dput() as upstream does, adapting user_ns for idmap, pntsd_size for ppntsd_size, and the missing kunit include context. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 39 +++++++++++++++++++++++++++++++--------
 fs/ksmbd/smbacl.c  |  9 ++++++++-
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index bb4695b61ec39..5505b775ab190 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -3161,16 +3161,32 @@ int smb2_open(struct ksmbd_work *work)
 
 			if ((daccess & FILE_DELETE_LE) ||
 			    (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
-				rc = inode_permission(user_ns,
-						      d_inode(path.dentry->d_parent),
-						      MAY_EXEC | MAY_WRITE);
+				struct dentry *parent = dget_parent(path.dentry);
+				struct inode *parent_inode = d_inode(parent);
+
+				if (parent_inode)
+					rc = inode_permission(user_ns, parent_inode,
+							      MAY_EXEC | MAY_WRITE);
+				else
+					rc = -ENOENT;
+				dput(parent);
 				if (rc)
 					goto err_out;
 			}
 		}
 	}
 
-	rc = ksmbd_query_inode_status(path.dentry->d_parent);
+	{
+		struct dentry *parent = dget_parent(path.dentry);
+
+		if (!d_inode(parent)) {
+			dput(parent);
+			rc = -ENOENT;
+			goto err_out;
+		}
+		rc = ksmbd_query_inode_status(parent);
+		dput(parent);
+	}
 	if (rc == KSMBD_INODE_STATUS_PENDING_DELETE) {
 		rc = -EBUSY;
 		goto err_out;
@@ -3224,10 +3240,17 @@ int smb2_open(struct ksmbd_work *work)
 	if (created) {
 		int posix_acl_rc;
 		struct inode *inode = d_inode(path.dentry);
-
-		posix_acl_rc = ksmbd_vfs_inherit_posix_acl(user_ns,
-							   &path,
-							   d_inode(path.dentry->d_parent));
+		struct inode *parent_inode;
+		struct dentry *parent;
+
+		parent = dget_parent(path.dentry);
+		parent_inode = d_inode(parent);
+		if (parent_inode)
+			posix_acl_rc = ksmbd_vfs_inherit_posix_acl(user_ns, &path,
+								   parent_inode);
+		else
+			posix_acl_rc = -ENOENT;
+		dput(parent);
 		if (posix_acl_rc)
 			ksmbd_debug(SMB, "inherit posix acl failed : %d\n", posix_acl_rc);
 
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index adf9d2d2e108e..ff74bce96b4ed 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/dcache.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/mnt_idmapping.h>
@@ -1033,7 +1034,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	struct smb_acl *parent_pdacl;
 	struct smb_ntsd *parent_pntsd = NULL;
 	struct smb_sid owner_sid, group_sid;
-	struct dentry *parent = path->dentry->d_parent;
+	struct dentry *parent;
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	int inherited_flags = 0, flags = 0, i, ace_cnt = 0, nt_size = 0, pdacl_size;
 	int rc = 0, num_aces, pntsd_type, pntsd_size, acl_len, aces_size;
@@ -1042,8 +1043,14 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	char *aces_base;
 	bool is_dir = S_ISDIR(d_inode(path->dentry)->i_mode);
 
+	parent = dget_parent(path->dentry);
+	if (!d_inode(parent)) {
+		dput(parent);
+		return -ENOENT;
+	}
 	pntsd_size = ksmbd_vfs_get_sd_xattr(conn, user_ns,
 					    parent, &parent_pntsd);
+	dput(parent);
 	if (pntsd_size <= 0)
 		return -ENOENT;
 
-- 
2.53.0

