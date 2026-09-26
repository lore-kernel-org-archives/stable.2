Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958D49D5A8
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790454048; cv=none; b=MuuBGBr5+t4JiEhYSIEwqhwiVyvs58fTZaDPIE6HA7VKV4km6KXQKM/SAPaaHwlbDaND43Ev1YUYQgbFkSHpry/8m9cGrr2KbTPBYki9x3RHxtCWxYAr66gNbIG4SzGXbe9Cn86ZFtojeic0XT/SgVeiR0e7SQPxEKS24SPEz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790454048; c=relaxed/simple;
	bh=TeA4rzx3tIqodbILhjQ27AMr7aKkw2UurfV3eDfJVl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=el183AjGdbnYASBr5XwhApOQasltdqwOyBMm+xgOJrQAVOYskonz/U1DFvzp+rYY/20u+nrpqc6VnAIKAqOg8noKM03MAuejrR2YbUgQqT+PURSvuWt258XCvY5RbQ/rnbIQXWrp0FLdhy/43FDWe695ok6T9gtYF5QG5xJ7vMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4C9Ye8v; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4C9Ye8v"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-53320dc09f3so8840151cf.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790454046; x=1791058846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1yMSXbv0RzpnT7LQIOAfBfWiKfyiEPbJB+JqeZgxSJQ=;
        b=B4C9Ye8vDV0EFsr3oKHAyHI/kH/795eJXULV6vT3OFXuif5LrmDFJ2MYGsg7JXT4uT
         ufJt4GlDu/P+DI6O4ptzoISLqHmP4k13q8/+xaH2/oq06MPe+304AwYH+9JSpIHukkrj
         msYhQ6rZYWa8HlPg8jofzEwYIisYXyzCD2dHDLQZe0M9XIuso7NblssbQdhBIXM3Gumb
         zxSj4v98NHWT3y4NhbeheZ3ZQkPxXLVeGoro3sIOMV3IjoK9NUsjOd0lS6Yv7yEFMpXa
         XVrq1faiFZeIj0VRrlETekFJrbaoCjUf0ueeUmifrAZ8aECYbb87fbG9m3nA9rsgHvDj
         I89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790454046; x=1791058846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1yMSXbv0RzpnT7LQIOAfBfWiKfyiEPbJB+JqeZgxSJQ=;
        b=T1xKytDMj+kJAwH25CYbqsNJXO7Mrk7O0qN7pHYBXW4Zt+ukufNdg/5GFKuNA1TZYv
         kYvafs5w8915dFFHCjt19DQVmAvUJzDhZLaLOgBJZdWEkSAnN9l2QqxRbe+qkU5FKfmi
         j4rMNJuqvdhFXn9Vw+seVQPb52IcXzeUl8o5axkWkuweSet5QQkNo68B/q1P0+7wYKg8
         uxXZpWshogjuHa8LTXKuFCBRqk24H1Ko8FjikJhHdDp34/SeO+EFH0uYnChAMKchRV5H
         WnOHGVzJjuNziz8/iZu8A0MvXUhbY5GveqkV2jbCr7PyJEFYswPDKRFppoSJ2u0zVpav
         j0yA==
X-Forwarded-Encrypted: i=1; AKwUvByhKyD2VWQHRLcAkaIjtMeoeHwe9SoVBH5XZSuxGWl5w2PdD9I7RzrJTUtFNbB/ax4vUbBc8uc=@vger.kernel.org
X-Gm-Message-State: AFuF++kaXIJE9xc80NBTA2Au4qsokRwB9s6JeTp3jaaBOR+H3kppekG8
	C+GYfofiRGTUnDn4E/xc1A6vO6r5REXGWZTL5kC9QufR0tCYCe+WMEAo
X-Gm-Gg: AYBFou2kZx/l/j6uTeD9jDC8yDrGMnxreglQXfLfMJ9eoewhgvnIi14dkhqYbIG3niE
	g2bGrkh1nppgmjCPOEEQk8Q8rw7gdk9IXIOmCwg0PyQRgsL2uUj/8I5kWiePHLluaP5T6fzRUfg
	K6K9QzCZHpIjpsL5Oig63UX2bxwAeBrpRRWFOOUsB38bCLmsBbFvZMFq51usYbEtG21CHUA5gBY
	JzwIRrFmiNGoMFtz7mMH9cKHCQ3MPz9S68/BcLBTn5zLFFekLZ9oHJJmgs+V6eVUJQ967h44NsQ
	LTwd/PBJDCPXzEOty6ZInIj/AcS56YIN7pui57xaEq8jyuagpCbb5EfnFjCoUaK9JH/ghQthKnx
	ALmF/kTmzreT6Z1yFlwopXZ6LRuXiAvOYsI03hfd3MES2OHRe3/zDtDxKlV11pb+OVvV2Xj31PU
	nCZtTvA1RFL25mMoJ3MQnFhQeNsv794n9LMdteRFj0YDdDZFav+6/fPeY71880isgDjZmPxMcPG
	C0iWSxSlf3eRRo+6FBiJA==
X-Received: by 2002:a05:622a:15c4:b0:530:178a:9dd8 with SMTP id d75a77b69052e-5330b556ae7mr122052901cf.8.1790454046528;
        Sat, 26 Sep 2026 13:20:46 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5332238c585sm25325811cf.20.2026.09.26.13.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 13:20:46 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Dongwon Kim <dongwon.kim@intel.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] drm/virtio: Reset device before deleting virtqueues on freeze
Date: Sat, 26 Sep 2026 16:20:27 -0400
Message-ID: <20260926202040.1313385-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtgpu_freeze() waits for the control and cursor queues to drain and
then deletes the virtqueues, but nothing tells the device to stop first.
del_vqs() frees the vring backing, but does not provide a generic device
quiesce operation. In particular, modern virtio-pci keeps enabled queues
active until the device is reset, so the device is left DRIVER_OK with
its queues pointing at memory that has been freed and may be reused while
the guest is suspended. virtio_device_restore() only resets the device
later, on resume.

Reset the device before deleting the virtqueues, the way
virtio_gpu_deinit() already does on removal.

Fixes: cad6a879a7fb ("drm/virtio: Freeze and restore hooks to support suspend and resume")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 2aaa7cb08085..52c174f9bff7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -225,6 +225,7 @@ static int virtgpu_freeze(struct virtio_device *vdev)
 		goto err_resume;
 	}
 
+	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 
 	return 0;
-- 
2.43.0

