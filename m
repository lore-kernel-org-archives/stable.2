Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE9555295A
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874621; cv=none; b=CnefEUg7eZBNR3UdwAOgpSj1FjyiMf9PxWW8UNCsP/zV0YwjNWcuGS6RMoN+OwQ/wE7JpaJrCYRsUrC4Nei3xS9jd+2FKWAW2aTl92eConKKWl4XXj8aBG0fe3MolWZn5GILHMxE+a0cI8PM2J2RT1cZgv6njLNKoq2SR2RFcz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874621; c=relaxed/simple;
	bh=XbC6Euk2Qr+JnfgijuFbut6UIIywhSK8/DDgwRdstLI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C3Jnm4+hLlFYGtfST8WM7cWjgHFZjLXy28c6ECYsTFDiLUnEnuH9CRtzU3hDGddeyB1we7RHQ5BJJz95lLjXljw44gIpaOnhjDnVDA15sFBSDcUcRa8PRjIQLj7JkSUsDLJxgEek9crtuz+h0hbqYbcqEHkxr4r6WbXb+oevKww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882371F00A3D;
	Tue,  8 Sep 2026 13:36:52 +0000 (UTC)
Subject: FAILED: patch "[PATCH] btrfs: abort transaction before releasing tree_log_mutex on" failed to apply to 7.2-stable tree
To: loemra.dev@gmail.com,boris@bur.io,dsterba@suse.com,fdmanana@suse.com,jlayton@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 15:30:20 +0200
Message-ID: <2026090820-emerald-festive-f68c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 529c01c3dc0d322c103611c35b01d71ea04562b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090820-emerald-festive-f68c@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 529c01c3dc0d322c103611c35b01d71ea04562b2 Mon Sep 17 00:00:00 2001
From: Leo Martins <loemra.dev@gmail.com>
Date: Tue, 18 Aug 2026 17:40:10 -0700
Subject: [PATCH] btrfs: abort transaction before releasing tree_log_mutex on
 commit failure

When transaction metadata writeout fails in btrfs_commit_transaction(),
the current code only logs the error, drops tree_log_mutex and then goes
through cleanup_transaction(), which aborts the transaction and records
the fs error.

That is too late for the tree log side. A log sync can already be
waiting on tree_log_mutex, because the committing transaction is moved
to TRANS_STATE_UNBLOCKED while that mutex is held, which lets fsyncs
join the next transaction and queue up in btrfs_sync_log(). Once the
failed commit drops tree_log_mutex, such a log sync acquires it, sees
BTRFS_FS_ERROR() still clear, and writes super_for_commit. That
superblock holds the roots prepared for the transaction that has just
failed to write out its metadata, so it can point at tree blocks that
never reached the disk, and the next mount fails with a parent transid
mismatch.

Commit 165ea85f1483 ("btrfs: do not write supers if we have an fs
error") fixed this class of problem by making btrfs_sync_log() check for
an fs error right after taking tree_log_mutex. That check only works if
the commit path publishes the fs error before it releases the same
mutex, and commit 68d4ece9c30e ("btrfs: don't call
btrfs_handle_fs_error() in btrfs_commit_transaction()") removed the only
thing that did so.

Restore the ordering by aborting the transaction while tree_log_mutex is
still held. We have a transaction handle here, so this does not need to
bring back the btrfs_handle_fs_error() call: __btrfs_abort_transaction()
records the fs error itself, which is all btrfs_sync_log() looks at, and
the error message put in its place is kept.

This is what commit 3810ab40afa5 ("btrfs: abort transaction on error in
write_all_supers()") already does for the next call in this function.

This is reproducible on an unmodified kernel by failing the first
couple of bios of a transaction commit with fail_make_request while a
concurrent fsync workload keeps log syncs queued on tree_log_mutex.

Fixes: 68d4ece9c30e ("btrfs: don't call btrfs_handle_fs_error() in btrfs_commit_transaction()")
CC: stable@vger.kernel.org # 7.0+
Reviewed-by: Boris Burkov <boris@bur.io>
Reviewed-by: jlayton@meta.com <jlayton@meta.com>
Signed-off-by: Leo Martins <loemra.dev@gmail.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index bafc62cf5ebc..39909d363591 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2583,6 +2583,12 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	ret = btrfs_write_and_wait_transaction(trans);
 	if (unlikely(ret)) {
 		btrfs_err(fs_info, "error while writing out transaction: %pe", ERR_PTR(ret));
+		/*
+		 * Abort before releasing tree_log_mutex, so a log sync waiting
+		 * on it sees the fs error and skips writing super_for_commit
+		 * for this failed transaction. See btrfs_sync_log().
+		 */
+		btrfs_abort_transaction(trans, ret);
 		mutex_unlock(&fs_info->tree_log_mutex);
 		goto scrub_continue;
 	}

