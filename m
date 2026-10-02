Received: from mail-lr2-f33.google.com (mail-lr2-f33.google.com [74.125.230.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1EE48CD7E
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940082; cv=none; b=FvZcX3cOlpFuQEnbAdgiwbOVIkuSrSNtXln4M0rTwEBz88iMPo17lKcXshFXiot8TnyTWe3vYsNoXhzawQGHU7Y7w8IK117Wy7GaNY7YccUhMUGEGO0VwuczetkzmiWdEviV0xtKXj8U2oywCYMY0jr6AIbDudx73Evb3e3oA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940082; c=relaxed/simple;
	bh=VXjopj5U+omqVAla7VGm6iwYDdGBC64jca9tjyI7yGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vB0Bhv1tI4a4IbEie1hx5wkbyWbx5CQsGPNTfd+pGnlLLCB3Oj8dcI0eZjN4O+qSYwS7qn9ah4Fh1IUoBnM5sJDzEt/4TqRz9P0hw//tUqToJ4F5iiHXFica5NG7xUqw7IVqZGmlZWSn1igij4bIVQWPHpvQg5F7H+QHMc7Xd/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KuByR8d6; arc=none smtp.client-ip=74.125.230.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KuByR8d6"
Received: by mail-lr2-f33.google.com with SMTP id 38308e7fff4ca-3a9270162ccso5202451fa.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 04:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790940078; x=1791544878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0/tFurwhhHzFcRbrY5ZaJlaUHnJjgD55kmW9K0lAQ28=;
        b=KuByR8d6UjZRycl+So0RrwIwPBEicVYJcRk5+xAWoEub528JpDc1RboOKZM4pr9kjQ
         sJ/3nIqIi+3XtFZX/oayLkGHP2IQPXMQ5eCeQp1e6ZTyEBrLp0oUn6qMDrX/mbnyfbDz
         pFwEqMk2qHko4oUPXc65Szti3/xkYoouUcqBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790940078; x=1791544878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0/tFurwhhHzFcRbrY5ZaJlaUHnJjgD55kmW9K0lAQ28=;
        b=blJ06phWlDqqpQZM73TLyb1rgHu3tAI+sz0KQoo6VvRyae2n0YbyTjvCntAkHGriz8
         Nzj1sRwJFhgmJKhyPb6GBZJGn8IEar0Gfv4e4fDX7VY3bev6ZQL2MpzvbLxhkb1epuzm
         eZqe9/gd98mXZOVPVhG6QCR13sYGUMdU2zA0OOL215bSJuNIPmwXGMTD0YiqwKRc3ObF
         hkW5C5Zt/splOi703l63lhaXDsSmax8dmQ3wl5UYydZVrZsos8TIsn7oRwLUaukXsuhX
         xMjBTbC0j3gMQsCvvBKxl7WVY+ADMnv+Qux4PKv5wmadZhNMQy/yqtGL9pp9giczi1Y0
         XwOg==
X-Forwarded-Encrypted: i=1; AKwUvBz80LELI+zDv98ZThtwsk7kBMtqkK2IXrasIr7o7HRYFIOUbrICnb0qjPuU9wAAT1U1QdeR/Tk=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7/QJazYgaP9tCGuhVSGG4lt4lRGTvIrZR2fyOJWmTc4WlK5Br
	+mnr8WqWUwYLrT499BpZGjf+welNDo2z5/8GlDX3V+llIUbrDxZoIWFekq/4+nOdQQ==
X-Gm-Gg: AYBFou1gBHnt54wb8c1uM+noZ2G5O/BjXdInfz64HdOkMh5qAz5LJwFEHX6DY3gAENr
	lBH+bmPpvxpQTkcTrao/LLrE/4E7tKZAOge6S+SXi+dp205NGnXA9q6jgPRI/1bAh2gN8UqIsVO
	lJMTwE4EisSDWDgklt6FIPuE0u8AetiPMi35fILlChfhpoQu5LezzlX2ifx4VCdZsufuF8Abct/
	rl2wnQdB2OBQHiITuQfeQuC05SjbA608OOsUUEcWGf/98QCix3RenT9izTZgB+3owaE3dfrsccV
	J7p/lNR7Fgvz9sF6i5K4hagk+cAvSyAqFc4uGxCWM1wLHFtwB4vVtCcruYouSsmrYXCxe9+25IA
	fhBFR9dcUTUz1yg153NDwODKZa1yCNuZELPeEkpWP/80WCoQQY14TSmcbklDiT2qvqEgp2s/l28
	Vdeakyc1BbrnqHWHIyV7Nn7G7SqXOqTJGztXRw573FDqTId6+V+UhpD2ysDi95FGGjNL9Ruw4in
	ZgRllI+6OzD/RSf6PXZvXLligPStAiioTSxKgAYGhIH1sQlzGHaZL4=
X-Received: by 2002:a05:651c:553:b0:3a8:380c:9fb6 with SMTP id 38308e7fff4ca-3a88786c31dmr6898411fa.28.1790940077733;
        Fri, 02 Oct 2026 04:21:17 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e324350sm8562931fa.36.2026.10.02.04.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:21:16 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 02 Oct 2026 11:21:10 +0000
Subject: [PATCH v2 1/2] media: uvcvideo: Introduce scattered field for
 uvc_control_mapping
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-uvc-status-11-v2-1-a98a135df0eb@chromium.org>
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

Most of the mappings are contiguous, but the one for
V4L2_CID_ZOOM_CONTINUOUS is not. Instead it uses bytes 0 and 2 but
not 1.

To force reading the byte 1 every time we set the control we used a
fake size of 0, but that was far from nice.

Instead make a new field for this kind of controls.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 6 ++++--
 drivers/media/usb/uvc/uvcvideo.h | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index d2f722bc3459..6224ecf28ec6 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -998,7 +998,9 @@ static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
 		.id		= V4L2_CID_ZOOM_CONTINUOUS,
 		.entity		= UVC_GUID_UVC_CAMERA,
 		.selector	= UVC_CT_ZOOM_RELATIVE_CONTROL,
-		.size		= 0,
+		.size		= 24,
+		/* Byte 1 (bDigitalZoom) is not part of the mapping. */
+		.scattered	= true,
 		.offset		= 0,
 		.v4l2_type	= V4L2_CTRL_TYPE_INTEGER,
 		.data_type	= UVC_CTRL_DATA_TYPE_SIGNED,
@@ -2815,7 +2817,7 @@ int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl)
 	 * needs to be loaded from the device to perform the read-modify-write
 	 * operation.
 	 */
-	if ((ctrl->info.size * 8) != mapping->size) {
+	if ((ctrl->info.size * 8) != mapping->size || mapping->scattered) {
 		ret = __uvc_ctrl_load_cur(chain, ctrl);
 		if (ret < 0)
 			return ret;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index af8cef94ffff..69ee3d0c971d 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -126,6 +126,12 @@ struct uvc_control_mapping {
 	 */
 	u8 size;
 
+	/*
+	 * True if the mapping does not cover all bits between offset and
+	 * offset + size.
+	 */
+	bool scattered;
+
 	u8 offset;
 	enum v4l2_ctrl_type v4l2_type;
 	u32 data_type;

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

