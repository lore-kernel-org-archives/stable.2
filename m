Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735308;
	b=4Q0bzxGtn/yq2PS83oh6oGJrmf+FW0RjSKPEWiM9UPA/PFo6O+6YMnUjyWgJwuyqFmD/
	 w/PQNLjjgaPa0chRmYeRwwDCJ/OpzWNP7z87flERei2KnQMGbZ2S9sYn7XNOAu+H4/U9t
	 LINwZDDOU3WAlsQE4Vp7Dn9Edz0SZJZBvUxgmLFRxyoNhpkSxuwfLYLqMO5FW9dhucDHy
	 pITeeMn+2SYkI9zLr+jxYRDUSdiEYKaY43DyC9SOxUEyJjDzp9YiEK5dz+zgQxvl6QOtT
	 0VWkHHTkgvK7Sq/3wWxK3uEMoFPevWIJYQlp0/QmLu7qUiT29RQgvceGZOzl8Sw+dRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735308;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Rp5z7ZJC9wOQOdv/AgK48IgCQYA9I9dzczmQgPacvSo=;
	b=IfEWhOEx2ClgvRXnEONe++ERePX/A6ml57EyXx8xamBjU0aJ7r7R/Oo54yjKp46bBMc/
	 wTip2Cij1WHGFcxdrl5B6EN1DejJRgzmKNu5VGajblNcVxv6DlvZsC68FdQd8uh8rfPAq
	 Bs2P+JTn1AePZYfVw1lrq5xwXrscYUkhwVUKbrtzn1tPPfP+JgGlm1HXBpg4WbVaKxCwv
	 ouT6x1GN5iVURyO4OCdp9wIIXgse30q5xXzv6c9/ggNJq+bFzsscoizoYDllNOp4ywSzu
	 BqikdfB1V2AJISSFLgKmb1450OMm182iox3NFfQc3UniaU2V1mfjtYhjzwEOTA2c96g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUkNUAtQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3AC606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUkNUAtQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF981F000C1;
	Tue,  3 Nov 2026 19:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793735308;
	bh=Rp5z7ZJC9wOQOdv/AgK48IgCQYA9I9dzczmQgPacvSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LUkNUAtQ4yQG5cZ76vLBQUsdjMPijcnNE/3WyiX1TnfYFA8hrCwkFZ5zmvislU9n4
	 RuQWqbv7jtRmiMpymGvD8br6/vP+vhm/fLxGJUDiKTBQ2I+PXQB2JdI9Lev7eX6t2X
	 JLDOaXiH0/ZtCFQXulYPDwFy0KU2NanyCmuMyEbeBO82b5SD6KsGramTbt16e6T4HW
	 oq++8TkuiZtxjOGNsxdtLIfwzNO1KSECJqf4uBipBpjKze0qvG1EWMLl5O4XhLoQ3A
	 FJ740J7PPtDfqpKVlsmZGdLO6Gbsn+/kLBRRdo/GHeREIWnq/BtxMs9+e97tBC06dn
	 3UnFPwyrOsc2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] ksmbd: fix named stream write and EOF handling
Date: Tue,  3 Nov 2026 14:48:26 -0500
Message-ID: <20261103194744.642471-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110330-handbook-dreadlock-76b4@gregkh>
References: <2026110330-handbook-dreadlock-76b4@gregkh>
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
[ sashal: Used non-const mnt_idmap pointers in stream write and truncate helpers to match existing xattr APIs. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c |  5 +--
 fs/smb/server/vfs.c     | 72 ++++++++++++++++++++++++++++++++++++-----
 fs/smb/server/vfs.h     |  1 +
 3 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index b3743e17aa3c1..b142280b57312 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8401,6 +8401,8 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 
 	newsize = le64_to_cpu(file_eof_info->EndOfFile);
 	inode = file_inode(fp->filp);
+	if (ksmbd_stream_fd(fp))
+		return ksmbd_vfs_stream_truncate(fp, newsize);
 
 	/*
 	 * If FILE_END_OF_FILE_INFORMATION of set_info_file is called
@@ -8409,8 +8411,7 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
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
index d61a5e55cde6e..f4f5187c3700a 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -392,23 +392,21 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
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
@@ -421,6 +419,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 		err = v_len;
 		goto out_revert;
 	}
+	/* Preserve the tail of an existing stream on an in-place write. */
+	size = max_t(size_t, v_len, write_end);
 
 	if (v_len < size) {
 		wbuf = kvzalloc(size, KSMBD_DEFAULT_GFP);
@@ -449,13 +449,69 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
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
index 55d099de71f52..0b337c2ee838e 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -83,6 +83,7 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    char *buf, size_t count, loff_t *pos, bool sync,
 		    ssize_t *written);
+int ksmbd_vfs_stream_truncate(struct ksmbd_file *fp, loff_t newsize);
 int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id);
 int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path);
 int ksmbd_vfs_link(struct ksmbd_work *work,
-- 
2.53.0

