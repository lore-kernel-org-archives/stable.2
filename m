Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FABC3FBB77
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644898; cv=none; b=gH01kHSCxstqJEb5OPWZfmxZ5vqIyAlOWLPibeEvQaXnc9XjflGQvNuqynOtwjBbjilMhywdKehTudjhvOK/uslIL+zC2fOhuZvSnI/abvdFfeJEyWfAlqApUX/q+4VpMJwPcuHz0BKg9TFmBKYk6zcrWKssRYGU9orTDK5pvpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644898; c=relaxed/simple;
	bh=Z2m80WvfGKsxAwDlp1phdArJ7xiisAJkuiPYA7mAvng=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E22fnZlqcYAO6bmnXPlG0nGHN6KM5nPKgWtiqm3cYYhFI0RQ8dK+IqkeMNuvyn3aX46q0hS728pVVtPhqq5l2utxjlBuJ9iKpmbLESEC9ig0/+nA5r+d5YRGI2OmC/9j3GOT7rF9EeYwtrrNUMQDbfVIYIFWfiwybUR9fwTESJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bZ6Z7ROn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bZ6Z7ROn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C851F00A3A;
	Tue, 21 Jul 2026 14:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784644897;
	bh=5FA8V0z5hCLctj9+fWDMgI9H8Ev5783eZ3ScJl6TQaA=;
	h=Subject:To:Cc:From:Date;
	b=bZ6Z7ROnRvGKbFyPRVlAZPDOopBoV2cHSU4GiVVUzKhtzq6lqzfKcrAMobiDTJAsf
	 yeRTijkGt5XxKAyqaZLIB+Nw6RfdtVJNwdVA66724tuqq0uLns2zRoa+6R8Nuuv3XZ
	 9d2vBHLo672Spwes6Bbj2axDPbo/s7UHvAg24u94=
Subject: FAILED: patch "[PATCH] afs: Fix premature cell exposure through /afs" failed to apply to 6.12-stable tree
To: dhowells@redhat.com,brauner@kernel.org,marc.dionne@auristor.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 16:41:27 +0200
Message-ID: <2026072127-dress-overplay-421f@gregkh>
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
git cherry-pick -x 26f17ce6fa3f05cb5965790499c1839094260de4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072127-dress-overplay-421f@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26f17ce6fa3f05cb5965790499c1839094260de4 Mon Sep 17 00:00:00 2001
From: David Howells <dhowells@redhat.com>
Date: Mon, 22 Jun 2026 10:08:53 +0100
Subject: [PATCH] afs: Fix premature cell exposure through /afs

AFS cell records are prematurely exposured through the /afs dynamic root by
virtue of adding them immediately to the net->cells_dyn_ino IDR when the
cell is allocated rather than when it is added to the lookup tree.  This
allows a candidate record to be accessed, even if it's actually a duplicate
or not published yet.

Fix this by not adding the cell to cells_dyn_ino until it's confirmed
non-duplicate and is being published.  A flag is then used to record
whether it is added to the IDR to make removal from the IDR conditional.

Closes: https://sashiko.dev/#/patchset/20260618155141.2513212-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://patch.msgid.link/20260622090856.2746629-20-dhowells@redhat.com
Fixes: 1d0b929fc070 ("afs: Change dynroot to create contents on demand")
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/afs/cell.c b/fs/afs/cell.c
index 9d8937ae24e2..47a2645768d7 100644
--- a/fs/afs/cell.c
+++ b/fs/afs/cell.c
@@ -205,14 +205,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
 	cell->dns_source = vllist->source;
 	cell->dns_status = vllist->status;
 	smp_store_release(&cell->dns_lookup_count, 1); /* vs source/status */
-	down_write(&net->cells_lock);
-	ret = idr_alloc_cyclic(&net->cells_dyn_ino, cell,
-			       2, INT_MAX / 2, GFP_KERNEL);
-	up_write(&net->cells_lock);
-	if (ret < 0)
-		goto error;
 	atomic_inc(&net->cells_outstanding);
-	cell->dynroot_ino = ret;
 	cell->debug_id = atomic_inc_return(&cell_debug_id);
 
 	trace_afs_cell(cell->debug_id, 1, 0, afs_cell_trace_alloc);
@@ -306,6 +299,13 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 			goto cell_already_exists;
 	}
 
+	ret = idr_alloc_cyclic(&net->cells_dyn_ino, candidate,
+			       2, INT_MAX / 2, GFP_KERNEL);
+	if (ret < 0)
+		goto cant_alloc_ino;
+	candidate->dynroot_ino = ret;
+	set_bit(AFS_CELL_FL_HAVE_INO, &candidate->flags);
+
 	cell = candidate;
 	candidate = NULL;
 	afs_use_cell(cell, trace);
@@ -380,6 +380,11 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
 	_leave(" = %p [cell]", cell);
 	return cell;
 
+cant_alloc_ino:
+	up_write(&net->cells_lock);
+	afs_put_cell(candidate, afs_cell_trace_put_candidate);
+	goto error_noput;
+
 cell_already_exists:
 	_debug("cell exists");
 	cell = cursor;
@@ -596,9 +601,11 @@ static void afs_destroy_cell_work(struct work_struct *work)
 	timer_delete_sync(&cell->management_timer);
 	cancel_work_sync(&cell->manager);
 
-	down_write(&cell->net->cells_lock);
-	idr_remove(&cell->net->cells_dyn_ino, cell->dynroot_ino);
-	up_write(&cell->net->cells_lock);
+	if (test_bit(AFS_CELL_FL_HAVE_INO, &cell->flags)) {
+		down_write(&cell->net->cells_lock);
+		idr_remove(&cell->net->cells_dyn_ino, cell->dynroot_ino);
+		up_write(&cell->net->cells_lock);
+	}
 
 	call_rcu(&cell->rcu, afs_cell_destroy);
 }
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 785c646856d7..601f01e5c15f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -388,6 +388,7 @@ struct afs_cell {
 #define AFS_CELL_FL_NO_GC	0		/* The cell was added manually, don't auto-gc */
 #define AFS_CELL_FL_DO_LOOKUP	1		/* DNS lookup requested */
 #define AFS_CELL_FL_CHECK_ALIAS	2		/* Need to check for aliases */
+#define AFS_CELL_FL_HAVE_INO	3		/* Have dynroot_ino */
 	enum afs_cell_state	state;
 	short			error;
 	enum dns_record_source	dns_source:8;	/* Latest source of data from lookup */

