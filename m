Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DAA42F70E;
	Tue,  7 Jul 2026 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439061; cv=none; b=WvlLGeqHE+WxhriRB7r/hSh6bBhydgqI7pdgoPWm3unwr9b+dQucqeZSdz/BONxJ77+g5U8Lv3MzoerNv8k1MNDC1fpSeLuZS/YA9AF9UWG7Ebypaut9PeK2xS4rzLryL6VmEw4MfgQUxWbykfE1OsnZ7vKlTHo3/BSClM5YPE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439061; c=relaxed/simple;
	bh=dMBKf2AX5Dyu3XptXi+HL+eqrOGbfiGBOJ/8EydqUNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPKkwwXVIZfFsxdynD47tjfXaV5Ym+oxOB8jj2bARZSEko5b/j6pVOvtCmKB5tGHeWeNxh2/X25klSkqyR0W8LskYTX0TW5ncFmYlJ5n+/g77iiVIopZB9u1fZWkYltPtFc1Lah2Mqe+JuX5ze74ntxxXz+n1QIwNHWE7IQlPpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=QKwbuDM9; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="QKwbuDM9"
From: Konstantin Andreev <andreev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1783438654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WvQytdZtu+yzyLYP8ABPtrzfMgo5skNZveQE1NDOW5E=;
	b=QKwbuDM9H6DH9G13VrjSKej9AdWAnGHAJ1P7wZ5zOzi0J6RXuRMvUcBYCkQh/55FsbHg9B
	dYd1u3+xyvRchpoJC60p9XKgmGj9OKSNIG2VHEqiTFGlYU91h6UNpBHXEfd3pCDRpb53AG
	nzQ9M022ON9qCY4iTRDZoxhwlIoS3x8=
To: stable@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12.y 2/2] block: fix queue freeze vs limits lock order in sysfs store methods
Date: Tue,  7 Jul 2026 18:37:28 +0300
Message-ID: <20260707153729.1834723-2-andreev@swemel.ru>
In-Reply-To: <20260707153729.1834723-1-andreev@swemel.ru>
References: <20260707153729.1834723-1-andreev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit c99f66e4084a62a2cc401c4704a84328aeddc9ec ]

queue_attr_store() always freezes a device queue before calling the
attribute store operation. For attributes that control queue limits, the
store operation will also lock the queue limits with a call to
queue_limits_start_update(). However, some drivers (e.g. SCSI sd) may
need to issue commands to a device to obtain limit values from the
hardware with the queue limits locked. This creates a potential ABBA
deadlock situation if a user attempts to modify a limit (thus freezing
the device queue) while the device driver starts a revalidation of the
device queue limits.

Avoid such deadlock by not freezing the queue before calling the
->store_limit() method in struct queue_sysfs_entry and instead use the
queue_limits_commit_update_frozen helper to freeze the queue after taking
the limits lock.

This also removes taking the sysfs lock for the store_limit method as
it doesn't protect anything here, but creates even more nesting.
Hopefully it will go away from the actual sysfs methods entirely soon.

(commit log adapted from a similar patch from  Damien Le Moal)

Fixes: ff956a3be95b ("block: use queue_limits_commit_update in queue_discard_max_store")
Fixes: 0327ca9d53bf ("block: use queue_limits_commit_update in queue_max_sectors_store")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Link: https://lore.kernel.org/r/20250110054726.1499538-7-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Konstantin Andreev <andreev@swemel.ru>
---

Backport of the CVE-2025-21807 fix to 6.12.y LTS
(the fix first appeared in mainline v6.14-rc1).
This CVE was previously backported to the v6.13.12 stable branch on 2025-02-08,
but was not ported to LTS kernels.

 block/blk-sysfs.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index c9e572ae0b9c..a5b6bcdfb9aa 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -684,22 +684,24 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 			return res;
 	}
 
-	mutex_lock(&q->sysfs_lock);
-	blk_mq_freeze_queue(q);
 	if (entry->store_limit) {
 		struct queue_limits lim = queue_limits_start_update(q);
 
 		res = entry->store_limit(disk, page, length, &lim);
 		if (res < 0) {
 			queue_limits_cancel_update(q);
-		} else {
-			res = queue_limits_commit_update(q, &lim);
-			if (!res)
-				res = length;
+			return res;
 		}
-	} else {
-		res = entry->store(disk, page, length);
+
+		res = queue_limits_commit_update_frozen(q, &lim);
+		if (res)
+			return res;
+		return length;
 	}
+
+	mutex_lock(&q->sysfs_lock);
+	blk_mq_freeze_queue(q);
+	res = entry->store(disk, page, length);
 	blk_mq_unfreeze_queue(q);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
-- 
2.47.3

