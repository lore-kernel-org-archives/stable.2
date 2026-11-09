Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217363;
	b=eKwdw5k9SrdTHaeNu6CU8Sx/bb/spPHPzKAHRteu9rcJaTVzBETEmJQxI3m0GP6sEk+k
	 MssRcYoPdc9lZvRFrGRC/2uNZx1qKdB4pgMI57WyGVh4Vl8MFCJDP8nx1eSzhT9OVoe/S
	 Pm9sDiw5yLk/aLSSpr6ZFdjw3ptUmUAHGMkOWy0iTqmCdqcbgu/EewKqjt2owRJ8HGPTn
	 +0jvK90dJZarGQHtChSFh1JZ09WFv4zDSbLuPwzHB9mLhHqA83A0f4wkKaMVQsI0A8SYt
	 j0QlyNKDTapZzJq9mLaarF+bLXkU+Tf3FOUvOSuLgoo4IDn0UZRPmXO6GvlSgTlbCkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fCkUpamE4D7/4z9TCaoq44cZ8/iOtncWCDcLfia3x7Y=;
	b=kyx1hvajsvTlwyL/C+5ARqqCYNVMEJAYKZ99KAFz71UhDUHBC6GS+B3rGE3VsFyFrTyX
	 mOTusNkEZweV2jc6HZ9qKBc6ByjquzRDh1v7Q7ZWSN5H5I4oZ6IrkVoDS7ZUowkfaIDNG
	 2bXU+3SGAauk6R07W1ntuD+Q2HHDV8/zy938OJ56SIot721VAYKO4OQC1/SIMzW9+cDCH
	 73Ybu2jNWbfhLZPizYcotLn0IfijC77bMLg5Psoef4D7SlHTttzUD0grqnQ/Inx6DIQ7V
	 1D+CQpV0TyeT04FGxShz+xJjZfFfVXwZHjTGsmvdNTMkKGJUuCrWr/7hr3xZNRXgZ5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dBCyq1hh;
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881B606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B881B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dBCyq1hh
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso781629e87.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 01:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794217361; x=1794822161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fCkUpamE4D7/4z9TCaoq44cZ8/iOtncWCDcLfia3x7Y=;
        b=dBCyq1hhomZE/74HffaWMTc+JpK35mfi57I2cdDXPuImuuSQxbgPZJ9Xp0XObIHlnU
         5NnPvzXdewQBJdGFf5Q1skcJiAGZQVcqqEUZXH9h+esSTbUol8RKFAb1ZbYvI86KcPbi
         5Nmhgx918OseqN4o+Yb4A2DWZEIkpL7Xd73Co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217361; x=1794822161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fCkUpamE4D7/4z9TCaoq44cZ8/iOtncWCDcLfia3x7Y=;
        b=jpsmz71KmZ2MZH7h/a3wOzr20EJHqq9Ax8KJ/NFzwjwStRZxCAdZJpf/1YR5BNB8Iw
         xal/cLjcKJtOWvyxIUgJmAy3zs6BdyIL/gni/xKL/FMQnmtbR9cfDrQWUCMN85otTCLZ
         mgcKEbaD27UktfUwQZNRswYNZh7VwrZ1gJLajjY3TPS8Wk9TODM0OAh/2LwEO9h1PTg3
         s1bTg94EMi53rEq9aHQPhRCDjyI18DiitWR3qFprfx+zVnJPzGUkOlYTzwTi5hSMDq2r
         C1h0cXrch0/F/zcr8P8R7LMQ4e1SSqGKD/ZjMZli4v5I7Snl26k4tGEaGk93PAaRDQA8
         LJMw==
X-Gm-Message-State: APuU4Z9pC5GKde3ZozVXqh0TaZf+oqsRz448dXOr2z14Nh2+v+GV4esl
	0xGdxkSJTydOF9N3OtXNcWQe/xlwZ3Lk7aurpdHEM/NTcKHPZ2SvI5Vuuo1bYubKAy0TYP3fINX
	RriJJ+AHB
