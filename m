Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DF14048A8
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548166; cv=none; b=eWJqI+uElbLjFTqef1+0A2WQnUww8Z+iDrYHOccdDkLRCG0RSlNp9G7VDuudYqJJOC1kBd0Cy7PKYpxpgQc+b3mNFzLdWUjX+07pKlyu5fGiUeto0/V11sbsT+APzlJWE13ol+voIVvfko9JW3ck8hxbi1q4voDspuQhdSMVmJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548166; c=relaxed/simple;
	bh=wpIzyFlOayw0t27RZwLxD2uaPShfVF6IYH7nU2klkZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sJb1w2sNUixKLV5yM6XHr+EzjKiaggzNzeF00kTXjv+KpcdMiJUa+ge5Lb7QQWRRILTy+Jnavhpi9vvqsrpPkX2Jo8AQGNI3EnMYzy1xYufIz0VjzWxUnXsZQumtoAKnrpBUQAYuOu9Tce0HHbjZY7PWJswgAIP4JmHH00iB/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mz3G2Dn7; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz3G2Dn7"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-472326ca506so7714800f8f.2
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 04:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784548161; x=1785152961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qNwj0cy3My+7S0Jfbfh0/9yw10VBWKnPBk+HsO2GxKY=;
        b=Mz3G2Dn73cx7ALAQthgVtmpotfolQNYxqZus+4711IsZZIcJxSOh2+9ij11ma3uCFw
         Bf7/wsZYPrFuw42IxzyljZGK2BNH4t1zBGUL2FiFl6kKeNHOsbMyKJ+0CU3xN630LOuU
         /Y9H+ar8Kl0dChdgAbFLAOaf1D/gaKyTYaFm9YBzb6tNy5NEoW84ZS+LpDWCEizCqw0m
         +pr826LR/ZUxTcrdWzzYiG9sDkUEOucX/lzQ5G62i+OZNzKFK0Xg4UzBX8Y5KPPndFUf
         2PoOEK9DQlDRO+4J5l3NO2ymVeAaH56xN5GylE8mgaOfLuNxIhI2vIFEseUwcAgqxn8+
         EM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784548161; x=1785152961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qNwj0cy3My+7S0Jfbfh0/9yw10VBWKnPBk+HsO2GxKY=;
        b=hwq81S2ff6U8z4Axyz1A6JoHv1yneGFhtZP8E15m0aoF8Dl34/pBhUB6JhxGUor7Vx
         Fhu9hGatoJ0cU+VuwKvYcQ1iMPZvPOX9wlw67FXvD8+FK6prrsIfsR2C/vN+Z2+3H6pW
         cb9R7NE9j/MVFbeYax9vNWRwyhdCqf2UP7495q2VpGl/hJDs35mbJju0yqz7M8u/BYM+
         wD7I9yGr4ZjapQ8VQHXapaiEKEil7Lr5oFUwGT2LCJk0lHEap5FjbnvSgMvTntQcnmVa
         qMGc7fAcoJpYlgJ2FP6baKIlRz25UijBD/ZnCwVnh82yPUr1Ygi/wagzg/sYFKPqJVPe
         KShg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7PwhiR4mIsu99uhf4yhijKHU5iKLX1XUcoK3gvLOS27vlp9FzVy4h+iGR+5bdtm479L4HZXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnwA5dgfZd3EjN4rcnr3DuZ0kk2t6yQanMD6lx3DyBLO6shS7
	cKjd7TTvjiwAd0sGBRqbW6vpMk7nkD6YHX419tLigZHx9ygo2KvyET0E
X-Gm-Gg: AR+sD11NVdaFfWwMIGQpefbSP6nU1I4DLzZN/BhY5CYEwkhTkqShsqEXYiESScPKYDM
	x8yk7lez9MJwQR5swc263OOYvTT4aj5Wqir/A5URoZUgeR5HaEwtFj1vbq94gOVmPwqx0PVsLe0
	GeUJirgeJQtMFejNowoXfM1HhdefTg+y5fzM4wEnF7pKq2diZq27dsUsh/5QHdDGvYrR6PEd1FX
	Lagjif0T5KwJ2uIGo7KsSHvKKK9iHuNd9yUBCGTo84ZbX9ZVPhVQae9/vvGi9T8BdJ+/aXiLQ7X
	fG7HDRJlGMjA7z4FUyVIYU4RTz4ZgUNCtdW/WtaGTA0kt3yPVL3WWPWseLiVci9C5FNI9eV/aCX
	Jw3zZAajI1XKNsz/qp/GAHVyd7QAsjxKaaIXnc55OgF6uz/tPvIZJMmnLqp+tT9PQpJS/XepLv9
	lSLFbQWyC+hecQUawkZhsqkgztls+YDyaoD2yZGj/QdEgVSpaA5IF0u4fT3tc=
