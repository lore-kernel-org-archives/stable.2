Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C1F374183
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940566; cv=none; b=C6a+V1zjo1pwc29bcwUZLp/E+7UaYOaKGfJlBdl5RG581+/DHmhxCC6jnsxXFbUyxj2IVzbhrrYqgohXMVy+gpFh2sDyo1TdWEJkLTeO9F9l2pkiHOY7oBepw+pH5Y7GM9hvB+03lloxQJqnk8pyynja73zdwDHyqCGkGmZfzpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940566; c=relaxed/simple;
	bh=XdMxzd8iDKQr5PS2zIsnUUypJpLDZzPkZaQ7qmg2evU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aLkra6zBd9Fbs/xA7ashdm/IJjac6hFFjssPRVrd25dgilxyPQnCCRRv620iYJwBq/tTB9Z4+63N+0KmiELPOub0kmeolp67tnL2jVb6mnirIWf3klagBiyBjfNG4T26HU/zn9SHhcPhzspTiuGnWdzI1nP7LQ21fWJMod9FfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=Vv6Mp1Qt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="Vv6Mp1Qt"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so2579632a12.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1783940563; x=1784545363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FFFSD3/CjVLS0ezRz/CdhSHYIzRiivgohq9ZOTv9sGc=;
        b=Vv6Mp1QtQSZ0TwbktUQjHmCzOuOnyqIkcvYujltX5uarPgxHuEvLrfQUW0Lwnbg7oK
         4Zn2kucqQaHe0LyQyy5kZ+OFNBcQMV2IO3cVFV4jjXIJ/jF3jVTWrirkNNaVXUTr472R
         MKPhAU7bkTfXX9WgFREkhBsGzrE+Q+j2cdnbItXAtYKFcOWeR24F8mVFkMOP3jCBwsIt
         cRE5Tp+XMCp0+w9Bq5pAUODODLuCWlrzONPwC3GRE1kgNwkzf+JeUz20gio5q65Zc24a
         nFOHMgG1nkk5ly88hw0dDanZsMTOvlFGQiscoy7OWFhvsBd+kb3Td4XX3uKUZQRM6BPA
         LZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783940563; x=1784545363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FFFSD3/CjVLS0ezRz/CdhSHYIzRiivgohq9ZOTv9sGc=;
        b=QMMigQRA/YLAUu6r+eV1Oq6a04bIaC/2HqR/nsF/FaxxYn19QN7Ysvj85C/5vBXtEH
         3KNzmOjSS1nwcIyxHZepStCfI1ph7s9WTkAMriPxnAThOvNxkx/maaoY4C4/Mn3QtRVO
         dxla3n9Mtc2/r2G5e4nzN8bQGV7MzpyMADlAL7s5rEn+tvhzMHfDu3Maf1so1a3HtJPj
         GKba5HohID4jzm8joclSuk68BH20kLyghLcdfmyRwq4HdijIRiI2Nkbr5ODMWf0KVs/o
         uIltceo94EBlGKlX21ZxZjLmRJxPcpGrYyvk5PGg7xNHlVt81zh0SJMLkyS+SjFncfDy
         yV0w==
X-Forwarded-Encrypted: i=1; AHgh+Ro0Mb+6a1ldHZMsiFzdT+/Rh4WRSleuDJpW512lbhz7HZt6/P/yFwuyo+ryD/BWX9NaZ3LpSPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAq+S1YOqnt7epIS+sN5R/Bax4h8aVQitixyiLPwekMpkwJYZB
	h/o9BnoC49oYU+TlIeWz7H5tCd8A9pkK35YYpK8uLR/x9D7cXR5zZ4/EbhS3+0Hxutg=
X-Gm-Gg: AfdE7ckxp1msl5cujks8g8/G8BXM9Ri1oPnW6MqMB67JjkBbb0PJ/tzMoS735DVTfAw
	agmucNPng7OtZRd0RQKLDzPKwTnOMaadQUCQSJdmVAvqvT5AT4fzMHbOYWK0B7cXsloul3OOlTg
	3ljsC/hgSgGJAPwZL/GtdRPs16Y2jLuDnn2+jtWzC6hMkQs4ax9S9+xmPPgzyoBuf3hVSHgj5Lm
	xVuCh+vuvCY3wv4DNl7IYUpXpSpkjTrVnABsj8BTN8678Mfcwdwa0ezgf9im6hPCtkULbGXKxvN
	kOCK+nLq2aWhJbfzuZbvLKZD1vyulnkxk+N/E/MdvGQkD8YTMUW07dhvrlqnGRx7wB0Pl9BVJzK
	QKsimRmkKgDXecFavO39vwftwfRwakf3jdYv39QFRlby3J6HcXTVaw6yep87BYDzWFyt5f9HSLT
	94uuRZhPqe78c1cAUSQJ0DTi9ZqdgKx7VrebRaGPURfuG2nxdxfvqdrHJmquv+T3m7zNRK+g1/G
	kfDWpqYJB/gh7YE+u5AWfim/griCv2JtTM=
