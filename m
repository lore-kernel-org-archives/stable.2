Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7421F30C14A
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250990; cv=none; b=Aza2gHWx06yy/aqfXZcDVI/3sfTgdRruRQEFxvs9pWmDG2KLsH9Ejv9cZqncrGMfrnLv9V1mi+PEfeTeqtW9i5+XAu3b4ZgDfuNKx8752+rJVCf/EoRw+YEZnGVlIuj9QCsp/cnh/J6X55swxm0YqMOfT/B4g9NOyJoOyrEqDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250990; c=relaxed/simple;
	bh=+Z8ZTpGEfHWM4q/zUbV7kqxbu5dhULZPNJ7diN0yJeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4BVp7Oc6p5LtPFaIdc9TxZzqjGykiS4ekm9ZNa84+jVpfynX3jN1pUcZ04YMOH/TonZYUu6yQZj8BifMsvRMgbQuIWbYn1imX/mtOMmTe6zfcee1uLq5SWIEbpshitLe4+G9x3FqKZlgCRIoJmVIc6PPR++FSWo9E6em5k00Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BINVxFsR; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BINVxFsR"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccda24afso1081208a91.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 04:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790250989; x=1790855789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6rBh57CQ8oC/XCjJGNJlSdgV/jpJp4/g95+Pgh7fgMA=;
        b=BINVxFsR7UzNJSt2OxM6kj3K5c/Bbn80SGQgLz5Bculzt8BEv1ozy2i39EZ4Aci7sI
         rqcbyd+wKl7GV8+3oZxyxgoRzYcvyKNaB9zYoODSrxI8x/kfW6UWtCuEoB/B0PCxocjG
         /18lhqey5AdE1CkIN9vsQ4GDeipPklgntAbGBe3zRC2NUbniCbyt1rzdY+0F2LpMRIvI
         p6ZMCMrNTPCeok2aQ4yOF7vSXAZufmCvjLyEZTVKYTVg1/CZxYbOVunKh2K1X8M1g1DO
         4i7oNBrJEwHSDsYUZWvKsewAVXvQRvJ+LmF15Py7Cly7ELneWtbeat7JVKSNdxqkK5+M
         zFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790250989; x=1790855789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6rBh57CQ8oC/XCjJGNJlSdgV/jpJp4/g95+Pgh7fgMA=;
        b=VjQLWhplIfPzb0w3j/2h/c20ORanRvSDuCAPVSnctyPxqu44wdz02zIDoCTFHO50Ay
         O5BdJcJBlGxE622BRFfaSzDsc/tunZJKrlRn+IwPvCNY6lL/SSEGvv02uFx+3FsorEQc
         ociOMc8NY27zRCGX/WLYdiadQMZyb8vfuYYXZp2nBcN5dPGzZS9ltN00oOApg+Bipo7O
         0AZX7fqLdcjAEvLgwl/iZ9Td0BDXKmYhQGsebCtVvkr0XXvSCErbyPdnmEvYljvrGQK1
         cZIbn0PPL1H5RqNAl3M/oxcqb3QalMXbrnnBeyD+00utCDTjYdWF9jVMEis32sGjnzt7
         woGw==
X-Forwarded-Encrypted: i=1; AKwUvByXkxcKDZGUw8uyHk4g2Cr02bfF8kWyRhVx11HxvrayHizaosWwChJd8jvwoagTz9a7W+bsDyY=@vger.kernel.org
X-Gm-Message-State: AFuF++kft++zu6Rn+diYhVXCrPGO2cre8GNJgyrOrsWrS7FnyT63xAeH
	OsZBoB/brmrCVYmfgwdb2bXRUKg+0Uy8W8uwAfU4n4XX+AYQeYHiN2MD
X-Gm-Gg: AYBFou23XunkPd+qOIYeaUXfNiCUPOyXGX9G+CVpcq8Li4KzhLDdVCn6CuosScOj+h2
	k0RmeYgoP/vmxDK+KR5PYlz7KZcVRMU782hQa0g+21RmvBpg4cw634lGPpjQweo9rpPZG1OCxtY
	Qkk96dW1a4/3w0EdoO5tMKTraeluPoZbA7JOWhuhi5O88b+pELhlK1OulHeninrjUBuJH5AOSgg
	Onu66QTTOiwl3+XRD4yAQbOOQ1xfMdqPcy9U7N2mEluI9xz4LvlM6oZ5zLu93JFkhapxs/kwM0Z
	vxsOXq7CbwuZBBDk6xzuU2IrS508zDRz9tWNID4WJ1AaytceGgsAt8IzGwIw9d55v4Smuh9GBg6
	S+hFOPStRe+NJnCJ097gQaW8/eyiKnQOzGXYM39oJbDYnS0K6ZATfef7gVna/B759kVlPxm948Y
	7s+e7WH48PSpcjb3PpiVjEhXGQ2fpHHpU4SV0jTBecEqOlFYqebFyPpw==
