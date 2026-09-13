Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94B2DAFDE
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 07:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789285292; cv=none; b=Y3djwSm/Gsi9Emo2G55G4bmVV9gYYZWsqgXSJB+yaNGhZY2kG2tCQzdfZ8f2ffsLKjJ+oHWY0wMcnl8Wlx7GGCzwUN1UK7F7P8SaaJUoKYzZQoNJvSoIN19+YuRc5UgFtQ+kMRX0Gs8MAWGdWeB717abdgdRsTUNI/ZL38/6tU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789285292; c=relaxed/simple;
	bh=dKObZWAzCwT7mA1hQ7fnOlWSOMxImMUgzG7IZRqICwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxVzb0WparIc1jP9/dTtbOLeyi2jFi3j3H4eN8DkMGEOq0Uy2psolOq6jvKcMMCVERyu5FFqMEvFG55iZjeVFSI7EUc4RqOLU5/uJp3VeZdiaCgBESzUA0wAahy0X4nw8MTaZgOwcCA1xN2jg+oe36UxVExovNItDj9ms/lzNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxD/VEFM; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxD/VEFM"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398c066106cso804559a91.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 00:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789285291; x=1789890091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QGMxhoqEc5sqXnRI8fK9K0ab088f98eW85+fhaIuxJM=;
        b=KxD/VEFMXoITsH9HCnfqHGeHh50r4MRQB5w5myrHdKVbhyu+PNVJGdw356hnTuPc5a
         yU9VkAtaXRdYUg5ubjk0B8QeX9YReZw6ePIag3ykUinVpFQn7St7BmhlvG5JsrLJlGKj
         asVW9V9gUw+i23ozZmlvUYCzlu/mSt4aT8xER5Fv8rK/mjzphcDPWFdaQuJweuoRz52N
         lNpI2JbYZYxB+35OTKcbI+C57DDgZiiIZvg+K6I3tZu1LQNWJLcfDZv1+EiEa2ndqImy
         FxGjre31Gx5ITZLx/9PO/Alj3PJdgFJOMLFEVxFCF64ApVy7eE3ifz9MCmCpnD44xvIT
         XGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789285291; x=1789890091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QGMxhoqEc5sqXnRI8fK9K0ab088f98eW85+fhaIuxJM=;
        b=A6SU32gi36HOWIi3UmVWDecvwJJ8zS16qSYngck5zxQlQiuoiQCmbXL8QGOKNdD7m+
         wSMYbb/HhwWvvyk1gZuq7GDzsTLWH2Zd5z4822elZBPb2LewsEzwYDrItSCf8eNZSKXE
         6CAV+ztZJAQQXH9WqKWaJBjFiYbcTkPYOwpWz/cWgxOuSiaakVwI8EA28EU0gvgjzYS5
         yILSYMM0/rF+QlQc3OnTX9Msc0D7IubZuWeH4KIr+EPrugmgT7KROtVITT4Ea7zf5dFB
         0WOmNjFSKTAHSI7EzAboJxwHNQd+p1rjp5AZnfb2j9XAkMpI9SRuUdy2hGjnguQkjDj8
         A7AQ==
X-Forwarded-Encrypted: i=1; AKwUvByYi5Z+J667hDHrx0J0L5aGAtAwLc5EylMgx4RsDMlcJYNU7azNufY4WfTQA8wTB/eUhja0q7Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lH2HAtV63jJcRTQCoA6xVomT3SGS0Yb2MurM9iVASL768qcwMP
	xOMHkHkO3KILvmO4iRAvfdfInTQdBU08V3uHge+MsPbhhi0sVnIGSJvN
X-Gm-Gg: AYBFou2N0cy68cXknttia5AFjdg99N5oG27+0TdpbsxLjmwSkwPukGAXlHXCPUIBO08
	fUPQAmzVSfBVSMyi29sM7IooiJTjkAc6x9N03nX2CnJCI0c8MXuXrhyIm4j2bzN1AhOQkE4n70G
	Y7O8A9dAhmXyyFojct5iF5gRF9pNd9e8yxElvOXCZaJjKiGtO33TR8CanWFJY6a64IY93v0Eodj
	lOy3rEu99gH+VxXa4RUBD95/AoJr5qNaWv3MVBrMP3rQFrqHBAYzXWCa6InprhBu4A1CCzQhzVS
	RugNxqYwItFzDcquWPd/aOLtmiXhq3/yjv3NsZIS3rRbJ/1XpMT1/8+DxgIzhxdFtCeQ17ftkmL
	YsrTbJv8cgmiHcJgI64HaJTmMqWU7ewhj4+nZ4c95InPUjIFGSbLkk/upWXJtT8U10lDY+/WAHs
	jNlra9tzLgEAtmekvIXqtyBz92yELwfyjpjsW+VAvXrW0XVZjsnq21rQ==
X-Received: by 2002:a17:90b:4984:b0:398:ba56:b926 with SMTP id 98e67ed59e1d1-39d9c3968dcmr22793828a91.25.1789285290819;
        Sun, 13 Sep 2026 00:41:30 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d95092c06sm14395927a91.4.2026.09.13.00.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 00:41:30 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sam Ravnborg <sam@ravnborg.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/kmb: fix potential use-after-free on probe failure
Date: Sun, 13 Sep 2026 15:41:20 +0800
Message-ID: <20260913074120.1483518-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmb_irq_install() registers the LCD interrupt handler with the DRM
device as its dev_id. If drm_dev_register() subsequently fails, the
probe error path tears down polling but does not uninstall the IRQ.

The DRM device is allocated with devm_drm_dev_alloc(), so its initial
reference is automatically released by devres after probe returns an
error. The missing IRQ cleanup can therefore leave the registered
interrupt handler holding a pointer to the freed DRM device.

The failure sequence is:

  kmb_probe()                            IRQ context
  -----------                            -----------

  kmb_irq_install()
    request_irq(..., drm)
            |
            | success
            v
  drm_dev_register()
            |
            | fails
            v
  err_register
    drm_kms_helper_poll_fini()
            |
            | IRQ remains registered
            v
  probe returns error
            |
            v
  devres cleanup
    drm_dev_put()
            |
            v
  kmb / drm freed                       interrupt occurs
                                            |
                                            v
                                       kmb_isr(..., drm)
                                            |
                                            v
                                       handle_lcd_irq(drm)
                                            |
                                            v
                                      access freed object

A later interrupt can thus invoke kmb_isr() with a stale drm pointer
and result in a potential use-after-free.

Call kmb_irq_uninstall() after drm_dev_register() fails. This disables
the LCD interrupts and frees the IRQ before the devm-managed DRM device
can be released.

This issue was found by manual code inspection.

Fixes: 7f7b96a8a0a1 ("drm/kmb: Add support for KeemBay Display")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/kmb/kmb_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 7c2eb1152fc2..d8e2fc28ee9e 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -569,6 +569,7 @@ static int kmb_probe(struct platform_device *pdev)
 
  err_register:
 	drm_kms_helper_poll_fini(&kmb->drm);
+	kmb_irq_uninstall(&kmb->drm);
  err_irq:
 	pm_runtime_disable(kmb->drm.dev);
  err_free:
-- 
2.43.0

