Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C22481238
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 11:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470553; cv=none; b=BuZghefy25riaQDiD9LR16zVfoUjNwT4yBqzYdwCNnpWIZypxU9bXYxA5+Mr96At9StysNZy4LD8HHspXRjBSA1BRQahUoV4ey//IjQy9VSfE3tBvJLg/GgBsbhUwGb6ij9kL1FvpborvQCv8WjJjXcc5gtI2/AkS/IQbJXaXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470553; c=relaxed/simple;
	bh=f7bXHlhXsnOZ/6ZvQ+o+waq2nBAiEKG6Kg1glvRzHJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdV5BE/Ov9A0eMpmv3GugOvrAzaZNvu1bCs+UY9jVkF2irnYAdmwWUqJMmAbVb2xsOeIPM2IZ4M7JUCVA0lHOppEddgDNMbsjEmvWHNj/ou6SFsxZP4cGcj5OK7pk4LYxsjB1GmD+VEBnZSR229k+m210CUufJc+ozI7B05+ZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OrkxJ37w; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrkxJ37w"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso136753a91.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789470552; x=1790075352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lh7rYkhxlrvXjsZrQxcY6UVDt2QLiuI71BjvESmUG5o=;
        b=OrkxJ37wMz9fIg1tz/0DBTIANhZHPZLHXpyST2kvx9sdNMfTOOAfFhp8+3OH+XIkvM
         FBnY0oh9l43RNSs9c/UGqgNHZQeE4uYh74yd5E04JeI7J/pq7jEqPtzf2dNSFUCzTu5Z
         ITOaaRcEJD9q4WILe/m881OGOv3McvUCV9wJM8LK7ikd0Pvr0dihvi8HOMlBI+YHYrSO
         2qkLGK8EJNDyygBYwqje8G6I2qaV8+fg9ifQ2k92Yai6I4II1Wf7hmP97wukDDJV+Hrk
         0qhlS3967PbQikLtidKtpDHhwXrlGZD5dJO+CqjIjagH/8f31R3rVmq2dGL9Z61+OWNi
         H1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789470552; x=1790075352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lh7rYkhxlrvXjsZrQxcY6UVDt2QLiuI71BjvESmUG5o=;
        b=nA1Im6N9yow/8GvR+04lpRjKHu8b5cGvxSHFxpzHqO8246VcBNqJ3N1pv5rOldqXIx
         USXAQxceFYEnaSOxHW0nZeb30SeUisN0QDPzK3n/Ruh5c+mQp3D5J5gvcMV7AjyK5etQ
         +aaM3Q8kRIg/uirCt8IyVpktFoI0GDGUbX74iEg/y9k5sDGQ2wUvQHnxzrZmmGdPU+pM
         OoYhxXQP7apBjbWGDyLRSt+wyGHN+Rz6y98HU7tY+ijzqGqSLN6LXHGIWtcJSo6jp6pr
         nPEMlZV1FiP/I4hH+yFzstqQrEe4IeR09qX1cB/MiEqR0WiHuAFF9+PKHvNIc79M9lJf
         V/hQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvG7lodU1D+m6VGG7m9K8X467rqXrHw9RITTkuAmA+DjOplhAVII5J947onnNy1AtHFr8NT3Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lHB0YQovtFsyVAzaeWZ8K4+G549KgqWuShT+xewhclST4SqHpy
	agobqIFfkye/Neum2E2pjdoV5mcx3Xz1+J1zjVg77+3lyPM5nF2CcK+5
X-Gm-Gg: AYBFou10lHhbGCx4dFUoQLfnGQkpOQRU192SUlPFqBmy3E9l2dA/vBBHSuc2dRUhh5e
	K63BdlYB11X/J1Z5jYkFvkbOaQ3LwcrBNpzMJFeOV4wTtnX0dDUdawEmWgvSncLmcY938zs/4HJ
	UkIeESuwWtNdGWNepABKd+NgCWE7dQQVawhFraNxizGa2dTuSSiOofV/6O2g3h3BzRLjaQOOnCR
	PAaHQViVi6IYLDkzOzwM24FIQA7XmhuKIgkHCZzEsL+aLi/Lh5tDFKCHnl5I52KHesIUbkYqXMf
	zOazM5w/o4CX5RlFAiBKLjlo2MCvbr4W48EJEeWGwigp3QPyC2umfDyuUMQazehJ1HYFgnWg/Vx
	i6KwNGqCM+SEJbphxKQWjFoKU4/UZNgrbtHh3rl3AUh6dbDfxR72xSZeRaOFBFM/dEaDPed3rJE
	67C5y9Dx2SgMSc8maehsqKa5XbX6IaubXu8ilq9GHs8RNtEp9MxlECcQ==
X-Received: by 2002:a17:90b:4b05:b0:39d:f5b1:e365 with SMTP id 98e67ed59e1d1-39e110f66f8mr651424a91.25.1789470551569;
        Tue, 15 Sep 2026 04:09:11 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfda8bdf4sm4828687a91.12.2026.09.15.04.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:09:11 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: tw686x: fix V4L2 device lifetime on probe failure
Date: Tue, 15 Sep 2026 19:08:58 +0800
Message-ID: <20260915110858.2381610-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tw686x_video_init() registers the V4L2 device, which initializes its
reference count. Successfully registered video devices take additional
references to the V4L2 device as well.

The probe failure paths currently tear down the PCI resources and then
free the channel arrays and the tw686x device directly. This bypasses
the V4L2 device reference count and the tw686x_dev_release() callback.

If a video device still holds a reference, its eventual release will
drop a reference to the already freed V4L2 device. Even when no extra
references remain, directly freeing the device bypasses the lifetime
management established by v4l2_device_register().

After cleaning up the PCI resources, check whether the V4L2 device was
registered. If so, mark the hardware unavailable and drop the driver's
V4L2 device reference, letting tw686x_dev_release() free the backing
objects when the final reference is released. Keep the existing direct
free path for failures that occur before V4L2 device registration.

This issue was found by manual code inspection.

Fixes: 704a84ccdbf1 ("[media] media: Support Intersil/Techwell TW686x-based video capture cards")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/pci/tw686x/tw686x-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/pci/tw686x/tw686x-core.c b/drivers/media/pci/tw686x/tw686x-core.c
index 5a4ab329c06e..1e3079bb8bb4 100644
--- a/drivers/media/pci/tw686x/tw686x-core.c
+++ b/drivers/media/pci/tw686x/tw686x-core.c
@@ -241,6 +241,7 @@ static int tw686x_probe(struct pci_dev *pci_dev,
 			const struct pci_device_id *pci_id)
 {
 	struct tw686x_dev *dev;
+	unsigned long flags;
 	int err;
 
 	dev = kzalloc_obj(*dev);
@@ -352,6 +353,15 @@ static int tw686x_probe(struct pci_dev *pci_dev,
 	pci_release_regions(pci_dev);
 disable_pci:
 	pci_disable_device(pci_dev);
+	if (dev->v4l2_dev.dev) {
+		spin_lock_irqsave(&dev->lock, flags);
+		dev->pci_dev = NULL;
+		spin_unlock_irqrestore(&dev->lock, flags);
+
+		v4l2_device_put(&dev->v4l2_dev);
+		return err;
+	}
+
 free_audio:
 	kfree(dev->audio_channels);
 free_video:
-- 
2.43.0

