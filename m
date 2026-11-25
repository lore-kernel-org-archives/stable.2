Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634013;
	b=rTdth+7vKk0kxntBKDqzsuXmqArvuOzVG7sSJguhLDG5zhdsIjVzxLZxJCjkjiSPm8jI
	 LGuLE1NMN4uPCGhm7aAoivsfJYSSf1VwMMmUdvYOAlmsw1J0SH2DVUPzLuEWT1n4C5UyN
	 fkP3bSIgmhoE4ay9brfuWmMH6ZvhOI4SFz4VIxK4fm/t5kv9uHzSq7KAKE+cKou61b2ml
	 Izg+o3N6c+1UbS+CXpWWPShW0kJ6yH+1bbxs1Kmcc6IRgB1OKVYINF8k4E2NmS4DW51p/
	 qjDwznVGRtMzQgCnVZCpSjwNUumZkrg7H90OuSwfWZ3FV7hViiShY5bKf4eei7+0bbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634013;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LSi3XFf2nmIrDeg1ambiiy653yNw6ElKi9eLe8v+IBI=;
	b=iaD6O1Kfl1pC06DUOFPis6AvfoypCg+cxyl9P1mSFAKTf9bFBceLC5ZVseJuhgNB/Hjs
	 cdL35ulkQyHf05Ype2/nKP1RmrEsoJTYzEsUDefTw4iylfBQIXuzFTAIu+XQLcuOO3n5E
	 EY5+5CsLyOwCAfzbtTHW//IwCYCuuJIFi40+tescOt/ROtxu5g/bWqO4tfC3jIqb2u5S9
	 cYPxTbH+rxdEh9p2FvSdLa4/Fqv9MyJRus6pOoGjYrffz69vtRACQpjuVvoLBKkUZzCJY
	 T/dRgej+1rPAh1DlTBUZozUAQz6I8JQep20kgpq4mW69XjiJnfNFlKnQca20ePld1Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ILQj/tz1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29ED606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILQj/tz1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE87C1F000C0;
	Wed, 25 Nov 2026 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634012;
	bh=LSi3XFf2nmIrDeg1ambiiy653yNw6ElKi9eLe8v+IBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ILQj/tz1vMFTJk7JVFiaCP8gLAQutW2NEUs9K8oXI4AZoOsPqH3T3PzmSwtP1QP9B
	 nSTWWZ8c4xu75zP4PnK6UFQf/Pc6sc7tWMCh+6Q0o0NQ3t8YcJ0AXpDPE2pXtkacT7
	 GxngDgrwMDRGZ8+jv6g0c3MoOu7JYQv+ZLGD3pgflKVx9+HAO0sjQBXuLJv36SFhYC
	 T2Tj/+mMRONsmiq1YZh23Gd4JVf6JeqfO/XBbFQQhqt/ybmCXWT20Wss/0+Xt5n5hv
	 36FcI6I/drDDAIuS0LRnms5wyo9IeFUCGwHCOUOCzEOZ5i2k12UIoEyF2AYjK3XcRC
	 oRiKhMU3+9DVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiwoo Kim <arpe1618@gmail.com>,
	stable@kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] ksmbd: pin parent dentries in SMB2 CREATE ACL path
Date: Wed, 25 Nov 2026 14:13:30 -0500
Message-ID: <20261125191315.1192033-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112517-unified-kosher-ea2e@gregkh>
References: <2026112517-unified-kosher-ea2e@gregkh>
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
[ sashal: Dropped the kunit include and the const on idmap from the smbacl.c context lines, since this tree has neither, and kept only the fix's own changes. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 39 +++++++++++++++++++++++++++++++--------
 fs/smb/server/smbacl.c  |  9 ++++++++-
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8f9773e0cf016..d6359702faa3e 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4974,16 +4974,32 @@ int smb2_open(struct ksmbd_work *work)
 
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
@@ -5066,10 +5082,17 @@ int smb2_open(struct ksmbd_work *work)
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
index c3be25f2db87b..27da571c96127 100644
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

