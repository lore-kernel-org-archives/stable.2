Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470843E00B8
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454184; cv=none; b=qMN2ps/nkejWUdybrBKPSj0RVPEd0avHZEWYAJNdBb8hY6Y5TAwnDIbt224O3znL2a7ppOTgid+SFxsKHZQ2FmMqzfkDpnT17aizSG8LEvKsgsJLFL29Kf7PqH9vjnnHAxXDY1VveOb8e5T6TJhPlWDwknu7gd9lvhVIA18+LlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454184; c=relaxed/simple;
	bh=L1WdMwl8r798AIHKgDuSol6Int7fl9w+oTVtJlotTiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oh5topZlRrlLXpDMHP4tgjr3HAwHGcJ+dz7T+ZUg9vSKJbUtq3CPKiBnpXxyGkRa07GmMWN76KcYiej8QxFYlwGCERTY8RbX5+UZUZcKJQaSdt69GWO6AaXn26W4yU9+zEN93WDZi77abmDfxhyD/tEpYgzHnCY9cDrUNqFRKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doJaCPMm; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doJaCPMm"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-487048857f6so2416162f8f.3
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 03:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791454181; x=1792058981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uEuJYz+pVbgCSCGaEVPneImA96kKSzfy+n11GiKnq8c=;
        b=doJaCPMmRZwHCVstBNfL7lSK1xCjnDgaNEveZotjPnQrA4kcQoXcrUs18njThKz9L0
         MxGFadUW6q5P6gCwrqzKL68JKEW4+X+uajvpfzVEv4BMYG50CFrKgOfA2IKCkNg/ItOB
         ULU6WgQnmET53ntDJZUR5lO5kt3PyDE8vMe5HnpnjleUpgBKWf77jnzCCDbTiWisL2Hp
         IY3Bw1ya1a5GkUZuDgHcGpR7LW/Uil1kfmRICLTeVI/6H7L78B1knatSJ3/I6qtGNfAw
         cSjAApIwqxLop9N6TU7Ypg07U5vYqAbufiFIpGOmS5IANTc+NIe0PNsUZaq2F646Qnwr
         e73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454181; x=1792058981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uEuJYz+pVbgCSCGaEVPneImA96kKSzfy+n11GiKnq8c=;
        b=oBgaVxYm6L8Toow5F4o3E2VUwKIQgns2E7nUCV04mHcN5VcJMQCtwoTcxq44Xhpdj6
         +Q4nnZFCTaRIsmgAVCvKIH3pAfmy3X5LffiI8L31eoMrKk0h5QHa5iBtDnPwrO3LQ/nC
         DGIVzxWR5S2vDfyMx9Tbvufevt6jBX27Mvk7K1EoWzT5fC+gDQ4WjvVTShqvOC1B4nOb
         oKH56I+sn35u3txUl9hPBqV9Z0EeIetUotz8M+kFfE2f3dE3ilW0xtZkfAhcEp/Ung7I
         N9h623WnSsS0hWVLo4Jk82ow+UgQ5aIXC886zsHBlKeXtCSRb/DdX5XdW50zNOqt6Zz0
         MXcQ==
X-Forwarded-Encrypted: i=1; AKwUvBxXU+8DWXgJuimVF8q69lG6g3mVK1gmX4BYRoEEsqwN+bMXQKwvnop/xuEXhaVgP4WlDthIyfA=@vger.kernel.org
X-Gm-Message-State: AFuF++kojtsC74h7aSo42AMv38mvwlJxtZBS7+q7Co9g2PfVBuVFHmRX
	UZU69n1c9kWSz3dPJMsX3IdJWr75CVeGfZUFS7tpbLtr7oLgSBn6GijUaEUoL+Ou
X-Gm-Gg: AYBFou0+qWrA9MYqTyb36Xq8kYhyU3yAs4ZC99lkhO5gf3j8tV6/wNVBK0KCeMP4GpZ
	LcRq1aHxLVBbr8PdvzwNAvHG4Bufg+if1wNVcSpV+I1tqsRhptxOnXlTwPOGEyCdIlWDi/hY+M/
	RGiVGXA/ePc2gqDWXw2qIH3FAKO+RNh4cXPYkhO15iZSxgwvZXYiYd8G0o83wXjo+6BjS7jNVtQ
	c0R3SOZwMcvXoO/fCJPjm/YGaCEtCaQE540J1v+WlZ9Ng5b7PXNwAjPk3ZEOL6xwzABZfthoScc
	7clLFntZoK9AYiL2XrRkumf5T7qMx57QP5JuDoa7j8XBON/N3nGTTiDuaRCXXiRMmZmJ70CIkeT
	Uk2cCG/X640dk5d+5Xv4d0a0hkOWXQGkzyQksycqrPZKj3C1WocvdTfpuUFXk47tP6VhOZHJ+5r
	1xIvdE/MRsbODBvDaQdTc+3hOAp/wlwJfqHIJbFgUIByNBfhAN3dzcOPalqA4lR8ykTbceGBuvZ
	00nkCV2SBQPDJd6zuHAHV5uSIkRC+32
X-Received: by 2002:a05:600c:524f:b0:49f:d6f0:6f24 with SMTP id 5b1f17b1804b1-4a1800d3d38mr84852165e9.2.1791454181336;
        Thu, 08 Oct 2026 03:09:41 -0700 (PDT)
Received: from osama ([2a02:908:182:d1a0:b456:28a3:bd59:abb6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843e3356sm52932505e9.14.2026.10.08.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:09:38 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Chia-I Wu <olvaffe@gmail.com>,
	Akash Goel <akash.goel@arm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/panthor: Fix TOCTOU race between GROUP_REGISTERED check and erase
Date: Thu,  8 Oct 2026 12:09:35 +0200
Message-ID: <20261008100935.3059587-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

panthor_group_destroy() checks the GROUP_REGISTERED mark and then calls
xa_erase() without holding the xarray lock across both. If the handle is
destroyed by another thread in between, and a concurrent GROUP_CREATE
reuses the freed ID, the first destroy erases and releases the new,
still-initializing group, leading to a use-after-free in
panthor_group_create().

Do the mark check and erase atomically under xa_lock().

Fixes: eec7e23d848d ("drm/panthor: Prevent potential UAF in group creation")
Assisted-by: Claude:claude-opus-5.5
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
- added Assisted-by tag, no code changes.
---
 drivers/gpu/drm/panthor/panthor_sched.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 0493858e55d7..a343c5180e01 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3770,12 +3770,18 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
 	struct panthor_group_pool *gpool = pfile->groups;
 	struct panthor_device *ptdev = pfile->ptdev;
 	struct panthor_scheduler *sched = ptdev->scheduler;
-	struct panthor_group *group;
+	struct panthor_group *group = NULL;
 
-	if (!xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
-		return -EINVAL;
+	/*
+	 * Check the mark and erase the entry atomically, so a concurrent
+	 * destroy + create can't make us erase a group that's still being
+	 * initialized and happens to reuse the same handle.
+	 */
+	xa_lock(&gpool->xa);
+	if (xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
+		group = __xa_erase(&gpool->xa, group_handle);
+	xa_unlock(&gpool->xa);
 
-	group = xa_erase(&gpool->xa, group_handle);
 	if (!group)
 		return -EINVAL;
 
-- 
2.53.0

