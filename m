Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC64954938E
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874399; cv=none; b=ryCuKES7ngq/6FA8fwUVd7CfBRSIgWQegly3Aua6aVReDt5YQOe0pyUFrvWimdb+547kYVq+FdE/UuMVxsaigYoGmEARiO+OG7bC/biV98BCALe9xLGR8u/gFsgKbFx60pzpZOeF9UK4CM43jvCtWw2JgI0D4B3SPAdFJREsJNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874399; c=relaxed/simple;
	bh=wStfZnVgmg2j80R2muszei4TEYo/ZSPAku01LNqt2MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzrbYtwx4z17wKG6zF9kQjQUeolxzUthp1XzhRl46DYO2vCmjS5FMTUD5CdO7El9peoPHQO93eFpSt6Bl4oYWjJ8ZA+YhDjBSWmIDMK/qbGEllmVtBSkwJJz0v/w0vaJLfYmxqJRAjILMTFsyTazHl32WlQTsAbK+8TMIUJvi6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1391F00ACA;
	Tue,  8 Sep 2026 13:33:05 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] block: drop the "busy inodes on changed media" log message
Date: Tue,  8 Sep 2026 09:32:58 -0400
Message-ID: <20260908133259.2325197-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908133259.2325197-1-sashal@kernel.org>
References: <2026090327-engross-lapped-120b@gregkh>
 <20260908133259.2325197-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 127a5093c79d9cdea9e6edc016ab346e6dd16c23 ]

This message isn't exactly helpful, and file systems already print way more
useful messages when shut down while active.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Message-Id: <20230811100828.1897174-13-hch@lst.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 7e9a46004b47 ("block: set QUEUE_FLAG_DYING unconditionally in blk_mark_disk_dead()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/disk-events.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/block/disk-events.c b/block/disk-events.c
index c25b67c190a6c..d44f6b6aca3d8 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -281,9 +281,7 @@ bool bdev_check_media_change(struct block_device *bdev)
 	if (!(events & DISK_EVENT_MEDIA_CHANGE))
 		return false;
 
-	if (__invalidate_device(bdev, true))
-		pr_warn("VFS: busy inodes on changed media %s\n",
-			bdev->bd_disk->disk_name);
+	__invalidate_device(bdev, true);
 	set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
 	return true;
 }
@@ -302,9 +300,7 @@ void disk_force_media_change(struct gendisk *disk)
 {
 	disk_event_uevent(disk, DISK_EVENT_MEDIA_CHANGE);
 	inc_diskseq(disk);
-	if (__invalidate_device(disk->part0, true))
-		pr_warn("VFS: busy inodes on changed media %s\n",
-			disk->disk_name);
+	__invalidate_device(disk->part0, true);
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
 }
 EXPORT_SYMBOL_GPL(disk_force_media_change);
-- 
2.53.0

