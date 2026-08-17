Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA0237D104
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 17:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786989551; cv=none; b=tXjXNJoi152Suup68jYXmHGN048P/9yZLCVaKAT1E8gSCP8f/EgKn8WStluIw3sjx3toF+WBqnfO0jP+NQIy0xhBIGqodGbyIoW2RzlGB9x55yHJwR+sVt8E/FIkymkOX+vsYiN3BYGegW25ypGtdBBcTncS0d+jkMHwduhqLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786989551; c=relaxed/simple;
	bh=sibB8iFM5/VjAIlNkLRcDDT+OS/yXnoeHHKfXPGdynE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4HtpEJNBIgXw426KOCV/j340Yo+BJSFcSQY/b1NPnEIgkCtG/fdm/rMT8VdUODM4ylhlsnLrqjDi1cdFXlv6FE188UGTyOsG/o7e4JzNgjS4whH9MCb+9nvG/VXboFULzYfIkvb34sa0jN0XNoqck2g66XOjoNEpIgDd1zTqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRS6rdnH; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRS6rdnH"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66c7264d87dso291996d50.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786989544; x=1787594344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TICx1S6M3SSE9LLwX9NrLNWIBAvmWSHkNpsaEs/JHlY=;
        b=YRS6rdnHXcrLdo9oYS7LodJ0ewf78Y0KdPiAhjKH7eCCvYYakVptF5q8D82oRMsS8p
         s+sCiQthGphpDlFGq5zdGco3Ig2WsR4AB7mhsLSQE3RJ1jLSyqRWjHyTwF0OjnA42V8Y
         T+hRK1SoTkbdprOYvHDevJqjXhJ9OU9zMpKZwnywo6LyhpKZKo7ix8xP6/4Gs0Hv6pk2
         xFyyA8haV7bA8jMNKvl8gj/It95sIOQCDmDGQ3ZYq1Xm82SC2TYhvcu3V50Mg0IngSyS
         qgKVjbZbm7aoYncQXVwGLUKGS0YSG4PKwlfP4sWqnpFKS3oWMtotlX1xiIWP3TXF/FDV
         +wHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786989544; x=1787594344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TICx1S6M3SSE9LLwX9NrLNWIBAvmWSHkNpsaEs/JHlY=;
        b=TNU30rdlXwpZE74tk7zBIu09TpWcSmH2QnmrJOIIu4/QK2o/W6/+HfdzVGA7Tj+xQB
         pbiBlHcuSO2ogO3uXu3Qrjs7gmwcN9Yx3ANqj0p18IcdIFpn4qRd3U8YNcMeFTdh+Z2i
         AmpqevLP2YH6djcK/NLg4mbg91hcIOOPclI3R7rEgQSrlCZukmrBa//BGCGb5U9v0nU0
         hAQH7sesdz+7XbxBQrIqRLlHCjHKgl37bvpd+1NjAQetR8549SJul5ehOYLhZPjygaml
         3uGNnhZLeCJZGiKeuRERDHJDA4DIXUe+XkN+fAfE3LKigs5uZtmTxxPoS6EPXumbDTd1
         iBjA==
X-Forwarded-Encrypted: i=1; AHgh+Ro/ebr9CtH22dMNGyPVHQKK30Yjh8BktCByc5FJZCI3y7sfPtUKY9u6mQJTH3JYzQUK1NfDuH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNWGyl9yN+O35+aDrvSypuKu2jQmk8+mvy0VIwiaBy2zQbJAdD
	T+apuPn9tJr99ZlQYP21R4/3IROGEQh4I89DyNwcdqggcS1p20a1CMk6
X-Gm-Gg: AR+sD11MlLAKuvmhRNcNekIwZ5ih/PwTonwc9Yb04uedZgwwrpyGRXwqZa+OmsYc4D3
	ryMR27r2GTcpB9sOvmwO4P1P7q6/Z2WSab44xQYcMhlF3qS6s2nZ7H6pmWNnb1GZe10pGYs6AWn
	hJBlunq9yMRadp2LCDtGNN8qCUschMFheZBlNyhjESzcnoq2ztqBv0EOUiPmjA1sI2CAzcnyt3l
	sHpkUA6ftsF9bog62XmLdGDWN/8EaL0s6pIc/d/X5i9tii/NTE/1YWfx8nk63QozyfV6NDCLFwq
	qy6hXo9qEp/PheOR9G0TZcyKwN7yN4TFI0487J82tYzfq1s9PFFEnY2s4rrNIlsX43h+Vn7NTec
	tINxzzytqVWlphPToXFrvlhbXFHWE6wpeItFnxA8KBL5uC9PW6Zhb3RJ1ZeS3fJ1DXlwE2UNvLV
	vEJFt8b721qqEkOwViB8a3wG1Zcnvpu9aadtExOd6+ROjuJl/JZvpQmxD/T928ucfInk/bL+Hca
	jci8jc=
X-Received: by 2002:a53:d94d:0:b0:664:c5f8:e342 with SMTP id 956f58d0204a3-66cbc0c01dcmr292247d50.3.1786989543723;
        Mon, 17 Aug 2026 10:59:03 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cb3eb8374sm1136431d50.1.2026.08.17.10.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:59:03 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	dlemoal@kernel.org,
	joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH v3] nvme: skip the zoned limits update if the zone info query failed
Date: Mon, 17 Aug 2026 13:58:59 -0400
Message-ID: <20260817175859.2966055-1-coshi036@gmail.com>
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

Fixes: c85c9ab926a5 ("nvme: split nvme_update_zone_info")
Cc: stable@vger.kernel.org
Cc: Weidong Zhu <weizhu@fiu.edu>
Suggested-by: Keith Busch <kbusch@kernel.org>
Found by FuzzNvme.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
Changes since v2:
- Mention the revalidation case in the comment, and warn about which
  of the two outcomes happened.  Both per Christoph's review.

Changes since v1:
- Only skip the zoned limits instead of failing the whole update.
- Gate on zi.zone_size, not zi.max_open_zones, where 0 is legal.

v1: https://lore.kernel.org/linux-nvme/20260814160954.2839507-1-coshi036@gmail.com/
v2: https://lore.kernel.org/linux-nvme/20260816191729.2865523-1-coshi036@gmail.com/

 drivers/nvme/host/core.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..5ceab58e8e4d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2447,9 +2447,26 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (!nvme_update_disk_info(ns, id, nvm, &lim))
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
 
 	if ((ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT) && !info->no_vwc)
 		lim.features |= BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA;
-- 
2.43.0

