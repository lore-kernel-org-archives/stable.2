Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72331195B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089200; cv=none; b=AjIxBxrezPdvXXvM/GEmoo/fi4HqcXXywRgS/SGvAjonxKjqXmwvmGSwplIw5MydAUKQSZGCPNs8xIvEs1VcZueR3wgoxf9THTqujpKLfGRDG4Yib1NwL32YGbWzMLjUg3r/LsMDBR/9V59KACeYtqEFwKORBBQojKwqkBOMB9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089200; c=relaxed/simple;
	bh=h1mjtZ3+L7Ncpf7dXFRyS+4hsGvzm3SXH4nNY396Wb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXWw8GH2J0M1HnIiQKtGplBSPcJay2B3iV+UyzKtNAHxN2te5R19tSO4y/17heCk5WH0nEKBqO+Yuixw1e70W/dtsCNH/oaArR5UhZc1hpHjsb4iINVdiw4WQugH2l5DrXKz9U+xyhtb+hM2VfOVGG+JbIlbssfPV+UJLunA2yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QF5ZW+/L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QF5ZW+/L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D791F000FF;
	Fri, 11 Sep 2026 01:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089196;
	bh=N5w93MDL8LmulaLku/iPFimVRgAHP0+La/BnLTBvfdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QF5ZW+/Ljn09Ypd7k/AAo4MQEYcUgVgcrxiKtbYyTQ+45oumYc72OXbjP1NS51EDT
	 ZSbrciz4V4YA525g4FBCmgkHLAxOKbgeEUw0hqR3oZzAuzzfJb7MidfCb8YU8+F0gs
	 FFQNQVNfLJ9nEytFdLcP/1HRIWsneamfSvyTbYkeS2/se8cxQ9yKbBg/el3lS1eUmn
	 tQGMLnf6qNLJx8glc+t90T6XObff/z6pMkHymmn7Dt7+maNxykYp0ZU5ssRMDWpg5Q
	 yzfeGM2IXVyq5z03l2dPa58VmPxpaFjsHyjDpom2026RMoPlW+hjmPKtrdrCIAz3jC
	 SInK53HCgsO0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/6] nvdimm: pmem: keep PREFLUSH before data writes
Date: Thu, 10 Sep 2026 21:13:09 -0400
Message-ID: <20260911011313.4034971-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911011313.4034971-1-sashal@kernel.org>
References: <2026090939-defiance-yelling-974c@gregkh>
 <20260911011313.4034971-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Chen <me@linux.beauty>

[ Upstream commit c644a2f8fef5618fcf453c591177700fd07dd024 ]

pmem_submit_bio() records a REQ_PREFLUSH error, but continues to copy the
bio data and can later overwrite the error with a successful REQ_FUA flush.
That lets data writes run after a failed preflush and can complete the bio
successfully despite the failed ordering barrier.

Run the REQ_PREFLUSH flush synchronously before touching the bio data and
complete the bio with the flush error if it fails. Keep asynchronous flush
chaining for REQ_FUA. At that point, data copy has completed and the parent
bio can wait for the chained flush bio.

Signed-off-by: Li Chen <me@linux.beauty>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260630092338.2094628-3-me@linux.beauty>
Stable-dep-of: e57140944b5a ("nvdimm: virtio_pmem: refcount requests for token lifetime")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/pmem.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 210fb77f51ba0..58f335dd57464 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -209,8 +209,14 @@ static void pmem_submit_bio(struct bio *bio)
 	struct pmem_device *pmem = bio->bi_bdev->bd_disk->private_data;
 	struct nd_region *nd_region = to_region(pmem);
 
-	if (bio->bi_opf & REQ_PREFLUSH)
-		ret = nvdimm_flush(nd_region, bio);
+	if (bio->bi_opf & REQ_PREFLUSH) {
+		ret = nvdimm_flush(nd_region, NULL);
+		if (ret) {
+			bio->bi_status = errno_to_blk_status(ret);
+			bio_endio(bio);
+			return;
+		}
+	}
 
 	do_acct = blk_queue_io_stat(bio->bi_bdev->bd_disk->queue);
 	if (do_acct)
@@ -230,7 +236,7 @@ static void pmem_submit_bio(struct bio *bio)
 	if (do_acct)
 		bio_end_io_acct(bio, start);
 
-	if (bio->bi_opf & REQ_FUA)
+	if ((bio->bi_opf & REQ_FUA) && !bio->bi_status)
 		ret = nvdimm_flush(nd_region, bio);
 
 	if (ret)
-- 
2.53.0

