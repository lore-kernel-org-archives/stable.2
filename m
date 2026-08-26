Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1226B95B
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787708793; cv=none; b=ent60G9seTmdmvQUsh1MOeO0KDOLvHPln29UZK2CdzANh+ygVu3Hm7Vv5inQg5fCvh6K8llezIdoJg3H8FLNtstpD+FheMyJcJRKXskJRRD6YIqQE7XMEWIZf2M3kxscs5PJgf1UoVS4IueTYJXfStmoAGnAhLuCng+/lYgFZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787708793; c=relaxed/simple;
	bh=3jkUap6NCaCqx+4gWDyq5dK/B5gRumntDwi8izavjMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nr+m9Q92WRnzXbJXmFR0+KisNc6tMG6C6BmxLoCwd7nyDkHLiXXdDSamRNp5Nw9ltFE9Zj94bsqar6GFGBMH2w22++yFvz49mnU33oXED8OM2WuHiQO90rgblsoOa88zS/4C8NglIISV8JGxctMxr4fAWwd2LjKMuJCgYE1DvPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1Ku3uND; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1Ku3uND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587451F000E9;
	Wed, 26 Aug 2026 01:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787708790;
	bh=Z52wnh7XgPVJNyy0xRMLTr/o+mJ4NfxfZynJzSIe7SY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H1Ku3uNDHYIvNaoP3KRwJpm6eFs9NgS+ALMIPPvrd54oQpfmT545zQZKbT/wkHqGW
	 4lX4h8Ylr67WxyMDKnxqx+0ukY05LkolKvXywu31Wluce08DfZFAjXl9zCCcXjhtml
	 1Z/VMXbepOPUPBZydFrKZNwqtdr5azraD7RQn+4XDAcpSN5Wh8ZcI/55/2XUjSVcIB
	 OsQF5HFljhygX6T3+YlhJuZxugW7RYjw/dGU4rolQ/yV3MtfaUUNlmsVSMUlR2Q3qL
	 KWrqE5KYYt7h11m+52mwLKCmz3AqIL+zwzbUnKOOQYu09oQ4Z8hG9199e0L4j5p+Qu
	 a7dXSWgZHIBaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	"Brian G ." <gissf1@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] nilfs2: correct return value kernel-doc descriptions for ioctl functions
Date: Tue, 25 Aug 2026 21:46:26 -0400
Message-ID: <20260826014627.1462629-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082454-grope-ground-b6d7@gregkh>
References: <2026082454-grope-ground-b6d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

[ Upstream commit 17c46a45cdb94c500f4e93b176cdd61931b03020 ]

Patch series "nilfs2: fix kernel-doc comments for function return values",
v2.

This series fixes the inadequacies in the return value descriptions in
nilfs2's kernel-doc comments (mainly incorrect formatting), as well as the
lack of return value descriptions themselves, and fixes most of the
remaining warnings that are output when the kernel-doc script is run with
the "-Wall" option.

This patch (of 7):

In the kernel-doc comments for functions, there are many cases where the
format of the return value description is inaccurate, such as "Return
Value: ...", which causes many warnings to be output when the kernel-doc
script is executed with the "-Wall" option.

This fixes such incorrectly formatted return value descriptions for ioctl
functions.

Link: https://lkml.kernel.org/r/20250110010530.21872-1-konishi.ryusuke@gmail.com
Link: https://lkml.kernel.org/r/20250110010530.21872-2-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: "Brian G ." <gissf1@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: a1735eae5544 ("nilfs2: reject invalid block index in GC ioctl")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/ioctl.c | 241 +++++++++++++++++++---------------------------
 1 file changed, 100 insertions(+), 141 deletions(-)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 77e6bae7d5c97..0a43f1f956cb7 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -32,17 +32,14 @@
  * @dofunc: concrete function of get/set metadata info
  *
  * Description: nilfs_ioctl_wrap_copy() gets/sets metadata info by means of
