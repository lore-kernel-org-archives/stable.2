Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3BB3FBB5F
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783547663; cv=none; b=bzKmHvPtdL4tjraD0rv0KfObyZFA6oquoByhq8jAPzSJogr/XGtL9/anx/+k8ZUTmWKBtD9wBDZA4PzV5hTK/asMS3rIUuNqDYVPIFdY34fFUGJMU6a+5NM0xAOezpFUwK+tnetpu77dE11pRo2gWzXreXhkPlXkrV3z+y1XSw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783547663; c=relaxed/simple;
	bh=mYO2vEWxO84mPWA2NS2Y7rpAH5cxlgNY1vFZOBHYWKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1wSiob1h2+4AoJBlmg+NdxyGXmI3qKGOOBE1h2gD6U8IqpNF+Vlhc9FehS99gb5TzfzRzrXhhAmbeMcvkFvt1oB+mQu1+YBJIdr8MKtBUrXMtiV9ZPCtADfp2dw0US/2BTkTytHtaDiwVQAuIq521EEltbUogpZrSha7O9B18c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVIz60PR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVIz60PR"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b27c7451so3829795e9.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783547659; x=1784152459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=864WgdCGKVvhVw+X58LxeAIhuiQbwracGrd3VXI+iDM=;
        b=aVIz60PROIbu3uClpOiCCKhO46Q81gKagqXuIADN+P5WSLd+X9bbQ5KpSLHX4VKOWr
         BkRHg0FytVA4uH8THfowTY4aOLZGxVYvEItlTETtwCSg2iD+cIQIm2SlJVYWAVUraUug
         bPySsVzR1a+XJy0KJ2r4RiXE6VbSYtzM58tw8aoRuRbNrcMWfKhEboFfsIMlwxeHYkfx
         GFRh6fR52Tp3H9ffkYpffwQE3qAHwJrQWY4CpqsDIrszr6KwP5dLviJbXcnPqxmyPSDP
         VVMfNhtnuBKVvi5NysKCkSBRcnaAXiI0lfTkwWTshzmf/SfivZiAugztd5+FQCDO2zHF
         UpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783547659; x=1784152459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=864WgdCGKVvhVw+X58LxeAIhuiQbwracGrd3VXI+iDM=;
        b=qZL8729bg1T9YJ1efG7tB+kGAsCk5T5PdzKkMrHj8VDV6UqXPhOuXyLAqDRXEBkyOs
         OxZdp+Wbo7JRu2BvLIzr3PHCOQK/Vu5J5e2s3j1axlvfBsUDwbN7PoOH5XdM/7l250M4
         kZ8yxyB6GK4tSuwVmJH1kiEgne8ERT5j0SyZ2BmyuaW0Cap6xxmdt6Wb+jAEbgTjFsfx
         MrhjMcJRtUa5BoRAi2oOCIxkpPVBFy36mzhPIAl5JLLbgOWEvO31MHCce+mCu6CWzcSr
         s6+wan0B9tXSHCP2Ux7wFiFkIOjbKDIsqWP4bC7RfRtgQM0SySLJ6vJOY/pyApEEv8rd
         mKpw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/ntR0cSf9jEI24+CX6JfleIL0bRzhQczFP0OEaEjkjije3aZoShEEeDjMzUE9l0I/E8iL0Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8CZ2B8SFWjdNVAGIdJaKaeQI7UnpQl/9LBnJIInZnFWi5LufA
	p0Xpp3t0n1pz4AhUYyxk2N5rfk0V7Kw7sIqwqIR9mMTmWPjIamR6b9YS
X-Gm-Gg: AfdE7clJ3y9Tyz52LHEujkNAdgEYWOIDLLUQaJlqnI2+bIURnHXkGQ9Ts3G5WVJrhV9
	icacmzxk/rkWdsum/95FYlZeRsMPMQXWAPbM5lxIvukmY/sshMinhoX/xuSlRwh+2twTk65jMmA
	Pb1TlqvKBcTAHQ+1q9hYGeV0roAICKycqJWcCuwqEdz0a90MW2ELeTAJDS1udAsQavpzObyRLb5
	BfXOz52VGsHi1/YY2alRPmEB3CJGGJLOgTz6URk9uB9YMdrKhi+T3Ha7uelmo/cX/L8KP451+Fi
	IjJZzEbekcQ8N2btawUg6MQ+bZtNcB5MXcCSDDZbmx/FJS6sUNHZboDZUB2FLTC0Lt2rUBi09Li
	KtigLjcpQX0dTloo2mg/XF8iPuSkaKrZD2KKHThZBCJLFbhTyoWYwiAcSuebDLDMVGyaVSbWhtd
	6P3WVzT1OBO1/tIGuvEpRPx+CFgg+fvZ3ZGfgYxYEdB9pVUi94mg==
X-Received: by 2002:a05:600c:3421:b0:493:cbd4:8925 with SMTP id 5b1f17b1804b1-493ec55d788mr490785e9.4.1783547658604;
        Wed, 08 Jul 2026 14:54:18 -0700 (PDT)
Received: from osama.. ([2a02:908:1b8:2060:7550:b182:7bdf:fbd0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47df6a31dd5sm1032704f8f.16.2026.07.08.14.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 14:54:18 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/imx: ipuv3: handle PRG channel configuration failure
Date: Wed,  8 Jul 2026 23:54:16 +0200
Message-ID: <20260708215416.147586-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipu_prg_channel_configure() can fail when no PRE is available for the PRG
channel, but ipu_plane_atomic_update() ignores its return value.

Atomic check is expected to prevent this condition. If it still happens,
warn and abort the update instead of continuing with the original
framebuffer address after the PRG/PRE setup failed.

Fixes: 00514e859335 ("drm/imx: use PRG/PRE when possible")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
index d6806d1ae6e1..78a3ea0581c0 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
@@ -629,10 +629,14 @@ static void ipu_plane_atomic_update(struct drm_plane *plane,
 	 */
 	if (ipu_state->use_pre) {
 		axi_id = ipu_chan_assign_axi_id(ipu_plane->dma);
-		ipu_prg_channel_configure(ipu_plane->ipu_ch, axi_id, width,
-					  height, fb->pitches[0],
-					  fb->format->format, fb->modifier,
-					  &eba);
+		if (WARN_ON_ONCE(ipu_prg_channel_configure(ipu_plane->ipu_ch,
+							   axi_id, width,
+							   height,
+							   fb->pitches[0],
+							   fb->format->format,
+							   fb->modifier,
+							   &eba)))
+			return;
 	}
 
 	if (!old_state->fb ||
-- 
2.43.0

