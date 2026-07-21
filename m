Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4342538C41B
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644887; cv=none; b=FTlPxfhKnscpInto1D3oqfiNrQXJZHnrw0dxw9hGjfvY/b6gm20VncipzM3Pnjh8T1iqhV6+tZA/zAigqTEjUgKhl3y+4fkewtdH50KcvRfWyNCPkcFJeI46ogV2lPUxcQ2293GNlgicPRR3rbpDTcq8yK0itzOgbgW+Br0ARTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644887; c=relaxed/simple;
	bh=tXeV/i+rA2KEsUu02/SnfAKYgDFRB7WUwqBxXRRRb1E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=blYsAS3HVS+OJQZw+zWFZZz3LiD2l07dCCjg5bg3ID5HzNqG+/r1Nm79CzR/9el+kOJ9/fRZe/qG69nyXpxKo7qZyT0EGs0eHUqEy3nWILPVAzncIPCZt1xYhckNnZ41EhdIsHxsnOIcwjtx6hN8I8fsQmHFvMgGXGukhyD6oUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kR7ryDg9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kR7ryDg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611EE1F000E9;
	Tue, 21 Jul 2026 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784644885;
	bh=tSH1ntLrGzWE4qrjZv7nE/CQJt6XU3T++AxWL4DVt8M=;
	h=Subject:To:Cc:From:Date;
	b=kR7ryDg9AFZliH/ySm0rhx/07MhplPEbf3g+pigSNzhHC4ak+mhSHTFmPNcYzEAkf
	 aLmFKon2563h6ZuS+yJiaJVht0V63kMhTIHqjSgpd+KpCJRZSkjdRytgFQMqZvd3Y7
	 DVsFDqhryZM1/fbGQqDYaapXoSy8GLEHxrVJVeAQ=
Subject: FAILED: patch "[PATCH] afs: Fix lack of locking around modifications of" failed to apply to 6.12-stable tree
To: dhowells@redhat.com,brauner@kernel.org,marc.dionne@auristor.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 16:41:16 +0200
Message-ID: <2026072116-feeble-cusp-7fff@gregkh>
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
git cherry-pick -x 55e841836c6f4646490f7b0347192b7a92d431ba
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072116-feeble-cusp-7fff@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 55e841836c6f4646490f7b0347192b7a92d431ba Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Mon, 22 Jun 2026 10:08:52 +0100
Subject: [PATCH] afs: Fix lack of locking around modifications of
 net->cells_dyn_ino

Fix the lack of locking around modifications of net->cells_dyn_ino by
taking net->cells_lock exclusively.  This also requires to cell to be
removed from net->cells_dyn_ino in afs_destroy_cell_work() rather than in
afs_cell_destroy() as the latter runs in RCU cleanup context and sleeping
locks cannot be taken there.

Fixes: 1d0b929fc070 ("afs: Change dynroot to create contents on demand")
Closes: https://sashiko.dev/#/patchset/20260618074903.2374756-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/20260622090856.2746629-19-dhowells@redhat.com
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index fbb8a43aa7cd..9d8937ae24e2 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -205,8 +205,10 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	cell->dns_source = vllist->source;
 	cell->dns_status = vllist->status;
 	smp_store_release(&cell->dns_lookup_count, 1); /* vs source/status */
+	down_write(&net->cells_lock);
 	ret = idr_alloc_cyclic(&net->cells_dyn_ino, cell,
 			       2, INT_MAX / 2, GFP_KERNEL);
+	up_write(&net->cells_lock);
 	if (ret < 0)
 		goto error;
 	atomic_inc(&net->cells_outstanding);
@@ -579,7 +581,6 @@ static void afs_cell_destroy(struct rcu_head *rcu)
 	afs_put_vlserverlist(net, rcu_access_pointer(cell->vl_servers));
 	afs_unuse_cell(cell->alias_of, afs_cell_trace_unuse_alias);
 	key_put(cell->anonymous_key);
-	idr_remove(&net->cells_dyn_ino, cell->dynroot_ino);
 	kfree(cell->name - 1);
 	kfree(cell);
 
@@ -594,6 +595,11 @@ static void afs_destroy_cell_work(struct work_struct *work)
 	afs_see_cell(cell, afs_cell_trace_destroy);
 	timer_delete_sync(&cell->management_timer);
 	cancel_work_sync(&cell->manager);
+
+	down_write(&cell->net->cells_lock);
+	idr_remove(&cell->net->cells_dyn_ino, cell->dynroot_ino);
+	up_write(&cell->net->cells_lock);
+
 	call_rcu(&cell->rcu, afs_cell_destroy);
 }
 
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 1d5e33bc7502..6e3c8c691ba9 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -278,7 +278,7 @@ static struct dentry *afs_lookup_atcell(struct inode *dir, struct dentry *dentry
 }
 
 /*
- * Transcribe the cell database into readdir content under the RCU read lock.
+ * Transcribe the cell database into readdir content under net->cells_lock.
  * Each cell produces two entries, one prefixed with a dot and one not.
  */
 static int afs_dynroot_readdir_cells(struct afs_net *net, struct dir_context *ctx)

