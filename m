Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B3454705D
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605937; cv=none; b=jLTVvanxG6A7m9vWo8L/k2EBH20LUR9m0/LhmgB1qnJfEA4kxdMF5VXvHx0ylyNOR4D76hjBsW1Qon5PI2+5AsH9OE1YKsOpd3OciKWttGph7Z1ozzzaLiTe3Zj8vGyfGa0c/mkmqMDUufKWn3dEIKrbm1oHr36y7U6ofF9tNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605937; c=relaxed/simple;
	bh=4xsFsq6UI1uMBaGJq5oiBxB4qejVSgh74V4L6/cQvzY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fLLBgQj6pUdkTUpYBm2MhWfYo+L/i9Mept8D3YPP7fq/sg7sdiW9TNPWdstz5YOTvAm85FRBXYvXfacvRBLL+qEjpHLHfizAywcMEjA+iBNMoTQt/QfsuhAj9NZf4cHGjjjhVc7obPm54T/FlTtwC1JmM0qXMtmnWKeQCU3L7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oabPQtPd; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oabPQtPd"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8ede3ab7aso653919e87.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790605930; x=1791210730; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/VflUiPNajJnp0ayxU8tq6LKcc1Q82tg7jHSnkHrkjs=;
        b=oabPQtPdHPZh/N6BPkRoRzoaDx2aXUofRIKFqCZj5MLG1UOlbat/PLIOHth8UqJIBp
         TCoY3e/ArdbcaNQsct0oGgR4GggntoUsJW7hgXrRO2ww2qfAGln2iib5yVKJ7SJNvtWC
         0zuwGLl5ibjxrp5l3kZc4itELt54mHEeQHf2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605930; x=1791210730;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/VflUiPNajJnp0ayxU8tq6LKcc1Q82tg7jHSnkHrkjs=;
        b=w0Hxjlk4C2ivma5BLAn1rXJTIl8EsrO3OnV9Vf8Eq6ZQg1BOpT5NABhcyzIhYSeW4U
         bORidHZoqq08Hja/A1Wlc0oNc2mVjIgK50f4FwIbb6XXeL8nJs/LxxvRyYkrRTK0yWxG
         qNXxBbV20ZWpqznKnkVnvJ7Z0nVookZWjLNdPk6wQHFxJx3nV6X7KWn3xDv3xcIQm3g6
         RDzN220Pf8pFe319a/jOJSFWIJP4qDa7/9FXA4HDkhzzmxKdQTrO3MSs1CcEyWaT54dL
         Zw/03edsI+IdWPt8RhuAiVXxKWdrUM/QeaqKHTJgfxjd1mAKknziyl++4c6UZFQYn7fq
         4jgQ==
X-Forwarded-Encrypted: i=1; AKwUvByZ6EWMpL+TPQxqI/53AgKr4sVppwFlcIzO18waYHl+jzWiQSoZrf1WJzjEF/5ltR/GqK1Ws5k=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1YzI7H6dD8DXHleepJvo54k/kVNbDwZ0Hm0k/fwXMYmAIqNj9
	jYpgDD9Geznogg5r+DvKZSZ4m9oGWc2aO2lUB7x9eIOTQogMHVdPTD6lVrcwM33GfA==
