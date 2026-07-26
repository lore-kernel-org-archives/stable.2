Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598E43A9DA2
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065574; cv=none; b=tVk5mLVb69iz3n30PTaIvCtry/oze1rX7ac+WsvEtTMwDfhquSGgfoR6bmjV1Nz4Vs/qNwVr8TDICWsceL+cU175JiMDMzSurDjP/1CNeyaREUpTKSoL+94kuuN7pNXtNiAmxS4YqqRfocMw17em3AxAql9GmTUaAOqC5plHPWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065574; c=relaxed/simple;
	bh=GxxQoTTF85ZeZ/Y5yoNRnfoKgu/J4SfvvCToNsb0LIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXKa1J5Ix6p9TbWywy1jS/MkjfcdO7WOxMhjDRwTI+C1GxK6q2kPK/l7bK5vswC+0OSLcPLW3D82gBSSfRUd0P/BjV/npPUN9B7xdo8J6hqe1IpEAqnyWrUP9YP4j9XZxtGwukuZRSE/9e8NVhcQxOc8bacj2ey4HPOCAvRMSLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=KE5Vhjp8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="KE5Vhjp8"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4720f3bf164so1649017f8f.1
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 04:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065570; x=1785670370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZaJ2bTFIw6n5gqGH1V3eysAf/jOPI3Jsri1IzDcY9ak=;
        b=KE5Vhjp8uW/BIN0XVrO5ugcEYaM0505FEmTjo6DYKXTGGc3wEPvgiUb4ezikwT87CY
         VV+daGOtl0brIVbdAw4aqYaovqkScuXs5WF6Noe7QntZVT/k6LVUh0DZbsMD7ocn+mIk
         suXzkHgQDKziTxEsFMyVf4zRzhdkp/J0kCeUcSZfarRIRgnECT1Skp3U9Mnq/bvqUUNO
         G1+7C9nA/pkwCHHIQgY86FR/LeIAjY4EKY37sEULFQXE7+scd0CS7KXMfZ+f9u+BI5U0
         EFEfFXB6R2cef5rD0VSLmn6FEXnr+dsPNYL/rP4/neUb9p+hP1qvzzLne1iKHxQRSNmg
         1thQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065570; x=1785670370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZaJ2bTFIw6n5gqGH1V3eysAf/jOPI3Jsri1IzDcY9ak=;
        b=XW39ak5wD0nPsEZ0b4Bwve3/1kHFvrn7Js/yGsqs3byoDd5SgX3I/X3AbS/sL62tXP
         5cCbr5wdDSi/9/w4mwiGMbp5URWnAIKfr0zQjXlTCsNArHW38cc7cNE352z8ik0eJyNI
         es5kh1aj4v6tAxQ52I2WgYgKogR6/rODqrM07OhoD5HqMm7deSSsJsirBn9pzls8MYFN
         nxUunqDRypR2J0d4LfmJz3MAcS1MF11pQ3ajXQTlIoxzNliPN+ji5A/NjqMDvB+wYdkd
         7jTauRz33lxx1RARJMEq6FE1B1FGMB7fKxcvkwuUEgJ2qHxeCKqmh3Ank0nu6jffucDm
         qzuA==
X-Forwarded-Encrypted: i=1; AHgh+RqVtG+BcjVMBY+kTf7m9jq0Wa4B6qmWWVifnhamriHLferdFbVR2haErjG4d7p9+vVn0ZLLSv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxxCmwtSOEhl1iNBPnKl0z+wh5AYh9CDcTRqLllmVj7EqtDlu
	LUCGhYQF6zMRz5jYVG2YUTrVduie/7PZ/6Xt+fn1UloLsoqp/AfFOm7cYnOZ1u9MqA==
