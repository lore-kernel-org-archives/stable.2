Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D825F379C37
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788686677; cv=none; b=S+SqjQlH9LoRwXZ7GWffQ4YiGgUi9wZ/iu6JBGPrL+3izKn4Gszq5GB20YVLiCI2pBjhT4SASegjosUPn72zZQmwJLEw4PRiwy+xHOLYCXKUHkJlfgEdAQr2L4oX5nemuTTjjqRFviwPw1HYxfSIo6zGWAa5ZoE2nAJVTICLAr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788686677; c=relaxed/simple;
	bh=sDvMApKRKg+lqlm98orB5wnP1nojcFweyk45ZzecYfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nveU8AAmOTjSAMRZUYHXK1qxv5DhYD2V3pTTPeVu7Rd5OEWfvWnnpRruVLeaLh7mpdj0TO6P2/4+zs1DZXa+1mgfXLhrjkpL3W8oT3PV+TgXgHXtdOQ+Q/E2osQ7O5J6hWem1kN9kue6nF2AvzCauQoZLYApZHtGGsuUj7F6RPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtKX1uVG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtKX1uVG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49557167508so30000485e9.1
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 02:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788686673; x=1789291473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vMJobEqGp+VWt8ryxcGp2CAzSroh7TVYBuRu9vWc0Ss=;
        b=dtKX1uVGsHRT2VsExbcbku5nNrRuAEEfqpYTRT4WyVRvWboSWfEybamKuGcUCHFx9D
         IoSmfsms/4n7SQyvpWU7gnaePi6iWCZXUfSA9pgurxqfCh61A4rcButSxWAb9IY9paeU
         BFrlMunFcqJJo09Lb03vfylJWOelH6Byc3t3zbSPKMM/x6DdHYc4gdOtJxgPolr3HBRr
         LUnuzGvb5DIyK13sQfWtAz6uUN01p0BSmz1K4ytOJPpDaXohtvzb80BmpucFRw9Ln22L
         /0DLS7CNhvHKumy5IKr1Mq9BLNDi9WLE5pdPl2L2vK1W0pm6EOODZJDbq6x6xqWShTIe
         PJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788686673; x=1789291473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vMJobEqGp+VWt8ryxcGp2CAzSroh7TVYBuRu9vWc0Ss=;
        b=mUejkjF5xoKIp0tk+Z7O1nvfrfeIu49d8PJA2uyo6fHyGAJBcrFQYJG7ptuzu3371R
         MQjeKwje9EcTufcZADd957CtY8DUrqJPkXdstULQjrU0OU8McZkl7147o5nUhjN//9rP
         knForyzz4X17n211JGyimhZKQDxXMvOqGW2pLFxoziFGwutnv1iwt2+RPGPKHjJRdu3r
         XSAyE/rFMTguZLHL5lRtN3s3dHMK6p+73K8mlqhM+AZ/RE0pJVMIUdhc5NB27Cbyvs97
         woLYjWWOU1101ENnXXd/Q2VO2ZKQZCrRh0X7pYpQtTKRjR4yzc6vO0iW+N2vKt6u8d0n
         yrSQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7ojpZhURRyWFUV0VVybgXOaOv8YoDuivoCYAueHqv8pcju10HUZGkPjEfZBA6Sa+NcAbfSLo=@vger.kernel.org
X-Gm-Message-State: AFuF++kCdYUp+ue9Eeni4I1zYb9NxRdf3YJ/AcNbt73VeSndVH/ALXVG
	gQrjWnnw98FjMoDK2dUf+MC2xw/CZmclwow2skY4Kl59CPdD3CllY9c+
X-Gm-Gg: AYBFou0KBupgo0FocvJZn6XXPoProrT9ufqJNaYgCf5FupxhJJywlZ2RceX03ECK2KY
	KHItb96RokVb8CpIA7GXbiq828MgYpqK0xIJy0JCWDmWiIXP6psCMAhCcYMr679qS/EpMu+27v+
	LMQhRqjXtQVSOGxSdDC4nr4wlJSNWGvu5iMFiSg7xQxqxfLT7OWOI2me/ThMsY0PnNsAt2HIBWa
	L4R6ELMmkxVMb5Lc2R7T7qg/ktN/ghHDsBB3FHuOYAunene5dItBpAGuSiDlUGBimXF+3aU47xB
	sZqnPitOcFKYIoh72E6rMwWPnMsmwBy2uc0AzeZ95KxDBjBv59zMWA1ozRpi5WShCq2le/bXSId
	PsOK8cvHKR6d+f/L+g8pNDLntE9euj0An5m6eKTEEXOAFwlcK8Oa/eObn+Vqvk9aWfq4whUwC5s
	l6QQ24JjuS3tCCPgpR7LJ4B4l6w45ho1jneiyaadK/ggSdEqKQ1jWHLpa6kxkoPsJwLiV8gq+cb
	7pB6dV0LlnViMtnBvDe1hLJLU2Dp+jd9g6groenQjy4irbH
X-Received: by 2002:a05:600c:6306:b0:49c:f5c0:aa76 with SMTP id 5b1f17b1804b1-49cf81e366amr389316715e9.5.1788686672750;
        Sun, 06 Sep 2026 02:24:32 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm216768265e9.0.2026.09.06.02.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 02:24:32 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: linux-media@vger.kernel.org
Cc: dan.scally@ideasonboard.com,
	jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org,
	nayden.kanchev@arm.com,
	hverkuil+cisco@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH 1/2] media: mali-c55: Check the parameters buffer address before copying
Date: Sun,  6 Sep 2026 10:24:24 +0100
Message-ID: <20260906092429.50046-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mali_c55_params_buf_prepare() copies the parameters buffer supplied by
userspace into the driver's scratch buffer, using the result of
vb2_plane_vaddr() as the source without checking it. The queue accepts
VB2_DMABUF, and vb2_dc_vaddr() returns NULL for an exporter that cannot
be vmapped, so the memcpy() dereferences NULL.

Reject the buffer at prepare time instead.

Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/media/platform/arm/mali-c55/mali-c55-params.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-params.c b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
index 70106276b7e4..16e895e3488e 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-params.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
@@ -710,6 +710,9 @@ static int mali_c55_params_buf_prepare(struct vb2_buffer *vb)
 	struct mali_c55 *mali_c55 = params->mali_c55;
 	int ret;
 
+	if (!config)
+		return -EFAULT;
+
 	ret = v4l2_isp_params_validate_buffer_size(mali_c55->dev, vb,
 			v4l2_isp_buffer_size(MALI_C55_PARAMS_MAX_SIZE));
 	if (ret)
-- 
2.55.0

