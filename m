Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606332;
	b=P5xRo4j/5159gV5GBZXGOYtBTg8G8HwKycM4aXuNaiku0sG97BWjXSECwcPCQ7kAbMFp
	 8M0awViqy4bSrMXP81I+ZBllgYdChUDjd/n/2QZsN0JCZCYtG93ds33uBGwJEMU+46Lx6
	 0WaiZ7QBNc0EyBVlIwvcDmjh7mE2idBjusLUykENDorlcC49B0v+z1ZQaa4e33IC0601F
	 LnVgDfHMsnAhu8+AZhyJ+F4kpTBCc7sy8HJkYFx2XXgueuiXCsgHvzMEYA+dAUlTkRrwH
	 IHtPCXYYaNUMQ8yoKAegJlkQOiav2ByY4USCrhRuo+jdgd5H+Bx2h2RODeTIJb0ry/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606332;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LWG0NoS2gMNI6wMq1SZUma9XWgiUcuTmuYMS9ZFYKeY=;
	b=5HKjmNA0vmO3chqk2iFjgURiNvPEqXKxGAAw6N5ZfBmFEkJ9Zjc8x5xjfIy+qNx3mN+F
	 XbX8hPcoA57IpQEdDRhGAgZMykWqxLDk3QMdJHiZgXqK2KBJjKDDmWU2hlos4PnZ/XaDC
	 XtRuxHxT4v1r+a1Re1Xynxk1mIv3BhE7Hcq3hyU+n+zkf/eYmJdGO6jzV1xggJmdXyWP8
	 zlrVgEx5RKTMWb+BR+mxfHYM/A0DnsINC4SDeXtzHNr0wby75LRlBFnFPhDUplUX4hMzF
	 r83DsZ6O7EAKh7RFbEMEUIo9aivNjdcJTZcxCKdc7wObeOKEwMZ6dtNjd1pGFIDtW7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=AV7VWuwU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8A5606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=AV7VWuwU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA091F000E6;
	Wed, 25 Nov 2026 11:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606332;
	bh=LWG0NoS2gMNI6wMq1SZUma9XWgiUcuTmuYMS9ZFYKeY=;
	h=Subject:To:Cc:From:Date;
	b=AV7VWuwU9y7sgcdNKrMOIv8wnUwnrJeJpDQgh/EEiD10ZvPrcekVMO9fl9/zNW/8L
	 RSYPGywgaa2OG0KSZlnn01wOrtG7WxmaonUFJTf/a0SL2IdvnmatzJ8v0RCucgRneg
	 YAX/mRmAd3/f4BXh9HFVkVOkotWiURJ7v59uBW2A=
Subject: FAILED: patch "[PATCH] dm: fix infinite loop in dm_blk_do_report_zones()" failed to apply to 5.15-stable tree
To: mkbund@amazon.com,dlemoal@kernel.org,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:18:28 +0100
Message-ID: <2026112528-skyline-strongbox-22b3@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 648320de920b30ae1730bbf0e8b86c0df0fb490a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112528-skyline-strongbox-22b3@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 648320de920b30ae1730bbf0e8b86c0df0fb490a Mon Sep 17 00:00:00 2001
From: Mark Bundschuh <mkbund@amazon.com>
Date: Mon, 19 Oct 2026 19:28:19 +0000
Subject: [PATCH] dm: fix infinite loop in dm_blk_do_report_zones()

If the device underlying a zoned target is removed, its capacity is set
to 0 and blkdev_report_zones() returns 0 without reporting any zones.
The mapped device keeps its old capacity, so args->zone_idx and
args->next_sector never advance and dm_blk_do_report_zones() loops
forever. On non-preemptible kernels this causes soft lockups and RCU
stalls.

The following sequence of commands triggers the hang:

modprobe scsi_debug zbc=managed dev_size_mb=1024 zone_size_mb=64
udevadm settle
echo '0 2097152 linear /dev/sda 0' | dmsetup create lin
echo 1 > /sys/block/sda/device/delete
blkzone report -o 0 -c 1 /dev/mapper/lin

Fix this by returning -EIO when a target reports no zones. The target
always maps args->next_sector, so a zero return means the underlying
device no longer covers that sector.

Fixes: d41003513e61 ("block: rework zone reporting")
Cc: stable@vger.kernel.org
Signed-off-by: Mark Bundschuh <mkbund@amazon.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 35916c6e490e..9ddbb67e97e5 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -33,6 +33,8 @@ static int dm_blk_do_report_zones(struct mapped_device *md, struct dm_table *t,
 					      nr_zones - args->zone_idx);
 		if (ret < 0)
 			return ret;
+		if (!ret)
+			return -EIO;
 	} while (args->zone_idx < nr_zones &&
 		 args->next_sector < get_capacity(md->disk));
 

