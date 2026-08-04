Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870D442047F;
	Tue,  4 Aug 2026 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826814; cv=none; b=YueL4efsMqGpgGYygruX3HNDrSOwrkic+V9BXCL48m5kqUkJ+M76M2PPtlO93p6DrstKjeIFYaUB3BruFRnez+LzYNXfehBedjQcVEcsvWcCMYeGHCcgoKRCJuGQx6D6kpNHEEeiKbUVLpRPaiZkYcw8ShK7BpvRuKZE7mnDvOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826814; c=relaxed/simple;
	bh=N22kHvK6mOOEJ/Bkjn+SGiAGOz1ZEkVCjIpfjLth/L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUCqn4kVZ5YtXk6XlDK+JrwKC2IR4XhcncJrkJHPGLPhzWfNgUPBsl61L/AunDCR9/ZWRqs2kdlOfdW6SRCQWPDHWoxEgyfOHzf25YPmvDcaD1UPTdQ8l3YmQzwJBPDfojItzG/rrgC8pZDVJ4MBcLVzvV/ZP5D6PxygA+EzWH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ep35ejxk; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ep35ejxk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=RK
	O/S/RJRt+I8zai8vvuoOTW2EMSK3v6o65Y3YF4rxo=; b=Ep35ejxkBhexmaTSfZ
	RIwfR7AzEHPDRvkp2QwH4syP3zYYduhuySQbHCtvyASKhG04NDSdlMAD6FR4l/6l
	LgTKQOAAMmLUEnwkr3ZB2JpfDgAVlH3NS/POf7tLVYS+XnmI81ax2tukYwS0N3Bl
	fAJLj5K2qo+tPU9iybIo/rR10=
Received: from XLL-9950X.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAnD2LOjXFqfGujNQ--.47278S3;
	Tue, 04 Aug 2026 14:59:27 +0800 (CST)
From: Longlong Xia <xialonglong2025@163.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] zram: fix out-of-bounds access in writeback_store()
Date: Tue,  4 Aug 2026 14:59:18 +0800
Message-ID: <20260804065919.3970386-2-xialonglong2025@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804065919.3970386-1-xialonglong2025@163.com>
References: <20260804065919.3970386-1-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnD2LOjXFqfGujNQ--.47278S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryxCw48Gr48KF47Ww4Durg_yoW8WFWxpF
	srG34YkrW5Ka1IvrnxWrZY9F98A3ykJ3y3KrWjv3Wav3s5CF92va45tFyjvFy3X3sayFWa
	qrZ8AF95Gw4v9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7miiUUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC9w+Nhmpxjc+VnQAA3i

From: Longlong Xia <xialonglong@kylinos.cn>

writeback_store() calculates the table scan bounds before taking
dev_lock. A reset followed by reconfiguration with a smaller disksize
can therefore replace zram->table while writeback_store() is waiting for
the lock. Once it acquires the lock, it sees an initialized device but
scans the new table using the old upper bound, resulting in an
out-of-bounds access.

Calculate the number of pages while holding dev_lock so the scan bound
matches the table protected by the lock.

Fixes: a939888ec38b ("zram: support idle/huge page writeback")
Cc: <stable@vger.kernel.org>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 drivers/block/zram/zram_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ace65c586072..02fd64475a9a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1244,8 +1244,8 @@ static ssize_t writeback_store(struct device *dev,
 			       const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
-	u64 nr_pages = zram->disksize >> PAGE_SHIFT;
-	unsigned long lo = 0, hi = nr_pages;
+	u64 nr_pages;
+	unsigned long lo = 0, hi;
 	struct zram_pp_ctl *pp_ctl = NULL;
 	struct zram_wb_ctl *wb_ctl = NULL;
 	char *args, *param, *val;
@@ -1259,6 +1259,9 @@ static ssize_t writeback_store(struct device *dev,
 	if (!zram->backing_dev)
 		return -ENODEV;
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+	hi = nr_pages;
+
 	pp_ctl = init_pp_ctl();
 	if (!pp_ctl)
 		return -ENOMEM;
-- 
2.43.0

