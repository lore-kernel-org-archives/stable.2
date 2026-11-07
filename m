Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794078892;
	b=ESdKnBAHubm3jKA+MDEguEF1Jse1Mhi0Z8v52Co0yUBu/5oieVOM8Nwx2kuhvqimbA9X
	 QYeVCjBAaQCrrRZlYQl1ULPUSQVTXPg7l7hiNEALOuEAaDlDHnAjzDfm0qM5Iwo9PTChG
	 s5Xk9Hj+wO4+VkNylCgw39w3Uko0qf7ZlMxQXMFrtA2K6Eqcw68cE+NH0QBdlKM+ufF9r
	 ybrqWeFZYcbo/0vQoRj6XWAfrkScYaFoE0pH95lgsnmWBxmZTyW2UebCzZAarT3W+kXSr
	 1aTh99KvuBvmhC4AskedqFElBcK2jHXsI2P/nEFVotXUDzKSWvj/BCDFSao6syrhEVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794078892;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Q40vr2Cuq0ydvo5nF+Yg5CTa2y/FTbCDRX+QJ+acIOM=;
	b=FSL47+h6GkaGynfJlA5J140u3pq7jl38hsaZot2GNswAcOBvSVrrUGsECE1lQIt26R7l
	 ZOu2UOKNF8cKGQQvZ4Jwc9RO24VFjU7dNpjnTOmXpIgjQpLvJ8C3VsP0QL9PBrlltkdHi
	 PAU2JqkAaNse3s5nibGMbqXeTXGx/maJOstDeptXccjft1zMk+ESSmoeg/zryTpymR2Nr
	 z6SdLoin02ySQin942SV4z2rCapgq973cH69O2mz1IgfNJtAxXUFUhrT1B22t9bogfO4S
	 lXFbp2RRBLiQTVDaFeP1JoRfRhKTYAWyUQjfdOnyBX8w5HKqwoZD0qa41o799nNR0aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MiqNa0XZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C719606A326;
	Sat,  7 Nov 2026 19:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MiqNa0XZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40981F0089F;
	Sat,  7 Nov 2026 19:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794078891;
	bh=Q40vr2Cuq0ydvo5nF+Yg5CTa2y/FTbCDRX+QJ+acIOM=;
	h=From:To:Cc:Subject:Date;
	b=MiqNa0XZF+0HvP2LorQgTctBCau471oOj8/sxvn+iSs7O9QPStXI6P2y3uhyTXCec
	 RGBMRT54L4RgNOcOVkdKAdwzOmP3Esskl9lUvMYiPuJ0jenAInaoJnn2xXYAN51TiN
	 ROkjvFw9Gb475rGJcgUk5PQ27tMo0d8V6pU8+n9ADn8fzpqpnwr1FD7DYz4Qk6vGye
	 V2E/J/fZWL1Rtdupr5jVqOd5hKumLK/hqt7lxCMeMPH7lQdCBBCRF8gKCxm9JU1xg7
	 vEhRhwFRSeLaBy0B3oOB1fE6UqGE2V9NomEBkzj5JZwvmMZmL5JdLQMo/9x9eVnCho
	 fkGNH2vxg2acQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: fsverity@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Andrey Albershteyn <aalbersh@kernel.org>
Subject: [PATCH 5.10] fsverity: Explicitly require FMODE_READ to retrieve hashes
Date: Sat,  7 Nov 2026 11:14:08 -0800
Message-ID: <20261107191408.43437-1-ebiggers@kernel.org>
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
(5.10: dropped the FS_IOC_READ_VERITY_METADATA changes, since that ioctl
 does not exist in this version)
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 Documentation/filesystems/fsverity.rst |  2 ++
 fs/verity/measure.c                    | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 895e9711ed881..4bd6f25e1a4b3 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -146,6 +146,7 @@ fatal signal), no changes are made to the file.
 FS_IOC_ENABLE_VERITY can fail with the following errors:
 
 - ``EACCES``: the process does not have write access to the file
+- ``EBADF``: the file descriptor is not open for reading
 - ``EBADMSG``: the signature is malformed
 - ``EBUSY``: this ioctl is already running on the file
 - ``EEXIST``: the file already has verity enabled
@@ -207,6 +208,7 @@ regardless of the size of the file.
 
 FS_IOC_MEASURE_VERITY can fail with the following errors:
 
+- ``EBADF``: the file descriptor is not open for reading
 - ``EFAULT``: the caller provided inaccessible memory
 - ``ENODATA``: the file is not a verity file
 - ``ENOTTY``: this type of filesystem does not implement fs-verity
diff --git a/fs/verity/measure.c b/fs/verity/measure.c
index df409a5682edf..be3628f9e557f 100644
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

base-commit: 3a323bc22b881a5bdc1646080f93f5ecb22850bf
-- 
2.56.0

