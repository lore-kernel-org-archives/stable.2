Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725435;
	b=ZJIP9h+9p2Sb3CYtRYepuPltZnWVHM+U6FKsJGbvPWVzStzbTBe4I6XF8k9s7fSv3hb1
	 I/mMMcnRgN6SZxbJYjl8s+gYCpKUtHH4zh6+fDNg7QjcUoqKiE/44fQFwkyEO+qEsDzux
	 dC9FqUuMLKLF2t9f+cseg5YfWj7lKa6YfMimg99GZVEevgexMvBfpo3YNNeOPY3QYTym9
	 w5ZWjP2S0rwKUBUq+L2RUvhCOPWdy0msL3To4tCFCIZOyo+l+m4OaQNTillgNWdbPeO93
	 sXrQmpvj44GffStufENGiZs9dWv7ln0hKskqWp1wNoHi62eqVi/TyEG6zDLPCNffHmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725435;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BdbbnnyD484214eiEqye1iTG1mbvSaa9RaKnJdRmIAU=;
	b=K1H/5HJS90fZ4OhYTFNNG+LZKt40e5PfBcvVc9zu1cno6vaZZ0EmsG4AwSN2kGGyDbaj
	 QARoKoduR3cmOkZ0gyj2D2Qj+0r2Qf+4HqLX879GwKUrkU8+DVvdzA5VhLwp1+Di1Klz8
	 +R5QfrF/UL/syAAQuSlgAUcGm/kT7kQ+h7YXolsW0Calt85jT1gCt+CFS8w99VZXd7TZT
	 u5T5qq3Vu3+2HbuwDq68f9Bl4Av6KrISGuxGkYZ5ygDCQRqVbu51VeNafseDFJ231r8Uy
	 2pIh1kqzZQtmQhL1vzRYOT7fPcwTy9uSO8ovUZIYJkNy8zcIo5WTBV9PQR2L0xkXljw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N874Q0bS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B02606A327
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N874Q0bS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B681F00A18;
	Tue,  3 Nov 2026 17:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725434;
	bh=BdbbnnyD484214eiEqye1iTG1mbvSaa9RaKnJdRmIAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N874Q0bSG5JQ0N/2U/zqRWR8w3HI2wnn96Vq7N9Nx3hJEfM5ByiuJt4KfL33DVR+M
	 LobzG5rdrITsbMINGwuZepKudCmv4bz1/t9HpvBnK37GuaXEfQ+fPOoZZSy+OvHuU2
	 xy+F2phy0AS/GNlX8F1IknHRu+JDCZClxDv1Oq3ClKPlTkZL34UJGvzskiBXBp+F+J
	 boKc2A0srzgqKcN6mjFkojY1fhvCfw8QT2erSeWibEWkzH2n1iAI9CjLMMKM8qmm+e
	 TrUWcMVrt6jzj4Oh6YrkdJKgde8M8EytpJ2jyN/ICIOe4cJO3HXSR0WOul2+e+p4Kp
	 ZtAQOoATAw4+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] ksmbd: use the existing xattr name for a named stream
Date: Tue,  3 Nov 2026 12:03:53 -0500
Message-ID: <20261103170317.644742-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110357-jaywalker-wobbling-bdf7@gregkh>
References: <2026110357-jaywalker-wobbling-bdf7@gregkh>
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
[ sashal: retained non-const mnt_idmap pointers and passed NULL for the new argument in the additional get_file_stream_info() caller ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 10 +++++-----
 fs/smb/server/vfs.c     |  9 +++++++--
 fs/smb/server/vfs.h     |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index b3743e17aa3c1..e81a16e4d82cb 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3356,7 +3356,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 						     path->dentry,
 						     attr_name,
 						     XATTR_USER_PREFIX_LEN +
-						     eabuf->EaNameLength);
+						     eabuf->EaNameLength, NULL);
 
 			/* delete the EA only when it exits */
 			if (rc > 0) {
@@ -3428,11 +3428,11 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
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
@@ -3485,7 +3485,7 @@ static loff_t ksmbd_stream_eof(struct ksmbd_file *fp)
 	ssize_t slen = ksmbd_vfs_casexattr_len(file_mnt_idmap(fp->filp),
 					       fp->filp->f_path.dentry,
 					       fp->stream.name,
-					       fp->stream.size);
+					       fp->stream.size, NULL);
 	return slen < 0 ? 0 : (loff_t)slen;
 }
 
@@ -7052,7 +7052,7 @@ static int get_file_stream_info(struct ksmbd_work *work,
 		 */
 		slen = ksmbd_vfs_casexattr_len(file_mnt_idmap(fp->filp),
 						path->dentry, stream_name,
-						strlen(stream_name) + 1);
+						strlen(stream_name) + 1, NULL);
 		ssize = slen < 0 ? 0 : (loff_t)slen;
 		file_info->StreamSize = cpu_to_le64(ssize);
 		file_info->StreamAllocationSize = cpu_to_le64(ssize);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index d61a5e55cde6e..4def2fb3351ca 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1911,7 +1911,7 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 
 ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
-				int attr_name_len)
+				int attr_name_len, char *actual_name)
 {
 	char *name, *xattr_list = NULL;
 	ssize_t value_len = -ENOENT, xattr_list_len;
@@ -1929,8 +1929,13 @@ ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
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
 
@@ -2085,7 +2090,7 @@ int ksmbd_vfs_copy_file_ranges(struct ksmbd_work *work,
 		src_file_size = ksmbd_vfs_casexattr_len(
 				file_mnt_idmap(src_fp->filp),
 				src_fp->filp->f_path.dentry,
-				src_fp->stream.name, src_fp->stream.size);
+				src_fp->stream.name, src_fp->stream.size, NULL);
 		revert_creds(saved_cred);
 		if (src_file_size < 0)
 			return src_file_size;
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 55d099de71f52..4bb15d99cfd92 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -110,7 +110,7 @@ ssize_t ksmbd_vfs_getxattr(struct mnt_idmap *idmap,
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