X-Gm-Gg: AYBFou1LIy8Xfvh8fC9rSKSpOczvAF+jUSBCs5fpZ8N3UE7kZSykBkrLrBWpHBVRLHx
	EEawdPhpz7lG9lVVSgZiiaezs7m0NBCFPbLwODA80P6+HYKODTqjZc3DtzvcgZ5eVWCjbvyHM7f
	16/ATGB1gCG2MJ8Bm5Kx0zXPVixzWquiSp+yqKcM9YUALUe1NJ7PM9sThPxYuTfnhjGgpDFsfoD
	ur5LI5uAgnYAcVmqxvlSvUe2QyYcHaCaL8ad7ufYDQyxG2eU2uJDUPbk59O2fZmTf+BCEdiC3JQ
	INAWnhawy1NZzcfU7liWcnpWZEE9eLPRlFm5e8F7sdbImDPDES8JfNx2GZW/KPwdeqGrPl+xMzh
	tE4WbojvIPXFQgsZmw6QiBKnJxZ9rSawNKusu5RY5+8YTRbNTPKsiuUVlkpAUqJDe4xLVyAEPcQ
	iJm4Hi9Lq2FH6XcVEJkFc66w6oI8ntzDUQiRw3dpBSd2rjKmWFfuRTSzd2rHJ3+Q0VNzeyrsp2P
	YjE3ULqhxnBhV0BOMPCh6zPgmLxBZUdKeNfJixMTxwvLHH+8g==
X-Received: by 2002:ac2:4646:0:b0:5b6:67b3:9f74 with SMTP id 2adb3069b0e04-5b8df0d4463mr3705125e87.5.1790605930461;
        Mon, 28 Sep 2026 07:32:10 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b9debb098dsm603606e87.38.2026.09.28.07.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:32:09 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 0/5] media: uvcvideo: Automatically handle invalid
 uvc_versions
Date: Mon, 28 Sep 2026 14:31:59 +0000
Message-Id: <20260928-uvc-version-v4-0-da0e983fcb95@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGB6umoC/33MTQ6CMBCG4auQrq2ZtsOfK+9hXGA7hS4A00qjI
 dzdwkoNcflN5nlnFsg7CuyUzcxTdMGNQxp4yJjumqEl7kzaTIIsoIaST1HzSH794w0ZshpVhZp
 YEndP1j232uWadufCY/SvLR7Fet3vRMEFV0iYG0uAhs6682Pvpv44+patqSg/uBDfXHLgqs6tL
 G+AiHqHqz9cJV4AKlmZqgFjfviyLG8EGPfBJwEAAA==
X-Change-ID: 20260907-uvc-version-aedefc4384ce
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Edwin Gatier <edwin.gatier@protonmail.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3

This series changes the way we handle invalid uvc_versions. Instead of
just failing it will try to continue probing.

Now that we are at it fix the way we handle device warnings.

Thanks!

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v4:
- Handle invalid dwMaxVideoFrameSize.
- ctrl_size -> video_ctrl_size
- CTRL_SIZE->VERSION
- Link to v3: https://lore.kernel.org/r/20260911-uvc-version-v3-0-604328d8a0dd@chromium.org

Changes in v3:
- Move uvc_video_ctrl_size to uvc_video_init()
- Fixes for uvc_warn_once
- Remove bmVideoStandardParsing parsing
- Link to v2: https://lore.kernel.org/r/20260911-uvc-version-v2-0-395f27b0444c@chromium.org

Changes in v2:
- Add quirk for Avermedia
- Change the way the compliance error message is printed and cache
  ctrl_size
- Link to v1: https://lore.kernel.org/r/20260907-uvc-version-v1-1-34e45dfe04de@chromium.org

---
Ricardo Ribalda (5):
      media: uvcvideo: uvc_warn should warn not info
      media: uvcvideo: Use uvc_warn_once when it make sense
      media: uvcvideo: Automatically handle cameras with invalid uvc_version
      media: uvcvideo: Do not parse bmVideoStandards
      media: uvcvideo: Force UVC version for Avermedia GC515

 drivers/media/usb/uvc/uvc_driver.c | 17 ++++++++----
 drivers/media/usb/uvc/uvc_video.c  | 56 ++++++++++++++++++++++++--------------
 drivers/media/usb/uvc/uvcvideo.h   |  6 ++--
 3 files changed, 52 insertions(+), 27 deletions(-)
---
base-commit: 58348f64125e9a3e44d3abb275ca7f4e6c9641e5
change-id: 20260907-uvc-version-aedefc4384ce

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

