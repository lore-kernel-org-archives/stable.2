Received: from mail-pz2-f16.google.com (mail-pz2-f16.google.com [74.125.228.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A0494A1B
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461891; cv=none; b=AxU5ouXEVuYZ+napz/qoYiGxNjDRMilvYEJS4HCWb2P6WTwViR8kuzBL1pJ0AF5X7CX+fPAshsinM82rZvqy68I3MfC8kfDPn+mGFK/r2hO+DQ08zQ/4E93b/ArC7gYfP532Rk1nh+lQmSrbHkrVPElo0bw68bhFZPLjCcfP+D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461891; c=relaxed/simple;
	bh=sIWXsFOViFSc+IDafr5CEvfwl5IYge2eVO88nxfFni0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N/79sf4FoSF+Zd3yssOZAvFe2sJBUTDFNf5kWBkav/njPwDQZsRDmaSko14PyLr6Y8GrVuVWdhSQqM2Hz34Ye1FvwSUmIoL553uQp9NwegUGspfUm1oEPJlDIDIdNvKezrQmwKVx6cKHg0ZiVOm4i5/0VF9M/p7L9lNV7rZQ2eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI8qnZnu; arc=none smtp.client-ip=74.125.228.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI8qnZnu"
Received: by mail-pz2-f16.google.com with SMTP id 41be03b00d2f7-cc4d2fe2056so13447a12.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789461888; x=1790066688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZZpYund0BctTk6ZH3SpbNGSO6zmMyboEAdN+GkOuIBA=;
        b=jI8qnZnu7uDOdAVW2I8qt620CwL1qYLkLRpFYssH/rWpXNRd0J3r5TMKdv+11vPr0J
         L67H/ULryeVp3mjXhiCycncaZ1R2FFURGZm6ss7salhjCCobfTJovosHdGZWK/uMTwZB
         31+R0BP9vX9CFJx/y6K+LNzpNxpDi9aCuCFrtsrlPGNJhVvBlrhSZkuUUkE26G5zTsqZ
         i8VXrnxtO3GarP75GwZtW/PgOvatJWxChudVV8Rah4Pd7WmFHN5Ahej1w+zFIUKKBCSG
         h2nzLLIA+sxd2wfm2P8kRQrpmRxNZ1EBAdALsl789N8e3O095KUcVmYhafm39XEMQgpK
         Am/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789461888; x=1790066688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZZpYund0BctTk6ZH3SpbNGSO6zmMyboEAdN+GkOuIBA=;
        b=Ue4T0l4nTJ7R39/DXH2ofiQ3b6fINb1H7tCJBlptbsus4h63ImMd0RZeLxoJ4UcZM0
         eHQKMqu66ZjqmOZijwwGRGSbhd61sYs3xUSoeufnxUv6iLYlP1+NUeLAAHjak7rToRwa
         FiUJ5Gq7Upy2WyIPxyuu3Y30wUsW/c51FEAEx5x59vmdUVufe9Sa/1Hl9pKsCZrqSlgj
         WuU5kMy9a+xuFdG6HDimeTT1TO9rXJ+gDGXMquh8d0pZo3BKf5hi62ORGYjIefqeF4Pm
         8B2S3N8jfcho2JkE1DC/0qNb69qO/75gMpLhSssg6iQtxbwwh14U/ZpH+5yQ7OS7Rkpg
         7low==
X-Forwarded-Encrypted: i=1; AKwUvBy8bl8iw6MYSb52tQg4rkiwKsD74mb6zTzjOGas+Po9dfPjr59ax9kc+FsfszWLy3dpx5uIcCk=@vger.kernel.org
X-Gm-Message-State: AFuF++kjpP6E6uLIXLWaaax0R+uJJLPHq6mNgG6RpsECdVBrEui6j83+
	aXKOIaES8HjapJNGdeXmfxB+TUskbIUq3Ei7+LlygdB3UnY45hfiwd7x
X-Gm-Gg: AYBFou0KJe7pW8E20P4xymZ6to2uU+fw8TbS3cZk87XLGwuSX542M2pRQ2Yk2wMj5YC
	tg12KUh7m1L77xS5Vp/ZUTyNfoXaVFDi7pxeHD4i40Q7k85imqt+00gVlF1U5b69YDJt7TJ9oRB
	LhLI1P+07vAKQL/qASuVin0ylnvWolZ3zcvDustHxkY2dA7XG9WlrfdCTtjCzS53ZqWRps20Gwf
	/vTjI9fGCLsjRnlK6rS3aozDa7l6RVhn9pDgjuTrWEJmkJyEGWlV8Ro+WW0uqTOPF5y1+s8hY28
	7XbjJxLz4ggbKCEboZgIl5myDsuxSlSxV3P9pkNLxalLRzwPW+KrKnZ7jb2uigpnoSgPtDvgpYW
	cLg3QVlMXuzg2bOPJx9nxG5wpgIGYJTa0lu8VZRK2woWC/KXY9caqKOGi+ldS8wZ/EqC3jbFs3+
	Osl1Ut1qCWuk8tO1Bf/TzKGZCmFHKcmzGq6LgNyn3S1HwMWFcn2gOUAJI=
X-Received: by 2002:a05:6a20:7f8a:b0:3da:7140:da35 with SMTP id adf61e73a8af0-3dd52823778mr469275637.15.1789461887506;
        Tue, 15 Sep 2026 01:44:47 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6528fb9sm6186338a12.10.2026.09.15.01.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:44:45 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Arec Kao <arec.kao@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Hao Yao <hao.yao@intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: ov13b10: fix power cleanup on remove
Date: Tue, 15 Sep 2026 16:44:36 +0800
Message-ID: <20260915084436.2329278-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ov13b10_remove() disables runtime PM and marks the device suspended, but
does not power off the sensor if it is still runtime active.

pm_runtime_disable() prevents further runtime PM callbacks, but does not
force the runtime suspend callback to run. If the sensor is active when
the driver is removed, pm_runtime_set_suspended() only updates the
runtime PM state while the imaging clock and regulators can remain
enabled and the reset line can remain deasserted.

After disabling runtime PM, check whether the device is already
suspended and call ov13b10_power_off() if it is still active. Avoid
calling the power-off helper for an already suspended device to prevent
unbalanced clock and regulator disable operations.

This issue was found by manual code inspection.

Fixes: 6e28afd152280 ("media: ov13b10: add PM control support based on power resources")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/i2c/ov13b10.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/ov13b10.c b/drivers/media/i2c/ov13b10.c
index b0d34141a13a..6d57da39c371 100644
--- a/drivers/media/i2c/ov13b10.c
+++ b/drivers/media/i2c/ov13b10.c
@@ -1688,6 +1688,8 @@ static void ov13b10_remove(struct i2c_client *client)
 	ov13b10_free_controls(ov13b);
 
 	pm_runtime_disable(ov13b->dev);
+	if (!pm_runtime_status_suspended(ov13b->dev))
+		ov13b10_power_off(ov13b->dev);
 	pm_runtime_set_suspended(ov13b->dev);
 }
 
-- 
2.43.0

