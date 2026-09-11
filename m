Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E7B282F1F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086573; cv=none; b=qRVQ8D811+vtNohZrjC/V3196f+lGD719ZgSftJMfIGj0SBrJ0HoB+9eGkEClEQfkIXRw9u5BWXbSVGI47Ik6P14+1NbCIh9y6shCtedanEg+aHYyc5+Fu+LFqHYXY2wI2yk3ddMi6CSygjtEt5tBC3FpJeYbtt5dqhQxSKQEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086573; c=relaxed/simple;
	bh=L2NV2KaTR9zYRhStKivLn4HuEBFIQPrLKeXhalQ0ZGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7NQnndk1Ck/6KJJz+FtMXBrxUi0ieforMvjyvJlNGCkZ4slVNCP3hYeZXQbmZhTL4caPtFObvS7zpO1k17WsvRqNwJQsbmkCChwhARJgnn378eq7u2w0zCjCInuIscY2eyy3LbUH+MPI44L4h0db9tKx3cNzCCacf3wul2YMhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ1PvyfE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ1PvyfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0601F00898;
	Fri, 11 Sep 2026 00:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789086571;
	bh=ZRLpU+IlhpJ4q0wzGdLGVxIUuSgpE4rAM1GALwEaAbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UZ1PvyfEWODSyqUyGx50MtU7EKLxjzaziIr/2V1A+isP/13Jsp5ymjDL9XgwNvoVl
	 IxuPv03+1rHNBnRbNcCmH/cdOzlHdcptx4c359dtbSSzodTWC1Q0wO3nr20Dp1xNhX
	 vftT+UNo6KqjQFbm4OUm94nB3DmQuVENvyWrUZB1dMw98uJockkGEocuULKEgFNO+d
	 B/XfbWtJxk0lXZNOb+g0m6rm2w13zwj3XLLn9K+t2kVs6FeDUMkO1CpA/dSBfkGxuT
	 ZS9IMzkn0B3+8AG0fL20NdRUbKF2kmJDaP/ZXPgF1Ku0StQgf7Uv1Rxpwp0hu8PTGu
	 ohI8FstwcJ6eQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/6] nvdimm: pmem: keep PREFLUSH before data writes
Date: Thu, 10 Sep 2026 20:29:24 -0400
Message-ID: <20260911002928.3429646-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911002928.3429646-1-sashal@kernel.org>
References: <2026090938-graves-stress-5791@gregkh>
 <20260911002928.3429646-1-sashal@kernel.org>
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
index 92c67fbbc1c85..05d3de33e2706 100644
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

