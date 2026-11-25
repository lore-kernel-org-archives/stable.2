Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603106;
	b=vcAWUejL3Ixm3P2AaRMYq5mrhRFPE3EdVkXPbSGvtlb7wK+gWyKl2lfy9pqakwQiMXd+
	 NcssfWgjaTcK+TvzD38LoWXvOW7xlWuiof3JUbC+7aiegjgKVOkfhE+2Ywhqhf6Mns8s+
	 nFsiEKoRYOdNaiU99BeWjWal0rgyeamkx6f3NPAUv1lNA1DPJ8M0GntjZlepq0+z0IAiR
	 gngIqcg8O7xqmnk04T6vG/BFQ/7Rl8DdRvqW2it3EBRJ3BBO33osTufXsqzYHvlBX96ls
	 Syug8yshFdxVUzikX8iKuMxKv8gMI/CCJPf+kiXHXxaLTYBSsefguE3/ACjVPzmsofw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603106;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aSzV9vPL96b1MsSnUARPQtPcSa8KU0VwX9DE4K1IKEk=;
	b=04UTedGvIecIsmhsMKG9dKEdjzNQM9bpbe2O9eqE68l0TMasipglkJC+EXj1XM3j7S88
	 aLDOaO+o3PIlLnxccFRJ+Im7GYH9mabICLL96qU2Wbg+KTYSBVciqOYQAx8A46tygFeGY
	 /WPVQeSdQhXY8AWatA4fFUTJti/kS02lYJ0C+rWjygGllRhR+VKDmjEBgkg43tWkX/5q7
	 WWeqQQ9msALGBO7CA/rEEhnp2LsP7tZQ8a1p9WLJk8d0zGyqAnXCXHiDpl/E67I1vvbR4
	 83zTOyXjzCUIJGzbf0cfZQ0ZwLiZvZqISLL5anaYgNHIIhq+ZFo/hkW5eHxuCNF2qqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=inDTaDGp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665E606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=inDTaDGp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89651F000CA;
	Wed, 25 Nov 2026 10:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603106;
	bh=aSzV9vPL96b1MsSnUARPQtPcSa8KU0VwX9DE4K1IKEk=;
	h=Subject:To:Cc:From:Date;
	b=inDTaDGpry8RUIj37aHgY+29gI7T2aFR5PAIRN90utaE1OS6NnfaZdnvYdzsss/y+
	 eooPlt/p8PLKqgHeikM15rCV/IN4eUgXv1eVAa5Z0xIBAPih47MkfDzrH4VZ+5n9gL
	 WAZPfVHoFM9OOO2RzUxTv8UrWjpuIuwHaJbfrVEQ=
Subject: FAILED: patch "[PATCH] ksmbd: pin parent dentries in SMB2 CREATE ACL path" failed to apply to 6.6-stable tree
To: arpe1618@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:26:19 +0100
Message-ID: <2026112519-filing-unpaid-50b8@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0383a66dabd7aa06237b9b24713c03656abeffe4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112519-filing-unpaid-50b8@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0383a66dabd7aa06237b9b24713c03656abeffe4 Mon Sep 17 00:00:00 2001
From: Jiwoo Kim <arpe1618@gmail.com>
Date: Tue, 10 Nov 2026 16:24:05 +0900
Subject: [PATCH] ksmbd: pin parent dentries in SMB2 CREATE ACL path

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

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 72981756ee23..b03f0287d4d5 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4969,16 +4969,32 @@ int smb2_open(struct ksmbd_work *work)
 
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
@@ -5061,10 +5077,17 @@ int smb2_open(struct ksmbd_work *work)
 	if (created) {
 		int posix_acl_rc;
 		struct inode *inode = d_inode(path.dentry);
+		struct inode *parent_inode;
+		struct dentry *parent;
 
-		posix_acl_rc = ksmbd_vfs_inherit_posix_acl(idmap,
-							   &path,
-							   d_inode(path.dentry->d_parent));
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
index 1b387c262d59..a81f17fa725a 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/dcache.h>
 #include <kunit/visibility.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -1207,7 +1208,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 	struct smb_acl *parent_pdacl;
 	struct smb_ntsd *parent_pntsd = NULL;
 	struct smb_sid owner_sid, group_sid;
-	struct dentry *parent = path->dentry->d_parent;
+	struct dentry *parent;
 	const struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	int inherited_flags = 0, flags = 0, i, nt_size = 0, pdacl_size;
 	int rc = 0, pntsd_type, ppntsd_size, acl_len, aces_size;
@@ -1217,8 +1218,14 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
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
 

