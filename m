Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CE51E45A
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788547504; cv=none; b=tSo5yr+5JK8kYyeUuEFWG7py9pP4oF6P0J268fe74BwB5eu6rqswd5mHlzyJ9130PPG+LpzxhiJQTTvYBlxucMU9OBBSrCPBLB3oz1DdKb10dHDet1ygBo/FzovQCie4Xxzvysh45EPiKmnojRMEe99OEZiIoThMryTxhXaY95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788547504; c=relaxed/simple;
	bh=48AKiUMBx+CoNNrc8Pt4qIgzacSmMbysK35CY29ztoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BXpzE+J3kji1XEjdYSOwDwdNmaeAk3BAKH+GU9+R3DqCkWvMSnduKtb0scr1FFdWz828J9bAq3a1bzVmaa4ZTFDahiRbnrAs688HheUE4JPg8KylXO4WaD9ytNyG6ksTjoV4/dMHaG4uv6574v2F9q0F2IVT+aflnJvYwlm8GX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdfQdUQN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdfQdUQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1591F00A3F;
	Fri,  4 Sep 2026 18:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788547503;
	bh=mEHsYJOHSryjv1njVJgnA5+qKPs6zE+GmgJsiB6ZT+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IdfQdUQNLjpDcWLLdncETcUV2Igp6qYHo8LrZSvNdoQhlEcQ2CzwmRU3YUSaMmBLT
	 jdVIR4ctIJAJtycqLaRlmaWnfQRYvDpx6/Q86lNv7JOW4Qc5YDIfNZXcn50KkEkJQv
	 anN9CfwWwXqlI77kbfdluPxh/XWgm7J0XcCnI9Ftb7cH7I0JIMmtcl82kSF+zwD1x3
	 o1SotvUDA1V2+nzCid4Zl+UH8vbpbKTsPdPhsiRCWTrNYn2ibsWU7zFwZ64yb0DsKx
	 owzXZ2AZOIBli06ImcYt/KTdGmHr2qGgHOahPLuv4G281m7rNmcBr79gIVGfCUWI+f
	 zF2iCQNTeA/KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] zram: fix out-of-bounds access in read_block_state()
Date: Fri,  4 Sep 2026 14:44:59 -0400
Message-ID: <20260904184459.1345418-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904184459.1345418-1-sashal@kernel.org>
References: <2026090354-deafening-decorated-22e7@gregkh>
 <20260904184459.1345418-1-sashal@kernel.org>
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
index d1f4b61509a0c..5c44967b1c73f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -885,7 +885,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	char *kbuf;
 	ssize_t index, written = 0;
 	struct zram *zram = file->private_data;
-	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long nr_pages;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
@@ -898,6 +898,8 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 		return -EINVAL;
 	}
 
+	nr_pages = zram->disksize >> PAGE_SHIFT;
+
 	for (index = *ppos; index < nr_pages; index++) {
 		int copied;
 		struct timespec64 ts;
-- 
2.53.0

