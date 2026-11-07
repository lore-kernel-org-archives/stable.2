Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794078665;
	b=U8HVjlW1Ub01dowBrNGCwkmb0CuWU4TyIv//v1Djavf5rgttt9cqq4XCkIQbfiHA8yqt
	 +RI0LjjKhuiR48P93mcuzbGGV5gFjb/mxeB/bAeRV5oAlW1/m3Q+nyEZFUBpSfFci+T2H
	 WMatx4gz7cSxdB8DYeZaKtOJHHpIy2FaMUkQbeMUxm3Sn4dQq3OEJFLcJmQRefmI1pqP0
	 jWyaalYu/E7aLiMgaZmQjn7/JLGPLcJeQ9sOgvkuqBxzPWFfOSwfEmwp9kqVWbsR6cE+G
	 vgmpoZfuTvMZlG/Svm8r7DPLw/hi3+XDIiAeJO5w/5vMt3EeJrx574o01wjRnFb6u5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794078665;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yyN5GPqYNltXjgSFkf27wDpTgQP8s8403TmnQfD6+HY=;
	b=GVCwxez88Bz9N12YDDfmytw/PqCOzzw6djLTM+LwJfNTSb604pbMvTGTyorSYPaYF0JO
	 EAiGHiAfURNeuu04M7OaJc5KSiECZVLtdsmqFKpV8FexTAtRJ5qCPJgDeC4XxHW7xxeHt
	 0VAeBW0lH1cNvPolUXV6pbRCx6bwAfwfhqVv2L+dOhu4bdzTjcRZUfHOZvOGWNhlbnu52
	 V31DqKqmM8nwRw6wRVWys3ljoSce/l9u2qo659oPQoSlLvEkT5gegS5M+s9NkCDLxPDtT
	 3427CvghEOv5FW0Zgqt9u1JFLT6mizYP3DgzD0h07Da+lgTi2UM1QYr8IFOVwOYuaeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1qEI1Qh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54918606A326;
	Sat,  7 Nov 2026 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1qEI1Qh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEA41F0089F;
	Sat,  7 Nov 2026 19:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794078664;
	bh=yyN5GPqYNltXjgSFkf27wDpTgQP8s8403TmnQfD6+HY=;
	h=From:To:Cc:Subject:Date;
	b=e1qEI1QhEYVta3kyUdSO6UyNLUIrSOAm38QzuQKL47MYZHcYTAFxmnJqqcb6LXXCR
	 qttOoKFFKCUaTu5+lpwcHAs+Z0GyP2ikkqtDlrVpywIJjhVplsB93rdN4WLUU7wNaQ
	 Vc38hoOFzKSEepTpc4pPldL7TPM9IsivCmL8Yh7ApsZWJNWiHTZd+Vo4ZwD2KrXmBK
	 hwZ+3eFNSlxM+/FMseWX/ctnGi9iMwh7eGY37VGwL7uRZiaNiT8712NbKUnPrjGWbY
	 FttGcER1aOmlDHKDHLeqXfm0jrxMZpK0ZdCGazl4c8s0aV2rSHsRYWk11nvJhv6CVL
	 1m5bVKKtlN2HQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 6.1] fsverity: Explicitly require FMODE_READ to retrieve hashes
Date: Sat,  7 Nov 2026 11:10:50 -0800
Message-ID: <20261107191050.25921-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0
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

commit 1acb4fd2d011c4bd6cc961095ae17361c71ff61a upstream.

The comment in fsverity_ioctl_read_metadata(), which justifies not
checking for FMODE_READ, doesn't consider that the nonstandard access
mode 3 (ioctl-only) exists.

Opening an ioctl-only fd generally requires read (and write) permission.
However, there are gaps with certain LSMs: an ioctl-only fd requests
read (and write) permission via security_inode_permission, but not
security_file_open.  With certain LSMs relying on the latter, such as
Landlock and AppArmor, an ioctl-only fd can be opened without the LSM
granting read (and write) permission.

Since FS_IOC_READ_VERITY_METADATA returns hashes of file contents
blocks, it should require read permission.  This also applies to
FS_IOC_MEASURE_VERITY, which returns a hash for the whole file.

Meanwhile, ioctl-only fds are a rarely-used feature, not known to be
used with either ioctl.

