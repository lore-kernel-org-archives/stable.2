Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532F2275AEB
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086856; cv=none; b=tMKy/xWui/pA3J0uXUuQImwXOsru4CyqhDTiUh0sYxmA+BMhDW/LJcLRUs56yuZvjckhYWzyW+0ECWWhUr2xKPbA1b+cjb36GH+/7RQK3RC8GmQ5xT3aGuMbvSsdgCsjSb3nUY+3mLjcgW1ovVVzd++/dfT/uhO91WzX9QOceSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086856; c=relaxed/simple;
	bh=iGmRMXu14z800BMRHZk2HMDprrrlmAQHMP4Xg1JYAOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCt6slS46w5hPiNOSNOBxs5n/iez/skPaVk1DFgUaWenu6C8HIcic5OjGy7d/T4nK7hY6EKiDZffrqeUPghM9Ph8uONyb55+VlvwBGAJKHTOXUE9ZZW5QuUQxv5rv2GnSKb+iig7HQ2v3JbtMUbB9xZsXSxrWH+bNw4PUgZAGos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj5Lkq48; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj5Lkq48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD18A1F00898;
	Fri, 11 Sep 2026 00:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789086853;
	bh=D3Vg+l7iVh/q4d8UKMvPeM35ZsI3VnLmP6Om59E7+8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pj5Lkq48AVTa4RqcS9UDye8t3WTmWPYusSEUGiGmSm3w/TANccE6o7GpTjejC+g2c
	 UTMrUvoEcZ6QRqFNPd4lSqGseHTiSXd7qvbgTxdM53w140bz2JYezdK75cmuXs0R+R
	 PhX1jRC+7QNzgmbBlhhwo9HK2DYerWo/YiaUbvI2UVKa+vz9JVD+ZIFHFq3tLjx5el
	 1RvOzrmK2AcUj/cMhBi0G7ddrqePWs8F8UoJsI2nKPGCPZIgL1LxVpGcojxxAiyPwV
	 1SRA7Z9ct/YAMr7j/6CqPFIUJ9DFdcW0ZvZgFKa2R0OUQ0vZo0cZ4rVbCUMw41Ii6g
	 8Rq7glKb/2sSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/6] nvdimm: pmem: keep PREFLUSH before data writes
Date: Thu, 10 Sep 2026 20:34:06 -0400
Message-ID: <20260911003410.3483414-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911003410.3483414-1-sashal@kernel.org>
References: <2026090938-reliance-nearly-8ed8@gregkh>
 <20260911003410.3483414-1-sashal@kernel.org>
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
index 05785ff21a8bd..1d6056b1048fd 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -208,8 +208,14 @@ static void pmem_submit_bio(struct bio *bio)
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
@@ -229,7 +235,7 @@ static void pmem_submit_bio(struct bio *bio)
 	if (do_acct)
 		bio_end_io_acct(bio, start);
 
-	if (bio->bi_opf & REQ_FUA)
+	if ((bio->bi_opf & REQ_FUA) && !bio->bi_status)
 		ret = nvdimm_flush(nd_region, bio);
 
 	if (ret)
-- 
2.53.0