X-Gm-Gg: AR+sD100J8sybWTi7CmL8hsA+FudCQ43NIhLb4UEjjXZ/ap4Nazj+3V2Zz4egIJARMS
	6c28uUloGw7xbSGEm0jnKVPngPz2YXKh0A+PfEybgvWPMOxZHiOHEQRuO4LbSqQoZ4/CeQRjLYY
	rbB9MZBH2IrgTGWP1nH/8tMT71tw4EwF7O3AVl4HXWWVNFD9cOSiuG/Ct3ha53tDRRqVHWxIDAP
	T2q3sjIQBmw4OSLBr/zMpxJ4u5IDSKsoLLFbMS9FFG/e7fSn3Lf7lEFe0UBGXdy1MbvqDkAc821
	4xBmJnCN2A3gTLQCIkh8J0goyQea34rDOHMMiSlSPJ6bW6wSKPknWgTz1WLFhlWdBjzZcSaM5bn
	ummRmRqIHERBoceQUYoKiOwCl3A+kfgjOjJl1j51VjzNdc6HkNFLELu+qg1wtqBkyOFs1UXUl+B
	nLuM9KJGOQy0ic4VUP2TmbtKQvdioi9zB1HNdeUZLHlglZLndUdy8PvLkrV39g6mdv7bEgtvI5j
	RXqoHzH6PA1i8VYt1N7YT1hBLLRLlIGUY1VwYkxwg==
X-Received: by 2002:a05:6000:402a:b0:47f:96e3:5322 with SMTP id ffacd0b85a97d-47f9fc8f595mr6148931f8f.7.1785065570487;
        Sun, 26 Jul 2026 04:32:50 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:50 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 07/12] md/raid1,raid10: skip futile retries on P2PDMA mapping failures
Date: Sun, 26 Jul 2026 13:32:24 +0200
Message-ID: <20260726113229.2154269-8-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BLK_STS_P2PDMA reflects the peer/member pairing, not member health:
retrying the same pages on the same member cannot succeed.  Keep
WriteErrorSeen so the range stays fenced, but skip WantReplacement and
FailFast eviction, as commit f7b24c7b41f2 ("md/raid1,raid10: don't fail
devices for invalid IO errors") did for BLK_STS_INVAL.  raid10
replacement legs are unchanged: a write error there fails the
replacement, whatever the status.

The failure is whole-range and deterministic, so narrow_write_error()'s
block-by-block submit_bio_wait() retries are pointless.  Record the
whole range as a bad block in the completion handler instead.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid1-10.c |  3 +++
 drivers/md/raid1.c    | 11 ++++++++---
 drivers/md/raid10.c   |  7 ++++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index cee21452e066..89daf8558251 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -309,6 +309,9 @@ static inline void raid1_write_error(struct mddev *mddev, struct md_rdev *rdev,
 {
 	set_bit(WriteErrorSeen, &rdev->flags);
 
+	if (bio->bi_status == BLK_STS_P2PDMA)
+		return;
+
 	if (!test_and_set_bit(WantReplacement, &rdev->flags))
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 19c4dec450de..83ebf40237d5 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2624,10 +2624,15 @@ static void handle_write_finished(struct r1conf *conf, struct r1bio *r1_bio)
 			 * narrow down and record precise write
 			 * errors.
 			 */
+			struct md_rdev *rdev = conf->mirrors[m].rdev;
+
 			fail = true;
-			narrow_write_error(r1_bio, m);
-			rdev_dec_pending(conf->mirrors[m].rdev,
-					 conf->mddev);
+			if (r1_bio->bios[m]->bi_status == BLK_STS_P2PDMA)
+				rdev_set_badblocks(rdev, r1_bio->sector,
+						   r1_bio->sectors, 0);
+			else
+				narrow_write_error(r1_bio, m);
+			rdev_dec_pending(rdev, conf->mddev);
 		}
 	if (fail) {
 		spin_lock_irq(&conf->device_lock);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 428bddddfe71..77c7d8a59916 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2940,7 +2940,12 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 				rdev_dec_pending(rdev, conf->mddev);
 			} else if (bio != NULL && bio->bi_status) {
 				fail = true;
-				narrow_write_error(r10_bio, m);
+				if (bio->bi_status == BLK_STS_P2PDMA)
+					rdev_set_badblocks(rdev,
+							   r10_bio->devs[m].addr,
+							   r10_bio->sectors, 0);
+				else
+					narrow_write_error(r10_bio, m);
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			bio = r10_bio->devs[m].repl_bio;
-- 
2.52.0

