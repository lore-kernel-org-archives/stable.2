Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623FB1A9B46
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396555; cv=none; b=RDPJuh828sBmgBLiCjcOElzqWVQodn6cJ2XCZkJdfSl9mvRgAGqBQcDWntyKcGy5DSOZh/UC48J6RflgH7BNWl4fabumkWG2NEsqAHJLflMnCcjvqo+in7OlOqtS1Q1WjKQ1lT9yEctwg2W6o65qwJDcSX5px2kHHi5MYKckZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396555; c=relaxed/simple;
	bh=Hw3/8nApHx3oWdMHX6ZoJa8miPwfFOJx9xFlroLT4CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmghfxlUhy01HWJLK248S6XkWP62oQCb3LlxVIj0E78jfsENlxNS4nXGssR5mOrxsK08l6etYZcqe36Oo0t43pmM5wa81WHv+LC5iGYXxXYA8mSPVQVjRWh8iUSJyx0qrC8N8e+Xrhwg1cy0onZC/7hXqCxcRMdGkXebtKZsogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIgLiKI0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIgLiKI0"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso43085915e9.3
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791396552; x=1792001352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+j2FYA42KZ8gXbeBKkIoF/p8AOJkD/LCcWergyht8w4=;
        b=SIgLiKI0X65xm/FX6viZ/+z7n3QAn3aQvGfOZ1lP4U3inDWWnTkkdunA0KLNYcfNgb
         ry7jMpdmLYYqtHOy4FinVF+JdDCH3C4CHZx1ADFU/bVJLCKSsdkYZGP60H6YxptnuaLT
         frvt5gv0AXeem+iq2EqLombHgLzoePjrYQw8d2JHDUUy8tA81BlgiXxzvFYG/6ICzJ/8
         nsKEpUmP9NTxfDBZ9QXGuq7qPRwYfRNgGO2Ys9SThXmsbE5SlK8/q9YJWfULydPmNLac
         4hUwLuNVYK6iPs34sgsXBoCTsJwxBF8uqXbsV40n/rjJt/c4B/IYxZkoMcLDzMmEv7Gp
         3a+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791396552; x=1792001352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+j2FYA42KZ8gXbeBKkIoF/p8AOJkD/LCcWergyht8w4=;
        b=OSH8t4yCzKlL6+tx/3IK2wEUVLDiJ1R63/dKB/8gDmaPT+crJlbybHWJd3RVLtbR+w
         kpYBgsXa+XZ5yOrqJKq4OcsVyCQweQRYKIpBVamcOeJNU9HLHHAvNYkODjmeUKCp7J4q
         7Xd5ahsB+W+V3XMip2oq+a35bNg0Lld0+Yo5170565Y+VEsCGpbHJx1MN6+3MDQIm98G
         jWq6OQb04jQ8hHJP4RQrkHQwPLEai3Oet+of1K8gByLYuUkZHaSK+jPOaWHS/JmrkoHc
         4jWxtMh/dXP3poXV0no4ATF3pg3YSrbSFQYx6dkXPSrVC3pkaIF6madR5SRaY7CTIt9I
         DHcg==
X-Forwarded-Encrypted: i=1; AKwUvByQieNLk4il3rV8DDmFj2mdrRIze8kkG9cuzTKc35gGMwRmBvK2sLW4KBWxITSqpvvrTfdJ0Pg=@vger.kernel.org
X-Gm-Message-State: AFuF++nDhp/jPmwV9/Mf9crtgb7Lwjo1viH5Xt8P7KNlxbxPUbJIdviw
	6U/wrW9XE+GTU2sKXVxvbs71dXmZbHuj/81+2F9xpsf5JNFatI/Bjx6v
X-Gm-Gg: AYBFou3MTpYo+eTBlVOc5kQkI0rg8rLNR5IJKMHKsRF30O353eO13VJt/vD/rSi7+MD
	ZpVsRu6VHMikpx+t9OZTy3hrqMRPM8KQ0wTAIB4sNex9c/tKN9QJzI/TXsPqKlslOKVD5Z2Lk6Y
	lk9U98PlhQfibciM870+4KTuGt2ZVj+kGm+9oSUOfwaFUVLL9qu3an1UoWW1+rsgQPZmQcpqTkJ
	/FEZSDjuqQfPSsuW1AOPDkHVEIs8rQoaTWJ7hW68P9GRMSdG79fbvHU0gum2FA4vAoX3HYsrcXB
	a1wLtAR37szZeN5GUKqgAy3qou49p6EmU5Q7uhpydFP6sGv9Ho3HTcSDZqYrt5XRmO8gd6XwuYl
	scVCf5VGrjUnO2Ic5/kvWVqSFroVy0UyQFiSipJj4Wb9x8IHaZ83LYCAJP+YesbhIL58BjsDgo6
	z+7IBr03FA/38wkl/x246HGThuEL2Kd6ZzQGcNFhKBaIfNdrcX0fy0sO5lG7CoVA7maxPSVcvp3
	GwFZ/uOPOpDM4hOGGb8hZLDQZwsR4EEd5Avbivi5UVTKlsAkHyYcI7mcRnmGOWitkDXWe/9DiLj
	fjGxV2MndQvjQ3x3wEawtWApsfX68h0tO9pVVUgxNBfwBwnSH6ZcAsHt+DbubtARS4oD0/pgxUg
	lChBWniuQO+Ndr9K2NiG06uJI24ZVrFNl4HdBfbFbbnlfWKB6trINRlPuxGcQox469ChggxMtLN
	MmgJIpVuJ5i/CCngk=
