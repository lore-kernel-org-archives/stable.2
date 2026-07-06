Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CC541D4F8
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337936; cv=none; b=CxVh3euKzu3SjJEEGwN83dAVXGtu2R5iddUIMTGD3/ayf5OiVhW9fjTzw/wuXdGlmECsdTzx+acOwcRA/2ZSZKYJbQpwXg+aAWuNF2Kf0Q8D5xXb+MIatBKciHYicgR449ZAzTSgAAw7WBeh3oCrAG9hoMo4TGKBwopNu+sycZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337936; c=relaxed/simple;
	bh=7sAeWkd7EwlEsoCRUeUm175QpZ9wzHwghbd3UXK25OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGjxA0R2rQ202pCimBWA/tqE+VzhHMVSxpa1uRppIkXSqlXVj3emJaH944hRzR7YU6P9YJRgjU4onq+kcJAsBjUexo5D3/RiNGeU2gqxFdAXacqPl1fqPMb68EuxWPHZmRmkYrcwGLRq6JTnZuLodm7G+eonRRnURTg3E8PbnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvK/Hbn6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvK/Hbn6"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3817f800c8bso2027730a91.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 04:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783337934; x=1783942734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPiB1VecAR3TN1u8hRdYEbrIAIhOnDTmSxtVCqyGQ3Y=;
        b=mvK/Hbn6C3GajLr04bOG/ecwTbmfmm6pHZZ7LY4p89pdJ3v3rdQzhDFRQW/A5HiMCw
         9zULrIHngYM/c8fdUQWS+atr0E/rZuplm9GpBnoKhSOTJHo+JC7A8DQK2Kk0CwtDFFSS
         ufAkvVoMr4/zc+Vd1pB9tDGd1N+eXqj0ztn8snMpBezK3nse5dDIX6JFPl8X3eW6Z44/
         BQgytokyVcUPVp9tpbNTRP5au9Wtx3HKvcITyrySvaOQJ7EIwULzOaL0FwMdQCS+kQ/v
         2oZGCl+3X38vUrvWkWPgj2+8WG6DBBQw6Qn4sbqcOR8hRC8HEqtJCOZDEF/wF+lW7cLT
         Cc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783337934; x=1783942734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XPiB1VecAR3TN1u8hRdYEbrIAIhOnDTmSxtVCqyGQ3Y=;
        b=SZAVjnkOUwaW+7AW4s98XZ6iW6AX5lwVxcRE1aSWSXKHayDJJFtG2ff4amj7TlCx9+
         StqoUbgAKuUTQotxahpMI1gNBXbAe0c3CkN2O6OAY5ycjriQrkwGCvOTCwerOBJSe/A0
         Q9QYermqTKe8pi7I4O5WuoVixG2e77xPidzQUmBwRWw/29y5VDLHNC31bvb6JAsBrtCh
         pPNX8OJM8/WiSbo++mSgrwUELlKJlch/iafStf0uCir7okTNlDdE3cM/TQAVq39EXsJQ
         wj7insY2f4YH9fCwnjJ+FUbrpLWDkVPgNM5NCWhrGiaTKEjaQB9jySLM/XA19mY/rwYH
         Dk2Q==
X-Forwarded-Encrypted: i=1; AHgh+RpiL89G94mcBiyY26e5mHcCzUfxi7BJzMhfqr/tHjMneWuz0/yZeuInNpz9rJvcBtYxyE1MwNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx/2vW0FVARFIoRFjVk4i1alUkwqXB2IH7lLojFrKJ/ZrDvFS8
	NdgkcJogZjAj2koP8usbHcs5d0nLnLNVye3T1CzVTlkOFMDhKHIPdrpY