- * calling dofunc() function on the basis of @argv argument.
- *
- * Return Value: On success, 0 is returned and requested metadata info
- * is copied into userspace. On error, one of the following
- * negative error codes is returned.
- *
- * %-EINVAL - Invalid arguments from userspace.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-EFAULT - Failure during execution of requested operation.
+ * calling dofunc() function on the basis of @argv argument.  If successful,
+ * the requested metadata information is copied to userspace memory.
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EFAULT	- Failure during execution of requested operation.
+ * * %-EINVAL	- Invalid arguments from userspace.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilfs,
 				 struct nilfs_argv *argv, int dir,
@@ -176,13 +173,10 @@ static int nilfs_ioctl_getversion(struct inode *inode, void __user *argp)
  * given checkpoint between checkpoint and snapshot state. This ioctl
  * is used in chcp and mkcp utilities.
  *
- * Return Value: On success, 0 is returned and mode of a checkpoint is
- * changed. On error, one of the following negative error codes
- * is returned.
- *
- * %-EPERM - Operation not permitted.
- *
- * %-EFAULT - Failure during checkpoint mode changing.
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * %-EFAULT	- Failure during checkpoint mode changing.
+ * %-EPERM	- Operation not permitted.
  */
 static int nilfs_ioctl_change_cpmode(struct inode *inode, struct file *filp,
 				     unsigned int cmd, void __user *argp)