X-Received: by 2002:a17:90b:5807:b0:3a0:8050:2ec5 with SMTP id 98e67ed59e1d1-3a0985be2fcmr1751949a91.12.1790250984098;
        Thu, 24 Sep 2026 04:56:24 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a097663fd0sm4598745a91.9.2026.09.24.04.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 04:56:23 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Bao Cheng Su <baocheng.su@siemens.com>,
	Benedikt Niedermayr <benedikt.niedermayr@siemens.com>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Henning Schild <henning.schild@siemens.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] platform/x86: simatic-ipc: fix platform device leak on registration failure
Date: Thu, 24 Sep 2026 19:56:17 +0800
Message-ID: <20260924115617.1578309-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

register_platform_devices() registers the battery, LED, and watchdog
platform devices in sequence. If LED registration fails, the battery
device remains registered. If watchdog registration fails, the LED and
battery devices remain registered.

These failure paths leave successful platform_device_register_data()
calls without the matching platform_device_unregister() calls.

Add an unwind ladder to unregister previously registered platform
devices in reverse order before returning the registration error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: dd123e62bded ("platform/x86: simatic-ipc: add main driver for Siemens devices")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Use an unwind ladder to unregister previously registered platform
    devices in reverse order, as suggested by Dan Carpenter.

 drivers/platform/x86/siemens/simatic-ipc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/siemens/simatic-ipc.c b/drivers/platform/x86/siemens/simatic-ipc.c
index 7039874d8f11..4a4509fc9263 100644
--- a/drivers/platform/x86/siemens/simatic-ipc.c
+++ b/drivers/platform/x86/siemens/simatic-ipc.c
@@ -92,6 +92,7 @@ static int register_platform_devices(u32 station_id)
 	u8 wdtmode = SIMATIC_IPC_DEVICE_NONE;
 	u8 battmode = SIMATIC_IPC_DEVICE_NONE;
 	char *pdevname;
+	int ret;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(device_modes); i++) {
@@ -139,8 +140,10 @@ static int register_platform_devices(u32 station_id)
 				pdevname, PLATFORM_DEVID_NONE,
 				&platform_data,
 				sizeof(struct simatic_ipc_platform));
-		if (IS_ERR(ipc_led_platform_device))
-			return PTR_ERR(ipc_led_platform_device);
+		if (IS_ERR(ipc_led_platform_device)) {
+			ret = PTR_ERR(ipc_led_platform_device);
+			goto err_unregister_batt;
+		}
 
 		pr_debug("device=%s created\n",
 			 ipc_led_platform_device->name);
@@ -153,8 +156,10 @@ static int register_platform_devices(u32 station_id)
 				KBUILD_MODNAME "_wdt", PLATFORM_DEVID_NONE,
 				&platform_data,
 				sizeof(struct simatic_ipc_platform));
-		if (IS_ERR(ipc_wdt_platform_device))
-			return PTR_ERR(ipc_wdt_platform_device);
+		if (IS_ERR(ipc_wdt_platform_device)) {
+			ret = PTR_ERR(ipc_wdt_platform_device);
+			goto err_unregister_led;
+		}
 
 		pr_debug("device=%s created\n",
 			 ipc_wdt_platform_device->name);
@@ -169,6 +174,14 @@ static int register_platform_devices(u32 station_id)
 	}
 
 	return 0;
+
+err_unregister_led:
+	if (ledmode != SIMATIC_IPC_DEVICE_NONE)
+		platform_device_unregister(ipc_led_platform_device);
+err_unregister_batt:
+	if (battmode != SIMATIC_IPC_DEVICE_NONE)
+		platform_device_unregister(ipc_batt_platform_device);
+	return ret;
 }
 
 static void request_additional_modules(u32 station_id)
-- 
2.43.0

