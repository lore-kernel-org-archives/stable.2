Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5F248E0C6
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940083; cv=none; b=NFT8BFv3wlm2GGwK6V59elCabQHG3FL4BzuZTkVJM6GENfRuGK5ByYz9UP/oiOJA9KiXlloqk8qy2oowntPG461iWvOyLSMDvSu3WdwZiThkNm8L9mD2ESwpqq8wa4y8XPda0KiRExJnIvC/fWtgFZSSOt9aC0Ad5HGzeuuoFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940083; c=relaxed/simple;
	bh=XcOKDhLPhYTwOzM/5M4/TmrnH66IhZP+myCUuGdY/04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cLdcv4kp6K2res2E6ZqKmHxBS35PScVo77/gIj5GTDfaeTRzxElXUp9mAjbyhUHtZWX4PGpfBRxEqDth6c+BWDZ0+YZbGIU7hkmH/o2xgaT/k8evOa6pMkUinfygrN58PrsQqryXyGVbtIVD6R9lBLw7+9FSbLgWwYnfiPxsA1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HvY1gSit; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HvY1gSit"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba43103cccso1946848e87.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 04:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790940078; x=1791544878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w3svkKcm9Hs8mBBSgiJOeXpCrb7Wu+8PwEu9DhSKxdk=;
        b=HvY1gSit73LX8YVLUuj7MYTSIvCk5cNTAiJUSXpZZiooFUQMf198nNTlbUxtG2KuzI
         xIxkgfojKcQkmMjD+5Xi2VS4jhfYA4dFRbLzja8e34YbsjnGlxQVNkuwTvIfznrN6rwQ
         h6cerYYULzdVovvEYzYoGs7qbrnI1hfcKTQU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790940078; x=1791544878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w3svkKcm9Hs8mBBSgiJOeXpCrb7Wu+8PwEu9DhSKxdk=;
        b=TXoLC/aBXFdrTlf03PBtnlY74/yX4G5tVMdgpKNNcop5McXlkvclPs6VgQQKlRdO8e
         MdNlgO3hDI0iwJLQqXgw3362IMfm3jaZpZH4de7R6tVraH80LM3vQXIuT4TPhDwNr2V9
         W1AbiJMlt4qFY5ExAuT+rU8sDZhBidaAEQX8fiT1n0BBPPsDJHRPs24rMfsZFNpnsMg8
         QP3Ypv6jlrSRPPXIq2v2GYiisI7XxCSq/Kl/5VAhMN8b9EkzntV1oESTGBfWcTxreuFk
         XLs0G4HUZVOVHBJ41Ug4Xe13wTK1CeWoh84LIytY+2glKAg9om4x68m2MsExdQwNNfqK
         ODmA==
X-Forwarded-Encrypted: i=1; AKwUvBxnBVos0qWu7SAynrruuFDgOmAF5Y6S4Uc474PBAlOHk44hCbXI5mmVD424Tv51oEKmW3Ie2nc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTrXvU8wtVW322w2/qNqtQ4iChV1qWrj9uvvDB1VfZqT5eei36
	Zj7iiMbz8Kra8NsJIfsGwi4//Np560mxH/Vv4dGPR66uLw0rGeh/qvUiSdilN+9cD4jw0KtVTDC
	eGvw=
X-Gm-Gg: AYBFou14MmF/O9avOJ1PrWnLk8+SMPsFxLJC8vJTHqUXywDSjoLAs+NZMcwCluyH+WN
	3cLz+C6XFW4nbcn8TbOJs/J02pBsc06iyQQdZEoU8YVBRCg3bGKwEDZu5CKbvCxIx8Cjs2rHi5S
	RESrPDPcxXoruG3Y3Uqv66J5VQnBorGaqmaBZh6dJYF960oSUnAXJ2Bmti5NgNNVQ79YL+vVzFm
	OR+6ENJy92NA+6ica9JzShChrWVSKudxCKuNL3RhvsX8MdRt3dpsmoBb6gmL5sDkXKCNtcEmrPa
	DcJcEkbQi3AdCPk1dq7vIrKwCkCvgOW05QCKc81KfNUpIyswdubLymM/uIG2Rla6qlu90RkiehF
	wBOotSNfcGekE2utI2qz9qdfsuFYX9WY7tEA1v6Pb1z1r7K+RLYsgpyW97k1bT8WsVlVffXLbRi
	PFSChPYm46quKSmCsWPg2IAr2nH70pUqxLEsShaA+3/wDymBJbuU1u7qQHuJYTi4ZrIZV3mlLwF
	3m3kjpbxPituWnu2ucstN+Yl2bKWzD73IVAd1GknU2bMtIScXN7YbY=
