Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580505;
	b=EXEEHXhUNvVKk5de2K4L3dKKcZjbze+121+rjT1ICuQgOGxN8w7CMmgbM9pqhpvngjlu
	 ZYo0ZcMkFW6nKCj+SPTEoW0K+/m4l4Z9PlRH9lZtNimZU5QmOrlImkux+W88r0UIoJXr7
	 GhVMiblYICg568LuRn+0y6lMqQqaLD+XRwuQguipa0bJEbgbzNf683076GlsmRoF4kwiC
	 gKrY08jZP+OdxHiXysmucJYpHa5DWubVtXnoDnrFdG0uiAkLa2FrqTpC00O26t4zhjHoE
	 c/3pNuLJuffodUuli5G1O5uvi7VKiQm8MnrSKGCSc1sgk9G7gCdU4Mib4EPWMlbnUcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580505;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GWg4AZZpi26qWCGg9kf/4HgOeC1ok7oerA087DRSWuc=;
	b=ketbIrKSRzj1LD5yfFlVpmkLGoY6COEAGIoXSbEzxTGFD1uaVaCe53tb5S364cq7y7wa
	 eCeXguyZ242a79yriveUmCdrHCVSN9FR7UG2U8HwILerRXfz4I0pla8irkjWIi7yhe9Qu
	 f0vkGxfciqSzuJtzq9gAz0+KmJLGDa7eWBmUYhtMOmGsLONFMej/X03rLfZFro/NO1pAM
	 MzpD0kM67S6dOrf8wKqLrvcypW+pHY0qOGSU7g3910E0wQMSEXmhTLoQPJN5w1tk52IgQ
	 IIXoFl7u1k8RINR22rqvWEAzEhKR359Ow3JoSuXH2MO0oVPMD90OqpJpXHRwSHHzn7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcRDQb4G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B6060A2604
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcRDQb4G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D37A1F000C5;
	Fri, 13 Nov 2026 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794580505;
	bh=GWg4AZZpi26qWCGg9kf/4HgOeC1ok7oerA087DRSWuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WcRDQb4GVSAYuDIDDDBz/KK5aekX+nb6vnAH/NP9DYicSIsQ9fJ1gdnKzmWJnK71a
	 6GmClybJhrprQRLbZtZMSpCXD880yYGa+Zr3Hn6xi/ozi6QYPPi69Wkaa+4CkHKIv5
	 olfjAanlqPYaNcUOz3bRLAoVKvaciJaBdPtjcsYqp0cLbKZBti9Kc3T5yt8DiPjhcm
	 hb3OREvT4tu6zOCM7vR0H3ir2gez8bi2xAw2mstIa1sWA5Dgd2KJCEA2vbsi48eMRM
	 xjxBIXD1nuvN4NaNFMG6/HjhFHU5KBXea/zQU0lC9jbXmjpBxvxrSCTk5tzvF7DRM2
	 YAmFgRUU18/Ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Bartosz Fenski <bartosz@fenski.pl>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] btrfs: raid56: do not verify the content if there is no data checksum
Date: Fri, 13 Nov 2026 09:35:03 -0500
Message-ID: <20261113143440.1807015-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053346-failed-6.6-d00b85308abe@kernel.org>
References: <20261107053346-failed-6.6-d00b85308abe@kernel.org>
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
[ sashal: adjusted context for sector_ptr checksum verification using btrfs_check_sector_csum() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/raid56.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 3e014b9370a3f..ce7baf55e6213 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1680,6 +1680,8 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	struct sector_ptr *sector;
+	const unsigned int total_sector_nr =
+		stripe_nr * rbio->stripe_nsectors + sector_nr;
 	u8 csum_buf[BTRFS_CSUM_SIZE];
 	u8 *csum_expected;
 	int ret;
@@ -1690,6 +1692,11 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
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
@@ -1702,9 +1709,7 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 
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

