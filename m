Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDA3439332
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 15:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525106; cv=none; b=LZeF8yxQD6RtbCv9rqOL9nRM0H7kobTjhxhzQf1jf+4B2ZCD403ns9khl9WpgphtiCIF1sx/GqdeLCLrP/6LFiJZ2FJeubKqnT7LZP6KwosXOMfFEn7D5wnIC0jmMfKda5mxJOEwCE3pMHqgaE8P7lzee9LTeOxQmrrgsj0zEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525106; c=relaxed/simple;
	bh=y1Zkb/qQ7tH76c5nw0yWw9pfRRFL5z9KF7XJjkvkH3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVw+oBIlmgLAurlAFomBianrQWt48mXy+h06ON60JgPecOSfpduv8OATPBTR7yLK3WWDEzawjr9kbjM/MqvamfZ+BmwT4der9OPLg0JtrTrRbCUi3yUK5nMZnSGBfNbe7rdzz7fGK4GBefkjiYnpfWJBaYmwYui9AxX6BTwkDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKRw+KqK; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKRw+KqK"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so9715825ad.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 08:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783525105; x=1784129905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E7M+3gHwLkUuZk+ZzB1+zc6TOfv5YYqtskQPl4nbwro=;
        b=LKRw+KqKrPUGMl3c149vOZRWpZbsXbk4Ycm4mUuHMgaiBk8qaoFjnbbj3eqR6TELcU
         iIJ3yWUSvw0TOofMr90DyGK8Sso30iLH4raoksC6+VgPjsb6QYDTXTfRVa+zYGgGxw7E
         BHV+Z83vvly+BOLX/Xq+fOpONF429m0X6zgRzFGgKqM4AuRJd2nUTiutiUwdy+ULSJIj
         PAA52xbIVk4CA5O9B5RHK4gO8LhIyt3aM2u4IwsiM5JdT2NsFyvDhEFzDAEAZr6rd595
         rd4QcC+7xguCaHseLu5AwcD75qN4/SWIUk0iOV+Q1qAdsOhmMJMQ4h66A0sg/kKJxzzL
         N2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525105; x=1784129905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E7M+3gHwLkUuZk+ZzB1+zc6TOfv5YYqtskQPl4nbwro=;
        b=GgT0GZn76fEbtAc3oDiJH3szCxtE19XGrtywqUs2rynbXyalMj3qkXB5WVVvlXxwqE
         GWcW0OGR23RQ69fr2Ou0Gd5CWcE/BPLeQVXbZ4yC7FGDWpspN7c6cqflyodFboruF6mm
         embSOtuV1noBbYub4cL/0CFzZX7CbsYZyBjwTHSRwfG3XRjxfZhja33MB5L9MdjMuCXA
         T+LX7S1Nwfz8OvgdueccFhgPLDpZa31+1mRRpALGPezQfqnxTzaxHRWUhlk8yCRiy8i0
         I+un+9OW6XQfv1fn/PmYXiupRF2Fmnze2LeH0HPfukjr0PtZe0HbHjhHN87DExGvjfA/
         vn3A==
X-Forwarded-Encrypted: i=1; AHgh+RqAxNmVbZj57F0j1V26k7kYc/21mqtJ0KLEuUipLtujhDYKQl4vCCwG7fnSW3JshUZsZjWROUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJnvsWM/i0aYVg0jtl1HItB+TrU+uSGQdSZAo54+JporBvcsp
	fS3VFuVbcfraet3ReojtTddDC2debUIfwDtow+6zZUdKtyWp+oGcUaF+
X-Gm-Gg: AfdE7cm8GNcYzQt+fhFuPy3ffj/iumK3WfWQV9m493zoFMmsRPQJv2LodE0z0qZ/IxT
	PQKDX1esKvrt3JWD1JB9/pLLeGBv7lTEspCZ/j31prOnZRun++NXaccR1SEhlIHki4AAA5i45ZV
	7NhNwR4F43Ge0KK0HQVKi3dJ06F8RmINz+40yC5fCSGb8aLy+gsAboWBkFvYuDxGr4vkpoXgaMO
	IbhvxUPdPDeZz5kePTQ9u/ZOQ9wMpFHNUEKyFBS5nTPz18jZSYNw5drlztzt3zVTQE3fYTgwhy1
	Q5lgVIrz94BcK3aB54CpIIUDpWtEqCfXFXFt/eMzZ1WuElI3ToqTGFKL4lYcF70epvel5OHc8Tv
	/kuB/Pq0X82R6+7VLg2dM7OTtz2kMq+ZkbFNO4AzXgWGU9mZqShZ3F/CeiDzN4nQAKhl9WcPq9Z
	kKMTG8nPIiU1b3xz8VAj1NMmvZ7RljRDXg0WJw2MvD3r0=
X-Received: by 2002:a05:6a20:c998:b0:3bf:bdb9:f602 with SMTP id adf61e73a8af0-3c0bcc6a270mr3505171637.22.1783525104357;
        Wed, 08 Jul 2026 08:38:24 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm24462238eec.19.2026.07.08.08.38.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 08:38:23 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	dongchun.zhu@mediatek.com,
	andriy.shevchenko@linux.intel.com,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>,
	stable@vger.kernel.org,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH v4] media: i2c: ov02a10: fix endpoint parsing use-after-free
Date: Wed,  8 Jul 2026 21:08:15 +0530
Message-ID: <20260708153815.50692-2-birenpandya@gmail.com>
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

