Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794078595;
	b=XdokwYuC9Z+k/k2u21chgNtv3yDLJONz5PDn7E2pz9dIHc5LtNBFZ598YlCGFXVaRTuC
	 E03cFg3MoT8AYhJ7Gal4FcouMJF5yjlW9S97m2vrbH60YEBzTlyiAVIXDbwtVQVySs6nE
	 exr2BbhikmLQfvTBhA9Qufv9/sDGNaZCkBXUhQfGDbwroxC+JR+we+2Jg0xTedzD9PrXL
	 miUQVtwYg21rL/K+eJQqFu4pZqnBdkHMQhgatttATyAL3lJRVjYc6NPAToLhVHR6bw0j1
	 wxyQioZov2I5BT+YvTLrHEwokwCXEGBEgr3bfzDC9LKKKPS/lxEAWHfW5uNCqKucciA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794078595;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=z2pPrbH2eOc26jyjwCHZ0OY4fYbax7uxcdS6AqhYzM0=;
	b=PCWyHXOno6DG5xI3s6Q9e8LNrhNBOI/Nr92hHO2hTQIRI+9HctQXzx8DZ0UsGajQB1wV
	 Sii9BNECcRX1WQ4lBuIiQDaytz15gvtR8X2MI32/dcuqPmGJQj9GSxIl5aLR5xETpy/Ff
	 HD0oQDzREfWYTRL4ZylBcGmvlyfnicJ91OANMnoT+ACf4ijDPQNzbEllEuSyEpduHR9uZ
	 cj869uqTYvho/JRfnAIHEzJH0cdE9Ze66YcEFhPzG1Y8zU4vlfb+8HYTgxTrospsVA0Kl
	 JaOjjdYsRIYGw8lVT0y7Eo+xyZsfJdgfOpx52z8JX/Ith532+Jc3X2x97soL/sdSW8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTtgLneH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87748606A326;
	Sat,  7 Nov 2026 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTtgLneH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F3D1F0089F;
	Sat,  7 Nov 2026 19:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794078595;
	bh=z2pPrbH2eOc26jyjwCHZ0OY4fYbax7uxcdS6AqhYzM0=;
	h=From:To:Cc:Subject:Date;
	b=HTtgLneHatLX5SDX16ZCcR7CNMySTojWm7+XFANYhnzC6EZCywowsY+08XCVP4Vl7
	 L2aLzy4c3bjSIO7Gqo+eWfmdkHUc56jnI5LKVc5qYhiWc7m4mtq7mWjejtqiosD5gC
	 T6X67eanw6Cd0nlDC9pEva+6sMGOOjNo4s86Lu1ICIFDVsoQuYRLTJdN8ao4eIpGKX
	 zDk75O6u8ysRcE7pUULTp5G+7jTEOxyUKRGK/QUCrc5F+ZgXWqPIvqP3aKNa6dv+xw
	 ZX6ribbHHwzzn9M//Y44lvd6fkiBjCygHDsGdxyui4WIPUTFtrH37igcDaBo7vrdWN
	 JBsucVcsVwKoQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 6.6] fsverity: Explicitly require FMODE_READ to retrieve hashes
Date: Sat,  7 Nov 2026 11:09:51 -0800
Message-ID: <20261107190951.19493-1-ebiggers@kernel.org>
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
index 13e4b18e5dbbb..dab77d92e5903 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -160,6 +160,7 @@ fatal signal), no changes are made to the file.
 FS_IOC_ENABLE_VERITY can fail with the following errors:
 
 - ``EACCES``: the process does not have write access to the file
+- ``EBADF``: the file descriptor is not open for reading
 - ``EBADMSG``: the builtin signature is malformed
 - ``EBUSY``: this ioctl is already running on the file
 - ``EEXIST``: the file already has verity enabled
@@ -223,6 +224,7 @@ regardless of the size of the file.
 
 FS_IOC_MEASURE_VERITY can fail with the following errors:
 
+- ``EBADF``: the file descriptor is not open for reading
 - ``EFAULT``: the caller provided inaccessible memory
 - ``ENODATA``: the file is not a verity file
 - ``ENOTTY``: this type of filesystem does not implement fs-verity
@@ -295,6 +297,7 @@ blocks from disk without actually verifying the path to the root node.
 
 FS_IOC_READ_VERITY_METADATA can fail with the following errors:
 
+- ``EBADF``: the file descriptor is not open for reading
 - ``EFAULT``: the caller provided inaccessible memory
 - ``EINTR``: the ioctl was interrupted before any data was read
 - ``EINVAL``: reserved fields were set, or ``offset + length``
diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index eec5956141da2..6b61ec273f070 100644
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
index f58432772d9ea..680792701ba29 100644
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

base-commit: 5139929c698c273e07cb0635732f6a918a7b8e78
-- 
2.56.0