X-Received: by 2002:adf:eb8d:0:b0:478:77c1:7876 with SMTP id ffacd0b85a97d-47f6233d208mr13018808f8f.57.1784548161324;
        Mon, 20 Jul 2026 04:49:21 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:a26b:a888:7408:fac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e499c2sm27588500f8f.4.2026.07.20.04.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 04:49:20 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: validate firmware interface structure sizes
Date: Mon, 20 Jul 2026 13:49:17 +0200
Message-ID: <20260720114918.15973-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iface_fw_to_cpu_addr() only checks that the firmware-provided MCU virtual
address points inside the shared section. The returned pointer is later
used as a full firmware interface structure, so accepting an address near
the end of the shared section can still lead to out-of-bounds accesses.

Pass the expected object size to iface_fw_to_cpu_addr() and reject ranges
that do not fit entirely in the shared section.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 30 ++++++++++++++++++---------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 9d0e1fafdce2..eee2bc7e8541 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -870,18 +870,24 @@ static int panthor_fw_load(struct panthor_device *ptdev)
  * iface_fw_to_cpu_addr() - Turn an MCU address into a CPU address
  * @ptdev: Device.
  * @mcu_va: MCU address.
+ * @size: Size of the object pointed to by @mcu_va.
  *
- * Return: NULL if the address is not part of the shared section, non-NULL otherwise.
+ * Return: NULL if the object is not part of the shared section, non-NULL otherwise.
  */
-static void *iface_fw_to_cpu_addr(struct panthor_device *ptdev, u32 mcu_va)
+static void *iface_fw_to_cpu_addr(struct panthor_device *ptdev, u32 mcu_va, size_t size)
 {
 	u64 shared_mem_start = panthor_kernel_bo_gpuva(ptdev->fw->shared_section->mem);
-	u64 shared_mem_end = shared_mem_start +
-			     panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
-	if (mcu_va < shared_mem_start || mcu_va >= shared_mem_end)
+	size_t shared_mem_size = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
+	u64 offset;
+
+	if (mcu_va < shared_mem_start)
+		return NULL;
+
+	offset = mcu_va - shared_mem_start;
+	if (offset > shared_mem_size || size > shared_mem_size - offset)
 		return NULL;
 
-	return ptdev->fw->shared_section->mem->kmap + (mcu_va - shared_mem_start);
+	return ptdev->fw->shared_section->mem->kmap + offset;
 }
 
 static int panthor_init_cs_iface(struct panthor_device *ptdev,
@@ -906,8 +912,10 @@ static int panthor_init_cs_iface(struct panthor_device *ptdev,
 
 	spin_lock_init(&cs_iface->lock);
 	cs_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
-	cs_iface->input = iface_fw_to_cpu_addr(ptdev, cs_iface->control->input_va);
-	cs_iface->output = iface_fw_to_cpu_addr(ptdev, cs_iface->control->output_va);
+	cs_iface->input = iface_fw_to_cpu_addr(ptdev, cs_iface->control->input_va,
+					       sizeof(*cs_iface->input));
+	cs_iface->output = iface_fw_to_cpu_addr(ptdev, cs_iface->control->output_va,
+						sizeof(*cs_iface->output));
 
 	if (!cs_iface->input || !cs_iface->output) {
 		drm_err(&ptdev->base, "Invalid stream control interface input/output VA");
@@ -957,8 +965,10 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 
 	spin_lock_init(&csg_iface->lock);
 	csg_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
-	csg_iface->input = iface_fw_to_cpu_addr(ptdev, csg_iface->control->input_va);
-	csg_iface->output = iface_fw_to_cpu_addr(ptdev, csg_iface->control->output_va);
+	csg_iface->input = iface_fw_to_cpu_addr(ptdev, csg_iface->control->input_va,
+						sizeof(*csg_iface->input));
+	csg_iface->output = iface_fw_to_cpu_addr(ptdev, csg_iface->control->output_va,
+						 sizeof(*csg_iface->output));
 
 	if (csg_iface->control->stream_num < MIN_CS_PER_CSG ||
 	    csg_iface->control->stream_num > MAX_CS_PER_CSG)
@@ -1015,8 +1025,10 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
 		return -EINVAL;
 	}
 
-	glb_iface->input = iface_fw_to_cpu_addr(ptdev, glb_iface->control->input_va);
-	glb_iface->output = iface_fw_to_cpu_addr(ptdev, glb_iface->control->output_va);
+	glb_iface->input = iface_fw_to_cpu_addr(ptdev, glb_iface->control->input_va,
+						sizeof(*glb_iface->input));
+	glb_iface->output = iface_fw_to_cpu_addr(ptdev, glb_iface->control->output_va,
+						 sizeof(*glb_iface->output));
 	if (!glb_iface->input || !glb_iface->output) {
 		drm_err(&ptdev->base, "Invalid global control interface input/output VA");
 		return -EINVAL;
-- 
2.43.0

