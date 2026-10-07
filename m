Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17492423780
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362531; cv=none; b=jv1f5qe+D7GIAC2A3mUksQ6rbDS59wg8uQeAtGHYwWBzyoahc8cPnL4cCP3rZIzNEgUFddVzqRdyYnsacUQ9bhG6sDX44RhMS9bksAjrjzntAVvp3cPJre7gUtzqVTHmdD9L2sOL2/eL7rC+WdBkEfwBcYE99U6sPk4cp0/9qEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362531; c=relaxed/simple;
	bh=nwstXmDioTnX2BujZyq0PGnZacFPgM2I9eTo4HRETMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5ElVOjfJzY2B6JHiiXV75OCi54XDVHbiNAI06KIvd3aFdY4g6jbV8JzXj3kE2AM31vIC3zJj7h5HHFk/F/Q8r3fXX4I2p4c/sIbFn5mn3E92mUqmRyj+UpOX5qiPWXaULPeRWaaAUJYrFVK4cFRMI2lYL9ucjX+KwQTCyblYkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/AV8+Ya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/AV8+Ya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EA91F0089B;
	Wed,  7 Oct 2026 08:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791362528;
	bh=TisuI44+ScKZ867y4KQ3IZCmoIIagB7Aw5EQoQNZ6zI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y/AV8+YaoZJ12As8QZ6xPI8Lu5KwH7ZMrAcT55Grw8fRqhhKRkw3HHIlu2aXQAV/x
	 nzvfysXAgFgHNnKzN4XbDAS0PLR4bl3B41eY8dbGQmwz6F1wMHLCHasOY+DlFuuYla
	 vAfGgH5CfXo4YpH+f0LJ7xjE4LZLsFbOY6rCaJjIEdIrbnmvIQoqE09EXhyWvDkDUy
	 AWXZAn2tnSu2veoErj1qvPkqZ4NG0Rf9Z/J9QlwxxDfMntKFC9eeuttaQCMj7VXjbQ
	 TP9bn0WYpDmNNGzNqVnfi5a3dUSlMB+gtepAaKqDqLHgxAJJeyPH3Z6YXblSOOEkzC
	 stxdBvXkSpRgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Marco Chen <marcochen.dev@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] iio: health: max30102: fix NULL dereference in interrupt handler
Date: Wed,  7 Oct 2026 04:41:58 -0400
Message-ID: <20261007083721.1749559-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261007083721.1749559-1-sashal@kernel.org>
References: <2026100618-wooing-curve-b2f5@gregkh>
 <20261007083721.1749559-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Chen <marcochen.dev@gmail.com>

[ Upstream commit f0ea4824deebf21dacfbe397c4b0a5fd3e745a8d ]

The interrupt is requested in max30102_probe() and stays enabled
for the lifetime of the device, but indio_dev->active_scan_mask is only
valid while a buffer is enabled. When an interrupt arrives while no
buffer is enabled, the handler dereferences the NULL active_scan_mask:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  Call trace:
   __bitmap_weight+0x64/0x98 (P)
   max30102_interrupt_handler+0x48/0x160 [max30102]

Call max30102_fifo_count() at the top of the handler and return early
unless it reports a FIFO sample is ready. Because FIFO_RDY is the only
interrupt source enabled in max30102_chip_init(), an invocation of
max30102_interrupt_handler() without the FIFO_RDY interrupt status bit
set carries no data to read and can return before touching
active_scan_mask. A negative return from max30102_fifo_count()
indicates a failed interrupt status read and is treated the same way.

Fixes: 90579b69e94b ("iio: health: max30102: Add MAX30105 support")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Marco Chen <marcochen.dev@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/health/max30102.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 43c16fcdeae19..9419cc62a2a4d 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -292,9 +292,15 @@ static irqreturn_t max30102_interrupt_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct max30102_data *data = iio_priv(indio_dev);
-	unsigned int measurements = bitmap_weight(indio_dev->active_scan_mask,
-						  iio_get_masklength(indio_dev));
-	int ret, cnt = 0;
+	unsigned int measurements;
+	int ret, cnt;
+
+	cnt = max30102_fifo_count(data);
+	if (cnt <= 0)
+		return IRQ_HANDLED;
+
+	measurements = bitmap_weight(indio_dev->active_scan_mask,
+				     iio_get_masklength(indio_dev));
 
 	mutex_lock(&data->lock);
 
-- 
2.53.0

