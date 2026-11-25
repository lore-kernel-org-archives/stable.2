Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606397;
	b=ibzwM2CYgDAOBRS7RQOGAkpWxciFjbeRh8JuIL2nLZhUmpGqM/PrbIiFSFiHR9AGDloS
	 c7FphjCjALAdGURyZ1LlZauumlb+vKoDfDPvkNoZIgG542vzmEHfKTBbCGYPK2m0ekp0N
	 UA8eOcv25C5GczSepXmdpRrbxS1IhfAebRw9A5ma8aZis83rvaG2+eju1rqfW1b6PTAo1
	 wGoT3p2BfWRdoq7kCc2ApVG6gZe5olpcQaF+vUecMDBG4B417kPm73aKZqK6ZGCv1VmfY
	 k3VGVxhwyZo1qScmJjA/0+w04hu2ysIkgUnJ2rS7wvU99XFNKnI2ntHbml6uimuXTzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606397;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EfbvPnf1q0h4GXc/7q/pzGRTQsiIJlxL/S+b+O52xMs=;
	b=RMC8MpLCnV7VSB8wSQe9ls1rHftUwo/FK2TqrT8rXP+hBxTjxvnpkgEVmEVgL/82DYSE
	 FmLK+ziWfzy+0vO86p+GguT7Kxmd5ORfvBRf8kmqn49Z7pfBkbxQ0ggUjW4Uu20x7DkPy
	 YcneXCDhAY8X2fXELWpMsQ/4eL8u36ne1t0VRKeDf427nt0OqgckCrcT45EXnTUji/Rfh
	 3y//VjBlo2K1s+YSauEo8VjPAQKyTpxJ7DvIYg24wKOaaJo0fikiVQR/kPcNn9R2J+VBa
	 dErttykdQ9L/dFRjMLm2XvZeif5u2g/wWJiu4JHmok3K0Lclla3kBGd/Fs/YmPySbtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="CnY6zb/I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E80606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=CnY6zb/I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D9B1F000D1;
	Wed, 25 Nov 2026 11:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606396;
	bh=EfbvPnf1q0h4GXc/7q/pzGRTQsiIJlxL/S+b+O52xMs=;
	h=Subject:To:Cc:From:Date;
	b=CnY6zb/IF227NODpP2bDo/p093E2tXAQBLKG9VsKsAI1L16KckIGaoMH6K+nrNjER
	 eCOZ7Qu2r9LdArf2iWhThTAZ6SiMBxFgTDtgBZCPyA3crwrRFY3dlo37NhXXKQfd8g
	 9uknonjGI0IXbBJWVONI/zVNEwOUouztzTjVAPsU=
Subject: FAILED: patch "[PATCH] dm snapshot: fix discard_granularity unit in" failed to apply to 6.6-stable tree
To: wuyuehong@cmss.chinamobile.com,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:21:06 +0100
Message-ID: <2026112506-afraid-flogging-8ebf@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d7216d7be2bbfdf3312695b6e41a4fc7c5e22902
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112506-afraid-flogging-8ebf@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

