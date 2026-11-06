Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991937;
	b=Ab+sHLGCODZuTMYROjTjUE464TVmO7tPf1AGlN9wTkqjpgYRCpkq3LsLHo1fSzTmintX
	 52ekj98rhcN7SWL+RuvABaCUGHFGlRHuZzMc8vd7z41k+tL93HIRYdIZuiQjDqWwBAlGF
	 93g7shq84ccMrV9/MNHYuOuvIyBeswJ0eVjSyyjkZ2Gl1O8FDypHV3NEfronHPr5AVe3T
	 qAFTqAFT8Lp2F/P/XASQH7Xq/jocaFFV9KmIkrU2a9vBx78ctR3DxNHS4C52j5jQozuWo
	 JfnWazY+6H0uP15VWu7Iex7n6ckHleQ/0wo+mcRhpQobR/OdpHnYNzTQlNKScUf/ltQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991937;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7osPQkuzp1BaetUyc8Ccppi80Dq54/ktTU/n1+Ddcpo=;
	b=TOIFMa89vN/ufUKTYrNOgTVc/VZFJeg5j2E0Ab60fnSU4yLvRXMjdSppVGJGegMGvNXh
	 6SDrQRfKWOEkXskb88q+MRM84w/gAu0HhLNI3amDd9jHp1bpYtWnyoX70eI/vpRwiIdjg
	 CPk/p8Y2zItPk+LOPiLNCKvS0S937w9uVkDaryPMubQ/zoceRlYM05hHcvMPzdDLwp6I4
	 2u89HEpHGH9A3VVIxGYNUas6KO0ewavOZJn+0qLeAJ+8fOqUEux5k25siRKK3R4Cb6Dz8
	 nma5C+o+UBrVgwPCg0xclO/seXSN4bH4iY4lRZn4f2BWM7YiU1KTkChsxLA32Q+vzMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiadGvaf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF454606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 19:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eiadGvaf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D936F1F0089F;
	Fri,  6 Nov 2026 19:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793991936;
	bh=7osPQkuzp1BaetUyc8Ccppi80Dq54/ktTU/n1+Ddcpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eiadGvafBb0RRwV16mUqQ8GdDG7hGUGx9/tAR6ZYCETF6h0qq1KW3T6+rLJj86D66
	 XgoR5wzTvUGT2FE4mV0yuQiZyfu5KekicnC5uvzc4/PcFhB8QbwtlQ7Z4m9J8JKvwU
	 q5HZXh09TGiJLF7mb23rIQVk1ZCeyn16fsxvm+yWj0j0uCyasoB4jVZNe/kmneic+4
	 UvHOTyD3tYoTtkOF5jHElfuzOoLPuOLtXKCuIb9eOoDisKnBfcDV6Ivd0a7x5vRqWU
	 jswV76GrBw4SbYYYyJ7Vr0EcC0YVupyDfCWXvuEL8HLfA/pBq36eQ5l1TOLDhtaQjl
	 23/nE1t40NIhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gael Blivet <gael.blivet@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: look up stream size by exact xattr name
Date: Fri,  6 Nov 2026 14:05:34 -0500
Message-ID: <20261106190519.1120084-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110445-either-jimmy-6232@gregkh>
References: <2026110445-either-jimmy-6232@gregkh>
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
[ sashal: adapted to xattr helper signatures using non-const mnt_idmap pointers and an extra NULL argument in the replaced ksmbd_vfs_casexattr_len() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 13 ++-----------
 fs/smb/server/vfs.c     |  4 ++--
 fs/smb/server/vfs.h     |  2 ++
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 2041811fedce9..f3b39f57ac64c 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5247,17 +5247,8 @@ static int get_file_stream_info(struct ksmbd_work *work,
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
index 3d1cfcfdfb627..54bd3e7012d7b 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -939,8 +939,8 @@ ssize_t ksmbd_vfs_listxattr(struct dentry *dentry, char **list)
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

