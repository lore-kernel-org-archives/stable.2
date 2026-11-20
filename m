Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795156472;
	b=WPR6HnQBXqf6t8S6ZzQwlunADi41UtNnYwvSbSJFSnCN0fms07Az6JSc9KzS7YF7P+7f
	 n72KkhyLM7RrxZFKPrLkLHjfCgK05j5DFNxgOrKn8MRvpzvOaEsrQ7Vg4wRy2xY8ktCbS
	 8UCbcvM/CNHVONNXeLXqSAihS6hWlt3p7DiRG04a1pkGOm/TAeTvOzkhwFFhr5ZNl7MiM
	 DEth8e4Dxx6X5quoCbqlkrXswPu//uPwIIzrgDXBETPbdCG4NtLj0SgN/fK5yfh0Tf4XO
	 DGRcTGZ1HSW2T6q7pu7eSPKNO0zdYZlWYAzDWd3SxRFvCIXYkKsbOHyEVjG/w3yDeqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795156472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l2nH2XTb5frL3IcF+3+XVhqdfkR4kPSpm/fGUJr6SFY=;
	b=DKn1eCEwlrHtR9UVKxDdUqPZ4G/3XqvOV4ZZscFL7AeCbDlcPLQ7bA1rPWamyjLovTgw
	 t3u6ZfxA0w7UxPYTGr2AJh4C3mxCcaVhnSCkspBQopJu2Ox2YhcUuTUYBGWglwJXaOtj+
	 2gHX9z9b+/fXsBbv4jirrBpyirrxkQGs0XHEQeB2wobGxt9YePnlMFELZJsvhfrSz8Iaw
	 rTFMNB+ta4QdOeHnvHm6WN9G6sA6zwWD9jqqUGvab/zknoZr/P0Ziji25x4KktTZNaiaW
	 p8IKug7KvhSzRyv9eZ0m+y0pOAWdffsV3aLkRHeENgVrhrSuWzbO7ZImaN6VCDqtLrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0qrljRq;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8D606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0A8D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C0qrljRq
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso778682c88.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 22:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795156471; x=1795761271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l2nH2XTb5frL3IcF+3+XVhqdfkR4kPSpm/fGUJr6SFY=;
        b=C0qrljRqr6WB5mcG2FJbWz0ZpX9xYi9k13zz9r6fJw7gy4F+Ayk/9gAIFz9swn8N9A
         qDjZXXGtcj0FZFKkzL+1NzcNDsO5LoPqkgJ0oW7b1Bhgqc1wZKyOaIiQVvkFz+MCqQNJ
         vH4a6+2RxDKcRA9eM2kHGdplYeHgqCM4yXDrnSCaCTnV78oGu5Srgcp1amxaui2zAXdl
         r01hCXvD/Fl0Kja049jzB1A6rIlgG03lKD/dsY31annm+LRUDzeKvTburg+a15/l28+p
         oQv0XBoiQBQUv9GAeSAzesTFbCvR9lMwEhZI7UgVlpGkTPHz0SaBWUw7NdzHOQKRM1+S
         UHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795156471; x=1795761271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l2nH2XTb5frL3IcF+3+XVhqdfkR4kPSpm/fGUJr6SFY=;
        b=MpHa6tvY0rOUUm2YwEthIQVM/mhjWTrDXuFT3GzIcz2sfYdxUx31emWWxmUsVVOvT7
         Smg8m1fDFWXDJhGjzwpiYcLvnvF72DcPIQxUJ+Z67oLnMVF4x9crHO+vy9ni8xGLrtQo
         i8eZeWuhWQBtyK7qkXJ906pPOQew5hKhOlfw7umtwPinKAb3HZEeZbt63yJ3iwTaH8w0
         WaqL0IFoIfTqWyGKnqZ8LbaflHx0Z+VDXQijtisbYOK1TG0JHWyZPB9PVz5ZDJI5850x
         2Yj7k64smvRbS5Ce38XA4D17X6SrAUc5mH+ihjHSi9SVnEb8rNF5vdUzi4EM5H/DXEp8
         5Vmw==
X-Forwarded-Encrypted: i=1; AL+hErEfJroVi5D+vh6YcukqNDFku/13XzK3cjKogtkr65cDWkXYDE2gZPiI+GZy++8QFels+47g9AQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iw/Ihbj/C0f3AMBZ/UisAU65icgeXvWcpUKWKkicIOaEsP6Jp
	NUSiRdL+/DcHgZj8LSp8SF5aB3p4mHLHzh8RupwOYAVD+/d4RK+hyWRW
X-Gm-Gg: AZFdTZc0W+M8aSv9RS07cgY6mu0aXqQxlgesgfQh5PLR9M6t0MbjeGt6FIYcPJWgn6I
	ryiWkV3W2ivOHzEigPTuiDp2FIH3C2ru++umrwM4PvRd3aVjuiC32kf9045vGR8P6S9kBlEiQIz
	edGrsJhDL0rdjatLxJjUUR8wCioIQ/gZQVYrMjeCPvnSTn5yGU4blryM/Vaep4w3RamahJSDqGr
	umgmDq/mzkTxYBoEixcYcoIlJMJnt0WRcPmHgwR3GNIGkC5uk235/bA5RxF1ODR2pQZSU2aG8T8
	9TKOskHJ77fyt03jp5WB84bDmcgKzjXNVxbCKJ0dPd+7pUbaKSEmbmElvPKyFYJ01KBv+VOgXRI
	UkPGhL2fZ6Ub0fmqBhcFHm1xJs4EFOqgk7UlsodQCjhB8qD3RtZGk8kwSIO5/pediMGCYDW4Rsq
	y1UclJd2IonIpMj1QZj+hUOpRsqdIsOgeFxTIkTA5IgWFYNvg0XoDhovXvVRDfp4/6WjeQONiN4
	1vTZ+wXhLYGJsiHo+ix9lX4SGISwzy9CeS2O8wAQCOX2cQ77gepC2BFpT3dQtEwAx8MrC1ov+4U
	3SHq8fefVW6S8qBgY76H7cS32EcGMR+HI1EReMX3mJ/1OBeMeLM=
