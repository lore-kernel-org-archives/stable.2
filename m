Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050004;
	b=pj9k1JZ3tV0HknBb8Jn+3gUj0AFKaY/X/BlEM0pddbc5tff79XX32KSUPRxQD+kaVsKw
	 gmALtLUhXDPP5Y3D4fGoPjysA+7oll/G3XIXnyDq+aBQe6C1ujykdkBHHsDoUX/md0gSs
	 ItbZPljrneemP5COFZI9t277fJlA1adSarCtDj2ZwXagLHaRQMtJMGdFQfzHdyf4+QEUs
	 0H5Fo8w4V2STO6jm3ptLn2DZyCRI0LLAPWiIWDihVctOIjE3KA9kCWrb1RF2IsSWH0GOk
	 qUrKIhDYanq7Rqy3J3OQx1QFfmckibfLvsviDPD/V5volaR27wWNRktva2BxG27njqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050004;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=atQUjQAqecxrTPTKvFOeZa4T7rBwBHRlRzqkdvvUVKo=;
	b=sJgbT/5SX+cYk6/Wr3rCP5gaIVIJiqH91V/xP8F/yQufduIysiEVxGaZ/3h9yrjPrPTl
	 a0yBJntUG3drP5ukZ9BjY2yUTns4z48EUdNp/bEzpD7vm0AFOgfFaMtNVRJWvhvuBAbcw
	 ae23XJg5PcNzRie8kG1YRwJ4yhAMP1vTsMnESdpBAc1ctWD6aeHLcXxgqUjBrcdj75LIj
	 sz+aJ6d8/C5kz2g0LKIpTw1EslHZ+jFuJZJNCE0iMOf0hZMX7lJGVfMSRzwhPfNT1FIsR
	 lnonB5mz1rs2aUYgorG2unOgI4MAie5K9ty5xOE7IbnLEZIR9l/V2ZTgf+sQWcMZELw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BWbJFqEQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82106606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BWbJFqEQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0181B1F0089F;
	Sat,  7 Nov 2026 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050004;
	bh=atQUjQAqecxrTPTKvFOeZa4T7rBwBHRlRzqkdvvUVKo=;
	h=From:To:Cc:Subject:Date;
	b=BWbJFqEQ2WHa+F+RXPCEvIXahVWePuZjktXwd4ltyrMw3/4KN+a/L1LApK7gG1ebf
	 Ryub5TB5Qv2sAVBhQJ2qas02nwDqeF6uVWjb53L2eUAbS85MHbjTBtlTzIhtY0feJ1
	 tZsQrRIYGxclASFEWiQgCOMkxoYnOiqB1RO6ZayaI0TWrYnQY/WWjWc5R1/kSJx1F+
	 y8q3kQdcigN38DABCgxs6Trl8Dac7/ZjXCn15lY6tOfpRIGj1Wqu2MkpQnXPdEcYc7
	 urOQfR9Wa71gp+mtTk6PxhKwdSiBa6z+5yyRe10mr2mHhXHbOvBxhPlUaCSDqtCB5w
	 ficcvZ+vzvasQ==
From: Sasha Levin <sashal@kernel.org>
To: ebiggers@kernel.org,
	aalbersh@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fsverity: Explicitly require FMODE_READ to retrieve hashes" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:13:22 -0500
Message-ID: <20261107061322-failed-5.15-1acb4fd2d011@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1acb4fd2d011c4bd6cc961095ae17361c71ff61a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061322-failed-5.15-1acb4fd2d011@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1acb4fd2d011c4bd6cc961095ae17361c71ff61a Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 22 Oct 2026 21:15:22 +0000
Subject: [PATCH] fsverity: Explicitly require FMODE_READ to retrieve hashes

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
-- 
2.53.0




