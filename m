Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606407;
	b=KtkSI+CZ1mi7pMJAj9Q4m9i0rr4kVDNLzXWHgsPoHWRY6Y2glaoAyGYTstd84yYa4lOv
	 UZc3KOeA99GozDaYd5cZkL539ctDCH5Y5qpx0tJo+t3iY1Fnp6098rgmuuXIUgg+9/Ude
	 Vr3CWW4Q9vz0f/pxpqNLWkvBu0zucyIFtZrqdvT1AQOlzp72UF4NKK+De1UWhemgDL/iV
	 XzqvQCu72kT0/mJqc2JJlTezMd12hVNrlOIsXgS+clpwQnroG/erG2z3tTEK+4eMCHt9W
	 cbGX/6tMAiFh7jA+gpdeJwbj32KQgtud8X5WveXTv2lk/exAEKXEOLV+IEQETed3UDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606407;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bbn40REh3nF2CMGBZbXQO9uCjYK0Da2VsB/sNfzadXU=;
	b=W8Jocb2DpHWe5kQnphBvQJaZ1heez6pqhLa/8Hxd6slvtTZLgaulWYYA2X98IeQXL14l
	 iNcFTxloMR/nFSV0K7nAJWOYJMqv8uj5zlD3nOi8waerJoitZn2Pvw5Xr2u1Z/dBjSHJg
	 5iyHe1FDKuc7Jdv7aTLoLW03XM15DSsLPoNuG0yKzPRe4wTtCgrpqL/TCWrVGASfBeGTY
	 0+haPSrWCZ6w/g9b7mIIpPszjyk7Rt6CouMKYWgqyws7Q+ve4BPhQDlLF/32KC28hS4Ts
	 j1R9HO3T7Fl97ThtD0OAmPgLzuR3FGaFafw1YBmGMLAfEd7yOrAxNp62WMVmxUORSwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yV82GrJO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0E606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yV82GrJO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35271F000CA;
	Wed, 25 Nov 2026 11:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606406;
	bh=bbn40REh3nF2CMGBZbXQO9uCjYK0Da2VsB/sNfzadXU=;
	h=Subject:To:Cc:From:Date;
	b=yV82GrJO2e+KdtIrWkuTxGaaxboXCFVBCDnMGL7PGZUeQv9uuczMphnhl9qIFnvTJ
	 6GONXy+gq2/VNBZM65BXAShbySAgVG3SNeQYeN3rB61T8V8qyuzKcECxHdcld39ZUr
	 sV6n7790YXcnmMsnTatxiy+TS/yIG0D+yIPWsJM8=
Subject: FAILED: patch "[PATCH] dm snapshot: fix discard_granularity unit in" failed to apply to 5.10-stable tree
To: wuyuehong@cmss.chinamobile.com,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:21:08 +0100
Message-ID: <2026112508-swooned-spherical-c717@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d7216d7be2bbfdf3312695b6e41a4fc7c5e22902
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112508-swooned-spherical-c717@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d7216d7be2bbfdf3312695b6e41a4fc7c5e22902 Mon Sep 17 00:00:00 2001
From: wuyuehong <wuyuehong@cmss.chinamobile.com>
Date: Mon, 26 Oct 2026 17:35:00 +0800
Subject: [PATCH] dm snapshot: fix discard_granularity unit in
 snapshot_io_hints

snapshot_io_hints() copies the snapshot store's chunk_size, which is
in 512-byte sectors, into queue_limits.discard_granularity, which, like
all other members of struct queue_limits, is in bytes.

For snapshots with a chunk size smaller than 512 sectors, e.g. the
16 KiB (32-sector) chunks created by the syzkaller reproducer, the
resulting granularity is smaller than a single sector.  When
dm_calculate_queue_limits() then stacks the target limits into the
table limits:

	blk_stack_limits(limits, &ti_limits, 0)

queue_limit_discard_alignment() truncates that granularity to zero
sectors and sector_div() divides by zero:

  Oops: divide error: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:queue_limit_discard_alignment block/blk-settings.c:645 [inline]
  RIP: 0010:blk_stack_limits+0x1105/0x2d00 block/blk-settings.c:916
  Call Trace:
   dm_calculate_queue_limits+0x70c/0x1510 drivers/md/dm-table.c:1823
   dm_setup_md_queue+0x199/0x4f0 drivers/md/dm.c:2618
   table_load+0x4fd/0x8a0 drivers/md/dm-ioctl.c:1661

The divide fault itself only became reachable when commit e924da7d6622
("block: Drop granularity check in queue_limit_discard_alignment()")
removed the check for a sub-sector granularity in v6.13.  Kernels
before that returned a zero discard alignment instead of faulting, but
they still advertised a granularity 512 times too small.

Use the same chunk_size << SECTOR_SHIFT conversion that
io_overlaps_chunk() already applies to turn chunk_size into bytes.

Fixes: 2e6023850e17 ("dm snapshot: add optional discard support features")
Reported-by: syzbot+1288484b13bf6af3620d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1288484b13bf6af3620d
Cc: stable@vger.kernel.org
Signed-off-by: wuyuehong <wuyuehong@cmss.chinamobile.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 797c432594d8..31676ee05514 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -2414,7 +2414,7 @@ static void snapshot_io_hints(struct dm_target *ti, struct queue_limits *limits)
 			snap = snap_src;
 
 		/* All discards are split on chunk_size boundary */
-		limits->discard_granularity = snap->store->chunk_size;
+		limits->discard_granularity = snap->store->chunk_size << SECTOR_SHIFT;
 		limits->max_hw_discard_sectors = snap->store->chunk_size;
 
 		up_read(&_origins_lock);

