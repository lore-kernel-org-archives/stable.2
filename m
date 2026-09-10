Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4FE568552
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067330; cv=none; b=AuvqOXaMvPFoO/Z25gjWuKQEFfy12HEM8qDmsqeMvCiN1rRpUW4pJVVTXYVVlPRQQcEtfjvfBzlFmtJEFGgClC2n2N4WJvxWmj8HihQxmQHbe7sHmRNmH/LZw0uZkVPZfE7Uo0031MSMmj/9uogXn9Vi+lH0splFZQqIZYBwets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067330; c=relaxed/simple;
	bh=Qv3W1uJ2ykF7Sb1IvzBDR/Ovge4S0FtIm4xBfZoaEhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YO9LnWNNU7TS1M+7x2xQyTmupgfEvoz3NAqAvODzVxDpRs9K0V5sZbkf4SByAaiUiDp+7I71HIWkq/fQ/KYwPf0iQvDyDjIpFzbMnZWbmp065PoBNZGOiB8N/QT0qXskcMqqnWJaciUrPUD8A484KP5HpmGtdSNSeTN8cqULJL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJqfObzl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJqfObzl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D71F1F000FF;
	Thu, 10 Sep 2026 19:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067329;
	bh=6u/WLyVlv6nCqy9K27OlZH8CfIXi/qhemIAkHcGXjKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GJqfObzlVDFooKZ/88adhUwTJ1Xj2W8U+xeLz2RN/DA1WhSxQF3ep5jJbmeVVvE2e
	 2n6vu/lNGjUUX3rUqaKHAqQ78D+8wnCSi65PdSniRCZQO3UIy/SHG/8MnCRiyzUoX+
	 RQYD3IEAZg8kf8UtyV051hCkDEM5iUabCNmna3cNfUopS9em2LFCTNUsr+d1PJF5LJ
	 j3r+agKsEVqloRlkZakkqs+fQBnaZIOC7++B12bKM21i1sLgRLvhWNzLsr/EphAnBH
	 vojo6iDjSNxSPfh0gS1LSpDwdcOYP84aqIkHVhD+9ak6eFpUZw9OL0tZCYozyoY+5X
	 nSqTiUDYlfR6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/7] block: remove a dead check in show_partition
Date: Thu, 10 Sep 2026 15:08:40 -0400
Message-ID: <20260910190846.1453814-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090834-voyage-donut-60bd@gregkh>
References: <2026090834-voyage-donut-60bd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit e3b3bad3f29878d13fdbc96f9e59674bd9b06bae ]

disk_max_parts never returns 0 given that ->minors for devices not using
the extended dev_t must be non-zero, and disk_max_parts always returns
DISK_MAX_PARTS for the latter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20211122130625.1136848-5-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 3f9c7a108c0e ("block: flag zoned disks with GENHD_FL_NO_PART")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/genhd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 768a49460bf19..01a7b81eca751 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1174,9 +1174,7 @@ static int show_partition(struct seq_file *seqf, void *v)
 	struct hd_struct *part;
 	char buf[BDEVNAME_SIZE];
 
-	/* Don't show non-partitionable removeable devices or empty devices */
-	if (!get_capacity(sgp) || (!disk_max_parts(sgp) &&
-				   (sgp->flags & GENHD_FL_REMOVABLE)))
+	if (!get_capacity(sgp))
 		return 0;
 	if (sgp->flags & GENHD_FL_SUPPRESS_PARTITION_INFO)
 		return 0;
-- 
2.53.0

