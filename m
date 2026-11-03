Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745563;
	b=5lJNR/Y4ykbYJlM+AlECmw0OE9wGyyUj5ek9x0/cxf0mXeea8nGQP6obmXTV/0CeXJtT
	 izVGtTXsjvtZO4Pbr/M+n2V5PQta0WnNiJfSLzxnrCHaCC8QXHkdIaJyn9Q6sC324krVd
	 6ztd0s44S3ckguVyAXx9OgjNPz5duAfQOHkvqUAucFZ0gE8MxYtTFMYT/7RaUpDMP5Lyp
	 AXBYsBKkTdgiuE5G/qRNqVbog8J/Eq8m03oAo/LHVODJYKS+rYiOGKyFcYX7ULtL3suJ0
	 YbvoC8NYjdlGNi6yQu2BCYbOJfRNFJygp5V83N8sjNSFOtz39Zwit6CQDxHflNZE9uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745563;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T0IXntGlP4rh4mxeqxOpajTaD2ouLRY80PreFj1JMKU=;
	b=ZtEAo8Qn7e9I/Y2n9EHYjGMUanZvn8a0Xc2R48HqvPwbUrfys0RPmzgKV26OlBWS/KZL
	 4QLPPwdSg1/81kQTjuI4MeQgQ8egwvqWzt8fMzNta8puU8oyUZAOMbLdP4bwkHz88p5N1
	 HxTOlu3Q6l48gunjuj+x230xww/Z37KKtWtA8byBhzz96NjORJT66QoFiTRiRMlYLLLZw
	 5QzHvu4pnCsLqBMcMcj4G3tzJgAMgVO/mL74XrURuK9OSsIgEZefTgQ1fttSkDHQnLJKU
	 NcvjW/ksPByuHYrYtbgv9kyDh+M8XL7lvJtjUsFEx1xoj58mIKUlLGxYXfl4JwCHR6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpm+6jHA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81816606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bpm+6jHA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915611F000C1;
	Tue,  3 Nov 2026 22:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745563;
	bh=T0IXntGlP4rh4mxeqxOpajTaD2ouLRY80PreFj1JMKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bpm+6jHAZ9KPBNaX7mdHQ5qMXOubd5HRS3aNZMXHVTBnGeBtnYzeNMUn4MTahI7cu
	 GLbPCFD7h3vxi4PAonsivTQoKGgydBdTUD5d+7H+suURtGLauIS0JXoQgNx5+BN4UW
	 dCCOu2iXB/yh98iSwLgyUDfPXtZFXheXRKjb9v3Zer6fiiU+ybCopAmFXwoo9dRvSo
	 NtQa/EyiJFvjJLNhWHloa5aRI1IMtShsjD6ngIUT60NOzcHyHyuGUioW1IrZkDqTjz
	 ZDSz2DyWIbIP5g7bKpXeCirmQf2BSeLdaQ36mRMJjOnhGM+OlB1Ur9GFsgEbegly9e
	 qENGv+YSg8WHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: use the existing xattr name for a named stream
Date: Tue,  3 Nov 2026 17:39:21 -0500
Message-ID: <20261103223844.1549269-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110300-flinch-tremor-2d5c@gregkh>
References: <2026110300-flinch-tremor-2d5c@gregkh>
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
[ sashal: adapted the ksmbd_vfs_casexattr_len() caller update to get_file_stream_info() instead of ksmbd_stream_eof() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 8 ++++----
 fs/smb/server/vfs.c     | 7 ++++++-
 fs/smb/server/vfs.h     | 2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index aaccef2e3f3bb..a4a04321fddc7 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2441,7 +2441,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 						     path->dentry,
 						     attr_name,
 						     XATTR_USER_PREFIX_LEN +
-						     eabuf->EaNameLength);
+						     eabuf->EaNameLength, NULL);
 
 			/* delete the EA only when it exits */
 			if (rc > 0) {
@@ -2513,11 +2513,11 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
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
@@ -5215,7 +5215,7 @@ static int get_file_stream_info(struct ksmbd_work *work,
 		 */
 		slen = ksmbd_vfs_casexattr_len(file_mnt_idmap(fp->filp),
 						path->dentry, stream_name,
-						strlen(stream_name) + 1);
+						strlen(stream_name) + 1, NULL);
 		ssize = slen < 0 ? 0 : (loff_t)slen;
 		file_info->StreamSize = cpu_to_le64(ssize);
 		file_info->StreamAllocationSize = cpu_to_le64(ssize);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index aed2d2dd9b25a..ec0a48b3f0850 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1806,7 +1806,7 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 
 ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
-				int attr_name_len)
+				int attr_name_len, char *actual_name)
 {
 	char *name, *xattr_list = NULL;
 	ssize_t value_len = -ENOENT, xattr_list_len;
@@ -1824,8 +1824,13 @@ ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
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
index 06903024a2d88..d0e05eca8616e 100644
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

