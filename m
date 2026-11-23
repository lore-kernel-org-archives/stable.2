Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438974;
	b=Mr+Xw0f8W5Ud/zbHwJev1VdyVJKKywoICfNAL1Adel43OOXHzU1JkuTGqlA1bcEqwpi3
	 Mryd46CD8aYNeIyC7rC9QPDkjBcj+4cwx7h+y0ZqDbqgG5ykHotmOz4LLOXOVIZZZIBeC
	 OvHXhg5/gIkV2s0o2lF433DSTegbPjLF+gg2dE66eacS0art6UbNKFTHw4syzMukYtQk5
	 vU6YfSZJz1aOY+lSohkYcZnIAVWW0efh1fRe35GfwI4apslbl1XmUXRLro2cfiQ93/EmA
	 NwRu+wlma+90M0EyVpJyWwWAg6+MG5brTW0n1Fwo4J79GGVlPutT6z5l2/mR6EdeA0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438974;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rld3maBrfiA0lhkY/oG5uCjn/3XFYAxqHfH64uthrqE=;
	b=qDR639JiSFETMDO21co8yzeMiI7IVQ0UQ+HTmJAA7pzeloVZp0bfr2EnlpY/4N7xv3VL
	 q7vsN3gj84JNIatIi5ZmUvw8BW8kC4lUoUF7QjvzOfjujUsyVwsLWK4rmWlV812WXLnm2
	 VX1xBIzuv3IwmP+UvxVgobMqTogA1u3Cnuqb3Yga+hO8MCAHBIAJjxcS4idXim06ejiNz
	 eGLP9KiE7xiOHP0DU3YcMUbcf5PzASYz2QfjPMHW5zp9vZrmS8Qnf+s1K718zS42VMo5D
	 luhdJoTlGCCftHDajdkFLEpAcwW6LEpyy0Qwb1N5qxFdcFbI33ghQnMc9H61ks0Et5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5Z0YzEZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21370606A31A;
	Mon, 23 Nov 2026 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5Z0YzEZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494E51F000C0;
	Mon, 23 Nov 2026 13:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795438973;
	bh=rld3maBrfiA0lhkY/oG5uCjn/3XFYAxqHfH64uthrqE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=F5Z0YzEZC0eRJqsjONT2UoZkZt6qaWiH+8t9+x3PP/kgp3QblOpwwQFQBXkKRo9Wx
	 rHOUChv+oKmFtLjE2EO94D/x75yk1xX79H5By2erM/W0F1aiS08XNPJRLtY7G0i91A
	 OTaJPVb/YtW+inJwX4ASvqb7qeMqkf8w11FWxp5Mw4lbKS/d8iMHAQlGv0vr1MtlC4
	 OQ4m7zcDQNSQbEzF3rA5ZccwiRu0+wrGPo+sacA8oDxmMFaNENvopHma6AHjlnWST9
	 yuk5emCdzWzg3PAfNWpnOqPzJ7fL/q7rgxAl80no5aGRn81u0nLBQcZWvkRkWToBbZ
	 BbVzrS20eAoBQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Nov 2026 14:02:19 +0100
