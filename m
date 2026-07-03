Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5D7286D56
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093566; cv=none; b=KP+3U5JbJxiMjvVgPbuNd+z3kL4XLbp/OPqJXfeArllh0L8KJq7sO9+2ostWTWhqjRQZ0Hc4wch8X1EwsyLVVNoInL91UsWP2fHQs2Fx5HFIbd9NwiYfQlzmQ/txMbzhN5qpnZx1tDLpxamKmNxrFolhRv9hmglUNMWceq9iAgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093566; c=relaxed/simple;
	bh=bpDBJApg2sIRD1xZQoJc5hMZ+M4aXNheD81m5KPvtWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B0G4S7Q+c79M5ceJ8l9EpkaFSadfJpXBEJ9tp4eUCIyFshrpqndXmn+mcAehZw4nHwgwXytBdRnNed5omPmAsqZPVM9Ho05d6jozaziNF6HZptiJGOXKZd1QyfgNbvT2Yy09RvLfk2nk6JNbiNj/6c9qmi9700VlVJo+reFZNo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4UN6O0E; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4UN6O0E"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493b8d99342so187945e9.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 08:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783093561; x=1783698361; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r/Xcb20eXe3Fb4hacmH4fR1R2kfzGBmc8DhY2l8UD4M=;
        b=B4UN6O0E/FMADkq9B6YzaJC7/yIa/yZ44RnPFci5x7w4Lr/Y47ztYGA2Fxn+XcckXG
         2vBPMYthk9jLmot39FUQM/msHgwPBkI8eCvDpSlEN4EvIqSdGUiZUmYPWxBrlY5GA1iR
         f+5oYC80l5GZ4lbklvoXLz1b+sumLKi73F9G8fakLBmw04xjoT9uaZi7Z9pmxCM07c3Q
         gC5lsQ1a51uP2V/9UtEUwGbfOn9SalJol1iKqsXgNKljqUIF1GPdj2D0MdmSClY3H8qC
         Ko3dGRli2FCxxpnlzEMFHpKNIRa8CdPrMG6OaS0uOumzvb5ZzEY27/1sZIBI2y1q3fbl
         oinA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093561; x=1783698361;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r/Xcb20eXe3Fb4hacmH4fR1R2kfzGBmc8DhY2l8UD4M=;
        b=c3xiPGPCaOioW26BqNWpl2mRdLRsdvYlYBeRGG0Yn+zaH31kuGUqDY6eoM+s0t8JzM
         F3VHOvD1ufUwB7HXb1DKXQCqxIWquRVV1jxXk2DMsbUdr95DVZjR33mjrqyuXvu/j0Kg
         HJqzqcv899uJDISLaJnlhJs3KCzN5ZDvLsFGM4Vlw9tGVKOBuOu6oe00mFGtSkD1Uplo
         svpBiyTStVerpWJH0vP6BrqmKCOIkYiTRuZ3ppa4X1x35BQNDV87RAwwHik/ZCF2bh+M
         +1IBTl+mOS3l0IWA7CN7GmC3dOt7vIaHGGC0blzOzq7vBHcS8cDh3uHumv1wkyn+8z4B
         8ycg==
X-Forwarded-Encrypted: i=1; AFNElJ/+70nP6EIQvsO4/GNMNhauUdUUwXlx5gl3iQxLEe1vZtEPT0SNxIVAhreyCHT9YhgLhSbT9t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxyKJjDRhgHj7EyUHYIHg8o4YowsUBksgZ5F2tVi8XxKpCD6QL
	yKvoi/ZhmLMV62zdFhhcVCmKSC2Q0X0dssUX4pOBH95G386w1JLl08du4HuzAxBcBg==
