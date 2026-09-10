Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA50658F06E
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067332; cv=none; b=RrT0b/xOgxxoxUrwikzGjcHE3iR3v7CwOOlVy7+GqstrBzNTCwq36250nwtF4x55bKW8JEPuyB65+AtZZ7LXTy9MYmCq7h1f2YTfNHX10QSP4zQHgp8hDlMw1QCc5zh/uzb2zJwL/rurOpRbuSGqV2Zrmh3PPUeBQy+Dns0O3KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067332; c=relaxed/simple;
	bh=MsLV1dAh/WQYYzpO6nxUYmycpIv0kcHBTlAFX6voTYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJqrjGnv/ZVGKhq5KsTdIYU3noOkcS5aOMnfYuMOmcH/QcfB6+YnuzYaZA6zmq1YcGddXwSQwtWjdM/irkwfgait3xgDdA/nrrLe7zehwZCDZOIg7Kp+M1NC+XZhqGC6mv2v7G+2Al7AsG44ldB5PM65AYFl2a5dv9OLD3UEvBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ9xoFFf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ9xoFFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2931F000FF;
	Thu, 10 Sep 2026 19:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067331;
	bh=F0odfVyJ86pFqNosdt2jhZl5L97hnTfeTVyCCG1yUEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nQ9xoFFfDA90G7lzweffRPvSLr6uUiJ6CG4ydFxAxYDFXRXG7YMqEzZhiA1tFQT5u
	 13ZOoUOsiKR+5U5B1ZYeEzrOBqHEUto7bdOPHoVChnK2sqvDg8xazRMokDC0i7VA14
	 8Yc1SsHMnQwwhoWly/N1Sq7fAWyuhJgrvyrCB+AZX+hQ2jM+hONhTt4Fasxaf5oPor
	 aWKG7Wnal40kEHhvKzBp3OaXhk6RfAAQwRH0RPN06C8zPkRDh8Sj8ALBs0xzEJU6fu
	 P06VIs8eYVQqNVnZPYNePIm0waTlQ0DdFBr43tRHNOk6YCWP8rqE42ARpagYtTXSBj
	 WxJ1KbyY5szCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/7] mmc: don't set GENHD_FL_SUPPRESS_PARTITION_INFO
Date: Thu, 10 Sep 2026 15:08:43 -0400
Message-ID: <20260910190846.1453814-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910190846.1453814-1-sashal@kernel.org>
References: <2026090834-voyage-donut-60bd@gregkh>
 <20260910190846.1453814-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 79b0f79a835c6f1103c06e449cd88fb13e67f405 ]

This manually reverts 07b652cdbec3 ("mmc: card: Don't show eMMC RPMB and
BOOT areas in /proc/partitions").  Based on the commit description that
change was purely cosmetic.  mmc is the last driver that sets this
flag and thus prevents it from being removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Link: https://lore.kernel.org/r/20211122130625.1136848-10-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 3f9c7a108c0e ("block: flag zoned disks with GENHD_FL_NO_PART")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 51b43895e3a2d..1f7f52697b1e4 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2411,8 +2411,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	set_disk_ro(md->disk, md->read_only || default_ro);
 	md->disk->flags = GENHD_FL_EXT_DEVT;
 	if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
-		md->disk->flags |= GENHD_FL_NO_PART |
-				   GENHD_FL_SUPPRESS_PARTITION_INFO;
+		md->disk->flags |= GENHD_FL_NO_PART;
 
 	/*
 	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
-- 
2.53.0

