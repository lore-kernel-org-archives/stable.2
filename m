Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D04823AF
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839395; cv=none; b=Go8SpjWC8Yz3CLa4m2yKciNEwrrZ4Fac6EiriO+CXTu8CEkiAMzj3WQn2dlkLsjlQAj6UNpkmga6lNnKvA8GQ8oDOS0Om02rsLRuMEsamQ+nsWXga18h692W3BrzWcOipmDMfzgk9N5ms8v1sxQkincOJUGZobOnPzWvh/S7fcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839395; c=relaxed/simple;
	bh=6JUXonkvhqCluPq91YNslI6Xc6PHhaJJ82TMx9QRo24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CORTxo25jgVEceCObXyWLyXUWrr98fk4c6W7YE6HwRE1/u6RHBEBOuv1+LAjIjlBSPaWpN1I60salVhlZKNNiw2l48rvFTBK5P3HVcZUlFvCRDUzFx7gPaRQC24kY7PvJb4jqVV5frxKNczV+JYQqC+YBshS6wMrPvaWgvKhC0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=b9TCH004; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="b9TCH004"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f7854678bso401241f8f.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 13:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839387; x=1785444187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=b9TCH004kM7Ijzlq2L+uYapxZbsJtgiPIoccs97iLOok/j4G0z9BoSi7OGTZzfNraM
         9nBbybkLeR3kaqz8qibH9iQR2/+3QMIg8k9UtqWVXdcUsUBX4RdymARurgQLc9PBz+tX
         cU1oMcOcw42w0OxGq4UZ131+iaLE2py0jzPsTM1peGRNz2HSGRqdZT2XUA1zms+v/aFP
         RSKb39m9qHn/9kGElrHMfdLkSFCt2vA+ObV319T3/Q3iv30jBdhCVHMR7mKE0DXcTuWe
         tR1+ya8cQ5UblTusXMB+XkhJKb/d+KQIXTWrnGw3X47bbkfgMA0AmX7SlpGUHEbpPpM4
         +F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839387; x=1785444187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=InzNp2nHOOp7QQLn15Ay7fcFkfBNFGx8C4/KxQQFD2c=;
        b=JMO7mh/q5RzHyX+C5jplAjnmTkfdTjRvUY/24RF6Jq3HJJd4ooYcI5/uwZ0H8dxVCC
         fTH/Y4IbRY45eTOwDZzUpN21pDzj983E5M5IvyH/625VgCLjnuIn0GbMFBCXhYp6BVcl
         +cyEXPVr5B0mXq3NfIiHbyYj6iXqWmE50VufsMVIp/rgF3E1MEWRnvrgkDxiQ1vZSN18
         1+6IcCBzs/1vXhT+QFX1+ad8xRAgQ5cFf7Wb/HcXhuFhcOfa7Rlh4ZAjrw0vyRDYFUzU
         fDikHPofnSPEJL/HjGTm7Q+n7abgAWyqcDtV+BIpiGj9L7BBrfHCfpbGy2+AUWx7ag7h
         ApCA==
X-Forwarded-Encrypted: i=1; AHgh+RqtQ4miSM7BYGRle1cdd0RjBd4zrjmUkQSemoUGO5anXFj4tgxZmGZ2YWYCHzu2SFlIGz/SeKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlj3mGUUiOj1oEeg/ztVLul7mnNmOiRVCCNVJdCUfq04kSkfwj
	H66cK+GimHwuo18DJzsE9x1Pfe59sNPGrASyTqyhKBnUVn21nvNquGsaGPZSpCPpSg==
X-Gm-Gg: AR+sD11JIbCMF/F16Z3mBkaIMR6nJzITTIa2ggXkR+0vmcnsHhktcCnIarKULrE+WM5
	BVDJqG9uGr83nFM+BEMEHSHkkg0jCTh7C3IPyoQG+CEqZBh6zbBaAQ3tKUXafirlOenJN+UQsFV
	kDQToqlCLBoy27rGjH9XAZE6Ok8yJEo7I8IeSOmhlFeKQaLItaXUs2sCWx8eA+mpXWcLC1lRLmS
	ZSAsqPwO4ayZ1Nyk1mbOV/oHoPNm85KVeb0FFaIH2oa+d6vrg4tB78zAfTxlBiocEtKVmh9Rn+d
	ccUWvD+9Yfbx2xaCiIfs+owQL3NmhodaTwVtMo8jRJkByzqgnZViJQMZOjmafeti2thgtA2ZVbf
	2zqVXbmI6LXrGGtWPgh5gJltvoBliKRamg/GvwBc6Tb8pUz4yPtSvylhxK03xvG+wIsahmpd4Gj
	WzFq5oTtCI0R4CWKFX2/7i0IYjiW21TTHaZDcPj7KTYbdcgNjTVMi86HgIyWyZYNEDMySeaYwZ+
	v7UNcQtu79SaeEISDT2nLhUEk1LfuvJaVAZGhkhXQ==
X-Received: by 2002:a05:6000:611:b0:47f:25b1:e7b6 with SMTP id ffacd0b85a97d-47f8dc7a211mr5521629f8f.30.1784839386364;
        Thu, 23 Jul 2026 13:43:06 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:05 -0700 (PDT)
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
Subject: [PATCH v5 06/10] md/raid1,raid10: keep REQ_NOMERGE on narrow_write_error() retry clones
Date: Thu, 23 Jul 2026 22:42:02 +0200
Message-ID: <20260723204206.76930-7-mykola@meshstor.io>
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

narrow_write_error() re-issues a failed write in badblock-granularity
chunks, cloning from the master bio and resetting bi_opf to a bare
REQ_OP_WRITE. For a P2PDMA bio that reset drops REQ_NOMERGE, which is
the only request-level protection against the member queue merging
P2PDMA segments across pgmaps or with host memory (see the preceding
md_submit_bio() fix): the retry path would quietly reopen the hole
the submission path closes. Restore the flag on P2PDMA retry clones.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid1.c  | 3 +++
 drivers/md/raid10.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index f07edeac6e5a..19c4dec450de 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2561,6 +2561,9 @@ static void narrow_write_error(struct r1bio *r1_bio, int i)
 		}
 
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 		wbio->bi_iter.bi_sector = r1_bio->sector;
 		wbio->bi_iter.bi_size = r1_bio->sectors << 9;
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 5b63175fb382..428bddddfe71 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2823,6 +2823,9 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 		wbio->bi_iter.bi_sector = wsector +
 				   choose_data_offset(r10_bio, rdev);
 		wbio->bi_opf = REQ_OP_WRITE;
+		/* Keep P2PDMA retry bios unmergeable, like the original */
+		if (md_bio_is_p2pdma(wbio))
+			wbio->bi_opf |= REQ_NOMERGE;
 
 		if (submit_bio_wait(wbio) &&
 		    !rdev_set_badblocks(rdev, wsector, sectors, 0)) {
-- 
2.52.0

