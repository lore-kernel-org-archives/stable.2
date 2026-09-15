Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431064A0151
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789471524; cv=none; b=GJg3UXAShM+CcnqPm/Q5oiuZyM1q/om1jFlobgMWaJVsNglwrIbpGkVNieOU2DJHx8LJpGc6kJkZQBqQKx2g+xQKC1iwf1yEm+CVZ6340WMVAVxPBe29hQNUFFSCA7fsQrwRzBt0+cuTCbWFv3cAZrRTJxJf+fkflg9gGn6gHyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789471524; c=relaxed/simple;
	bh=JciKneq+ovpdv8gqUDVuoYPtwcnhOaSHeZQ1sy8ZmKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Usa/4BDQwllsJYVlRLTQqU0fEDWFtPZlRTdlu3dWfKQHwp26srVLmOeh/1tWdh3TUi2K2b+eFtUjYw/ownoyt40HKJa58+98iZ+Ty5XW+lwxhPtbUDSH+qtCMaU8VdMDENo7mLW5wnGJ58DVjIBjWmlzWEz1bKQVfQOKlK5TB4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EK4hMLH4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EK4hMLH4"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2db710396ffso6915635ad.1
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789471521; x=1790076321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=B9svfT9glpJgkoC//MjvMoYEtW7Hx9VQdKaO91u+NqI=;
        b=EK4hMLH4cGnKtlrKDEkmEerJfGpwumN1S/S429PvkQJxJFfXtEVFo3RXbiib3faFx3
         V0PXSPlrhij+kWFxCSvNk+8qQacW59ziL7EMT3tN8O0ekPEO6W78svt4mXjgUu/2iSK0
         W5EHoNvx+RlxdVzU7nK5giM6av0ezYGayOitnbhUprkIeEvCx5BU7jhRBiq8WL33F+P7
         E8LsiBprmyDxKv7q2MfpJiQnCzIM1arKgsa09m0z3or5aMy0cDsHGbKGkyc0iH10GqR8
         yxNS+5XvRbIq+s0jLhqa6DooPjMXLmpdFj4jm6j+Tmg5x4KSWGhkK8KQauR6nNMdO+66
         oTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789471521; x=1790076321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B9svfT9glpJgkoC//MjvMoYEtW7Hx9VQdKaO91u+NqI=;
        b=ne3Bs99RTJcPGWJ3eK5Y4SNGAJcKHghv0j9qwRfxYWyFGYv1KcTXK5FXvNtAZuhtOp
         IkjtZEGgsa6VSxLu9CE+xf8uaf+kHOFIuGb3RB1ZUzTRZn+StOLp8yon5yE/FvVqd+8Y
         ICXM3+fAUxKxlGAxjjcwz9vpUVQ4t2T2mXcRgdGdPuErxxiuYPxE0D5G20kXnm7745ln
         QY6Hjy/JPKs9+jergexWNg+Ru2/Z9MeX4wdNUZx+y5j6voExHfcfSuaNhYNlG/+5VUcH
         qV2AohAQBzRx0wZq+O8QWFs35scvWHmYdUTik6GqtCFVdpvxdmEwzdmMvrunWSZd6wsP
         8sJA==
X-Forwarded-Encrypted: i=1; AKwUvBy1Y6UrxB6jz2SIb7MkryujkFKqagZ0RhXgXT7Ej/YDkgo2RmdcSYvN2843U7ASTUgasWSa26k=@vger.kernel.org
X-Gm-Message-State: AFuF++kjcdfHqtS+UQe9cwQdw9kvFbH5fWyYUCqCEYAHNVZmy1ePdlO4
	cPTvc26ERgVMeYx2l1+DYR1AP0H/dtD53ObcSA+Ma7HpoaXV0D1o8nDu
X-Gm-Gg: AYBFou2J3H/NtBG3HiMwDWhDWOzV5iZ7CCPJj9dOZfLEIHOjmHMVhy9nmT20ugd4TcG
	sljPrYzjKiT43NKfuqsETUCKPMk48DV2OLj8A5m4y4A6lVHWn5S0bsc07K/t/OuCVyp4V55OuTS
	g9RFcG+p3LWIlMYG1y/Dz2DPymPXYdDQQdxxGoQD0aT02sGBsxyoDcweD1ARAv6lVzIgR4Unvsu
	R7+zsOrN5F8kJaDlwGm32VCShG748HflB7nyVKArKpMdzYjEs3XHnceO2TowGk+qXlcELqnNWd4
	WPT2mwCg5EuEwRX6nLjU01QKn4ejxC/DEKr7nOEMHaZKOZ0+QVLxj0x/vkOcKUYvCeSmwJO0vEY
	Y1ncc+H+RQ/KLOVIIHlgubVMt3/siXbjF/tL3vpHotIBf5lDDoBLwjj61xD+HIA2XMUfL/6WjT4
	asc3OG+inNt+1x/18rYOqZpRmTPwxuSMiNitmXGSEj+oKLDiDUVZ7NxQ==
X-Received: by 2002:a17:902:db0c:b0:2bd:2c3a:2a36 with SMTP id d9443c01a7336-2dd763da77fmr44939985ad.0.1789471521158;
        Tue, 15 Sep 2026 04:25:21 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2d2565d2sm65391005ad.15.2026.09.15.04.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:25:20 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Eugen Hristev <ehristev@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: atmel-isi: release unregistered video device on remove
Date: Tue, 15 Sep 2026 19:25:10 +0800
Message-ID: <20260915112511.2397941-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atmel_isi_probe() allocates the video device before registering the
V4L2 async notifier. The video device is registered later from the
notifier complete callback once the remote subdevice has been bound.

The remove path relies on the notifier unbind callback to unregister
the video device. However, if the remote subdevice is never bound, or
the complete callback fails before video_register_device() succeeds,
the video device remains unregistered. In that case the unbind path
does not release the object allocated by video_device_alloc(), and the
remove path leaks it.

Only unregister the video device from the unbind callback when it has
actually been registered, and clear the driver pointer afterwards.
After unregistering and cleaning up the notifier, release the video
device directly if the pointer is still present. This covers devices
that were allocated but never registered while avoiding a second
release of successfully registered devices.

This issue was found by manual code inspection.

Fixes: d12c9088c0b2a ("[media] atmel-isi: remove dependency of the soc-camera framework")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/platform/atmel/atmel-isi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-isi.c b/drivers/media/platform/atmel/atmel-isi.c
index a05a744cbb75..6a7e240c5b18 100644
--- a/drivers/media/platform/atmel/atmel-isi.c
+++ b/drivers/media/platform/atmel/atmel-isi.c
@@ -1121,10 +1121,13 @@ static void isi_graph_notify_unbind(struct v4l2_async_notifier *notifier,
 {
 	struct atmel_isi *isi = notifier_to_isi(notifier);
 
+	if (!video_is_registered(isi->vdev))
+		return;
+
 	dev_dbg(isi->dev, "Removing %s\n", video_device_node_name(isi->vdev));
 
-	/* Checks internally if vdev have been init or not */
 	video_unregister_device(isi->vdev);
+	isi->vdev = NULL;
 }
 
 static int isi_graph_notify_bound(struct v4l2_async_notifier *notifier,
@@ -1323,6 +1326,8 @@ static void atmel_isi_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	v4l2_async_nf_unregister(&isi->notifier);
 	v4l2_async_nf_cleanup(&isi->notifier);
+	if (isi->vdev)
+		video_device_release(isi->vdev);
 	v4l2_device_unregister(&isi->v4l2_dev);
 }
 
-- 
2.43.0