X-Gm-Gg: AYBFou2Mqoa+w78raaUlnzitQ7BKA4Dc+YbTmS15wtYwh0Lz1F5OkVPtSS2SsuoVJlD
	1O1vKqdPFonmg76YTAZbN6lLCfy00hmNORYd/HY4bTxv0JgC1WLkax3kQCm2v5lDM8M3EllDwVS
	dOk8ADKjUP3e4kXMGjyY0bP+cs4Br6tZRM9YYOSJSbx7hvxGa4/WYXfbPccoUVlynOrtYTIaUYz
	73sERzBSP4ZUv/tjxz4yIXZ023k1VmQxS0OOAj5l+ZSRsFvNQziseg0hzkqXGzfIHeimmUAWU2c
	TkCJw9aLvHC3J5tCAb2FqhV+YNMO+EE/i7DtXcNSISEct7vr6RMW/R1N1Qssrqs5iAs5RfJU+Cn
	o+DuqWPdaBUugppyMbCV2AeuPYaUpEUKfjStfKbrn/qBjIrWdN23hRWtLoMcERJXtddA9J+N7cJ
	ovammLNvhyU4fc3mExkY9GLBqdcBvNfs9gXEUaxLjHNhGcJNqRCNm6JBNQkmAg4wpJcBndNDPo1
	pAXa2zl47OypFyp94WI/a5eDNxDPyhwL+N3mlDblhpofAzCpxazlriT8JJfjZDkqu5xobyaxuGM
	KbZrWRVw1dlZfMjPDf3nxflToz8p7DebWbMgLdbnNrv9r+hpPq3KIrUH5u6yythUhdLOZ0VKeod
	m+IDnD5tuNi1buKQ=
X-Received: by 2002:a05:6512:108a:b0:5bf:e540:8606 with SMTP id 2adb3069b0e04-5c14c01e3fdmr877056e87.59.1794217361031;
        Mon, 09 Nov 2026 01:42:41 -0800 (PST)
Received: from ribalda.c.googlers.com.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c14b8128f3sm723271e87.56.2026.11.09.01.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:42:40 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Doncho Minkov <donchominkov@gmail.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.10.y 2/3] media: uvcvideo: Force UVC version to 1.0a for 1bcf:0b40
Date: Mon,  9 Nov 2026 09:42:36 +0000
Message-ID: <20261109094237.2534131-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109094237.2534131-1-ribalda@chromium.org>
References: <20261107061805-failed-5.10-65444446f0c5@kernel.org>
 <20261109094237.2534131-1-ribalda@chromium.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The Shenzhen Aoni Electronic Co.,Ltd 2K FHD camera reports a UVC 1.10
version, but implements UVC 1.0a as shown by the UVC probe control being
26 bytes long. Force the UVC version for that device.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reported-by: Doncho Minkov <donchominkov@gmail.com>
Tested-by: Doncho Minkov <donchominkov@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
(cherry picked from commit b400b6f28af040d55b4eb397ea7b8ece368c6b12)
---
 drivers/media/usb/uvc/uvc_driver.c | 17 +++++++++++++++++
 drivers/media/usb/uvc/uvcvideo.h   |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 3b144e858271..ae1050c48983 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2342,6 +2342,12 @@ static int uvc_probe(struct usb_interface *intf,
 			"linux-uvc-devel mailing list.\n");
 	}
 
+	if (dev->info->uvc_version) {
+		dev->uvc_version = dev->info->uvc_version;
+		uvc_printk(KERN_INFO, "Forcing UVC version to %u.%02x\n",
+			   dev->uvc_version >> 8, dev->uvc_version & 0xff);
+	}
+
 	/* Register the V4L2 device. */
 	if (v4l2_device_register(&intf->dev, &dev->vdev) < 0)
 		goto error;
@@ -3020,6 +3026,17 @@ static const struct usb_device_id uvc_ids[] = {
 	  .bInterfaceSubClass	= 1,
 	  .bInterfaceProtocol	= 0,
 	  .driver_info		= (kernel_ulong_t)&uvc_quirk_probe_minmax },
+	/* Shenzhen Aoni Electronic Co.,Ltd 2K FHD camera */
+	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
+				| USB_DEVICE_ID_MATCH_INT_INFO,
+	  .idVendor		= 0x1bcf,
+	  .idProduct		= 0x0b40,
+	  .bInterfaceClass	= USB_CLASS_VIDEO,
+	  .bInterfaceSubClass	= 1,
+	  .bInterfaceProtocol	= 0,
+	  .driver_info		= (kernel_ulong_t)&(const struct uvc_device_info){
+		.uvc_version = 0x010a,
+	  } },
 	/* SiGma Micro USB Web Camera */
 	{ .match_flags		= USB_DEVICE_ID_MATCH_DEVICE
 				| USB_DEVICE_ID_MATCH_INT_INFO,
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 4a1ff08453d7..184ff2c10560 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -654,6 +654,7 @@ static inline u32 uvc_urb_index(const struct uvc_urb *uvc_urb)
 struct uvc_device_info {
 	u32	quirks;
 	u32	meta_format;
+	u16	uvc_version;
 };
 
 struct uvc_device {
-- 
2.56.0.506.g506a7eabc5-goog

