Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14B33AD527;
	Tue,  4 Aug 2026 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854364; cv=none; b=lk6E9oESy28GhjHrnvvShFUtOe57VUs7A40TCMqrzT+WFWZ5xxP8lHi1+onsaBY8S2RI03uYZic0aNCHM9VchzSAVadWErXbx4DOEUItekNeMtCX3sRxrtuKcTmmNLC9vm8UrNdE0W84vLpKmo0R741XkXZRG75ea/ziknzOto4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854364; c=relaxed/simple;
	bh=4X1tPzJigVvr40BdaDBDCLhEpe1kcYx6kA9UvOTX4DY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fI8iiHKJheeV8fc/IzeEl/z6HfPkzUOQoxho2KSvUGAAcYVTzwBV+zhP0uLNPhWIRXYQDtHwEouSCui+yb2JBSfZKJyMriLtgZ4npC4vov2r1cMIhV8Z2y3JAZL7wv2mFr2X4FOiQN5ukbbpChkMYI4zbYzlld4ukcL2kqcno1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JsMPjO7g; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JsMPjO7g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=WY
	+pSK9kVlYwbHQ/s3RtNIXYh4tZ60x6d6fkvs7Kgos=; b=JsMPjO7gsGMZkn+DqH
	TcxGK5eEkmS7j3oo73DZS3g1Iotu5CzPFmCgIaFGenow0olFkRU8iZESlyHTUhAh
	GtnVGx0N78ejqgsE7IF2v+vcTyvVyGiOOWAmdcfxEnqkFVYR4aIDq1aoIPokvFOX
	M0iXt0hMDy6G+gvgt20FY/XPI=
Received: from XLL-9950X.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wB3hVZs+XFq6UfaMA--.60636S2;
	Tue, 04 Aug 2026 22:38:36 +0800 (CST)
From: Longlong Xia <xialonglong2025@163.com>
To: minchan@kernel.org,
	senozhatsky@chromium.org
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH 1/1] zram: reject disksizes that exceed slot index range
Date: Tue,  4 Aug 2026 22:38:32 +0800
Message-ID: <20260804143832.146129-1-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3hVZs+XFq6UfaMA--.60636S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF15Aw1kGFW8WFW7GrW8Xrb_yoW8Wr4rpF
	WUGFyYkrW8K3WUZw1jg3y8tF1ru395A3y5GFyYyws2vryrGF97Ca4UJFyFga47Zrn5AFWa
	qFn0ya95WFWkXrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrdb8UUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC2wyQiWpx+Wz8SwAA33

From: Longlong Xia <xialonglong@kylinos.cn>

zram uses u32 slot indexes, while disksize_store() accepts a u64
size. On 32-bit systems, a disksize larger than U32_MAX pages is
truncated when zram_meta_alloc() assigns the page count to size_t.
array_size() then sees only the truncated count, so a small table can
be allocated while the original capacity is published. Valid I/O
within that capacity can subsequently access beyond zram->table.

The same oversized capacity also lets full-device scanners compare a
u32 index with an upper bound larger than U32_MAX, so the index can
wrap instead of terminating.

Reject disksizes larger than U32_MAX pages before aligning and
allocating the table. This keeps the table size, published capacity and
slot index range consistent.

Fixes: 33863c21e69e ("Staging: zram: Replace ioctls with sysfs interface")
Cc: <stable@vger.kernel.org>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 drivers/block/zram/zram_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ace65c586072..2728a8a826d4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2876,6 +2876,9 @@ static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
 		return -EBUSY;
 	}
 
+	if (disksize > (u64)U32_MAX << PAGE_SHIFT)
+		return -EINVAL;
+
 	disksize = PAGE_ALIGN(disksize);
 	if (!zram_meta_alloc(zram, disksize))
 		return -ENOMEM;
-- 
2.43.0

