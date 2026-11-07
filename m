Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794078695;
	b=Ih9prnD76DfhRp8Brsfttcw0h2ECvXXgQaNcLnhNeeOMmqsjTK0Wl4kUckx9bT0Eb64t
	 ExWS7edWDMbsfsD6/EG1DZMU2BRU16/OikfTVRygSSwvONC/sFBG7ooBuv5UN/cLITTG5
	 /8TmCEmmO5RLPvCsdRo979NXKToxJ9MaphBJyqFGsxhqfHPeH/oaNHz+VsaV9igLjuSPe
	 ayBJC6/bWnFd6mTRE/bHU1eoJe61EfecvNUdgeQICtwdD+qPaRjdC2PixB0qxvFiH06cQ
	 ZJupkZRA5SuD8hwuIjxezubRx2V6mrgcQ+ualdGZHWCsx0Yd1Jra4cH1mhDK4xmV0Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794078695;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=J/0dtP5xYfXIzszRXLq1JECyHEksY7C3pNkAl/62Ly0=;
	b=XhaOfcojlOFCz31xuyvQVtptPHTfzpjFKHIvSjBeDh8Hu5Ok5ETR4QUAwdll8f7/brSj
	 r3IDFyFzO+X0sPwxXJPVweB5FkTDDccyHGmtl43xdJQpBWPVjavPzIVbnIHRVRd/llAS7
	 zsb9oM5x8geaHf8NsFEzfS1AxKgqcje6R0k/IM8kKIRCbyCrXTY7fL+alhTADaLIt8Zwe
	 wV8HCLTWC3zVD8T6Qe3WXkp6bSAY1s206+MP1hF1Kg81xsu+kT11RPEor02KKo+zd5Mpp
	 bvzrB+DIkDcQnequY3XnJHMv/iiRgCAR5bS+DyW3bhauRk+MTFPN5CWVWLhZIOzawXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gH1jn0Lu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A718606A32E;
	Sat,  7 Nov 2026 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gH1jn0Lu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9725A1F0089F;
	Sat,  7 Nov 2026 19:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794078694;
	bh=J/0dtP5xYfXIzszRXLq1JECyHEksY7C3pNkAl/62Ly0=;
	h=From:To:Cc:Subject:Date;
	b=gH1jn0LurG1BZMclIkuEadZ57/aNDj4TiJ0qEHWGQ7F3v0BGLjppB0/FTk35HWdK3
	 BkBLco3peoQ52HnDS1RRCrVTlRpGILpqB//IGHs88K1ECXBZLR52HV1ddLN+TZ8FXX
	 kPhrKy1mbh2zTRfHxF0Vscv97RuxzVlf0Zm7r0t8dzTN4N1vT7Il9RIxV7ZyV4RpAb
	 C5NP5gbhc1utxldDV7xFk5Bpf7MQyptie1UzH9l/du46idBFbOQ5MCHGH5ay2NyUxP
	 wWcEaoesi70uaX7WihPpdhYmCbZZ7+U5ekr+3Z8NJWXttjzfpbaF6ge/YEXVPsxQbr
	 cV3qzkseP5gaw==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 5.15] fsverity: Explicitly require FMODE_READ to retrieve hashes
Date: Sat,  7 Nov 2026 11:11:31 -0800
Message-ID: <20261107191131.30975-1-ebiggers@kernel.org>
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
index 1d831e3cbcb33..073bb57334c45 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -146,6 +146,7 @@ fatal signal), no changes are made to the file.
 FS_IOC_ENABLE_VERITY can fail with the following errors:
 
 - ``EACCES``: the process does not have write access to the file
+- ``EBADF``: the file descriptor is not open for reading
 - ``EBADMSG``: the signature is malformed
 - ``EBUSY``: this ioctl is already running on the file
 - ``EEXIST``: the file already has verity enabled
@@ -208,6 +209,7 @@ regardless of the size of the file.
 
 FS_IOC_MEASURE_VERITY can fail with the following errors:
 
+- ``EBADF``: the file descriptor is not open for reading
 - ``EFAULT``: the caller provided inaccessible memory
 - ``ENODATA``: the file is not a verity file
 - ``ENOTTY``: this type of filesystem does not implement fs-verity
@@ -280,6 +282,7 @@ blocks from disk without actually verifying the path to the root node.
 
 FS_IOC_READ_VERITY_METADATA can fail with the following errors:
 
+- ``EBADF``: the file descriptor is not open for reading
 - ``EFAULT``: the caller provided inaccessible memory
 - ``EINTR``: the ioctl was interrupted before any data was read
 - ``EINVAL``: reserved fields were set, or ``offset + length``
diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index f0d7b30c62db2..f0eaef6bea4a1 100644
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
index 7e2d0c7bdf0de..ea8044164508a 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -157,13 +157,19 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg)
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

base-commit: 29c6cdaac04a6989a7ed4ae4275ce4244e617f58
-- 
2.56.0