X-Gm-Gg: AfdE7cm/99ZwvDJrTZOb+me2QLHLi9KtSoYkZrHZ/ySkOaMTTZb3nVOKvAwDRTnVV+o
	2xDHWyYzAq0g/CoaxO9PBydC5G0kTMBvYOCdrGbJJGu3/xeBGrGyGx+PZVmDCR1TZ4uOb/Qw5FY
	P40D34h2mzzrjrw8kcgfjzIkXo4pnEjO2umhkVNvhBU30SBIBuBmZzQR3TTmlbsHESWbQJg1+gn
	uEb5Y3bV5QQb0fFkr6abdUh5VFta4uc/zMk3V5UymP05qVjfHOh2I5OFwRtBMFOHBv8AMXPJsnq
	gRTw+Wg+u4lIjlBNGoaiVw3x5rP4pVS48Yu3KyGfjW7pdZY0JIAlmC1nIkB6SXdI483M6FBjjEL
	Zxd8plhUOuJVMaMTtc2TZt9wGiFULKDtAYvl4et4jjkaYJ1ZM6ET6Qez5yEAmt5FGMQ1r1Z4PMo
	sqneKWnqQ2zRKm8C31vsNkAdyrTooY4WDzZM+RKRUKChssnYLAJFBwqvoPdVm5cSu4iDcrVKg8z
	K2MhbeV2A==
X-Received: by 2002:a05:600c:1795:b0:493:caa7:4fd2 with SMTP id 5b1f17b1804b1-493d10409a5mr19435e9.6.1783093560547;
        Fri, 03 Jul 2026 08:46:00 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e3e2702sm245351f8f.9.2026.07.03.08.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:45:59 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 03 Jul 2026 17:45:54 +0200
Subject: [PATCH v2 3/3] HID: rapoo: fix missing hid_is_usb() check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-hid-usbcheck-v2-3-c5ed7bc94772@google.com>
References: <20260703-hid-usbcheck-v2-0-c5ed7bc94772@google.com>
In-Reply-To: <20260703-hid-usbcheck-v2-0-c5ed7bc94772@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Miao Li <limiao@kylinos.cn>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783093554; l=1735;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=bpDBJApg2sIRD1xZQoJc5hMZ+M4aXNheD81m5KPvtWc=;
 b=B0s19zRLEsgsGYSktBtXzkHWMswlMWePnN15OorJ1offp7HG3eYwikDX1/ThZNnRAe5X4QV3Y
 wuAeaAHgsW/DMS/E0g086z4y23Xxu4LX37hk9U1Nc8ProQ7j1KHTpQ6
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

to_usb_interface() can only be used on a hid_device whose parent is really
USB; uhid can create devices that identify as being on BUS_USB, but don't
actually have a USB parent.
Fix the use of to_usb_interface() without a hid_is_usb() check.

Add a dependency on USB_HID for hid_is_usb(), as other HID drivers do; the
alternative would be to provide a simple stub implementation on !USB_HID
builds.

I have verified that it is currently possible to trigger a kernel splat due
to this bug in an ASAN build, and that this commit fixes the issue.

Fixes: b3b1c68fb726 ("HID: rapoo: Add support for side buttons on RAPOO 0x2015 mouse")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/hid/Kconfig     | 1 +
 drivers/hid/hid-rapoo.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f9bcaeb66385..48934c4f3c45 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1048,6 +1048,7 @@ config HID_PXRC
 
 config HID_RAPOO
 	tristate "Rapoo non-fully HID-compliant devices"
+	depends on USB_HID
 	help
 	Support for Rapoo devices that are not fully compliant with the
 	HID standard.
diff --git a/drivers/hid/hid-rapoo.c b/drivers/hid/hid-rapoo.c
index 4c81f3086de4..5c9c396fabf7 100644
--- a/drivers/hid/hid-rapoo.c
+++ b/drivers/hid/hid-rapoo.c
@@ -36,7 +36,7 @@ static int rapoo_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	if (hdev->bus == BUS_USB) {
+	if (hid_is_usb(hdev)) {
 		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
 
 		if (intf->cur_altsetting->desc.bInterfaceNumber != 1)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

