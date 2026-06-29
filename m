Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F86C2EFD95
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782760670; cv=none; b=AH/+75Ed17Tm8i7R4G0smbXz92cHGINynsYmLauouQtZxL5Q7adeI15wra93PAreorcMvy9ST0vgP59+/STUwznqP9ttRDPiMqU7l3W+XlI76sTFwzPLlJ3JsuV8BiNLL8RCX98Ju7i4lzCL4uPo/DNgYOL3ARQbh3NyuxkT/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782760670; c=relaxed/simple;
	bh=CZylIcWn27L68MlVFpHOzPw+3g5OCtM2dDKHRd6Pmhg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DEHD5yuChFZOBoOTykUJje2NO4HfxNygBBjs08LA8E4O76X+y1CHYOQ3zNto4bLvzdUMNHX+x1gp/AwqCnQ4Dd0HaXJEBqOGJm3YJEDOpcFJ3PvJ/3rIKzxRJEkM7bSR94F90TChPrv3fxfaYlKC2tG1TozklnicCcTsqQwQjC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CG5WBuvz; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG5WBuvz"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47488efcf30so589561f8f.3
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 12:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782760668; x=1783365468; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CH+iuavhzCl31XtXX1knhfjNMAVOS2hmiFPE+b/1Lsw=;
        b=CG5WBuvz7eUJAeTCaqbjb2USK8+SGz5bPFKn5AfIysLueqQb7/KNyxrm4rdoocpP/s
         en4pMQTwtdxuhaBDULhM2evWMmz1Z+6w5ravfu+wAA/+q+smPf1J2p6vNzTRKsEvSkGt
         NmSDvTPnRH++NtQ2JMyhRHSK7XKRJOm0wDSXRztYDZoW/fKPc1qgFkYRVN9phXDbHUXe
         rPEhc+2U0ASGXlXw7AeNGd1kfWh8s/bXJbM7P9CTb+pUx0ah0G1WdaKtJl3PqN7Yxn7J
         War+C5zDoHelbnF6YMUM3QiTPbcfC/f07BxnrTZymfzmrzGp/EHbCmjuZHf7x9U2ur+g
         oBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782760668; x=1783365468;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH+iuavhzCl31XtXX1knhfjNMAVOS2hmiFPE+b/1Lsw=;
        b=hGqzTmYncTdIYSpf/HTyRFy+iDjfiQn3RILCPP8RdYVthCRBG2uD0PQguGtLtITGtB
         V7ufRwuZlN9vyEgRgJ5dlfwC85XaeAsgCwtahnECfa1490s1VAlTYFue1ARI4H2e/Fmd
         GfzipKStkRx1R7shXJzvLVh2FAq/vWtpJo57vjqNPo1YiyPk9WrOiqAttlFStighwoG3
         555Gjx7VBxKHyu/xabUtAPbM45WH6KFUhosc+CXyzTgoY2kIjMzd8PYlfatCLR2OGaxU
         SW2z0bZ+dpInZOUfJhs1boQqjjzHTK3wkHhKYCFuLSoidpn4r0aVKWkWPMUEWLpeS1V+
         aEeg==
X-Forwarded-Encrypted: i=1; AHgh+RrUckfVJVMwcrJq4CRcOHkHPPgPmPf4cX27/mRbpZ2I7DP8RbGPBMXhG/lpiy1LFZcgQkRggtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTzsc+tNMYmvkZlAtyCqCj+/L/pZ99GCAZwZ+JXrIQ/Zvpf20x
	bVmrVv46cz1PawnEfbmcb0QDcfUxOYsi57vWiO5y/o4ue83+aLcHB3s5cx0FcA==
X-Gm-Gg: AfdE7cmO3K+Wkpa/Lu0T4siYgsO0LzYmZ9/wm3S9tfFycMzMvY5Vi62ApSZlgNHooXc
	UmI/nLpnEksClYuUXeEXjeVEL2CvFPzcLWKh2joXy8VQpNuFNplP5d62Yk9HvOGCS2zYBNuoon8
	eJFULmyVEZJSPHD68GYPDnT8OqGvl9nm0LV20LNWzKJOCMqcq384+21jTC6FLqgls4G8YPyxxdA
	PGlZFPh1x3M20HFnJlG92zJOoF+c0ulwjDt7qmIkUBFsx5OrMRDQl0K8jH6RdEAbN3uF1WYj+R3
	FOwIq7vpUcn2DLV4JZZdiUb+NtjxHCBfUK3QaO/YCQHQd5gV5UdVHdSJ0GEELkwmsQl85xPnfEB
	mrlEP2c0XHoAzSdEvvnZV36M5YORFJkfzUjMaR4ckYezpHn2l+KBOdtzzUDcarQLPNRp38u1qNy
	AUJzB2BJygBdVBlnnDaVCPqvMgZ1VsXEYnWdBGumy8wvYhsDGlmVPRPjVZ3dx4NlF+jYuJYGvHm
	vPhMqUvihyQLrFTPq0fSMaUxLvkJWEb13Ek0hFyZdrN9Sm6Yr2Wd/arDjqhnEu2h2rv0HPEAlLu
	r5jAzy7bow==
X-Received: by 2002:a05:6000:460d:b0:454:a41f:d082 with SMTP id ffacd0b85a97d-475507ddd71mr871993f8f.3.1782760667911;
        Mon, 29 Jun 2026 12:17:47 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636cdccsm259568f8f.24.2026.06.29.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 12:17:47 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 0/3] hwmon: (various) add missing `select REGMAP` to
 Kconfig
Date: Mon, 29 Jun 2026 21:17:38 +0200
Message-Id: <20260629-add-kconfig-deps-v1-0-8104df929b1a@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBswK8OuEi1ExxoCE4UIpLsnL
 d/i/wqFMlOBRVTIdHPhKzb0nQB32LgTsm8GJZWWWhm03uPprhh4R0+pYG9nLQcTplEaaFnKFPj
 5l+v2vh+GCetaYgAAAA==
X-Change-ID: 20260629-add-kconfig-deps-1a76039f5409
To: Guenter Roeck <linux@roeck-us.net>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782760667; l=872;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=CZylIcWn27L68MlVFpHOzPw+3g5OCtM2dDKHRd6Pmhg=;
 b=fJCaRP12TPACNq8PfkVp10HKykP4OoU1/PrGyUvkczDlSND00BPHkhebyN75Tj58oGKUw8XU9
 +0uMykZpudYA0VOOsI8UZcWpXv6Wn2PjOFfH7X93cgc5gtkJfjDECfB
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

This series adds missing `select REGMAP` and `select REGMAP_I2C` to the
MAX6679/MAX1619/LTC2992 Kconfig entries. Without these, some builds may
result in a failure.

Steps to reproduce build failure:
1. Run `make allnoconfig`.
2. Run `make menuconfig` and select I2C, hwmon and any of said drivers.
3. Run `make .` and make will end with regmap-related errors.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Joshua Crofts (3):
      hwmon: (max1619) add missing 'select REGMAP' to Kconfig
      hwmon: (ltc2992) add missing 'select REGMAP_I2C' to Kconfig
      hwmon: (max6679) add missing 'select REGMAP_I2C' to Kconfig

 drivers/hwmon/Kconfig | 3 +++
 1 file changed, 3 insertions(+)
---
base-commit: 446bf1ecbaeceb72d85553ce0ac0e6afc03ec5ca
change-id: 20260629-add-kconfig-deps-1a76039f5409

Best regards,
-- 
Kind regards

CJD

