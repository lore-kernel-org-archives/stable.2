Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8253AB5BB
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783407937; cv=none; b=PNEdWuNFk5BynXBrbKy+ohkk+RjCnO2mNbso9SxmXzPn5+stEZLYSYE2Ti9G73VESy02C1Ztik0b+ANjTk99LsRBgYGXUAV2R7PDCpPzlFfmoSSuta4sxJ++BrQHTyV/hS644kUiKksHsQwxc9aK2Ksp3ZTyy3aVVvjU6+N6hwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783407937; c=relaxed/simple;
	bh=bY5LKc3I0Jv8nZpUIEOF6lgwuy/yE4feoIlM/xShIEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IcU7MBTTFnIVl3LRGpnUYAUQ17+T5z2lV+M32D5dhoA/ycRAhs70/vqnbzX12YAqhnLTkk2d8+TepTXbVWMB9+SYqHosk+4Q3322wdYYl0wP1WTfUFU3obIAj0de9FaVRL7GvEmVf+tpr1PeGLWipbGfSVnr9d+qYdiS+vRTYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=EaP6yODx; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="EaP6yODx"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84780c95e2eso3033992b3a.3
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 00:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1783407935; x=1784012735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JinMzbnW1YyIiCcwbl+3maMIpSRORpZ9ZKiJ12a6GbA=;
        b=EaP6yODx08kgproUFTtnRXilV1dE94XAnTRvYsVcD9t5ocNt4ZsrRoeRxJIBqCmTLb
         3PGJsgCMLDPfdoklquK6PnLQrdLoSnD9lrGLInB6xI7u75Epg4I6EY2zNrJhSA6Q7jsH
         j/NDBeP7Ucd6OXfKb8js3E6k1bXGEaHhU4kJs+I4S1yK3fsAOBI1j09U0E9fy6SHdplm
         ySyggBrfvb7Slw5pxesIPUgChAAx1HvupoSUKUQIHZTqCtRcT9dFfLaknFRAubZfn1L6
         /gXURG11v5Zl7b/GQGTCouhsE5S29K5UnUpHZa/w46E/AWdkXq6uVOeG1lH9fquMKNIp
         MQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783407935; x=1784012735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JinMzbnW1YyIiCcwbl+3maMIpSRORpZ9ZKiJ12a6GbA=;
        b=MGZS1BMHsWQb5hlFqKE3DCGV01W25fJ8OVDdM+CA4AKS1QzMUrw+YpgNKD/sF7UVSI
         NFupwzCeTgNBCHTfP6tzlI5pAi7ueemz0Fle6Kir21e6tiZVjYWTYZDoJZe022H9i5tS
         g5ja778Kf3PMux82Bu8TqshMQ96M0QzA6Rf7GptHEMrSNiqNDke25s+PFtQ+KnErjLV8
         nmp1PQ9cmw+I560SVHZkDjh5owj5dBf8+YceJjB4eiICAcvUpppiUyR5qq80IXA9XDDk
         zpLTbvnJG4eDkIYzlwi9Nf3C+n1jSNG4IMDbqMFwW660gf9ha53Oc5O8q5tptPGZuqlv
         oCOg==
X-Forwarded-Encrypted: i=1; AHgh+Rr1AjMhuhidSzeC9PeWhoxnUKZEr5/yVeOLXOiaGxbIdmKILgpSYvtR+iSBeNTDb2Bvr3eGgok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7UIPdinuXuUS4gXmT+KukIcPV2jJNiwU8FuU2TyAcaPHaJWqh
	wLcqcdQqRtBTzPAb03FfpLiwvKgYHtayBfEz/bbIpJu5VWEQf1olYG/yUMEqxAqu4B8=
X-Gm-Gg: AfdE7cnhQAfqKPgDmtl69JEgYvNjAMQ8qF5STKug/PUnHFnypwDwHaQ+kJZNoTtMsC6
	DpD/fKIcqwQ8atJlqLnC0ThygXxxRxvrDbCaEYX/b2zk8c4sBylpx7QV1L6nE21BJ9zeHoWv6W0
	qIhP5uCQ2acvSgmNgkJ/RdUpwlSB7eB38EAFZe7LfdbEhtNy5ah3AijznngVJk3OpxU0vw3I9sY
	yaSGmqDpwmMly8P6PI3XybvbpMAEy3iDC3EBFZZTEB2iKhsCcVxiXyn6Y49WmizESohWv9wusmD
	wmA4/wK1nIj1/pg1BVftRmeip/Mz4U7CclWVKFs/cNQ1Rkpua9cmGKSR6mxwrYgN9bn/zNd4+rI
	KUSRc2zn8fjNI0w+e0MCSvDmzUBDCPL18/73rs8iqVxdj5DRqrrZTY68fhoZDZ9T62LDqZGlbuN
	H4WGlNZKW66gMIymAhFF7gKEgy3t2GomS31vbAC80C+eGT13jceGImxoHo/jbmSP7ODfIrdfo7K
	GSFxqjekmB57hzOc6amyw7Biwo+9JPty28QNXttJJw=
X-Received: by 2002:a05:6a00:2905:b0:848:2f74:d8d2 with SMTP id d2e1a72fcca58-8482f74dc63mr1607434b3a.67.1783407935320;
        Tue, 07 Jul 2026 00:05:35 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-847f6d4e741sm4986516b3a.28.2026.07.07.00.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:05:34 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: s.shravan@intel.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: int1092: Fix potential memory leak in sar_probe()
Date: Tue,  7 Jul 2026 12:35:22 +0530
Message-ID: <20260707070524.953741-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocated for device_mode_info in parse_package() called by
sar_get_data() is not freed in some of the error paths in sar_probe().
Fix that by adding the corresponding free in the error path.

Fixes: dcfbd31ef4bc ("platform/x86: BIOS SAR driver for Intel M.2 Modem")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/platform/x86/intel/int1092/intel_sar.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/platform/x86/intel/int1092/intel_sar.c
index 849f7b415c1e..b27fc07c087a 100644
--- a/drivers/platform/x86/intel/int1092/intel_sar.c
+++ b/drivers/platform/x86/intel/int1092/intel_sar.c
@@ -273,13 +273,13 @@ static int sar_probe(struct platform_device *device)
 	if (sar_get_device_mode(device) != AE_OK) {
 		dev_err(&device->dev, "Failed to get device mode\n");
 		result = -EIO;
-		goto r_free;
+		goto r_sar;
 	}
 
 	result = sysfs_create_group(&device->dev.kobj, &intcsar_group);
 	if (result) {
 		dev_err(&device->dev, "sysfs creation failed\n");
-		goto r_free;
+		goto r_sar;
 	}
 
 	if (acpi_install_notify_handler(ACPI_HANDLE(&device->dev), ACPI_DEVICE_NOTIFY,
@@ -292,6 +292,9 @@ static int sar_probe(struct platform_device *device)
 
 r_sys:
 	sysfs_remove_group(&device->dev.kobj, &intcsar_group);
+r_sar:
+	for (reg = 0; reg < MAX_REGULATORY; reg++)
+		kfree(context->config_data[reg].device_mode_info);
 r_free:
 	kfree(context);
 	return result;
-- 
2.43.0

