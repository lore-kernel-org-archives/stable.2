Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634733;
	b=FEXspBVSKgubcEYMMRjH1uLk27LMd5IsP/UVZ28Wu7YjhDDxWLS3at3vPDK8lZ80w+GB
	 yRhcqDI6rDDjaVNL/6Y6iqPDVN3m/cNv8k4Uu3EbfNBvBtoe/+dtIelknOe7qG9aUVq2U
	 wZy+Bdrc80WKHE9vdzzdaYY7mEoRjDQf16ooEHGjdwO8pYRMtEyjvsL+GQ0E7YGXkwqKS
	 yxLw+ETG5eCiRTVF/pSTWWYvetd0ThY20DUn8Uev6NCXGLm3QO/2SQ/cTuhd1wqHvZjoj
	 hn71J/H6Lhd/KeXhLT1niYIB7FSEfQKK+CGKY6bkawJS/1XQKB33PVu2B5sSHxYJzcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634733;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DUEAU9nEFxu8fd9l74XoyOIb5fuZv2poWMXvg7eJmT0=;
	b=fIfWzSLfhQs/T38B+Paspwm6fa9lKgHf0841TVqD08HPwxPn/s/OsvaT4FfbBNWJuxLF
	 OO1jl2XnyUrkQ2A45dqDVVTPZRhoWqEi/7oQ6+FJj6ipSeWNpM5jg0FvShvX14vbO2eKR
	 B5M1yty+zNbGXVSzY1G3q4nJYFDgBfq6bOSozDHpWI3thHnfnTPRp2S3CL25r331Wm1e9
	 1fgJI4JoViIl5BibJYe8y2I/z7E7sOJp7epcxKhZ286llv/gB6XNRJVE9aHIHOHdzkj9a
	 a6Zhxx969jgpfj5+iWE/KxSdB4MlWxYs/c5rKf0E1s56cgVvQO+RsVlKMB8SDPWn/GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EFT30KzT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D006606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EFT30KzT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6874A1F000D8;
	Wed, 25 Nov 2026 19:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634733;
	bh=DUEAU9nEFxu8fd9l74XoyOIb5fuZv2poWMXvg7eJmT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EFT30KzTAOtqXoxCq6NnoeXZ0vgdSbdieLec53uxRsfdN7JN+iaD7QJRIv5JK64me
	 IjkdiAe8EqXdx8jqUhof+kXUZ5bjG4e8TBhDLcdzRo+gRrQyBkAkBwdV+8+OLSYRaq
	 OWkdFiqyMMdZEAebFcsu+MaOVtO5i45JBFrs3zT8nT5x0NY68S8fj+mnIQy1l7bkua
	 dnM2ZY40AhuH7DvGCyCekmCrlS3VvXa8PHfPzFoipS1wEVdam7iWC4KNRyuAo/I9vM
	 HYMFuwHxZzQbPQnuAow/ZPt5Yn4h2NQlXOMnzh4eHad5+JLNzkHgX4SU2BLuOS2AOA
	 KRsZqP/4+PMWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiwoo Kim <arpe1618@gmail.com>,
	stable@kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: pin parent dentries in SMB2 CREATE ACL path
Date: Wed, 25 Nov 2026 14:25:31 -0500
Message-ID: <20261125192512.1244971-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112519-filing-unpaid-50b8@gregkh>
References: <2026112519-filing-unpaid-50b8@gregkh>
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
[ sashal: adjusted include list and used non-const struct mnt_idmap *idmap in smb_inherit_dacl() to match older context. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 39 +++++++++++++++++++++++++++++++--------
 fs/smb/server/smbacl.c  |  9 ++++++++-
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index f35ce9f7c322b..d287bef38af92 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3415,16 +3415,32 @@ int smb2_open(struct ksmbd_work *work)
 
 			if ((daccess & FILE_DELETE_LE) ||
 			    (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
-				rc = inode_permission(idmap,
-						      d_inode(path.dentry->d_parent),
-						      MAY_EXEC | MAY_WRITE);
+				struct dentry *parent = dget_parent(path.dentry);
+				struct inode *parent_inode = d_inode(parent);
+
+				if (parent_inode)
+					rc = inode_permission(idmap, parent_inode,
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
@@ -3478,10 +3494,17 @@ int smb2_open(struct ksmbd_work *work)
 	if (created) {
 		int posix_acl_rc;
 		struct inode *inode = d_inode(path.dentry);
-
-		posix_acl_rc = ksmbd_vfs_inherit_posix_acl(idmap,
-							   &path,
-							   d_inode(path.dentry->d_parent));
+		struct inode *parent_inode;
+		struct dentry *parent;
+
+		parent = dget_parent(path.dentry);
+		parent_inode = d_inode(parent);
+		if (parent_inode)
+			posix_acl_rc = ksmbd_vfs_inherit_posix_acl(idmap, &path,
+								   parent_inode);
+		else
+			posix_acl_rc = -ENOENT;
+		dput(parent);
 		if (posix_acl_rc)
 			ksmbd_debug(SMB, "inherit posix acl failed : %d\n", posix_acl_rc);
 
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index cf429f6bf0573..f2f4e20429611 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/dcache.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/mnt_idmapping.h>
@@ -1200,7 +1201,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	struct smb_acl *parent_pdacl;
 	struct smb_ntsd *parent_pntsd = NULL;
 	struct smb_sid owner_sid, group_sid;
-	struct dentry *parent = path->dentry->d_parent;
+	struct dentry *parent;
 	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	int inherited_flags = 0, flags = 0, i, nt_size = 0, pdacl_size;
 	int rc = 0, pntsd_type, ppntsd_size, acl_len, aces_size;
@@ -1210,8 +1211,14 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	char *aces_base;
 	bool is_dir = S_ISDIR(d_inode(path->dentry)->i_mode);
 
+	parent = dget_parent(path->dentry);
+	if (!d_inode(parent)) {
+		dput(parent);
+		return -ENOENT;
+	}
 	ppntsd_size = ksmbd_vfs_get_sd_xattr(conn, idmap,
 					    parent, &parent_pntsd);
+	dput(parent);
 	if (ppntsd_size <= 0)
 		return -ENOENT;
 
-- 
2.53.0