Subject: [PATCH 2/2] jfs: set lbmDONE before dropping LCACHE_LOCK for
 lmPostGC()
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
Message-Id: <20261123-work-loop-backing-file-v1-2-48f83eaf2499@kernel.org>
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
 syzbot+2e5cf2352e9f69ebf172@syzkaller.appspotmail.com
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=4293; i=brauner@kernel.org;
 h=from:subject:message-id; bh=b8EYIYFE93TzJHlD80pR7dcEDpzJ/KGj2d6wFcvD3To=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSzWGaHm3yvStZecdbu4KV9V/6GdDvdZ82Z/P5i38WMU
 Jdd9y7Hd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykdh3D/5I/0xJNXp/2+X9n
 w40/WfN3b5qo553Vt+PIg+Nbq05tOMgJVOF2Kne3O5/K6Qet2/5+Fbx1U99xsTCfqFTDlenbZvd
 zMQIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Since commit b15e4310633f ("jfs: Set the lbmDone flag at the end of
lbmIODone") lbmIODone() sets lbmDONE as the very last thing. For a group
commit write that means after it dropped LCACHE_LOCK, called lmPostGC()
and took the lock again. But lmPostGC() can hand the buffer back to the
freelist via lbmFree() or queue it for the next write via lbmWrite(),
and the buffer of the current log page is written by group commit over
and over. So the lbmDONE set afterwards can land on the next I/O of the
buffer.

At unmount lmLogShutdown() writes the current log page via lbmWrite()
and waits for it via lbmIOWait(log->bp, lbmFREE). If the completion of
an earlier group commit write of that page sets its lbmDONE in between
then lbmIOWait() returns while the page is still in flight and on the
write queue and lbmfree() asserts:

  BUG at fs/jfs/jfs_logmgr.c:1919 assert(bp->l_wqnext == NULL)
  kernel BUG at fs/jfs/jfs_logmgr.c:1919!
  RIP: 0010:lbmfree fs/jfs/jfs_logmgr.c:1919 [inline]
  RIP: 0010:lbmIOWait+0x5ab/0x5b0 fs/jfs/jfs_logmgr.c:2154
  Call Trace:
   lmLogShutdown+0x1ff/0x850 fs/jfs/jfs_logmgr.c:1657
   lmLogClose+0x28c/0x530 fs/jfs/jfs_logmgr.c:1457
   jfs_umount+0x2da/0x3b0 fs/jfs/jfs_umount.c:124
   jfs_put_super+0x8c/0x190 fs/jfs/super.c:194
   generic_shutdown_super+0x13d/0x2d0 fs/super.c:751
   kill_block_super+0x44/0xa0 fs/super.c:1903
   deactivate_locked_super+0xbe/0x110 fs/super.c:586
   cleanup_mnt+0x204/0x2a0 fs/namespace.c:1396

In my build of the same config R12 holds bp->l_flag at that point and in
the report it is 0x2e, i.e., lbmWRITE | lbmRELEASE | lbmSYNC | lbmDONE.
So the completion of the write lmLogShutdown() waits for hasn't run yet
and lbmDONE came from somewhere else. A completion that only gets to the
buffer after lbmWrite() stored those flags takes them for its own,
clears lbmWRITE and takes the buffer off the write queue. A read
completion clears lbmREAD and sets lbmDONE under the same LCACHE_LOCK.
The group commit branch is the only place in lbmIODone() that drops
LCACHE_LOCK before it sets lbmDONE.

With a workload that writes and fsyncs a few files before every unmount
on PREEMPT_RT the late lbmDONE lands on a new I/O of the buffer in about
one out of ten group commit completions. Mostly that's the next write
lmPostGC() itself just queued. But in about one out of 1800 completions
another task reinitialized the buffer while the lock was dropped.
Preempted completions kept it dropped for up to 14 ms. I haven't seen
the late lbmDONE land on lmLogShutdown()'s final write on its own in
about a million unmounts. But with a debug patch that holds the
completion right after lmPostGC() until lmLogShutdown() has submitted
that write every VM hits exactly the BUG above within the first few
unmounts, with the same 0x2e in R12. With this patch the same delay
leaves the completion nothing to do after lmPostGC() and 15400 unmounts
run clean.

So set lbmDONE before dropping the lock for lmPostGC() like lbmIODone()
did before commit b15e4310633f ("jfs: Set the lbmDone flag at the end of
lbmIODone") and don't touch the buffer after lmPostGC(). That doesn't
bring back what that commit fixed. That was lbmRead() returning while
lbmIODone() still used the buffer. Nobody waits for lbmDONE on a group
commit write. The transactions wait for their commit records via
tblkGC_COMMITTED instead.

Fixes: b15e4310633f ("jfs: Set the lbmDone flag at the end of lbmIODone")
Cc: stable@vger.kernel.org
Reported-by: syzbot+2e5cf2352e9f69ebf172@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2e5cf2352e9f69ebf172
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/jfs/jfs_logmgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index e96593d79a1df..ae3bd0cd85471 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -2279,9 +2279,11 @@ static void lbmIODone(struct bio *bio)
 	 *	Group Commit pageout:
 	 */
 	else if (bp->l_flag & lbmGC) {
+		/* lmPostGC() may free or requeue @bp. */
+		bp->l_flag |= lbmDONE;
 		LCACHE_UNLOCK(flags);
 		lmPostGC(bp);
-		LCACHE_LOCK(flags);		/* disable+lock */
+		return;
 	}
 
 	/*

-- 
2.53.0

