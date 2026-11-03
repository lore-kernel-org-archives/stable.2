Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735328;
	b=OHtTdcfk574lP6CRgoEI8IWKEL4KZxN2ifUclihSTzU39VtDRegzO7tUFn3HPhvyUZr1
	 L5nZgH6Nc1iDghccIcj7kZKrv+J0X0JhlHa+ebykU/8Pbtl48nxCau3RRkwhrx/vFcGxG
	 Gw3Va8ncPqexUAzyF9dURtB6OA8Z9i8JC43aqkl2iuFnkcwglXYPI0tjcxGhiNZ3/JyEY
	 YRPXpg8Lkm/bT4OI6W12ettkhkm9Me3QqtzuSmHv1DLGNpHjfroc8AxUMETIxna1pV9Mq
	 H+6urys1Rf6AQY/NjzO2EwzKWbPSF0GOa3LYSceGJ0JkPNSmgsZRGvOURSOMcxa79zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735328;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Tanm8huoLVBnPKJ5qp+Yu3eTl9Ar/d+jV6fB0qmWj/Y=;
	b=vchU+a8m3Sk8RmX35FO74rl7MSlQrzBoiWCsw1rjc6U16yDymuxqk9/n6ObJH/i3tRyB
	 yDb916PQl8kkAmlgsxMS7YHFmoL38VxXheLm75nT0eBJsF3dh+umWGx9BbTGMY4yKF8B8
	 VGrV0Mug0jmxCAzYtrjV3CtTIq6AAhSMzR+DzouS3NE93rLWqcfH+k/Vvh+W7hNullP2X
	 aYW5/6bEuLFJVHs8UGVVMeqVhR5AP5FATin0yYbwcuYI4lI5W3g0xuzZv6+5v4k15ax64
	 PG7ELR6TMQpXFsJuTokphOye90AxBFC0oZ562xOLTSToBxpKcB+ePg46zgN7bmRgu7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bvzHH8UO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896AF606A33B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bvzHH8UO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA4B1F000C1;
	Tue,  3 Nov 2026 19:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793735328;
	bh=Tanm8huoLVBnPKJ5qp+Yu3eTl9Ar/d+jV6fB0qmWj/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bvzHH8UOdZI6gX6iP53aOiiGIXO3O1MhV4lhO6aNgCpVZteWyJtsQ6ANGyolB5HCr
	 PbHL8Ae+ykWVES5yqpUbZanHg78BrnfBL9DyRqgaY5d4N/G1i+XXVv8yVj/jVMwFgY
	 19vlNYSWA54lW5lcF2Ob21BCCu4vb1orWF2pqL4RBAL7Zz5CIRQdHmmzTQ73/uCJdm
	 lF0JkAAnKCbwFPG4QBQ+RC7fknY6HrOiMgzRAQn8s6M1Zzp09cCRqfwOzxk3jH3MYM
	 ygGlu/BKqZU7fJbNtPkwQTwHr/uunofIZV93dvvDeRMhNee/BL1KrEV6zfzaf8VzGl
	 pPQ/F8J6JPvRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: use the existing xattr name for a named stream
Date: Tue,  3 Nov 2026 14:48:46 -0500
Message-ID: <20261103194749.1035677-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110358-jaywalker-relapse-2135@gregkh>
References: <2026110358-jaywalker-relapse-2135@gregkh>
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

From: DaeMyung Kang <charsyam@gmail.com>

[ Upstream commit a7d1d52748e0fe4d06fdb871fc9899904fbba93f ]

SMB stream names are case-insensitive, but ksmbd stores each named
stream in an xattr whose name is case-sensitive. Opening an existing
stream finds its xattr with a case-insensitive match, yet the handle
keeps the name as the client spelled it, and every later operation that
needs an exact name uses that spelling:

 - a WRITE or an end-of-file change creates a second xattr, so a stream
   created as "Foo" and written through "foo" ends up stored twice, and
   which value a later lookup returns depends on xattr list order;
 - delete-on-close and delete-pending removal can fail with -ENODATA,
   or remove only a case-variant copy and leave the original;
 - the share mode check compares stream names with strcmp(), so two
   opens of the same stream that differ only in case do not conflict.

Have ksmbd_vfs_casexattr_len() copy the matching xattr's name into the
handle when the stream is opened, so later operations use the name
already on disk. The match must have the same length as the name it
replaces; the stream lookup passes a length that includes the
terminating NUL, which already guarantees that, and the check makes the
copy safe for any caller. A stream that does not exist yet keeps the
client's spelling, as before.

smb2_rename() compares and looks up fp->stream.name case-insensitively,
so it behaves the same with either spelling.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: adapted stream lookup signature changes to the existing callers and non-const mnt_idmap interface ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 8 ++++----
 fs/smb/server/vfs.c     | 7 ++++++-
 fs/smb/server/vfs.h     | 2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 793c219b9a610..9af1ef5a13d6a 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2464,7 +2464,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 						     path->dentry,
 						     attr_name,
 						     XATTR_USER_PREFIX_LEN +
-						     eabuf->EaNameLength);
+						     eabuf->EaNameLength, NULL);
 
 			/* delete the EA only when it exits */
 			if (rc > 0) {
@@ -2536,11 +2536,11 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 	fp->stream.name = xattr_stream_name;
 	fp->stream.size = xattr_stream_size;
 
-	/* Check if there is stream prefix in xattr space */
+	/* Keep the existing xattr's case for subsequent writes and removal. */
 	rc = ksmbd_vfs_casexattr_len(idmap,
 				     path->dentry,
 				     xattr_stream_name,
-				     xattr_stream_size);
+				     xattr_stream_size, xattr_stream_name);
 	if (rc >= 0)
 		return 0;
 	if (rc != -ENOENT && rc != -ENODATA)
@@ -5243,7 +5243,7 @@ static int get_file_stream_info(struct ksmbd_work *work,
 		 */
 		slen = ksmbd_vfs_casexattr_len(file_mnt_idmap(fp->filp),
 						path->dentry, stream_name,
-						strlen(stream_name) + 1);
+						strlen(stream_name) + 1, NULL);
 		ssize = slen < 0 ? 0 : (loff_t)slen;
 		file_info->StreamSize = cpu_to_le64(ssize);
 		file_info->StreamAllocationSize = cpu_to_le64(ssize);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index c18ab8431e0d2..b23179a7b780c 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1812,7 +1812,7 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 
 ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
-				int attr_name_len)
+				int attr_name_len, char *actual_name)
 {
 	char *name, *xattr_list = NULL;
 	ssize_t value_len = -ENOENT, xattr_list_len;
@@ -1830,8 +1830,13 @@ ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 		ksmbd_debug(VFS, "%s, len %zd\n", name, strlen(name));
 		if (strncasecmp(attr_name, name, attr_name_len))
 			continue;
+		if (actual_name && strlen(name) + 1 != attr_name_len)
+			continue;
 
 		value_len = ksmbd_vfs_xattr_len(idmap, dentry, name);
+		/* The caller provides attr_name_len bytes for the actual name. */
+		if (value_len >= 0 && actual_name)
+			memcpy(actual_name, name, attr_name_len);
 		break;
 	}
 
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index df6421b4590ba..ccf289592718c 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -107,7 +107,7 @@ ssize_t ksmbd_vfs_getxattr(struct mnt_idmap *idmap,
 			   char **xattr_buf);
 ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
-				int attr_name_len);
+				int attr_name_len, char *actual_name);
 int ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
 		       const struct path *path, const char *attr_name,
 		       void *attr_value, size_t attr_size, int flags,
-- 
2.53.0

