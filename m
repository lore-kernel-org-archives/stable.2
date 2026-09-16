Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E184D7D25
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579804; cv=none; b=RdLZz+hAikW4YooUQ5o6zt0vJ1vrCRhqqYOfrR9WnEQmD/P5uA+FZT2OV0ZZWjvffKgCVWu9MQ9ui+pWlNW4rpKKrp1oPeJA574m3WB6R7E6WQaN9j2mPWype/ccAzk/vvovT3QadIDrq4Epv8Vn9MYsqqqJzzToIWu4QOWpkXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579804; c=relaxed/simple;
	bh=RVI7t+k8jlfEWU1sN3JT3HYvr4gTNtmmIHtDAPO01LM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ALj2hFgBfYC3lXn+L2ngL0zUD2TtpFWPpyeIpYS+xSrgFzqXiXa6Oo7+5iM3N6ZLfAFmF6uZcfWNVWpyu4bs0wGflpNl0MR6T5IpYDNt9RPqSgkVHnRGz1mQrHQJshgcNiatoesvOprBhKWMzBet0urXRoKVJIktMpDbbemuAb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1lxEZJ9c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1lxEZJ9c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088FB1F000FF;
	Wed, 16 Sep 2026 17:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789579798;
	bh=Oi4J1yoTZjWTQtgRtGtLRLQs9Gc/+HS81au1Kq0qeQ0=;
	h=Subject:To:Cc:From:Date;
	b=1lxEZJ9cbTdwMc6l3gvvyck/GXgyqkedV081CoybjnX3aj5JinmxiIQDEI3d2HVJc
	 4bgpWDyJr7O9QzB/J4wOQGY41/48Njjj0f9FrYi8Se1+gcrWSC6rkYoXWn3CttZ5ry
	 1f/LD5U+yD/vYq6YwRKT+dpY8pIOO9CSokd4dbXM=
Subject: FAILED: patch "[PATCH] xfs: fix media verification ioctl for internal rt volumes" failed to apply to 6.18-stable tree
To: djwong@kernel.org,cem@kernel.org,cmaiolino@redhat.com,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 18:25:42 +0100
Message-ID: <2026091642-cohesive-swimmable-562b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f789d291bbdac6bc02d9d77e0141e138626c17a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091642-cohesive-swimmable-562b@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f789d291bbdac6bc02d9d77e0141e138626c17a8 Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Thu, 20 Aug 2026 20:58:06 -0700
Subject: [PATCH] xfs: fix media verification ioctl for internal rt volumes

A media scan of a filesystem containing an internal rt volume produced
an error in xfs_scrub phase 6 complaining about a truncated realtime
device.  The rt device wasn't truncated, but the media scan code thought
we were trying to start a scan past the end of m_rtdev_targp.  That in
turn is an alias for m_ddev_targp, but in xfs_configure_buftarg we set
nr_sectors to the size of the data section.  We don't account for an
internal realtime section, so the kernel doesn't scan any part of it.
Oops.

Reproducer:

 # mkfs.xfs -f /dev/sda -r zoned=1 -d rtinherit=1
 # mount /dev/sda /mnt
 # dd if=/dev/zero of=/mnt/a bs=1024k count=100
 # sync
 # xfs_info /mnt
 meta-data=/dev/sda               isize=512    agcount=4, agsize=32768 blks
          =                       sectsz=512   attr=2, projid32bit=1
          =                       crc=1        finobt=1, sparse=1, rmapbt=1
          =                       reflink=0    bigtime=1 inobtcount=1 nrext64=1
          =                       exchange=1   metadir=1
 data     =                       bsize=4096   blocks=131072, imaxpct=25
          =                       sunit=0      swidth=0 blks
 naming   =version 2              bsize=4096   ascii-ci=0, ftype=1, parent=1
 log      =internal log           bsize=4096   blocks=16384, version=2
          =                       sectsz=512   sunit=0 blks, lazy-count=1
 realtime =internal               extsz=4096   blocks=1114112, rtextents=1114112
          =                       rgcount=17   rgsize=65536 extents
          =                       zoned=1      start=131072 reserved=53248

IOWS: 512M data volume, 3.1G internal rt section.  Now let's try some
media verification:

 # xfs_io -c 'verifymedia -d' -c 'verifymedia -r' /mnt
 verified 536870912/536870912 bytes at offset 0
 512 MiB, 1 ops; 0.0496 sec (10.067 GiB/sec and 20.1345 ops/sec)
 verified 536870912/536870912 bytes at offset 0
 512 MiB, 1 ops; 0.0409 sec (12.222 GiB/sec and 24.4439 ops/sec)

