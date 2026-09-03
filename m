Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED313264E2
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444391; cv=none; b=ZXvgY5+u1M5emci0T42TL4/pAZOy9NZ/yJxR0PND1Xsjco/F61GY7X7ytk+enPPiS6J2NO4MHJYDGCMJph5ghYP4KkWfTt6OVXhPoSxMYbjdbly15cuXelUVBqlE240HGm9Y5qe5+fjXSZ3ckDmFsNvJWRz3iZ00fJKq01xW/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444391; c=relaxed/simple;
	bh=/qpxEbOcXu7zQ4DmXTYRSlK82+w6LHEgGtdm6Uu11qc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ubh1p1VN2fmSi1/uilQ+/Qe7GlWTYLzmAkW/hURrQ6vuv/aCs2k1peMlvWpNAK3p46MWLBMsffs3BuN2fi03gI28DTik42HFAeCLnVSvDIAEnx218bjGl+sn4jBMBgiQJ7cBf+SxWfqijienBFCjMrfW+oDU2DiyXnj07WpdmpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lF7xgL+5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lF7xgL+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE681F00A3D;
	Thu,  3 Sep 2026 14:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444383;
	bh=gWv/q/quo+AtD8i0BIELJ5mCzfZLAUCKTVydyh/fgPk=;
	h=Subject:To:Cc:From:Date;
	b=lF7xgL+5wBHTfz7N2XX69zAaE3l+y/a5P0TnWFPAUBd/azBA/BfgWvkKQ9MgQLC2V
	 eusWT/a1AEKSnPr9YDe/aBh0Opfo10+7qYjQs+ivbLzwxHNNH4nJjl4celLpOCZteV
	 J8SxPHl4fV+/+wbEUITse3JpxJMJ28JYehuhYZFs=
Subject: FAILED: patch "[PATCH] block: set QUEUE_FLAG_DYING unconditionally in" failed to apply to 6.1-stable tree
To: hulianqin@vivo.com,axboe@kernel.dk,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:46:27 +0200
Message-ID: <2026090327-engross-lapped-120b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7e9a46004b471eaf69b082c473d865316a4158e0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090327-engross-lapped-120b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7e9a46004b471eaf69b082c473d865316a4158e0 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?=E8=83=A1=E8=BF=9E=E5=8B=A4?= <hulianqin@vivo.com>
Date: Wed, 12 Aug 2026 11:59:04 +0000
Subject: [PATCH] block: set QUEUE_FLAG_DYING unconditionally in
 blk_mark_disk_dead()

Disks created via blk_mq_alloc_disk_for_queue() (e.g. SCSI SD disks)
do not have GD_OWNS_QUEUE set.  Currently __blk_mark_disk_dead() only
sets QUEUE_FLAG_DYING when GD_OWNS_QUEUE is set, so for such disks
blk_queue_enter() and __bio_queue_enter() cannot detect the dying
state via blk_queue_dying() and remain blocked waiting for I/O that
will never complete after surprise removal.

blk_mark_disk_dead() is the explicit "surprise removal" API -- the
caller has already decided the disk is dead.  Setting QUEUE_FLAG_DYING
unconditionally here is appropriate: any in-flight I/O from other
threads should get -ENODEV immediately from blk_queue_enter()
regardless of GD_OWNS_QUEUE ownership.

For disks that already have GD_OWNS_QUEUE set, __blk_mark_disk_dead()
will set the flag again which is harmless.

Fixes: 6f8191fdf41d ("block: simplify disk shutdown")
Cc: stable@vger.kernel.org
Signed-off-by: Lianqin Hu <hulianqin@vivo.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/PUZPR06MB62247E82E66A3ED46CC3E6C7D2DC2@PUZPR06MB6224.apcprd06.prod.outlook.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/genhd.c b/block/genhd.c
index df2c3c69b467..7b089e2d52c4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -681,6 +681,7 @@ static bool __blk_mark_disk_dead(struct gendisk *disk)
  */
 void blk_mark_disk_dead(struct gendisk *disk)
 {
+	blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
 	__blk_mark_disk_dead(disk);
 	blk_report_disk_dead(disk, true);
 }

