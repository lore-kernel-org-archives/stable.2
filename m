Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E251FCDB
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547798; cv=none; b=MThkrD/gWIK7wz54Vvs1xq8zKEzWwq+ZYj3Fy0DfddV7Mpnh0RhDxyHqwdWTR1LzpSfypb7b41Qjd5OlGuX7d1GV4Ib+tbILGhiNccfWhFaG5nS2Q8/FOheEaQHIFiHBthIRtCJAPPtQnwCAQ/R3RivNMu026ENLXBx1FxJxDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547798; c=relaxed/simple;
	bh=AcP4HwON4u8Q0MiG/nlqZvJ2/rmgMURFjLupVtTBnv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNQbpTsgu8PkrG9OedzaapsgsrEFu9UZbcuTi2weyu9QVA0e77cjwslwlt3vKS9AwsOdd4V63BX+PUGDNifwKRh1ScY/xr5pOu04YJveVBt7EiF4IJH3RQtRJkLi4zNVcSRPtjj3TSCQKkCwfLU2FFmeJoioxDmZfg61ynTqJTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyUHEry6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyUHEry6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA31C1F00A3D;
	Fri,  4 Sep 2026 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788547796;
	bh=nZIdEgla7VUEPIbrc7qX7Bp1emmoHvGFOWNBu9bpyVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WyUHEry65uYCEwP81ZwRKWvlDbygNSEIGG6Lsd8H+hrL2vBzK3rVhaHcnwBrDjn1r
	 z0BJW3gIjfF6GL+YdtHy2tvs4PZWk4d21A7jA6MLI8JrWr2N0FYc7VSkvm7T/Butlo
	 1KhdYHNCZ3z2tpfJw64nME4k94+glo3fGk+38UptTMGDvCaEQrBuuBPZBsfCrls10L
	 rs0oTwuisD6svWTySxNUkG4ehD6y+MjSF7ogMOKs/o5QSr8z+72tnqMhYxhu0r1xew
	 0P+OR19oVclJuIsbVusE6EvW5WtMILTTABWLrBQjGgDltpleQsBqIZqncBrOqv6zCO
	 ZsJtgXutmshug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] zram: fix out-of-bounds access in read_block_state()
Date: Fri,  4 Sep 2026 14:49:52 -0400
Message-ID: <20260904184952.1353914-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904184952.1353914-1-sashal@kernel.org>
References: <2026090354-barricade-goatskin-e135@gregkh>
 <20260904184952.1353914-1-sashal@kernel.org>
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
index ac5965ee64b2c..8a3670dbfa1ab 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -882,7 +882,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	char *kbuf;
 	ssize_t index, written = 0;
 	struct zram *zram = file->private_data;
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long nr_pages;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
@@ -895,6 +895,8 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 		return -EINVAL;
 	}
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+
 	for (index = *ppos; index < nr_pages; index++) {
 		int copied;
 		struct timespec64 ts;
-- 
2.53.0

