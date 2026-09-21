Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414F53B4404
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977205; cv=none; b=rOSSkLJ6Avcln1zXcMDkxzNQOcXJ9p7pY0N+eWBnXukE7BetRGb+RyoQsNRi6Inb0VIjGFqLQquQ8/QnOaMKovTpU4+PA40q+pdjArMJV3V4SWZ0uV4pOq2ALLPQ+ZkCZKDT9F8GIxU3gRs6BwM/86vU5RlOur7PqBUdhYO03sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977205; c=relaxed/simple;
	bh=9jVvDTNMlifeWHalrehEJ9MSMBp7ROdLwpLKuSgTo60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QiVXul73U4Z/nYBs82lDJOv72dI0D7rvMdn32jCpnnWgwLPBGTNgsfAs+wepQ4+x9zfb47ydyxlzp55NXYhF61OKpdCe6wa7GDYRbriwtDaulhzySkkXmkLMMmzb2KTnKCacm0Kz910cydoN7DR85ooCAaDDXBVXhWrztbjOchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adPkZDyu; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adPkZDyu"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb751so2195252a91.2
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789977203; x=1790582003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XL6pKrFrkkzHRuFW00rA0h4XTY4p2ooSEMR1SrVlXM0=;
        b=adPkZDyuQBkAi9YeL/0AzuuADoZeEjtZUdrZwEoGF7xvzd0XyNwW2QJFX+ELYhEAzC
         nqRUrRzFXjfmVGZYLobkL+5gqJ2zfhqzFLitlYPZIJlEMW00kS0JhFsOkVD6ZqSq+tO7
         imS3jCLqoMAxRC3KqUe2OWzpZfNOmUC4bK2TxugfmHx9h3iFeTkkM7Qm09WqNcOwX2jV
         Lh2rz0oqusL2jZ31VYeSuOOcgXG/mkrWdl6IanfcFi2Y6vsOleirwR16lXdxaQ34Y3KL
         3/RZEtmUclPxOjZYAOnaHtCn8zsHJfIg7GrxHc64aNULi5VZTbFQUQ1hxvmK90nYktlB
         Uo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789977203; x=1790582003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XL6pKrFrkkzHRuFW00rA0h4XTY4p2ooSEMR1SrVlXM0=;
        b=D7GO324C2JA3m5r9pfrUvys1wbiLgtA65La+mbvS3VMm3qOqdNstbj6nPx5hqq8fvE
         vWEC7mSIWt957UUyQjkQaTsBwjNQIlgn1s/OllUvQJLnj0Iqk0iqHri0cSc/CHzvND5r
         mkdAezVtUh8ISqOw/gHidu03hC2IgxH4RV+iIj4LjAnArux3ZLV60CUtFYBqX6ByC89g
         onSnukSnoYZrqlDehm3jGCt8fQFu8m4Oe21yHSssvD0mj7jLUKwRVR1gno9pz8zWVBAA
         S5aOnCNEaDoEyZN8+eskcs0C9appxGH+/ALjeb68QAHE8qecIPa/+xLUeknbSLheKIxG
         0xXA==
X-Forwarded-Encrypted: i=1; AKwUvByMyUx64BhIDSFSpz2dw81VS0hBsBztxbjWjPLbQOjNPc7tTvjQ/q0qiVd3DqTagTx76f0UJug=@vger.kernel.org
X-Gm-Message-State: AFuF++kv6ltoCM/D4dM05AED9lMc0uZZZc3Ff/rCeMnfHPzqPwOsp1Hf
	EGmK6u4w2Qy9g119KEGxng7afBgSFtwVFDcUIo+WJjW3Yfwma8SgO+SY
X-Gm-Gg: AYBFou06WMHKch1YmZz/+1IaP2e0cHUh/XEFjqSVR35xfEUiwQqLrd2usMAUDvy/nep
	D5X95cR1fm8c8ip/cZRPopGePAzep4lpsagz9gLaSAXkqE+ENECLU3WZ4136+AK3PxJjvY2f/61
	b7NJhVm4aNk2vjTauYE2JrdgEpSFT7xk9bB9tiFNolDC4b8pvf+R6lZQQTI03f+2cwY4uCDz4fE
	GF1N/F2XZryp7VG2MCWWLIGr5NiyAOygvs4hvCeevV9sfNLDN/JBpNkE/CwfnpMeyWsFGW5bE66
	F3gCS/1nhS+Ft73+bB0ScY6B1LpPw7YoCibQFgxPGrKh4Ipk7c725CatDcFeCZvktkAz3T5stYd
	3NNnXNmm6kvTeHMgjRUwoa1YZfCCcEN6U9jvqBVSgWHKe6DYurcu1IbHzS0Iw6um8n/5GkW4m2l
	u3fpgdl3YEQPNwYhRvj8+qlh5KIcuOsPL0g+XAE2GeB7miz4ZuJ7shMw==
