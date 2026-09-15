Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750562AE76
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474239; cv=none; b=lI1KTNW2QMNTx/o+xLeJcEVbjLhpfL9bYF3a68JHe9aj8noig8mO5U5PsJnk8LrXScYqVMuBUNK93UyInnZClBcnWx6c6KyTDw4aQ8ggXOMuGZhIhr3iOhmvBxdBU0EPChbmSclALurvzSu/TBMI2GoL8l00DVZCeJNC8DrY6Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474239; c=relaxed/simple;
	bh=dhlrGVJ7D9Hj9A6FiXBLOrjstCSBxDQs1GtUiWJMBS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5xvPkgZlU1+47nMOjBxapea9hr/MjdYxxeQxqWdPaKFY0sCjmkf71jMUwFfdOS7cxK8nLTZaxWETXGlBxrMsUTEeXNuIVUxP+80gcbJs075LLzUvc08fPRaeCy4fPKZ6FdXAsSSs7FgZDhX+6Y/HW56BS47Wk8jtO6lW10Sbt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOWoBGT3; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOWoBGT3"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd53691be5so28606695ad.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789474238; x=1790079038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ARc4u49b6G5t0LuKLqwXD8cu3X9ELbFHgcHDb7cDF2U=;
        b=DOWoBGT3Xdze7NRdlHBOGu+/jqOc0krPoz7fA3s2cpv9rBCgaNuROGRD00SLUzFMgJ
         fMhnKXKYjPXyX7eCPB8sdkyy9AWlm0/Dekr3mpPAFgbWx69ga8eOFYyA9h0f2Rn7VmKo
         QR98P8gbKftzva//gbx7hOG1Tk/ffrk9tVYGq25R6vwxG6yjeTr4ebtv3TeezQBIp/EO
         RG2563XeLWA5ub7wzupEMaCE2eDVBWy2ri/hWALVvMOjwqqZTe6vMFYbHDdGftH7vAPl
         mNpRppvAGEl9AENaYJ7uvG9Zs3jRRHMIvuK+QgUbb06RDtTbdmgBxQwqfyF7I3pWrBFX
         gdzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789474238; x=1790079038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ARc4u49b6G5t0LuKLqwXD8cu3X9ELbFHgcHDb7cDF2U=;
        b=BaRN7ZMqtPyJlmDqrpy5vQUt3nTAJCv26nfXoal8eo4Orb6u3nfK+qgk7+9Q+IsWXl
         AeJ9ydKPA1CDjTOhsRrnjQpmGBgQVXtAkYzeJNBPRWtB3UEdJhhYRmtCveh4ZHUYeYQV
         1zW5exaAjFTdOWpzV3hl8+rIt4Q2TG6+mFvcD0CyyWs3qZUUQGlF92P+IZRC9WYjlhtu
         Kq3+F5IED5neDxwBwJbOWLKzn3uX+PBLM5hnWMaoUZ1blbQD8KFnWuqFhN0aNoVHxv9b
         x7AvMTGqu4ul5m8Ofa4dyPSS2dkGrERHLAHOWwGNL0u9YwlrPNQF1Mrpax/dMg//gIHX
         nHiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvuUlccgCScsy1DxjLuZNH4Tms6zVj10VM9Hszx6N7sC+bO+L6IPyshPfPI8/ODh5rlyVSurU=@vger.kernel.org
X-Gm-Message-State: AFuF++kOjK4gCwBFfWqs/efHusDNFBqCEC3njxAcUJ3ZLTOptcGgymle
	rAFgBTAVZ8Zg7gu+Ehe3JpPIuNBB6QDvFOHj0oUYF1CQtMI/uK/2KxP/
X-Gm-Gg: AYBFou3PyUK5NLHWtPy7YtdWgcg92QLsL+hYMCWVAy7N8r2DJImCZt+DDmMgZX928zs
	BgziR0palevz06DHzwBmcaruz5VZMU9ORmmkXBZP2fWXW7WNL9HALOkiSyvs57GwgGwr4tJFoon
	He7DBwS8dE5tyFjrh3v70/HI+it+vruvGMQ6ppOL4E2PTnGbWq5pYMJR9ykCU5MuESJ4T4h+jTl
	oFkjesaxkDnVQkP+naLWgFe6vs3bvx9W20/Rjp6zPg1vA6tdBlZMuAZo/ABok+uuisxYBpf65nm
	BhdDh32bR39ZzRoFfGFg0pG67CcsjZgnCOz8guqVxMU2rqUKv7bcL5rWcdxlcPGQw/1lvz2Bc3s
	Pz3ZS4b0+7fWw6kPxi23OdFNQvUQu7HNp0rYYOwZW9sGJ+dpuNC7+xeZET65dB0XPNVfsOt9iBV
	BLUFtZA/HAPcTA63iOSEPDALZshl5j7Ze9+XbqAg77RCLmyrkTW+W/Wg==
X-Received: by 2002:a17:903:2c07:b0:2d5:e3ce:3988 with SMTP id d9443c01a7336-2dd6c6e9b11mr142531885ad.11.1789474237753;
        Tue, 15 Sep 2026 05:10:37 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cfce707sm66466685ad.55.2026.09.15.05.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:10:37 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
	Houlong Wei <houlong.wei@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: mediatek: vpu: release reserved memory on remove
Date: Tue, 15 Sep 2026 20:10:25 +0800
Message-ID: <20260915121025.2412446-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_vpu_probe() may assign a reserved memory region to the VPU device
with of_reserved_mem_device_init(). The probe failure path releases the
assignment with of_reserved_mem_device_release(), but the normal remove
path does not perform the corresponding cleanup.

As a result, removing the VPU driver after a successful probe can leave
the reserved memory assignment associated with the device after its
lifetime has ended.

Release the reserved memory assignment after freeing the VPU external
firmware memory, matching the cleanup performed by the probe failure
path.

This issue was found by manual code inspection.

Fixes: 3003a180ef6b ("[media] VPU: mediatek: support Mediatek VPU")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/platform/mediatek/vpu/mtk_vpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/mediatek/vpu/mtk_vpu.c b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
index 8d8319f0cd22..16b5bdc2f2c0 100644
--- a/drivers/media/platform/mediatek/vpu/mtk_vpu.c
+++ b/drivers/media/platform/mediatek/vpu/mtk_vpu.c
@@ -966,6 +966,7 @@ static void mtk_vpu_remove(struct platform_device *pdev)
 		destroy_workqueue(vpu->wdt.wq);
 	vpu_free_ext_mem(vpu, P_FW);
 	vpu_free_ext_mem(vpu, D_FW);
+	of_reserved_mem_device_release(&pdev->dev);
 	mutex_destroy(&vpu->vpu_mutex);
 	clk_unprepare(vpu->clk);
 }
-- 
2.43.0

