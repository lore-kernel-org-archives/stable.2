Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3C37B40E
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789091039; cv=none; b=Os7ExjVytKvVqsG9zMOIMopxYwpqYtwNzOwgxZrDj6RX7qj2uvAIk486bhfrZGlB62q4P0uUV9qSVgioLm0b2S0fc+4PjlFkIwZVtu9RBUCmYA+B/SUyOBCFv5AYkfI5/QB8S6eARubbAA9C2TweHMqXgARRCWrIYp8UMnI3hSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789091039; c=relaxed/simple;
	bh=kDRSPfUPEyD7WtyDuh0Q79vnkUaeq0QQqlOLUfRWJtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubQQ4VumZTbOIOILs0GMd7PdonwDOjdAscqfYcOLePyklqVWM3gauaVpv69StmvxZwhAKj0jMt9Rz9ekxOn9CoHbpfWKoX+lYVhIKDgGEACF5F09UhjBd+fJJUPY5Nu5JMnrsc+rPPqNE2uOgQXqLP9id07GNVbtsZkh7eVFO0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOKtemUp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOKtemUp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8521F00898;
	Fri, 11 Sep 2026 01:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789091038;
	bh=pimd6/Zm0g2eibOk0fd0qVrOck2fEFltZF4fgkpnjE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QOKtemUplLTVwyAf4u/5rvJD9RY0zI0Nw/FyRZN2MxromOzyCxbs6iTI7/YFRPr0f
	 dPTqHnREN34lzRzxhCdvs8e+zgxeohgrPY8/q59HrJuDUHrH2h3K+ADuSZplfz0uZC
	 z0soaqoFx0G1UDy1O1v3wRaBnVX1RdxJ8vTwGwDbdUalhRdDR/SgefMh/cVkJmzfpu
	 f745bUF7ZjdbjqXQ7G2RO/qvdarPNarMWG4bJgF8XEUbbXsmhpSlyC3Rxh59bYRgkw
	 IvXvRDidVrk3R4jhFbO/B3KpwUPPP3w3WwjiCE1xP9/rsy7yFfcTpP9WqvgQV6wzax
	 jAhCW3ZGVmNLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Li Chen <me@linux.beauty>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/6] nvdimm: pmem: keep PREFLUSH before data writes
Date: Thu, 10 Sep 2026 21:43:51 -0400
Message-ID: <20260911014355.4149601-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911014355.4149601-1-sashal@kernel.org>
References: <2026090939-disdain-corridor-626c@gregkh>
 <20260911014355.4149601-1-sashal@kernel.org>
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
index 4e8fdcb3f1c82..e82c8e7ec3720 100644
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

