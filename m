Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750339;
	b=TnhLbJGyOEVaH13m8IWSyigVJ+CWj8kRJq06m332Q1frFVWHNBJma5b9XJy1Y4vKJaIv
	 RF3dQNbOhhe5LkH4Yle9QOqnW9bkV3bROlA1W8ADHfOXWfG342W5jhkkpPZs8HPNLnN5N
	 Gog7Le4JX+z5k3LGxOXnIgW9xzCU0f/UCKtU6DtbaAbQPGpOaGc6Q0yViWKciY+B/L81S
	 B4NNP6H7MAU9TVbq1aQkt8HBxHe1k7lvqCUZXmDPADBEYMW/HPu7CXK1hV8FUwKOaj1ak
	 YpKSF/xF7r3mZPwJz9zlxtgtHi/qP3ItVLmomoGcAB03caClitWpSKwLO2vaEXg/HvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750339;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vMpqvtQNovUuAIqmhTHcL6s31FG+bQ7NcYA2144BjfE=;
	b=Cd3MEQJcSZ+sn1OnuD6blrsAjVwJD2NPy49JDognRdIM6+6uuf6R7jSUA1NCzMqQuvsS
	 K/fqmedCX29XtuTMfgvYxTzzfJnPn8hYens8AnOxiaiYjO3olRlKBbtPda9JwRGgIeFJJ
	 XT1pd7Iw+1TdtT1B4/FF+r8Uh2ExLMzdACQTRJJAFHvg3AGeS9pVxxGy1PCe5+5bB7hqS
	 B96Tx2tz9/EQ/1b0z4HarqIN7YmcHpAR+T3Tx8YRadfVygYsgQEhZ5coR5XNQWWh7YW3K
	 vcdJYJ52runfWZeB2fT6PRMYcBHsUcj76aB2az++VojzVlRPFbS2LTs1C2F+mpKUR3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XHt5pX5P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC9E606A329
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XHt5pX5P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D4E1F0093A;
	Tue,  3 Nov 2026 23:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750338;
	bh=vMpqvtQNovUuAIqmhTHcL6s31FG+bQ7NcYA2144BjfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XHt5pX5PFa7d8TO865fjwYL5TBzozY2vGJ8dath+2i9eE14/HnzvF9ivsZQVV507f
	 bkQi6StS3WwXt4ZYmfoHD57uDKrZwsTjecwAwdSi4p+W2pie4RC9i+a9WNwPrjKMwl
	 IIzkJfNiAGT4IqIjMzKXkHtFfDogydQ11HTsfFvm8GK43MLJDD7rnmSf/9gQjCfX+t
	 ZuZYNxo8NiOMwMRG2BRvE06JMr2hJ7F39Xxm/Igzw02EjtitKvwGVNg7wsNp6Dl3+p
	 syzQ+Q32Ctlh9apRpzFWl2yDEESxFymRe2BB45EKz60ANikd64cPCDYfwt6ku5Ram5
	 zcK8myTy7TcUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: fix named stream write and EOF handling
Date: Tue,  3 Nov 2026 18:58:56 -0500
Message-ID: <20261103235756.1654200-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110333-decompose-wifi-2653@gregkh>
References: <2026110333-decompose-wifi-2653@gregkh>
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

[ Upstream commit 02165c8d402392278a5cd2cf97645ed73a7ad4a1 ]

An SMB WRITE to an existing named stream can silently discard data after
its written range. ksmbd stores streams as xattr values, but the write
path passes offset + count as the length of the replacement xattr even
when the old stream is longer. Writing 26 bytes at offset 0 to a 60-byte
stream reports 26 bytes written while discarding the remaining 34 bytes.

Keep the existing xattr length when an in-place write ends before EOF.
Reject writes that cross XATTR_SIZE_MAX rather than storing only the
portion that fits while reporting the full requested count.

Commit 4ea0bb8aaedf ("ksmbd: handle set/get info file for streamed file")
intentionally skipped ordinary inode truncation for stream handles: an
EOF SetInfo on an ADS had truncated the base file. That fixed the base
file corruption but left stream EOF changes reporting success without
resizing the stream. Handle these requests by resizing only the stream
xattr; the base file size remains untouched. Zero-fill stream extensions.
This is needed alongside the write fix: a short write's accidental
truncation previously masked an ignored explicit EOF change. The stream
resize helper returns xattr errors directly rather than using the
base-file truncate path's EBADF conversion.

