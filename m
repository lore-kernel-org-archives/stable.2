Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D2D2066DE
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789259392; cv=none; b=ImB558Vy2VYrbXI508SBY4lJCogJRJMnqGPXxCr44Kp1Qr3SoGb4T7izBm98RUdeFttmzvvD3KoP97eTI4/EzceGzV8XcOACrquD8g1chZx8Ui6mZe0U+8qBtG4QiUiByZSysebLyToP5VwGk+rabY1+xzodW4KLCg07nzdqN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789259392; c=relaxed/simple;
	bh=64GHYTg1r/dPubV34LDaud4uA/ldHinB73PiAAq6dL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QVtIZELZoVchbQAeGKbMefbsdGISdU3fNHLtTpmcJwg8Xzueq/VuJRXBTCNXZoPWkHC/X1IHxAm1Q5aoQ8u7IbfuxFWb1ykPrus0ZY3nwnkkw16EGFlvOwuHuReOPC2E0JSVqWCDWEOz/y8BLhKz3/2he3M3paceDPEtor5BR78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=K/eki52j; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="K/eki52j"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2051133a91.2
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 17:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789259390; x=1789864190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ScvzY1Zp8ZMCyDWV+7q9ZIbetTA7/SJK3fOR/Be6tok=;
        b=K/eki52jSQCCaMSD3UYg329lTYAcUrS4WzaaDIP5tJ3QMQYELAMphUE9XvP13BzS9+
         TaLjjnQh7O+KmufGtixa2NbnQEwkil8jx+GJAN0IkrhFI2hTE5mGQtD5rwJJljo7BJkx
         02+haKJcPPgIQUBAwLcqt+5X+Utm4bXQpco3OsNVNVFX1Ji+rRqTiCwuMtTfKFftGKPW
         gSG3Mbc7A6TvRNc21cQhqAAZDGCHQuNp5a1PgkrA7bjHg1c7pNAmvwI0iWHuvEj+G69E
         SAmdHmEjm1KX4WIhl+fdz4KIRGXb4ICYJ0uKKcclIAN+P6a74JlS4ppOnPVxJxCf/q+t
         F2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789259390; x=1789864190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ScvzY1Zp8ZMCyDWV+7q9ZIbetTA7/SJK3fOR/Be6tok=;
        b=ENf9F8XkMP5IwC/hF31wuOkCfFxH15Lks7Y7ekMAOvO6Wx+CFZcpLYKcQ5xKd5XiTk
         WihwGeGK+rlm/mnGr5T/PfoSAcLCK+JW/gaL47h5jqrYgeemvN5kYELUlNYTkDqRxG4M
         xrYBPQIP0DrAgFHSusYGr8voDTP7oMn1nHThncd6aCjFwAlYfv8LS2gF5ZeFogmO4zbM
         CR2Lwcoq61vNh0Eq+9KT33pxAu547t//iXm6uMGXP5/nKSLL7Ei+Qwg26Jh17ozZOSyd
         Qd2to8efdVflb4mM9h/s+k9Qb7RJJxZ1nWPTeVEIhKn8cN4AbArFhU4j31zFB3iwViIT
         tA7g==
X-Forwarded-Encrypted: i=1; AKwUvBxRzgMKJTnbf0qoSpmA4ofZU3RXi6O95x+f45XxH81vhzJRsoHfGOFf00OD6teJG/N8VwK4PLE=@vger.kernel.org
X-Gm-Message-State: AFuF++k0ou2IcdnyL9qfArsLRXwgwaPLd8WlyRZ+ykITjPHBn3xv/NUG
	ZjElzR03XYjVONdOyeY5d8gkGzwkR9XCR65Xff2cko4kLfkw39X8j7VKLDvMWUrNPg==
