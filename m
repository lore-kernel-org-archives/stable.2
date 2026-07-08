Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F42609C5
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 13:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515946; cv=none; b=CSWuMMKuZDhgfIU12JN2bvCItLayBQxtrReMSXXijfyIyVa1CXtQarrA9dSle6nk9dj4lH94VaAl8Ak1ez4NUC/ckamglJqb60MgSt954eqYCg9YvSSBoQuY1lWipwTxhe8lCkWhMOjRlps0++fqsCVY5cjmHtBJFfQWSa9RN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515946; c=relaxed/simple;
	bh=Myyijv87T89uidt4IlT3B+u6WDZawELqMmMmm2VS+Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epucVDXiF8IbVe+N18Y99pCYySl5XG/jO/qrvr+uf57hsdVa2o0Un9fpy/k8ECjugz7e5y2eOx/fXmvV5OsKI4MXtnsNInYOI7AfEdmAcnKzbHSGpQhF4/MeCSTzVFKiRydVlz6qP7X7fTNUgc7abaahWsCmG0sr9wSRpelwGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyRgVdR3; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyRgVdR3"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c89636920a3so301197a12.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 06:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783515943; x=1784120743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oiV9BZ6JtLWxJM5aFV2ir0HHpN4TWqB4aWSQOFRnO6Q=;
        b=gyRgVdR3lzU4E4TSYPhCrjJxiHHgMW0R8wRU2jTSq7Q5EvyVN+8hFEEZX4T5a7xHTy
         9F2+P1eRa1NbYSpVoMvn1LH7nVHVNctdaHMWxiLt5wM2XZWh6i4UCei6+JuQ5cPkWaoE
         V9IBbb+1MFgmmbiMeM8ONYOceYrRaHjSzGtROcNr0QXxjC5ytrRnARjMp2gJaFqdehUT
         jnhyG1jeWyMpCuoQ5lTIdxD1qFJQBZ7cQh90tkzeyUAJ8lseZI5XhiPEFE/0qfa6a2tD
         vw5fJxnKLUSoryQTGIeF5auA0DeWoOB29+m+XzvzUUKCo/QXw0ye4M5rPTzk3NTEJSfL
         GUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783515943; x=1784120743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oiV9BZ6JtLWxJM5aFV2ir0HHpN4TWqB4aWSQOFRnO6Q=;
        b=PWaaysWP5CHJMdDr45QGsNow+imozGZ7x5AeleBb1a3gFwmJqq1WjRRgMBXfd1LR/B
         tLaf9qaYutVz+Xmit4RS7neTn7b+QPbuBGYuyWQLQTWL+whkVG0KkjBSqJ3UzjX0JNvi
         HPPMbAWQUTpPILlDSjc1JiPDWJSYyL8iRmlQZFDHa0gGntwcueGMWVk49W9zXCBmgN9m
         zCoT5awzHLIDzB48NqRCF5NTLnxmIdke9MovgifRbsOYXXFDuwxspvTOqFBvsZPes1BY
         aVakQY3ynLNQVQqrWiz0fVANh1aZBuYkgUHJa2X4bjcT8EbwSZy9lFkRkAC7CDHOVNC3
         zd+w==
X-Forwarded-Encrypted: i=1; AHgh+RpPslhXRMgYqOMizfHKIA+RvGcKNM0zFDb38FikQMbtg2ES14XV/OYaVUW7Fau6kuYhOURDP8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxNolFjYT2ARPYCxQVkK493TA6AZ/B/32C2O+T1/o8yr4u8Jbf
	+MTdjBalsYvLRWbOYyIKCt5ooyip3JuVBpzrGiAI/cql8nCgj1w9Wso1
X-Gm-Gg: AfdE7cmyGOLsWs6WNkzuuOMhZITTffn48Y9fhe9lStM4U6pZHkabftZ+wQI1PyXVsZ/
	QO+IGIwbd1cujMV6u1F3hUj+DQt+iDCokKLGLS45O4H79Ir6gJFy8We/YD21Ec/5EZIKpgy9HDJ
	mZYTgS8mIOQ/8ffknwz2zmQw5gMqx3jiUOTBFyO4D5PICPkcfm+cEVIZ+tSwFjdm/wDau8oPAzr
	5Sq5aSEnkco3gEb5EXdBeZufNHGLKTsK79zjrF+iLymQ6EHtkcvvCjLGSUtGECf1Q1hsEnHCmsh
	JK214q9NAzYcueLR1pbmUWvdhK3Wg6SpOQHlKEb107sJ5LMk2HcOycth3EfaHpgCZhk9sISA/xu
	D88VikTgu1p3FMy1G9VQi8ZAosIEM59FP8EdJwAqetx1tHs2YyUqqe8G3Qtn8VlcuYYzlIru8b4
	SxQZez81cB8Ek/4TM8LZZGfoI5nXg1x8GQ4A/Mu5HKO8E=
X-Received: by 2002:a05:6a20:a11d:b0:3bf:735d:7fb7 with SMTP id adf61e73a8af0-3c0bc8ab2bfmr3335231637.13.1783515943372;
        Wed, 08 Jul 2026 06:05:43 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31189cd8234sm9748365eec.9.2026.07.08.06.05.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 06:05:42 -0700 (PDT)
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
Subject: [PATCH v3] media: i2c: ov02a10: fix endpoint parsing use-after-free
Date: Wed,  8 Jul 2026 18:35:33 +0530
Message-ID: <20260708130534.29329-2-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260613112920.64617-1-birenpandya@gmail.com>
References: <20260613112920.64617-1-birenpandya@gmail.com>
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
 v3: moved property reads before parse to avoid UAF; fixed error leak by dropping assignment to ret; added Fixes/Cc stable; picked up Reviewed-by.
---
 drivers/media/i2c/ov02a10.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/media/i2c/ov02a10.c b/drivers/media/i2c/ov02a10.c
index 143dcfe104456..0150e4d296af6 100644
--- a/drivers/media/i2c/ov02a10.c
+++ b/drivers/media/i2c/ov02a10.c
@@ -820,18 +820,16 @@ static int ov02a10_check_hwcfg(struct device *dev, struct ov02a10 *ov02a10)
 	if (!ep)
 		return -ENXIO;
 
+	/* Optional indication of MIPI clock voltage unit */
+	if (!fwnode_property_read_u32(ep, "ovti,mipi-clock-voltage",
+				      &clk_volt))
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

