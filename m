Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B501E9919
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791020108; cv=none; b=UEs0PRHb+x3N6vKNZND8HAPYGnQa6FDbPpl8l/0ATitJDhQTLCMZEql4Jlv8kDj8ssFBLAd9bvFQfytnmNX+c0JaKT82d7exe/+VwQrp2oZG+nX16y9TnTlXl+X/Sy6s/at05o0gJSo9ZGBGkedK4q67ks3qPE5GOTI6BJ/cros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791020108; c=relaxed/simple;
	bh=sMtTL70sqBS6bZKU54CdL/36q23iIjnTETx6pZYzH5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9cvSqh56MQh+nuyQJ5lgJjbQ1ReNKPKfkotstdpaH+0ncdJlY+fHrdp1AGXX6+swTgr5xh5x5t+Peu+Qy+Rc/QNu7+FMppEKpPQx/iYZUMiYNoLSKDoM+tHBWRin9wje9V38o5raM67z+MCLsmBbPZV/vbK6e+sXqVRSIjcKmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hY3mMQpG; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hY3mMQpG"
Received: by mail-pj2-f10.google.com with SMTP id d9443c01a7336-2dd9bce707bso1258585ad.1
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 02:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791020104; x=1791624904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zWQSpGzLG7DWALbabuPoeKknlGH7FdAX1uCS5SSDZcY=;
        b=hY3mMQpG7FmLiUZINjqfWHoG08M6zQGeP4vRc1awwlkF4WqnT3iuwfBO3VBWlepzKS
         VkoiMNpXzT30bkM/NKdt+MsiniyZ/f+fOwLIMI5JijE9fEKhq5ZNaFLHH/FPYD4VNF0s
         MBMqca7rWkb6IdsMMIQ398um0m0zcPDJxFwQ0jt1nE8kjutdPPsqVLxg99z6vuG6r+8A
         grWfu6/psy2xiyk8/+I/GM3pBYXRACHipUZ+Y6CDi094PuWTShDEJ2e8kZfZTgV7RljI
         VIER3S4j3cDS549gXB6s5bEVVQVVk1vTcLwnsbuRLQj59iFIOZs/U6LKvpV7Yzv7PMe/
         rYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791020104; x=1791624904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zWQSpGzLG7DWALbabuPoeKknlGH7FdAX1uCS5SSDZcY=;
        b=BWPVh9thEEVChGQ9ewT0OqAU5lQ/RT6AaMxnUTKDqIa8PGVuUxbSFZqHLWk7tlFLkm
         EM3xtuGctjw0Zue2xlCPiNIM2bJWyY0yaszob8iUmJl8favbiDy6UcBH3OxWGazhWfgN
         N6k4SH659PZGxDdzFpouEWJRfpj6kaM2WrwCucjIS59sbR6RYiQuIPNe1Pk744eqvwLS
         5tWIzm4NxRXviCVe77hZqhe2tNRbdwOvTCKfTP3s5yRDRfP4yQFvSwSbEnYaOng5rdMV
         MijwAS/9S2OdN9Njuh1+pLxp7SfFgmwO6HV4wNTvPbzOY2Gp3c3T7JPmM7RTyAtsEAq/
         OpPQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbdZjg04w/nIaIF0qiXdL1TIw+Bv5kttY6djmynHYv3oLLbic2Q/vuSCRw1XuX+1OoA4WpqyQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kcLrdyyLEn0iedddy2odWAgUMpkANQOJncXvtzDB9SwuBI++ms
	v2Irpp3PhRLFKWVj80b5JJ6Un9ZhSx0p0Gfxe9noLvfZWanRHqaSL2a0
X-Gm-Gg: AYBFou20fNMT0XP5+6CDzbNgTpr10XWk605aBJrICVOLW++fMndI/+GDx1ca2qOEOct
	eauR0TekdCJM8YIUxDGXHqyG4h0lhyH6LSF5+qOlqhQW/Fv0jZeORkUAR/v8qXP01Sk0kZYKOjg
	HamGyKhF+ePtmJrgjiLOV+ON3bVb2RAhClESDD40TJaXUch1e5zwmJxKP1O+XfJdroGmKrwSKHG
	LdYHf/qeHKhTNQMW5PbMnwMsmYxYolBAhEQM2rHrBVJpS6vWXMo9waHHrm6eX1UDCzbkQ4OwdBP
	M5N6DX9R8r/lOWH594gJug0h2M5jMnoSVLhuWcpMD7ejXc8RBrCBc8iqzMWgtyEPvnCybDAmMBg
	jEW/Rjx64JIhYODqhnJP04zzZ6+kqGwwPUn7ReuS19PPgOQ8jeGnBeY1JU9tt/v/j2B1tW9xzHb
	hqae8Gm+8P0Bxvcpu1fqETfdkj4NlCxvUebvk0bhrS6i2jva2vU4vp8IjjIpwRUhgT
X-Received: by 2002:a05:6a20:94ca:b0:3e0:b680:c3cd with SMTP id adf61e73a8af0-3e0bd2900d8mr5555662637.49.1791020104397;
        Sat, 03 Oct 2026 02:35:04 -0700 (PDT)
