Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEAD434405
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 18:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534380; cv=none; b=A6ORfxqW9D2hnEabyqWXyUr6AiLGgY5/YLlLEGPXLd4TT4EyHY4QM8eGUkiMQCMy4J6fZd13bM3sksLnx970z2/6FZCxN2zP7sbhuI56gsHnNyMoHaHvbnb+hihkkygLusYdk8ssxJKm5bKiD6Ztf1qF+r2zvDDbJ/69BevgYjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534380; c=relaxed/simple;
	bh=y1Zkb/qQ7tH76c5nw0yWw9pfRRFL5z9KF7XJjkvkH3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2fzq97WiLPfBuxnphAvHRreRjby/SrYRbpGkeWa6xq6em1UkiZ5Q6HiyNgp0q887BPX+MLPWKUTBTF9Ziy45KHwOL64OnPS9mL1VM5lXZn1F+7AnaI6N2qm+Lhby0bKvl+2DLVZKbElnExOLPYLusOy/AOvuWJEsmt46DwT2+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mq0EXNbU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq0EXNbU"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c96bfabc8d4so607794a12.3
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783534376; x=1784139176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E7M+3gHwLkUuZk+ZzB1+zc6TOfv5YYqtskQPl4nbwro=;
        b=Mq0EXNbUIosTjJuWW4QPPcinw+8f1KwIFogYqknNG1BHNHRcHc4AI0cM74ZNGnVw0X
         /sJT2yWSOK6vpAeZqYf1sVtckf8nKm7FYE+0P/mE3uplWFMRB5QmZT4jBujOp/h8t65L
         ssR+6QUak/UhAm4sfKaRmjhcO1NlQTbx+isi7E9otGXGdrQKnNFMeANe4+e07K4rsXHG
         3lVOvz3ovx6Quy6TIsSBOKMG0XevjQ8sHSlQ8ol6GOlx+xe0a3BoPx1naTg0mWRTbCHc
         nzD80MmUvSbnsIIgfSYX35Z4XwIe190dDpLmOTdY0rCz1g6tyNwGpL2JmJOJr4XLKtbZ
         yVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783534376; x=1784139176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E7M+3gHwLkUuZk+ZzB1+zc6TOfv5YYqtskQPl4nbwro=;
        b=tVD3uGnAlXfTZHSIztq/yYI4KNAaZofn40tduQxh3M4xy2aF4PvcTPxVjSpPR4tC+V
         EjiXa/PheW5MsjU0TUpBlT3gCvreClvb3z5+2kqDkjEkTCCIQDJiP9hliTXoa8uHd43l
         oBrA8+bXkcf5hGDUTNwWqFerFWukvsmmK31ilyN92UJ8yQCTq7ctc2QyQYmdjbHLtmsN
         tXZtyRvZVa5+3DuqYUeasTRjX5z3/0qcnNhoUJEL+soNoOsXvMC1xv2gjTa5yq0TbtCh
         VCqOtua5K0anZUWbC8Pk6bKmw0e8KyoNjbE3DnIuf4X72+b6uqMqEWJkr+SEpFmUthpz
         Dsig==
X-Forwarded-Encrypted: i=1; AHgh+RrpFp3ci8tWyaIDiE4NcZVUNV0thEfPFnvgv8pPWnvn4kxLxFlGSuwR2KXWwuGvn3LQPxc6jbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygxMYRc2j23Jgf3VeGnf0f1//Utu1PT5ldNGYeoCKro1luFwgT
	gXxoVQpQ49OYCkrG1joikXNArOkGgssKsLudj71Gj9EO6JkznxYqG3mV
