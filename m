Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B949346A1E;
	Tue,  2 Jun 2026 21:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434065; cv=none; b=S6NXfOYfKt8biB0CMKHH/0ezVlY5snGgvOJe9F8+YPoZTHzMbowJNMCwgIIK5D9qFus/ByP429dOuwOn90Au5fmnKhBPhLV2FUBuN6qgFQblN8GZec/NB3S126ClwZS15L9uD2rILoU4Lx04SuDSiyjDXPVLLxorYfkUbEuXF9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434065; c=relaxed/simple;
	bh=Nm41nf7LMZhJDpK1ZklP3HkjMp0TeaGHvlDLxKRJpWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUMyoRR+SdA4ge8w3diDGj+lluHVhF+wZ3L8SZP/vJvVl1YqLAdICb2Fu1Z1qFc0J02IPQXc8l1Z2imMQcBS5//G0UYcu0hAVPPLk9CIToiwHSUfldROI0fFA/8H1em1D1Emk/R95qo35uXfaPJmdVZWUSKxHQTzog1wWiBGFrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=g/vOA9ES; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="g/vOA9ES"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1780434056;
	bh=Nm41nf7LMZhJDpK1ZklP3HkjMp0TeaGHvlDLxKRJpWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g/vOA9ESm5QsZvtz4J+owM+EoVL5A3D+rQ2Zhp9PQdWUE7BDnbd1vQ61t1XtRy9Im
	 Sl1+4vpvjKcnq9N03fpS+75IFtSkfKa8E86ThpKFublJB7EEXlANwsyZ6MAYAuUUHC
	 /Mg86spic96cnVeVV7loKAaCpqllQ+ObO2XuGnS8mVRQ+Rn8k9/3RTzlh5WhBG77WD
	 Lpjl/L/t5SJ+5LcP8G+PgLYNci8UNI2bYOrcz89JKhQW0AZyaUBhU3efJoNXOohY5/
	 3PC/SNg+A3iK5/KiHaeue6nii9FOsnxC5nbWJFHSUi8fVJVsO7br0IFAWadnQIURL0
	 AJEjYaw7/kM7w==
Received: from [100.64.0.241] (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3171B17E09B8;
	Tue,  2 Jun 2026 23:00:56 +0200 (CEST)
Message-ID: <b89a3039-05b7-4e4f-8306-07a37d2bd3c9@collabora.com>
Date: Wed, 3 Jun 2026 00:00:55 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe
 when PHY is down
To: Frank Zhang <rmxpzlb@gmail.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: detlev.casanova@collabora.com, daniels@collabora.com,
 dmitry.baryshkov@oss.qualcomm.com, heiko@sntech.de,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260512103153.8861-1-rmxpzlb@gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20260512103153.8861-1-rmxpzlb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Frank,

On 5/12/26 1:31 PM, Frank Zhang wrote:
> The following panic was observed during system reboot:
> 
> Kernel panic - not syncing: Asynchronous SError Interrupt
> CPU: 6 UID: 1000 PID: 2348 Comm: pipewire ... 7.0.5+ #4 PREEMPT(full)
> Call trace:
>  ...
>  regmap_update_bits_base+0x70/0xa8
>  dw_hdmi_qp_bridge_clear_audio_infoframe+0x3c/0x58 [dw_hdmi_qp]
>  drm_bridge_connector_clear_audio_infoframe+0x2c/0x48 [drm_display_helper]
>  ...
>  dw_hdmi_qp_audio_disable+0x28/0xa8 [dw_hdmi_qp]
>  drm_bridge_connector_audio_shutdown+0x38/0x68 [drm_display_helper]
>  drm_connector_hdmi_audio_shutdown+0x28/0x40 [drm_display_helper]
>  hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
>  ...
>  snd_pcm_release_substream+0xcc/0x120 [snd_pcm]
>  snd_pcm_release+0x4c/0xc0 [snd_pcm]
>  ...
> 
> The root cause is pipewire tries to close the HDMI audio device after
> atomic_disable(), which sets tmds_char_rate to 0 and disables the PHY.
> 
> In this case, dw_hdmi_qp_audio_disable() will call
> dw_hdmi_qp_bridge_clear_audio_infoframe(), accessing register without
> checking tmds_char_rate.
> 
> Add a tmds_char_rate guard in dw_hdmi_qp_bridge_clear_audio_infoframe().
> Decouple write_audio_infoframe from clear_audio_infoframe to avoid the
> redundant check in the write path.
> Add PKTSCHED_AMD_TX_EN to the clear mask to keep the enable/disable
> balance.
> 
> Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
> Cc: stable@vger.kernel.org
> Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
> 
> ---
> Changes in v2:
> - Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
>   the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
> - Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/
> 
> Changes in v3:
> - Add a tmds_char_rate guard in clear_audio_infoframe path.
> - Decouple write_audio_infoframe from clear_audio_infoframe.
> - Balance the PKTSCHED_AMD_TX_EN bit enable/disable.
> - Link to v2: https://lore.kernel.org/all/20260418101936.7731-1-rmxpzlb@gmail.com/
> 
> Changes in v4:
> - Update panic stack on 7.0.5
> - Link to v3: https://lore.kernel.org/all/20260423081514.15444-1-rmxpzlb@gmail.com/
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> index d649a1cf07f5..1c18f8650fcd 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -886,11 +886,11 @@ static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
>  {
>  	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>  
> -	dw_hdmi_qp_mod(hdmi, 0,
> -		       PKTSCHED_ACR_TX_EN |
> -		       PKTSCHED_AUDS_TX_EN |
> -		       PKTSCHED_AUDI_TX_EN,
> -		       PKTSCHED_PKT_EN);
> +	if (hdmi->tmds_char_rate)
> +		dw_hdmi_qp_mod(hdmi, 0,
> +			       PKTSCHED_ACR_TX_EN | PKTSCHED_AMD_TX_EN |
> +			       PKTSCHED_AUDS_TX_EN | PKTSCHED_AUDI_TX_EN,
> +			       PKTSCHED_PKT_EN);
>  
>  	return 0;
>  }
> @@ -989,7 +989,10 @@ static int dw_hdmi_qp_bridge_write_audio_infoframe(struct drm_bridge *bridge,
>  {
>  	struct dw_hdmi_qp *hdmi = bridge->driver_private;
>  
> -	dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
> +	dw_hdmi_qp_mod(hdmi, 0,
> +		       PKTSCHED_ACR_TX_EN | PKTSCHED_AMD_TX_EN |
> +		       PKTSCHED_AUDS_TX_EN | PKTSCHED_AUDI_TX_EN,
> +		       PKTSCHED_PKT_EN);

Is "avoid the redundant check in the write path" the only reason of open-coding
dw_hdmi_qp_bridge_clear_audio_infoframe()? 

Performance wise, I don't think there are any real gains here, so we'd be better
off reusing the existing code where possible.

Regards,
Cristian
