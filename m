Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B313B993A
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555745; cv=none; b=TpqY54fZuz4tnrNvmJbCJMIl1juihSv0suOPUvMWnUbDaXrb6rVk6QjUvpJb/KiixyM0hBajpZPLc/D9rNMkJWn6W13vmXo8r9GR9+jT1WWrpD0iJwZ39a0/xuux7Q3fDb3Z7xptWSPVHKHG2N9jlggUc/2OififWQFQr+mh5hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555745; c=relaxed/simple;
	bh=TPvDhOM/G5Ox46QDmSOEhQ2uaWLJXTIQ+1GgCbHDgFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5DEYphIEuvV0WxT9k6Y1FbPoWdcF6DZv84SSGweB1r2n0W2b2eYyaIkRlHdqpqm4QVfGQtDHsoP1nNNbMzO9Vzq0UlzxpK57yfpIt0TmcIaQtbFE/w7K4sOYkfTUM6MRbHzSd4lVpa//Iv3YpMm46FQpCxzffR8sXqfOKcst6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c6zh5CpV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6zh5CpV"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493f6de72faso26795685e9.0
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 06:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784555742; x=1785160542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N1G6MUTItawGdl9kT6xgYXezu1UMlR9b+KB/O0a8o3c=;
        b=c6zh5CpVmhXTdeWKAKtYaku1YQxQwwwnS2jpwoplNlZzcC4jdNAZAq2BcL2+EO5Kqb
         0B2g574bG8RAcbIBp5WmrfzgXBl2K8b+t3xjOGXMhFdxZLOeTaKSorLrnBwY900BzuT2
         WxY+fyG6RHI2lonUKq1KHAyn7Dw1O6PXq7OrrwUIE+s2PNoLFWrwFNkqLyij5FcEWSvZ
         Ki/8utMxikufCQTFUqbKkf3A30K5n7SIcxGEynolBkdRvselac+iLCn4W4y9/kbj+2uH
         gEsahZFfvjxHZseitPqu1kqxybZB1AoHRW13X1BA3oFCbm6pkE3eJdpnkEoZaJm4NaiD
         i70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784555742; x=1785160542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N1G6MUTItawGdl9kT6xgYXezu1UMlR9b+KB/O0a8o3c=;
        b=GoDxGNUQKJjNUfLKi0uidYWNIa5rnYrid7z7RUaJXMndcdbuBQ/C7pWhPkWo92a7K1
         mBBfBwpoGjHxhu0g/K9vUEWk8RH3AqYnF+o9L/h+4lCsq+uJLGug+KpwS7c/dAQxfZM9
         BOIImf8CNoTy0t6ufxwT8pMekfj/UfXMdc6R4Olbb6nIUsdA8QnxDsp6uLM/M9E/mNd/
         CUF6LKYQL1+YOWZaw+22Jq16D/HpSvbZ+zzQojk81bR/ueEHfU5x2ifV4zvI2ifnb2IU
         W4XyZqmpetddgJmL2QEYbJFUyp5k/mwVNMRdSyqSgjjevWlhmEFLO/ImC4Oku3sdZR5L
         W3xg==
X-Forwarded-Encrypted: i=1; AHgh+RpnPiBH7V03ZV7elK6hT098UeGjy0NPuxjxM74SNw8gDIVl+6gsnBjCPhlTS3eUcQ5sgHJ4ZqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzIWpK3qYfV7WvOzRwmm8pOYpzAjRRzqo9fLrd9iZGHEclnqFb
	lJlGwpfg87i3qsMin0crJXo4yCuv6RCUJAxiLmX1C+9iDzyDLrd67YTl
