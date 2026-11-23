Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438969;
	b=vSXKpceko/TqzOpwgpXuwAy4vsl+4wg4UCVmUF6a7zSp4HZW4wHqtqydJ9tgZmi2f9gG
	 BvznNdQG8n34J/J+1JbXbabLLBhy5Zt8+EMAlHmeNF72DHDqUiyLszmt8Pc5knK4QqZ53
	 7VkxCXxBdngqnqlFbmrq8yjvM8BI6Z8Oniocm8LRB/M7lFXggLO5RyoH5AiI6YTXsDKG6
	 NV4qctIzoMixZUnfNmX2GrmbbNFBQdR5RV4sQ1tWESItWIyooSBO9h7BIOpP4GZGy9fFG
	 fLO0MZ1s2p3cS1oRiyVBAJGprkM593LO+iyIVI4R6XsNr0zVg7Axi27NVlqcNDX2m7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438969;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=9kGDZUqKQUexLM07zlp91pvIAfI6qEAMqWfY2Nhi7p4=;
	b=QuC4sm/zAEdfXpWtt5AVR4cP7wJ5yKTC157c8JAyDrI8FrO6OekYVM0rQaSPLSdTn0WE
	 HniiEqFgJkIrr2vFnKiAzJAXyiqOt4wmDScGT3hmigRIJjJT8qXkH4QG11rktGpxbqpry
	 CRUg+hfziUk6lHHEUvAr6gQG62JOVGji8sJTp6eldG0ptbpHcGm0a9np5+78guXkauy6b
	 w7PHPKzzjfDMQcInDujJwoBtb7RI9fiR38or4Tj350I746nF/m4MjRHemB+sR9etNQFrF
	 pxWifIKb/k9kHRACm6NgsfNxYlccsQCxnC6q4bz9FyI//y+lLWbBuRHUk4WLKQNM5lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMOq0Wc8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054C4606A31A;
	Mon, 23 Nov 2026 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMOq0Wc8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C11F1F000C6;
	Mon, 23 Nov 2026 13:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795438968;
	bh=9kGDZUqKQUexLM07zlp91pvIAfI6qEAMqWfY2Nhi7p4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gMOq0Wc88wdd/i1Tx0eHPjeonGAkYj70GAArRvPSiUkYYtRdp4FZYxyG+4AR2dy4r
	 QoNdBTRF4bJKdG0b9qw33Grj923KZNSepVEg3vCijOfQTtI+Xhgrd2LgGNtSEEBHH9
	 uVu82LXEaIMjIFTw2ksvaqEJFmgqrz7a4FOneXCQOeQDIeYH6f2K55j5NOGsEe9+ua
	 44cUr7UIcHDrfn2c8rcLnffYv+tf43prWKy5hOIN09E+qJVRya50egyC5I6o5n+p7E
	 kR1PwLEg6zBTc31qxRcec5J41B16MZ4J9UFcMgWEarQR12XBdMswNAFv0DY/c2D4zW
	 GzTFx9Wps6SKQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Nov 2026 14:02:18 +0100
Subject: [PATCH 1/2] jfs: wait for lbmDONE under LCACHE_LOCK in lbmRead()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-work-loop-backing-file-v1-1-48f83eaf2499@kernel.org>
References: <20261123-work-loop-backing-file-v1-0-48f83eaf2499@kernel.org>
In-Reply-To: <20261123-work-loop-backing-file-v1-0-48f83eaf2499@kernel.org>
To: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Bart Van Assche <bvanassche@acm.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
 Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, 
 Edward Adam Davis <eadavis@qq.com>, Jens Axboe <axboe@kernel.dk>, 
 Ming Lei <tom.leiming@gmail.com>, Hillf Danton <hdanton@sina.com>, 
 Tao Cui <cui.tao@linux.dev>, Al Viro <viro@zeniv.linux.org.uk>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 linux-rt-devel@lists.linux.dev, linux-block@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org, 
 syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com, 
 syzbot+ecf51a7ccb6b1394e90c@syzkaller.appspotmail.com, 
 syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=6530; i=brauner@kernel.org;
 h=from:subject:message-id; bh=9N5EHJOYs+e80Rlb9NuImJmX7Upo8CeUohDPDCeNZYQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSzWGbFK3u7fnXi+8aYtPveOp6Z17e0nxcqSE5ZNdFPZ
 m306SypjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl4BzAyzD5Ucfjt88nts9c+
 2xFc1b7/83umfff0PFmPhyp6fNdsC2dkWKA3/Wains7rf7G12+oZ/rEwXArKnhnzUd64NGjTpss
 2TAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

lbmRead() waits for the read without taking LCACHE_LOCK and returns as
soon as bp->l_flag is no longer lbmREAD. Since commit b15e4310633f
("jfs: Set the lbmDone flag at the end of lbmIODone") lbmIODone() clears
lbmREAD and wakes the reader first and only sets lbmDONE right before it
drops LCACHE_LOCK. So the reader can already be using the buffer again
when lbmIODone() ORs lbmDONE into bp->l_flag.

lmLogShutdown() reads the log superblock, updates it and writes it back
via lbmDirectWrite(). lbmDirectWrite() sets bp->l_flag without taking
LCACHE_LOCK and submits the write. If that store happens before the late
lbmDONE from the read completion then the write is marked as done before
it has even been issued:

  umount                                  read completion
  ======                                  ===============
  lmLogShutdown()
  -> lbmRead(log, 1, &bpsuper)
                                          lbmIODone()
                                          -> LCACHE_LOCK()
                                             bp->l_flag &= ~lbmREAD
                                             wake_up(&bp->l_ioevent)
     // bp->l_flag != lbmREAD
  -> lbmDirectWrite(log, bpsuper, ...)
     bp->l_flag = lbmWRITE | lbmRELEASE | lbmSYNC | lbmDIRECT
     submit_bio()
  -> lbmIOWait(bpsuper, lbmFREE)
     -> LCACHE_LOCK()
                                             bp->l_flag |= lbmDONE
                                             LCACHE_UNLOCK()
        // lbmDONE is set, don't wait
  -> lbmLogShutdown()
     // free all lbufs and their pages