X-Received: by 2002:a05:651c:43c2:20b0:39f:1b37:82bd with SMTP id 38308e7fff4ca-3a88777f837mr4192461fa.11.1790940078458;
        Fri, 02 Oct 2026 04:21:18 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e324350sm8562931fa.36.2026.10.02.04.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:21:18 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 02 Oct 2026 11:21:11 +0000
Subject: [PATCH v2 2/2] media: uvcvideo: Do not read beyond the
 uvc_status_control memory
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-uvc-status-11-v2-2-a98a135df0eb@chromium.org>
References: <20261002-uvc-status-11-v2-0-a98a135df0eb@chromium.org>
In-Reply-To: <20261002-uvc-status-11-v2-0-a98a135df0eb@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

When we receive an event from the camera we only receive up to
wMaxPacketSize bytes. If a v4l2 control is mapped into a UVC control
beyond those bytes, right now the code is blindly reading them.

Add a check in the event handler to ignore controls that are outside the
data provided by the camera.

Note that this patch now dynamically allocates the size for the status
based on wMaxPacketSize instead of blindly use 16 bytes.

Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/patchset/F0F008459FFA835D%2B20260813074632.2021311-1-raoxu%40uniontech.com
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c   | 12 +++++++++---
 drivers/media/usb/uvc/uvc_driver.c |  2 +-
 drivers/media/usb/uvc/uvc_status.c | 18 +++++++++++++-----
 drivers/media/usb/uvc/uvcvideo.h   |  9 ++++++---
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 6224ecf28ec6..e61235e83e80 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2142,7 +2142,8 @@ static int uvc_ctrl_clear_handle(struct uvc_control *ctrl)
 }
 
 void uvc_ctrl_status_event(struct uvc_video_chain *chain,
-			   struct uvc_control *ctrl, const u8 *data)
+			   struct uvc_control *ctrl, const u8 *data,
+			   size_t size)
 {
 	struct uvc_control_mapping *mapping;
 	struct uvc_fh *handle;
@@ -2162,6 +2163,9 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 
 		if (uvc_ctrl_mapping_is_compound(mapping))
 			value = 0;
+		else if (DIV_ROUND_UP(mapping->offset + mapping->size, 8) >
+			 size)
+			continue;
 		else
 			value = uvc_mapping_get_s32(mapping, UVC_GET_CUR, data);
 
@@ -2191,7 +2195,7 @@ static void uvc_ctrl_status_event_work(struct work_struct *work)
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
 	int ret;
 
-	uvc_ctrl_status_event(w->chain, w->ctrl, w->data);
+	uvc_ctrl_status_event(w->chain, w->ctrl, w->data, w->size);
 
 	/* The barrier is needed to synchronize with uvc_status_stop(). */
 	if (smp_load_acquire(&dev->flush_status))
@@ -2206,7 +2210,8 @@ static void uvc_ctrl_status_event_work(struct work_struct *work)
 }
 
 bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
