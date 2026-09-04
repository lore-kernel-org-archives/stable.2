Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FE84FDE69
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537538; cv=none; b=U/DIybDjujzYUw7du1QvGwMrBeq7kGIRStN9uxRNi1hM44Gx7HXXG6Bk+7DZuVZ5PSNbtvsnvAscX4lUu3vtfa/8R7qxmrVBXrr1r5bYwzy40q6DGrOZIAstKvzfvCFIZzcCgOc3P4EFLhX8Rd+oRMzg9brbnud8wfQL3oZNiL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537538; c=relaxed/simple;
	bh=rQux/6bbwoM4MUPngajCqLEPGsXnf4G/BX4VXlh52SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9PMAEMnXBwiRRpV8UEEmjCGC5bk4DDEedvEEXO+lzNakp8a6w4wxA1kk6KkhLzWWAuCCI6q/KxbAYDi82jdDMADgcZqUVnrW2R90a1TI/4pWwo7h1nxMYCS2/4hg+cK1bTaO2vEPainQ7kFOZ8t8fhQ1Qz74BTTnLqJYe61R4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0lNIOm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0lNIOm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1731F01564;
	Fri,  4 Sep 2026 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537535;
	bh=m+5ipZoQ2ILwm/S4Q1hKjsMJCuXPv6HjoQLmWTKDON8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M0lNIOm1c6TqwayYoilmRIEPyu+ZFgcbdvQiWlwGGfsriUe0eQKa3alvOdf+8vhbD
	 dhVeJ/87JYIX9foKd2132fub4tMsOvCTmenjR4313ZGq29grpGadnicDvehUJtc+Cf
	 gwtAuqACQDdpOjX933inrdhNoRRhsilk2ZypWoAc7LkND1+JWEs1pv83/Op53UACRJ
	 T8sgNvy1TATO/CvUW/9k8okP6Sd53OqZtmuQkKo0kBpQvow2zvIEQtVMR0p+nB+Fkc
	 gaQVzMBCgfIyOWGNcbMudZ2LB2E3SjI+LMLQarRR4DGTzDwgd5o31qSBfKDiHDWbot
	 bqUAzfu4RoH3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] zram: fix out-of-bounds access in read_block_state()
Date: Fri,  4 Sep 2026 11:58:52 -0400
Message-ID: <20260904155852.1071464-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904155852.1071464-1-sashal@kernel.org>
References: <2026090352-imaginary-automaker-68e8@gregkh>
 <20260904155852.1071464-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Longlong Xia <xialonglong@kylinos.cn>

[ Upstream commit 391f057f44a51cc9418da5cba78b014324174264 ]

read_block_state() calculates nr_pages before taking dev_lock.  If the
device is reset and reinitialized with a smaller disksize before lock
acquisition, nr_pages still describes the old table.  The subsequent loop
can then call slot_lock() past the end of the newly allocated table.

Read disksize after acquiring dev_lock and checking that the device is
initialized.  The read lock then keeps the table and its bound stable for
the duration of the scan.

Link: https://lore.kernel.org/20260804065919.3970386-3-xialonglong2025@163.com
Fixes: c0265342bff4 ("zram: introduce zram memory tracking")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 84d977505ca52..683480f67f375 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1135,7 +1135,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	char *kbuf;
 	ssize_t index, written = 0;
 	struct zram *zram = file->private_data;
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long nr_pages;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
@@ -1148,6 +1148,8 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 		return -EINVAL;
 	}
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+
 	for (index = *ppos; index < nr_pages; index++) {
 		int copied;
 		struct timespec64 ts;
-- 
2.53.0

