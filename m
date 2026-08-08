Received: from sg-2-4.ptr.blmpb.com (sg-2-4.ptr.blmpb.com [71.18.227.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862213264FB
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786223095; cv=none; b=P2xz+fZdV1IEfoTfOLUxjvCs5jXeQASQU9QhvrvP96Z/ytUY4/Z3FFGsCmp2wms9YkVgOcX0pxUGSqdFS1c+5UQvRH77P3JpnmOnXAqmpmc7X7KFmAfVghDI2mb2EUCqAHYzrtXaMLbDHoNjxpn8LVxaE9hpl+xQzTVjn0EweK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786223095; c=relaxed/simple;
	bh=AC5SWAywDMaP1Sb8Nj099atu8XPp7ozet8L5ciyWmRI=;
	h=Message-Id:Mime-Version:Content-Type:Subject:From:Date:To:Cc; b=PnRgF3Ow59RAkeQ6lVuPsmYLKfk6LCO/WZJ27WYLxWaPqmATtPg985qv006NFdt84PcokKnwj4+dncpM/tyn+/s5VGoVT+gjGIS3OS3JfUa/7wyk25LP9whLnNHwIjeKzAWI9WIHsbYpzykyPnzlIbH0Ahx85UhRK7061BsDs9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=e6JRJue5; arc=none smtp.client-ip=71.18.227.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="e6JRJue5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1786223086; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=tMpGP1Jm3Y5J/q4bmaMh7uf40na3FpkySfAXRsQUnrk=;
 b=e6JRJue5ez08pwUE3BTI3KA7T9jdlU/xGgf9s9VOj6YXUnwfC4LWYQPTQA/fl6VjKi13UW
 fXOpJFRqXNroy77WzfVDhuoDg/e2VCt2Ag0vljmpDr6YwNZDQgVSXx85RRq5WjIwGAAqpS
 jWnHwEO9xmt70+R4CSPWTNAItS8cuhPS8doAvPAsPMJbNX4X5Ga0xI+FdGS4kdX37GXe1F
 bAsc/EmaOw5MhR0vUtEnXG/tVF2MolnWLroXKErpEg/9VUqJp5ZsErl2d2OrXcEnTpfdOT
 FEZQlVdVRMl94xlabv24x+y4HdURv1D07reGi6KDGkygBa/93loveTxmsKWhGw==
Message-Id: <20260809-fxls8962af-fifo-v2-1-80ff1be1f1f2@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH RESEND v2] iio: accel: fxls8962af: clamp FIFO sample count
X-Original-From: Shengzhuo Wei <me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Date: Sun, 09 Aug 2026 05:04:41 +0800
X-Mailer: b4 0.14.2
X-Lms-Return-Path: <lba+26a7799ed+78b744+vger.kernel.org+me@cherr.cc>
To: "Jonathan Cameron" <jic23@kernel.org>, 
	"David Lechner" <dlechner@baylibre.com>, 
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
	"Andy Shevchenko" <andy@kernel.org>, "Sean Nyekjaer" <sean@geanix.com>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Jonathan Cameron" <jic23@kernel.org>, <stable@vger.kernel.org>, 
	"Joshua Crofts" <joshua.crofts1@gmail.com>, 
	"Shengzhuo Wei" <me@cherr.cc>
Received: from [192.168.9.107] ([111.42.148.195]) by smtp.feishu.cn with ESMTPS; Sun, 09 Aug 2026 05:04:44 +0800
Content-Transfer-Encoding: 7bit

fxls8962af_fifo_flush() copies the number of samples the device reports
in its FIFO status register into an on-stack buffer

	u16 buffer[FXLS8962AF_FIFO_LENGTH * 3];

which is sized for at most FXLS8962AF_FIFO_LENGTH (32) samples. The
sample count is read from the BUF_STATUS register and only masked to its
6 valid bits (0..63), with no clamp to the buffer size. The watermark
path caps the count on the write side (fxls8962af_set_watermark) but
the read path does not, so a malfunctioning or malicious device
reporting BUF_CNT > 32 overflows the buffer.

Clamp count to FXLS8962AF_FIFO_LENGTH, mirroring the watermark clamp.

Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
Cc: stable@vger.kernel.org
Assisted-by: GLM:5.2
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
The transfer reads count * 6 bytes through regmap, so a device reporting
up to 63 samples writes up to 378 bytes into the 192-byte buffer,
clobbering the stack canary, saved registers and the return address.
This mirrors the bmc150 fix (ce0e1cae2609). A well-formed flush reports
at most FXLS8962AF_FIFO_LENGTH samples, so legitimate devices are
unaffected.
---
Changes in v2:
- Use min() instead of min_t() as suggested by Andy Shevchenko.
- Link to v1: https://lore.kernel.org/r/20260806-fxls8962af-fifo-v1-1-bd9d27047fee@cherr.cc
---
 drivers/iio/accel/fxls8962af-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index d0c2a8daef0db964134ad10b25782b9f5752613d..18d7b09bddd2b4f506c3348bf4e8cf94ce1c554a 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -969,6 +969,8 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
 	if (!count)
 		return 0;
 
+	count = min(count, FXLS8962AF_FIFO_LENGTH);
+
 	data->old_timestamp = data->timestamp;
 	data->timestamp = iio_get_time_ns(indio_dev);
 

---
base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
change-id: 20260806-fxls8962af-fifo-c3812fd02eeb

Best regards,
-- 
Shengzhuo Wei <me@cherr.cc>