lmLogShutdown() returns, the unmount finishes and the block device is
released while the superblock write is still queued. What happens next
depends on who gets there first. If the write is still sitting in the
loop device when the device is torn down then __loop_clr_fd() has
already cleared lo->lo_backing_file and the loop worker dereferences
NULL:

  KASAN: null-ptr-deref in range [0x00000000000000a0-0x00000000000000a7]
  Workqueue: loop6 loop_workfn
  RIP: 0010:file_inode include/linux/fs.h:1351 [inline]
  RIP: 0010:kiocb_start_write include/linux/fs.h:2797 [inline]
  RIP: 0010:lo_rw_aio+0xc26/0x1100 drivers/block/loop.c:398
  Call Trace:
   do_req_filebacked drivers/block/loop.c:430 [inline]
   loop_handle_cmd drivers/block/loop.c:1847 [inline]
   loop_process_work+0x638/0x11d0 drivers/block/loop.c:1882
   process_one_work kernel/workqueue.c:3495 [inline]
   process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3578
   worker_thread+0xa47/0xfb0 kernel/workqueue.c:3659
   kthread+0x38b/0x470 kernel/kthread.c:436

If the loop worker gets to it first the freed page is written to the
backing file and lbmIODone() then runs on the freed lbuf:

  BUG: KASAN: slab-use-after-free in lbmIODone+0x130e/0x16b0 fs/jfs/jfs_logmgr.c:2192
  Read of size 4 by task ksoftirqd/0/16
  Call Trace:
   lbmIODone+0x130e/0x16b0 fs/jfs/jfs_logmgr.c:2192
   blk_update_request+0x57b/0xe50 block/blk-mq.c:1036
   blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1167
   blk_complete_reqs block/blk-mq.c:1242 [inline]
   blk_done_softirq+0x10a/0x160 block/blk-mq.c:1247
   handle_softirqs+0x1d4/0x6c0 kernel/softirq.c:669
   run_ksoftirqd+0x53/0x190 kernel/softirq.c:1133
  Freed by task 5632:
   kfree+0x1c7/0x6d0 mm/slub.c:6930
   lbmLogShutdown fs/jfs/jfs_logmgr.c:1862 [inline]
   lmLogShutdown+0x456/0x850 fs/jfs/jfs_logmgr.c:1681
   lmLogClose+0x28c/0x530 fs/jfs/jfs_logmgr.c:1457
   jfs_umount+0x2da/0x3b0 fs/jfs/jfs_umount.c:124
   jfs_put_super+0x8c/0x190 fs/jfs/super.c:194
   generic_shutdown_super+0x140/0x2d0 fs/super.c:723
   kill_block_super+0x44/0xa0 fs/super.c:1852
   cleanup_mnt+0x204/0x2a0 fs/namespace.c:1396

If the loop worker got hold of lo->lo_backing_file right before
__loop_clr_fd() cleared it then it writes through a file that is being
released instead. That's syzbot's "WARNING in file_remove_privs_flags".
I haven't seen that one in my runs but in all four logs of it that
syzbot kept the process that owns the loop device had mounted a jfs
image a few seconds earlier.

On PREEMPT_RT LCACHE_LOCK doesn't disable preemption. The woken umount
task preempts the completion on the same CPU, gets all the way to
lbmIOWait() and only then lets the completion finish. With syzbot's
reproducer that happens in about one out of 70 unmounts. Without
PREEMPT_RT the umount task has to be running on another CPU already and
I've only seen it once in 26400 unmounts. lmLogFileSystem() does the
same read, update and direct write of the log superblock for external
logs.

The lockless wait isn't new. Before commit b15e4310633f ("jfs: Set the
lbmDone flag at the end of lbmIODone") lbmIODone() set lbmDONE first and
that ended the reader's wait early as well. lbmDirectWrite()'s
store could then get lost in lbmIODone()'s read-modify-write of
bp->l_flag when it cleared lbmREAD, leaving nothing but lbmDONE behind.
That window was a lot smaller but syzbot hit it too.

So wait for the read via lbmIOWait() which waits for lbmDONE under
LCACHE_LOCK. lbmIODone() sets lbmDONE and drops the lock as the last
thing it does so once lbmIOWait() returns the completion is done with
the buffer. Note that lbmRead() keeps ignoring lbmERROR like it did
before. That's a separate problem.

Link: https://lore.kernel.org/69e2ca14.a00a0220.1bd0ca.0031.GAE@google.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: b15e4310633f ("jfs: Set the lbmDone flag at the end of lbmIODone")
Cc: stable@vger.kernel.org
Reported-by: syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28
Reported-by: syzbot+ecf51a7ccb6b1394e90c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ecf51a7ccb6b1394e90c
Reported-by: syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bc273027d5643e48e5b3
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/jfs/jfs_logmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 306165e61438c..e96593d79a1df 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1984,7 +1984,7 @@ static int lbmRead(struct jfs_log * log, int pn, struct lbuf ** bpp)
 		submit_bio(bio);
 	}
 
-	wait_event(bp->l_ioevent, (bp->l_flag != lbmREAD));
+	lbmIOWait(bp, 0);
 
 	return 0;
 }

-- 
2.53.0

