Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066293E556B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 02:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789094490; cv=none; b=Q4t/fDN3IiO/yVCoxqU2m+ikb+xIzi8a+NZ5AEM4XGUyL+1QBBeOrYr8538JGNw/e3PMlna2Uki+JcLpc+Mr33dt3bFgCsllLFdG9J5fwXWnL8R6B609iIPI0MdUShXTm/tfU3hdOn+TiIYdF67HJQi5w9sKOV40PTGqoPymGXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789094490; c=relaxed/simple;
	bh=sjESdcS2EM2vEsLu6P8HDo2aEZEHCuRQIE8x3kwLsDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8wvi4Yns9vEhsk/+JLYz3xYaY5EdNHkLj0vywmAY0lGIGpJFNI9aJMxdwi6Ug54cqhCHAQvWdYyIPJ/fdSPmFTw/OrQwkkeCYJJsdD+Ps9pO42HFKhIT3xBbil8SwDX1PEWRpFEcYr3YEM+0e+wQm88FY4f8zez1lW51tvKZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SabW6JuD; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SabW6JuD"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb766bfd3so6002401cf.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789094488; x=1789699288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n4Dzp3Tnbb5RWA/Zbp2U4elxI7yc4utkRSfWOSPNhYE=;
        b=SabW6JuDlLPKDN/Xt74mRP4jkxEufO3CnqlqZAipa2FOJX26/jxgAYMrVlG1bzm9hh
         QWujq8GnP8VCQJ2IaA4euzIDezx4d8CyRtbWdWPInuluYGBe8NrU6WovzM6+RQ47lxXa
         OGu1LTYtqUF4dQmroCCktPVlMsVqnQIA0hrHIIQnFva5lH5LrPQVek6PMfTcFtnTTRxQ
         Pio0Qf3wj++uZ0XejeL4lutw43NdmBxCHMUt6qk1qMBiT0luiP+GVc4uuXWZJ2/A04lF
         Wlivq5FgDfhrN1DnNUDZDKkMFwZ4+13zCG2/OPWTvbBHgGuqYUil+s4b5hzthl2vPtpk
         uuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789094488; x=1789699288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n4Dzp3Tnbb5RWA/Zbp2U4elxI7yc4utkRSfWOSPNhYE=;
        b=U+QA/l0h6a2x+pma/5r9fyBayaYRjrvhfiGUWs8fcCth1EApt89jJOaqtkJWphrx4n
         x7NAkD909dfSAlxW8yk4VKmmdzVeSwEkDJDeE3X5qCtJPOApE7Pji2UlnFMmDizt5hTW
         mK2aoUVtXIsYfMs/O8dNKkTZpi4lGJ8vhajVKotAf8hkqSYsQhW2AuHFLNqnn/9EvULE
         JSgzYJwQk8osXDxgsHps21SfQaQ25uCsxDyVt8hrdHiykxKkS0gYOc4Qw9+fzat+EPTw
         s+UEHksZrFMvsURijXMrP5Jsw1PcFSvHNduoGUQwm16nh64jZEVqqHavW6bq4+GOWI+z
         +JGg==
X-Forwarded-Encrypted: i=1; AKwUvByaEkUnIw07uKIcu4XehNL3Ys3L+yUTVri9LNHyFfTIO1J+nUOWC/YEGDp4M2eXJ3gM3jDTIyU=@vger.kernel.org
X-Gm-Message-State: AFuF++kw3wrcUUWSY84u8dxZ/iodbWqnwEbaEIq9KW0Kc6oYhPVuZzHY
	4/cjHIrekoT9M1lQA7fFMlkT0qcfKdTQZTCnu0L+WDhgKk8guOHYDLKP
X-Gm-Gg: AYBFou3Ll/aUlgGqnbRx2GRISsEUcUngU9XzmDawyvDAARfci4a1zyJ8Krb+swT+UBO
	GBKdqcBEK75nrSEZ7IgCf19hfGglz9fAFb4bE0dxacQlNAm4xi/sHJ7SCZ0ghh/IxL9yMIqmj/m
	yvuUM9G+t9T/OQtxV0X0HeUcsomNlFc9DuJwD7pefKKIr++f+eYiFZGjng3T8c2PwW2d3ijEPoD
	m4BWTqvTV1yiXiWh3hXTWWiBCHyfrquXKcmbY4NiRvBNoM2olD96M0wEd79dRAV8hqCxQWBt8xq
	PKKOHUEqDkV5nR2tfj8c7n1ND9s4v1updq6h+WwkU+97IaQMTPVALhyeKz/sv0mnLfVlV9Iq1wv
	8Jeue+be8lxevgWBmPYl4iY7X5rPEoxrM73UL/mvBH+03wwJWg33YzLBfogIVPM866SIWVGqH07
	gHrye+Yr+NJr6+CpeT5rSBAUjKYOhWjms+BAtPhtFqC8ygPjxW7zgyMTCYTriEdegsOMVH3Ynr9
	R2C3ZO/bG063pQ9QQ==
X-Received: by 2002:a05:622a:5cf:b0:530:9ad1:2f75 with SMTP id d75a77b69052e-530c876eb9bmr36932711cf.42.1789094487939;
        Thu, 10 Sep 2026 19:41:27 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d89f9sm10651196d6.47.2026.09.10.19.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 19:41:27 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] Bluetooth: virtio_bt: Fix probe error cleanup
Date: Thu, 10 Sep 2026 22:41:24 -0400
Message-ID: <20260911024124.1527637-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once hci_register_dev() succeeds, the HCI device is published, a
registration reference is held, and power-on work is queued. If
virtbt_open_vdev() fails, the error path only drops the caller's
reference before deleting the virtqueues.

The registration reference keeps the HCI device and its callbacks alive.
Therefore, a later HCI send can dereference a freed virtqueue through
vbt->vqs.

Unregister the HCI device to withdraw it and drain its work before
resetting the virtio device, reclaiming queued buffers, and deleting the
virtqueues. Also, free vbt on every probe error path.

Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
Cc: stable@vger.kernel.org # 6.2+
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/bluetooth/virtio_bt.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index c20d54088c8c..8c55b538deef 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -315,12 +315,12 @@ static int virtbt_probe(struct virtio_device *vdev)
 
 	err = virtio_find_vqs(vdev, VIRTBT_NUM_VQS, vbt->vqs, vqs_info, NULL);
 	if (err)
-		return err;
+		goto err_free_vbt;
 
 	hdev = hci_alloc_dev();
 	if (!hdev) {
 		err = -ENOMEM;
-		goto failed;
+		goto err_del_vqs;
 	}
 
 	vbt->hdev = hdev;
@@ -390,20 +390,25 @@ static int virtbt_probe(struct virtio_device *vdev)
 	if (hci_register_dev(hdev) < 0) {
 		hci_free_dev(hdev);
 		err = -EBUSY;
-		goto failed;
+		goto err_del_vqs;
 	}
 
 	virtio_device_ready(vdev);
 	err = virtbt_open_vdev(vbt);
-	if (err)
-		goto open_failed;
+	if (err) {
+		hci_unregister_dev(hdev);
+		virtio_reset_device(vdev);
+		virtbt_close_vdev(vbt);
+		hci_free_dev(hdev);
+		goto err_del_vqs;
+	}
 
 	return 0;
 
-open_failed:
-	hci_free_dev(hdev);
-failed:
+err_del_vqs:
 	vdev->config->del_vqs(vdev);
+err_free_vbt:
+	kfree(vbt);
 	return err;
 }
 
-- 
2.43.0

