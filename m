Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396638D3F1
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067332; cv=none; b=Ib6a3XZUnq6McHmudOSgYommFKlyohdny54g4fwYBUZGwuW7xHoAhWpIdDCyFkar/xfOrDbroerqOVJuXatMtwpRYVFrdcBRwcWZlYFziYRiKYW5W4H9ngRIyMjVRfquNa4chHdwpZZLw4ohXd7hS92A6MJGiLBYnugQ4mnpuFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067332; c=relaxed/simple;
	bh=/59W0oXlXc8ScqLqudjW+qu7vV1+uVqKQdRNY8g3nUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5W/K4uBj08orOpN/cBe7KakVNuk1m9opLaA60ChCpWS3+IfByLxzk9FPtqT7+W+/1M+qi9cP0jF6rHgQOS4pB8ziwUpUDFEz6ZSVrPKt9ITkme5UBMIqV2qz6e54ankVE0vcWYWxq/Zk7zSdOFt2k1W3NjjEV+lkKFDinZ3Xcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bh3GmmfL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bh3GmmfL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249F21F00899;
	Thu, 10 Sep 2026 19:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067330;
	bh=StxUhHge0O6axzUdGMJQaVWZ/FVM/6IUUmNi/1vcH8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bh3GmmfLJKtIjGf0gGWF7s35s1kK88hTEDHF15Nk26OTe9LXQcdZTslb7e4VMxUFS
	 G0HlD3P/xEDU2evqubDy9GDE6m3IbI97316JtrPw1TpkXCy1i2lYKMyQpFaiEkmqtW
	 BrOZxzYTWaZtLkCtlB2/tO5wlPah4vzK0BhAlKs/oP/HXW39Qlgt69inIOqm2tfkYv
	 168NffrsJAJAeinuxeiD5BimXQaZ+esqQnqepktq/VXLSbq6K/4m9Vd8ZR+XAF/XNe
	 IuzDF4E3cjCx1fCOdmALv5OHldbg8AMUrCJGVCrXpLrNVWWpg6lol1vfXtItI4bGCN
	 pRVed//0Rojuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/7] null_blk: don't suppress partitioning information
Date: Thu, 10 Sep 2026 15:08:42 -0400
Message-ID: <20260910190846.1453814-3-sashal@kernel.org>
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

[ Upstream commit 94b49c3ddb2127f84a133d70cef49054e1ebaaa4 ]

This manually reverts commit 27290b469051 ("null_blk: suppress invalid
partition info").  The message in that commit log can't appearch as
the flag is never checked during probing, and there is no good reason
to treat null_blk special in /proc/partitions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20211122130625.1136848-9-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 3f9c7a108c0e ("block: flag zoned disks with GENHD_FL_NO_PART")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 8e24fb93324cb..de14af5232ae2 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1692,7 +1692,7 @@ static int null_gendisk_register(struct nullb *nullb)
 		return -ENOMEM;
 	set_capacity(disk, size);
 
-	disk->flags |= GENHD_FL_EXT_DEVT | GENHD_FL_SUPPRESS_PARTITION_INFO;
+	disk->flags |= GENHD_FL_EXT_DEVT;
 	disk->major		= null_major;
 	disk->first_minor	= nullb->index;
 	if (queue_is_mq(nullb->q))
-- 
2.53.0

