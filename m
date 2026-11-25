Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606329;
	b=anPkGF0VPogKbJwAaguRMYRVjtJ4mLPnB+LxMbtDJGngVNDazAZVUAH80iNgQ9NX9g/O
	 9P6Vg+0TzmVAH7BMR2cm2cPSarTlgp2WKcn60k809PdlVuZwpwm7Tu8wNa0pJ2SYCfOYb
	 sGtkkzo+x1nCAhklJyaWkKEJBjES67FNgp1KEPc1KiN2JUlyJKuGxiaF1pvglCoedXmZE
	 /Jtp8IXtKvfA+GgjiH1iRbzL6fDD5j44Hcy/NBl4rbaSLA54dgg9Fa/BFAYds5buwn14Z
	 mGuUbJxWhJI7dX56JJK6HvLyxAOXQEw5MHUp5U8aWX+uC3KhZErSDTcpHRY1/qAGb1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606329;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GaqSUAmk4FJxO7znC2lX0VSc0hVBN6U6Mgt2xau/W1w=;
	b=f8cc/1AydyODoxMMRDJwlFOxOBriS1Z+mpSTJxsuQ6wpLXvZbQHYtEALTLVrOuuAK48t
	 +x01RcBL0GIn2DIBVbjrCPG0rPEEXABq/gP3r/hwoi06I52gUIQCE2lIPPVNX04PFrOTE
	 kqA53d8GHnghwBwOpWnWo2vrx4wI3Y7EqwL3mvDSWVqUS506Y3SGpeV1eFC3Y25xBi0YX
	 d9reY7+KE0LnaHP430jIpQ5WvdhhgN2YD0ml/gI0WeIIfxLeWbTQZWqqYwZLQQlOf+Smn
	 5wh1faKP14uNaJbifphN4/OGBVz95NJCgOnirDRuiBW26G6RKWHYRtFr9irOYAAU6FA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=d1iK6bKV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6816F606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=d1iK6bKV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1501F000C0;
	Wed, 25 Nov 2026 11:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606328;
	bh=GaqSUAmk4FJxO7znC2lX0VSc0hVBN6U6Mgt2xau/W1w=;
	h=Subject:To:Cc:From:Date;
	b=d1iK6bKV6lO82+eGGiwKDgIRqXebxmwM4XiiH05o7mrY0qD8HgjZ/QbJmFi0K54IW
	 dxnYRBMDh3rVOiP9x2kaZmfBE1iVZmI2AIJceS8LeOSsWISvIoIZ2Xo+ORnodB0wem
	 RRjiIj93ux+5ETa9TSKtXWdAhJBBZmTiOl2zDs+Q=
Subject: FAILED: patch "[PATCH] dm: fix infinite loop in dm_blk_do_report_zones()" failed to apply to 6.12-stable tree
To: mkbund@amazon.com,dlemoal@kernel.org,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:18:27 +0100
Message-ID: <2026112527-unequal-wilt-0a1c@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 648320de920b30ae1730bbf0e8b86c0df0fb490a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112527-unequal-wilt-0a1c@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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
 

