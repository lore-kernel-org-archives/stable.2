Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603103;
	b=JfX7sSFM2rBzB2vrYacS/AB7gOSXaxh0WyaSQ+RZPNWCj9ejxSM9V7qkPyOsucEa31NV
	 kMD00QzJuuv8u7rBmo2/801GA+s10boR1mOLthiCCOEETd3xQQ9xfJCSyTtedKbIzpaSQ
	 XcDTYP4SeTBM07cWahSMLBmglZ4eOiohxecgF8q8+9MtBr+CvMCp7bWXGskzi+gfS7liZ
	 zQoJ7XHAiR6Uy1mKSRY9apEVBc4a/kg8YzwMnxuSfQE4Jw5xzazx/DG9nqAgkhWMs4MQT
	 QsgnGWiqnn+0yKljt8+rb7NJ9Jy0XB0zlti46gkI6CUoFkrXk8Q/7MUobCqFo8PsnZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603103;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=52d5/5j5GSvsMcnK70ralFhT3FgTasmlSk6/Tr2pz/s=;
	b=jVGiNDeaWNO1eoNFEde6C7F6H3leonKJUmSo16KUexewEhezE+lZ/feU6bY93QWCA0oR
	 GTJhK/JU768MeXr1GS88Slxjdisa3Bb5qDoegxiA0rfAJGahMj8f9UWMNTSrTZVuGy+ZO
	 9KYpL9QS5b9uVCNIsr6EkoYQZKjjUCnx9qal1/RAetnRkZHxKX8dRxPmE+E45rR9d0xg5
	 a+mt5mxDLhyJrl7EcIvz3GxDAFjtHlHVgO2CJVQuAP/4+yGhXTq4+ljv7WXmm1RbcIWf/
	 /q/PclVmO5d1g907Fcy6ueI2gr/UfYQDyplvdhiaOY6kMzWe4hD2/Sq/ZuFBHUThGqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OOaDeFet;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEECD606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=OOaDeFet
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943D41F000D3;
	Wed, 25 Nov 2026 10:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603103;
	bh=52d5/5j5GSvsMcnK70ralFhT3FgTasmlSk6/Tr2pz/s=;
	h=Subject:To:Cc:From:Date;
	b=OOaDeFetVEhVTrAKQvyx9v92Az1MqSF9StkeNVyZhLAuBxKhIYYiMdi58IGS+1Fbq
	 mK0GnNubImGkNUc9G01VMvZnNZLtfgw1b4F7/lEy7MH/I4QPx75VqP5CsGx+6NFBie
	 AdwN4UDxCUUvIc+pPsmdHta9+w3xQE+gzd9aFHRY=
Subject: FAILED: patch "[PATCH] ksmbd: pin parent dentries in SMB2 CREATE ACL path" failed to apply to 6.1-stable tree
To: arpe1618@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:26:19 +0100
Message-ID: <2026112519-enlisted-ripping-26f8@gregkh>
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
git cherry-pick -x 0383a66dabd7aa06237b9b24713c03656abeffe4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112519-enlisted-ripping-26f8@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

