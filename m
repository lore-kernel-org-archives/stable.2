Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44A48CD48
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462243; cv=none; b=tN84/Z7+ior9czXVeaURpK6KEakAPMVK3BVWuqmEr6Y9DOLWb4j7AENg1sCoWCssWL/zd5weU52ANBvpnSZ0Fjd0BnYKRXmjk/HRJoM5FVxYotvjlKbiWlSfkr+oXNGFHssO0Otmajk4gKk5F7PDFkRO/GlC5qQ+eCr2l3pJjGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462243; c=relaxed/simple;
	bh=aOycPQPzW1hoyp3VFb8uVa68Tk1zbSs3hp8DysdIXZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0lBH/EUafcVWEMP+iENQzLulmyB1uqcY6+5ZVigvyojYwFjzLHug4lrpth+VnTsV1B693Qyc4ygLnqSrtKk8aqy6bfGTUutq92iaiY+Gvqu2lhlcLaobau1C2SuQoBgQ3qx+H86XuAj+NJNemrBBMa9xyOUWtTJu7KrROIu3qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akwQ9mg8; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akwQ9mg8"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so2948245a12.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789462241; x=1790067041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EZwK4GxS0mTkcXMKP8dTYTElQEtFXQdtakQVWZWGWY8=;
        b=akwQ9mg89ZrMDBRUKanD+mVGTGgNbzRxMKlQScviLHR+k5NbO7kffI7WvuaaZsp8U1
         eqVWdTJhZ8zac9hWolYcpYW/ppph/8i9GVwd9WwhZWj02rf+scQyXw62AKheVW5UnDJA
         5jy4f2In7M/8YJthjEcVaX3ypism7aJnQG8mvqk0UiZhAo1vk4WSuyYrBJ46+Qv7jl6O
         qV9hGrFpY7CAm363jHF3B07QaiwfPg9jp/VSCaxZTkKIO2z9XPVwm2TjYgGlUK5iNl3V
         X/kCna+FJEKS/MDg90QIodyA4+27mnIYGc47RTugoH/6l04GbtFkNd0w10Uzv3HlRBbe
         FBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789462241; x=1790067041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZwK4GxS0mTkcXMKP8dTYTElQEtFXQdtakQVWZWGWY8=;
        b=WoskVgjp59iU2Yl5dlM1ZRL9gx2ZDC9xhMJ8tH5gTKxqFahyJJgLE8k9W0dpxpNgq4
         KfAQPUO++YIVA3Af7gfO+NbeYbtD7M7oefBDamDDxxTuchyvgPHGx8pUfX3fbH+fvP/1
         pVwtB2oeeBPpc4HmtPBQCZCFdlXKozACRGpiyUUucyEi78WloIyy30rXZctOe6AnSd+w
         FoFMjY8e7UBo7mPi+E4n1T4tIiHC7Whjp0tTYC2iejRgWbBUuosNjsCtFubdfT7YoWvm
         rFybVAkQv/b3Q5N0OfwR5gzJyuD7PlcqCjzJSqsg36yi/uN4tD0v1GTgzcZK22qcDGDu
         7eMw==
X-Forwarded-Encrypted: i=1; AKwUvBzcQarCVNPMtz8axNVB8naApnH1mxZUpouYGouSQCjbetg0W7iZwfC6VAxdFrnV51sDGo5HLKI=@vger.kernel.org
X-Gm-Message-State: AFuF++m57WlM7fne1T8KQEVjZ38gs3ccRSeW/CBKiBHBNv9ybJmxFL1z
	kmscke/7eFJuXyTJxGLVHFsIHjdKKoUaPdh+AIknKqyhbwuJeA/wHty1
X-Gm-Gg: AYBFou0XjWF32FrFFGDchmlAcvsgMKH58/dijIXEkDJkShd9BcTFJbifuC8yb+IEjpW
	yxhn9x4hYjoXfqnEgIvZrJil4mGepWSAiF6i0z3J04ZdfztUdGnFUB0aN2ohLvsDPskD8TfvyQd
	IkYegGLblHYk6Re1PmDPSAvKRY3C5IgKmCUEJJlmaVmrDodXl4yPCMtRHTfjf4+yPQEuiFZ35HV
	48021ozY2Cprn6TAmN/MQmkAZPi07iBuywJWUVzvMoa3vikYyqU1a8udzmVqJCY34LxpoFaGSVa
	pPj8cmo/vCXGpQavn5VCGAYVCKj014AvKUpP1PP0gMgQF6Iv5b3C0gutswdip8rZT2geTUj+ZPE
	5XIzvRHNsZTafxvHNMC4tVQGeaELwA9Ty0erGhPTk6l+eWHu+k85bWvLeGMp0wgcB8+LSQn0CIG
	SbbSsCwoDvYbhr4q2AgbzT7t7oyu5StfDLrLot0iU1uAWVAv2HD7Ty7b0MlHa3dD4i
X-Received: by 2002:a17:90a:d88b:b0:39d:8794:5564 with SMTP id 98e67ed59e1d1-39dec08fa53mr12246257a91.12.1789462240654;
        Tue, 15 Sep 2026 01:50:40 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd28acbsm4003559a91.10.2026.09.15.01.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:50:40 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: ov2735: fix power cleanup on remove
Date: Tue, 15 Sep 2026 16:50:31 +0800
Message-ID: <20260915085031.2331315-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ov2735_probe() explicitly powers on the sensor before enabling runtime
PM. The probe failure paths call ov2735_power_off(), but the remove path
does not perform the corresponding power-off operation.

The managed runtime PM helpers only clean up the runtime PM state.
devm_pm_runtime_set_active_enabled() disables runtime PM and restores
the suspended state during device resource release, while
devm_pm_runtime_get_noresume() drops the runtime PM usage reference.
Neither helper invokes ov2735_power_off().

As a result, removing the driver after a successful probe can leave the
sensor clock and regulators enabled and the GPIOs in the powered state.

Call ov2735_power_off() from ov2735_remove() to match the successful
ov2735_power_on() performed during probe.

This issue was found by manual code inspection.

Fixes: fa9e6df636fb ("media: i2c: add ov2735 image sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/i2c/ov2735.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/ov2735.c b/drivers/media/i2c/ov2735.c
index dcb1add1fd9f..2defcaa8b795 100644
--- a/drivers/media/i2c/ov2735.c
+++ b/drivers/media/i2c/ov2735.c
@@ -1081,6 +1081,7 @@ static void ov2735_remove(struct i2c_client *client)
 	v4l2_subdev_cleanup(&ov2735->sd);
 	media_entity_cleanup(&sd->entity);
 	v4l2_ctrl_handler_free(ov2735->sd.ctrl_handler);
+	ov2735_power_off(ov2735->dev);
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(ov2735_pm_ops,
-- 
2.43.0

