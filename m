Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755840;
	b=et0k+UA91GBspyQqBICwqstSEttWv8afi5kwM2aI1lol7EYPsjhTbexhkMxb8HCoWK9y
	 LpeXoa3E1IUwNoKtvQH733/B8i6Xg7S7/vn7iwSjIbBLFY1JQixT3cSN40lsQvnedpCx1
	 TRn5vBVD7fTdqGZ4fWs4zshE2KlGdfYaPrIZMWAYF8sgwD+eo5nQZV9cncCXy6z24butn
	 t8+WNUoSLr3M0msTlpzjsq5g8+d3lYD30TXiAWo85gZ5bocgP9TJ+t7u9c2+vRLEv53Xi
	 Elj1xWqDu4/3vCCc+VG/v1NAmP9UUSQDH/A16NmEGTDM0uHQ3ICVL90BEwkz+Yfs4Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755840;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2d9EUj3hgwJSmD9sEGS282bstb+oUD2mB3t7WELOXZQ=;
	b=KB5ooc27BrYDuY2OwGh3K/9B6ZjI5QxnBU1zheZgPmqZb57PPp76eWvNvzyXgZS9OhLC
	 0v6CT4QxhigG4vlGaIdRLpTSIYbcgTIDaT14GJPCj0vcBIgWfSICQxarDmczdP88TC8Qg
	 G/+Q1GBc8hb/a+UZ3t24ZFbqikrnYVf05KYqx3S8Td+rHyVgPA6BoK8ZEaKBLgKt30xzK
	 YfcOGxYxN5jLM4kgkOcwIMUoQdxtz8c2v+Fcq1qTifVsjpy2iBqjRq/N6mcF8tknk6wPS
	 xxNG+1GvTmRzVAdfYCUJ3Af90D+2qCV7qijFihrVWIatKXS1gtJNDecu/I8wEyUL5dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Q/3CXa/M";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6473A606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q/3CXa/M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB72B1F000C1;
	Wed,  4 Nov 2026 01:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793755840;
	bh=2d9EUj3hgwJSmD9sEGS282bstb+oUD2mB3t7WELOXZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q/3CXa/MxWk7jlsthw+Xbyw62JlNPFlG91wVwaOKb13HHP9aGWinWtNJR0K5QV2dw
	 0lC++fIG5IpSi0sqT4FT+O+HGflqhtaYnDes+RA0yIrET+F/XSrVPwLFjAXlfVv1Ma
	 x3Yktb8VGN1/XWvYEIHTDxZK565hEQ5/018C8b8AT3wbqsYs2QFj5lUuWUuBNBXLRH
	 x2XO7JlalSLARXmuEdGuA1BoyDbx0caYotSz+1afI9SxA8dvMTErbLH9leofs8XIyK
	 EL9IBAgANwDjpwG72fQteY/ky+djKM/Rc8tGkuy9u1Mcx+IE4UfIHyesVNDHm8tBxR
	 yOpB/O2GRVLYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: DaeMyung Kang <charsyam@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: fix named stream write and EOF handling
Date: Tue,  3 Nov 2026 20:30:38 -0500
Message-ID: <20261104012839.1954511-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110334-operative-heavily-7efb@gregkh>
References: <2026110334-operative-heavily-7efb@gregkh>
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
[ sashal: adapted xattr calls to use user_namespace and file_mnt_user_ns() instead of the newer mount ID mapping API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c |  2 ++
 fs/ksmbd/vfs.c     | 71 ++++++++++++++++++++++++++++++++++++++++++----
 fs/ksmbd/vfs.h     |  1 +
 3 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 4c42205fe5261..8f7977f7d9c41 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5921,6 +5921,8 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 
 	newsize = le64_to_cpu(file_eof_info->EndOfFile);
 	inode = file_inode(fp->filp);
+	if (ksmbd_stream_fd(fp))
+		return ksmbd_vfs_stream_truncate(fp, newsize);
 
 	/*
 	 * If FILE_END_OF_FILE_INFORMATION of set_info_file is called
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index aff2d0f22c8fb..074adefa8c919 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -415,19 +415,22 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 {
 	char *stream_buf = NULL, *wbuf;
 	struct user_namespace *user_ns = file_mnt_user_ns(fp->filp);
-	size_t size;
+	size_t size, write_end;
 	ssize_t v_len;
 	int err = 0;
 
 	ksmbd_debug(VFS, "write stream data pos : %llu, count : %zd\n",
 		    *pos, count);
 
-	size = *pos + count;
-	if (size > XATTR_SIZE_MAX) {
-		size = XATTR_SIZE_MAX;
-		count = (*pos + count) - XATTR_SIZE_MAX;
+	if (*pos < 0 || *pos >= XATTR_SIZE_MAX) {
+		pr_err("stream write position %lld is out of bounds\n",	*pos);
+		return -EINVAL;
 	}
 
+	if (count > XATTR_SIZE_MAX - *pos)
+		return -EFBIG;
+	write_end = *pos + count;
+
 	v_len = ksmbd_vfs_getcasexattr(user_ns,
 				       fp->filp->f_path.dentry,
 				       fp->stream.name,
@@ -438,6 +441,8 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 		err = v_len;
 		goto out;
 	}
+	/* Preserve the tail of an existing stream on an in-place write. */
+	size = max_t(size_t, v_len, write_end);
 
 	if (v_len < size) {
 		wbuf = kvzalloc(size, GFP_KERNEL);
@@ -471,6 +476,62 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
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
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 6d108cba7e0cc..c9b1e4de44f02 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -120,6 +120,7 @@ int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
 int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    char *buf, size_t count, loff_t *pos, bool sync,
 		    ssize_t *written);
+int ksmbd_vfs_stream_truncate(struct ksmbd_file *fp, loff_t newsize);
 int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id);
 int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path);
 int ksmbd_vfs_link(struct ksmbd_work *work,
-- 
2.53.0

