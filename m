Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB1A3B5E07
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555099; cv=none; b=L4NKj64aA7oKYhaktMTxAD8YB6G5t3bmnLuChkI0nVDI1NvHTl3xcoqoBOZtPicDhrOL1EOBspzkA90CLbJqyjxl8ShQjmyBK35IvgHVj/i99XmB1BCbmF0D8pqHs7st6rmW4N4Ix2eIQ/TQ6V04RX5hqHFFNDFZPugHqACiGIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555099; c=relaxed/simple;
	bh=SpXvCRsLS26PMst73oG6Sh2eYmkKAEv4+NoYGhVhDTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dM4/OMVZYCeSkgs6/4TMEmLME94NRO5iYW46gl/5EmM3SianPt918hcfLE7ICKCvcuT6EICjVkDHOVPcn8UOVVLfxbMa3jCI0s+/xewFr15qfPaeLKuLf2umGY99V8cIehYR+vknBt+mwjss4crHP8A6pgIKeqNJKI7wzsgWvN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c36+cW3l; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c36+cW3l"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so17658095e9.1
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784555095; x=1785159895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TZl1SyHTfE2VJ6SL46lxQ8jIIKDocPqnasYj5shzWDs=;
        b=c36+cW3lVvZ+aad0ymFUqU7jKYa6UgHu8orrjQUTozHjQCzXDYqjJRHdY/xp18t1he
         awm9c470jvkFZvClxUTDH0QK3BvzbQlB0W/L0YFmQidJPTjqVKDtnp0ka/tNW6dil4gd
         X4nematGC5WaukXtF2I6P2FzbU+9QJcbCe1b5oqNbcekOqFNX4gYoIoEHH1mhDC1NY38
         ON6d7PYIaohgqJtWeBSy/FAxG+fHRS2RSPbeYZYJMnll+iSLTbMuyPGtLLWnvI/o0NS9
         4k3ysqsLjfIf6tm011vfXHtB+BkzWx9uT000nKeYfDFqWSPzZ12ElfCSrDSVPZEKTpa1
         /0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784555095; x=1785159895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TZl1SyHTfE2VJ6SL46lxQ8jIIKDocPqnasYj5shzWDs=;
        b=ZiwGhcr45h/awfjoUj625ATMNVkuB1H0tm1R+CVl9j0jI0gx4ziPMNxWtoy+JDnu+y
         n1gNy6znh3BjChAyWrSsuxSrOuRNlwlbFBTg6lCDgrCYL/3abYLg09hu97S9oY4ycyle
         xfwqvTvHxj68ys6fi1dseC2MYWhVXbcSJgtXf8nCSumMzwZOdC6+AU2auKdQwVhxgrr8
         YHT/xn1upZjY4yOroUPMRXfhXk1ConAhMEIKBMceFOVK4oVy5aTXzUa/JeYI3AjW4pW6
         ntsKPG4VHgI4DV86foEPKqPAvQ9wZ+OrmNMQ8konCaVy0sGu2ne0Eu6lwxsYfIIx9QNy
         eYqA==
X-Forwarded-Encrypted: i=1; AHgh+RqPhkDDqQkqld6Iha+JSsfyvI36AtJFXvk6orFE7T3RbVvHyVcf+l7rqu+Sq6pdKGdl6Mzj5yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUF7Y20JJnw1zJD5kyIxhchMLzMf9/Tn2I9mBsOOAVTXIPDgei
	DmRK4S8i4VGO409IVQx1Ln9itf2rRu/C0fs/TX3DGzU5AlRf5Uza3kNk
X-Gm-Gg: AfdE7cklBbDqGzPUl74l5FLJ3HRGNvBEl2x6te+LMnTEewYw9MMrSUzcg2QQyLRkNu0
	3yGHrDXy5119yjvWyavXEZi5mckBM9sgw48U+Wfc+c6UZTf3VppA7AJRXnVQlEJHcP4t4Zf8nA2
	iRGKz/ZD5yvAzVWcu6fqiDki27nE/fWTGeYAVo61lk3GdFMvAI886KD+iFjRUtZT8ZUNx9b21El
	P2mvnEM6zP2KykkMVmFnsijH3N2Nhesn9NdOGQeskVpBp0UxFX9F+0UPv6K4VjbGzkJDDT8dVnt
	FdAuBWrNYzR6fjZZE6mB+TnfLLikNe2utxjFEmFCwTmgOe/bwsL0eRphamasqQupDJHI1wK6VBI
	BvMyQKU1QUd2Q70KA5ubRFWiAqz2BjbDH0nQ8tGNPD4gXy4GFSDsgGX9gyASOoZ5y0vtsuvOD0E
	tj4VOANmqPG9vCSyZaGI8SKgbx1W0wwPNsK6rSvYE=
