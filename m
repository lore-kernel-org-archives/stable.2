Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9969348C5A
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693342; cv=none; b=nNvuirDfqZNBLk9lQ5jBCRRrtB3YjMf15rWkKbZsBJ32TuZZaXT7+/v3+Zz7b+G+jiUDPqpoXUDXMR4Q+n8yZ1G403TFIt68VIypWhYnO8hifeVLl0iA7bWaXwd7S1kBe7BuWwNxXJtUJJf5wMxgaPPFRsIsTKPwW2pNfJbHPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693342; c=relaxed/simple;
	bh=6hgT5DK0oOq5/Wsou8lo8FKxq+iZjqEUc+JvtN+p1Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M26jSFHrNNb15Km+mN3v1OkRuTERqpTroAs/FXGiVMgRCglWomYc1pdZu8Jzb3ullzkDY9cw7XxCYsQs0WP1+L2ujHRYPSH83wDi1/qV1dSrrCt2eorqwbhkA5Ovu2+sIXwJLxb9daWYgTn0MOiHykTXdSAuKpaHGIMmL8jLqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koa+HvEO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koa+HvEO"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cad8076b01so11346615ad.2
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 07:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783693340; x=1784298140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FoLPitrFKeUob810vvgoU4umxRfKuy0C/dr9NicwKbA=;
        b=koa+HvEO7lg9XcgkLN2/bl9mT5SeCgfUW5Wm50PElj0/sM7MUMXn80hRtUaLko99WZ
         mfZQtFGnh7XSERhoNftFrOx6u56h+Z2o1ct913mI2bVIv4TR5XFrqNimv+xCteqnhrd8
         TyqqJlgx3VVyYclVUidRgrsAt7KoXkwSVrxtUBaTEYIMitTaRz2OUs0kxPJWFfvFQkzK
         aHmsZPcWOga8y03UvuAvRS1uRg7T3hTAWMzOlFmCntmMEZnNFZT7QAxP+MMxZsBk1Xaw
         POwfKz2AWsJc8l9lKN5lL2MXrfvPm2RpriW1JcVmSuTdxHkm8a494oaUQJMhOf6Am93s
         ePlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783693340; x=1784298140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FoLPitrFKeUob810vvgoU4umxRfKuy0C/dr9NicwKbA=;
        b=nKSpPzYbSZbe2NuWcZzehneCC0RBwDI8emWio7HgPlNOzF0VoJ2sSGzyLS1k4zyl7j
         K5y1Rv7YJIdK/mXOK+5IySNLgZTAtG1SX/+Ne4t5qzGjdZbfFIG4pvGNp58d2c+//tjB
         7yp9RqYF6vsnkVZH91xfFuuzrpq9//09pfMCey6WUftRgKTxLXqr3Wd+06M5ZyKZmwzj
         dU4uZ+733qK6Q7KoKMqOs/M0l6B9zkn6UVuqA7WYUu2AhqrhdLcvkefecm2ggt3to8M6
         BHCy8n7yTL7lwT8Z/+pSnBJvYhfX/GeVYNKXJs+2yR2H5d3zou3pwyXHiU8MaFUDPkwR
         qzcg==
X-Forwarded-Encrypted: i=1; AHgh+RrE3MfyKJTd2VSat2txzsyW7yDxlpQXb7IdzNwYQDP0mL9/ArxyKKPMge+I7TDfWYAh71tRQfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLKdAD6xxBkUJamaaJI5iYaW9vRUaPRyHIKyxQOelUTPPuLOm
	vrZ4alxIOh3kGfb2w4Wa/cqUsL2N24TffBV/AKyxzg2vnszgF2C8sT61
X-Gm-Gg: AfdE7cl42EHbauOrm56qbpeqaiDN9Vqbgd92JY1pEDwE0VjE84hyLpQhQ+lCIbs3CsR
	a3upjY5yy7zs+NqQBKKGgwwY4+VgdaLF9mUWZmb1V4uEiKe8pDprpjpkDhR3OV+CoIri8EguZjF
	HuxLZgPpELcyFE1zQqvgtE6HzK4k3ugpGHCWkdwSAeo0tsSzce0k1mVq+kPZc5tUu4bY83y+cBR
	ptQ25ydWIPfc6iL8geKGXv9UgdR5u2ZlJcsvGNDPoL/4Zt8j53WMXd2J+x7v8FHUdi+eWKXOh3v
	qOIp/FzDj8haseLI/owqDbZ+PAseOYv2UCgikihCO/agLJpBaHda2VqUX8SdLM9Ge4E7HhHaGnN
	Zg9P2E4jbHw3HwhQprhL4AUAOe1ojG3nDLCvitt4OwT11B8JaQZFRCh4psBroPBb3fDuqM9h7CA
	ENgISPWqsqw2LT9ydof/Qz4FcYd4JMesJsYchMCBtBK+1y/dAFI0ZN1ioMutNMyw==
X-Received: by 2002:a05:6a20:a124:b0:3bf:b089:c55e with SMTP id adf61e73a8af0-3c0bcc23bbfmr14504856637.52.1783693339957;
        Fri, 10 Jul 2026 07:22:19 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:5177:3103:5737:1752:bd47])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d7c8bsm45575083c88.12.2026.07.10.07.22.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 07:22:19 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] iio: proximity: hx9023s: validate firmware size
Date: Fri, 10 Jul 2026 20:07:12 +0545
Message-ID: <20260710142212.52225-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hx9023s_send_cfg() copies the firmware into a counted flexible array and
then reads fixed offsets from the copied data before walking register/value
pairs starting at FW_DATA_OFFSET. A truncated firmware image can therefore
make the driver read past the copied buffer during probe-time configuration
loading.

Reject firmware images that cannot contain the fixed header, reject images
too large for the u16 fw_size field, and validate that the advertised
register count fits in the remaining payload.

Move release_firmware() to the callback so the firmware object is released
on all hx9023s_send_cfg() error paths.

Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsing functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index a6ff7cbe9e6..a2f9c077e58 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -18,6 +18,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irqreturn.h>
+#include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -25,6 +26,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/units.h>
 
@@ -1031,8 +1033,12 @@ static int hx9023s_bin_load(struct hx9023s_data *data, struct hx9023s_bin *bin)
 
 static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data)
 {
-	struct hx9023s_bin *bin __free(kfree) =
-		kzalloc(fw->size + sizeof(*bin), GFP_KERNEL);
+	struct hx9023s_bin *bin __free(kfree) = NULL;
+
+	if (fw->size < FW_DATA_OFFSET || fw->size > U16_MAX)
+		return -EINVAL;
+
+	bin = kzalloc(sizeof(*bin) + fw->size, GFP_KERNEL);
 	if (!bin)
 		return -ENOMEM;
 
@@ -1041,7 +1047,8 @@ static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data
 	bin->fw_ver = bin->data[FW_VER_OFFSET];
 	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
 
-	release_firmware(fw);
+	if (bin->reg_count > (bin->fw_size - FW_DATA_OFFSET) / 2)
+		return -EINVAL;
 
 	return hx9023s_bin_load(data, bin);
 }
@@ -1058,6 +1065,7 @@ static void hx9023s_cfg_update(const struct firmware *fw, void *context)
 	}
 
 	ret = hx9023s_send_cfg(fw, data);
+	release_firmware(fw);
 	if (ret) {
 		dev_warn(dev, "Firmware update failed: %d\n", ret);
 		goto no_fw;

base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
-- 
2.51.2