X-Received: by 2002:a17:90b:17c5:b0:39d:ecc8:73b1 with SMTP id 98e67ed59e1d1-39e54df9c06mr20858242a91.7.1789977203496;
        Mon, 21 Sep 2026 00:53:23 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6bd191aesm13132465a91.0.2026.09.21.00.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:53:23 -0700 (PDT)
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
Subject: [PATCH] platform/x86: simatic-ipc: fix platform device leak on registration failure
Date: Mon, 21 Sep 2026 15:53:12 +0800
Message-ID: <20260921075312.120983-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

register_platform_devices() creates multiple platform devices using
platform_device_register_data(), but returns directly when a later
platform device registration fails.

If LED or watchdog platform device registration fails, previously
registered platform devices are left registered. Since module init
failure does not invoke the module exit cleanup path, these platform
devices remain allocated and their backing platform_object memory is
leaked.

Unregister successfully created platform devices on registration failure
paths to restore the missing cleanup.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: dd123e62bded ("platform/x86: simatic-ipc: add main driver for Siemens devices")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/platform/x86/siemens/simatic-ipc.c | 40 ++++++++++++++++++----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/siemens/simatic-ipc.c b/drivers/platform/x86/siemens/simatic-ipc.c
index 7039874d8f11..9bf8b2d8248c 100644
--- a/drivers/platform/x86/siemens/simatic-ipc.c
+++ b/drivers/platform/x86/siemens/simatic-ipc.c
@@ -92,6 +92,7 @@ static int register_platform_devices(u32 station_id)
 	u8 wdtmode = SIMATIC_IPC_DEVICE_NONE;
 	u8 battmode = SIMATIC_IPC_DEVICE_NONE;
 	char *pdevname;
+	int ret;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(device_modes); i++) {
@@ -118,8 +119,11 @@ static int register_platform_devices(u32 station_id)
 			platform_device_register_data(NULL, pdevname,
 				PLATFORM_DEVID_NONE, &platform_data,
 				sizeof(struct simatic_ipc_platform));
-		if (IS_ERR(ipc_batt_platform_device))
-			return PTR_ERR(ipc_batt_platform_device);
+		if (IS_ERR(ipc_batt_platform_device)) {
+			ret = PTR_ERR(ipc_batt_platform_device);
+			ipc_batt_platform_device = NULL;
+			goto err_unregister;
+		}
 
 		pr_debug("device=%s created\n",
 			 ipc_batt_platform_device->name);
@@ -139,8 +143,11 @@ static int register_platform_devices(u32 station_id)
 				pdevname, PLATFORM_DEVID_NONE,
 				&platform_data,
 				sizeof(struct simatic_ipc_platform));
-		if (IS_ERR(ipc_led_platform_device))
-			return PTR_ERR(ipc_led_platform_device);
+		if (IS_ERR(ipc_led_platform_device)) {
+			ret = PTR_ERR(ipc_led_platform_device);
+			ipc_led_platform_device = NULL;
+			goto err_unregister;
+		}
 
 		pr_debug("device=%s created\n",
 			 ipc_led_platform_device->name);
@@ -153,8 +160,11 @@ static int register_platform_devices(u32 station_id)
 				KBUILD_MODNAME "_wdt", PLATFORM_DEVID_NONE,
 				&platform_data,
 				sizeof(struct simatic_ipc_platform));
-		if (IS_ERR(ipc_wdt_platform_device))
-			return PTR_ERR(ipc_wdt_platform_device);
+		if (IS_ERR(ipc_wdt_platform_device)) {
+			ret = PTR_ERR(ipc_wdt_platform_device);
+			ipc_wdt_platform_device = NULL;
+			goto err_unregister;
+		}
 
 		pr_debug("device=%s created\n",
 			 ipc_wdt_platform_device->name);
@@ -169,6 +179,24 @@ static int register_platform_devices(u32 station_id)
 	}
 
 	return 0;
+
+err_unregister:
+	if (ipc_wdt_platform_device) {
+		platform_device_unregister(ipc_wdt_platform_device);
+		ipc_wdt_platform_device = NULL;
+	}
+
+	if (ipc_led_platform_device) {
+		platform_device_unregister(ipc_led_platform_device);
+		ipc_led_platform_device = NULL;
+	}
+
+	if (ipc_batt_platform_device) {
+		platform_device_unregister(ipc_batt_platform_device);
+		ipc_batt_platform_device = NULL;
+	}
+
+	return ret;
 }
 
 static void request_additional_modules(u32 station_id)
-- 
2.43.0

