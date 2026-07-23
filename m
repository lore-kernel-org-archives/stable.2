Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13C45D197
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839403; cv=none; b=gxU8bT8PG0+2MY0mphgSqAgFsZdcpQ7ya/iSMfHufHaHHvYC2QOA6kWLMkm9U/fSyIuNst4Xx/lsIwOiDQkDS0ZeYavU8qj7Y95LoJJ6fK1KZQUmVhSsWU4G0KGfeWZLlB1Z8Tz51xfaY/1kBm0LX2uHczhlreYFFGRNrsf1pUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839403; c=relaxed/simple;
	bh=sQcSSX/jufOA+fic/HSdeMNwwQDiSrn4ZEB0dsr0Z0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TTRvrB+BgSX33VAVJ1gikM4TNwm0FHLGEbF34HC0EFtPoI9NWC7bfhfERCpe7j2uxVuKDM0wkvvG4Bg3L22gWAVlbkZucHepdDUEwq3RFtUzyPJIJUSFzBBc8obUbQ5KeZ2jap6GsaTQtQ2pbgC4Cl0U1kwkp61Jp4Y6OsL+yxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=A0PhEHmn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="A0PhEHmn"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-471eeac43bfso1015706f8f.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 13:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839393; x=1785444193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wlFyTwpdvsIeETeN6SJHO+G4KnBBWZplfaizFoTi1JY=;
        b=A0PhEHmnTJ9+QVVolXbcvu7kUytNNzkuhnHI49ebvWjAT6aQC68XJXaZrWn7EYoFv5
         UIO5jsHccWyUmv7Nv/1ttGqpO6WGslxxl0LC7v3d2+kqu8O6A4jeX57CmWsLOJU5+l07
         JUMPQJJdBfPptyNw5ZmEZpCs6++PzJKMUNnrMRAA6hdTyIF/T/F4TH/OpLZvYP8EtPdH
         axSjIMMIRo/9Qv11/Sq3CpM7Sp/JMxKM93gVOS9NxH9ur9U9e2WTf5uKUKO+kc1gb6gb
         DoXu81Q0TiGqj9JO1cZDqx/lBMgNGlBkDNSOWle9RU93/xX2Cd5Xm0D106GZydDPVLmQ
         bwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839393; x=1785444193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wlFyTwpdvsIeETeN6SJHO+G4KnBBWZplfaizFoTi1JY=;
        b=kMURCtWoEyPS3Z3oqyqB3vrS6qrd/fhVz/BGFpI1DE6Xj3YafJZxSYmv9NA7JzaEL6
         aG8ktlhgJPMuCh5Iqbmn8sRz+bxtLro8bIAm6opm3bOY7+WW9R2eop66qpjkx7VSR0j8
         6zdl31KFUazHF8JiVGhXT4gnUNNDkhAsPtOiGvci219++wIYaet4FzrJvG6yRAKPoS0n
         aC/sVZ/I/6SVXC156+75Ay9OBMDAEBP7BxSWffTL38eY8YXFxWy3yat+LG5Y7SVpFlmy
         huQhAVBXMZLw4uImUeX7bGEN9ZFKTxl8EicE2jaOyiyikeSZfvKPmXqw+guTzTGEgRqS
         BKuQ==
X-Forwarded-Encrypted: i=1; AHgh+Rreyk1hCIryVe6A+tx6kBbw9JUPA5YoNY77R1GTbmcSLuFgjg/q2uKn7+RMt2n5CW7EhQ+eP+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqF9gybLzYmAbhpJbSSgJaHKa0Cjwahr9ONOoWz8I/rqv+m0nk
	Wx3zRMfwBS+/8WEYp5mZm1iTycPkvdeXKdIIZDXdlcuKMSfQPkUZjo5Ep/WdK4BaSQ==
