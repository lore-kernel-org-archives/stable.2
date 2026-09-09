Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D355335B3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965622; cv=none; b=WxLJ1xrWBqPFTbSWz4dF3DY2OSDR7plakEOsc8Th8l0M+4E0Eip+T48g+eQJj98rJ+Q/Pm2YenLsDU1cdXtOuCA9be6bYiiNnEvfZYFthToA/RGEQNbAmwdLbqTLbycy7TvHczeXFzDnbgO2Phkt8Yd4GmcGej7vluB7FYwfP1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965622; c=relaxed/simple;
	bh=7urVkxJ5yAVQCCgrqBnJch6kponWRL2EW8+0s8gm9HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+367Z7Zkq3QHsmYeZoli9sHFSqRr6iUXlEPMtQVz/X7299zYpz60NikPgGbf81T/9jdjQJwrVH+fkmhis5TkObFNMpdlQTd2jazwyReIE9hZ5UwDBLunYCLZyGd7XcVZhFHIWXUyzvoQiovceEYmMJCd+jO72VMN2Nf7cop1eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lm+8l/cE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lm+8l/cE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00591F00AC4;
	Wed,  9 Sep 2026 14:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965621;
	bh=AmHRTwQawwObpJaXrtV89IptD/6uUpwmoctMroyFrG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lm+8l/cE3fnRmidZBXE9LzFTpVpPMT4PsUabqI74Stis3IEsZq7mvVJIOmFyr3Kfz
	 kp/y4u6o9e7NWCaX12euyloIuUPDcyttk019AcOlK4VWLD8z4/hl5IIGqQn6Qt+oTt
	 EBj4lSDGiX3PVgyEuCq+uFSYGyKRfP+pdesfv81oxoNdBRGLURJuM6pH3kkyfOj9dE
	 TWq2gGavht2JwnZGAn1vfsoYIoK+W628MJazweQg+xJfvRgyOteZZWmHNCsjmqqkpm
	 N+pZ7pniNrfPwEuJ++JLRl2T+z5A+FG2Ou2kV/E1lYnMAHP02pnPxJqXdmzK+5qN7B
	 WTPZ07mgon/dQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] platform/x86: int1092: Fix potential memory leak in sar_probe()
Date: Wed,  9 Sep 2026 10:53:38 -0400
Message-ID: <20260909145338.2698768-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909145338.2698768-1-sashal@kernel.org>
References: <2026090357-daylong-strangle-f0da@gregkh>
 <20260909145338.2698768-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Abdun Nihaal <nihaal@cse.iitm.ac.in>

[ Upstream commit 30c906cff490c3601ee9ff110fe8115fabe75fd4 ]

The memory allocated for device_mode_info in parse_package() called by
sar_get_data() is not freed in some of the error paths in sar_probe().
Fix that by converting to use device managed allocations.

Fixes: dcfbd31ef4bc ("platform/x86: BIOS SAR driver for Intel M.2 Modem")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Link: https://patch.msgid.link/20260723-platx86-v4-1-93b4a178b595@cse.iitm.ac.in
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../platform/x86/intel/int1092/intel_sar.c    | 32 ++++++-------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/platform/x86/intel/int1092/intel_sar.c
index af4c127d33f4d..1cfb268f6b71f 100644
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
2.53.0