X-Received: by 2002:a05:600c:3b98:b0:499:79b9:e220 with SMTP id 5b1f17b1804b1-4a180422c02mr53420365e9.10.1791396552352;
        Wed, 07 Oct 2026 11:09:12 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:413e:676b:9d85:c07d:dc5e:c7c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a181aeaea2sm59416855e9.5.2026.10.07.11.09.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Oct 2026 11:09:12 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: xiaogang.chen@amd.com,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com,
	Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/3] drm/amdkfd: teardown processes before freeing kfd.dev on surprise removal
Date: Wed,  7 Oct 2026 20:09:07 +0200
Message-ID: <20261007180909.34013-2-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261007180909.34013-1-olivier.kaloudoff@gmail.com>
References: <20261007180909.34013-1-olivier.kaloudoff@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On surprise removal the PCI core runs amdgpu_device_fini_hw(), which
calls amdgpu_amdkfd_device_fini_sw() as soon as pci_dev_is_disconnected()
is set. That frees kfd.dev - including the kfd_processes_count it
embeds - before amdgpu_amdkfd_teardown_processes() in
amdgpu_device_ip_fini_early() ever runs. The unconditional
adev->kfd.dev->kfd_processes_count dereference in the wait loop then
crashes the pciehp removal thread (observed as a +0x1b4 NULL deref on
MI50 Thunderbolt unplug).

Move the process teardown ahead of the early fini_sw() on the
disconnected path so that terminate events are sent and the drain wait
runs while kfd.dev is still valid. Keep a NULL guard in
kgd2kfd_teardown_processes() for the second invocation from
ip_fini_early, where kfd.dev is already NULL.

The wait itself stays unbounded: returning while processes still
reference kfd.dev would just trade the NULL deref for a deferred
use-after-free in kfd_process_remove_pdd() when it decrements
kfd_processes_count on freed memory.

Fixes: 28695ca09d32 ("drm/amd: Clean up kfd node on surprise disconnect")
Fixes: d12d05c4bc4c ("drm/amdkfd: Check if there are kfd porcesses using adev by kfd_processes_count")
Cc: Xiaogang Chen <xiaogang.chen@amd.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
---
Changes in v4: unchanged.

Changes in v3:
- drop the 30s bound; the drain wait is unbounded again (CK)
- run teardown before the early fini_sw() on the disconnected path so
  the wait actually observes kfd_processes_count while kfd.dev is
  still valid; NULL guard kept for the second invocation from
  ip_fini_early
- v1 took a bounded-wait approach; v2 of this patch was never posted
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 9 ++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9269e78..bd9d73a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4315,8 +4315,11 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 	 * before ip_fini_early to prevent kfd locking refcount issues by calling
 	 * amdgpu_amdkfd_suspend()
 	 */
-	if (pci_dev_is_disconnected(adev->pdev))
+	if (pci_dev_is_disconnected(adev->pdev)) {
+		/* Drain KFD processes while kfd.dev is still valid */
+		amdgpu_amdkfd_teardown_processes(adev);
 		amdgpu_amdkfd_device_fini_sw(adev);
+	}
 
 	amdgpu_coredump_fini(adev);
 	amdgpu_device_ip_fini_early(adev);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 586e640..43029b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1801,7 +1801,14 @@ void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
 
 	mutex_unlock(&kfd_processes_mutex);
 
-	/* wait all kfd processes use adev terminate */
+	/* kfd.dev may already be freed on surprise removal */
+	if (!adev->kfd.dev)
+		return;
+
+	/*
+	 * Wait for all KFD processes using adev to terminate. Must be
+	 * unbounded: device state is freed once they are gone.
+	 */
 	while (!!atomic_read(&adev->kfd.dev->kfd_processes_count))
 		cond_resched();
 }
-- 
2.47.3