X-Received: by 2002:a05:600c:3b1b:b0:495:443b:1bbb with SMTP id 5b1f17b1804b1-4954a50c473mr146050565e9.25.1784555094606;
        Mon, 20 Jul 2026 06:44:54 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:177b:1470:c99b:b6d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49549a3f07esm272678615e9.6.2026.07.20.06.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 06:44:53 -0700 (PDT)
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
Subject: [PATCH] drm/panthor: fix firmware control interface bounds checks
Date: Mon, 20 Jul 2026 15:44:35 +0200
Message-ID: <20260720134435.13377-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

panthor_init_cs_iface() and panthor_init_csg_iface() validate firmware
control interface offsets with 32-bit arithmetic and the size of the host
wrapper structures. The offsets are derived from firmware-provided strides,
so the arithmetic can wrap before the bounds check, and the host wrapper
size is not the size of the firmware control interface being mapped.

Use 64-bit arithmetic for the computed offsets and validate against the
actual firmware control interface structure sizes with subtraction-based
bounds checks. Also validate that the shared section is large enough for
the global control interface before using it.

Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index eee2bc7e8541..e2fcbd639c3c 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -897,15 +897,16 @@ static int panthor_init_cs_iface(struct panthor_device *ptdev,
 	struct panthor_fw_csg_iface *csg_iface = panthor_fw_get_csg_iface(ptdev, csg_idx);
 	struct panthor_fw_cs_iface *cs_iface = &ptdev->fw->iface.streams[csg_idx][cs_idx];
 	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
-	u32 iface_offset = CSF_GROUP_CONTROL_OFFSET +
-			   (csg_idx * glb_iface->control->group_stride) +
+	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
+			   ((u64)csg_idx * glb_iface->control->group_stride) +
 			   CSF_STREAM_CONTROL_OFFSET +
-			   (cs_idx * csg_iface->control->stream_stride);
+			   ((u64)cs_idx * csg_iface->control->stream_stride);
 	struct panthor_fw_cs_iface *first_cs_iface =
 		panthor_fw_get_cs_iface(ptdev, 0, 0);
 
-	if (iface_offset + sizeof(*cs_iface) >= shared_section_sz)
+	if (iface_offset > shared_section_sz ||
+	    sizeof(*cs_iface->control) > shared_section_sz - iface_offset)
 		return -EINVAL;
 
 	spin_lock_init(&cs_iface->lock);
 	cs_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
@@ -955,11 +956,13 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 	struct panthor_fw_csg_iface *csg_iface = &ptdev->fw->iface.groups[csg_idx];
 	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
-	u32 iface_offset = CSF_GROUP_CONTROL_OFFSET + (csg_idx * glb_iface->control->group_stride);
+	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
+			   ((u64)csg_idx * glb_iface->control->group_stride);
 	unsigned int i;
 
-	if (iface_offset + sizeof(*csg_iface) >= shared_section_sz)
+	if (iface_offset > shared_section_sz ||
+	    sizeof(*csg_iface->control) > shared_section_sz - iface_offset)
 		return -EINVAL;
 
 	spin_lock_init(&csg_iface->lock);
 	csg_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
@@ -1011,12 +1014,16 @@ static u32 panthor_get_instr_features(struct panthor_device *ptdev)
 static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
 {
 	struct panthor_fw_global_iface *glb_iface = &ptdev->fw->iface.global;
+	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
 	unsigned int i;
 
 	if (!ptdev->fw->shared_section->mem->kmap)
 		return -EINVAL;
 
+	if (sizeof(*glb_iface->control) > shared_section_sz)
+		return -EINVAL;
+
 	spin_lock_init(&glb_iface->lock);
 	glb_iface->control = ptdev->fw->shared_section->mem->kmap;
 
 	if (!glb_iface->control->version) {
-- 
2.43.0

