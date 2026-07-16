Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08BA3B961A
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187298; cv=none; b=L26mo/2qo5TtLKjsADz4YsJEOhiVNoWKaazAu+yzAf0KfCJoUJTuf7sK2Y71a9gNiCUpicHa5xGAJ+NzdtIKXoDZ8EQs0XoAdEFBcDiuG5ZpDysNeLU1KBc+4ZlFFhdg5EnyfiF8yGJ6Wj65dkxLWC7uY3vaC5bdCzFH3NCVPzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187298; c=relaxed/simple;
	bh=DhBbEOn3V8U3HEfjjicQ4mItO1gvyqCSXwzPScmbSmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1+gJmazJ9XxPTYOXQ2sJ/gkfiKlwc71B75x1POjWAdb17ZhuKzLJ9/gkZLnw9cyXsLWys/TqRAbTwuhSICGkv7W317HRIEW5oT8QoTBXYGV3kEilvI+ENSiz5oJkRzfaI5+gKcCl65HrvGslhCFCV6cjc0SkuDutyRVBdpnKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNAxcrFw; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNAxcrFw"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5bfaa014978so2192086e0c.3
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784187294; x=1784792094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eIPPdn+Y/jhq/+ps2+rJ21EFwsIWNTgxJJ9i6E4eeGg=;
        b=PNAxcrFwr2H4dE1qb4uGdk7HYEjFCKZzlHgqy4perZZ2vdaWhDkblNWNVru/ULPRpI
         9CFIgPa23bPACCOP+aZil3Ff+CKWHmJyFStoAk2aMHBloXRN8MyzhsJzL1s1R7/Gj7dv
         dw1NShnNpPqtFaQ9dlOarPTw3aozMD8Bjnou4hh8kQEno51WQE9G8TGhfsxMv7/hl2BX
         5SjDqXdwY3Vz3jpj94GTDEAHOxkZWgTSBQF5Zscgb+fKqO5YKktJb7M/RsnvsgxtUA+R
         ZxUlDxKl3H/Z6A5qi7W1EOIVaYfo9Ch7/6TOXmVQsoa1PFyC7c8qWKFpbDFF4ioSBL+2
         ji8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784187294; x=1784792094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eIPPdn+Y/jhq/+ps2+rJ21EFwsIWNTgxJJ9i6E4eeGg=;
        b=p+f8H37KV8hI3xFp0kQT71WnBVeioolBgHZcWoRMOV9qrn6AoctFzs7x9gsYw1wrEq
         LyuhKu9JMEtC3Avbwj4sLQfTLW+fJyY9onYURoQ6CNNbj9xX3kLXpaLU26k6qujHCztS
         hQPiXMdU1tTz6bBvL5GiPn5JJ+bKFDOF6LRmuz12h2qNRALNMRXO75Xj0gGXvTpDMjSW
         H18LUcTUozHDD7NTlXPnxuI11OxblLMvhYXt+fj5Z7CHiOVorg8+kD3P78DYkmNy3BBw
         jeP6Di9Z8Sl2s+RCmO1ymgsnd6wk0quGdMptVnJz4MrpfhGneqdeXvzl/6nCdB2ExBSc
         7/Bw==
X-Gm-Message-State: AOJu0Yx2/DcBKR76LHzfXiaxt1Odak14lUeWt3MASjaN/WiBT+SA+A4F
	JX3QD7llk0MirV2ZXw+dmVDDfOVJiPyO8a2Ru2WphUvCh0Qu/FjVdtlZJ5PX0s0d
X-Gm-Gg: AfdE7clWUkg8m3txe4TiJVMEAyZYL9Im+j6YNR5jwC4EY8g9c0QrXcxhxoBQRp+Hd/O
	RewVUbTT9zlF1TBnUPD5jTrswJYTiLfkK1WdYuPBaJGBhvuXZidrdOot+ddbgcbirHRH2KJ8tCI
	HrWUPhqsrggVlLYD3gUj+w+t3AbdHA4YlZE1h0dls+s4dSK2/Mx+Llmp3sect4B7yfbxUNyGopc
	H1rDo1x5Xb11HDB6Ell4Zohz5bQEHkM6Lfx5htxXC2uFZfEoWTPKqEpreRNhTNksubQgfg/7mgH
	3EetzTbuwgFwcfEZs2dn0XiH/HdcLV42g17F3yIrI2s5/Rxo8+Fvra4k1g3KLrpeM4ON5ETc4Ip
	bGLFISCC/bWrc5MMk4sTReRkYk1hiJN3SpSBhciOertFjcBdogcRZ5NU8be10xZLqo1ry68B5p7
	jiyxDgyqoCBTNV2qWwXa+U
X-Received: by 2002:a05:6122:a08:b0:5bd:b2e1:e1f5 with SMTP id 71dfb90a1353d-5c10ebec2aamr5668365e0c.2.1784187294367;
        Thu, 16 Jul 2026 00:34:54 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bf6f5e0f38sm14365479e0c.2.2026.07.16.00.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 00:34:53 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@kernel.org>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [PATCH 6.6.y] block: skip sync_blockdev() on surprise removal in bdev_mark_dead()
Date: Thu, 16 Jul 2026 03:34:52 -0400
Message-ID: <20260716073452.3246468-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026071548-remember-handling-8672@gregkh>
References: <2026071548-remember-handling-8672@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 49f06cff50a4ccf3b7a1a662ceb892b3b21a527a upstream.

bdev_mark_dead()'s @surprise == true means the device is already gone.
The filesystem callback fs_bdev_mark_dead() honours this and skips
sync_filesystem(), but the bare block device path (no ->mark_dead op)
lost its !surprise guard when the holder ->mark_dead callback was wired
up (see Fixes), and now calls sync_blockdev() unconditionally, which can
hang forever waiting on writeback that can no longer complete.

syzkaller hit this via nvme_reset_work()'s "I/O queues lost" path:
nvme_mark_namespaces_dead() -> blk_mark_disk_dead() ->
bdev_mark_dead(bdev, true) -> sync_blockdev() blocks in
folio_wait_writeback(), wedging the reset worker and every task waiting
on it.

Skip the sync on surprise removal, matching fs_bdev_mark_dead();
invalidate_bdev() still runs. Orderly removal (surprise == false) is
unchanged.

Found by FuzzNvme.

Fixes: d8530de5a6e8 ("block: call into the file system for bdev_mark_dead")
Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260522220025.1770388-1-coshi036@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ adjusted for 6.6.y: bdev_mark_dead() there still unlocks bd_holder_lock
  after the if/else and the else arm is a bare sync_blockdev(), so the
  !surprise guard is added as "else if (!surprise)" instead of inside the
  mainline else block. ]
Signed-off-by: Chao Shi <coshi036@gmail.com>
---
 block/bdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index f3b13aa1b7d4..2bbe0408dac2 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -961,7 +961,12 @@ void bdev_mark_dead(struct block_device *bdev, bool surprise)
 	mutex_lock(&bdev->bd_holder_lock);
 	if (bdev->bd_holder_ops && bdev->bd_holder_ops->mark_dead)
 		bdev->bd_holder_ops->mark_dead(bdev, surprise);
-	else
+	/*
+	 * On surprise removal the device is already gone; syncing is
+	 * futile and can hang forever waiting on I/O that will never
+	 * complete.  Match fs_bdev_mark_dead(), which also skips it.
+	 */
+	else if (!surprise)
 		sync_blockdev(bdev);
 	mutex_unlock(&bdev->bd_holder_lock);
 
-- 
2.43.0