Notice how xfs_io says we only verified 512M of the rt volume?  If you
run btrace in the background you'll see that we read the first 512M of
the volume (aka the data section) twice and never read anything from the
rt section.

An earlier fix tried messing with the buftarg geometry, but I've decided
on a more targetted fix for the media verification code.  All we have to
do is calculate the starting and ending daddr for the device that we're
verifying, and clamp the user's input values to that range.  This leads
to some bogosity in the output reporting:

 # xfs_io -c 'verifymedia -d' -c 'verifymedia -r' /mnt/t
 verified 536870912/536870912 bytes at offset 0
 512 MiB, 1 ops; 0.0606 sec (8.248 GiB/sec and 16.4968 ops/sec)
 verified 5100273664/5100273664 bytes at offset 0
 4.750 GiB, 1 ops; 0.3329 sec (14.267 GiB/sec and 3.0035 ops/sec)

Because we don't have a way to report that we didn't really do anything
at all for that first 512M of address space of the rt "device".  But at
least we're no longer ignoring real media.

(Note that the fsmap/bmap/fiemap calls all report physical addresses for
the internal rt volume as offsets from the start of the data device, and
the media verifier call consumes the same.  We baked that into the
user-visible behavior in 6.15, so we're stuck with that sparse hole at
the beginning.)

Cc: stable@vger.kernel.org # v6.15
Fixes: bdc03eb5f98f6f ("xfs: allow internal RT devices for zoned mode")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_verify_media.c b/fs/xfs/xfs_verify_media.c
index 5ead3976d511..b75c81f8fcc0 100644
--- a/fs/xfs/xfs_verify_media.c
+++ b/fs/xfs/xfs_verify_media.c
@@ -268,6 +268,8 @@ xfs_verify_media(
 	struct xfs_buftarg	*btp = NULL;
 	struct bio		*bio;
 	struct folio		*folio;
+	xfs_daddr_t		dev_start = 0;
+	xfs_daddr_t		dev_end = 0;
 	xfs_daddr_t		daddr;
 	uint64_t		bbcount;
 	int			error = 0;
@@ -277,24 +279,33 @@ xfs_verify_media(
 	switch (me->me_dev) {
 	case XFS_DEV_DATA:
 		btp = mp->m_ddev_targp;
+		dev_end = XFS_FSB_TO_BB(mp, mp->m_sb.sb_dblocks);
 		break;
 	case XFS_DEV_LOG:
-		if (mp->m_logdev_targp != mp->m_ddev_targp)
+		if (mp->m_logdev_targp != mp->m_ddev_targp) {
 			btp = mp->m_logdev_targp;
+			dev_end = XFS_FSB_TO_BB(mp, mp->m_sb.sb_logblocks);
+		}
 		break;
 	case XFS_DEV_RT:
 		btp = mp->m_rtdev_targp;
+		dev_start = XFS_FSB_TO_BB(mp, mp->m_sb.sb_rtstart);
+		dev_end = XFS_FSB_TO_BB(mp, mp->m_sb.sb_rtstart +
+					    mp->m_sb.sb_rblocks);
 		break;
 	}
 	if (!btp)
 		return -ENODEV;
 
 	/*
-	 * If the caller told us to verify beyond the end of the disk, tell the
-	 * user exactly where that was.
+	 * If the caller told us to verify before the start or beyond the end
+	 * of the disk volume, tell the user exactly where the volume starts
+	 * and ends.
 	 */
-	if (me->me_end_daddr > btp->bt_nr_sectors)
-		me->me_end_daddr = btp->bt_nr_sectors;
+	if (me->me_end_daddr > dev_end)
+		me->me_end_daddr = dev_end;
+	if (me->me_start_daddr < dev_start)
+		me->me_start_daddr = dev_start;
 
 	/* start and end have to be aligned to the lba size */
 	if (!IS_ALIGNED(BBTOB(me->me_start_daddr | me->me_end_daddr),
@@ -323,8 +334,7 @@ xfs_verify_media(
 	 *    verifying.
 	 */
 	daddr = me->me_start_daddr;
-	bbcount = min_t(sector_t, me->me_end_daddr, btp->bt_nr_sectors) -
-			  me->me_start_daddr;
+	bbcount = me->me_end_daddr - me->me_start_daddr;
 
 	folio = xfs_verify_alloc_folio(xfs_verify_iosize(me, btp, bbcount));
 	if (!folio)

