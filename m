Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606339;
	b=aTFp5Nva6VT/Jcl+eEsUm/iZxuvPg9C4yaOCVs2puk6Z7H5cjD2Ar+ddpOsVqNHYY6oY
	 nIqxkj4xne9eZ78aU/LbKHPVHzSHR0SCX9G7B9iQYvph74Eaw9a5klB9rNJg2n7WtQ7oF
	 nMVkQCyv6+wlqq4AM1//sz1u6h/pC6Uh/CFXtHqVX9JA8JElyqJxsjiMJDH15Mbtvc8k0
	 hVNm5e588nzh76knpHN6vr74J9359YiiOYIXa+qlCfYiIn9DUgs7JQgN4XKrNRPUGVWDq
	 3MCtChRc7pqeo5BM6T5uWbpl7egYFfCa31NIuGG1mKQbKOyYjgGZzVnCSNDa0+JxaGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606339;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C11n+0d3+wpf69MzNrP4T/iqDKyatAbnNbCVaZ/Ert4=;
	b=dIW1vJHyjbFUICCLdtlhM8F/eYzrSplzYeRnBpVvQcCXA/okRMmjQAep4kYUoX5djZzJ
	 hoNVtAsc6CoBt+AMjhlJWrQXHm9ycFi2rsIgX5gwt8Y5ezMadsmztMNFlAt84uRcY4qoK
	 cAXX2vyDB/mr1igwU4IG1DM5CItzextI+DeryrYXXZGyz3EBsnIS0vNhXszq97FzbXZbH
	 0IwEUMA+cjJ3aVfyDoWVJLUtXD5LhRq4Nv109doVX+aXY18eKACgv88BNhi+5luKf72cX
	 QBeL8jQx+OL0iv6I9w4d8CWwqp53gGTOGvn3qNxH+ZH3NeR2dYo1Yc2oUjrZThWTVcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=owSyEnS3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E1A606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=owSyEnS3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA2C1F000CA;
	Wed, 25 Nov 2026 11:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606338;
	bh=C11n+0d3+wpf69MzNrP4T/iqDKyatAbnNbCVaZ/Ert4=;
	h=Subject:To:Cc:From:Date;
	b=owSyEnS3z3Rx1wL/EyTA+ztGGdpemv4WGYiXRUFBeJvQ+ppeZsu4cMkL5zifWo3bm
	 wsOBIQszWH8mM7p3Np9WNvSB3l5FX+LiSj4UCkRwzWZZd6cIs8kJ6ZwQqjM5U6Y+sb
	 32w+Zwl9uS4x5MMD/cDNFcUT5RGVhvFbQG7y1N1k=
Subject: FAILED: patch "[PATCH] dm: fix infinite loop in dm_blk_do_report_zones()" failed to apply to 5.10-stable tree
To: mkbund@amazon.com,dlemoal@kernel.org,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:18:29 +0100
Message-ID: <2026112529-pulsate-grass-2146@gregkh>
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
git cherry-pick -x 648320de920b30ae1730bbf0e8b86c0df0fb490a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112529-pulsate-grass-2146@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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
 

