Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636026;
	b=4081UYN4eMqjKr5XhrtHKzkjgsto7mYF3bcObkD5amHNhSYkY0nFzSnUjf4OGuAbCCwP
	 zokmoFCB5wXkU8x82Qhjw6bieb/tQiabGrcXgjM+efqD4M9kNHQcxgO6u/3WJueIwb4pV
	 vcJsy/B863kXMWnpsEnQQYv/E+kOL0ahpirvYY4/nhVR07ZcbfEEsFPu1ALOhrFQzB1a+
	 8LhFpwEan5DFMKRzTn2/+YBf2n+WKFXQY/re2M1f1QHmK7BUcRjDX6NRNF6ei4bsS5nxy
	 2xYb+frhCxFZMaS5VeUoZUqIz7DJvuAgS0vz/4QxMWGhn95YqiWWQnBdZFt1Wc58LFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636026;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LIRwkauZxqSG1ki52vsU5a1xUINinaPXINZ0IVCPowY=;
	b=DUWX/izsMZm8JsgNnEw6Dww0iusBU4vZiQ5rSahT4Vs8oEJ+6TgZ1TjLq1nh/Ydh1ZGZ
	 zaPAuPcadBHpG/2aiqd1FXxh7trKjG0UCWO9b539EAqjyJ/OXeHf/RCSefXSnRalJ5raW
	 6vvrxtM98YbBKd5ikfVufmLDTwpb2BM2EMzbXj9Ah4/wp2tyHTchJQLRKnQfrj4gxJt4w
	 /T+Hz8nia5UdWXZ5Ri6jxOI0cDubSoHsCRYGIv33g1oRHmHpUJnYGWo6EZM8/gxJrMlD/
	 +Kyhf6U46HOaujedjE2K1ALLj+krBBXxXyDa7udTdq/oUM0WF8914jkFgzVsMRk3mng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNmj7HyD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8E0606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNmj7HyD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D54C1F000C4;
	Wed, 25 Nov 2026 19:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795636026;
	bh=LIRwkauZxqSG1ki52vsU5a1xUINinaPXINZ0IVCPowY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HNmj7HyDs6ztmUBHMDui30sKSJL1cb6UaRuCM/aUWtRz+s3rQv+EWYRU6pryaerik
	 dn58m2y0Ou4i7QM0kfUOugF2UZZkpBi26wzJCjLnO9hpSfPnjZkrHFReYFl3sln4hd
	 i3MN5Azd9JrsQD+JWuAgj+2Tlh2OuDgu8IeiUZwsRHX71VjEyKcCsGrznJi70rMgEy
	 OPig4OKU+xam+JDdhGEIfw3Ovpsa3VNE+9dhIFZyU+oupYnI3BLpVC2rPDfQewMfLF
	 ILWXcPVYRGSFz4Jy4Srrh6cYio55lCYVx1DaSuu9T7wIidAHeXGDza6/ahSTf+VtKO
	 6rK0p291liKtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiwoo Kim <arpe1618@gmail.com>,
	stable@kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: pin parent dentries in SMB2 CREATE ACL path
Date: Wed, 25 Nov 2026 14:47:04 -0500
Message-ID: <20261125194629.1256948-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112519-enlisted-ripping-26f8@gregkh>
References: <2026112519-enlisted-ripping-26f8@gregkh>
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
[ sashal: Replaced idmap with user_ns throughout and dropped the <kunit/visibility.h> include, since this tree's smbacl.c has no KUnit hooks and the smbacl.c context lines differ. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 39 +++++++++++++++++++++++++++++++--------
 fs/smb/server/smbacl.c  |  9 ++++++++-
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 70150e016e6f7..cd01774de5f0c 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3188,16 +3188,32 @@ int smb2_open(struct ksmbd_work *work)
 
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
@@ -3251,10 +3267,17 @@ int smb2_open(struct ksmbd_work *work)
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
 
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index cb434c7539e02..e021c6bf79682 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/dcache.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/mnt_idmapping.h>
@@ -1184,7 +1185,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	struct smb_acl *parent_pdacl;
 	struct smb_ntsd *parent_pntsd = NULL;
 	struct smb_sid owner_sid, group_sid;
-	struct dentry *parent = path->dentry->d_parent;
+	struct dentry *parent;
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	int inherited_flags = 0, flags = 0, i, ace_cnt = 0, nt_size = 0, pdacl_size;
 	int rc = 0, num_aces, pntsd_type, ppntsd_size, acl_len, aces_size;
@@ -1193,8 +1194,14 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	char *aces_base;
 	bool is_dir = S_ISDIR(d_inode(path->dentry)->i_mode);
 
+	parent = dget_parent(path->dentry);
+	if (!d_inode(parent)) {
+		dput(parent);
+		return -ENOENT;
+	}
 	ppntsd_size = ksmbd_vfs_get_sd_xattr(conn, user_ns,
 					    parent, &parent_pntsd);
+	dput(parent);
 	if (ppntsd_size <= 0)
 		return -ENOENT;
 
-- 
2.53.0

