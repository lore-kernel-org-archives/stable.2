Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D515311C1B
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 02:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789351812; cv=none; b=afpHM3Kc6/8Hv3ptyof7Xs6S7XQ5RBai6ixUycM0AHKt/aDRsxUdl0zcSAVUCetWGiNCKPhgLmBMAV/ZC5aT1Pj7d818+43uKPmXZi52I5PdPv7d6MGgmn5cOItqIUtPCQXTH9UNo/D3fIoFcbGLY8kTiK2EtAFZkjCDmrtxWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789351812; c=relaxed/simple;
	bh=B0FAHrSWVXGHaqZILibkK+o++O0wPS8q+cwkcADrHJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E0t6/qNjnmy0dKfZ7uk0YHP+Rd91WpVuXJTVt4+bR+wPIAYr5PFfxkRQMS9v521B79Ss4vxw58tAPNHK9xc06pID/1WCgLPrds1iJu9h7TX1d8klxZUVVgg1sUUASubvjV0wgJ9s1NNCW52KyqqBfHn8daHOsJ12OUc/We82jYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMhYpaHD; arc=none smtp.client-ip=74.125.231.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMhYpaHD"
Received: by mail-oi2-f0.google.com with SMTP id 5614622812f47-4a4492f5cd1so366597b6e.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 19:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789351809; x=1789956609; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dXWWEPWR1eTf24c4piCmTsBKFKIOYSQEhaTgS6fa4xg=;
        b=jMhYpaHD25glrbNFCZY7N3myS5Va4Yy1yKfh8kwtcxHm8npygF+60cH/NArCGfy+bX
         7E/uk5TmNSjnrhrtvry/lRMIYLiLQpsgnOPGMrOqixKzBHy/mTY3a/w9/wVWZoCErj33
         /Tum4wE7vsktKOXNciKT4BzGScbFKDUssqr6jPtP+GmXUbVtxYHHxgzFzF0oIFOqiFRa
         6FegTJ5MhNLSZ6YlJzxfUpHxTDWRjFdtUbWLmIugJHnN9JB+EXHJbNGcWcE8MuksL3bC
         3x4LLuv/Og9OrXhl5LCFktkue7ni0TuobRSyHNjFGVwJdKvnTJDbSgrxgkeh7nEp7D5y
         OOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789351809; x=1789956609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dXWWEPWR1eTf24c4piCmTsBKFKIOYSQEhaTgS6fa4xg=;
        b=Fbxz3PD5iGXLkoBx71rYeYeoV7P0GczbX5uje9C/viHC24YH9eKF+kWAdMkGnk7+dT
         2OIyxoLi11VegRH2cPL5iNrfjsdowDJP7yLg5NnIA/o8cMSinLApXOa5IMEEEVgcRzL8
         /7s0MMAFYx/s+aCDIdivmMA/r5mywW7e2OtvkMe7DOTerMbcFosmafh0sJ9w5gt3KzE1
         TWNxhRS1tU71eGCBL2AR7p/F7VM/m4DQG+GX5jLtne2nVPN5PrnrSmMds7nj7lEVmTvk
         Rr3evvq0rcSuZrfGhV/lwixW2jIoXZKawjtUMlT/v4ZwFRTq0WfEkV2SmPy9lDwa5r9j
         +yBg==
X-Forwarded-Encrypted: i=1; AKwUvBwBLTy8oWAxyWnUCAxb31LmxyQY8wuMPBMGL51NsXcmHZKXD7FgXxQgrcCn3HtvAY5sO/fEaK8=@vger.kernel.org
X-Gm-Message-State: AFuF++k8esf1zsF+ydgVccu14Vn1EzKEeU75ulif1mYOTNGpPo5Fvlmm
	AGIvWEgAMhOMs8cClJOiGcnOLeXHjQW9H1GztWc5HeEIDDQeztbT3Hcq
X-Gm-Gg: AYBFou1ViHyVKiqSmYKw3DKane97Finav3LrQE6cXIu8ABWfPONl4xpN/IyBwdKCKcV
	v6ThlH6RJJsd3E7ZP374bJpQDN41RgdPzcSNnFoi/GRvLcj7SFkQg7roeWAWKqLQSSsf9Atcbv0
	X2REgggDx46xG0Cf4NIgIng9aiP4ZLoqGRHg7Cq7EfByX9X8FWIaYhiDGlXkB+qAnoS7coh2Fg3
	0Ymv6KAmH9ukN8jfZZZE9vVRcigRM3x+zKLyrh+gRDFMtbDxRN4pmXZmBDE7d0oqHhQGBm6FK4K
	KY+RoZQy5FJQtVhg7DDJsNy+Hdd+EUhrEYuLShLjcztGD3auCb2+rTLxd64PcQVCCVMesbNXp8y
	xW/C6gAWNPoEOc1QhTvFG14VFRQuCeWYYkLfxgflpqv9f2jXHFMKzGSEQaaPfwWQn7HUsuUwNgM
	djzpC2GJ8RLddlxhQSdgu5OsZo7DV7i2qKWLbQjM7Ohze2nWOWbetdcC3ZAjf7BPEs4vw=
