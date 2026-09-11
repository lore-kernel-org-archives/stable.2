Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A480B274B39
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085751; cv=none; b=ivgZon2TmbMMzP7APWukPNqy5BY+ainAwvk7U45aKs5bmkKoQQIfhossanl6fFOiRDuyCXb5HxjZ/ymr+kD3f9yTnI6U4LFk8aWnqcHgjGTvtanA5n3/B5JzuKmM8fi3o76HTRar4JMUICGVJdAUb0enqYOiLsR5S8XOtcapK0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085751; c=relaxed/simple;
	bh=Bfe0ODgm9meRpNE4ePQDSBu7xw6MfOaTnbIzh7919GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOO6s+3vF2II9k+cf/zT725BUeTKngw3Hed/bmv9vkGqaF+YANIGiLeZJCRLb+mnDSIEb1HUlf0h6/QwlPY7Zue22Og541MCKNsHWPC5FPGvzUZhcKuCWfQQJVUlWAeQyo5gEgwxE6iq6VF1axz93cLurQEFjgXO9LIOL4Tm0So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvLOtZmY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvLOtZmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A2A1F0089C;
	Fri, 11 Sep 2026 00:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789085748;
	bh=3ghaUWH31Fpv3pb3Y/SMS6rNdWglVhg3tDiBOcABifU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VvLOtZmYPrOornTYSEF73/q8MM8PaAjD1nWvMa9QppIIhrw9fUxlESDxTaU5O1D24
	 u5ra450eXVdDDPEnhzajhnXT1VQaa6WpRDzbm6iMrgIfHjCNR0V3X9rCJ+jdRgEwmM
	 Fpk6okWRVu8pImEkPIZxbAgr+7smnHyAG5BF++kBKNywdUMs1ouuJuuo1sBh5bUKpb
	 OFGvfoyzVDN3taHPM1bWYvlNqjzg9XCDxchBEHKyGXg5rZXQqyo/wJy4zOfZB+/rwe
	 Vs+w3PRwoZJQIbSGVnoE8tEUkntzWQCftPudYunFZ5BOl+lsc9pgGsdek90u3TuApA
	 y0rlwhYV/6tfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] nvme: skip the zoned limits update if the zone info query failed
Date: Thu, 10 Sep 2026 20:15:43 -0400
Message-ID: <20260911001543.3303783-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911001543.3303783-1-sashal@kernel.org>
References: <2026090951-hardhead-splashing-d9e8@gregkh>
 <20260911001543.3303783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Shi <coshi036@gmail.com>

[ Upstream commit 3838e80fcfb32e62baffb63c6dc0a60153665a4d ]

nvme_query_zone_info() returns either a negative errno or a positive
NVMe status code, but nvme_update_ns_info_block() only tests for the
negative case:

	ret = nvme_query_zone_info(ns, lbaf, &zi);
	if (ret < 0)
		goto out;

If the device fails the Identify Namespace (I/O Command Set specific)
command, or the Identify Controller command issued by
nvme_set_max_append(), the positive status falls through and setup
continues with the zero-initialized zone info.  nvme_update_zone_info()
then marks the queue zoned with chunk_sectors and ns->head->zsze set to
zero.

blk_validate_zoned_limits() does not check chunk_sectors, so the limits
commit succeeds.  blk_revalidate_disk_zones() does reject the zero zone
size, but by then the limits are live and nothing rolls them back, so
I/O keeps being submitted to a zoned queue with a zero zone size and
disk_zone_no() shifts by ilog2(0):

  nvme0n1: Invalid non power of two zone size (0)
  UBSAN: shift-out-of-bounds in include/linux/blkdev.h:747:16
  shift exponent -1 is negative
   disk_zone_no include/linux/blkdev.h:747 [inline]
   bio_straddles_zones include/linux/blkdev.h:1058 [inline]
   blk_zone_wplug_handle_write block/blk-zoned.c:1423 [inline]
   blk_zone_plug_bio.cold+0x25/0x1c8 block/blk-zoned.c:1605
   blk_mq_submit_bio+0x18fb/0x2870 block/blk-mq.c:3196
   submit_bh_wbc+0x575/0x740 fs/buffer.c:2824
   __block_write_full_folio+0x728/0xdd0 fs/buffer.c:1933

Any device, firmware or NVMe-oF target that fails this one command
reaches this.

Skip the zoned limits update in that case, and log which of the two
things happened: during a revalidation the queue keeps the zone
geometry it was last validated with, and on a first scan the namespace
is registered without zoned limits, so that it is still available as a
handle for admin commands.  Neither of the paths in
nvme_query_zone_info() that return a positive status logs anything, so
the failure would otherwise be silent.

zi.zone_size is an exact indicator: every path that returns a positive
status returns before it is assigned, and after that the only failure
left is -ENODEV, which the caller already handles.

Found by FuzzNvme.
Fixes: c85c9ab926a5 ("nvme: split nvme_update_zone_info")
Cc: stable@vger.kernel.org
Cc: Weidong Zhu <weizhu@fiu.edu>
Suggested-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chao Shi <coshi036@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3e36b814fbe6a..917370e290668 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2208,9 +2208,26 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (!valid)
 		capacity = 0;
 
+	/*
+	 * A failed zone info query leaves zi zero-initialized, so skip the
+	 * zoned limits update instead of configuring the queue from it.
+	 * During a revalidation that keeps the zone geometry the queue was
+	 * last validated with; on a first scan the namespace is registered
+	 * without zoned limits, so that it is still available as a handle
+	 * for admin commands.
+	 */
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-	    ns->head->ids.csi == NVME_CSI_ZNS)
-		nvme_update_zone_info(ns, &lim, &zi);
+	    ns->head->ids.csi == NVME_CSI_ZNS) {
+		if (zi.zone_size)
+			nvme_update_zone_info(ns, &lim, &zi);
+		else
+			dev_warn(ns->ctrl->device,
+				 "zone info query failed for nsid %u, %s\n",
+				 ns->head->ns_id,
+				 blk_queue_is_zoned(ns->disk->queue) ?
+				 "keeping the previous zone limits" :
+				 "not enabling zoned mode");
+	}
 
 	if (ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT)
 		lim.features |= BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA;
-- 
2.53.0