X-Received: by 2002:a05:6a20:b7a7:b0:3c0:9c1b:d0b2 with SMTP id adf61e73a8af0-3c1108c2c0amr8860918637.61.1783940563499;
        Mon, 13 Jul 2026 04:02:43 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm52249087eec.22.2026.07.13.04.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 04:02:43 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Mon, 13 Jul 2026 16:32:24 +0530
Subject: [PATCH 1/2] platform/x86: int1092: Fix potential memory leak in
 sar_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260713-platx86-v1-1-c8991bff03a0@cse.iitm.ac.in>
References: <20260713-platx86-v1-0-c8991bff03a0@cse.iitm.ac.in>
In-Reply-To: <20260713-platx86-v1-0-c8991bff03a0@cse.iitm.ac.in>
To: Shravan Sudhakar <s.shravan@intel.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Abdun Nihaal <nihaal@cse.iitm.ac.in>
X-Mailer: b4 0.13.0

The memory allocated for device_mode_info in parse_package() called by
sar_get_data() is not freed in some of the error paths in sar_probe().
Fix that by converting to use device managed allocations.

Fixes: dcfbd31ef4bc ("platform/x86: BIOS SAR driver for Intel M.2 Modem")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

v1->v2:
- Changed the patch to instead use device managed allocations for both
  the device_mode_info and the context structure, as suggested by Ilpo
  Järvinen.
v2->v3:
- Align the arguments to the opening paranthesis as suggested by Ilpo
  Järvinen.

Link to v1: https://patchwork.kernel.org/project/platform-driver-x86/patch/20260707070524.953741-1-nihaal@cse.iitm.ac.in/
Link to v2: https://patchwork.kernel.org/project/platform-driver-x86/patch/20260710052806.100107-1-nihaal@cse.iitm.ac.in/
---
 drivers/platform/x86/intel/int1092/intel_sar.c | 32 ++++++++------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/platform/x86/intel/int1092/intel_sar.c
index 849f7b415c1e..7263114f0b3d 100644
--- a/drivers/platform/x86/intel/int1092/intel_sar.c
+++ b/drivers/platform/x86/intel/int1092/intel_sar.c
@@ -91,8 +91,10 @@ static acpi_status parse_package(struct wwan_sar_context *context, union acpi_ob
 	    item->package.count <= data->total_dev_mode)
 		return AE_ERROR;
 
-	data->device_mode_info = kmalloc_objs(struct wwan_device_mode_info,
-					      data->total_dev_mode);
+	data->device_mode_info = devm_kmalloc_array(&context->sar_device->dev,
+						    data->total_dev_mode,
+						    sizeof(*data->device_mode_info),
+						    GFP_KERNEL);
 	if (!data->device_mode_info)
 		return AE_ERROR;
 
@@ -253,7 +255,7 @@ static int sar_probe(struct platform_device *device)
 	if (!handle)
 		return -ENODEV;
 
-	context = kzalloc_obj(*context);
+	context = devm_kzalloc(&device->dev, sizeof(*context), GFP_KERNEL);
 	if (!context)
 		return -ENOMEM;
 
@@ -264,7 +266,7 @@ static int sar_probe(struct platform_device *device)
 	result = guid_parse(SAR_DSM_UUID, &context->guid);
 	if (result) {
 		dev_err(&device->dev, "SAR UUID parse error: %d\n", result);
-		goto r_free;
+		return result;
 	}
 
 	for (reg = 0; reg < MAX_REGULATORY; reg++)
@@ -272,43 +274,29 @@ static int sar_probe(struct platform_device *device)
 
 	if (sar_get_device_mode(device) != AE_OK) {
 		dev_err(&device->dev, "Failed to get device mode\n");
-		result = -EIO;
-		goto r_free;
+		return -EIO;
 	}
 
 	result = sysfs_create_group(&device->dev.kobj, &intcsar_group);
 	if (result) {
 		dev_err(&device->dev, "sysfs creation failed\n");
-		goto r_free;
+		return result;
 	}
 
 	if (acpi_install_notify_handler(ACPI_HANDLE(&device->dev), ACPI_DEVICE_NOTIFY,
 					sar_notify, (void *)device) != AE_OK) {
 		dev_err(&device->dev, "Failed acpi_install_notify_handler\n");
-		result = -EIO;
-		goto r_sys;
+		sysfs_remove_group(&device->dev.kobj, &intcsar_group);
+		return -EIO;
 	}
 	return 0;
-
-r_sys:
-	sysfs_remove_group(&device->dev.kobj, &intcsar_group);
-r_free:
-	kfree(context);
-	return result;
 }
 
 static void sar_remove(struct platform_device *device)
 {
-	struct wwan_sar_context *context = dev_get_drvdata(&device->dev);
-	int reg;
-
 	acpi_remove_notify_handler(ACPI_HANDLE(&device->dev),
 				   ACPI_DEVICE_NOTIFY, sar_notify);
 	sysfs_remove_group(&device->dev.kobj, &intcsar_group);
-	for (reg = 0; reg < MAX_REGULATORY; reg++)
-		kfree(context->config_data[reg].device_mode_info);
-
-	kfree(context);
 }
 
 static struct platform_driver sar_driver = {

-- 
2.43.0