X-Received: by 2002:a05:7300:c01b:20b0:385:4b9:18ea with SMTP id 5a478bee46e88-38571027a68mr2036926eec.35.1795156470715;
        Thu, 19 Nov 2026 22:34:30 -0800 (PST)
Received: from annie-ProLiant-DL380-Gen11.. ([119.204.109.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm4821319eec.14.2026.11.19.22.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 22:34:30 -0800 (PST)
From: Annie Kim <pulpannie@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hyokyung Kim <pulpannie@gmail.com>
Subject: [PATCH] virtio_blk: validate zone append sector from device
Date: Fri, 20 Nov 2026 15:30:39 +0900
Message-ID: <20261120063039.4155597-1-pulpannie@gmail.com>
X-Mailer: git-send-email 2.43.0
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

From: Hyokyung Kim <pulpannie@gmail.com>

The device reports the starting sector for REQ_OP_ZONE_APPEND completions,
and virtio_blk copies it into req->__sector without checking that it
still refers to the requested zone. A buggy or malicious device can
therefore make upper layers believe the append landed at an arbitrary
location.

Validate successful zone append completions before updating
req->__sector. The returned sector must not precede the request start
and the entire request must fit within the zone writable capacity.
Reject invalid completions with BLK_STS_IOERR.

The polling path may batch successful completions, so perform the same
validation before admitting a request to the batch. Invalid append
completions then fall back to the normal completion path and are
completed with an error instead of being reported as successful.

Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
Assisted-by: Codex:GPT-5
Signed-off-by: Hyokyung Kim <pulpannie@gmail.com>
---
Tested on v7.4-rc3+ using modified QEMU backend that returned incorrect
zone-append sectors on a memory-backed null_blk zoned device.

 drivers/block/virtio_blk.c | 50 +++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2b462005c..8f88570b4 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -331,15 +331,45 @@ static inline u8 virtblk_vbr_status(struct virtblk_req *vbr)
 	return *((u8 *)&vbr->in_hdr + vbr->in_hdr_len - 1);
 }
 
-static inline void virtblk_update_zone_append_sector(struct request *req,
-						     struct virtblk_req *vbr)
+#ifdef CONFIG_BLK_DEV_ZONED
+static inline blk_status_t
+virtblk_update_zone_append_sector(struct request *req,
+				  struct virtblk_req *vbr,
+				  blk_status_t status)
 {
 	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
+	sector_t req_start, sector, zone_end;
+	unsigned int nr_sectors;
+
+	if (req_op(req) != REQ_OP_ZONE_APPEND || status != BLK_STS_OK)
+		return status;
+
+	req_start = blk_rq_pos(req);
+	sector = virtio64_to_cpu(vblk->vdev, vbr->in_hdr.zone_append.sector);
+	nr_sectors = blk_rq_sectors(req);
+	zone_end = req_start + disk_zone_capacity(vblk->disk, req_start);
+
+	if (zone_end < req_start || sector < req_start || sector >= zone_end ||
+	    nr_sectors > zone_end - sector) {
+		dev_err_ratelimited(&vblk->vdev->dev,
+				    "zone append sector %llu + %u outside valid range [%llu, %llu)\n",
+				    (u64)sector, nr_sectors,
+				    (u64)req_start, (u64)zone_end);
+		return BLK_STS_IOERR;
+	}
 
-	if (req_op(req) == REQ_OP_ZONE_APPEND)
-		req->__sector = virtio64_to_cpu(vblk->vdev,
-						vbr->in_hdr.zone_append.sector);
+	req->__sector = sector;
+	return status;
 }
+#else
+static inline blk_status_t
+virtblk_update_zone_append_sector(struct request *req,
+				  struct virtblk_req *vbr,
+				  blk_status_t status)
+{
+	return status;
+}
+#endif
 
 static inline void virtblk_request_done(struct request *req)
 {
@@ -349,7 +379,7 @@ static inline void virtblk_request_done(struct request *req)
 	virtblk_unmap_data(req, vbr);
 	virtblk_cleanup_cmd(req);
 
-	virtblk_update_zone_append_sector(req, vbr);
+	status = virtblk_update_zone_append_sector(req, vbr, status);
 
 	blk_mq_end_request(req, status);
 }
@@ -1242,7 +1272,6 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
 
 		virtblk_unmap_data(req, vbr);
 		virtblk_cleanup_cmd(req);
-		virtblk_update_zone_append_sector(req, vbr);
 	}
 	blk_mq_end_request_batch(iob);
 }
@@ -1260,11 +1289,14 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 
 	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
 		struct request *req = blk_mq_rq_from_pdu(vbr);
-		u8 status = virtblk_vbr_status(vbr);
+		blk_status_t status;
+
+		status = virtblk_result(virtblk_vbr_status(vbr));
+		status = virtblk_update_zone_append_sector(req, vbr, status);
 
 		found++;
 		if (!blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, status != VIRTIO_BLK_S_OK,
+		    !blk_mq_add_to_batch(req, iob, status != BLK_STS_OK,
 					 virtblk_complete_batch))
 			virtblk_request_done(req);
 	}
-- 
2.53.0