Received: from localhost ([129.227.235.110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f739cba5sm1956261a12.28.2026.10.03.02.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 02:35:03 -0700 (PDT)
From: Evanshenf <archwse@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>,
	Qianhai Wu <wuqianhai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Mingcong Bai <jeffbai@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Evanshenf <archwse@gmail.com>
Subject: [PATCH 2/2] drm/loongson: Handle buffer mapping failures when clearing a BO
Date: Sat,  3 Oct 2026 09:34:59 +0000
Message-ID: <20261003093415.902f89244043-2-archwse@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003093415.e64386de1e64-1-archwse@gmail.com>
References: <20261003093415.e64386de1e64-1-archwse@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lsdc_bo_clear() ignores the return value from lsdc_bo_kmap() and writes
to lbo->kptr unconditionally. When the first mapping of a newly allocated
buffer fails, kptr is still NULL and the subsequent memset accesses it.

Return the mapping error without touching the buffer and propagate it
from lsdc_gem_object_create(). Install the GEM object functions before
clearing so that drm_gem_object_put() can release the buffer correctly
on failure. Do not add the failed object to the tracking list or return
an uncleared buffer to the caller.

Imported buffers still skip clearing, and successfully mapped buffers
are cleared and unmapped as before.

Tested on LS7A2000 with a one-shot range error in ttm_bo_kmap(). Its
-EINVAL return reached userspace, the object was destroyed once, and
no GEM handle was published. Normal create/map/zero/write/read/close
cycles passed, with the tracked BO count and VRAM usage unchanged.

AI assistance was used for the lifetime analysis, fix, fault-injection
tools, build and test execution.

Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Evanshenf <archwse@gmail.com>
---
 drivers/gpu/drm/loongson/lsdc_gem.c | 12 ++++++++----
 drivers/gpu/drm/loongson/lsdc_ttm.c | 10 ++++++++--
 drivers/gpu/drm/loongson/lsdc_ttm.h |  2 +-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_gem.c b/drivers/gpu/drm/loongson/lsdc_gem.c
index 2fb0348..9eba4e1 100644
--- a/drivers/gpu/drm/loongson/lsdc_gem.c
+++ b/drivers/gpu/drm/loongson/lsdc_gem.c
@@ -157,14 +157,18 @@ struct drm_gem_object *lsdc_gem_object_create(struct drm_device *ddev,
 		return ERR_PTR(ret);
 	}
 
+	gobj = &lbo->tbo.base;
+	gobj->funcs = &lsdc_gem_object_funcs;
+
 	if (!sg) {
 		/* VRAM is filled with random data */
-		lsdc_bo_clear(lbo);
+		ret = lsdc_bo_clear(lbo);
+		if (ret) {
+			drm_gem_object_put(gobj);
+			return ERR_PTR(ret);
+		}
 	}
 
-	gobj = &lbo->tbo.base;
-	gobj->funcs = &lsdc_gem_object_funcs;
-
 	/* tracking the BOs we created */
 	mutex_lock(&ldev->gem.mutex);
 	list_add_tail(&lbo->list, &ldev->gem.objects);
diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c b/drivers/gpu/drm/loongson/lsdc_ttm.c
index 88536e2..7b30dea 100644
--- a/drivers/gpu/drm/loongson/lsdc_ttm.c
+++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
@@ -388,9 +388,13 @@ void lsdc_bo_kunmap(struct lsdc_bo *lbo)
 	ttm_bo_kunmap(&lbo->kmap);
 }
 
-void lsdc_bo_clear(struct lsdc_bo *lbo)
+int lsdc_bo_clear(struct lsdc_bo *lbo)
 {
-	lsdc_bo_kmap(lbo);
+	int ret;
+
+	ret = lsdc_bo_kmap(lbo);
+	if (ret)
+		return ret;
 
 	if (lbo->is_iomem)
 		memset_io((void __iomem *)lbo->kptr, 0, lbo->size);
@@ -398,6 +402,8 @@ void lsdc_bo_clear(struct lsdc_bo *lbo)
 		memset(lbo->kptr, 0, lbo->size);
 
 	lsdc_bo_kunmap(lbo);
+
+	return 0;
 }
 
 int lsdc_bo_evict_vram(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.h b/drivers/gpu/drm/loongson/lsdc_ttm.h
index 843e147..df47d9b 100644
--- a/drivers/gpu/drm/loongson/lsdc_ttm.h
+++ b/drivers/gpu/drm/loongson/lsdc_ttm.h
@@ -89,7 +89,7 @@ size_t lsdc_bo_size(struct lsdc_bo *lbo);
 
 int lsdc_bo_kmap(struct lsdc_bo *lbo);
 void lsdc_bo_kunmap(struct lsdc_bo *lbo);
-void lsdc_bo_clear(struct lsdc_bo *lbo);
+int lsdc_bo_clear(struct lsdc_bo *lbo);
 
 int lsdc_bo_evict_vram(struct drm_device *ddev);
 
-- 
2.43.0