X-Gm-Gg: AfdE7cnREiWYjBsQHSTBlFKxxagm5GKIY9ZVb82JxWWd1bqroNLDFbw0uIDHl/hm9Oj
	P20hFzkGQO0zclUn8c228ycQOudg4inFLTqzQzX0wUnvEpKP9PjL+Sd8hOS06oXUu6imzaihwGi
	MuTpCOzC13iBhzfRTvROHIJ1bc+gl/fcqgIxiPqaJWvU0Zw1YCPEbhg+QCCly2TUE8clcEpmbjE
	0MbgIvNuQIE+KstJeycZR/u2g3TZs/VbOAhC95+x778RwNv6YGrVlBS9RPi8T9pQfHqEAlNdCVh
	6Yt1i2Y5NCa1zAcotoJg+1jiLprOKGzer/Jvs9HJtYcYiimr90HtVUgskk0j0qj2JJXErNuMJei
	ZtJN6wFvp0+c+nMXjaT5ysrWRgdaSgrN8KzDwzAhmZVdrxgPQti+X7zoL6qxOkSU2BLI11ty3Lh
	+0pJo5v9WtJ+VyQRvlqXLxOcP1vThx7tdEyvAdZL46Nh3VlqnpbYA6Kg==
X-Received: by 2002:a05:6a21:7d02:b0:3c0:9c1a:894e with SMTP id adf61e73a8af0-3c0bd312f81mr3943968637.70.1783534376489;
        Wed, 08 Jul 2026 11:12:56 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659c8572sm22368639c88.9.2026.07.08.11.12.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 11:12:56 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	andriy.shevchenko@linux.intel.com,
	dongchun.zhu@mediatek.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>,
	stable@vger.kernel.org,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH v4] media: i2c: ov02a10: fix endpoint parsing use-after-free
Date: Wed,  8 Jul 2026 23:42:48 +0530
Message-ID: <20260708181248.57758-2-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260613083235.57363-1-birenpandya@gmail.com>
References: <20260613083235.57363-1-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ov02a10_check_hwcfg() function calls fwnode_handle_put(ep)
immediately after allocating and parsing the endpoint. However, it
subsequently calls fwnode_property_read_u32() using the same 'ep'
handle, leading to a potential use-after-free.

Additionally, reading the optional 'ovti,mipi-clock-voltage' property
used to overwrite the 'ret' variable. If the property was missing,
'ret' would become negative, and this failure code would be incorrectly
returned at the end of the function, causing probe to fail entirely.

Fix the use-after-free by moving fwnode_property_read_u32() before
the endpoint is parsed and freed. Avoid the error leak by not
assigning the result of fwnode_property_read_u32() to 'ret'.

Fixes: 91807efbe8ec ("media: i2c: add OV02A10 image sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
---
Changes in v4:
- Collapsed fwnode_property_read_u32() into a single line per Vladimir's review.

Changes in v3:
- Moved property reads before parse to avoid UAF.
- Fixed error leak by dropping assignment to ret.
- Added Fixes/Cc stable.
- Picked up Reviewed-by.
---
 drivers/media/i2c/ov02a10.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/media/i2c/ov02a10.c b/drivers/media/i2c/ov02a10.c
index 143dcfe104456..98f8fc5b6a5ae 100644
--- a/drivers/media/i2c/ov02a10.c
+++ b/drivers/media/i2c/ov02a10.c
@@ -820,18 +820,15 @@ static int ov02a10_check_hwcfg(struct device *dev, struct ov02a10 *ov02a10)
 	if (!ep)
 		return -ENXIO;
 
+	/* Optional indication of MIPI clock voltage unit */
+	if (!fwnode_property_read_u32(ep, "ovti,mipi-clock-voltage", &clk_volt))
+		ov02a10->mipi_clock_voltage = clk_volt;
+
 	ret = v4l2_fwnode_endpoint_alloc_parse(ep, &bus_cfg);
 	fwnode_handle_put(ep);
 	if (ret)
 		return ret;
 
-	/* Optional indication of MIPI clock voltage unit */
-	ret = fwnode_property_read_u32(ep, "ovti,mipi-clock-voltage",
-				       &clk_volt);
-
-	if (!ret)
-		ov02a10->mipi_clock_voltage = clk_volt;
-
 	for (i = 0; i < ARRAY_SIZE(link_freq_menu_items); i++) {
 		for (j = 0; j < bus_cfg.nr_of_link_frequencies; j++) {
 			if (link_freq_menu_items[i] ==
-- 
2.50.1 (Apple Git-155)

