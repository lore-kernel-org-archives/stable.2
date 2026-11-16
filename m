Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794826409;
	b=z8LVTXj2B3blRZVW3lZvRrs0XX0pTsjpdZOtNce3yixnVpxM3nDW6nW28Q7EtdLZU6+y
	 0wwaxkCw1yTxY4zkmc5wvWjQGsXBRk0l18ob68G1KpPV05Lwe7j/2CdPEChyKjvaP0nRl
	 4ksnBSnh1IHS4fgzFUOgg/2KbTWdTmXbqy21LktGethnYZWVr1QnPVbj7J5/8GQy0qOHt
	 clzfjI3qU3aio6uVmQt3HbpQTJl/zuqkDPRwTi3UjISHW40qZay8mqDno91IyMDz68NWu
	 EOUPR6kBMOW1eW8AAyuWjUHfL8KqlhGDW1hAw8K6DdPxBlGmtJ1lmF//08r313zC6yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PAvLjaQHm95bpI85WuhjYZDGCvdWFtQOLeuhomlJrGw=;
	b=aj1SaqDOiS3L2GGEXkZCr1VwlMBFbi1r0NCUfBoYsuJ7geHVx/d8zW9UIc+mFiKWGt6x
	 yK3ebc+1BNXW8niohE3VYNhbtmMRW1msUrEcIjPZqjTTX1Pa8kxJPpUJDuD2JMBsqqjJ7
	 yQyDwPShk6W/AXuCvUVu+BN9AF/HhPBvoRCKVVxvWxPQgQ6/0gZiY8QvYJqoBNWS/HZUd
	 /TXaH+WPesy9ObDiUL4hkCixRutAUHGlSPhH9nWZCLyJl1dcnUtTNAfAYubagPYcxMCvc
	 2JqWqrpfk7nvaHw9ekViCARSZrLFGOKsligACLLM4LK8+8PM20M5X38Le5OciC0f7bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z3Ea0nlK;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2253E606A333
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2253E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z3Ea0nlK
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so3566467b3a.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794826408; x=1795431208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PAvLjaQHm95bpI85WuhjYZDGCvdWFtQOLeuhomlJrGw=;
        b=z3Ea0nlKzoHzWrHQ00kEDJl5rfOB2Dg7M+zjuDwFFVeBB1B41crdVBP2TX0y6p8Xop
         2gxeoqI0JOQJaigUbRP1y7Z01mOIqd0eXV3Rn2TSyHontQL5gyoGWDO6hBlrnqyXQ0sl
         S8RaDDEvazFivPJ2N4Zy7MqbAq/+85l0ppFvkPD1purZvKrq4PGmdkA5qtHqOzKlK8Ta
         /z4lAL45RJ7TbpKpDqOKOOUGj+D45dgmYTBejinZQFcwmxBKT+tSjGGH6JoafZRH0cBm
         0jM1fZgwW95QXXGkqnP0H2BBG8AVF0trDAL9o/SWv6PSeJJ7MPajgtp2yqtGRHmUPzmk
         lOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794826408; x=1795431208;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PAvLjaQHm95bpI85WuhjYZDGCvdWFtQOLeuhomlJrGw=;
        b=QsBuUamdTZG+ichsntyN9G3QeqqAdIQYEos67vZNuhmsIxeSPDRTZ1gPHq2TWtw0DU
         liJarVBqE8NFKLHveuNhYfDkovPjW5VSR35FBG0XBY7msNLzBGaJoCQRFQfPP96CVfA4
         yNNIYimntA6KiYgtWva7sl3yOGtmZ0dOGTogSVbUC9NuXqdn6GH997/ZcdXsDg1b7ThZ
         lQgRGMZfQnaj0WXtOmH5YaL6nXnItkWWzZT/rV3qNlArq9gqZoCBQrgtuALU2oIBTTZs
         yTl3eM3n5dcLJCSY3GTmCUj4Dz6CyIbm4zDi29BZWeNaFKqAGZUet4QVBXdDwuZVbuqR
         z8vw==
X-Forwarded-Encrypted: i=1; AL+hErE3Tce9daxo4rg/bPObNx3DfmgDJOyjDxOTpLrzDpMyCig/6Chlo0nPbRuzuJk/2nz6jdOCcEM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/q0AsPASA4mnrKNRrEq+DX4wG2Xcux2EcN2Mr685hPicIZuU1X
	SxHXrlgjXUJxTB0vBrY6U0MeovxWwW/XRW2ypyT1GA0conlf6cZb9Hth
