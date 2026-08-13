Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4F342D75E
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786653814; cv=none; b=RjS2avuc4ylQxY0RXE/7c0unwrPkwpcHj58omZf8zGtHkbixn8vPac0bKQp8DGZVmsY59nJtPUhfA1p01YH6M9hKc3idaNiUaa4H/fEHQdYHKofAJUIwn2FHGJn6w+BWXhFv6p6JknUJsqg3BToU3K+HoSH1lVuOQIN+ItDmMFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786653814; c=relaxed/simple;
	bh=UsjfjuhDncxtlbBeZ9IQfuCMw8Vym1bwPGtUunGcIJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Uq+bBI1/fzreUIouM3IBthUyIJ2sQmim+iY+l1vwalMi4NTlQZuXE44dEk1HIVZudrxlk6GXnaHbWpqeqeNbfJScImzfFo6b4DD/fv4s7fr9qyQ248GwulGMI1Pp66XlCFrA7o5ldLUpU/2I2BIiW9Rdyp4FLpLPCKzBgdKs+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YKQvpvxt; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YKQvpvxt"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so246147e87.1
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 13:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786653810; x=1787258610; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NdrNrxezjoizxu3zjSdvwdOKcGeoA1YtD7Hl3JvJCrU=;
        b=YKQvpvxte2Lew8DZ5sPh1icol+ABX16MA5EOORUVWK4C7FuNirUn+TXmrUu1S+LRFc
         P16rNgww0MGV78SwInO63gz6pEwX93quSQe0LXvu6D6c0MP4OpKagaUlXOMeyDJGGM4X
         7V24FElM6FnXWogF587dCLc/+kNLqVUhCDwj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786653810; x=1787258610;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NdrNrxezjoizxu3zjSdvwdOKcGeoA1YtD7Hl3JvJCrU=;
        b=OqN1Q2ANx1geGpYzMQLu0Ecn5FqfE/KNHiYANtxCSsz83rrS//c4zlNMqgGSnws3Qx
         iQmz32T9kqPGhK9g2zGLXJH1xGWtKPzdsuTz7wTs9/7cQbz7UXl+GBVsxHwr3qT8mBT7
         G9r2HkH6nd5ZfIkhC9luqI00nKrLF3yOFNM/wrFj4cx4FtWigSyzrxAr6ssjJGY4y1Xn
         ZZxOM64IG0OG1ouXvtmygEe4gggdiOTacOsXU6ftvPBtz6vBOHVZp9UjCkSwVzAtL6gj
         DnB8ybpj2l4gjpjwGUCirYICOEfjEDIenuKRCnlJmiwaSum6v8zLYx4ZxepUhukDU6yK
         mJew==
X-Forwarded-Encrypted: i=1; AHgh+RrEgbaf9NDao5LdThzGAQXSXcohRvHwzjY5y1wzXDAc5+ZoBsWZ1rGLGk73r1WuymXctUgdMTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+0ffmAQIWEYnLxFiHIDYQW7dQmShskS28BUzu8H3D+/lKwNS
	SU/7hyiKP3xKUqfFxJfcmSLkNpCu5QPXqSjEtKBSdwke0KVrY3J5cYqOKGcoY/O2Pw==
X-Gm-Gg: AR+sD130vhbVtBcCZ7kMFur2h33ASVa7v8kiTdX1D1XrY/DNeB1Vzf0DcCn9spVjW3U
	Ae8cqrHzKEkmdfpaw4XoVnFCBhC1z8B/LcseTd2YtS8ZaTRcg7y0zGUFQc5J1VBlm9adZ2WbSuR
	yDqD2/34k/6lEGRR6CfEiyRy0z1hyqu9Gmh+ommgLsdT/XHMem7liFT4s+6XBemYuwzsPHzPnIE
	jD1busN2GH+VNNvWwdxmO0pOx+J/vLZ1Pxlhcx0f54iTEJLqy0JWusOPljScUnrsJTa9JNMb/Zy
	8g3WU0Q8w2itAdTKXZSeQ00/I1c65w5yDf/RmnwR6d0/H+dBnUh50AxPE9n9+rrqblrSNZ0p/la
	A28vQPDJrKy1snPRsnrQg7nl03k9oZr/p9ESZXvOdYelRrcKExX4zSeVnkI7FfvKhnH5kwOeHuT
	OC5FhPsgS2oQxuZ5xkHKY0ibapHsjt/uG57eU3axEToQVRQxlaJQM0hu57g8ye0ZYAqriq3RBJq
	LLiMA1j4NOzuHRfeDqjdGKt7YdEyud9oZRhirI=
X-Received: by 2002:a05:6512:2315:b0:5b1:5a31:8603 with SMTP id 2adb3069b0e04-5b45914b27cmr88124e87.55.1786653810310;
        Thu, 13 Aug 2026 13:43:30 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b458bac84fsm102509e87.37.2026.08.13.13.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 13:43:28 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 13 Aug 2026 20:43:24 +0000
Subject: [PATCH] media: uvcvideo: Do not read beyond the uvc_status_control
 memory
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-uvc-status-11-v1-1-2cf43e9590b0@chromium.org>
X-B4-Tracking: v=1; b=H4sIAGssfmoC/x3MQQqAIBBA0avIrBtIg8quEi2sppqNhVMSiHdPW
 r7F/wmEApPAoBIEiix8+gJdKVgO53dCXovB1Kate93gExeU292PoNZo7WzJdK4nZ6E0V6CN3/8
 3Tjl/2Ap7Fl8AAAA=
X-Change-ID: 20260813-uvc-status-11-99b9e27a8ea9
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

When we receive an event from the camera we only receive 11 bytes. If a
v4l2 control is mapped into a UVC control beyond those 11 bytes, right
now the code is blindly reading those.

Add a check in the event handler to ignore controls that are not
available in those 11 bytes.

Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/patchset/F0F008459FFA835D%2B20260813074632.2021311-1-raoxu%40uniontech.com
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 +++-
 drivers/media/usb/uvc/uvcvideo.h | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 3ca108b83f1d..3061f388f57b 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2158,7 +2158,9 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
 		s32 value;
 
-		if (uvc_ctrl_mapping_is_compound(mapping))
+		if (uvc_ctrl_mapping_is_compound(mapping) ||
+		    DIV_ROUND_UP(mapping->offset + mapping->size, 8) >
+		    UVC_STATUS_CONTROL_LEN)
 			value = 0;
 		else
 			value = uvc_mapping_get_s32(mapping, UVC_GET_CUR, data);
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index b6bcee4a222f..ae5e6b6fdd98 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -559,10 +559,11 @@ struct uvc_status_streaming {
 	u8	button;
 } __packed;
 
+#define UVC_STATUS_CONTROL_LEN 11
 struct uvc_status_control {
 	u8	bSelector;
 	u8	bAttribute;
-	u8	bValue[11];
+	u8	bValue[UVC_STATUS_CONTROL_LEN];
 } __packed;
 
 struct uvc_status {

---
base-commit: 7b1734e1761258d78651263706182f1d772c0d3b
change-id: 20260813-uvc-status-11-99b9e27a8ea9

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

