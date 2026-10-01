Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C337F314
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790877486; cv=none; b=JfEGUGu7/V5zOycdjK7skhQ6UNKAnIk979Ly4uhmBUrJKvSc2p+h2YucIf1qDGUAm0wIiFEn+pF6EfNXv+gSgjTrS4lWX2X6u6A8pQplq6NaJ1Pj8XNxzvcr2dU9bPDne8MgwB5qnQXax3rJ9CphZXmg77xSovQzgGxtwBQUi1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790877486; c=relaxed/simple;
	bh=jpJ+Su3Y1yhm/gM5Dhwlk3M8DvQgQBJXozNtOrhbmY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Buap2t9kVo/1d42fNYrmBhNtK71gjEv/Ai6EtN9CrLthekgWA67KBGcjN2f4Gzcr51p0N178sJDiWZ131sma5PCJuiVt3XGzDNlobfVU1wWff8b1ZeGfzy18h8tTR8DLj4WvATpRcvWVZFaN5QMG9Dq8nrSoxp6wmOhXiD4sNAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNGs+jaV; arc=none smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNGs+jaV"
Received: by mail-qk2-f40.google.com with SMTP id d75a77b69052e-5332b66b660so59731911cf.1
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790877467; x=1791482267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=axc/agQFuJUMgO0JWETHJcM/R1Xc0CldGQrnTgdLGIs=;
        b=SNGs+jaVfW43SM1Zgl6aMZN+jyG4LJHlDbCqUHj/SM4aCLKMnDVQIuKCoCnpLPz7le
         RxIQ4Z1qlRrYx8VsITrwpLd8/+1pSR5/OfbB+qjsB3fCkm4QVXaUB7Kz8QqSR97Bkm33
         L25YAi79gY2Y89N/UY1hVrqFeZtSY45ue2RvlRqANFPgq0sYaMr9oXAuBM4M9eTVYscX
         SXk9BktaXIdrQkF6z2NFkXdRLmcijYdcLmpNV2scAxtmpIpiTUvlLEDZl+2om1+ZTLHS
         md3mSVfNJrMP/awCNVVjrG4lC7RvIGxlKkX2sUxfCpMfCvOjYBeKdZ/E27pLJ9ywNSF9
         0Raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790877467; x=1791482267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=axc/agQFuJUMgO0JWETHJcM/R1Xc0CldGQrnTgdLGIs=;
        b=zkx704dnn4S74lpMGaQLrR2c8IOBl6w5C6/j2GN0OBMi0ElXNhb+7FBOCW0+4HOBUw
         5qdaapcFB9BLQb8NZa6L5j17s6oil7aulQpC0M8dLVKACJluGCZplXTGAyRZyn644LHs
         UUcrgBqa6Vx2JOVC+TbmrlowAe8V/dZKbe13leJ0McZiABJOq5PFnKmrcAJPI9spvxAo
         HOzrxcojynphUsV8r1d0fuVwM+C0ODmE0q5gI1tfOwe66bxMyKEJ2cdnTXW4yWLUN5AJ
         rBzaL9s9k8aOXRpwK5x3M1urj1V1GxJlg3Xo2C8X4Z9ZV4j2lkWJ3OAvNpg+kvhqXW7l
         4OBw==
X-Forwarded-Encrypted: i=1; AKwUvBzH3HLheYEBficGp0FeziT6I3uGVw3pXtXj6uzZ2x++fM7h8h3Z1SMxHajHJOUypIFnYDji2p0=@vger.kernel.org
X-Gm-Message-State: AFuF++lzVaLvzozIUJ2gQbRYzDt6fePVdAdP6k2Go52XjQyr0hN/p/83
	XX9npawocnX5gt+gvWnRTVblBcJcXzmIP5AUfHF9lAiflGYOUXMfBQY=
X-Gm-Gg: AYBFou25jCzir6YSQqVIc0o2MZCAEnAFsLbRldfl2t5ZpiHA2R10braQkYzUoEiEWr0
	d4+mG0W78f6Omh2zdAmZRfHYZ4GkaFxaDaLIRbAx+jQgIvFoDFVPcrcRufaNmrrxCsrhYvJTtaR
	RU2a56cCk0cdQ9dppTyGZ1kxyyPQw/pV8BefB7NSmwta3us92OJpXxL1VEXFa27tqpML4ixcB14
	qliLyVdYydIr8TgEbKWOhVOj4Q3eI9vV8UBMLnliRz0pyz8sX6bBwA6g7/Ca1pT8pXmWjuoEA/Y
	yf/L/aoqK6eR6H719LuUx9K0U6VlmjNBCPUKr1rqxFyuLY06NzLAmScPQ0YvkLCO95EWKY4gTBH
	cOkqjwMsw4KJa08ZJnUIDD95hUKWdTsNJtuSfNUAn8OWqxinSm/E+RmT2sScdPPpYB/+ZlH7aDR
	dCyn6pK1MI3sIJvyhvLHQeXY5svj7Wa2DiFcNGoz3YGOOmXMMX+6zHg3AQx6NHoyyMF70LQgBb5
	ROm12vYjSoFRUU1DagnI+9PBWUgkFbsdLaWRq6ZhHuT4r0KVtCrpoY7Rzg1ljcGH6Xnjxq0inuf
	8+NapHeJv1YFtWVibNYyRqHG5tQX
X-Received: by 2002:ac8:7f8c:0:b0:52d:9dd9:63bd with SMTP id d75a77b69052e-5337427ea48mr112168181cf.10.1790877466953;
        Thu, 01 Oct 2026 10:57:46 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917a8a9800dsm31853976d6.46.2026.10.01.10.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 10:57:45 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ming Qian <ming.qian@nxp.com>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Zhou Peng <eagle.zhou@nxp.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	Shijie Qin <shijie.qin@nxp.com>
Subject: [PATCH v5 2/2] media: amphion: prevent unbind while video instances are open
Date: Thu,  1 Oct 2026 13:57:37 -0400
Message-ID: <20261001175737.4048254-3-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001175737.4048254-1-mhun512@gmail.com>
References: <20261001175737.4048254-1-mhun512@gmail.com>
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
Reviewed-by: Ming Qian <ming.qian@oss.nxp.com>
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

