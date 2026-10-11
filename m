Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F831A07F;
	Sun, 11 Oct 2026 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734187; cv=none; b=sWErOHbMUaIyEOUdWkaIK2vmjnXQFZWycO+TLnK+ne/7QEfPY5k1p3TyeMq9Nv56X5j8Dr1YmrEVK6KUBS6HwqNt+YuTgzmpjBEcVgzSMsnk9Y+MFGkPXYU2fpmFFxv0ih0aXjNaIRvSdwFLCUHhG6ZhjCdqyBwfhZ2Bhsf+404=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734187; c=relaxed/simple;
	bh=nHIysbKhzKKRUGVJwIJ3J6fM5uyQakeGXeDho6ccu4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hkLAx9+0/F2iWj2oF3G1AT+r8VZmaFEfnVH7WvvDlAOmI05CI45sFJvJs1K0jlEues5b6WRvlzCkZ03Owy6ARkI956LMwwgxNhvPgcj9qaBzP8c9aUW4F0r01qC52IYqAo3TPHGmDWrF52OztxL7lWCWVtwG+fXBSo3GPuv/YxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8g4m7Mx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8g4m7Mx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B691F0089F;
	Sun, 11 Oct 2026 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791734184;
	bh=qG+osqUPvehWCmIuj6izf+dzlDs/z2saJ2ym+wB+G7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=W8g4m7Mx3DOVmJYLHx2to7CtskDkpMcwrCTfz0FdL2gInZ6D3D93KUvFcP7hh3o+j
	 No5v6Ti2KQ9WNM5oKUNy/6laTmKOBQ40JJkKbmjxJnVqPAOPR92Pgbl/dD4V25AkjG
	 VsDGlaLtta+DQZc4NvzfjRroyD6ipopLaUFg3RQ+WNZLbuD2nm1uopOM1P4q8gmKOS
	 uggvnF3ey8HZpvuebYd5qDYH4lhPDr34ZtlcVTBc8MLsHyuq/tuCkE8MUlDVMm+ozc
	 EiLBEQ5aBy0clhm1opvWcbIfDa7YUipQHUXEnI4S1HW+9BGnoLu2oIPz8pBbT4Tofz
	 fg/99UsWY3MDw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:56:05 +0200
Subject: [PATCH 05/15] fserror: fully order the last pending error
 decrement
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-super-fixes-core-v1-5-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4710; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nHIysbKhzKKRUGVJwIJ3J6fM5uyQakeGXeDho6ccu4g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd3jjbR1b57MeDU8ID3zW79vW43zxmvLJ6Rj1TRADT0
 7zPdfPudJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEbjnD/6pu5ZZ/hrVXJOVW
 b7Oz0r95SO9C4t/MM/cV527T1vybuIjhvxfvE5+LZ67u+d0/+bwTz8rimtYz9exXv6ZvnHJ6lta
 GOn4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

fserror_unmount() drops the bias on s_pending_errors and waits for the
count to reach zero in wait_var_event() while the umount holds s_umount
exclusively. The worker that finishes the last pending error wakes it up
in fserror_pending_dec() through refcount_dec_and_test() and
wake_up_var().

wake_up_var() requires a full barrier between the store that makes the
condition true and its waitqueue_active() check. refcount_dec_and_test()
isn't fully ordered though. It provides release ordering and acquire
ordering on success which orders the load of the decrement but not its
store against the later load of the waitqueue. So the worker can see an
empty waitqueue while the umount, already queued, still reads a count of
one. The umount then sleeps forever with s_umount held and sync(2) and
everything else that wants that superblock hangs behind it.

LKMM allows this and so do the herd7 models for arm64 (LDADDL; DMB
ISHLD; LDR) and POWER. x86 is safe because the locked xadd is a full
barrier. With smp_mb() before wake_up_var() all three forbid it.

The litmus test (LKMM: Sometimes; with smp_mb() before the read of wq in
P1: Never). P0 is fserror_unmount() dropping the bias and queueing in
wait_var_event(), P1 is the last fserror_pending_dec():

  { cnt=2; wq=0; state=0; }

  P0(atomic_t *cnt, int *wq, int *state, spinlock_t *wql)
  {
          int r0, r1, r2;

          r0 = atomic_fetch_sub_release(1, cnt);
          if (r0 == 2) {
                  r1 = atomic_read(cnt);
                  if (r1 == 1) {
                          spin_lock(wql);
                          WRITE_ONCE(*wq, 1);
                          smp_store_mb(*state, 2);
                          spin_unlock(wql);
                          r2 = atomic_read(cnt);
                  }
          }
  }

  P1(atomic_t *cnt, int *wq, int *woken, spinlock_t *wql)
  {
          int r3, r4;

          r3 = atomic_fetch_sub_release(1, cnt);
          if (r3 == 1) {
                  smp_rmb();
                  r4 = READ_ONCE(*wq);
                  if (r4 != 0) {
                          spin_lock(wql);
                          WRITE_ONCE(*woken, 1);
                          spin_unlock(wql);
                  }
          }
  }

  exists (0:r0=2 /\ 0:r1=1 /\ 0:r2=1 /\ 1:r3=1 /\ 1:r4=0)

Not reproducible on x86 hardware. The consequence can be shown there by
emulating the reordering in fserror_worker(), debug only: sample
waitqueue_active() before the decrement, sleep, then decrement and only
wake if the sample saw a waiter:

          iput(event->inode);
  +       if (debug_reorder_ms) {
  +               struct super_block *dsb = event->sb;
  +               bool waiter;
  +
  +               mempool_free(event, &fserror_events_pool);
  +               waiter = waitqueue_active(__var_waitqueue(&dsb->s_pending_errors));
  +               msleep(debug_reorder_ms);
  +               if (refcount_dec_and_test(&dsb->s_pending_errors) && waiter)
  +                       wake_up_var(&dsb->s_pending_errors);
  +               return;
  +       }
          fserror_free_event(event);

  # boot with fserror.debug_reorder_ms=5000
  mount -t ext4 /dev/vda /mnt
  xfs_io -x -c "shutdown" /mnt      # EXT4_IOC_SHUTDOWN with NOLOGFLUSH
  umount /mnt &                     # hangs forever
  sync &                            # hangs behind s_umount

  INFO: task umount:108 blocked for more than 30 seconds.
   fserror_unmount+0x20d/0x2c0
   generic_shutdown_super+0xac/0x530
   kill_block_super+0x3b/0xa0
   ext4_kill_sb+0x6c/0xc0
  INFO: task sync:111 <reader> blocked on an rw-semaphore likely owned by task umount:108 <writer>

Fixes: 21945e6cb516 ("fs: report filesystem and file I/O errors to fsnotify")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fserror.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/fserror.c b/fs/fserror.c
index 1e4d11fd9562..d8a800580012 100644
--- a/fs/fserror.c
+++ b/fs/fserror.c
@@ -35,8 +35,15 @@ void fserror_unmount(struct super_block *sb)
 
 static inline void fserror_pending_dec(struct super_block *sb)
 {
-	if (refcount_dec_and_test(&sb->s_pending_errors))
+	if (refcount_dec_and_test(&sb->s_pending_errors)) {
+		/*
+		 * refcount_dec_and_test() isn't fully ordered but wake_up_var()
+		 * needs a full barrier between the store and its waitqueue check.
+		 * Pairs with the barrier in prepare_to_wait_event().
+		 */
+		smp_mb();
 		wake_up_var(&sb->s_pending_errors);
+	}
 }
 
 static inline void fserror_free_event(struct fserror_event *event)

-- 
2.53.0

