Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633262;
	b=pexiqSVayHGwPaG6bqPrvydIp0Oaj2+vB5Of7YCZlvjic1qRO6TnX032RwjNgOLcwWQx
	 STuQEdz/cpjjOWAJ0B2Adzfjg4dpMcZM+xL3pLHMzAOyyYEbbju14omUTdtoSIe2LqsNo
	 M8dUeNRZnM9Fkr0qfUIXM6s8zr/QQGL4IpCVVtvcQEgcnSldJukIvYcXlI0J920YQ+7G6
	 4yGQRaXtWo+H+KsZrEli8MvNeIf7oJ8KGdyxWKNto1qGIg7dY/vrGsXMNQQ0gCwv0NBi+
	 bCMQa5gdmpKz+oG+40axAaqNo705Dx0D9xFe6mKOMzIRIgoqX80lQVZL6v44Tdt4qSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633262;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=701+TK7BupjY3H7pv04Jm3iJ3F83deu5Zm1R1KEPq/4=;
	b=EkFUvDXAPQRe+I8K73EmQkDRpzUbOgPeDPsKSU6vRBhSWeyOM30NhRCaAa/CqdR0pH4u
	 M2aDSAB4X6ifpT4hVSnFUc72dAUutsMrWSGUclRmkrFcxBrFaskph54ATKZA3cU3aHxj7
	 MgZBaBA8I3zoqLJKU8jvXcCyP9E0Z7VYeuaZM9ZJiMSr0kkS9kKFBTheBRM6YZIatEypY
	 77XPtY/4E12xJdwoafvWkjtKiyEHDrdbwwvoWi9O2MNlIyDsp79LyDa3KY/iJoeTJuz3d
	 XYDU9liD0v14azCb+l5BQSTIhLyrHM4vtiTAnGa5TAaWOh98mMyIUnqwdnlNEay3tKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=A3h8FDyu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F61B6083620
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=A3h8FDyu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89ACD1F00A1B;
	Mon,  2 Nov 2026 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793633261;
	bh=701+TK7BupjY3H7pv04Jm3iJ3F83deu5Zm1R1KEPq/4=;
	h=Subject:To:Cc:From:Date;
	b=A3h8FDyuBkd9f+GB7RKpZqyKsC8j1OlnJsi37l1y/dQhyoGQ5Jw88U3ZDQXhp7jK5
	 lQJ2JJYW31wkSc0ixj8a9XmLXHFibjom3qTdnCNdHanQRnVR0SAhe7w5kI0kxk97K4
	 SZo6C8Bv5z9xmGdV8E3KzHQ/KjIaPmz/F9sAsvHI=
Subject: FAILED: patch "[PATCH] ksmbd: serialize directory emptiness checks with readdir" failed to apply to 6.18-stable tree
To: d3bugee@gmail.com,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Nov 2026 16:27:39 +0100
Message-ID: <2026110239-facial-handiness-1e99@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7220980b2423d06a0604516129bfa4cec8a697ae
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110239-facial-handiness-1e99@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