X-Gm-Gg: AR+sD10a+1SzzkkKhzvbn9/5RPk3+1rhipxKMyNiagJVlKI2KlLnRw4jlZYo/h7fbFi
	qaakPK25NraL/KJ1D5ywqNHJHIZloW+lasCnb6fgEUeMIXDjiVk1AvTQAB6UIQQ1/DtEFP9B7UJ
	NH1DpEmXFJwm81bd6MVMcJ98Z1vsJy8ZiRI1EpXItmWX91bD5fqZDBLPYuc46X8gXXPWowW7XTU
	sUEmJr0Y/0r6xAmo/XaTSVz6a255dOBRJfiFhg7+fNGKWjvsgsim96+Ybx0tb4RspmMjSf4taXB
	200k9/9n+33A1noLdiaHPf8aqMrCbKeBwj6qMWkw8S8spWSp2MK5x9sSyY34P41EzyxkfgdAZ7X
	8RMfH4/CDi025PQ2u9zcnqYr0Zl3C8fgqUL551DyKPINpaIRQLaxUSVSl3QDRZkG4k+AN5YwZsM
	elNgZiH/fMaEdMS5Mva+AUKVrqOopqlf9K6uVyRG4bpptXWuWPJURX2vFE+QwuXhqCvsmSJ7Ggb
	8Q7F/Yx2VzqWba/6z5GKvyeogh5FsCEEMNwiQu7Tw==
X-Received: by 2002:a05:6000:4203:b0:47f:7b75:61a with SMTP id ffacd0b85a97d-47f8d71f494mr6221114f8f.15.1784839392888;
        Thu, 23 Jul 2026 13:43:12 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:12 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 09/10] nvme-rdma: use ib_dma_map_sgtable_attrs()
Date: Thu, 23 Jul 2026 22:42:05 +0200
Message-ID: <20260723204206.76930-10-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
References: <20260723204206.76930-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ib_dma_map_sg() folds every mapping error into a zero return, losing
the DMA layer's error code.  Switch both scatterlist mappings to
ib_dma_map_sgtable_attrs(), which preserves it for the next patch to
act on.  No behavior change: failures are still reported as -EIO.

A local sg_table is needed: dma_map_sgtable() maps orig_nents
entries, and the embedded table's orig_nents is the allocated count,
not the count blk_rq_map_sg() produced.  rdma_rw_ctx_init() does the
same.

Assisted-by: Claude:claude-fable-5
Cc: stable@vger.kernel.org # v7.1
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..63830334c73e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1469,6 +1469,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		int *count, int *pi_count)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct sg_table sgt;
 	int ret;
 
 	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
@@ -1480,12 +1481,16 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	req->data_sgl.nents = blk_rq_map_sg(rq, req->data_sgl.sg_table.sgl);
 
-	*count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
-			       req->data_sgl.nents, rq_dma_dir(rq));
-	if (unlikely(*count <= 0)) {
+	sgt = (struct sg_table) {
+		.sgl		= req->data_sgl.sg_table.sgl,
+		.orig_nents	= req->data_sgl.nents,
+	};
+	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+	if (unlikely(ret)) {
 		ret = -EIO;
 		goto out_free_table;
 	}
+	*count = sgt.nents;
 
 	if (blk_integrity_rq(rq)) {
 		req->metadata_sgl->sg_table.sgl =
@@ -1501,14 +1506,16 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 		req->metadata_sgl->nents = blk_rq_map_integrity_sg(rq,
 				req->metadata_sgl->sg_table.sgl);
-		*pi_count = ib_dma_map_sg(ibdev,
-					  req->metadata_sgl->sg_table.sgl,
-					  req->metadata_sgl->nents,
-					  rq_dma_dir(rq));
-		if (unlikely(*pi_count <= 0)) {
+		sgt = (struct sg_table) {
+			.sgl		= req->metadata_sgl->sg_table.sgl,
+			.orig_nents	= req->metadata_sgl->nents,
+		};
+		ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+		if (unlikely(ret)) {
 			ret = -EIO;
 			goto out_free_pi_table;
 		}
+		*pi_count = sgt.nents;
 	}
 
 	return 0;
-- 
2.52.0

