Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792703753;
	b=nTDJ7p3TVKCRz1tOVh4hU6FTCSV47TTNGUPsZbR1czokdWFaaZ6rnmzzxW84VivsRLuY
	 z/wjMabXDZ+uwj3ScT3TWjA4U0t1PoEBLcH/GQ0I53cFS6PLnV86FVehMEf8Al8qxniuT
	 fWZYAQwIEa9mLyxCEHrvtDfLRYYendS6UsQaUZtB9Wh+aMN1WZqTfSDd7BEuG5/wCjX49
	 mu6Kmkom7qTteNtVWTuGa3ml3LciwbGdQ7sOCO4ffovoiMb2WecmN89q99NoDzvrO93ee
	 03yElyafd3HAiIEuCiBt5ItzaMYW4fu8m1PpnsdkQlb9+BT8Yj68DKjXIgwXOyPp1GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792703753;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ViygJGyeeKvJcEAVcpZEFMreWDoAi2NThaUnWrUztsE=;
	b=5HzW9eGmfD45exqcl2AIByZaXRNzeRHcoa/OatIgCVEaA1DN7+R02e9hLdh8mD/CnG1k
	 UBb6+Hxm8SVv0BnuDgn3fOUd8vxiRJ5pjnzP4OOz1CL/yvcrkO5sp4SewY+Egq06q0EYn
	 mQldIuIx406iLHlICl59uFPWswATpPRyOGFDGCrT26XbkxyJFEgR+7OIVPYJl9DNueZAP
	 uIGw6whAna1kGg1+LkC6dioWVuHINqjOpm+WmP2BwGjGlfmgulTCIiqAlCWSD45bjzZvV
	 dhkKFLnrnpX3Sxv5Zs0fDQ1tXwHJ88vk6UOCaBHTlNpHq/IlbsG1IFEgNYpE7ARtLmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCxihNjW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6D606A319;
	Thu, 22 Oct 2026 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SCxihNjW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7851F01825;
	Thu, 22 Oct 2026 21:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792703752;
	bh=ViygJGyeeKvJcEAVcpZEFMreWDoAi2NThaUnWrUztsE=;
	h=From:To:Cc:Subject:Date;
	b=SCxihNjWYTJswMFE/aoaWYWaNtZCzWx2fkm9erpYMu+dRRYAe3HrLDW5k0Hs6PFF1
	 VGACzBA0gGUva6RmPUXAIWoAx3OAqQiVnTy4NSwiySXdxC85SrpOdir24N4cLCuofK
	 peAS+eyD24b/1gcnIRHrYSMTXcBy21lAAFm6H/+ueZ4e6dVBp+F3iadh6yxnb5Tpp9
	 6AkmR1nig2lrI7aS0t0NHyUVvmDGFLEK52AlscxlnbSHd5KFaiHi7q4E+ILWpgt0cn
	 O1BFkL+g30Mga4W6DpSbG5LDokarVsF+Y92ZyokYYSYFVrVAAYSzygP2nmXkAlDpuq
	 OYb+oOKGBxVeQ==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] fsverity: Explicitly require FMODE_READ to retrieve hashes
Date: Thu, 22 Oct 2026 21:15:22 +0000
Message-ID: <20261022211522.1489943-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
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
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 Documentation/filesystems/fsverity.rst |  3 +++
 fs/verity/measure.c                    | 10 ++++++++++
 fs/verity/read_metadata.c              | 14 ++++++++++----
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 22b49b295d1f9..e5d38439bf585 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -170,6 +170,7 @@ fatal signal), no changes are made to the file.
 FS_IOC_ENABLE_VERITY can fail with the following errors:
 
 - ``EACCES``: the process does not have write access to the file
+- ``EBADF``: the file descriptor is not open for reading
 - ``EBADMSG``: the builtin signature is malformed
 - ``EBUSY``: this ioctl is already running on the file
 - ``EEXIST``: the file already has verity enabled
@@ -232,6 +233,7 @@ regardless of the size of the file.
 
 FS_IOC_MEASURE_VERITY can fail with the following errors:
 
+- ``EBADF``: the file descriptor is not open for reading
 - ``EFAULT``: the caller provided inaccessible memory
 - ``ENODATA``: the file is not a verity file
 - ``ENOTTY``: this type of filesystem does not implement fs-verity
@@ -310,6 +312,7 @@ blocks from disk without actually verifying the path to the root node.
 
 FS_IOC_READ_VERITY_METADATA can fail with the following errors:
 
+- ``EBADF``: the file descriptor is not open for reading
 - ``EFAULT``: the caller provided inaccessible memory
 - ``EINTR``: the ioctl was interrupted before any data was read
 - ``EINVAL``: reserved fields were set, or ``offset + length``
diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index 68dfccb697720..0c75616dca011 100644
--- a/fs/verity/measure.c
+++ b/fs/verity/measure.c
@@ -31,6 +31,16 @@ int fsverity_ioctl_measure(struct file *filp, void __user *_uarg)
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
index b4c0892430cde..6694149f7b467 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -166,13 +166,19 @@ int fsverity_ioctl_read_metadata(struct file *filp, const void __user *uarg)
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

base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
-- 
2.56.0.307.g5fe7bd680c-goog

