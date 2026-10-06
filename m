Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84668286D70
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309769; cv=none; b=Gdy22nzE6AB4S2pQNitGc4PUvlKSrEoqXHNJGS2+KvpN91NydXkmdd3+l91bR2EOwDRn8tZylzG2LA6ncEklM5aYOohjgIlCSOjAaEuRVeiGwnLZHOwKnwFgYfGPKdbPzGrAEnI2K4u9GMbSk4sAqptWfejW7fq0VTZePRWqKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309769; c=relaxed/simple;
	bh=OIgGuVTAETN+U8XK039wZARTMDtLKuBTKbKIh7hLRn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yu4DeM+Xmnr3Ttyfwy9ATcypeCZkE1T6qcql4K/Z/Ot9Vnlp971CAo5w0pWLMuK3Umo4rH416Yh8FTFqpGb0CtyAkBH8JL8IP5AZXuS5PNO9wg257VInmEfZ3brUT2bEUaPhra+oVRV9RNSdy1pQL40omPPHErqrj0xl4d6ehLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o1JK7KVp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1JK7KVp"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso1870435f8f.1
        for <stable@vger.kernel.org>; Tue, 06 Oct 2026 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791309766; x=1791914566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=51cqNJkvvQhB+knnY5xbu/9pUkd+scvU01KRl0tqVok=;
        b=o1JK7KVp3fun25ZTcc/7wfZaK3VROqbRwToyhaR3GQm+CklKfd8oguGOKlmM9VXGgJ
         UR0GAZT2nB2lMcbNUbryjZo1IxIjjiryU9tsAuhPz8XdefNJzCUEAV6ZZuqBUd54romP
         SItMFPlfi9ifSiUVsz2ehB0v+hGHklwWLwqsI5oV8HtQWarelDxXDY4jQYivvvrKDmyB
         blpqamZ0iJeIjV8Sl8oW5edqxUWzJQp6v84QWJjFpQLKu0+NqTkxw+DDGNJQMkT7cJav
         Shay4QUt7vqZsQi0HUBpHB9WIwc0eCungaEMNI0XfSGkXvr7gc642p7EvNeEHQ7YvPZE
         4I+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791309766; x=1791914566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=51cqNJkvvQhB+knnY5xbu/9pUkd+scvU01KRl0tqVok=;
        b=lZJRk3vfc8jryMtGWnWujXlGm9PIv901jJkeHI7v4WQcC8UrlVT5DsvxQyKgfmYqTU
         ZilKI53P5yn8tw12YnFvrpBq8SCpQX0vJwLJCe5QPuk6q7lIT/hL429in6enfiCMw8vv
         Jwapy5sQkByOrdNLIsJGcb5JFHTdiHKrD1oml44yw0ol8FM5X4EvcjspyeekM0lBV5uZ
         M1ZCJDhvo6U4CBQ/TaJ91/dKZ2LYH9Kug3VG6o/ynvIIMz3GkP+hFEuof/Uwmc+Zzu2+
         g1uq4O19HjBtazERvG/in8zxEWmWbUMLYX/QkdTT7V61AN1le2ThiqwPZl0hqOmhZB85
         86pQ==
X-Forwarded-Encrypted: i=1; AKwUvBw90aeIOI/KhxXZd3W36y8rLRBEpDyv7uOQeb/HloOfO8cgOvTDdk7jP4jq7m8r77BwU4AuahE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKx2Alx5NmjAzs+zQD/9bhmC2nJNVusrY/RS+IcumxPyhqmMZY4
	h48vw9oPESnh2CAfOloTmbqlqjpugIs3Gv+OmyEGzZuTnOudN6GDoqy6i+JCjQ==
X-Gm-Gg: AYBFou1badoIqCdftwjKWSiChsH3JtcvJJ2uu4PL6rNzTsP75E/9Mnsg7MpM7aoBHb4
	c5bIrI8R2XnCshZX37L7DDz1lkaMhffR3UCx9ovleCfVSRQzIAAvWbVe+HHtpl2ZY2LHx9uhOtv
	ZNDT9+KK7+4ZrLZyxELglxs0P31ONsYKx+0gS5Yq1D8/uemcWScoS4fYSQkwDD7JYxwnoRF5ebQ
	bUBdJgJlG8iotnj9/nOqk5ZfFgRiZU3mYs06E97j8kqRsfy86u/vLdDWTmttpZU+4EZoJZ8d5Xw
	fE6us09wEeiEOsEP66UAKKHcOuBf6vzFpiP2o215oAAkOuUdayzHTToBMSE7oZOYkBlsRZfAi5H
	6/fHg95bFRTnD/7IyAGFonD1E3uwpG10IE1XcLb8Sk/al3t2OjzuN4Czx7oUVlYEKsWhRL+/J9O
	NWT1EXcONXKgHZ/5dRws7JxHXuJdxBg+C8gd/mU0iLbhQ0egWXpYlPcLwZAXRxBhC/eTZalga+m
	sMF33zgzcxJwVXCWu3zSyuKNP7Imabtg7lW/9BlxTLYdsJDsNKIYEQWKwctgUolCY4wTsSQFYAs
	MGZWubsUcnQ/V20ux35GxRjMRBR3jaCfIsqn/RuHR7VwwwwBdaXdUh2LzA1hrXyXfS59R4DiLAI
	Z0zhbWTnIQSHw04Qgux3D8ex2btLI40KqJUBNsO/z0bexTSdZMPCSd2Cx5poPF8BV8bc3rvWGyY
	U6XPaRS1SK/JwXvkc=
X-Received: by 2002:a05:6000:4308:b0:488:6561:b324 with SMTP id ffacd0b85a97d-48c727878e3mr401700f8f.9.1791309765476;
        Tue, 06 Oct 2026 11:02:45 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:41ef:ba36:bd76:1e3c:1e5:c273])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1f3f7sm813630f8f.32.2026.10.06.11.02.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 11:02:45 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	Xiaogang Chen <xiaogang.chen@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] drm/amdkfd: teardown processes before freeing kfd.dev on surprise removal
Date: Tue,  6 Oct 2026 20:02:40 +0200
Message-ID: <20261006180242.52809-2-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261006180242.52809-1-olivier.kaloudoff@gmail.com>
References: <20261006180242.52809-1-olivier.kaloudoff@gmail.com>
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

