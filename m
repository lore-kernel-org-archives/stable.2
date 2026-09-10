Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3B54B515E
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052068; cv=none; b=b8QGGj6GEDOElTND2qhh+b+wuAQ3+jtoEGQJ22GuRJ1PjQEghp3BjPedqbCBoRXC9/mRKnxH+D/R+XLHf9Ae5XoD+n8SBge+KZT4auHkMEZd7KxxPUMpOomwwZgH2Z9HLve7tYV3GufeNQXO0TfiMM/du89hYriJoO4P9/MxCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052068; c=relaxed/simple;
	bh=JgUnjoodBuVNW/YrPY0KKrU3ZJSjBHXdGgBbpphpFqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjeZEwyI98uzXejktuNlPiRrflDm4lp+YlXm101pCoRfVxT4KF8Hpjlk/KSypAk7n3Vr2vMrpIavAG5wEi5uzcnJASlQhqpdJlg9/CA37/7MUi2DUm9p2QX0H8Z/MtKdaaUhnAeqLBvYpb2UbyMg8pZFUwF9Ec6fp0ifPV/10w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIo3tzPp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIo3tzPp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1471C1F000FF;
	Thu, 10 Sep 2026 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052066;
	bh=2Y/X6+5xjCH1oxZcLEtOauD3W82Qwtkh/GQTOzO4ZUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QIo3tzPpEV+vACiA1OCmF5NKK5lZ1CqDqUWBkEzfhF7upgGKJMYcBQbT9cITlhpdf
	 GHKfC1egNOfn7SPAdYC7soMmkxanjcLi0LR9lBCIISwpY4Ug0oJw1leSb5BdiJjRW8
	 UNp0J3TdFMN7G5r+rKz6NSiMhpyTqPlywY1U4vcuQwVRRYlPRtXeLnW8i5hRoMIeJG
	 j3XCEUEttm3EG2/Dlk/Vq53iBsN49ZmE8mvttM95u0pF6k2LeWT4/tKWK1Z6tXUU0Y
	 Yx1NbzeX8s9v8Y41cThya6yKHSRojV6dwd+v1NhaXqAMmekwhFxv32fZrn1wXQHzgQ
	 Fwf3kDX3DaoXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leo Martins <loemra.dev@gmail.com>,
	Boris Burkov <boris@bur.io>,
	"jlayton@meta.com" <jlayton@meta.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] btrfs: abort transaction before releasing tree_log_mutex on commit failure
Date: Thu, 10 Sep 2026 10:54:24 -0400
Message-ID: <20260910145424.828388-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090820-emerald-festive-f68c@gregkh>
References: <2026090820-emerald-festive-f68c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leo Martins <loemra.dev@gmail.com>

[ Upstream commit 529c01c3dc0d322c103611c35b01d71ea04562b2 ]

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
[ adjusted error-message context to retain `%d` with `ret` instead of `%pe` with `ERR_PTR(ret)`. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/transaction.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8f94197281008..5376cd5505454 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2589,6 +2589,12 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	ret = btrfs_write_and_wait_transaction(trans);
 	if (unlikely(ret)) {
 		btrfs_err(fs_info, "error while writing out transaction: %d", ret);
+		/*
+		 * Abort before releasing tree_log_mutex, so a log sync waiting
+		 * on it sees the fs error and skips writing super_for_commit
+		 * for this failed transaction. See btrfs_sync_log().
+		 */
+		btrfs_abort_transaction(trans, ret);
 		mutex_unlock(&fs_info->tree_log_mutex);
 		goto scrub_continue;
 	}
-- 
2.53.0

