Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255404A33F1
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 12:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784810691; cv=none; b=i1w3ApF94G7ycJqsYVH0pwe17aUamctLIU2poLV0Ey1Sa7/MtF4HTbItOWtw0kmtztE77a/+Jm4EtOsWrfSla5hyUwppZoHFdULFuPzYkLqMtu3XyEfP63308pTJNOjb8pL/hGKeOuvY/IqEh7uk/StMLyuvQysmK8n+egD2vuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784810691; c=relaxed/simple;
	bh=PfHJYqAdNUNso9QIi/a1PoUrfQ4churnV2g+9V85fDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bo8xQjNG31FqBpHdl3LLA6hy8dvldKpry0HdOtqHIaAx6PQaW/qqitrJPIku077qYT43M3wUEvVfM+9gwj7M/xoxX/EvWHo5oTCRN6ITcQNec2oJfGG8X5autmFNrLE2vLbg9y+MXoALbxj00xAuUQXpq157hdL1POtGlhmfbZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=NZcD67tG; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="NZcD67tG"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so585336a91.0
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 05:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1784810687; x=1785415487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hiPXGv4jgjzWQcJFciSEaz+MHyjRNnFYQcUtVupcsGc=;
        b=NZcD67tG6Rx/0xeEYtDNRtHDUf73GhTBotoqwwKXKcJWLA+Br7KBLH24ftX0w32vmi
         l1QE7HKbvWuFOV8etmtsI6J7klcZYa+pvLAVKF589b43qUCQxS9BOb3SdkbbiSN1/4zW
         RhnO82ZjouOYFTzpm84giPSnlYf7DB/qzcc3TQsWAZEeK3UjjJDEVrPFJvtjLRyYLLAd
         B5qy3u2D4juQo9eHPWup+3G/bMnfjSzXC6zlGoK7HhyfiuBtFY528d1l0DPc9mENwzWZ
         36MDxTA1XaU1HHbUAIQW/8aNq8F4St+JzZMfm5sAxVzjwPexM+v1QbcZV6IGj+iRqe3+
         QUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784810687; x=1785415487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hiPXGv4jgjzWQcJFciSEaz+MHyjRNnFYQcUtVupcsGc=;
        b=kGYCdZErvXzukmu3JmGLJP/B+kcyb7gqOiVCbduN543Kcbx1PonT3T6cZgKR/BgM1Z
         8/xNaFm3tpdKIZ0cT+wvua14CS3GalroGe+/uYyTeromVINsdc/vGGr9XdT3ik3Uf09i
         SXEZP6hnkoDF/tY0wDscJGWrIe+68Oxg60H13MktB9pkA96MU9qqLcL7yD8gwJ3UdDj7
         KZEQdBvimtQitIPFG1hr/jtH1jquqQfzFrrfITCRG3lXMub1Fa4t87RY/iwFIQdsj9Jl
         tVYLDGasB0vBwFix4PiAIIPOat5DnPQZnNeMLnyaEy18GDtxX+c66C9go5iZqPTefsbs
         aehQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr+4S3rgtRwW8dkSWJhqNJUSvEjzHfcPkVJTdkVxqW3aow5TSV22sqXOdVpoW8h2i8NAT5EQ3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWM+maIpAceMP/XIK1pV5gMLiQEJXYCyh24ROVgCVoX5qhWOAj
	X9vNc0xyr5x5f1VEoRWPgQn0EpZit2PmMfXimDbQcWBT+MKnmNCDjm8vFwmVFicqiqQhB7lmxZr
	00CwtZtE=
X-Gm-Gg: AR+sD13yz+2AjxlCie6OXwCs3C+9JFxo5x1dqj9PkNb5Y2vjpPwVnzpu3pn3HlmaDQs
	+cflYvrT9KLmkLNqdYhoMVzxSFeJI0DNHlBT/9IWaPi49r6eaSJebD9XBfbkVeAl1NYkbkI/OAZ
	5RwsFKbA5ne9k/+HNDhRRrpD3DgVmsa9ufo5X1jWmk3tQWWGQCc36C7r0OVlk1DoVOr2Hmc7ltH
	xNbv4chybE/Hplf5RkfMa7cPRwJLSUh7Uj6Lmo4UezTnFsuW2lyeuhu3acpx68/TRKLR+7WaKhg
	G33Ue3jfMt+KAWPJ7MXB1MTZ9fHAjEcyD1jK3/eC+SNh6cnk5wcpU5C2Y2UiWeoS2Zvbs1JEJ2L
	fsLHA7npjwzk3b235bwSSsWqr3ZV/Di2N0MMtXSU5ow7jFVDDkFdHL62UjuRZauJ7d2uce4CRm+
	9UQObm61pkWVCaqHGDAN1vFt/9BUktWxLQkpWsUGMs59dNIPsvyNrQZd2NcqfPm5d8XB1V7u/jG
	TLswproE5uRSx6hKLmGvmJf
X-Received: by 2002:a17:90b:2b88:b0:38e:ab33:9551 with SMTP id 98e67ed59e1d1-38ec66604ddmr2925445a91.42.1784810686968;
        Thu, 23 Jul 2026 05:44:46 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-13d1300401fsm21663197c88.3.2026.07.23.05.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 05:44:46 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Thu, 23 Jul 2026 18:14:15 +0530
Subject: [PATCH v4 1/2] platform/x86: int1092: Fix potential memory leak in
 sar_probe()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260723-platx86-v4-1-93b4a178b595@cse.iitm.ac.in>
References: <20260723-platx86-v4-0-93b4a178b595@cse.iitm.ac.in>
In-Reply-To: <20260723-platx86-v4-0-93b4a178b595@cse.iitm.ac.in>
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
v3->v4:
- No change

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

