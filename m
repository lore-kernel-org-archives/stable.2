Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E514823D8
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784839403; cv=none; b=CC1e6X9th9GBcGKcvm4G1dxfzAEt5O6Ca5OpJWjGIQlxUjKF36JMVEjbAvhyz97lGCt/AxM0aVGbxBGqLYOIXyJh1pA4uR5vAVNfBmbGpd3l5L9s5C8Y1Nh7Ok94sdA5boRWoWJ5CsWNzNdGWnRdSO3/Qky32MZIAa2bozRhBgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784839403; c=relaxed/simple;
	bh=5VbqgoxnpZ25+DAS/Bu8wOeDLmqQ+TGKyYgc7R7RYZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fI9gVxLzft1lWkGIwgQnMt8KCJWTWVTxlEisGmhW+Ba8r0bxewlI3wkw1qrwrDG0xqZ68RRLGDAVx4K7JY2Si9nKrqkRW01xsq6ZPFYusNxQdY8UlnYcDfTtOymFauX4CzEjR7Cpsw/AQWyPh6niy//kMUp9j8X8BLiF7f94LdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=pWUtozAa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="pWUtozAa"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4955484387cso8503635e9.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 13:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839391; x=1785444191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LVDrwHOShpJST2v1XpPaKOLt9RN1zMUNY9kPyJb4mps=;
        b=pWUtozAaJSTecCwJDXbOMORoINDMoqgo9Qoopb+fRZGbZ+1dCa8zKImQRbnzXgwtS0
         4bxSTGZ+KB3kbLh8dqXEI6NqPkrJ7dpV3qr0Uhy9JLv6EOyCFQ0M7hmPKIX5uGzEwLJu
         WAjRRQS3RtP+TuPh9cC6966bVDVMFSZoQpJk/xLxg7RN7MSzwL9Xz3zp4XNk5qxbTPVa
         Ij7eQdCt2J9dRmBSjFvR0XePkWBYixyUSYzKKC3gd3hdtkBHQgGXcsohxJs9UXrqalVi
         bZytFv3qu5xQpBMWwy/WkbvtM7H6Yoe0LOjSNcckFsOaOnNOdz7TS0TrRWgJa7+N9MT9
         8NkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839391; x=1785444191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LVDrwHOShpJST2v1XpPaKOLt9RN1zMUNY9kPyJb4mps=;
        b=ST8EwieskrLmwJ4izZnTSVXgtu2YEs3OGEDS/wyec4WMh/VOZwhAtVkBVKqqP/nb5m
         18yDxNugRqfzNHqD9PIDO8ea4/78EQTy2xWisUiGZVgjetGz2gNS4C2VB4hVw2tcqtVQ
         6BfGL3XjXqchjbWSZcIkahiZ/KJjctNw6MENGMgofP+e0AMtGHUD5P61xVQUKc1QK+L0
         IBuAZhrwnOPX5b7fo7PzB5QO9Qyt1Uq6Wq9GxU7ZPAS+etiag4GRlCac7O85DWA7CEoJ
         uxJTf6jhBiji4teVVbuFTD+5fnZE0KBur5Aefc2zhMbipc87KWok+MlfI/6G0Ed0uw3z
         YNpw==
X-Forwarded-Encrypted: i=1; AHgh+RpYBA2jx+SOzfrkSpXAMF6KVKUk99N9YwDrnRDOsdxN8q/ViEH+I88VtFWlwcp2MGK14mOFxPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypOdwyNoHSnPcGKWxQNvm2brplzo5XkDWfEQxc5dZDNWrNd2Cr
	gHcuLnXDR6gdQl/5Iih4WjzBd7iiFwr87mr2wUTF0ejyMAa+LbDY0985vujQdTQUJQ==
