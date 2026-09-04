Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380637F33E
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553942; cv=none; b=diWfgW2V417rTUTOpLLeBoHLrxszO2FU++CH5Qt8TaiYfQNJv8fY+2V5zXIsH7ab0Fzu8YyNPGB33e/Vran5nRwqBxMQtOkmm/xvKMAcQzgC+JmYFpGpMjlOBPZNp3F+mdzO5XVMZttjWAvhWftclpy8fWrfn1X2CbGOLdWEczU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553942; c=relaxed/simple;
	bh=pNx2q88ieBNpiTzy1OEMRhAwyKHNjVxSpHCDIZL0x10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSTIro9CDZSEgto6XJ2BqEb8ci0aG/J4QLAIzf32WMJrYSik1Ies+hHjZNvLuNhJgSe+A1OUAPkKUpzHX8E+d3nlOcVEhl48vjBDVLgDGEzXTmf/HqZSC+z9WzSd9sjNrBWnvjIHbEtU1abTSuzMBs3mO3gHLpoySnatBKBjc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLQK83X4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLQK83X4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C421F00AC4;
	Fri,  4 Sep 2026 20:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553936;
	bh=vmPt+QGL+gTHBRBTH0AYuF61MbdsDN5jTAxMlM/Do6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PLQK83X4EsIpO6Su/iRjxKpSgI/f328WhRXdZ2LNV9tE2TuawtEjEtToGPuSGNt2w
	 By+enIpFbN5Ky3UKaonSDk/yJ0QWRyoDVHQdGCM8mPx1+YHadz44d36qFsy4vvUnoX
	 TpVH9xjsKlR4tJBb1X8fx+XVdMqZUoS7JJGgtYQOBB0S0m5kE8gGoeomAQB6gLbDkJ
	 bLqmi20R9vB3Em4dlrIPvHD1PEYvYgX+bW69TYPKuwGzTB0XQIvrnZqEYhZT01nNse
	 bMrGvnpd17oQaJUUuKzyxXlpZvmZ1+gAQj0eJaSxOUj1wfN71zJLr7FJiPyA2ORoL0
	 +EkLQkR2QBWuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@google.com>,
	Richard Chang <richardycc@google.com>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/5] zram: read slot block idx under slot lock
Date: Fri,  4 Sep 2026 16:32:09 -0400
Message-ID: <20260904203211.1547892-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904203211.1547892-1-sashal@kernel.org>
References: <2026090323-dreamboat-stable-993d@gregkh>
 <20260904203211.1547892-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit 1b1a4e4d6797a57fefa40569fc920ce573bbf75b ]

Read slot's block id under slot-lock.  We release the slot-lock for bdev
read so, technically, slot still can get freed in the meantime, but at
least we will read bdev block (page) that holds previous know slot data,
not from slot->handle bdev block, which can be anything at that point.

Link: https://lkml.kernel.org/r/20251122074029.3948921-7-senozhatsky@chromium.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Minchan Kim <minchan@google.com>
Cc: Richard Chang <richardycc@google.com>
Cc: Yuwen Chen <ywen.chen@foxmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: dde75313eed0 ("zram: set default primary compressor in zram_destroy_comps()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a9f69da092ba5..29c6ca1586630 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1732,14 +1732,14 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 		ret = zram_read_from_zspool(zram, page, index);
 		zram_slot_unlock(zram, index);
 	} else {
+		unsigned long blk_idx = zram_get_handle(zram, index);
+
 		/*
 		 * The slot should be unlocked before reading from the backing
 		 * device.
 		 */
 		zram_slot_unlock(zram, index);
-
-		ret = read_from_bdev(zram, page, zram_get_handle(zram, index),
-				     parent);
+		ret = read_from_bdev(zram, page, blk_idx, parent);
 	}
 
 	/* Should NEVER happen. Return bio error if it does. */
-- 
2.53.0

