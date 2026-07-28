Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1E1C862F;
	Tue, 28 Jul 2026 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785271781; cv=none; b=Z7yZaSFGJAqglzYSu0pXOWiwnCKMV20k73OhCi/TQxkzoeYalX0kToF+lqFLB6+RyzWxmkr9sZl8hUv7ViqFI+hHjogI1iRmeacMLqLahU5vIdqJIO1hTw9og1etW2HZJmoFVZcElR34SMnvLDRgeM+fxxT8oXXGVYKxCZ0pNTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785271781; c=relaxed/simple;
	bh=c5hudVdnzwY+IIN3aq7FxRaOzUnoOdkhftDNJVr6cJc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BoC7nhAk9lJ3cGOcpr/r21n/IQ7rclv3VLr90znqkmw3I5Tfz+wH04Mnj9qEX1ZB736vOpX8Sd6EDI86i8YVg8gKn/e63Nww4+mJ54MfRpXUuN0lKl2kvjZDc7OHRJlA0taUoya+dU/jpD5SS8LqCNGANe45qrxIlqiTWcPj4tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=CaffAYuF; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="CaffAYuF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1785271780; x=1816807780;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rteBlfPyVEI5nCax/H3OHuyikrjDCNL2OwoibbcDzbY=;
  b=CaffAYuF9e/jUq1vZVPKg6TtH+zlU2XgupGp4W8HwAFvfkgP1Zl7cg75
   95dPZf966EetiEbCjPUeAckTfbIcGiCXmyWaqpHBJ9twxVcjY9T+cnBY1
   tEyu/TCJr1Hi0jzhNPS4ctqQu6gNRNzjSi8OmQOYRLhms6RV1J6PD4KRY
   D5Fmmkr7kaPVBKnLQ0TOOsF5ur8kP483M6oGBgSaEKkrlueUKxrezAqEj
   ctHPECTtciNGiN3Kc6bFv7Q2Q0rmWzIqL4ZTReHUBct2ROq6tEkDrEWSY
   WMoouelHaIivXoqD17WvVvsoJtnorRCqofAPLI5e0I8hn83CkoaMngEyp
   A==;
X-CSE-ConnectionGUID: 7Hmt0+2SQVWeyLYgYNHkxA==
X-CSE-MsgGUID: xVmUVW4RTrCrIsUeGvUuRQ==
X-IronPort-AV: E=Sophos;i="6.25,191,1779148800"; 
   d="scan'208";a="24548750"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 20:49:39 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:16539]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.59:2525] with esmtp (Farcaster)
 id 5a5d2cec-ed45-4021-b3a0-623761b24eb4; Tue, 28 Jul 2026 20:49:39 +0000 (UTC)
X-Farcaster-Flow-ID: 5a5d2cec-ed45-4021-b3a0-623761b24eb4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 28 Jul 2026 20:49:39 +0000
Received: from dev-dsk-wanjay-2c-d25651b4.us-west-2.amazon.com (172.19.198.4)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 28 Jul 2026 20:49:38 +0000
From: Jay Wang <wanjay@amazon.com>
To: <stable@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <sashal@kernel.org>,
	<linkinjeon@kernel.org>, <sj1557.seo@samsung.com>,
	<linux-fsdevel@vger.kernel.org>,
	<syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com>, Yuezhang Mo
	<Yuezhang.Mo@sony.com>
Subject: [PATCH 6.6.y] exfat: validate cluster allocation bits of the allocation bitmap
Date: Tue, 28 Jul 2026 20:49:38 +0000
Message-ID: <20260728204938.14116-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 79c1587b6cda74deb0c86fc7ba194b92958c793c ]

syzbot created an exfat image with cluster bits not set for the allocation
bitmap. exfat-fs reads and uses the allocation bitmap without checking
this. The problem is that if the start cluster of the allocation bitmap
is 6, cluster 6 can be allocated when creating a directory with mkdir.
exfat zeros out this cluster in exfat_mkdir, which can delete existing
entries. This can reallocate the allocated entries. In addition,
the allocation bitmap is also zeroed out, so cluster 6 can be reallocated.
This patch adds exfat_test_bitmap_range to validate that clusters used for
the allocation bitmap are correctly marked as in-use.

Reported-by: syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com
Tested-by: syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[Adapted to 6.6: replaced __le_long/lel_to_cpu word-level bitmap access
 with per-bit test_bit_le() calls, as __le_long and lel_to_cpu do not
 exist in 6.6. Uses same test_bit_le API as rest of exfat bitmap code.]
Signed-off-by: Jay Wang <wanjay@amazon.com>
---
 fs/exfat/balloc.c | 54 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 32209acd51be4..2d4fe3d754bbc 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -45,12 +45,37 @@ static const unsigned char used_bit[] = {
 /*
  *  Allocation Bitmap Management Functions
  */
+static bool exfat_test_bitmap_range(struct super_block *sb, unsigned int clu,
+		unsigned int count)
+{
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	unsigned int start = clu;
+	unsigned int end = clu + count;
+	unsigned int ent_idx, i, b;
+
+	if (!is_valid_cluster(sbi, start) || !is_valid_cluster(sbi, end - 1))
+		return false;
+
+	while (start < end) {
+		ent_idx = CLUSTER_TO_BITMAP_ENT(start);
+		i = BITMAP_OFFSET_SECTOR_INDEX(sb, ent_idx);
+		b = BITMAP_OFFSET_BIT_IN_SECTOR(sb, ent_idx);
+
+		if (!test_bit_le(b, sbi->vol_amap[i]->b_data))
+			return false;
+
+		start++;
+	}
+
+	return true;
+}
+
 static int exfat_allocate_bitmap(struct super_block *sb,
 		struct exfat_dentry *ep)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	long long map_size;
-	unsigned int i, need_map_size;
+	unsigned int i, j, need_map_size;
 	sector_t sector;
 
 	sbi->map_clu = le32_to_cpu(ep->dentry.bitmap.start_clu);
@@ -77,20 +102,25 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 	sector = exfat_cluster_to_sector(sbi, sbi->map_clu);
 	for (i = 0; i < sbi->map_sectors; i++) {
 		sbi->vol_amap[i] = sb_bread(sb, sector + i);
-		if (!sbi->vol_amap[i]) {
-			/* release all buffers and free vol_amap */
-			int j = 0;
-
-			while (j < i)
-				brelse(sbi->vol_amap[j++]);
-
-			kvfree(sbi->vol_amap);
-			sbi->vol_amap = NULL;
-			return -EIO;
-		}
+		if (!sbi->vol_amap[i])
+			goto err_out;
 	}
 
+	if (exfat_test_bitmap_range(sb, sbi->map_clu,
+		EXFAT_B_TO_CLU_ROUND_UP(map_size, sbi)) == false)
+		goto err_out;
+
 	return 0;
+
+err_out:
+	j = 0;
+	/* release all buffers and free vol_amap */
+	while (j < i)
+		brelse(sbi->vol_amap[j++]);
+
+	kvfree(sbi->vol_amap);
+	sbi->vol_amap = NULL;
+	return -EIO;
 }
 
 int exfat_load_bitmap(struct super_block *sb)
-- 
2.47.3

