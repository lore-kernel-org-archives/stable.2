Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB24218845
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332841; cv=none; b=EV3wkhFs1x6kZ8TA7jH8gbP1IRWxRVhDg/ND/le0pcpGyTMb6RD44HjM2xy5zOGqj73QMVhRRSS2e+8eqxqPv4CxfekDeMA7FT/4a8bofcdNqbajuhDXgQcZdziDFH+i9CvUgLGNLTmBc29A5gCmORById2+wnzBjQlMSPvutwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332841; c=relaxed/simple;
	bh=UZTXWjK8x/NRhkKH1KVgZtnsF4WFF1H9MFbKhtDQ6Jg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ANrEaD/S9x8usHRUFGctW3sjkXPwCOQg3sLI0+RpWJaswwcTbQuiZtw378h2TGEdLIqyqZfNajc+n0NdJuWCsGBlcJ0bzrASzaOpfboBb2jUuQfpgYazOex3f779p+HVz5Ou1vRI3OY1eyefAu7Xjvqdl5uwizzUt2DvPP2Z2sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iRz5hz1m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iRz5hz1m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC171F00A3A;
	Wed, 29 Jul 2026 13:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785332840;
	bh=O+JXYcM040qIIJl+DsOt8jB7JGHxEhyeLiQrS+Q8T8s=;
	h=Subject:To:Cc:From:Date;
	b=iRz5hz1m51qzB9lveT1LqcQ8GA6m42udOR7CcqJyVH4VQVE5FWEMNFch2aE+FIbVK
	 azb997yB9HLlxnNBKgfp1xQVpZvHWeDisjbXmCrnbToFycHAPKrj63TsYO9VIK7Wlg
	 JwQz0fjDr+TDCjkaxVAHXR0/Rpqb1SfPrTqqNL8k=
Subject: FAILED: patch "[PATCH] ceph: avoid fs reclaim while using current->journal_info" failed to apply to 6.12-stable tree
To: max.kellermann@ionos.com,idryomov@gmail.com,slava@dubeyko.com,xiubo.li@clyso.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:46:57 +0200
Message-ID: <2026072957-lining-clip-c159@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 5b602344a49e039e792ce5a8923bcc61412ee134
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072957-lining-clip-c159@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5b602344a49e039e792ce5a8923bcc61412ee134 Mon Sep 17 00:00:00 2001
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 22 Jul 2026 13:49:31 +0200
Subject: [PATCH] ceph: avoid fs reclaim while using current->journal_info

handle_reply() stores a `ceph_mds_request` pointer in
`current->journal_info` while filling the inode and dentry cache from
an MDS reply.

An allocation in this section can enter direct reclaim and prune
dentries from another filesystem.  If this dirties an ext4 inode, ext4
starts a JBD2 transaction.  JBD2 interprets the Ceph request in
`current->journal_info` as a journal handle and dereferences the
request's `r_tid` as `h_transaction`, causing a kernel crash, e.g.:

 Unable to handle kernel paging request at virtual address 00000000077b4818
 [...]
 Internal error: Oops: 0000000096000004 [#1]  SMP
 Modules linked in:
 CPU: 6 UID: 0 PID: 2699135 Comm: kworker/6:3 Tainted: G        W           6.18.38-i3 #1113 NONE
 [...]
 Workqueue: ceph-msgr ceph_con_workfn
 pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : jbd2__journal_start+0x2c/0x208
 lr : __ext4_journal_start_sb+0x100/0x178
 [...]
 Call trace:
  jbd2__journal_start+0x2c/0x208 (P)
  __ext4_journal_start_sb+0x100/0x178
  ext4_dirty_inode+0x3c/0x90
  __mark_inode_dirty+0x58/0x400
  iput.part.0+0x2b0/0x370
  iput+0x18/0x30
  dentry_unlink_inode+0xc0/0x158
  __dentry_kill+0x80/0x250
  shrink_dentry_list+0x90/0x130
  prune_dcache_sb+0x60/0x98
  super_cache_scan+0xe8/0x190
  do_shrink_slab+0x174/0x388
  shrink_slab+0xd8/0x4c0
  shrink_node+0x31c/0x908
  do_try_to_free_pages+0xd0/0x508
  try_to_free_pages+0x11c/0x238
  __alloc_frozen_pages_noprof+0x4d0/0xdd0
  __folio_alloc_noprof+0x18/0x70
  __filemap_get_folio+0x248/0x440
  ceph_readdir_prepopulate+0x570/0x9e8
  mds_dispatch+0x1424/0x1ba0
  ceph_con_process_message+0x74/0xa0
  ceph_con_v1_try_read+0x3a0/0x1510
  ceph_con_workfn+0x260/0x460

Enter a scoped NOFS allocation context and leave it after clearing
`journal_info`.  This prevents filesystem reclaim from recursing into
another filesystem while the field contains Ceph-private data.

Cc: stable@vger.kernel.org
Fixes: 315f24088048 ("ceph: fix security xattr deadlock")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Reviewed-by: Xiubo Li <xiubo.li@clyso.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 853bf698b356..3c692ad02c85 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
+#include <linux/sched/mm.h>
 #include <linux/delay.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -4015,6 +4016,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 	struct ceph_mds_reply_head *head = msg->front.iov_base;
 	struct ceph_mds_reply_info_parsed *rinfo;  /* parsed reply info */
 	struct ceph_snap_realm *realm;
+	unsigned int nofs_flags;
 	u64 tid;
 	int err, result;
 	int mds = session->s_mds;
@@ -4158,6 +4160,14 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 
 	/* insert trace into our cache */
 	mutex_lock(&req->r_fill_mutex);
+
+	/* disable fs reclaim while we are using current->journal_info
+	 * for our own purposes, or else shrinkers of other
+	 * filesystems might dereference this pointer as a different
+	 * type
+	 */
+	nofs_flags = memalloc_nofs_save();
+
 	current->journal_info = req;
 	err = ceph_fill_trace(mdsc->fsc->sb, req);
 	if (err == 0) {
@@ -4166,6 +4176,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			err = ceph_readdir_prepopulate(req, req->r_session);
 	}
 	current->journal_info = NULL;
+	memalloc_nofs_restore(nofs_flags);
 	mutex_unlock(&req->r_fill_mutex);
 
 	up_read(&mdsc->snap_rwsem);

