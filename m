Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E56D385D9B
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344428; cv=none; b=tsUKNn46ypHHvJv76J20yJ/oUN/IBlfbYZNRgH4ck/dcFEZXXDG1Iq14Bum8/+Uw3SKpXR7v72IYjzLlRhV0nC6B4jxYq99qX+e7Sjx+Fc0ksnHvc67zMhteuMD5OVRSWBSua9OJHjnKvJALYQzA1Yc7h70XACsww5VVk0QrTp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344428; c=relaxed/simple;
	bh=r59EUgtIsaoxZtEmDgwSAtgrbkt8LgaNF7WBBajdhfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQdrn3q8sNr6HH54+vfKTrjY/iya63EURdEyNyweMICMSCpSqiN8n8teJ2qKN40VJyT9rr0zPaVqGbKZ/aWE+BCC5aiMpyEJI5qEXGAg+gwKescdMC6qiBQ9/5yq0CziUX/wUFLWAsXcIfusAHNfSffRDHPvTZaAVREMlRSG2yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOG4Jff6; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOG4Jff6"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso1637551a12.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 06:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783344425; x=1783949225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n0i9VdK/Ma3gHZKckXQb+1T7ww2+Cb/2KCUzwQQKXZo=;
        b=QOG4Jff6djVIViTWz1Q3hLEV4bLPsWHn9vBIfA1dMtVRTFsyHRdIjXX0LSf1BKh0Yp
         GglmX0vDvykiIoXcd8kCdTLoQ39DUryaIS83GFy5DdzISUUWCKJJLgcmGLKzWBlvbcKV
         U8HSoE3DssPRm7FcobPdvksh6roMquR5E+RPAsFWxoKPKjm51jbPdTbdk62C2h7yIwUC
         EdjsQlS71L9/p+1bueRRrqdXApRfgoBZSdZPJG8mlhXX7s16RQeMCj5ybSa3k14N4oRo
         15uR97NtG3Cy7O2qseVn/+D9Q4vLfEz2EquJlowRha+HXatMQq2SCcgiVe/S+pMGD5cI
         UASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783344425; x=1783949225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0i9VdK/Ma3gHZKckXQb+1T7ww2+Cb/2KCUzwQQKXZo=;
        b=j6u8RBNigk5pEQL40Kv/wloRreQIqfTszlSZL0Vfmy1/q3jq5JMqUcpcXHiJnzaMik
         mY9nmq2YaFuRL9zCRRicVPvbbe5xn9VhWUm1orEOPthCJWML02YdpEpyR7/L2dFRjLSc
         ml/j2vkRJnz9nyAJvnRLKlnGN48Fd47DPKO+GKxuitrQEXAcHazyNT99jmCu1L+Pshn/
         7ZRUAVbv7j4Xgh0IsBrFBgKAuU/VzWFkFnrQQFzcTObqBV3kpNkg048ux7esvhypz3os
         4nrhE74FCYdfJzWnNLqL7BOSrgXhvo6+ukUuYihLVp7In0lrFnCJj8GWfyssM9rk7Dx3
         s3OA==
X-Forwarded-Encrypted: i=1; AHgh+RrrbKiGG0er1RWcQWSFofDIqsgGBSYl66C8YWN4XdeYllZTZV0CeR9p+yt7wTeC1dI9h0XRYnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZi4ngknhijKnet2lu9v84Wsbgh4Jfh5IY5Wggt366aOLO+A6V
	ZdZROwDmrHk6assvzYovBNLMMT3eWZS1BwsoXjjM/vBNQvKlnh9V0lIH
X-Gm-Gg: AfdE7ckgt6z4RJCyrO0ec2tyjdiXBRSOpiY5k9Bzk8YVj5qXdww2XVsqcnu5V+aqLa0
	zFUIqYCfficfkAk4SmcBBxS2r2WWX3uCHXCwufdsA3DfJYBSubys2jVQpfs9My+ccCwjE9EmV8/
	k7fIm0Q4zr4c0CZkIO7qPA5kJsR0cNj3jqD7VtEOGRaBhAps2maMmP/m8YQECe0SvadR8lexeh+
	Gg3olLw2qQ68XDJdZFz365IiRcGVYZCnz8RQFH21KBiDD7FdZ637FG5AmiJ2oNcnKIwBfFufJ/J
	VrLH8edQtMUPTdb8kQNzvCIDlgk8l7rv0kdEytsTVbqYHMhslwrjZpRfyWKFE3tyNyslrAeEeCH
	7zjl+bXsOq9v5exj/5RVsVTl2nW91ehcOsJ01+OiHDD4rwJfPCHbekaOm8ujWeRSqWE//PlujLj
	GliLgj8UnxyZLoTgxeTD3zPoRcMWj+3qlQuAF6ICyuFgwbSPExXyY9mdMqVMra3JwFMJWc25x+O
	j591nnb
X-Received: by 2002:a05:6a21:4c11:b0:3b2:8674:9830 with SMTP id adf61e73a8af0-3c01c65ff4fmr14772604637.14.1783344424235;
        Mon, 06 Jul 2026 06:27:04 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3114fe08b1bsm17734598eec.26.2026.07.06.06.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:27:03 -0700 (PDT)
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
Subject: [PATCH RESEND] drm/bridge: tc358768: Enforce input bus flags via atomic_check
Date: Mon,  6 Jul 2026 10:24:17 -0300
Message-ID: <20260706132440.1594239-1-leoreis.costa@gmail.com>
X-Mailer: git-send-email 2.43.0
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
