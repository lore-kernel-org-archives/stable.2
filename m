Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0633E360
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524460; cv=none; b=qF3bzdITiw5N/YMP+2pC1Ns5gDk355vU8d/uIv6HMnk5zP+NLTo0gWvWhR2c3a2bjuzaDoMxTzQE7R3MEy1oiMNe6TaBRb24Zd+HeQ0TqQ8Vjebhfmv9PS/IgGPu07ArnS1Cm7U/MZmKTBaA3GfKwwjHQdFBOM/j8b5ocnjRfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524460; c=relaxed/simple;
	bh=UDvQV6rFRI3FIaxkx7xY2X+5+gK+CH9bz4CKRg0qTRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=vC7BtgwCV/udsvyEcXqrlZK1aIlykquScflHArx66Nwmn++5cvVsKA/FxMuOIhKEHnTMdrfEuA9ZDTVcQWWHsDkEdYIpXBOg8ymz/NxRTt6q2lF3RplKYPSj8OIcWsofYuRC2hlLtknFO98HE+1oyDZ31PeqElGozuUfb4Ip+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mLGtWp6h; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mLGtWp6h"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39957d210f4so9276411fa.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783524457; x=1784129257; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2nEGKNYfDM9Ah7oR4t0smWiebWNokw1qo2LnrhbkcPM=;
        b=mLGtWp6hHhbSSHEr8TIcfUfRzy+3EGrRDncOSfoGbi17lYvCvyFxmf15zTiZNgfc3q
         bb5KGgAER+zBZo737xgCarm32F7ixsIZeT0A0g+JVb69Q7jAoMTGDVctRAxNfz+I3kIO
         FGVGkwUgwE6flo4jBhpZ2cMsy9G83C5X6WQrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783524457; x=1784129257;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2nEGKNYfDM9Ah7oR4t0smWiebWNokw1qo2LnrhbkcPM=;
        b=Yq0GHQhwBqn+AOJuI+wRtPBqAf0UmZyIV/eaCouAo+NBr8G6HeMPcdupKC+z4pBToi
         w9Q5vG/x0xiwuLjBdywqcNngpQ8ZomdAfZiDkBoE5YjOa6oyt/1xSgHMzFXBT5V6R5RT
         FSIJrtoGCuYuIRKA/OtMwx3m91Um3bHdx+65pyMPsgZNWK8zty4Ur6mcSo4La3ximvXC
         WbLXBqGWi0gzO8SWuPP2WQ7WRLFljWmk+xn4BxncTSigcgrgJWCBrLz4HtbIvK7IhXjC
         nEDSjqXLmZCcLvt5QXVnQ1fYXTyfF/peWWulmlL7suDXCFq3XjbE+Ci/O3/RTTnVrxHX
         asJA==
X-Forwarded-Encrypted: i=1; AHgh+RoaMjC7BPDcyOYf0STh9vf6ymaae5Tnb6AGpSF/5fmK1XKODO1171vczLSWITFoYT3VymTz8g4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDvyEzbB4nkqUD6UwPgb8KfGS99+RhApQXXshs9B9ia8qZyueT
	dCbL3vazCzoxm/S8URNwPzDHVsZoYv++irMenlW2frnNxdjavQBbkLZ+bLkspVGJkA==
X-Gm-Gg: AfdE7cnNFV/8TBGk7wKOYYtSxBJcqC6gVzxEFHJFrRQLcsfRt0NmqckdOc78A43VlwW
	o69ZlN9phaccSlBQwPeG3i5SvMZ6PYMdPp4ZZLBdz475hD0t5vWgFA12A7cJ0fNxtMqXhVi76g1
	oWif2KPoCLO9Q/hZ4uJj0MFhY7kkR7FLBtWh8IVjuwbPTIZi9chE8Cy4x95s9RB7kuo9knpPaOp
	PiNMWVufxACWYSAJQwUsZg+PCLOcTkNi+Ej9vM9kbq12L73uJJ429n+DslkSbz6XdWAsczuwjcM
	Me6X3QP1dIvii2DUXqhvdR17yYn5MNUsYlhtV466DC50SiRdZtFdXybfNxGvwHs/kgJDnfUAEz3
	nPFgtLNDy2w1iYT6vBSY0HdqrY9QRGJQv2RoscTnmchrScEIlVJUh58mA62KULpzn1JuHg8TuXj
	fbVzBiDVylEooL8TXQNAJGetAQ+hKBnq7vOuXgLmhTPeCoW00lEIvf5vF0ss6AtFTxXPGu
X-Received: by 2002:a2e:be94:0:b0:39b:2ff8:64ae with SMTP id 38308e7fff4ca-39c798056e0mr7267771fa.9.1783524457569;
        Wed, 08 Jul 2026 08:27:37 -0700 (PDT)
Received: from ribalda.c.googlers.com (151.214.88.34.bc.googleusercontent.com. [34.88.214.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c7429c4c9sm6430751fa.35.2026.07.08.08.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:27:35 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 08 Jul 2026 15:27:34 +0000
Subject: [PATCH] media: uvcvideo: Explicitly return the metadata buffers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-uvc-flush-meta-v1-1-71b8b18191c8@chromium.org>
X-B4-Tracking: v=1; b=H4sIAGZsTmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwML3dKyZN20nNLiDN3c1JJE3UTTpDQzYwMzEwMzQyWgpoKi1LTMCrC
 B0bG1tQCYtoAKYAAAAA==
X-Change-ID: 20260708-uvc-flush-meta-a5bf63064061
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

If we keep the metadata node open, while we close the video node, there
is some risk that after reopening the video node the next metadata frame
will contain data from two different runs.

Please note that although the URB callback will usually flush all the
queues when the urbs are poisoned during uvc_video_stop_transfer(),
there might be some situations where this is not triggered.

Fixes: 088ead255245 ("media: uvcvideo: Add a metadata device node")
Cc: stable@vger.kernel.org
Reported-by: Hans de Goede <hansg@kernel.org>
Closes: https://lore.kernel.org/linux-media/CANiDSCuO5aEApqHxy6uqZheza7hgdOkH38sY5YhO_xAxSYAJbg@mail.gmail.com/T/#u
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_queue.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 3c002c8f442f..57397fd793c8 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -196,6 +196,7 @@ static void uvc_stop_streaming_video(struct vb2_queue *vq)
 {
 	struct uvc_video_queue *queue = vb2_get_drv_priv(vq);
 	struct uvc_streaming *stream = queue->stream;
+	struct uvc_video_queue *meta_queue = &stream->meta.queue;
 
 	lockdep_assert_irqs_enabled();
 
@@ -204,6 +205,15 @@ static void uvc_stop_streaming_video(struct vb2_queue *vq)
 	uvc_pm_put(stream->dev);
 
 	uvc_queue_return_buffers(queue, UVC_BUF_STATE_ERROR);
+
+	/*
+	 * The video node acts as the stream manager, if it stops streaming,
+	 * the metadata node also stops producing frames.
+	 * To avoid metadata buffers partially filled by two runs, we need to
+	 * also flush the metadata queue.
+	 */
+	if (video_is_registered(&meta_queue->vdev))
+		uvc_queue_return_buffers(meta_queue, UVC_BUF_STATE_ERROR);
 }
 
 static void uvc_stop_streaming_meta(struct vb2_queue *vq)

---
base-commit: 8dac27bfa2f994ecb11f01a63641527d17d48fc1
change-id: 20260708-uvc-flush-meta-a5bf63064061

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