X-Gm-Gg: AfdE7ck6B3oeGIHzFoFVxdNbw48nUEGvQ9hAmg2+XUQA5EG5LGfl7aZqtCAwMDZ3BMj
	/le2+7pxDcSvU0zEvFMsgZZL3TfedYtCBZGJoV7/6TM0M3ug7g2Tpr40TFcuOgRm3j+CwjtMMrZ
	oIrkjDU3jHm2T4398tCC9vW0PRTX5BlReY3yWzGEMhynDFFz25qokQ/dIqnp7bEyAbigp7YY83I
	LVjOSL9m2ci1C3sGoKtld8sTCgybxFGlU/1EGWY1DEkqWG3fN9bYYwwTKDyDZant0e0ymvNl79Z
	7jhm/S9QmPaEFh4yYWPhJj9aVSpsKVfGH4PmY8k+vrL2SbqJih2JjPRvninEf0QeHDN/PnlwDCv
	95dbgT2XDWfRwQvzwKUKy7ND0HbzYnZoSgnFiTk2yUIVJExrqHS0GYEJrMEVuA2lYrnTRYxM4d5
	mZUN4RTYpMyCykKTglF8IPAAiVR2AYkHnjNUdh1Y7Wr1IILW5ccg==
X-Received: by 2002:a05:600c:6289:b0:493:b4a3:5ab0 with SMTP id 5b1f17b1804b1-4954a33dc26mr146084685e9.13.1784555741410;
        Mon, 20 Jul 2026 06:55:41 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:177b:1470:c99b:b6d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2b87c6sm512521655e9.7.2026.07.20.06.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 06:55:40 -0700 (PDT)
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
Subject: [PATCH] drm/panthor: snapshot firmware interface counts before loops
Date: Mon, 20 Jul 2026 15:55:18 +0200
Message-ID: <20260720135518.17927-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware exposes the global group count and per-group stream count in
the shared control interface. These values are validated before being used
as loop bounds, but the memory is shared with the MCU firmware and can be
changed after validation.

Read each count once with READ_ONCE() and use the validated snapshot as the
loop bound. This keeps the loop bounds consistent with the validation and
prevents the compiler from reloading a firmware-controlled count during
iteration.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index e2fcbd639c3c..6e6da98d795e 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -959,6 +959,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
 	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
 			   ((u64)csg_idx * glb_iface->control->group_stride);
+	u32 stream_num;
 	unsigned int i;
 
 	if (iface_offset > shared_section_sz ||
@@ -972,8 +973,8 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 	csg_iface->output = iface_fw_to_cpu_addr(ptdev, csg_iface->control->output_va,
 						 sizeof(*csg_iface->output));
 
-	if (csg_iface->control->stream_num < MIN_CS_PER_CSG ||
-	    csg_iface->control->stream_num > MAX_CS_PER_CSG)
+	stream_num = READ_ONCE(csg_iface->control->stream_num);
+	if (stream_num < MIN_CS_PER_CSG || stream_num > MAX_CS_PER_CSG)
 		return -EINVAL;
 
 	if (!csg_iface->input || !csg_iface->output) {
@@ -990,7 +991,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 		}
 	}
 
-	for (i = 0; i < csg_iface->control->stream_num; i++) {
+	for (i = 0; i < stream_num; i++) {
 		int ret = panthor_init_cs_iface(ptdev, csg_idx, i);
 
 		if (ret)
@@ -1015,6 +1016,7 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
 {
 	struct panthor_fw_global_iface *glb_iface = &ptdev->fw->iface.global;
 	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
+	u32 group_num;
 	unsigned int i;
 
 	if (!ptdev->fw->shared_section->mem->kmap)
@@ -1034,17 +1036,17 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
 		return -EINVAL;
 	}
 
-	if (glb_iface->control->group_num > MAX_CSGS ||
-	    glb_iface->control->group_num < MIN_CSGS) {
+	group_num = READ_ONCE(glb_iface->control->group_num);
+	if (group_num > MAX_CSGS || group_num < MIN_CSGS) {
 		drm_err(&ptdev->base, "Invalid number of control groups");
 		return -EINVAL;
 	}
 
-	for (i = 0; i < glb_iface->control->group_num; i++) {
+	for (i = 0; i < group_num; i++) {
 		int ret = panthor_init_csg_iface(ptdev, i);
 
 		if (ret)
 			return ret;
 	}
 
 	drm_info(&ptdev->base, "CSF FW using interface v%d.%d.%d, Features %#x Instrumentation features %#x",
-- 
2.43.0

