Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7A4EA39A
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363835; cv=none; b=DmU3l8vCSLpLD390o9WILIGWFpGxrP8oKwu0TV7Yxbe72eKIn2PZz3SKQ06DYNl5P53nKbyJ3Wm1GzJObnYFuD1jUbh7vcaF987pPVf8dENjXAXoOBNXDB5PdNnFEv7Qn4Qe11/D7vopBMUcCoQFHxTO6akImKv5/vIEvMX9iY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363835; c=relaxed/simple;
	bh=XhREjkmhNCUql4b5JIcUpys+k+BsoJ+A9gP9gB2g0ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQtzNAm6pH6r/OLgyWW4tIP6nBkMA9/FzCRen+48RG33Cs3wP4a3Y7nPlBd6rF/RBMnBFI3PiolNL/xX9H6Ih0e2Wlf1hgQnDghbE0kqcDTTfsIH19NVMdh7nqROpyY8NIjIuDzKZhe95BtQeSqeZXNypemuaeDH4FK5BfwIGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUP7Ifi2; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUP7Ifi2"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-9142e0b0668so13890466d6.2
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 12:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790363833; x=1790968633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YTcnAr0ZcdWSjcBB1bEaQzDSsCqaWUPkS0US6ahLsTs=;
        b=KUP7Ifi2+UmoY1j2EVngOcpDYqQVkhqwPhr8aF47l3gIQX6WkkKr6Z1EVPm243Vsfo
         w/5f/YcyeaAked5s6YpBLIzr2SvdJOuM0FYMTbBQvwrNKg/z5qnbmoP4Hb9iLmC7J1V3
         Uezrz0V6xcGUbe0LlnL6dzfxPP1oTLCYkfzM3HRCzGSdZzvrYDb3UNLR2lYsZ6Jk0255
         uQ0NxXJUBHCu8pW1p0RWvtqsT+tFva7jNuCZA+Vzay4/4p8l6NtVvrjGcKKRHEgop4Lz
         Ywsdx9NTdqeKT5bvcq7fzXu/yXTwRCBV1tpAT63zF/1ks3zHQF1IduvrUMKg/WHBJc43
         XyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790363833; x=1790968633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YTcnAr0ZcdWSjcBB1bEaQzDSsCqaWUPkS0US6ahLsTs=;
        b=GCqB/qvS6QYF08nyEquoaEkIVacFZz/qRbr29f+bf9RHSf0omg5dDAdxis1ppTo3gx
         FXRaV7tMLWPol8Hv6N/eIvqd+50ZjHKYLzP1NJYzIQlugoo50WdCVhzOZlsH+sQAmzqI
         giGteJ5wfVSmiTtLqgVPgWxHUUqQZBrtk9ILJzio0/2i2g7A8QRdif7IJRak+oJ48NPV
         r2WavQVn4MOidjzT6kLsqHzjhoUpkKd0qOJZDA067TFnYOuzPxL2yoFt9y0y+qLBS6MJ
         l8pdDXx0FzfkdAeVj7n2prjXA3de6nw/a4f8kEKRvsMEfCg0Xre0Ynjrx8oS9bPIOZtg
         LYNg==
X-Forwarded-Encrypted: i=1; AKwUvBwSDibFOtWgYoVdZntakwkBnGzv6lkxJh4RImEph3vJC5QHVdqbM7Bq9q6Et3Ml5ZPZpr6mO/Q=@vger.kernel.org
X-Gm-Message-State: AFuF++kVys/CIFX8bT9MnA0yyguTPEDLd7wFZVXnLkZ/li0RCZo8j4QP
	ExtMoXQZbijOwg61qq6NUgB8ZBj1BdUafQDwJqrkcaQpSro0EfaLuG3BBXH4uL8drw==