X-Gm-Gg: AYBFou0ggc5KL3PcErEkrL7xDuZPc1K/q9/+qKG6ZwIcLST3CCbMCwTAQFHV3ts4p6C
	XepFO0ZPRzS/5MKVKpY+a3yPvrDcRgkW1nDGuVaMbXx8PQKnTqnKFySBodj97F12WPQj68mhvxn
	jCh+GBng0wh63lhL+SM7IZgIvrmZ7dSLOatvyQWGZUFkHIhpXcgiA8ArRrm/Z4pxjNP2Fzhqld3
	25DzZvL9wcdJjdt73lgj1uDyJrF5ptZFmDuBlfvWzGI/ymHmIOd2GI6pJ+WIS8n2lTIDNBZPFGw
	270seeEz60dKdgbxc4W8Dnlq9frKM4/OCOdJhQ0vJNpz9N3hkj4pFUxITk+7H77dE1qfuIiWKAC
	tGPTChIMkfHjXMfGinuqWJYfpLgV9lyvEAy2GPNqTWBW1CsaqExes0OAvznt9WLaSx0K0XBQgwe
	agAvyO0szKFQrXSbawSWcyhh+Cx9dK89IjlvdDQSWEQ531CCBJo0MVh6qGCaHOqPKM39jJpgdzw
	UzrZXCshwyQmhESFMrBFrvC2fQ+TsceW/P5X+YBjFvrrZLkbz54yf9a
X-Received: by 2002:a17:90a:d64c:b0:392:6638:2e6a with SMTP id 98e67ed59e1d1-39d9c1d260amr18545118a91.13.1789259390011;
        Sat, 12 Sep 2026 17:29:50 -0700 (PDT)
Received: from xps.tailc0aff1.ts.net (149-169-99-5.nat.asu.edu. [149.169.99.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b78d59sm14899408c88.8.2026.09.12.17.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 17:29:49 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+9782320f78c23f40@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH] media: em28xx: reject audio endpoint with zero packet size
Date: Sat, 12 Sep 2026 17:29:45 -0700
Message-ID: <20260913002945.338569-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

em28xx_audio_urb_init() divides by the audio endpoint's wMaxPacketSize
without checking it, so a USB device that declares a zero-sized audio
endpoint divides by zero at probe time.

Reject a zero-sized audio endpoint like a missing one; the caller already
unwinds on a negative return.

  Oops: divide error: 0000 [#1] SMP NOPTI
  Workqueue: usb_hub_wq hub_event
  RIP: 0010:em28xx_audio_init (drivers/media/usb/em28xx/em28xx-audio.c:718)
  Call Trace:
   em28xx_init_extension (drivers/media/usb/em28xx/em28xx-core.c:1248)
   em28xx_init_dev.isra.0 (drivers/media/usb/em28xx/em28xx-cards.c:3887)
   em28xx_usb_probe (drivers/media/usb/em28xx/em28xx-cards.c:4258)
   usb_probe_interface (drivers/usb/core/driver.c:396)
   ...
   usb_set_configuration (drivers/usb/core/message.c:2268)
   usb_generic_driver_probe (drivers/usb/core/generic.c:250)
   usb_probe_device (drivers/usb/core/driver.c:291)
   ...
   usb_new_device (drivers/usb/core/hub.c:2703)
   hub_event (drivers/usb/core/hub.c:5961)
   process_one_work (kernel/workqueue.c:3322)
   worker_thread (kernel/workqueue.c:3486)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
  Kernel panic - not syncing: Fatal exception

Fixes: 1b3fd2d34266 ("[media] em28xx-audio: don't hardcode audio URB calculus")
Cc: stable@vger.kernel.org
Reported-by: co+9782320f78c23f40@bugs.sh
Closes: https://lore.kernel.org/all/51lCz4R7QyTUKbh4mhXNaNzX0evpk0siOzbh%40bugs.sh/
Assisted-by: Claude:claude-opus-5
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/media/usb/em28xx/em28xx-audio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/usb/em28xx/em28xx-audio.c b/drivers/media/usb/em28xx/em28xx-audio.c
index ccff6be5599e..7f0c5826ce5e 100644
--- a/drivers/media/usb/em28xx/em28xx-audio.c
+++ b/drivers/media/usb/em28xx/em28xx-audio.c
@@ -693,6 +693,13 @@ static int em28xx_audio_urb_init(struct em28xx *dev)
 	}
 
 	ep_size = em28xx_audio_ep_packet_size(udev, ep);
+	if (ep_size == 0) {
+		dev_err(&dev->intf->dev,
+			"Audio endpoint 0x%02x has a zero packet size\n",
+			EM28XX_EP_AUDIO);
+		return -ENODEV;
+	}
+
 	interval = 1 << (ep->bInterval - 1);
 
 	dev_info(&dev->intf->dev,
-- 
2.43.0

