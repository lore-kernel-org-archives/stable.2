Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633264;
	b=Zp5/fqjGDjOyXddAeZ5BaHLoKRzzHTju4KwPddkSg+1ypYULI4Wy7ZAXPmCF89GzH4zq
	 /X3ZfJPJgti73ceq71gW6Ej2nP9tQbpjcBCyoo4cbhqwRYOubiM8Jw0mzPWCXg/ZDuC/K
	 H/r4ouhrvDsQCG4qe24IiDpCoMNZdjc2AYNuK1S8329mW8GaNCyC5BDTuCkTyxo9N1KlX
	 mzRVmI0EGMdBeJy+7o+pSAE3HoU8+N8TLP4fll8popnMoXWLzgpCCRqYVNjtAofz3Voyk
	 qmcPY7pJaC1ntjhBfa1jbwtpeOUO7P1w/fYv6gLl61LxGwQS9T8qOX3DgmvDM0i9Nvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633264;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RCLREU3ug6s0nq3vvgZoAVXVzQ57l3I6oW/fEoaBMow=;
	b=3SEDMVve+xOzzw+n9V85yX67os1YM5kWNbZ4oBPM7MM0nO+DpvbQoSNrj0Dzx7bw37BV
	 /RoXADu1Ux2pVgzLaNAAXx+bzR2U5UUDwQuAzTkZAEphFd8D93l38ZJClqBUSB7isWBKE
	 iWHts5qxV1JdyQqoL0pxvPIEgTGGc1sJw9ZL2DyCcK3NvjAaoZRbc5o2WKTvWV6gzLYMU
	 SQPiKduifKaddh33wGX4aXjBmTKBDnfJrsNRq0Bc2YrtRnPf4UEHyJ58i9TWT7Hy0iE3K
	 7eK9wOXMefyfkmKp55WRAUaeR6GQ5bHkjqQqOn4vsg4NUrLR6MAUHP5davsc4o2WHJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kUhxPalx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBE4609C7E5
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=kUhxPalx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A701F00A1B;
	Mon,  2 Nov 2026 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793633263;
	bh=RCLREU3ug6s0nq3vvgZoAVXVzQ57l3I6oW/fEoaBMow=;
	h=Subject:To:Cc:From:Date;
	b=kUhxPalxzD/hHe08wSGoYf0/1h1WOwNlor/jB+juATdY+FZG8Ky4xfY8FPK6+p4EO
	 lz7yZPangqneNzfz99gigX0tduPcnW02g3Iop575bLEijk/mqBvJcOEp/dLL1Igu3P
	 z0PhUJOgtqgO4ssVUeV+W6YINL513lvnOpgx0j8E=
Subject: FAILED: patch "[PATCH] ksmbd: serialize directory emptiness checks with readdir" failed to apply to 6.12-stable tree
To: d3bugee@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Nov 2026 16:27:41 +0100
Message-ID: <2026110241-arrest-granny-ae4b@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7220980b2423d06a0604516129bfa4cec8a697ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110241-arrest-granny-ae4b@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7220980b2423d06a0604516129bfa4cec8a697ae Mon Sep 17 00:00:00 2001
From: Yongjun Gwon <d3bugee@gmail.com>
Date: Fri, 23 Oct 2026 02:38:32 +0900
Subject: [PATCH] ksmbd: serialize directory emptiness checks with readdir

SMB2 QUERY_DIRECTORY holds fp->readdir_lock while it calls iterate_dir()
on fp->filp. An SMB2 SET_INFO request with FILE_DISPOSITION_INFORMATION
can resolve the same FileId and call ksmbd_vfs_empty_dir() on the same
filp without that lock.

iterate_dir()'s inode read lock permits concurrent readers and does not
serialize per-file iterator state. ext4 stores its dx readdir cursor and
fname RB tree in file->private_data. Concurrent reset or refill can
therefore free a fname node while the other worker still traverses it or
retains its RB-tree link, resulting in use-after-free accesses.

An authenticated SMB client with list and delete rights on a directory in
a writable KSMBD share backed by ext4 can trigger this when the directory
takes the dx readdir path. The client overlaps an SMB2 QUERY_DIRECTORY
request with an SMB2 SET_INFO request carrying FILE_DISPOSITION_INFORMATION
on one live FileId.

In one x86_64 SMP KASAN multi-shot guest using ksmbd-for-next at
171df27077fb, the unmodified kernel reported a cross-worker use-after-free
before a panic. The first report's access and free stacks show the two
request paths directly (trimmed):

  BUG: KASAN: slab-use-after-free in ext4_htree_store_dirent+0x488/0x550
  Read of size 8 by task kworker/2:0/29
  Workqueue: ksmbd-io handle_ksmbd_work
  Call Trace:
   ext4_htree_store_dirent+0x488/0x550
   htree_dirblock_to_tree+0x535/0x990
   ext4_htree_fill_tree+0x319/0xba0
   ext4_readdir+0x175a/0x2f40
   iterate_dir+0x1b6/0x630
   smb2_query_dir+0x1003/0x1cc0

  Freed by task 279:
   free_rb_tree_fname+0x67/0xc0
   ext4_readdir+0x13a9/0x2f40
   iterate_dir+0x1b6/0x630
   ksmbd_vfs_empty_dir+0xa2/0x100
   smb2_set_info+0x2ffa/0x45d0

Take fp->readdir_lock across the entire emptiness check. This places both
iterators over that handle's filp in the same lock domain while
preserving the disposition status handling. The exact code change
completed a warning-free x86_64 KASAN bzImage build. Tracing three request
pairs showed that the two iterate_dir() calls no longer overlapped and the
expected statuses were preserved. A further 1,600 reproducer iterations
completed with expected statuses and no KASAN report, Oops, or panic.

The reproducer and complete guest configuration are available privately
to maintainers on request.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Yongjun Gwon <d3bugee@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index da82d80c222a..f5fe3cf8ba32 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8918,6 +8918,7 @@ static int set_file_disposition_info(struct ksmbd_work *work,
 				     struct smb2_file_disposition_info *file_info)
 {
 	struct inode *inode;
+	int err;
 
 	if (!(fp->daccess & FILE_DELETE_LE)) {
 		pr_err("no right to delete : 0x%x\n", fp->daccess);
@@ -8932,9 +8933,13 @@ static int set_file_disposition_info(struct ksmbd_work *work,
 		if (ksmbd_has_stream_without_delete_share(fp))
 			return -ESHARE;
 
-		if (S_ISDIR(inode->i_mode) && !ksmbd_stream_fd(fp) &&
-		    ksmbd_vfs_empty_dir(fp) == -ENOTEMPTY)
-			return -EBUSY;
+		if (S_ISDIR(inode->i_mode) && !ksmbd_stream_fd(fp)) {
+			mutex_lock(&fp->readdir_lock);
+			err = ksmbd_vfs_empty_dir(fp);
+			mutex_unlock(&fp->readdir_lock);
+			if (err == -ENOTEMPTY)
+				return -EBUSY;
+		}
 		smb_break_all_levII_oplock_for_delete(work, fp);
 		ksmbd_fd_set_delete_pending(fp);
 	} else {

