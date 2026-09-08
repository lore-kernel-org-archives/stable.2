Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3185592FA
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874398; cv=none; b=NpuoKFA4jWnucoOKTwSKyNfAqKT1NkqoQm8Q5CUKP4eVbvS89vviwNMwOTesx0wk7LfXo8P60c9rLsWITsf7rD+iDxXAO28WKB2ZLy3Yrjl6p7z6N7z8SZaikVxQlc3jU2Gdh8uJeOYR0JjjXmv5uJeTmc35VFZ8NuEZjyvcVCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874398; c=relaxed/simple;
	bh=TtLc0jag+GTgKU7eAj9d4GE4aoXuSktorKkVzJA7r2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mevJXm6b71mUyBttvEbvBHln9JojpxN7NBwsyGLnq8lsXRNdbZFPzRHYrO6RT6A2FspejdZq45nxpS4C/MGNp1uBqOqoxQK6PpvlksEmn+NmxVBv70UA/oCTo+NdCUi0luDoyJYwAccxUGJK7k8oK+QvKLBaND8elc+13leOhkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2BE1F00A3D;
	Tue,  8 Sep 2026 13:33:04 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Josef Bacik <josef@toxicpanda.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] dasd: also call __invalidate_device when setting the device offline
Date: Tue,  8 Sep 2026 09:32:57 -0400
Message-ID: <20260908133259.2325197-2-sashal@kernel.org>
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

[ Upstream commit 2527fd38772fea30c1d1cbf94839a0bbf4122133 ]

Don't just write out the data, but also invalidate all caches when setting
the device offline.  Stop canceling the offlining when writeback fails
as there is no way to recover from that anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Message-Id: <20230811100828.1897174-12-hch@lst.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 7e9a46004b47 ("block: set QUEUE_FLAG_DYING unconditionally in blk_mark_disk_dead()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 4250671e4400d..591b6cd934aaa 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3628,9 +3628,8 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
 		 * empty
 		 */
 		if (device->block) {
-			rc = fsync_bdev(device->block->bdev);
-			if (rc != 0)
-				goto interrupted;
+			fsync_bdev(device->block->bdev);
+			__invalidate_device(device->block->bdev, true);
 		}
 		dasd_schedule_device_bh(device);
 		rc = wait_event_interruptible(shutdown_waitq,
-- 
2.53.0

