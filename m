Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741876;
	b=0oUVyGvexiDpnrWf0wGYhSCc1x0K/Fa6VqcCbpws5AD8orjlV0JwzcOqyBWGaQXrYM0f
	 jVJKaC4iZCaZQj/mgNo3qT++oR/yMbk8CsbcqzXR7lMQDU8GzM3SxvauaLriQaUsPXtuB
	 EN7gqG1Us82Vn4C+Sen/6gmxE2xMYMAWJBwBcjKQBG4cMORxohOE8ZyWdOAgUV0FUCDXB
	 ZNixbUPZ/4QVUD+dbkm7vajH0eFCJUqFNlURAvyOwiuajjsjM/nk8KSYhIUEb100EtPns
	 zBRmB/+1kl7QNJaAPW6r3OfPc8JqOPqZYcz7H2moMWyrXIcayUKau6hkKwavGd0tLEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741876;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OkOXO46M75q1QpshZJitsKatR7RXAmUc4Db7NPYgSSA=;
	b=QaJs23jVa86kUbgvy1rzmg7V+U6zgPh87LPO7ZSlw8TwZY2TDkqVXgIcKv0IO3jhOuDo
	 YZimfpjhKZnTf8YQXSL3Z5LqBvdGFpfNqnAfTqd23H5oz2EWd5uJHJIuAV3KiYNEqAOSk
	 O5U0DGLgCO3DkG3vLDCAWNzq/Q9bglL/ybGrtr3J6A/GdB6mIHkyEZTHcFjZ/zW5V+6WF
	 mr737BsjHkt3uBJ0lBTRNSo/Bb+8D5ZQswgOy55bIHbMYl6zP+yUs7VzU2gUCXVygRzyd
	 okoMiElqAAHNIm6aVawKI3g8267dmcR+SXi7p3P+4EcbitXx/o2iRTxMY0w+v+xPpHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lt91GhcR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30742606A326
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lt91GhcR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CE81F00919;
	Tue,  3 Nov 2026 21:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741875;
	bh=OkOXO46M75q1QpshZJitsKatR7RXAmUc4Db7NPYgSSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lt91GhcR54IXKPYRMUD9P6oTNXbl5JioxX4RikiYrh8hQ6yQG5wrbva/cCe79tCRK
	 f6ZnQRrduarGQVg7S0edsvbkMesiBoB+jPtGOd/WhplkalEmRuRzumIX8Hyp6Y7Kkn
	 zD++ynIulDilK26isebZPZrpHWcouHdb9ORIxaQg4m6zxQOHDUghH5wGMPWNZQ4Ekr
	 T69Q9IhoLw8Ua4czZBfEWJDd28et/XEP4Ou+VqscNSxC89Y24G1TxuHy/xZm6Svt1H
	 YWV9Mxl/puWs3tbkx4aF29934NSFoFCPohz+drt4rZpWsMGnOzsbo7vU1gq6yPVvzI
	 l11WWi/kIPNqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: fix named stream write and EOF handling
Date: Tue,  3 Nov 2026 16:37:54 -0500
Message-ID: <20261103213657.1420833-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110331-trimmer-sizzle-dc5f@gregkh>
References: <2026110331-trimmer-sizzle-dc5f@gregkh>
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
[ sashal: changed const struct mnt_idmap pointers to non-const pointers ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c |  5 +--
 fs/smb/server/vfs.c     | 72 ++++++++++++++++++++++++++++++++++++-----
 fs/smb/server/vfs.h     |  1 +
 3 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 793c219b9a610..e8a8453946b0b 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -6546,6 +6546,8 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 
 	newsize = le64_to_cpu(file_eof_info->EndOfFile);
 	inode = file_inode(fp->filp);
+	if (ksmbd_stream_fd(fp))
+		return ksmbd_vfs_stream_truncate(fp, newsize);
 
 	/*
 	 * If FILE_END_OF_FILE_INFORMATION of set_info_file is called
@@ -6554,8 +6556,7 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 	 * truncate of some filesystem like FAT32 fill zero data in
 	 * truncated range.
 	 */
-	if (inode->i_sb->s_magic != MSDOS_SUPER_MAGIC &&
-	    ksmbd_stream_fd(fp) == false) {
+	if (inode->i_sb->s_magic != MSDOS_SUPER_MAGIC) {
 		ksmbd_debug(SMB, "truncated to newsize %lld\n", newsize);
 		rc = ksmbd_vfs_truncate(work, fp, newsize);
 		if (rc) {
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index c18ab8431e0d2..2369ff55e7c37 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -414,23 +414,21 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 	const struct cred *saved_cred;
 	char *stream_buf = NULL, *wbuf;
 	struct mnt_idmap *idmap = file_mnt_idmap(fp->filp);
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
 	v_len = ksmbd_vfs_getcasexattr(idmap,
@@ -443,6 +441,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 		err = v_len;
 		goto out_revert;
 	}
+	/* Preserve the tail of an existing stream on an in-place write. */
+	size = max_t(size_t, v_len, write_end);
 
 	if (v_len < size) {
 		wbuf = kvzalloc(size, KSMBD_DEFAULT_GFP);
@@ -471,13 +471,69 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 	if (err < 0)
 		goto out;
 	else
-		fp->stream.pos = size;
+		fp->stream.pos = write_end;
 	err = 0;
 out:
 	kvfree(stream_buf);
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
+	struct mnt_idmap *idmap = file_mnt_idmap(fp->filp);
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
+	v_len = ksmbd_vfs_getcasexattr(idmap, fp->filp->f_path.dentry,
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
+		new_buf = kvzalloc(newsize, KSMBD_DEFAULT_GFP);
+		if (!new_buf) {
+			err = -ENOMEM;
+			goto out;
+		}
+		if (v_len)
+			memcpy(new_buf, stream_buf, v_len);
+	}
+
+	err = ksmbd_vfs_setxattr(idmap, &fp->filp->f_path, fp->stream.name,
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
index df6421b4590ba..7a49b731e99a1 100644
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

