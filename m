Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633271;
	b=c/7WeNoPD3NNzUrUrQZ//OEzkCzTuWuC+BSK28VNnZQDMcfQ9l/GIsZlydEW/Hwe59x6
	 I+aHaApSCfpJho0fEWuWAo1WF1QajoiFwIhPUzrd3dVNUogiUWZK4aaZKlOEhkQLeOimt
	 FujrvPot2BNbOeuEphUUmGpachpFHrQxz+eQV4xT58rxdwRHh0QXboHK9olI6+uv3NjYl
	 ZmTchyWa7faeElaPWzVwklx69+2nlC5uQpdgbVf1g2x+cWgXWx/V52/5RzlJKDacEoeYP
	 Ky6vs17NWsAxI1HcPHzlrbtRNYjlvHBJDfzs4Vx1ZPmkMHOCXwXr/Ck4BHp89KjiUNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633271;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vMxVdkmrNwG1jbRysNcsfpJbb/GnrhA0xuWACCMqaZE=;
	b=BNNZ28Xl5ojVRCjloVBYv7S7hTsHLLCBG1gSdMWsGjp2q9mGuNJV2OISosXj+h2/qzzL
	 C1S51nGWYJzKhOcePu7MNTQ/1PadvWhh6DHcgBFg2iR91gZlwKAhmAqZGLki1OJbFKyI0
	 KpP31sC7NnYdZ2Tj/2c4Cnv19UZG20OrsBv3fK3leHq3kV8xXAc2SdCkoOSaxC8/4gXEg
	 JJvLvV1KiHf8wEMt+v3L7TnmGmJD3JDpXhJUWNgcwU3LnH3bog9w5DCKefTq161lhPohY
	 zp46pbA4Oxpti++kGCMgtb3v/nVtXG7hKyMzpkyCmNktUIKBiDspsjrFoP+/ifT/24Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=A+sXngxi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16296085546
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=A+sXngxi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659881F00A16;
	Mon,  2 Nov 2026 15:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793633270;
	bh=vMxVdkmrNwG1jbRysNcsfpJbb/GnrhA0xuWACCMqaZE=;
	h=Subject:To:Cc:From:Date;
	b=A+sXngxilGpz0rhfl0fu4TJWt9Q6w0R4C9v6ctCEFROKQTBHqKswcI9DawjBpjHF2
	 +/MlqC0RYOiokjwtj3eJ8kzprN8qAjV2W+y+Dr4ByQvJ/GBT5rUi665xUJFrH7oVeA
	 gV1DcyeZ0VVDNC9ePWKErrmqUbRWQznhkL+0QuMU=
Subject: FAILED: patch "[PATCH] ksmbd: serialize directory emptiness checks with readdir" failed to apply to 6.1-stable tree
To: d3bugee@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Nov 2026 16:27:43 +0100
Message-ID: <2026110243-apostle-blitz-3a1e@gregkh>
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7220980b2423d06a0604516129bfa4cec8a697ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110243-apostle-blitz-3a1e@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

