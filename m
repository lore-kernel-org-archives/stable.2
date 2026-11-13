Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578707;
	b=Byn0Yn6323+fp5GEt1Cd3I2pJCe+uDlGIptMyesETpDWsOcv5ckDLXnAt8gJAXl2PP98
	 o1QhS2DLkA32zJQ5N5Am+fezLjgbI5ELTiYSb7hJaK0Ro5Hs91/zyxiPWpfD9TY7I9EmF
	 J8O8wxsl1o8rL6aNemKQw/500CK9laaL1NZPTOOJsnPjI4MNtHBfQSbSKFOlM6bE7rNZY
	 CEieKlnYu73JGRHERwnGjkiYdsUnzKrZZO3O9yot3D8fa/yNffpP8u0sXkaWdXGpIgfj4
	 k/tTfEgTRZ4rvbXxKTMWTL3/UH2lREkAo13pVGImIDDwaYwd0ajSAC8FBYZzp6OnTGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578707;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=H3crmsW4TBvlnxarFptrPiyZrI/Gm3dSUfnZFWLW/9M=;
	b=GoN3dtMWHqNBUGNCJ1ZzhcuYJJ32Du7zBMjG4UnKasIVd5o4gEOfN9yjRFB1StSRbX+x
	 tuSK7thAQfxB+LpdAAoyRl52IZaaykfLzD1wCzHlFFviMA6bHF0nCa67QRvko4F/3OpoY
	 MKejYqhtO1f7bEXHtITYfJEQkbzunXFEvokAp0LW8fKKGNSkjcyBUWcESKeFvgUjPtatl
	 z81q//g6WCVVjFkspqSubARisoqCeZj5vx1kFOZhW1XdxGPsKB5dPZtnQkb5JF4dU9IdH
	 7GFDJAC4Cx4YxNGMpznMf0THTZDyRgEwgZ1rHvJXCt+A/IzCK3MW8jH8aUe8Kl3TwJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTr8SUFo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECCD606A33A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTr8SUFo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDB41F000C6;
	Fri, 13 Nov 2026 14:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794578707;
	bh=H3crmsW4TBvlnxarFptrPiyZrI/Gm3dSUfnZFWLW/9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kTr8SUFonYxrt+OjC15EMQpoH6uZk+2h5gwR54TllCPK4tQ3t/2a6QKHYfft4V/E1
	 lCOLPBlw1JNGhPwJimM3eLRJ6o5wZlEatPpWB4V2k5hpOVVrOx7htLcgrFyHVk6EkH
	 5mDsGbwoi18JVahynhsCq1Udi40ApagzMWNFAhQEzXLXS6zmg3/JXr5KaGIWf8S8gg
	 R2Q5rPPdGU9acJ+zBkPGINsmywMHdlWpO8uovGn+2eTYWd/x0q7rrXD/mjNYV0iCqa
	 yUm6ssAgpwsDwwoZ4FECq61ekbDKmTc2hukVd6lbXzLrVnD44PUEbmQMsPHM4uEW8J
	 2NGwvcETAhENQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Bartosz Fenski <bartosz@fenski.pl>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 5/5] btrfs: raid56: do not verify the content if there is no data checksum
Date: Fri, 13 Nov 2026 09:05:01 -0500
Message-ID: <20261113135926.1497314-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113135926.1497314-1-sashal@kernel.org>
References: <20261107050424-failed-7.3-d00b85308abe@kernel.org>
 <20261113135926.1497314-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/raid56.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index a5d0ef09d92ab..3412f43d5dec1 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1892,6 +1892,8 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	phys_addr_t *paddrs;
+	const unsigned int total_sector_nr =
+		stripe_nr * rbio->stripe_nsectors + sector_nr;
 	u8 csum_buf[BTRFS_CSUM_SIZE];
 	u8 *csum_expected;
 
@@ -1901,6 +1903,11 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
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
@@ -1911,9 +1918,7 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 		paddrs = rbio_stripe_paddrs(rbio, stripe_nr, sector_nr);
 	}
 
-	csum_expected = rbio->csum_buf +
-			(stripe_nr * rbio->stripe_nsectors + sector_nr) *
-			fs_info->csum_size;
+	csum_expected = rbio->csum_buf + total_sector_nr * fs_info->csum_size;
 	calculate_block_csum_paddrs(fs_info, paddrs, csum_buf);
 	if (unlikely(memcmp(csum_buf, csum_expected, fs_info->csum_size) != 0))
 		return -EIO;
-- 
2.53.0