Therefore, just disallow these ioctls on ioctl-only file descriptors,
similar to what was already done with FS_IOC_ENABLE_VERITY.

More specifically, explicitly check for FMODE_READ.  This also covers
write-only fds to non-verity files which otherwise would have failed
with ENODATA.  This change in error code for write-only fds should be
fine too, as these ioctls cannot be usefully used with write-only fds
anyway, but it's worth noting as another technicality.

Fixes: 4dd893d832cf ("fs-verity: implement FS_IOC_MEASURE_VERITY ioctl")
Fixes: e17fe6579de0 ("fs-verity: add FS_IOC_READ_VERITY_METADATA ioctl")
Cc: stable@vger.kernel.org
Reviewed-by: Andrey Albershteyn <aalbersh@kernel.org>
Link: https://patch.msgid.link/20261022211522.1489943-1-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 Documentation/filesystems/fsverity.rst |  3 +++
 fs/verity/measure.c                    | 10 ++++++++++
 fs/verity/read_metadata.c              | 14 ++++++++++----
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index cb8e7573882a1..3c7ddd6790baa 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -157,6 +157,7 @@ fatal signal), no changes are made to the file.
 FS_IOC_ENABLE_VERITY can fail with the following errors:
 
 - ``EACCES``: the process does not have write access to the file
+- ``EBADF``: the file descriptor is not open for reading
 - ``EBADMSG``: the signature is malformed
 - ``EBUSY``: this ioctl is already running on the file
 - ``EEXIST``: the file already has verity enabled
@@ -219,6 +220,7 @@ regardless of the size of the file.
 
 FS_IOC_MEASURE_VERITY can fail with the following errors:
 
+- ``EBADF``: the file descriptor is not open for reading
 - ``EFAULT``: the caller provided inaccessible memory
 - ``ENODATA``: the file is not a verity file
 - ``ENOTTY``: this type of filesystem does not implement fs-verity
@@ -291,6 +293,7 @@ blocks from disk without actually verifying the path to the root node.
 
 FS_IOC_READ_VERITY_METADATA can fail with the following errors:
 
+- ``EBADF``: the file descriptor is not open for reading
 - ``EFAULT``: the caller provided inaccessible memory
 - ``EINTR``: the ioctl was interrupted before any data was read
 - ``EINVAL``: reserved fields were set, or ``offset + length``
diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index e99c00350c28d..70735f2708772 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -28,6 +28,16 @@ int fsverity_ioctl_measure(struct file *filp, void __user *_uarg)
 	const struct fsverity_hash_alg *hash_alg;
 	struct fsverity_digest arg;
 
+	/*
+	 * This ioctl returns a hash of the file contents, so it should require
+	 * read permission.  Disallow it on ioctl-only (i.e., nonstandard access
+	 * mode 3) fds, which can in some cases be acquired without passing all
+	 * LSM read-permission checks.  Also disallow write-only fds, which can
+	 * refer only to non-verity files which would fail with ENODATA anyway.
+	 */
+	if (!(filp->f_mode & FMODE_READ))
+		return -EBADF;
+
 	vi = fsverity_get_info(inode);
 	if (!vi)
 		return -ENODATA; /* not a verity file */
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index 2aefc5565152a..1ef755130407b 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -156,13 +156,19 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg)
 	int length;
 	void __user *buf;
 
+	/*
+	 * This ioctl returns file contents block hashes, so it should require
+	 * read permission.  Disallow it on ioctl-only (i.e., nonstandard access
+	 * mode 3) fds, which can in some cases be acquired without passing all
+	 * LSM read-permission checks.  Also disallow write-only fds, which can
+	 * refer only to non-verity files which would fail with ENODATA anyway.
+	 */
+	if (!(filp->f_mode & FMODE_READ))
+		return -EBADF;
+
 	vi = fsverity_get_info(inode);
 	if (!vi)
 		return -ENODATA; /* not a verity file */
-	/*
-	 * Note that we don't have to explicitly check that the file is open for
-	 * reading, since verity files can only be opened for reading.
-	 */
 
 	if (copy_from_user(&arg, uarg, sizeof(arg)))
 		return -EFAULT;

base-commit: c75b0cf0982c00cddfd88d1acf3872f79b40980c
-- 
2.56.0

