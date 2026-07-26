Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD63ABD8D
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 11:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785065576; cv=none; b=QPIEW17nTT32Hanxieqxyawef0r4m1xv1gVYhJQTgKxTm06bZa/7zHRqHe3PmoVkBA034kVrSmW0iVsKwt2pUJy+TYrI0nqBYcY9SXdKu6E8SYnrw8CTs95pPlOe140WuUMS5S6hAYU/tSUn79babBk6rJRRYPhPrhRdyHdgHMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785065576; c=relaxed/simple;
	bh=5VbqgoxnpZ25+DAS/Bu8wOeDLmqQ+TGKyYgc7R7RYZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqxSL0MQBg+u7fp71n7rBCmq1seD29wFmXFCc1XO14zSzVyzdjFEKNhxBEnWe0l0YYPH2tPuUB3n8MFCkx6CITTWAAmUH1qwMYzvvFHCPAhAAaOjByVQ5K/y+nM5PMmarjOAwOk/bEcpjTI48UJD5BJOX43jeOOUCmRVn2E57sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io; spf=pass smtp.mailfrom=meshstor.io; dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b=I8CoToVg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meshstor.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meshstor.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meshstor.io header.i=@meshstor.io header.b="I8CoToVg"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso1042034f8f.1
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 04:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065573; x=1785670373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LVDrwHOShpJST2v1XpPaKOLt9RN1zMUNY9kPyJb4mps=;
        b=I8CoToVgnhfi6CD5hsnL1S5lf9veroblUqePdat1VA8hZao7t9o1XOYIWdG2BAtYD4
         Ewb+M6RPysjyjg7CefuJHYjobEuZqV2emlWsOXXoeu/xEY/qYUY0hwCelAB45Z5C+3Gf
         RktKAwkY83aALcsTcUf0a45zV5UwkBSiYGdvd7SFAPrEHhE9aDZR4oxZiU07zt7In8+l
         1KdKEsKN4x/Q7NOxsXaD5eM/3+O1fWWnZQnZ3EL9OqkuZ4TL0Se1jx5BmTusLCZpdeF8
         MWo9BVeOhdMwTqdpC1QGYm56Swe2twQGWP/dLqmEW0a5SpmP7xIddo3pdnbN8+jkA4/u
         KE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065573; x=1785670373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LVDrwHOShpJST2v1XpPaKOLt9RN1zMUNY9kPyJb4mps=;
        b=UekCZ6H2H4wb/0VeUfei6e4Am4FBNS8CfC0KGhcoEfjMoLIwbcZe5tv2F6dJtLzMIf
         3zNQ2RJqGrJGVZc/4dPtjJW9prdlduvOLAXEvTqdQoezndcgeZbjNcPcj8Xdr4/DeI7Y
         kfArcP9krg1QqUb3PtEmlmHSQiHHQvcocYT7CWfCWHwf3Hp1nwcDXuj715C0/54kguS8
         gDooarG/0T9jGLoFDBeURDKR8/x3BW1yE1TK4cuFh9L5iplp1fGTxJlFsf+usA3F7yIw
         z0D5L/iEAfYHBjFMWdkkWb83TvWDV9FKFayTMPI+He3PCvAxyHGA7p80ssB2tNTBbnYX
         QIHw==
X-Forwarded-Encrypted: i=1; AHgh+RoPXHlpcFzw1+1y0cvYQYbY5F1md4f6zmM3BCXkOr/sfdXjA4Gcy1Mgrst4MAeYUDPSYLauSvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR3ntGuIz0j9RcvrtfqTXK/JYpVmuw0sYHKDMztObgHI0Z6ZLl
	7rD1NeGZwVUNtmVPKFxiJ59/wtWG7+mEFP97DXEzEWIQRhDDCG7jqGUnaiIaFRq2oQ==
X-Gm-Gg: AR+sD10KGF6ldhfeq1OlNVIiHgds7LgUGutt2ZL0vtNY79zECvuTlmtQVHtVyaX+vtD
	s1jSeojjUKEwC8n/UTKTzI4ODfOHg/ExSA3huKvVWNE3naNB19C8b0cUQRZ2WFoPPDKJcfTmp6j
	i2Fv88z47/gxpAofvjgolQEqtU8oVhYqrrdhJnv5W5z+we8gT0fs2BgUp7sSOkNQt3ATs49X+CB
	2u2dCojRrdEdNiR/1qde415UhtzXBBLY688tnECX61cjpvMkEDiFj4cmHupFdtP5nyuArCwzHT9
	rPqDTjWuBwgdCvRHoj/oY7RaAJ41/2aBeJqG00XA9LrnzD8G28sKAfa8S4qMjDToZZS1THM1CJ5
	PEgxBhas4wL1pmdugrIuAXRWp7hZcok7Yw47svsnUdcdudaiFX/XcpU3etQJiKyY4AeWGIZRwZk
	OR9E3VYRaI6q4tikrzyZioWokdU7Ula0wNZK7LNflrxgt5MeMLzC+4ncgQZli6zdEXKjuf1i4xM
	zAkkGS8lE/P+PtUdZ54ThulF03FOfk4ujILrHGv0Q==
X-Received: by 2002:a05:6000:40e1:b0:47f:8fb6:c32e with SMTP id ffacd0b85a97d-47f9fea93b1mr5573278f8f.46.1785065572724;
        Sun, 26 Jul 2026 04:32:52 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:52 -0700 (PDT)
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
Subject: [PATCH v6 08/12] md/raid1,raid10: set IO_BLOCKED in case of BLK_STS_P2PDMA
Date: Sun, 26 Jul 2026 13:32:25 +0200
Message-ID: <20260726113229.2154269-9-mykola@meshstor.io>
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

