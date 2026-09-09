Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF221492E37
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973210; cv=none; b=t8x9JfdRWPovRGdHu9BeMElef0Xl1sh32Apro47Zp1eRXgyG3Nlik/1Nwr4fbVG0BHU56OMxZLAESKZ51SiR8K8B99XofFtsmi3Je64PtNff+QswaOaWQb/tYv2BkWgpUlWvXFS8JliyIbb6VUwORt+QIxmnwvSFKyQvANunsQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973210; c=relaxed/simple;
	bh=BoFEQmYq7vrvr8TZ0URTfXrqyytqe3uJC/hRsrB1wX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmxINM/3/3YJkW2IAFL09z3WEFnEt1HG3isZoHJCz9rYmE/nqJUeqvGEKx8hvkPOmyJK7/PfdEOrN59WIBQRPWrskVYjJLDUk8IT9qKTJ7RiNAoXT+mVN7vggIA9Zdim+kKUc7KON6YNilAwNPY4qlSzE6+XFaqo5Yrtrp2mk8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kelb4x0P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kelb4x0P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D0A1F00898;
	Wed,  9 Sep 2026 17:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973208;
	bh=LkeL1VUF8GCsJTfgx16g2NXzfnLxpDkdrEA5E/DMLEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kelb4x0P9NnGGh4oF1ciGekzzLraQPbdjXQH6Z+KX0XDZN68F5yXIQlqR6eqfSg5c
	 f4Z7i0CF3lWl6KtauKXxgREWW4KXYbvRcJ4l4ZucOv+JPP3IINYiDaeSiWGdXsGxOb
	 j84PVV8Xjphi1a4PoJ9IYf+3l0hC8I1gH/tmzDBJRG+gzy82zAazRZjunjEGheciw0
	 TcsHzIFUyPSJBWPj/TDjHwwY/OA9r/ih67bP4/bLZ2+b/7jBhqn6x0+ozqS8NJDZ9S
	 cocJFysm2QO6IDmpRCkjG2X/Dw5U4p6GTRw5fWNJh7OiTnqPwlsKKRvJUzuqeCalSr
	 CL1fSRBY+OSqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] platform/x86: int1092: Fix potential memory leak in sar_probe()
Date: Wed,  9 Sep 2026 13:00:05 -0400
Message-ID: <20260909170005.3157069-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909170005.3157069-1-sashal@kernel.org>
References: <2026090358-subprime-ruckus-2c80@gregkh>
 <20260909170005.3157069-1-sashal@kernel.org>
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
index 011b2deacce80..251d55ab89e62 100644
--- a/drivers/platform/x86/intel/int1092/intel_sar.c
+++ b/drivers/platform/x86/intel/int1092/intel_sar.c
@@ -96,8 +96,10 @@ static acpi_status parse_package(struct wwan_sar_context *context, union acpi_ob
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
 
@@ -259,7 +261,7 @@ static int sar_probe(struct platform_device *device)
 	if (!handle)
 		return -ENODEV;
 
-	context = kzalloc_obj(*context);
+	context = devm_kzalloc(&device->dev, sizeof(*context), GFP_KERNEL);
 	if (!context)
 		return -ENOMEM;
 
@@ -270,7 +272,7 @@ static int sar_probe(struct platform_device *device)
 	result = guid_parse(SAR_DSM_UUID, &context->guid);
 	if (result) {
 		dev_err(&device->dev, "SAR UUID parse error: %d\n", result);
-		goto r_free;
+		return result;
 	}
 
 	for (reg = 0; reg < MAX_REGULATORY; reg++)
@@ -278,43 +280,29 @@ static int sar_probe(struct platform_device *device)
 
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

