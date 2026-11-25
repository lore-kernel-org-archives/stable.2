Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634516;
	b=sAV4Juw78Giq7QMX4n0wJNyK/vdrNIxiypQ3ACROXYLb/Trio8B4r5wXVpR70eki5kUH
	 PJTGisCE9xjVoR2w5xw62GhTVqkbmLmGOu5/2AkrEvt9L36pYE2eOO0Hn9/0ghqa7W/Uo
	 k0ZZpd6/79xYzvd0YvtabRXMLrISN+i+E5pSpeOMHQbv9dWqxB1lohc2g34Vl9B1g9R/I
	 ITFdZgZUDUVPNFp3vZayz6QBwFpxN6WxbHXAaEqaOvmwXuGSo0DKZEG0YU0HYhu1fGw1C
	 8vcyk5Vqhx+mPvPx6Yot6C7CZGSio4zZfgqr/gT6bkNpycTwHK3Oz7b+/7Exqqdqz9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634516;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2uDwQIer1N/KvqzoVWPQmhubuH/lhNBvRfjkFHtSrws=;
	b=SOCucdKoGE6aWY8i5hOUscxXeJdv21hAIqF9+nHgnncnnr7go1IH7MbwXDo5HFQERMBv
	 3xsERqxRU+bvviEomIYpEavrVqyOAUnrClFBLlYoXbR6AmpuGvO1+8S2Y3Ly0Is/eXkUy
	 pWQQPPhhvZBOV4WDd5X1viSdRPGfIbz6g5lhBt2WHEa5D1wHa+bNBSfqqKZ6XwPHe0bvx
	 Ca3W9frJdfX9KjoJMTay6hJNzCWEA/Mt7KBuddePTZHjHOu8IoFduwFRymcjNa6rbMwhE
	 AzIwJyqUDdmY4J3Iy39XFT+DW357mbtqhTNl/gyhDtETtptvMlmnh+g0ZuTfKA2wtKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meaewS8k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5819606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meaewS8k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8F81F000E0;
	Wed, 25 Nov 2026 19:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795634515;
	bh=2uDwQIer1N/KvqzoVWPQmhubuH/lhNBvRfjkFHtSrws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=meaewS8kWSwV+YjprGRNq7u4hQFqa/N9mSR2C6q57AcX8cH7qJXZuDR+i3gU+y6Zx
	 g90scB7BPmHUkFGSaR77yPttoPkz9hhzof5rJrZKYxUMKzXnmH57JMsOtIAEXdxW6A
	 BvJV7KB5TNiD2n2q/LqDYZRJmMQasBfoF7TkFiLSwXKPRTUsRAQCwx6naKDTAgxpfM
	 tx7wgxt2qEq2rcBFM5/f3ik8+9nFRffF2dq/NA3TNvLE4zL3m1+lDpA+WliQR5TZPp
	 XlTls83QMeRwxsCzyyktJGdedWKzRl76Nzp3abE1ONdB6c0G0jWxVzj7C4N2IQbAVX
	 Yl4c29s8uBdaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiwoo Kim <arpe1618@gmail.com>,
	stable@kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: pin parent dentries in SMB2 CREATE ACL path
Date: Wed, 25 Nov 2026 14:21:53 -0500
Message-ID: <20261125192109.1231499-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112518-cranberry-chaperone-0cf3@gregkh>
References: <2026112518-cranberry-chaperone-0cf3@gregkh>
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
[ sashal: Dropped the kunit/visibility.h include context and adapted const struct mnt_idmap *idmap to non-const struct mnt_idmap *idmap for the older tree's smbacl.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 39 +++++++++++++++++++++++++++++++--------
 fs/smb/server/smbacl.c  |  9 ++++++++-
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 115960cc93994..82d1225dd7e8f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3442,16 +3442,32 @@ int smb2_open(struct ksmbd_work *work)
 
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
@@ -3505,10 +3521,17 @@ int smb2_open(struct ksmbd_work *work)
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
index 42a638d1d2b97..1bd816153e542 100644
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

