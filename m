Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987934;
	b=F5wIf4TeRqy+ivUtzfaLdZswURoyqeCHIBmGvMYbAPzwTbGDi4W8F1cMgnwlTCiQI4nr
	 WBwRWUIX9M2MfsuQVfi/LO0EIoFEisbIug20wTv+wP08Nja9oU+J1A/n3SMsBYcDOINqa
	 fRadNjyzLQ9KEZxtm4FtErv6C+31vLo6iIbcRJA2pjjsOYzoJIp5msd+kQ7EtzBxlaeRf
	 yd4Bf6l15KOQp5hsCD4S8OMeTN92P90K7Xrbr3PGgFJncS6CMR2xVVto5jdoNk0OvklK7
	 x1YmhfDhQ4BGnBa3r4oUIvtejRw1gPmddSCmYA1sLnEJzGWoUWPH3JfJnSku4sZgywA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987934;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aitHP8o6bbKI4rA3xgyStjglLQTh52Mr5AOfh+EMPh4=;
	b=yYSv046rLx2q6XHYy5zLCqOwL+0dJ8Wk06JX7NVVRQMZlXa57Hdaq5tGsemBuw50PT5S
	 SkwRbnIQUds9kb5K5cjnkaGCyJojIZuHr400keh5Mp6kdQ4rEGvnKRlZu1wguKrBeaQAQ
	 vpXXYs3i7/uIwO3VVyqBCpWTp7j4xrIt0jCuRrkEE6Nj1RQ5BggG1sRGl6Gy4bOjh/RBj
	 pGOhAh2tM8s+yCCRqwhvGof/9kPAghr+y8M1dit2W5TvXI07Lktnt9lM8r79RmNZvnUzj
	 4p1rDS20YhuC7dsRJz0I8eYeF/9jb+9iPqlsCe868iHMf8sa3XNvuVKfxBDozG06fvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0LN5gVW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C2606A33E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M0LN5gVW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E664E1F0089F;
	Fri,  6 Nov 2026 17:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793987933;
	bh=aitHP8o6bbKI4rA3xgyStjglLQTh52Mr5AOfh+EMPh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M0LN5gVWG1t1e1PDcbCgF8g4EV/4RQLb0R8RVV8QVzqVtvpgo3VkYq6RxlcN3TjDg
	 DbAtLTW+X9Bwnq2PfQvQWkKHmRdTTCH54BcYGzbqLBmGOTFb2oq4AY7evlVR1GBx0q
	 +THV2kOlpWnu9SsfA5OY4qPkEFL28kTGC9Y98jTAvNcI1F+g+7KHFlfUgmEgzCjfCi
	 ctJJr5+e0b/uWeAFuM9ttyd0RC6blZNQhuVSlZ7Sk+/YPZRx/zJURAGigx559WOaiP
	 V3DRUHETSylzro5qmfB5W6jWhAuAIMm9slIEvVn3ywBLmjMfCl3dCvBtOqzXx6LDiK
	 zo+6DG5dyP/ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gael Blivet <gael.blivet@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: look up stream size by exact xattr name
Date: Fri,  6 Nov 2026 12:58:51 -0500
Message-ID: <20261106175840.528183-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110444-overfull-uniformed-0087@gregkh>
References: <2026110444-overfull-uniformed-0087@gregkh>
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

From: Gael Blivet <gael.blivet@gmail.com>

[ Upstream commit 10ea20d6584ecdaf2f7505855412a856a88d8934 ]

get_file_stream_info() walks the xattr list from a single
ksmbd_vfs_listxattr() and sizes each stream it finds with
ksmbd_vfs_casexattr_len(), which matches with strncasecmp(). Linux
xattr names are case-sensitive, so two streams differing only in case
report each other's size.

The loop already holds the exact name, so query it directly with
ksmbd_vfs_xattr_len(), which is what casexattr_len() calls once its
search succeeds. Make it non-static and declare it in vfs.h, and drop
the comment above it, which describes a different bug and no longer
matches the code.

This also drops a full listing per stream: casexattr_len() runs its own
listxattr on every call, so enumerating a file with N xattrs cost N
listings instead of one.

Fixes: 689f1eb3719d ("ksmbd: report actual xattr value length in stream enumeration")
Signed-off-by: Gael Blivet <gael.blivet@gmail.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: adapted ksmbd_vfs_xattr_len() to accept a non-const struct mnt_idmap pointer ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 13 ++-----------
 fs/smb/server/vfs.c     |  4 ++--
 fs/smb/server/vfs.h     |  2 ++
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 4e0f43051d9e0..1ed32310c73a5 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5275,17 +5275,8 @@ static int get_file_stream_info(struct ksmbd_work *work,
 		streamlen *= 2;
 		kfree(stream_buf);
 		file_info->StreamNameLength = cpu_to_le32(streamlen);
-		/*
-		 * stream_name_len is the byte length of the xattr's *name*,
-		 * not its value -- same class of bug ksmbd_stream_eof()
-		 * (smb2pdu.c) already fixes for EndOfFile/AllocationSize on
-		 * a stream handle; this enumeration path needs the same
-		 * real xattr value length, not the name length reused as a
-		 * size.
-		 */
-		slen = ksmbd_vfs_casexattr_len(file_mnt_idmap(fp->filp),
-						path->dentry, stream_name,
-						strlen(stream_name) + 1, NULL);
+		slen = ksmbd_vfs_xattr_len(file_mnt_idmap(fp->filp),
+					   path->dentry, stream_name);
 		ssize = slen < 0 ? 0 : (loff_t)slen;
 		file_info->StreamSize = cpu_to_le64(ssize);
 		file_info->StreamAllocationSize = cpu_to_le64(ssize);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index dafb92aa39a6c..9aee0214e8fdc 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -943,8 +943,8 @@ ssize_t ksmbd_vfs_listxattr(struct dentry *dentry, char **list)
 	return size;
 }
 
-static ssize_t ksmbd_vfs_xattr_len(struct mnt_idmap *idmap,
-				   struct dentry *dentry, char *xattr_name)
+ssize_t ksmbd_vfs_xattr_len(struct mnt_idmap *idmap,
+			    struct dentry *dentry, char *xattr_name)
 {
 	return vfs_getxattr(idmap, dentry, xattr_name, NULL, 0);
 }
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 397dd2dd09886..1ca170dfb349d 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -106,6 +106,8 @@ ssize_t ksmbd_vfs_getxattr(struct mnt_idmap *idmap,
 			   struct dentry *dentry,
 			   char *xattr_name,
 			   char **xattr_buf);
+ssize_t ksmbd_vfs_xattr_len(struct mnt_idmap *idmap,
+			    struct dentry *dentry, char *xattr_name);
 ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
 				int attr_name_len, char *actual_name);
-- 
2.53.0