X-Received: by 2002:a05:6830:6a95:b0:805:6a93:d9ba with SMTP id 46e09a7af769-80899266f27mr185481a34.15.1789351809265;
        Sun, 13 Sep 2026 19:10:09 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f5ffd82bsm9788713a34.11.2026.09.13.19.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 19:10:07 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 13 Sep 2026 21:09:52 -0500
Subject: [PATCH v3 1/4] drm/imagination: don't gate the runtime PM
 callbacks on drm_dev_enter()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-1-674b907d0652@gmail.com>
References: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
In-Reply-To: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789351801; l=4009;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=B0FAHrSWVXGHaqZILibkK+o++O0wPS8q+cwkcADrHJk=;
 b=m0nuDmmhwVrLfYPrLL6ql7pVKv9N25E76iOoE06iKNPUoksHHY7cDxzgdfxNiEHBncqvkJPZO
 omdWCiOyDUoAX3gisn8eY+hxz2rX+Vqz3A726TzxwQSuwuOn3F1GHuS
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

pvr_power_device_suspend() and pvr_power_device_resume() take
drm_dev_enter() for their whole body and return -EIO once the device is
unplugged. The section protects nothing: the callbacks run on the
platform device, which stays bound until pvr_remove() returns. It is
being used as a "device lost" test, and pvr_dev->lost already is one.

Used that way it causes two problems. The suspend callback waits for
the watchdog worker in pvr_power_fw_disable() while holding the section,
and a worker losing the device calls drm_dev_unplug(), which waits in
synchronize_srcu() for that section: neither finishes. Runtime PM never
lets the two overlap because the worker holds a usage-count reference,
but pm_runtime_force_suspend() ignores the count, so a system-sleep
implementation on top of these callbacks deadlocks. Reproduced on
mt8173 with the worker delayed between taking its reference and losing
the device: system suspend froze until the hardware watchdog fired. And
once the device is lost the callbacks fail forever, which leaves runtime
PM in runtime_error and would abort every system suspend.

Test pvr_dev->lost instead and hold no section; a lost device is a
no-op for both callbacks. Re-test the flag after the cancel in
pvr_power_fw_disable(), since the worker just waited for may be the one
that lost the device.

Fixes: 727538a4bbff ("drm/imagination: Implement power management")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_power.c | 44 +++++++++++++--------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/imagination/pvr_power.c
index eb4b6ecdf4f4..8d82b9a79daf 100644
--- a/drivers/gpu/drm/imagination/pvr_power.c
+++ b/drivers/gpu/drm/imagination/pvr_power.c
@@ -97,6 +97,10 @@ pvr_power_fw_disable(struct pvr_device *pvr_dev, bool hard_reset, bool rpm_suspe
 	if (!hard_reset) {
 		cancel_delayed_work_sync(&pvr_dev->watchdog.work);
 
+		/* The worker just cancelled may have lost the device. */
+		if (pvr_dev->lost)
+			return -EIO;
+
 		err = pvr_power_request_idle(pvr_dev);
 		if (err)
 			return err;
@@ -372,24 +376,19 @@ pvr_power_device_suspend(struct device *dev)
 	struct platform_device *plat_dev = to_platform_device(dev);
 	struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
 	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
-	int err = 0;
-	int idx;
+	int err;
 
-	if (!drm_dev_enter(drm_dev, &idx))
-		return -EIO;
+	/* A lost device is left as the failed reset left it. */
+	if (pvr_dev->lost)
+		return 0;
 
 	if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
 		err = pvr_power_fw_disable(pvr_dev, false, true);
 		if (err)
-			goto err_drm_dev_exit;
+			return pvr_dev->lost ? 0 : err;
 	}
 
-	err = pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
-
-err_drm_dev_exit:
-	drm_dev_exit(idx);
-
-	return err;
+	return pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
 }
 
 int
@@ -398,33 +397,24 @@ pvr_power_device_resume(struct device *dev)
 	struct platform_device *plat_dev = to_platform_device(dev);
 	struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
 	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
-	int idx;
 	int err;
 
-	if (!drm_dev_enter(drm_dev, &idx))
-		return -EIO;
+	if (pvr_dev->lost)
+		return 0;
 
 	err = pvr_dev->device_data->pwr_ops->power_on(pvr_dev);
 	if (err)
-		goto err_drm_dev_exit;
+		return err;
 
 	if (READ_ONCE(pvr_dev->fw_dev.initialised)) {
 		err = pvr_power_fw_enable(pvr_dev, true);
-		if (err)
-			goto err_power_off;
+		if (err) {
+			pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
+			return err;
+		}
 	}
 
-	drm_dev_exit(idx);
-
 	return 0;
-
-err_power_off:
-	pvr_dev->device_data->pwr_ops->power_off(pvr_dev);
-
-err_drm_dev_exit:
-	drm_dev_exit(idx);
-
-	return err;
 }
 
 int

-- 
2.55.0

