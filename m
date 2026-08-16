Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47904B04B6
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 19:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786907859; cv=none; b=X9nAoBupj0haAgUQyqur3v76DVhFWq6CKk+VfFqQQ7CnocStr3/oLSjcDJqNH7/Fgm0driuTN8P1+nr5PuHprvy98SLNoarD0hhu+VwWwmUUMV+NMM0g/3b7wKrvJ/otWBmDBvUiUK3px35V+epb4uOKVY/hsgPjBjDWWSL3bbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786907859; c=relaxed/simple;
	bh=T0h1D6+F6G80KEwNjlSZDg0Rlz+RAzRQLdI3ihYaork=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ngbfy1J3QJce0z+ks4Lnbx7CrkZz9FgyHutAfqEjH1Nf8/nv9Kl/Is89lgo9HdgMBwKefgy8+Ye7VlRYWT4czd/f2+LBvd7HvY2ThJkh+l1gdTuMaJHH3LCLKaGf8zYfQvYfmRWdnxF7YDBigyaKN00/OQROKa6+8ZsMkyub2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQiyfkjY; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQiyfkjY"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836c436a6b3so37046667b3.0
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 12:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786907856; x=1787512656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AISqMB6CvA0Lb35Q0jRjNWDuiHxCP9fPg6wK9jXO2X8=;
        b=VQiyfkjYp3Nm/sFqtCN5TjUGYwMOxOCAKIWryw9oOtxv3w+Hpi7p3VDhXZ2+hZYsFG
         nhXxt/Eyg6tmVY0zRTHO6SZ8tmL4h51bNIS1+x5uvao1bEMyXJhhctfnCx03K/2z/Gfg
         YQxvXNkqMuLTKLW/c3vJT378SiWVeTpzTxxzVb/XwOOLdVkUEzg1lz8lIPlQaaFkCuVS
         jy3+4g38vll1iI1lGHYSC12lu8PlLf347D34yAVsh/CjGjzcbVkX+9Yhfo3+p+KIAMKZ
         Zvb3d026i1cBmXISxy6GCbDuRh1/X+Ac0jOoDRwfNwFooxpUkuh8kmnIqApDisc0iasY
         pQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786907856; x=1787512656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AISqMB6CvA0Lb35Q0jRjNWDuiHxCP9fPg6wK9jXO2X8=;
        b=OXMO0EWklaY2eoGN+ObKi/rJTEaIe0CwGurAa3lkCtmfMk0jHU9QaLUwCBMAGzEfrq
         gKIfnZ/LrgWy/kcU7dS96p1DFd+gU72JAOEZno19dbg69yi84X2JYHcULYzCsEApcP7n
         HAuTCsS2OQ3QC1xYLRtiSeaf7UDw7ofCsURM0nGEjWcJEdAgfwJ/2Ya9Xm/FbI9YWF5r
         Irt/Abz+ZxArvkDx0NvBtq8H1qH9MOWj3fkD8x8CzPRWj3LGU55wbGmja5k8zq2oP3g8
         NCxxepDJf/6xStd5ThIscd9NeG3h5eOb2mZ6hSdRdDeVOw1gVI30bHaa4dzuPRX6u0cn
         kCEw==
X-Forwarded-Encrypted: i=1; AHgh+Rq94Pqs7bgKMq62sKZtS0KKiBeu2pRLDcjN8ulJIc1QtE1z6Ivr0ifQDGQ78A7lpFgnxntvTz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfni3wk2u9HUrLK9/cA2N5UuwlqCZNoDHeUmxP1TYVDd942h73
	qgNmUy55FLFmcQqwq681VDqvCA9HVfHFRs64T3YpgGQ+BrmsBGQDAuob
X-Gm-Gg: AR+sD12BZxHbszepUKb8p6t0ERCyOJlOh4N5WCL9N9dmhxOyAoVVS0vm6jQWOxttNFN
	DlhBeVPsvGQR/ENOp3Dq5Ba8IdcOC6HCooloeRp7dOMpqT1IWnXODCIQ4qEwHMs4FtahmPF19b/
	TvuoPxfaHwJ8Zm2OnNAfvx8s5dzCE5DXoTuF0ptwEATbiGaQ5n0SyHg6Jx+9fLJsADNKR57srpI
	ZDSb4c070qC3Sko1pRRRpTx+JE5jy6sqR547ZeN2VGv4PG42TVAZEew5f3RU7BusUYMKBdUVH7W
	KgNkiEXIF7J4tWx9h68IpUkWr1LRkUO3tb1q1Bm+OBLH1thLHQn0FWxsCvD6jZIolQnTVCQ5rVw
	hjKvyxRCWL0h52UT1n2cKyLAAfFk1Cldq/BjG2U7hcPgFYkIixkHk0nHtFMDRmQaLnunBnwH0Wr
	/BJak6NJ+HT3BhSNMaS6eggVeNGSf91XntiMGRAPgnSPJR9xal+ThHhXFRA321JMxbBt/HBg5+U
	IahO34=
X-Received: by 2002:a05:690c:e292:b0:827:b35:9d5e with SMTP id 00721157ae682-83714123a7fmr56142987b3.33.1786907855860;
        Sun, 16 Aug 2026 12:17:35 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c17784f2sm38580437b3.32.2026.08.16.12.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 12:17:34 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v2] nvme: skip the zoned limits update if the zone info query failed
Date: Sun, 16 Aug 2026 15:17:29 -0400
Message-ID: <20260816191729.2865523-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Skip the zoned limits update in that case.  The namespace stays
registered and usable for admin commands, but the queue is not
configured from zone info that was never read.

zi.zone_size is an exact indicator: every path that returns a positive
status returns before it is assigned, and after that the only failure
left is -ENODEV, which the caller already handles.

Fixes: c85c9ab926a5 ("nvme: split nvme_update_zone_info")
Cc: stable@vger.kernel.org
Cc: Weidong Zhu <weizhu@fiu.edu>
Suggested-by: Keith Busch <kbusch@kernel.org>
Found by FuzzNvme.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
Changes since v1:
- Only skip the zoned limits instead of failing the update, as
  suggested by Keith.
- Gate on zi.zone_size, not zi.max_open_zones, where 0 is legal
  (reasoning in my reply on v1).
- Drop the "malicious device" wording.

v1: https://lore.kernel.org/linux-nvme/20260814160954.2839507-1-coshi036@gmail.com/

 drivers/nvme/host/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..87e0534cde1c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2447,8 +2447,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (!nvme_update_disk_info(ns, id, nvm, &lim))
 		capacity = 0;
 
+	/*
+	 * A failed zone info query leaves zi zero-initialized.  Leave the
+	 * namespace registered so that it can still be used as a device
+	 * handle, but do not configure the zoned limits from it.
+	 */
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-	    ns->head->ids.csi == NVME_CSI_ZNS)
+	    ns->head->ids.csi == NVME_CSI_ZNS && zi.zone_size)
 		nvme_update_zone_info(ns, &lim, &zi);
 
 	if ((ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT) && !info->no_vwc)
-- 
2.43.0