X-Gm-Gg: AR+sD13NrYCr1rLC5h4p4dX45tcmnSpP8zfFlByTEAOWq0j7OCyYOVLWi0i0zP/14eO
	yyevlFsso95z8a8IMl24pkdf8f3mIyWhOmL6XgJvk7SyeYOK4C4AKadGsLsQYq2BRdNmkoDnxN8
	8LcgWuYgCVxV1lTOJiSfizlvNym7dLop0lLXTN3v/HiZCxvGcAFVxiIH7DUnIAsSdFr+CdHd62H
	PMqZDhh3IpzFVZcnA3FTAsJq/V2wUCIMvEHXzf0JxX798JeAGP+OiZZQztoLp/JZ8zfz9gxR90N
	4aN8bFFANModwJHVZTtwahlftMFGcCHZjhrLOTjksSvSaJc1dLx0Zjz1BcQ9ugKlZ1AyVWsJD+P
	xTa07ggCAI5bncnpSO7pcGe+Xtdv8PI+VbW+axTXlIRVmAirnIYfx20V3p5O4tvMpVpZQi7V99e
	vZFAFbhrRz6cz8GWJmCEZrba2djAwxbv/KPXZAshr+jybsttXtM07m0X7N6IY+/jbJL2y/h6Fnc
	tkBSYg0PUS/kFnZTI405LmydYImhYk8aVwrGNejYA==
X-Received: by 2002:a05:600c:6a07:b0:493:a613:56b2 with SMTP id 5b1f17b1804b1-49573c8d700mr36854855e9.8.1784839390786;
        Thu, 23 Jul 2026 13:43:10 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:10 -0700 (PDT)
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
Subject: [PATCH v5 08/10] md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
Date: Thu, 23 Jul 2026 22:42:04 +0200
Message-ID: <20260723204206.76930-9-mykola@meshstor.io>
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

A read that fails with BLK_STS_P2PDMA cannot succeed against that
member, so mark the leg IO_BLOCKED and let the retry redirect elsewhere.
Skip the read-error machinery: there is nothing on the medium to fix,
fix_read_error()'s probe reads into host pages and would "succeed", and
charging the read-error budget would evict a healthy member under a P2P
read workload.  FailFast eviction is skipped for the same reason -- the
request never reached the wire.

Fixes: 02666132403a ("md: propagate BLK_FEAT_PCI_P2PDMA from member devices to RAID device")
Assisted-by: Claude:claude-fable-5
Co-developed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/md/raid1.c  | 4 +++-
 drivers/md/raid10.c | 7 ++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 83ebf40237d5..16a47568679f 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2657,6 +2657,8 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 {
 	struct md_rdev *rdev = conf->mirrors[r1_bio->read_disk].rdev;
 	struct bio *bio = r1_bio->bios[r1_bio->read_disk];
+	/* evaluate before the bio_put() below */
+	blk_status_t status = bio->bi_status;
 	struct mddev *mddev = conf->mddev;
 	sector_t sector;
 
@@ -2674,7 +2676,7 @@ static void handle_read_error(struct r1conf *conf, struct r1bio *r1_bio)
 	 * read error.  This is all done synchronously while the array is
 	 * frozen.
 	 */
-	if (mddev->ro) {
+	if (mddev->ro || status == BLK_STS_P2PDMA) {
 		r1_bio->bios[r1_bio->read_disk] = IO_BLOCKED;
 	} else if (test_bit(FailFast, &rdev->flags)) {
 		md_error(mddev, rdev);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 77c7d8a59916..462f622556ed 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2847,7 +2847,9 @@ static void narrow_write_error(struct r10bio *r10_bio, int i)
 static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
 {
 	int slot = r10_bio->read_slot;
-	struct bio *bio;
+	struct bio *bio = r10_bio->devs[slot].bio;
+	/* evaluate before the bio_put() below */
+	blk_status_t status = bio->bi_status;
 	struct r10conf *conf = mddev->private;
 	struct md_rdev *rdev = r10_bio->devs[slot].rdev;
 
@@ -2859,11 +2861,10 @@ static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
 	 * This is all done synchronously while the array is
 	 * frozen.
 	 */
-	bio = r10_bio->devs[slot].bio;
 	bio_put(bio);
 	r10_bio->devs[slot].bio = NULL;
 
-	if (mddev->ro)
+	if (mddev->ro || status == BLK_STS_P2PDMA)
 		r10_bio->devs[slot].bio = IO_BLOCKED;
 	else if (!test_bit(FailFast, &rdev->flags)) {
 		freeze_array(conf, 1);
-- 
2.52.0

