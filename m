Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580219;
	b=H5bPrP/r8DYrYegh3y+66Jk9IoHIQ/WdhvGe2Kdr/btX5uBCf4ZT76SGpreL21kUax+v
	 Sr8mo5hu5vU9Xh/sqVadtzjItSQpnygWphRYgqj7c+teiZfevBZoUD4kpoXdjiGiazqJ/
	 A92TcRJ4JRxNg7WNEamDT3KI/JXcI1lRocIPYXnFKOduDEE06JgbVeJdV6q9ovyM+ci/L
	 fqhrlGRgPDnp0EyeuzFW6BN5q+zmPoTrWDQS9N57Tq9yBimzvmGBKpkewqIegTXsOSJmC
	 CGd0RivmQ3avPsdLQE1+Tz/TE8CVxhgfh/tQh88TN7Xfvhuhl7BfuOdb/aLbFIJ8SrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580219;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PSZ2zDU8DJLWMNTG7yqCgwjHu17E+StsJn+sAchdP90=;
	b=yVlQhf3/4dGLq9kIsT53+0NZmF1GIt4xjXefCmhGesrr22tbp+2nfqr9X6XfpQkQGxTo
	 sEeviKJjo+WBBfHfOj4g53lLK7/GAtkUBOo2N1FKe3Q3+DV3sslZNpPiS08s134yY1+DA
	 aG4VcWEaJKIpxjnDYZpxmuGCTU4Mz+sDKNGDytXmYP2xDpOEs/+2Z5V1Z+cL5kUH08BFs
	 2zMEWxMXY1w45bb+UfFU3VM1bJ8LCCkJDFhFDuyfTLHOn/U2GTX5vd57iXMt0ilD+mH3w
	 BwDHQz1lqx3sswAaXx1yT7UD4t5Jj/0v8o2PdCnmMp6p4tp1Pu+RsiuOsodhSAcwZDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCrWDeaO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA46606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCrWDeaO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACC11F000C4;
	Fri, 13 Nov 2026 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794580219;
	bh=PSZ2zDU8DJLWMNTG7yqCgwjHu17E+StsJn+sAchdP90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lCrWDeaOjMlauyr/WJSnD5L3Xu7C0kCMdIvD28gKAwuOFjepsJRxlHqxv5oW9ZR6V
	 a3abz6Ie06oCpvmujRC70e+FLRNIOIfGRD6XTX4IXEdNnFTO5csGwnf8Q/9CWySt73
	 mh9rIFbiygfAOVWSGSUgrgCNaSiluoS9lYVSU6XAp5yDWlvHolYVktCxju7oJ0gy6q
	 t0mE8Hv4uaKCmQDTigeXtrA/HvvmONIr73Gu1huQHG8kyQ9TLT8DCIvGPcTfD7Ahiw
	 0juVbT7KFeeZ8c488oQsp+2AR9SKcgeWRW/VfG5cvbpkQ+KxtQ78PrUsPlqqRUNUTT
	 h9sK9fS7srmFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Bartosz Fenski <bartosz@fenski.pl>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] btrfs: raid56: do not verify the content if there is no data checksum
Date: Fri, 13 Nov 2026 09:30:17 -0500
Message-ID: <20261113142954.1775698-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052120-failed-6.12-d00b85308abe@kernel.org>
References: <20261107052120-failed-6.12-d00b85308abe@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit d00b85308abee300dfb7e1ac642f38bab9ec7492 ]

[BUG]
There is a bug report that fio can fail to sync the data on a degraded
RAID56 mount:

  # mkfs.btrfs -m raid1 -d raid5 -f $dev1 $dev2 $dev3
  # mount $dev1 $mnt
  # btrfs balance start -d $mnt
  # umount $mnt
  # btrfs dev scan -u $dev2
  # wipefs -fa $dev2
  # mount -o degraded $dev1 $mnt
  # fio --name=degraded-write --directory=$mnt --rw=randwrite --fdatasync=4 \
		--bs=4k --size=512M --randrepeat=1

The run will fail at fsync:

  fio: io_u error on file /mnt/btrfs/degraded-write.0.0: Input/output error: datasync offset=142254080, buflen=0
  fio: pid=2064, err=5/file:io_u.c:2008, func=io_u error, error=Input/output error

[CAUSE]
With extra debug output, it shows the problem pretty well:

  rbio=2876243968 faila=0 sectornr=0
  rbio=2876243968 error=0-15 csum=2 bio=15

The first line shows the rbio's full stripe logical, and stripe/sector
number when verify_one_sector() failed.

The second line shows more detail about the rbio, the sector range [0, 16)
is corrupted, which indicates the first data stripe is corrupted, matching
the missing device.

The important part is that the csum bitmap shows the data csum is only
for sector number 2, meanwhile the failed verification is at sector
number 0.

This means we did the checksum verification even if no corresponding
checksum is populated.

[FIX]
There is already a similar check at verify_bio_data_sectors(), but
unfortunately there is no such check at verify_one_sector().

Add the missing check to skip the csum verification if there is no
corresponding data checksum.

Reported-by: Bartosz Fenski <bartosz@fenski.pl>
Link: https://lore.kernel.org/linux-btrfs/a72409af-45ef-45df-9970-2e38bcb22ea6@fenski.pl/
Fixes: 7a3150723061 ("btrfs: raid56: do data csum verification during RMW cycle")
CC: stable@vger.kernel.org
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ sashal: Adjusted verify_one_sector() context for the existing struct sector_ptr and btrfs_check_sector_csum() instead of physical-address helpers. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/raid56.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 8afadf994b8c8..9f8515370eb8d 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1789,6 +1789,8 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	struct sector_ptr *sector;
+	const unsigned int total_sector_nr =
+		stripe_nr * rbio->stripe_nsectors + sector_nr;
 	u8 csum_buf[BTRFS_CSUM_SIZE];
 	u8 *csum_expected;
 	int ret;
@@ -1799,6 +1801,11 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 	/* No way to verify P/Q as they are not covered by data csum. */
 	if (stripe_nr >= rbio->nr_data)
 		return 0;
+
+	/* No data checksum for this sector. */
+	if (!test_bit(total_sector_nr, rbio->csum_bitmap))
+		return 0;
+
 	/*
 	 * If we're rebuilding a read, we have to use pages from the
 	 * bio list if possible.
@@ -1811,9 +1818,7 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 
 	ASSERT(sector->page);
 
-	csum_expected = rbio->csum_buf +
-			(stripe_nr * rbio->stripe_nsectors + sector_nr) *
-			fs_info->csum_size;
+	csum_expected = rbio->csum_buf + total_sector_nr * fs_info->csum_size;
 	ret = btrfs_check_sector_csum(fs_info, sector->page, sector->pgoff,
 				      csum_buf, csum_expected);
 	return ret;
-- 
2.53.0

