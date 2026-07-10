Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C272D2397
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697348; cv=none; b=uyQXRu3l/3MqOgdE4hZogggSzWHUOut5v5WUi2uOd9F93hlUBXVw5FvULfVuUxLkmaWhtU0YaFTMQN9ObnwX3KmmHl6EM0n/umYRg5crWH6iwCwnMzNQt7/S+SHx/EugZair7aPOLzrP0+xHFDzItRuM8xhaJg1Cn4FBScJ0sv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697348; c=relaxed/simple;
	bh=uFocWuHJZaaxUq8QuNDSYP+avYhxDHj9PK9MXWFU37Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bODBYdbn9PD1nS2uKL29PYkCIq0FNcYCn4HAcRbgqsvFaX+D4+rWFq+AhCoqa+4t0DTwaokqsKI/FqIqGhUU1x5Nhbu6IWj4m1dEXUv2BQ3D5HZTNevNZ3/mXQ4k7uEl/1gUivCLmILDYleAw2hVUfbxI3nOhc+z4L62MlmXiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwy1WbGm; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwy1WbGm"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so772229a12.2
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 08:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783697347; x=1784302147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VcTUFizWMfGK+B+3eVdsqm8eakFk3+4ykgzWhDZ97KU=;
        b=mwy1WbGm8h977O3elQpFs4A3GdNipEHUGbJft6hFhGOP5e8WSBmInLtGSmSJzaAt3f
         ntrWwd9NMpPckV6XW0PbYsfjnPtYgfvllvsGcW7XyD4IqcD3ySYCz6O46xTfZpp9M67E
         yzSoIDeyxRuLNKf1dzZcHnHcQBpMspgQJ/ST5GQkIwq9n7wHLGNeNFxO2Mopolpy3J1X
         W5bX/R4cS2rC9Gumm1mSZqHa36fyIFGw/RWqGpCxvvTsjzjlfKO4iy3Gk336ajGNGqT7
         mCmY/RmQG6EtaQuDQFzuA2ahwQbsVqA589GWeYWycjxmroCF+0hz6UKG69zE55rojOs4
         y7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783697347; x=1784302147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VcTUFizWMfGK+B+3eVdsqm8eakFk3+4ykgzWhDZ97KU=;
        b=DWHaeOm3cFlZfcs+qIBz1o/2+w9DJSxXSkaOk3lE5HI7S34diiILaAYEgsyQ5EpLoS
         wuUyuGZ1M7fSX7mOK0q8ACPWFZuHfUvejd44f0Rk3f2pTFoeyWe+XNsVyU2vOAnLBTKY
         7zcmxkC56kztdBvBwDX6eu7lWsBCn8O3W5c4Ovkr7xwh5teMa5KIkYUrIY+ejNvIAPX3
         lZG+a60OjPHq2K37eKNNXe6jFUdESBPMo1VXncDEqYtBYmeshuJ/JYJTWaWMZNVfPacC
         gveeh8PnfuRsKVMYqeODhdxWeMpO7rBBFciPRTrM8Smf/pvEeUuV9r3ratzjoRRWqM68
         fu6Q==
X-Forwarded-Encrypted: i=1; AHgh+RqE2TOpqultRvo+ZCVM1YQEJbeMHCoI7nnSg5LVRTIwKA5cVpcT7wKpjNgb+wl5K9Bitya2g/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41j0HEKK9gNGSy40tWcAoFlT53AJfgKBOGYv+ekvUL1v0kQAc
	UA1IblVTyS116/1aHzEyeycL2I8+61Tk8K2WraLxoRQC3GlFPV8MS2i2
X-Gm-Gg: AfdE7cmIc7eTBTrAWUr/K9MvVIgr47EyVj8eBbKGO0pko/7ZoCPTgOifpjAaPss+UYO
	WbpgzrFAJZZt2PfzeE/Gvye41lnKM3qPBglRjPhmX/8MYu3DMm9lNMDITin6NHvQvkpE2U2GDIa
	W9+awbkpUt65eKBJK60D/r7yY6AV4ZxEeeCqDlKaAMewtfBB9HDj9cHrANCv2ZyCKHSnnpstWFb
	WqnTKt3zuO/jmV6DGVfGrDA2maHpoK3EoCW6hVo4XnA8YWv0toYxI/9HwZ6Y6pkgB5Ht/LD5vq3
	BDDVeFAHtnh7ODD2RZh44N+IMTntbsRIpcwjIJI9ZBRCyeuQlST1cSoCCM6t8sttxr6E8Nq724W
	ZtDJhnLcZTeWF4NhASmddAqjbe/Dfbc9JXdIrJTo/zajjSen26osOIsAxvKcS0HhxLuhVytdRyE
	+swcqy8GrYvPcYVIgmGwkF95xbSJsuYrmxJpScEFc0QuYQisXoHrfMCBcToQYQ
X-Received: by 2002:a05:6a21:6817:b0:3b4:888f:b3f7 with SMTP id adf61e73a8af0-3c0bcbc1d5fmr13963413637.42.1783697346693;
        Fri, 10 Jul 2026 08:29:06 -0700 (PDT)
Received: from localhost.localdomain ([103.190.41.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c865asm45300287c88.11.2026.07.10.08.28.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 08:29:05 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: proximity: hx9023s: validate firmware size
Date: Fri, 10 Jul 2026 21:13:42 +0545
Message-ID: <20260710152842.53659-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260710142212.52225-1-acharyalaxman8848@gmail.com>
References: <20260710142212.52225-1-acharyalaxman8848@gmail.com>
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

Fixes: e9ed97be4fcc ("iio: proximity: hx9023s: Added firmware file parsing functionality")
Cc: stable@vger.kernel.org
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index a6ff7cbe9e6..9d91ce681ac 100644
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
@@ -1031,8 +1032,11 @@ static int hx9023s_bin_load(struct hx9023s_data *data, struct hx9023s_bin *bin)
 
 static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data)
 {
+	if (fw->size < FW_DATA_OFFSET || fw->size > U16_MAX)
+		return -EINVAL;
+
 	struct hx9023s_bin *bin __free(kfree) =
-		kzalloc(fw->size + sizeof(*bin), GFP_KERNEL);
+		kzalloc(sizeof(*bin) + fw->size, GFP_KERNEL);
 	if (!bin)
 		return -ENOMEM;
 
@@ -1041,7 +1045,8 @@ static int hx9023s_send_cfg(const struct firmware *fw, struct hx9023s_data *data
 	bin->fw_ver = bin->data[FW_VER_OFFSET];
 	bin->reg_count = get_unaligned_le16(bin->data + FW_REG_CNT_OFFSET);
 
-	release_firmware(fw);
+	if (bin->reg_count > (bin->fw_size - FW_DATA_OFFSET) / 2)
+		return -EINVAL;
 
 	return hx9023s_bin_load(data, bin);
 }
@@ -1058,6 +1063,7 @@ static void hx9023s_cfg_update(const struct firmware *fw, void *context)
 	}
 
 	ret = hx9023s_send_cfg(fw, data);
+	release_firmware(fw);
 	if (ret) {
 		dev_warn(dev, "Firmware update failed: %d\n", ret);
 		goto no_fw;
-- 
2.51.2

