Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7831A40DFD5;
	Tue,  4 Aug 2026 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826801; cv=none; b=SUdadyJPgP25vknmVLpM/IVpamZWJiHQebDf0G5L8NyJDBU6uINObXvifiNuo+uBaLPd7nV3LoYNcQaS8n+yMEj7YLKSa+dIBW9Ksj7qD6KRn8StGNYB02CatdiHwcY0sQa3+5JpoMyAjryNT3gLfsEM7ysmpl4i10aE1Xk3mJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826801; c=relaxed/simple;
	bh=ir1QM2G3+r6Hc4AbWgtVJ7sj5gAESnFCcrK0ZjIMNo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLLdAJHYDQWcCkXB8yhkzzHFpZtWRvpMYmklpI1uhnPkl2zQGuI+KQwrPciH/UOcQiVl1BpEvNoOhHGGd+dc9P41ChfI3qB5U5HzWz4B0wHfWulGjHgsKXFGmeNDbOZ3K4PNlXDuWMdcnXGGrfP/zeuDylDywdK7Bk6sIYQ48N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AuD9RKUz; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AuD9RKUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Mq
	yM0XSCVl95o6QAASoxa/Hb1m9rTLKwdgnnVqqg558=; b=AuD9RKUzvgs6QBjSHN
	yCdd0nW5wj5ToCENSbgTr1knWO4D6YRVMsx71ys1MBGZB3uL8Gf/vaYJIHrfgjbv
	Bw80MKriv1nGavQ/7QTb5yLGXXZ2ZAV3XRlkWqmOQqmOyNgTWADDW7rrKpw56gav
	+GYE9Ac6KYCK9jWh11KO1lW60=
Received: from XLL-9950X.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAnD2LOjXFqfGujNQ--.47278S4;
	Tue, 04 Aug 2026 14:59:27 +0800 (CST)
From: Longlong Xia <xialonglong2025@163.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Longlong Xia <xialonglong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] zram: fix out-of-bounds access in read_block_state()
Date: Tue,  4 Aug 2026 14:59:19 +0800
Message-ID: <20260804065919.3970386-3-xialonglong2025@163.com>
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
X-CM-TRANSID:_____wAnD2LOjXFqfGujNQ--.47278S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1DKF43tr48Zw13ZFyDtrb_yoW8Xw17pF
	WUtw1Ykr4DGF18Zr1fJ392gr15Cw1DCayjqrW7Zw1Y93s5GF9Fv345tFWDXFy2qr48AFZF
	vFZ0yrZ5AF1UurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jg8n5UUUUU=
X-CM-SenderInfo: x0ldz0pqjo00rjsqjki6rwjhhfrp/xtbC3BCOh2pxjdArAwAA3r

From: Longlong Xia <xialonglong@kylinos.cn>

read_block_state() calculates nr_pages before taking dev_lock. If the
device is reset and reinitialized with a smaller disksize before lock
acquisition, nr_pages still describes the old table. The subsequent
loop can then call slot_lock() past the end of the newly allocated
table.

Read disksize after acquiring dev_lock and checking that the device is
initialized. The read lock then keeps the table and its bound stable for
the duration of the scan.

Fixes: c0265342bff4 ("zram: introduce zram memory tracking")
Cc: <stable@vger.kernel.org>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
---
 drivers/block/zram/zram_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 02fd64475a9a..e5f42f56220d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1552,7 +1552,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	char *kbuf;
 	ssize_t index, written = 0;
 	struct zram *zram = file->private_data;
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long nr_pages;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
@@ -1564,6 +1564,8 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 		return -EINVAL;
 	}
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+
 	for (index = *ppos; index < nr_pages; index++) {
 		int copied;
 
-- 
2.43.0