X-Gm-Gg: AfdE7cl1LaQfd251n2DNuuTNpESsqqdg1YJ5bFjk0LSlPNqziOMHxasdeSy/4BfrY4r
	j00bY5++ZKpAd9xM5QDLHtZr7QilUnTNgrHJGe7G7DQkOhtRASD8qcF5U5H+NecO5MaxzM/lzU+
	zvT5xK8TAGC2VqCQ67GfH2OY1iZQbqUP36GRm+Zu6x6IlW/x+hVcuOHAJYVm4bNKrdXv6tG4PoU
	4mfrXBvUwuVhCnTxlc9KQr5Ysa54aFGmO4/TDkMx0Y2HE3FkVeKlhC0l0qqC/gvuTwuQ0jsvknN
	42VWMpPtssnPszpcg1mtOWbmhQVp5mh2vWR/YCrEG90Swm56TrYrcqethdVrd1KEcQ7Jq6Mzccv
	pHsyCZeriPTXtnPLq0KSyP3xj222NhiSDl0S6/tCGw/6KPFmE9r1VK9mZ0Pv5pPzGFZKkwviI87
	Acg9fZIntYzv3ouxH2rD1OehNysodgMarqPvIN02lBwFYcSYCSrKGPHI55Xtlsnj4hrSUpb96DX
	VvXSVKJ4PgQMhOv7B8=
X-Received: by 2002:a17:90b:51:b0:37f:9cdf:f0ab with SMTP id 98e67ed59e1d1-3829f9debb6mr8700704a91.26.1783337933770;
        Mon, 06 Jul 2026 04:38:53 -0700 (PDT)
Received: from leonardoc-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31151fff32fsm18581752eec.21.2026.07.06.04.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 04:38:53 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
To: leoreis.costa@gmail.com
Cc: Laurent.pinchart@ideasonboard.com,
	airlied@gmail.com,
	andrzej.hajda@intel.com,
	dri-devel@lists.freedesktop.org,
	francesco@dolcini.it,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	leonardo.costa@toradex.com,
	linux-kernel@vger.kernel.org,
	luca.ceresoli@bootlin.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	simona@ffwll.ch,
	stable@vger.kernel.org,
	tomi.valkeinen@ideasonboard.com,
	tzimmermann@suse.de
Subject: Re: [PATCH] drm/bridge: tc358768: Enforce input bus flags via atomic_check
Date: Mon,  6 Jul 2026 08:38:36 -0300
Message-ID: <20260706113838.1586775-1-leoreis.costa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706105840.1582166-1-leoreis.costa@gmail.com>
References: <20260706105840.1582166-1-leoreis.costa@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

> The tc358768 declares static bridge timings requiring pixel data to be
> sampled on the positive clock edge.
> 
> However, the DRM core default propagation simply copies the output-side
> bus flags, coming from the next bridge, connector or panel, to the
> input side. If the propagated flags are incompatible with the bridge
> ones, the data is wrongly sampled, typically resulting in visual
> artifacts on the panel.
> 
> Implement the atomic_check hook, replacing the mutually exclusive
> mode_fixup, and set the bridge state input bus flags to the ones
> required by the tc358768. The sync polarity defaulting previously done
> in mode_fixup is carried over into atomic_check unchanged.
> 
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> ---
>  drivers/gpu/drm/bridge/tc358768.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index 0d85120fcc7a3..0516a331e71ba 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -1262,10 +1262,13 @@ tc358768_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>  	return input_fmts;
>  }
>  
> -static bool tc358768_mode_fixup(struct drm_bridge *bridge,
> -				const struct drm_display_mode *mode,
> -				struct drm_display_mode *adjusted_mode)
> +static int tc358768_bridge_atomic_check(struct drm_bridge *bridge,
> +					struct drm_bridge_state *bridge_state,
> +					struct drm_crtc_state *crtc_state,
> +					struct drm_connector_state *conn_state)
>  {
> +	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
> +
>  	/* Default to positive sync */
>  
>  	if (!(adjusted_mode->flags &
> @@ -1276,13 +1279,15 @@ static bool tc358768_mode_fixup(struct drm_bridge *bridge,
>  	      (DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC)))
>  		adjusted_mode->flags |= DRM_MODE_FLAG_PVSYNC;
>  
> -	return true;
> +	bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
> +
> +	return 0;
>  }
>  
>  static const struct drm_bridge_funcs tc358768_bridge_funcs = {
>  	.attach = tc358768_bridge_attach,
>  	.mode_valid = tc358768_bridge_mode_valid,
> -	.mode_fixup = tc358768_mode_fixup,
> +	.atomic_check = tc358768_bridge_atomic_check,
>  	.atomic_pre_enable = tc358768_bridge_atomic_pre_enable,
>  	.atomic_enable = tc358768_bridge_atomic_enable,
>  	.atomic_disable = tc358768_bridge_atomic_disable,

Please ignore this, as it was not meant to be sent in reply to the thread
above. That was an accident.