X-Gm-Gg: AYBFou2YhoOq3vFfVcC3/B7gsexCL7fYogiFE4VsW4GXjdsLxOfqIN/qAhMarXsIzVK
	XhdRMc9MDWvL4nkqL5WtLZhWsAyzdhZi3MsFa4AcD/PCakqdwuyNbkADLUGobnFQi5tfIhv2w6m
	JweNLfuNB4DqJvBFU/GLoEkMxU39YoNVsf7qUdd1j0MLbZL4NSYOIEfFYVIHURxFy6j65jaW7ex
	EQlR053mmxhTTILk8oS/1EdCTXsUQig9/nrIPVqC9LqzpGV1n9jAnD3MC/MF10C/Hp7Wr1hJMFI
	R+eXcgnwkzBEBJ0j2qCtkIwUIEiroEdoJG2TNnRZN/5B8KWNR4QkuVKborfQUcCvZlZtUSAQxJH
	8V2OHnySa5QfuwJXAsfbyjtu5g7MvEhdYaTM5i1rd+t6h0LNMI73+9muxzU3vesMf+CrXhiRFOu
	qk2es41yApKkbdc46kUUFgMveDlUie0HrAONZgCBaVF2Ai1Zm6tii2TcbOhsu7naK88NmB5SxDQ
	GjwLnIXRBZ0VRk31H24kTOQf4hGtpIgPg1LP8vKrGNLgqdGGMYZD8/LV+6gu12M/slVPv5b4Mj3
	voUZtZuzLPwB26W8u4dvmXsO/7GTQd1Wn6jMCpM=
X-Received: by 2002:a05:6214:d8c:b0:912:40d2:45c2 with SMTP id 6a1803df08f44-9142f8b25bdmr62523526d6.30.1790363833095;
        Fri, 25 Sep 2026 12:17:13 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430e09ce4sm23521776d6.28.2026.09.25.12.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 12:17:10 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ming Qian <ming.qian@nxp.com>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Zhou Peng <eagle.zhou@nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v4 2/2] media: amphion: prevent unbind while video instances are open
Date: Fri, 25 Sep 2026 15:17:06 -0400
Message-ID: <20260925191706.3144437-3-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925191706.3144437-1-mhun512@gmail.com>
References: <20260925191706.3144437-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An open video instance holds a plain pointer to its devm-allocated core.
Unbinding the core or its parent through sysfs can release that memory
while the instance remains open. A later ioctl or close then uses the
stale pointer.

The video file operations pin the module, but sysfs unbind bypasses that
protection. Suppress manual bind and unbind for both platform drivers,
and warn if core removal ever encounters a live instance.

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/amphion/vpu_core.c | 3 +++
 drivers/media/platform/amphion/vpu_drv.c  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index a0c58ec97a42..2e8e08e05de7 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -696,6 +696,8 @@ static void vpu_core_remove(struct platform_device *pdev)
 	struct vpu_core *core = platform_get_drvdata(pdev);
 	int ret;
 
+	WARN_ON(!list_empty(&core->instances));
+
 	vpu_core_remove_dbgfs_file(core);
 	ret = pm_runtime_resume_and_get(dev);
 	WARN_ON(ret < 0);
@@ -846,6 +848,7 @@ static struct platform_driver amphion_vpu_core_driver = {
 	.remove = vpu_core_remove,
 	.driver = {
 		.name = "amphion-vpu-core",
+		.suppress_bind_attrs = true,
 		.of_match_table = vpu_core_dt_match,
 		.pm = &vpu_core_pm_ops,
 	},
diff --git a/drivers/media/platform/amphion/vpu_drv.c b/drivers/media/platform/amphion/vpu_drv.c
index 2cca61f41bea..9c6f32c5eae9 100644
--- a/drivers/media/platform/amphion/vpu_drv.c
+++ b/drivers/media/platform/amphion/vpu_drv.c
@@ -205,6 +205,7 @@ static struct platform_driver amphion_vpu_driver = {
 	.remove = vpu_remove,
 	.driver = {
 		.name = "amphion-vpu",
+		.suppress_bind_attrs = true,
 		.of_match_table = vpu_dt_match,
 	},
 };
-- 
2.53.0

