Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045867;
	b=ALj4vVjyTx+M2btMb4si+awrpLhXKSlqc0CLh6XKQIlPBtxHBoc3OfiUS5HSbpHSnccC
	 56qUsNEBq/OLuKqPejUm4+0XjdbozKzkfmhylYOHmdhdhh2RomkWaImxdx2QbPod+p9Xw
	 oTKIyYE368RVKZ9s71sbwBYsTQqy2Taei3LgH//5sOgx0YKugxd/dBNfY0hckhg7UioU+
	 +e0G3lmwtoLdVEpRlZt7s///0b170yV2bq/oJr9ngxWZv3h0pcf4KSfcODH3BzFW+hqlX
	 fTAoTLAmKpq741ogsENvVuIKny+qYILo3m4w633UH3BCLEdM6fEQVS9j2+7VniIig9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045867;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qIFoEDlSietCp4LxnDFWbEXY+DSEj7vxmiIIXDKhTdU=;
	b=fBHqIuL8tcmNUCYTjzVCYcUmlQAbXFfqJeuEdhPX5UwGtxEnAlcaO/iYhxpSplblt9vT
	 vFhqWhvjMVcIToVxyAVEE0fZVukPy79GvCU6ZWwPhKuddh6cUF0yq7AQFA/0o8jnfo3U9
	 ZJYJ4b86ogsCzxqVqwB69BGmnXpjtfJwwxqssUcvpuKfIr7XQo/MzLCN35njto5uRhxOx
	 jJM0jUGytyBi5jrz85VCRqataQ2jp2jVahFhtddnfKDpKATsPNHG182gqLOLLgtOpxIYN
	 78cC8mqyaWJDfoTYjPHyv1hYWmCsV3tjAZwX7fso6F+vvanVSeRDaEP2YwJ1b00cA4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aHH5umfz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A2C606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aHH5umfz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB45A1F0089F;
	Sat,  7 Nov 2026 10:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045866;
	bh=qIFoEDlSietCp4LxnDFWbEXY+DSEj7vxmiIIXDKhTdU=;
	h=From:To:Cc:Subject:Date;
	b=aHH5umfzYd2FJp2gG2+IdYqapGauIfdyPqFDb4MfbnRwADzibOCD4LQNR3mzWi+gg
	 BtjhS1p0sIsBsCDoqhj2UkmV2GmLyjfjWX9wXHKvJGAQOWHtouKZ35cIiqYzVGFlIy
	 Fmv1jFBDgNTtcZm+ws5qiLDHGY+ZupGea3/t0CMoKKPFPwWWhMgOcrU4PSoXjFJjly
	 MqNdH/JNbgqPOoDNi4gqSCxXCN3d1HJPxqHSxxbPXJQcpHiPno9vZCCFCQCSIZuFPg
	 vb5owywko6+pquBNYKNKRAiJAOvrIef1FkhywMZO+s3od/RRKniPNLGBe+FeuuPbRa
	 P2jiOKAP0SnnQ==
From: Sasha Levin <sashal@kernel.org>
To: wqu@suse.com,
	bartosz@fenski.pl,
	fdmanana@suse.com,
	dsterba@suse.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] btrfs: raid56: do not verify the content if there is no data checksum" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:24 -0500
Message-ID: <20261107050424-failed-7.3-d00b85308abe@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x d00b85308abee300dfb7e1ac642f38bab9ec7492
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050424-failed-7.3-d00b85308abe@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d00b85308abee300dfb7e1ac642f38bab9ec7492 Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Wed, 30 Sep 2026 18:29:58 +0930
Subject: [PATCH] btrfs: raid56: do not verify the content if there is no data
 checksum

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
---
 fs/btrfs/raid56.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 8ec24dbb180f9..5ec31299f1c30 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1889,6 +1889,8 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
 {
 	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
 	phys_addr_t *paddrs;
+	const unsigned int total_sector_nr =
+		stripe_nr * rbio->stripe_nsectors + sector_nr;
 	u8 csum_buf[BTRFS_CSUM_SIZE];
 	u8 *csum_expected;
 
@@ -1898,6 +1900,11 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
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
@@ -1908,9 +1915,7 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
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