-				 struct uvc_control *ctrl, const u8 *data)
+				 struct uvc_control *ctrl, const u8 *data,
+				 size_t size)
 {
 	struct uvc_device *dev = chain->dev;
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
@@ -2218,6 +2223,7 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
 	w->urb = urb;
 	w->chain = chain;
 	w->ctrl = ctrl;
+	w->size = size;
 
 	schedule_work(&w->work);
 
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 468d46dfb9e7..b57825fadea1 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1305,7 +1305,7 @@ static void uvc_gpio_event(struct uvc_device *dev)
 
 	/* GPIO entities are always on the first chain. */
 	chain = list_first_entry(&dev->chains, struct uvc_video_chain, list);
-	uvc_ctrl_status_event(chain, unit->controls, &new_val);
+	uvc_ctrl_status_event(chain, unit->controls, &new_val, sizeof(new_val));
 }
 
 static int uvc_gpio_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index 97c939206302..a88fa57513fb 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -169,6 +169,7 @@ static bool uvc_event_control(struct urb *urb,
 	struct uvc_device *dev = urb->context;
 	struct uvc_video_chain *chain;
 	struct uvc_control *ctrl;
+	size_t ctrl_len;
 
 	if (len < 6 || status->bEvent != 0 ||
 	    status->control.bAttribute >= ARRAY_SIZE(attrs)) {
@@ -187,8 +188,10 @@ static bool uvc_event_control(struct urb *urb,
 
 	switch (status->control.bAttribute) {
 	case UVC_CTRL_VALUE_CHANGE:
+		ctrl_len = len - offsetof(struct uvc_status, control.bValue);
 		return uvc_ctrl_status_event_async(urb, chain, ctrl,
-						   status->control.bValue);
+						   status->control.bValue,
+						   ctrl_len);
 
 	case UVC_CTRL_INFO_CHANGE:
 	case UVC_CTRL_FAILURE_CHANGE:
@@ -257,13 +260,18 @@ int uvc_status_init(struct uvc_device *dev)
 	struct usb_host_endpoint *ep = dev->int_ep;
 	unsigned int pipe;
 	int interval;
+	size_t size;
 
 	mutex_init(&dev->status_lock);
 
 	if (ep == NULL)
 		return 0;
 
-	dev->status = kzalloc_obj(*dev->status);
+	size = usb_endpoint_maxp(&ep->desc);
+	if (!size)
+		return -EINVAL;
+
+	dev->status = kzalloc(size, GFP_KERNEL);
 	if (!dev->status)
 		return -ENOMEM;
 
@@ -286,7 +294,7 @@ int uvc_status_init(struct uvc_device *dev)
 		interval = fls(interval) - 1;
 
 	usb_fill_int_urb(dev->int_urb, dev->udev, pipe,
-		dev->status, sizeof(*dev->status), uvc_status_complete,
+		dev->status, size, uvc_status_complete,
 		dev, interval);
 
 	uvc_input_init(dev);
@@ -360,7 +368,7 @@ static void uvc_status_stop(struct uvc_device *dev)
 	 * process it synchronously.
 	 */
 	if (cancel_work_sync(&w->work))
-		uvc_ctrl_status_event(w->chain, w->ctrl, w->data);
+		uvc_ctrl_status_event(w->chain, w->ctrl, w->data, w->size);
 
 	/* Kill the urb. */
 	usb_kill_urb(dev->int_urb);
@@ -372,7 +380,7 @@ static void uvc_status_stop(struct uvc_device *dev)
 	 * uvc_status_start() call.
 	 */
 	if (cancel_work_sync(&w->work))
-		uvc_ctrl_status_event(w->chain, w->ctrl, w->data);
+		uvc_ctrl_status_event(w->chain, w->ctrl, w->data, w->size);
 }
 
 int uvc_status_resume(struct uvc_device *dev)
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 69ee3d0c971d..788cee0c409d 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -567,7 +567,7 @@ struct uvc_status_streaming {
 struct uvc_status_control {
 	u8	bSelector;
 	u8	bAttribute;
-	u8	bValue[11];
+	u8	bValue[];
 } __packed;
 
 struct uvc_status {
@@ -629,6 +629,7 @@ struct uvc_device {
 		struct uvc_video_chain *chain;
 		struct uvc_control *ctrl;
 		const void *data;
+		size_t size;
 	} async_ctrl;
 
 	struct uvc_entity *gpio_unit;
@@ -771,9 +772,11 @@ int uvc_ctrl_init_device(struct uvc_device *dev);
 void uvc_ctrl_cleanup_device(struct uvc_device *dev);
 int uvc_ctrl_restore_values(struct uvc_device *dev);
 bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
-				 struct uvc_control *ctrl, const u8 *data);
+				 struct uvc_control *ctrl, const u8 *data,
+				 size_t size);
 void uvc_ctrl_status_event(struct uvc_video_chain *chain,
-			   struct uvc_control *ctrl, const u8 *data);
+			   struct uvc_control *ctrl, const u8 *data,
+			   size_t size);
 
 int uvc_ctrl_begin(struct uvc_video_chain *chain);
 int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