@@ -230,13 +224,10 @@ static int nilfs_ioctl_change_cpmode(struct inode *inode, struct file *filp,
  * checkpoint from NILFS2 file system. This ioctl is used in rmcp
  * utility.
  *
- * Return Value: On success, 0 is returned and a checkpoint is
- * removed. On error, one of the following negative error codes
- * is returned.
- *
- * %-EPERM - Operation not permitted.
- *
- * %-EFAULT - Failure during checkpoint removing.
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * %-EFAULT	- Failure during checkpoint removing.
+ * %-EPERM	- Operation not permitted.
  */
 static int
 nilfs_ioctl_delete_checkpoint(struct inode *inode, struct file *filp,
@@ -282,7 +273,7 @@ nilfs_ioctl_delete_checkpoint(struct inode *inode, struct file *filp,
  * requested checkpoints. The NILFS_IOCTL_GET_CPINFO ioctl is used in
  * lscp utility and by nilfs_cleanerd daemon.
  *
- * Return value: count of nilfs_cpinfo structures in output buffer.
+ * Return: Count of nilfs_cpinfo structures in output buffer.
  */
 static ssize_t
 nilfs_ioctl_do_get_cpinfo(struct the_nilfs *nilfs, __u64 *posp, int flags,
@@ -306,17 +297,14 @@ nilfs_ioctl_do_get_cpinfo(struct the_nilfs *nilfs, __u64 *posp, int flags,
  *
  * Description: nilfs_ioctl_get_cpstat() returns information about checkpoints.
  * The NILFS_IOCTL_GET_CPSTAT ioctl is used by lscp, rmcp utilities
- * and by nilfs_cleanerd daemon.
- *
- * Return Value: On success, 0 is returned, and checkpoints information is
- * copied into userspace pointer @argp. On error, one of the following
- * negative error codes is returned.
- *
- * %-EIO - I/O error.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-EFAULT - Failure during getting checkpoints statistics.
+ * and by nilfs_cleanerd daemon.  The checkpoint statistics are copied to
+ * the userspace memory pointed to by @argp.
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EFAULT	- Failure during getting checkpoints statistics.
+ * * %-EIO	- I/O error.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_get_cpstat(struct inode *inode, struct file *filp,
 				  unsigned int cmd, void __user *argp)
@@ -349,7 +337,8 @@ static int nilfs_ioctl_get_cpstat(struct inode *inode, struct file *filp,
  * info about requested segments. The NILFS_IOCTL_GET_SUINFO ioctl is used
  * in lssu, nilfs_resize utilities and by nilfs_cleanerd daemon.
  *
- * Return value: count of nilfs_suinfo structures in output buffer.
+ * Return: Count of nilfs_suinfo structures in output buffer on success,
+ * or a negative error code on failure.
  */
 static ssize_t
 nilfs_ioctl_do_get_suinfo(struct the_nilfs *nilfs, __u64 *posp, int flags,
@@ -373,17 +362,14 @@ nilfs_ioctl_do_get_suinfo(struct the_nilfs *nilfs, __u64 *posp, int flags,
  *
  * Description: nilfs_ioctl_get_sustat() returns segment usage statistics.
  * The NILFS_IOCTL_GET_SUSTAT ioctl is used in lssu, nilfs_resize utilities
- * and by nilfs_cleanerd daemon.
- *
- * Return Value: On success, 0 is returned, and segment usage information is
- * copied into userspace pointer @argp. On error, one of the following
- * negative error codes is returned.
- *
- * %-EIO - I/O error.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-EFAULT - Failure during getting segment usage statistics.
+ * and by nilfs_cleanerd daemon.  The requested segment usage information is
+ * copied to the userspace memory pointed to by @argp.
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EFAULT	- Failure during getting segment usage statistics.
+ * * %-EIO	- I/O error.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_get_sustat(struct inode *inode, struct file *filp,
 				  unsigned int cmd, void __user *argp)
@@ -416,7 +402,8 @@ static int nilfs_ioctl_get_sustat(struct inode *inode, struct file *filp,
  * on virtual block addresses. The NILFS_IOCTL_GET_VINFO ioctl is used
  * by nilfs_cleanerd daemon.
  *
- * Return value: count of nilfs_vinfo structures in output buffer.
+ * Return: Count of nilfs_vinfo structures in output buffer on success, or
+ * a negative error code on failure.
  */
 static ssize_t
 nilfs_ioctl_do_get_vinfo(struct the_nilfs *nilfs, __u64 *posp, int flags,
@@ -443,7 +430,8 @@ nilfs_ioctl_do_get_vinfo(struct the_nilfs *nilfs, __u64 *posp, int flags,
  * about descriptors of disk block numbers. The NILFS_IOCTL_GET_BDESCS ioctl
  * is used by nilfs_cleanerd daemon.
  *
- * Return value: count of nilfs_bdescs structures in output buffer.
+ * Return: Count of nilfs_bdescs structures in output buffer on success, or
+ * a negative error code on failure.
  */
 static ssize_t
 nilfs_ioctl_do_get_bdescs(struct the_nilfs *nilfs, __u64 *posp, int flags,
@@ -480,19 +468,15 @@ nilfs_ioctl_do_get_bdescs(struct the_nilfs *nilfs, __u64 *posp, int flags,
  *
  * Description: nilfs_ioctl_do_get_bdescs() function returns information
  * about descriptors of disk block numbers. The NILFS_IOCTL_GET_BDESCS ioctl
- * is used by nilfs_cleanerd daemon.
- *
- * Return Value: On success, 0 is returned, and disk block descriptors are
- * copied into userspace pointer @argp. On error, one of the following
- * negative error codes is returned.
- *
- * %-EINVAL - Invalid arguments from userspace.
- *
- * %-EIO - I/O error.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-EFAULT - Failure during getting disk block descriptors.
+ * is used by nilfs_cleanerd daemon.  If successful, disk block descriptors
+ * are copied to userspace pointer @argp.
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EFAULT	- Failure during getting disk block descriptors.
+ * * %-EINVAL	- Invalid arguments from userspace.
+ * * %-EIO	- I/O error.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_get_bdescs(struct inode *inode, struct file *filp,
 				  unsigned int cmd, void __user *argp)
@@ -526,16 +510,12 @@ static int nilfs_ioctl_get_bdescs(struct inode *inode, struct file *filp,
  * Description: nilfs_ioctl_move_inode_block() function registers data/node
  * buffer in the GC pagecache and submit read request.
  *
- * Return Value: On success, 0 is returned. On error, one of the following
- * negative error codes is returned.
- *
- * %-EIO - I/O error.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-ENOENT - Requested block doesn't exist.
- *
- * %-EEXIST - Blocks conflict is detected.
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EEXIST	- Block conflict detected.
+ * * %-EIO	- I/O error.
+ * * %-ENOENT	- Requested block doesn't exist.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_move_inode_block(struct inode *inode,
 					struct nilfs_vdesc *vdesc,
@@ -590,8 +570,8 @@ static int nilfs_ioctl_move_inode_block(struct inode *inode,
  * blocks that garbage collector specified with the array of nilfs_vdesc
  * structures and stores them into page caches of GC inodes.
  *
- * Return Value: Number of processed nilfs_vdesc structures or
- * error code, otherwise.
+ * Return: Number of processed nilfs_vdesc structures on success, or
+ * a negative error code on failure.
  */
 static int nilfs_ioctl_move_blocks(struct super_block *sb,
 				   struct nilfs_argv *argv, void *buf)
@@ -668,14 +648,11 @@ static int nilfs_ioctl_move_blocks(struct super_block *sb,
  * in the period from p_start to p_end, excluding p_end itself. The checkpoints
  * which have been already deleted are ignored.
  *
- * Return Value: Number of processed nilfs_period structures or
- * error code, otherwise.
- *
- * %-EIO - I/O error.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-EINVAL - invalid checkpoints.
+ * Return: Number of processed nilfs_period structures on success, or one of
+ * the following negative error codes on failure:
+ * * %-EINVAL	- invalid checkpoints.
+ * * %-EIO	- I/O error.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_delete_checkpoints(struct the_nilfs *nilfs,
 					  struct nilfs_argv *argv, void *buf)
@@ -703,14 +680,11 @@ static int nilfs_ioctl_delete_checkpoints(struct the_nilfs *nilfs,
  * Description: nilfs_ioctl_free_vblocknrs() function frees
  * the virtual block numbers specified by @buf and @argv->v_nmembs.
  *
- * Return Value: Number of processed virtual block numbers or
- * error code, otherwise.
- *
- * %-EIO - I/O error.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-ENOENT - The virtual block number have not been allocated.
+ * Return: Number of processed virtual block numbers on success, or one of the
+ * following negative error codes on failure:
+ * * %-EIO	- I/O error.
+ * * %-ENOENT	- Unallocated virtual block number.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_free_vblocknrs(struct the_nilfs *nilfs,
 				      struct nilfs_argv *argv, void *buf)
@@ -732,14 +706,11 @@ static int nilfs_ioctl_free_vblocknrs(struct the_nilfs *nilfs,
  * Description: nilfs_ioctl_mark_blocks_dirty() function marks
  * metadata file or data blocks as dirty.
  *
- * Return Value: Number of processed block descriptors or
- * error code, otherwise.
- *
- * %-ENOMEM - Insufficient memory available.
- *
- * %-EIO - I/O error
- *
- * %-ENOENT - the specified block does not exist (hole block)
+ * Return: Number of processed block descriptors on success, or one of the
+ * following negative error codes on failure:
+ * * %-EIO	- I/O error.
+ * * %-ENOENT	- Non-existent block (hole block).
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_mark_blocks_dirty(struct the_nilfs *nilfs,
 					 struct nilfs_argv *argv, void *buf)
@@ -844,7 +815,7 @@ int nilfs_ioctl_prepare_clean_segments(struct the_nilfs *nilfs,
  * from userspace. The NILFS_IOCTL_CLEAN_SEGMENTS ioctl is used by
  * nilfs_cleanerd daemon.
  *
- * Return Value: On success, 0 is returned or error code, otherwise.
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
 				      unsigned int cmd, void __user *argp)
@@ -970,20 +941,14 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
  * and metadata are written out to the device when it successfully
  * returned.
  *
- * Return Value: On success, 0 is retured. On errors, one of the following
- * negative error code is returned.
- *
- * %-EROFS - Read only filesystem.
- *
- * %-EIO - I/O error
- *
- * %-ENOSPC - No space left on device (only in a panic state).
- *
- * %-ERESTARTSYS - Interrupted.
- *
- * %-ENOMEM - Insufficient memory available.
- *
- * %-EFAULT - Failure during execution of requested operation.
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EFAULT		- Failure during execution of requested operation.
+ * * %-EIO		- I/O error.
+ * * %-ENOMEM		- Insufficient memory available.
+ * * %-ENOSPC		- No space left on device (only in a panic state).
+ * * %-ERESTARTSYS	- Interrupted.
+ * * %-EROFS		- Read only filesystem.
  */
 static int nilfs_ioctl_sync(struct inode *inode, struct file *filp,
 			    unsigned int cmd, void __user *argp)
@@ -1017,7 +982,7 @@ static int nilfs_ioctl_sync(struct inode *inode, struct file *filp,
  * @filp: file object
  * @argp: pointer on argument from userspace
  *
- * Return Value: On success, 0 is returned or error code, otherwise.
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_ioctl_resize(struct inode *inode, struct file *filp,
 			      void __user *argp)
@@ -1053,7 +1018,7 @@ static int nilfs_ioctl_resize(struct inode *inode, struct file *filp,
  * checks the arguments from userspace and calls nilfs_sufile_trim_fs, which
  * performs the actual trim operation.
  *
- * Return Value: On success, 0 is returned or negative error code, otherwise.
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_ioctl_trim_fs(struct inode *inode, void __user *argp)
 {
@@ -1095,7 +1060,7 @@ static int nilfs_ioctl_trim_fs(struct inode *inode, void __user *argp)
  * of segments in bytes and upper limit of segments in bytes.
  * The NILFS_IOCTL_SET_ALLOC_RANGE is used by nilfs_resize utility.
  *
- * Return Value: On success, 0 is returned or error code, otherwise.
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_ioctl_set_alloc_range(struct inode *inode, void __user *argp)
 {
@@ -1146,17 +1111,15 @@ static int nilfs_ioctl_set_alloc_range(struct inode *inode, void __user *argp)
  * @dofunc: concrete function of getting metadata info
  *
  * Description: nilfs_ioctl_get_info() gets metadata info by means of
- * calling dofunc() function.
- *
- * Return Value: On success, 0 is returned and requested metadata info
- * is copied into userspace. On error, one of the following
- * negative error codes is returned.
- *
- * %-EINVAL - Invalid arguments from userspace.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-EFAULT - Failure during execution of requested operation.
+ * calling dofunc() function.  The requested metadata information is copied
+ * to userspace memory @argp.
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EFAULT	- Failure during execution of requested operation.
+ * * %-EINVAL	- Invalid arguments from userspace.
+ * * %-EIO	- I/O error.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_get_info(struct inode *inode, struct file *filp,
 				unsigned int cmd, void __user *argp,
@@ -1196,18 +1159,14 @@ static int nilfs_ioctl_get_info(struct inode *inode, struct file *filp,
  * encapsulated in nilfs_argv and updates the segment usage info
  * according to the flags in nilfs_suinfo_update.
  *
- * Return Value: On success, 0 is returned. On error, one of the
- * following negative error codes is returned.
- *
- * %-EPERM - Not enough permissions
- *
- * %-EFAULT - Error copying input data
- *
- * %-EIO - I/O error.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-EINVAL - Invalid values in input (segment number, flags or nblocks)
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EEXIST	- Block conflict detected.
+ * * %-EFAULT	- Error copying input data.
+ * * %-EINVAL	- Invalid values in input (segment number, flags or nblocks).
+ * * %-EIO	- I/O error.
+ * * %-ENOMEM	- Insufficient memory available.
+ * * %-EPERM	- Not enough permissions.
  */
 static int nilfs_ioctl_set_suinfo(struct inode *inode, struct file *filp,
 				unsigned int cmd, void __user *argp)
-- 
2.53.0

