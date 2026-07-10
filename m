Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDEE2D7DCF
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 05:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783661303; cv=none; b=F6rFP+bDOz9efhI7aQkQfC3hOJz8qRz0Rom02asTvmLRnQft+2zo6E1/+ep16KeopJUPav2nFhAds6ZVKkCpfJH29L5sUY0uZMIRl075UQwDb15zsK379XLIRQchuljh1cXUvqB2lsdyMsEWU0zGh3/nh3jeJGjllZ9v2PcVrxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783661303; c=relaxed/simple;
	bh=I6qmZKmYgOCDd23juh8E1V8ly31ICCecziDj6Ab2yfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sK/jWrSGy7Awxq+DLTf8Zj0PTG7TyQNCAdqGGMBT+zfZ29pkz9ZmsXEj1W6G/cdZS6MKiJCSFFQ9XuVLUgqSCenGrPkDB52rArZCMultsBzZRCRRULYthSlpuI+iMxa1HlAtJ6B6xTbJBwfLOVr298j/hX5IoVaFG1YMKMLdQEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=VYOQvi9O; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="VYOQvi9O"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8487b7b4066so138314b3a.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 22:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1783661298; x=1784266098; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mtgNPfiuPP2PxEYv19OKovNjnDZbOavqTWC7kRVkwjA=;
        b=VYOQvi9ORuhZUOM50E2rhusfmvI9IH/+CbWZ7mfqyoZiwXu3DydnAQYE1NsJb237ck
         7SQ52aB4FSgZjM4h3+S8WnPFBrmkNtnxhz41BomM7htlf7zTS5qQGTDHZSd3sTPTLLS9
         zvjzlqp24u+R5Ah4nuNfzvmeei0K9NqiWqYhZe+9uUQsEgfVnvwdiZqIPQSZ9XkbqVvr
         av5RXxir9YvMnR8M0tKcT4IPkiWuUTPwdvVtUAVWj4Uo2y0WhKQxxC0RaHvRA+DKSjx+
         tFoFGy55mKGZsQ+bSmSsyyGJuwsuhOZhGOOUvbZY0hYECUiAOtcENxNhvkkFuVHgOBvF
         iSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783661298; x=1784266098;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mtgNPfiuPP2PxEYv19OKovNjnDZbOavqTWC7kRVkwjA=;
        b=LofWXogltYgzwjOXNg+cfevWUQ3yjh5H30zA1jXLz9LWCYK943Ao1Qk8y+YUbl32no
         Afiz1+8Gl9mg+V3AP4cRwHFvIs5mKv9Ug7MAwGGzK7CZC9IrevGk/kt+aHJTZeUgRvjT
         R122GcaA6XZwJ4RnjQ0WW5o9A4FQ+lcvLzLq36nnRZqhvcNgd1y6PXGhu7XtE37Z0pG5
         KY9HGP+chC6XiFQv6JMgDV7Y3zfwHflS6PyVR8gnpdjCBs+6CVAOFacLLZ4lX1BWFoFr
         M2RRV4I6NFBW4f3WxkCMJk2C7wWDaDzc9W11RmYyeK+wL41CctZTYA6pbbmXLjtQ40rT
         eXbw==
X-Forwarded-Encrypted: i=1; AHgh+RplH5s3uzoBT6hzu0et6zq2/6P+PFxuwEuMrHRMFF8lKJEg9plhUDWugnrUQMydwtmHOQEDRjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsfVsXsH9b6vSRs6sUx5OLnLCckJqjVBIvvWi0KsmIwiwXTaU
	vUzhasMInPFnl4suF40MeFiYYKtnK1f2KENAiQ69hDXvGH08hYh5H8XiUkq8WvM3oXM=
X-Gm-Gg: AfdE7cm0pF8CHBLfGqFPvTakWC8lgKY3oMe/d8hYWB4bR8Z8HwvVPQfbJHjcS41oaSB
	Nb/i5ipQYTjNErDt4w8ySn2c5PXeiO8tn/Vd+dOnPoZRBrniy0DBpwdTwnOIlYBxXde0Rn2TRav
	m/FT8CVNDGpibJ16jV8b8Pwi5+wXwR/3ztQH87HqBXiqqHuUDoAdoAo3Zz4H2YsuZvlSZDBABuk
	TQIvgEPZC1HVCFimA4KJtTQlsbeZxhnYPJXxClF1FU3+DBP+QlrSvMWoC9ZJpPPMOeZClkSlTyY
	zOxtC3b4/QxhfD0Jh5xuxogDGVp8wXlW/h9gIUp/qoIHjp3G7qrRIhFCZPZrkRM7S8JR99pFLQg
	aeu3xM2v0D/hHabH9yu7JugnCElX59ryIwsqKBoNiL5mdbI605MD2I/sBrrCQ5oJWfr93m8KFSd
	0N9V+u494w3W4zUgO7kO3HRftGAwoUIZc0mn+RdqqyvTq+h3/3q2mXPzGAET48eWJzOU1BVH+Zu
	wIbzJa5UCn0wKlaJWEwcNsugoR4KPrU5ifi1SlyQrM=
X-Received: by 2002:a05:6a21:7a9c:b0:3bf:9c93:ac44 with SMTP id adf61e73a8af0-3c0bcfea4bcmr12603274637.19.1783661298383;
        Thu, 09 Jul 2026 22:28:18 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm62526530c88.14.2026.07.09.22.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 22:28:17 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: s.shravan@intel.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] platform/x86: int1092: Fix potential memory leak in sar_probe()
Date: Fri, 10 Jul 2026 10:58:03 +0530
Message-ID: <20260710052806.100107-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Link to v1: https://patchwork.kernel.org/project/platform-driver-x86/patch/20260707070524.953741-1-nihaal@cse.iitm.ac.in/

 .../platform/x86/intel/int1092/intel_sar.c    | 30 +++++--------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/platform/x86/intel/int1092/intel_sar.c
index 849f7b415c1e..f234e1f55aec 100644
--- a/drivers/platform/x86/intel/int1092/intel_sar.c
+++ b/drivers/platform/x86/intel/int1092/intel_sar.c
@@ -91,8 +91,8 @@ static acpi_status parse_package(struct wwan_sar_context *context, union acpi_ob
 	    item->package.count <= data->total_dev_mode)
 		return AE_ERROR;
 
-	data->device_mode_info = kmalloc_objs(struct wwan_device_mode_info,
-					      data->total_dev_mode);
+	data->device_mode_info = devm_kmalloc_array(&context->sar_device->dev,
+			data->total_dev_mode, sizeof(*data->device_mode_info), GFP_KERNEL);
 	if (!data->device_mode_info)
 		return AE_ERROR;
 
@@ -253,7 +253,7 @@ static int sar_probe(struct platform_device *device)
 	if (!handle)
 		return -ENODEV;
 
-	context = kzalloc_obj(*context);
+	context = devm_kzalloc(&device->dev, sizeof(*context), GFP_KERNEL);
 	if (!context)
 		return -ENOMEM;
 
@@ -264,7 +264,7 @@ static int sar_probe(struct platform_device *device)
 	result = guid_parse(SAR_DSM_UUID, &context->guid);
 	if (result) {
 		dev_err(&device->dev, "SAR UUID parse error: %d\n", result);
-		goto r_free;
+		return result;
 	}
 
 	for (reg = 0; reg < MAX_REGULATORY; reg++)
@@ -272,43 +272,29 @@ static int sar_probe(struct platform_device *device)
 
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

