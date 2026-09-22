Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189BC56C653
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790095739; cv=none; b=rJd9PYc7PUHRM+rz+QjhfmkQ5Bq/qxs/1DHxVEGtnujK7dA/B68PKlHN8CgtxIqcF4Ywxb27IzOgq23HXzpA31msP3jh9MzYELbLGcbn3gqctBGJmQH+xMky9b/sPKVJuomP+8ESg2m5/vWeUwWil8OiTnKL/nEqbJ63Ms1klYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790095739; c=relaxed/simple;
	bh=CNLswHmrXfd84ye0Kt7sXIpUx6vi6G1xuek1EYi5BIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzsurKc7229GyBLBBIAPh22agKkF1N+8Q28xyRZ3PC7ZLYy0MdhWG1WPYxlrSvbmdbovFGCH8V+qnb0Uqs5gVVJqKkiWCaH6aqyFm+4mBb0cFSdLtGrT2pGXMfHrF2pL4JbuMqeDICNHJ3KZVaXUHoaaiQsts9LHD5xnwEjU6kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeKA9b7r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeKA9b7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0F41F00893;
	Tue, 22 Sep 2026 16:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790095730;
	bh=YZL7VrRmf3cG/c+Kehs0oCOpD6Lg8b8VQHhgOCrEWaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KeKA9b7rUA/AcPZRX726KaGq9VYbEvokfyCWzwLITPf8mgAvhb8mebMJ50JlAB2XG
	 vZL6/mrshiuN2h+iuIm6kc1IvU8IKt+EcithLDM2eGaqPiw6gKZprgCwfXI1EhRLE+
	 X6JnjA3H421+EqKj8cGcWbLRqJrSBh+2+vTGCcgWfVGAacCDlPDqqWfSf0sZx/4fZo
	 y9YKBBsM8UC1qpHPyqaIXvQ3sbh5lOIjMNjRJ/s87qVIRZmRfodVeJGs7ELqTqdhnu
	 bdGpr5p/AEvdfg5IPquT8G7nAq6Q79jb4mTJ3VOJSsIwZy4uLSLfRnnqcVKxfS6TUQ
	 RRiAnWev8cEYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] block: move blk_drop_partitions to blk.h
Date: Tue, 22 Sep 2026 12:48:46 -0400
Message-ID: <20260922164848.3125553-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092239-justify-dizzy-3fd4@gregkh>
References: <2026092239-justify-dizzy-3fd4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit e7243285c0fc87054990fcde630583586ff8ed5f ]

No need to have this declaration in a public header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/r/20220124093913.742411-3-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 90af7fde083e ("memstick: ms_block: destroy io_queue workqueue on removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk.h           | 1 +
 include/linux/genhd.h | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk.h b/block/blk.h
index 07f571e1ece0a..395aba99026e5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -350,6 +350,7 @@ int bdev_add_partition(struct gendisk *disk, int partno, sector_t start,
 int bdev_del_partition(struct gendisk *disk, int partno);
 int bdev_resize_partition(struct gendisk *disk, int partno, sector_t start,
 		sector_t length);
+void blk_drop_partitions(struct gendisk *disk);
 
 int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 3f49a3a30e9bc..ccad6b4b5d289 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -235,7 +235,6 @@ static inline sector_t get_capacity(struct gendisk *disk)
 }
 
 int bdev_disk_changed(struct gendisk *disk, bool invalidate);
-void blk_drop_partitions(struct gendisk *disk);
 
 struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 		struct lock_class_key *lkclass);
-- 
2.53.0