X-Gm-Gg: AYBFou2IQqJEbjej3xssDDijvWk/AG24jYrHJ4Qtq5UCAnJvJN/xYNRiNB8bTCdQnCa
	IPFyLBygkf5+ax4knTkVP+P7UFwg1/VgBF4AUW/lbMZTa8hutyT2LtfCzLyqGLHzYnTMt/EdbGV
	xPpzPu8rrQVZToMyL6WLZUNkuOYVPgWjD1vxxZxMFP7eIRE7MyWxPvPu0ThJnQ03Q4DTe/Wv6r8
	dRzjtrbqYQgqviJUQ5hm6jCiOC97J+WOWCQksjXrstSEgwgcxXiA/aOvGo9hps1q8IOP4p+ntLL
	g+ULCeNhtEZpFD0FZLWQJLRJLnXCvCEqkvn8LobDFBMUD1R1h4WJTPGtpAosquRPvqod290IfNz
	jtvOh+qDDW75rswkFu40M6Qc3clZiGr2G51iEBmPCLQP0fTp+Lo10d/8soCRG/W6WC99ELN+5Nz
	MDkiThsA1VZxMYuHYiakDteMKL5e4qK8fJpzjEhyZfmreI1MsYo00awY60yu1vEYsdj7o+2xLCx
	Db+JPwUsAUjiB0z/1sLirXaxTgPFTeruhQjt8qfjqjsbw4tviEgg9kgWDbP5u5bIlFES2uckLC+
	z6EsJcwImjXVs3qI7N7PTa5i/ElYsvBXdQM=
X-Received: by 2002:a05:6a00:94c4:b0:89d:7f51:6492 with SMTP id d2e1a72fcca58-8beb65953fdmr9351345b3a.32.1794826408064;
        Mon, 16 Nov 2026 02:53:28 -0800 (PST)
Received: from leonardoc-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed263b354sm3407230b3a.47.2026.11.16.02.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:53:27 -0800 (PST)
Date: Mon, 16 Nov 2026 07:53:20 -0300
From: Leonardo Costa <leoreis.costa@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Leonardo Costa <leonardo.costa@toradex.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: simple-bridge: Enforce input bus flags via
 atomic_check
Message-ID: <mvwowftpwgn6vypc25fkqgajpizsnnmkceoaclot4ms2b43y56@q2oiqnpwrled>
References: <20261002-v1-simple-bridge-atomic-check-v1-1-ef5d8332b078@toradex.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-v1-simple-bridge-atomic-check-v1-1-ef5d8332b078@toradex.com>

Hi all,

On Fri, Oct 02, 2026 at 04:15:23AM -0300, Leonardo Costa wrote:
> From: Leonardo Costa <leonardo.costa@toradex.com>
> 
> The input bus flags set at each bridge's timings are never actually
> added to the bridge state and are not considered during modeset.
> 
> Implement the atomic_check function, to allow simple bridges to declare
> their required input bus flags.
> 
> Existing bridges that configure specific flags (currently the ADV7123
> and THS813* bridges, which set DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE) now
> write them to their bridge state, and have them propagated to the
> previous bridge in the pipeline.
> 
> Fixes: 0a01de65a741 ("drm/bridge: simple-bridge: Switch to atomic bridge callbacks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> ---
>  drivers/gpu/drm/bridge/simple-bridge.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
> index 3fba7002322e9..848c2df2a276a 100644
> --- a/drivers/gpu/drm/bridge/simple-bridge.c
> +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> @@ -158,11 +158,23 @@ static void simple_bridge_disable(struct drm_bridge *bridge,
>  		regulator_disable(sbridge->vdd);
>  }
>  
> +static int simple_bridge_atomic_check(struct drm_bridge *bridge,
> +				      struct drm_bridge_state *bridge_state,
> +				      struct drm_crtc_state *crtc_state,
> +				      struct drm_connector_state *conn_state)
> +{
> +	if (bridge->timings)
> +		bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
> +
> +	return 0;
> +}
> +
>  static const struct drm_bridge_funcs simple_bridge_bridge_funcs = {
>  	.atomic_create_state = drm_atomic_helper_bridge_create_state,
>  	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>  	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>  	.attach		= simple_bridge_attach,
> +	.atomic_check = simple_bridge_atomic_check,
>  	.atomic_enable = simple_bridge_enable,
>  	.atomic_disable = simple_bridge_disable,
>  };
> 
> ---
> base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
> change-id: 20261001-v1-simple-bridge-atomic-check-e7b7eb8381e9
> 
> Best regards,
> -- 
> Leonardo Costa <leonardo.costa@toradex.com>
> 

Just gentle ping, could we get this fix merged?

Best regards,
Leonardo
