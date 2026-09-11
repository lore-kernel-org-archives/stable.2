Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998743B3F9
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123305; cv=none; b=ji8bpnLO6X7k2b+s3n5bkWpxOOI3HJ1A13ha9Mbw8ctjIuX4toBogcWf+v+yV84pmndy2jq2x+jhyunPyPzzDxxlhlwUlOl45baCMPPF6IRubGdzSrPcbf+HEYrtB3fdvFqCSZa1KeaUwoH4DAYYU+k7nYQn8BI5oaQV7mN8QOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123305; c=relaxed/simple;
	bh=cAtuvZP2OW5hwd8IMpgrifdmwAztlj5X3WFcZUCw5QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTbRZxzPE89dEmS7Wt7OrNWxCjjprlg19E3fkSTKan7bQGRAuYR80UG9sL2xu3OLrtpovcbTMs1IoWF5wANMKm1zbXLN4s8zVFfH0purrCaoRKLbpLq797cUIYfY1RRji2CtB+7dA8JCywoOLRvX1ucVYiJ/RziOz4hbxEiQ4Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbfUXd43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbfUXd43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFF81F00898;
	Fri, 11 Sep 2026 10:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123303;
	bh=/3Yw9c9MV4wEs4Dk9TvaSHKd9uJmYxMCMKEehAsAU70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kbfUXd43NTlgrr/krfs1cv4K0mNQmMN8U4qNbCWT1pgso3QtWoEyzqhiwHfue4FJF
	 lqvEj3ZYAAxZZq/MJMoCGgeDKMBg77BM1vBNgXZOPfIe+T4L2UqEmb+cCF+Wxkehpr
	 dXENBCtwYUzlAbPFlHyS3H65U622OW7tmfl/nFEmBPHNFmtnUvB6hUxVF2YPrhJyjb
	 ufpzoAYNWBjtNprZN1QPRO9vG81DadjyBOMF+cuC2vd//3wYS76MQjiw9Wkipee768
	 H0AERlPww8vVod/jZ5cbEwZHzErLsfaYZ1xO0TZJJUdFq6eACUuxowc0J1NBRv9P+u
	 B06ETA+4sEZFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] nvdimm: pmem: keep PREFLUSH before data writes
Date: Fri, 11 Sep 2026 06:41:38 -0400
Message-ID: <20260911104140.195754-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911104140.195754-1-sashal@kernel.org>
References: <2026090940-grappling-configure-44a7@gregkh>
 <20260911104140.195754-1-sashal@kernel.org>
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
index 96e6e9a5f235d..8a8cc5d8efeaa 100644
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

