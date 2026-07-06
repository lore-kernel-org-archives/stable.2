Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868AF3F1AD9
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335638; cv=none; b=d24mWQpawdKHXSTd/BDDpLHjYzfxZXhVKm0f49YO1ciKH6b6UzJsCoe8NgKjDy7LB/zbS3oRg+F8WkIhCcOjvRfHiIYGoQF5NoCTIbDYw7Iw9dYdMCOI3rwClD/Mhf5GIBKhgAg96aySdjD93jtLreVl16m9It25/fdzhIkG1qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335638; c=relaxed/simple;
	bh=r59EUgtIsaoxZtEmDgwSAtgrbkt8LgaNF7WBBajdhfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RD5BmQ9ARdYYI2ydwBVu2hmZgsac8OmkgTfBCqX8a4d1UqmShcD6roIbcBUHmnJ4vwE9cDEwFGDewdX818/zrLmGuMd/NLBhJHKFsGQcHPhn4TRuiDXoWqoyb4HOfJabAxmwhODekDn6mhvP5EHp9E1zI/ww/QXylDf3jfRzhHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue1umZFD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue1umZFD"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84794e800f4so1551299b3a.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 04:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783335637; x=1783940437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n0i9VdK/Ma3gHZKckXQb+1T7ww2+Cb/2KCUzwQQKXZo=;
        b=Ue1umZFDf6Ej1/uf2F/JGCGxBbNkkVdGUpw3KZLToNJwu7NRsoI4gypqJemzD1MGwi
         vU339z+BYdtjylLU0QmMZJbQQnENeanwQCmQ7/nSPFFpYQJV1UpllkMpgyxPFYi6ZN2X
         qr83Y8ZxxH1Wj6WbR4xN94YrEzS/M047vCySbj+JiN9+tT0/vcoFeFjhvlQhPqrQQOeH
         v7s+4Fn6uOD/FuGZPuhOcROFiBm0go40GloEaOMQnUGkf+DqycE/417X0RM7ZpZcCLdN
         TX1g8otxy7FDZkeJiba01BaXMRxLH0aHstkWuZP5/s5kIL5G/xYdIfcIID8RAXkf15M+
         NGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783335637; x=1783940437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n0i9VdK/Ma3gHZKckXQb+1T7ww2+Cb/2KCUzwQQKXZo=;
        b=ECrVe2rJiPHWFErF3Di6tjIxaBrIQ+rwK+thBigZwxOQpoky/9DNfPaEumV2nH6UKb
         F/iwAg6zQctMJnobVCYXcAnOWruHrqHExOn/33oEcSCtyj0BffzMDN6RB1OWXUn2etGL
         Mz6rEmexKxq96jqjNCe0HLQ1lF/Obigmw8LPFLIYavJicRP4N0aalAE7oXjyC8O5XqJV
         p0FKNaB55Nyon23m0B4pEndLSybSGcntrgn3/j+ecRi6xa5gbKqsBc3y2KsSy/aP75Oc
         TYOYVDMaxSqKR80iKtb40V1Z/bL9jTyOTDXEb1JA1ao42/Qgn4Rm6cfOgktCHDq59OfR
         ysAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpsnOOayOwRcW8KPLaFnX2BTvmC5Zqe91HvZHFDFkbeh/tHiiZNx5S8ZOdkWo4Vx8W5FCc1fjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPomJc1rTeDz5zuwX8ynqP7LXyxa4ECLv+DsjS2Ha81Bfn8Gfv
	sMn8pclPah+TqRuVmwmmgCgvad40dajpKttl6jh+tbSX9ajDdkNBVzy+
X-Gm-Gg: AfdE7clvjTorh0hBsxANc1GtXDv5FBD7I7uk/lbYMHejqA0HDUjZfixqvj5ubhbMlG9
	W+lydD1F569/kEzPxeTu6fh3dXu5L7yrD6IRKVLg/1fKlKFd6WrqnKgjiZMXgdO2+Md0E6z1gL4
	q12RtUnfmMs9kzdq0cMGbEVz0cis5XGsUYCrrd+ZSdmSpKKAAzdnF/+e/ir5LeAavzQhNotkrqY
	U65MZq+TlwLacVTQeUrscsx53DF0pq6y/ZeRZuDcwbyxLF8KDH6xPuLoxB/rGunN6Stx0fsFxa0
	HbWbSNig68St9h63rz6HhlI9mq/wQCjzqmYjBi9Muw50rHfr5CtY7lBa6LGSdEyOovQF6D2xIMX
	4Zsqe9HH/tJ/VBVdk8D6QzCOIofD/jSJ2ViFajTaMvq7cJ5RHv2RuD1mPcqLnpD1/9oQ4Jd2u/r
	BnZOrE+jGM7I/1+WtMRjzHvBrVWV8+YD10ehveNMi5fZUfkHyaHLYEhovZFO9ujo1H3OVZeUX0b
	972/mP5
X-Received: by 2002:a05:6a21:2d46:b0:3b3:1b38:d9d6 with SMTP id adf61e73a8af0-3c08ee3658cmr63419637.39.1783335636463;
        Mon, 06 Jul 2026 04:00:36 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7ef728sm47797381c88.3.2026.07.06.04.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:00:36 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	luca.ceresoli@bootlin.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	tomi.valkeinen@ideasonboard.com,
	francesco@dolcini.it,
	leonardo.costa@toradex.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: tc358768: Enforce input bus flags via atomic_check
Date: Mon,  6 Jul 2026 07:57:45 -0300
Message-ID: <20260706105840.1582166-1-leoreis.costa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106141227.899054-6-s-jain1@ti.com>
References: <20251106141227.899054-6-s-jain1@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leonardo Costa <leonardo.costa@toradex.com>

The tc358768 declares static bridge timings requiring pixel data to be
sampled on the positive clock edge.

However, the DRM core default propagation simply copies the output-side
bus flags, coming from the next bridge, connector or panel, to the
input side. If the propagated flags are incompatible with the bridge
ones, the data is wrongly sampled, typically resulting in visual
artifacts on the panel.

Implement the atomic_check hook, replacing the mutually exclusive
mode_fixup, and set the bridge state input bus flags to the ones
required by the tc358768. The sync polarity defaulting previously done
in mode_fixup is carried over into atomic_check unchanged.

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 0d85120fcc7a3..0516a331e71ba 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -1262,10 +1262,13 @@ tc358768_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	return input_fmts;
 }
 
-static bool tc358768_mode_fixup(struct drm_bridge *bridge,
-				const struct drm_display_mode *mode,
-				struct drm_display_mode *adjusted_mode)
+static int tc358768_bridge_atomic_check(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state)
 {
+	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+
 	/* Default to positive sync */
 
 	if (!(adjusted_mode->flags &
@@ -1276,13 +1279,15 @@ static bool tc358768_mode_fixup(struct drm_bridge *bridge,
 	      (DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC)))
 		adjusted_mode->flags |= DRM_MODE_FLAG_PVSYNC;
 
-	return true;
+	bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
+
+	return 0;
 }
 
 static const struct drm_bridge_funcs tc358768_bridge_funcs = {
 	.attach = tc358768_bridge_attach,
 	.mode_valid = tc358768_bridge_mode_valid,
-	.mode_fixup = tc358768_mode_fixup,
+	.atomic_check = tc358768_bridge_atomic_check,
 	.atomic_pre_enable = tc358768_bridge_atomic_pre_enable,
 	.atomic_enable = tc358768_bridge_atomic_enable,
 	.atomic_disable = tc358768_bridge_atomic_disable,