Fixes: f44158485826 ("cifsd: add file operations")
Fixes: 4ea0bb8aaedf ("ksmbd: handle set/get info file for streamed file")
Cc: stable@vger.kernel.org
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: Adapted mount ID mapping to the existing user_namespace and file_mnt_user_ns() API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c |  2 ++
 fs/smb/server/vfs.c     | 70 ++++++++++++++++++++++++++++++++++++-----
 fs/smb/server/vfs.h     |  1 +
 3 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8d2f5e4e9ae3b..4896ebaef5702 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6040,6 +6040,8 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 
 	newsize = le64_to_cpu(file_eof_info->EndOfFile);
 	inode = file_inode(fp->filp);
+	if (ksmbd_stream_fd(fp))
+		return ksmbd_vfs_stream_truncate(fp, newsize);
 
 	/*
 	 * If FILE_END_OF_FILE_INFORMATION of set_info_file is called
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index cc8cadcbc2036..7db4eb93efc6c 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -420,23 +420,21 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 	const struct cred *saved_cred;
 	char *stream_buf = NULL, *wbuf;
 	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
-	size_t size;
+	size_t size, write_end;
 	ssize_t v_len;
 	int err = 0;
 
 	ksmbd_debug(VFS, "write stream data pos : %llu, count : %zd\n",
 		    *pos, count);
 
-	if (*pos >= XATTR_SIZE_MAX) {
+	if (*pos < 0 || *pos >= XATTR_SIZE_MAX) {
 		pr_err("stream write position %lld is out of bounds\n",	*pos);
 		return -EINVAL;
 	}
 
-	size = *pos + count;
-	if (size > XATTR_SIZE_MAX) {
-		size = XATTR_SIZE_MAX;
-		count = XATTR_SIZE_MAX - *pos;
-	}
+	if (count > XATTR_SIZE_MAX - *pos)
+		return -EFBIG;
+	write_end = *pos + count;
 
 	saved_cred = override_creds(fp->filp->f_cred);
 	v_len = ksmbd_vfs_getcasexattr(user_ns,
@@ -449,6 +447,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 		err = v_len;
 		goto out_revert;
 	}
+	/* Preserve the tail of an existing stream on an in-place write. */
+	size = max_t(size_t, v_len, write_end);
 
 	if (v_len < size) {
 		wbuf = kvzalloc(size, GFP_KERNEL);
@@ -484,6 +484,62 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 	return err;
 }
 
+/**
+ * ksmbd_vfs_stream_truncate() - change the length of a named stream
+ * @fp:		stream file handle
+ * @newsize:	new stream length
+ *
+ * Resize the stream xattr without changing the base inode size.
+ *
+ * Return: 0 on success, otherwise a negative error code
+ */
+int ksmbd_vfs_stream_truncate(struct ksmbd_file *fp, loff_t newsize)
+{
+	const struct cred *saved_cred;
+	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
+	char *stream_buf = NULL, *new_buf = NULL;
+	ssize_t v_len;
+	int err;
+
+	if (newsize < 0)
+		return -EINVAL;
+	if (newsize > XATTR_SIZE_MAX)
+		return -EFBIG;
+
+	saved_cred = override_creds(fp->filp->f_cred);
+	v_len = ksmbd_vfs_getcasexattr(user_ns, fp->filp->f_path.dentry,
+				       fp->stream.name, fp->stream.size,
+				       &stream_buf);
+	if (v_len < 0) {
+		err = v_len;
+		goto out;
+	}
+	if (v_len == newsize) {
+		err = 0;
+		goto out;
+	}
+
+	new_buf = stream_buf;
+	if (newsize > v_len) {
+		new_buf = kvzalloc(newsize, GFP_KERNEL);
+		if (!new_buf) {
+			err = -ENOMEM;
+			goto out;
+		}
+		if (v_len)
+			memcpy(new_buf, stream_buf, v_len);
+	}
+
+	err = ksmbd_vfs_setxattr(user_ns, &fp->filp->f_path, fp->stream.name,
+				 new_buf, newsize, 0, true);
+	if (new_buf != stream_buf)
+		kvfree(new_buf);
+out:
+	kvfree(stream_buf);
+	revert_creds(saved_cred);
+	return err;
+}
+
 /**
  * ksmbd_vfs_write() - vfs helper for smb file write
  * @work:	work
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index cc47e71c4de13..f50be5f9ec348 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -82,6 +82,7 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    char *buf, size_t count, loff_t *pos, bool sync,
 		    ssize_t *written);
+int ksmbd_vfs_stream_truncate(struct ksmbd_file *fp, loff_t newsize);
 int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id);
 int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path);
 int ksmbd_vfs_link(struct ksmbd_work *work,
-- 
2.53.0

