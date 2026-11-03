Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750329;
	b=XRPO6Shcr1qsaCVIyRAvgevOp9tTcRVnt1OG9ibYSEfh1oI1foQl76xNqTwei3R893Ld
	 q4pvZy4y69oH2JaZA+vcY26VIEqu3oR7y1OW5t9yWwzi6Ti4a6n/uF/HDisGOsoecfToA
	 dlXbGzG4d4NdrSy4op54dLSRWTJmcT61IlnTE9ck0kOdG6AYp9lz+nGOyZezEM4gKiety
	 dE+ZuCToHbfvK39pmhmGcnQE7ZKzQVh16VcgIARJp7FjXiIYPiUALZTE2Xx3DcWWqa1nJ
	 fgfpQR51IwLgdkc6n9N0wqvi2OINpHPPRLZCCkJt/bonn1LqwrjE6yqC+M81+/+DgCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750329;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yGsxje97kIZMgsI4h9rmNg9isZrGOr7jXRHYGrVKMSA=;
	b=xFAX4oTiyRxJuIOPhqQPqG+eogHQFdvTB2cKorDjT8jzviEm4O6IBTfgeoT2TnRyFOkW
	 UhpNDhw8RSq7unB5A9wxiuzgiCYb2lCF72kOjvDur0GQAqcPU/a+F1iWqcgxwzfdNVnzq
	 EjKcV8f9g45iLXBapCXCl5EMsUn1E5br6DIRytPitt3sMpKkpobu4Ev9a4sryT/PeKUkp
	 2vutIuwRPqReOF1yGy4C9mvuKPbK+8MwIcljmslHjSutt6F7/vMubpQ3m4MkejCf4KPlX
	 rhUAan7nKEC4BEuR7Y1+1nWcPOPmBnfL6RTqgXruF4y/Yai9FyquMXJghUcu5on2EvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+cKs4Lo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC3D606A31B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+cKs4Lo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5781F0093A;
	Tue,  3 Nov 2026 23:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750328;
	bh=yGsxje97kIZMgsI4h9rmNg9isZrGOr7jXRHYGrVKMSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M+cKs4LowsHu/HDaaTF5PPVyKX2c+GrvDXaqM7OTTfMyYXIxvi9W8u/PgseioLd6B
	 z89AiFYtUa9vkL3PsrqVYnFKstSZ2w5NK5Yu9sBXXQi1Jw2Xsp8hCh5BVCLLTluYd2
	 CA2H9NSbH9/eI+14SZbmMBob+Nl+WeZzAtyN2Zc7IfNZt1EkNyWyb6KOYwi0Tp0Woi
	 duYsFQEMRgCC9ZWMdOFymUiJyakhU/Xm7k3sq7MS1f6616CqniHkxB2PcjvXhsSb2j
	 kuQVEoL0BaL6lehHFFq+k9fYguQfxYX6/sURT3hrGxwp6S3niLKV8QzG0EMYjbcMXY
	 dlxrcgXz2sMTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: use the existing xattr name for a named stream
Date: Tue,  3 Nov 2026 18:58:46 -0500
Message-ID: <20261103235759.1652856-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110301-overboard-fifth-de8f@gregkh>
References: <2026110301-overboard-fifth-de8f@gregkh>
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
[ sashal: Retained the user_namespace API instead of mnt_idmap. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 6 +++---
 fs/smb/server/vfs.c     | 7 ++++++-
 fs/smb/server/vfs.h     | 2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8d2f5e4e9ae3b..ffe74d0b068a1 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2455,7 +2455,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 						     path->dentry,
 						     attr_name,
 						     XATTR_USER_PREFIX_LEN +
-						     eabuf->EaNameLength);
+						     eabuf->EaNameLength, NULL);
 
 			/* delete the EA only when it exits */
 			if (rc > 0) {
@@ -2526,11 +2526,11 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 	fp->stream.name = xattr_stream_name;
 	fp->stream.size = xattr_stream_size;
 
-	/* Check if there is stream prefix in xattr space */
+	/* Keep the existing xattr's case for subsequent writes and removal. */
 	rc = ksmbd_vfs_casexattr_len(user_ns,
 				     path->dentry,
 				     xattr_stream_name,
-				     xattr_stream_size);
+				     xattr_stream_size, xattr_stream_name);
 	if (rc >= 0)
 		return 0;
 	if (rc != -ENOENT && rc != -ENODATA)
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index cc8cadcbc2036..6dccf1f1fe4d8 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1798,7 +1798,7 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 
 ssize_t ksmbd_vfs_casexattr_len(struct user_namespace *user_ns,
 				struct dentry *dentry, char *attr_name,
-				int attr_name_len)
+				int attr_name_len, char *actual_name)
 {
 	char *name, *xattr_list = NULL;
 	ssize_t value_len = -ENOENT, xattr_list_len;
@@ -1816,8 +1816,13 @@ ssize_t ksmbd_vfs_casexattr_len(struct user_namespace *user_ns,
 		ksmbd_debug(VFS, "%s, len %zd\n", name, strlen(name));
 		if (strncasecmp(attr_name, name, attr_name_len))
 			continue;
+		if (actual_name && strlen(name) + 1 != attr_name_len)
+			continue;
 
 		value_len = ksmbd_vfs_xattr_len(user_ns, dentry, name);
+		/* The caller provides attr_name_len bytes for the actual name. */
+		if (value_len >= 0 && actual_name)
+			memcpy(actual_name, name, attr_name_len);
 		break;
 	}
 
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index cc47e71c4de13..67f79a85370c2 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -107,7 +107,7 @@ ssize_t ksmbd_vfs_getxattr(struct user_namespace *user_ns,
 			   char **xattr_buf);
 ssize_t ksmbd_vfs_casexattr_len(struct user_namespace *user_ns,
 				struct dentry *dentry, char *attr_name,
-				int attr_name_len);
+				int attr_name_len, char *actual_name);
 int ksmbd_vfs_setxattr(struct user_namespace *user_ns,
 		       const struct path *path, const char *attr_name,
 		       void *attr_value, size_t attr_size, int flags,
-- 
2.53.0

