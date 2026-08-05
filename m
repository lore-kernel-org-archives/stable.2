Received: from va-2-52.ptr.blmpb.com (va-2-52.ptr.blmpb.com [209.127.231.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A1B47F2F0
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964529; cv=none; b=c5jaeJhIzywy6q3WznLPJweMjd7J/t7xezwMN2mpElTjekUClAHKUUOTtBBekvKvHUDaOPG5L4PuZHPwXYjxzFMRXjqyV05av5TVkvkkaNIoojw8pz2kfwI6GcepPgdaCVZxi4+UyqUDcdckFY+TvtFXVVcu0o1BagkgpxTob8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964529; c=relaxed/simple;
	bh=rYfqoIFNwjvCC+6kagJIIOet3GAFYFzNfC6GCrz6IBQ=;
	h=Cc:Subject:Mime-Version:Content-Type:To:Message-Id:From:Date; b=Rpguxg0cD/GGdfIjp6HqdaB8xZ/EYfdk7GDZQk26yZ0eoQwcqxsRBPeY4/y4vo4k8vs+WBfjkMGT1hE6qaoUqIluCmysf0/UkEB0rKkKaBtWnZyoC1TMOL0jxMHpoLgfhiNs36wnLNSLIE0Qo/MChO08HWwTghuKugxC1S0I108=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=vyDVk+y1; arc=none smtp.client-ip=209.127.231.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="vyDVk+y1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1785964502; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=DOdeTHScjlg8KvRPtx1PQYGvpV3GwXW8tvnccpldDFc=;
 b=vyDVk+y1D1boASSO3/8EkkQMJuSdmz8r7iUnHR091TlCQ+T3lPzi/MeDehtE3TgmQsOAxO
 HFzS2fKKC3yK3wRddUCSEQrgIOChA3aSKEJCNGpxSoOdXbZP5BH4KOYP4vPCGNqB1Y++lG
 27VC2uUPCFm8upPH0XSB6lnzOfDGPY+/P7Qip9rpNeznxP7h3nF4tb8mnTbIggO3eBEvBX
 oJWHMbSv4hdlJ6ok5E5rsw9QB94BFGTucFauNmUgg0/ysKr2o6PuWK8oUyxehkiyS3pbbO
 j8YHoHqUljH8yeRWHz/wYc7MRB5omnABuEIug38wtdH0+4QbfOixjHuE/LgRog==
X-Change-Id: 20260806-fxls8962af-fifo-c3812fd02eeb
Content-Transfer-Encoding: 7bit
Received: from [192.168.9.107] ([111.40.58.194]) by smtp.feishu.cn with ESMTPS; Thu, 06 Aug 2026 05:15:00 +0800
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Jonathan Cameron" <jic23@kernel.org>, <stable@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH] iio: accel: fxls8962af: clamp FIFO sample count
X-Lms-Return-Path: <lba+26a73a7d4+d36c15+vger.kernel.org+me@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "Jonathan Cameron" <jic23@kernel.org>, 
	"David Lechner" <dlechner@baylibre.com>, 
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
	"Andy Shevchenko" <andy@kernel.org>, "Sean Nyekjaer" <sean@geanix.com>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Message-Id: <20260806-fxls8962af-fifo-v1-1-bd9d27047fee@cherr.cc>
X-Mailer: b4 0.14.2
X-B4-Tracking: v=1; b=H4sIAMync2oC/x3MQQqAIBBA0avIrBNsArGuEi3MZmogLBRCCO+et HyL/1/IlIQyTOqFRI9kuWJD3ykIh487admaAQ1a44zVXM7sRoueNQtfOgyuR94MEq3QqjsRS/m P81LrBzw2uzFhAAAA
From: "Shengzhuo Wei" <me@cherr.cc>
Date: Thu, 06 Aug 2026 05:14:53 +0800

fxls8962af_fifo_flush() copies the number of samples the device reports
in its FIFO status register into an on-stack buffer

	u16 buffer[FXLS8962AF_FIFO_LENGTH * 3];

which is sized for at most FXLS8962AF_FIFO_LENGTH (32) samples. The
sample count is read from the BUF_STATUS register and only masked to its
6 valid bits:

	count = reg & FXLS8962AF_BUF_STATUS_BUF_CNT;

so it can be 0..63, while the buffer holds 32. The only other limit,
the watermark, is applied on the write path (fxls8962af_set_watermark)
but not here on the read path. count samples are then transferred into
buffer[]:

	fxls8962af_fifo_transfer(data, buffer, count);

fxls8962af_fifo_transfer() reads count * 6 bytes through regmap, so a
malfunctioning, malicious or counterfeit accelerometer (or an attacker
tampering with the I2C/SPI bus) that reports up to 63 samples writes up
to 378 bytes into the 192-byte buffer: a stack out-of-bounds write of up
to 186 bytes that clobbers the stack canary, saved registers and the
return address.

Clamp count to FXLS8962AF_FIFO_LENGTH, the number of samples buffer[] is
sized for, before the transfer, mirroring the watermark clamp already
done in fxls8962af_set_watermark(). A well-formed flush reports at most
FXLS8962AF_FIFO_LENGTH samples, so legitimate devices are unaffected.

Fixes: 79e3a5bdd9ef ("iio: accel: fxls8962af: add hw buffered sampling")
Cc: stable@vger.kernel.org
Assisted-by: GLM:5.2
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
This series adds a single patch clamping the device-reported FIFO sample
count in fxls8962af_fifo_flush(), mirroring the bmc150 fix (ce0e1cae2609).
---
 drivers/iio/accel/fxls8962af-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index d0c2a8daef0db964134ad10b25782b9f5752613d..3aa96adf3eef8ff525e65ceec9a371da82216ea4 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -966,6 +966,7 @@ static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
 	}
 
 	count = reg & FXLS8962AF_BUF_STATUS_BUF_CNT;
+	count = min_t(u8, count, FXLS8962AF_FIFO_LENGTH);
 	if (!count)
 		return 0;
 

---
base-commit: 848acc8ffe1b7cd5f1bf427b93069becfebc2c9d
change-id: 20260806-fxls8962af-fifo-c3812fd02eeb

Best regards,
-- 
Shengzhuo Wei <me@cherr.cc>
