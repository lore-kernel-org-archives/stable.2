Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9D048DB4F
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174727; cv=none; b=kEn59+aN2U/3p75c2Y2B0ri19LVSRFvMcZEdwH0pZXtVMmUW0j7VLLQRzR44VX1rcUi9wCXINNGaXt+UdIWOMjdfN9KAp2wCBNMYlD0crVXW3FsKTw2gdGfwbPdfyUO3BKY5hXf7CdabRYj1eCAWXmH5jVFJ1dpJnkDD4VH4RIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174727; c=relaxed/simple;
	bh=cv7M+dN044DZi58xzYZ0UJyxuBaQyZGB9jKAovpJDq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cx1kTgSvRZm787rixFdwW69zt5IZ/CAH1xjEunDfmULzkMSlp2y9+z1Y5lhnfnXFFrP0+xl3ht06Cfwfff2cEiJZqPPKOoDC3vGppWA4+DvOLLQ7lixGeU4LRa+oTiUm9hmx0aj3f4sSBfdyKIBhbB79HV2+V366ppezw37lyGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3DNfDb7; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3DNfDb7"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso242159a91.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 11:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792174725; x=1792779525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h9A2Yfj731x24w4qxPFGevwuk2PrCtFEa04ZNqz0+k4=;
        b=h3DNfDb7P5tOc84dkYuDtQTl+1aP3E5flFzLAkw6VEnPLAKugnv3YC4tEg9APXRF/O
         ICM3G7cQg5Vc9QsMm3e4B8eJDPCdQu5O7laa3pkefJily2LMaQ2si2WQvW9N403sfSux
         KjYY2jPdVVE02C8kSprKs1m14tkCje6f8+yWU6wD27jPVcNvAM4210qdDjxRsEvWl+nM
         aW7btW4oSLpslIXqOiNPj37Od8j5mjjjwWm1e6nfq0c4KitZV+Jyz0Z8r5RI+T0eTpKS
         nr2ZdKHYK+5HerOlZ5MAEINPad62zj+SKtl9L8dPp83/xzNFfERIghQzcxoc73Zfj8O0
         aMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792174725; x=1792779525;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h9A2Yfj731x24w4qxPFGevwuk2PrCtFEa04ZNqz0+k4=;
        b=PzIdnfD2QnWUNpeJKZQW7zBXMnbJcNvw41anbFZVAEf2xge+9F8GU2/muo6qKviux4
         Xs0oFoRsJSvBVJG+BfozNfl9SuGSaLmdEswZ3x6lV+U/nF1YJQtVzwWMG5yKBjijhFzS
         QW9jy3xHMJxxxIzorXTfc+ozDUHc0+UzdSs7/f9a3/q9d+SvmZrwi2pCMhU3v6jwHU2Z
         NsCG6fiNPhrmJeSEwgL/eiUXP6HSC3DkfoK0Ou62oC2MJ6ZnoFTurEpBj6+4rHvHLhBb
         Hs8X2I3McQ61gPbUNiR/YHVlN57PSrsHMou0v4m0dxguiUUjYd/SZOtup4lSrKpL+pFr
         utWQ==
X-Gm-Message-State: AFq9FYLfPdUWtL5aGd220kkLTnR8+WnVtL7DeMVPuNQ52+F2NPJr70b+
	dd9p6Itfrka1fy3lE59ot6PgFeFhfejRHTruBI0++jbo3yprGv8Mq5bsEI1Jk4aSAaY=
X-Gm-Gg: AYBFou1++26UCkzQg/A0G/uNYyV6g/gOSzbQxtKic8rC/8/3cVoBtk4ecVS1yDVvY+z
	CsHPyUD7gp4ofnEkbWFHQNoqT9tpwrq7+xOrha5c/EofPpuPMqJcqy3YBCZqSBgNx7eTbBZbIl6
	t1G0uOsHDxIzbgbaDmwLom6iOzInLLefkZl/CQIuy5hky9iAsKH6UWw7hAezCbLr+ry1ZWQf/r7
	7WIXaN8vDVuNSnVURlWpGbwz+MMfk7VcHQIQ1oxVUUT/bElnbwmqISptyyWYxPwESkCDkANxJBC
	lUVDZCwk3mwlr1K1ZNQdYB1NkZVwxKcse4X+A/nh1h+uivbb6yI+E7PTgWtM3Uwg/jkLY3B6nkf
	7dDenAEoewzrVwbs9Wob+25Y74H3LeVJCZOSXhsr+r2T/jXn7FvILAvdl7fMYvvKJ1zZE/Mds0Q
	R6aaBeLD/GS++yPuJ3JcfbTRMh6Fs8Zt9NMT8dREuX8YDKmVvD9fkAXfPeYdTFXFpocxyKPouAQ
	3wmnLAmhnCJGLk/UcBdfbgYgYaNQuJVP71tdTRFo7aBksWMn6abMr5G69WaRnWaA+nj/RMd2+WW
	6vqAKmfoQ+/d0ejbFqLDaCGmFgqOAZpxWafmYfDWwvOOJN1XkQocFTpuQGJZbT2hVzx63eDeUiA
	2J98PAg3g5FrFUzxZbtqjAfOJ4qep1HEVrF3YKVT4ApdJjw6S4FXjefQuppU+
X-Received: by 2002:a17:90b:5112:b0:3ac:7f4c:a690 with SMTP id 98e67ed59e1d1-3acef189c0dmr530059a91.35.1792174725391;
        Fri, 16 Oct 2026 11:18:45 -0700 (PDT)
Received: from [192.168.1.100] ([58.124.177.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc49c263asm4911998a91.17.2026.10.16.11.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 11:18:44 -0700 (PDT)
Message-ID: <e4cd86b2-6975-43e2-9812-daf8e4207583@gmail.com>
Date: Sat, 17 Oct 2026 03:18:40 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: cs35l56: Add DAI for SDCA OT25 stream
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@opensource.cirrus.com
References: <20261005155235.1386525-1-rf@opensource.cirrus.com>
 <20261005155235.1386525-2-rf@opensource.cirrus.com>
Content-Language: en-US
From: Juhyung Park <qkrwngud825@gmail.com>
In-Reply-To: <20261005155235.1386525-2-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

v7.2.11 includes bf7a3ce1d563 ("ASoC: sdw_utils: Switch CS35L56/57/62/63 
to use OT25 DAI")
[ Upstream commit 4b7f393a01f88e8d03cba94cf4948652de14789b ]

but not this preceding patch from the same series, which adds the DAI it
switches to.

sof_sdw tries to bind a DAI that the cs35l56 codec driver never 
registers, and card creation fails:

sof_sdw sof_sdw: ASoC: CODEC DAI cs35l56-ot25 not registered

On my Galaxy Book6 Pro with CS35L57, this breaks sound.

Please apply this commit 86c8360c97f6 ("ASoC: cs35l56: Add DAI for SDCA 
OT25 stream") to stable too.

Thanks,
Juhyung

On 10/6/26 12:52 AM, Richard Fitzgerald wrote:
> Add a DAI for the SDCA OT25 stream on SoundWire DP4.
> 
> The SDCA-defined OT25 stream is an amp reference feedback, typically used
> for AEC. The firmware outputs this on DP4. The firmware owns all control
> registers for this stream so there are no mixer controls or any other
> configuration options.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>   include/sound/cs35l56.h        |  1 +
>   sound/soc/codecs/cs35l56-sdw.c |  9 ++++--
>   sound/soc/codecs/cs35l56.c     | 54 ++++++++++++++++++++++++++++++++++
>   3 files changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
> index 45a5df574aa6d..747e10ec1a274 100644
> --- a/include/sound/cs35l56.h
> +++ b/include/sound/cs35l56.h
> @@ -312,6 +312,7 @@ struct snd_ctl_elem_value;
>   
>   #define CS35L56_SDW1_PLAYBACK_PORT			1
>   #define CS35L56_SDW1_CAPTURE_PORT			3
> +#define CS35L56_OT25_CAPTURE_PORT			4
>   
>   #define CS35L56_NUM_BULK_SUPPLIES			3
>   #define CS35L56_NUM_DSP_REGIONS				5
> diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
> index 98bb4542b9143..e10f04d677f4d 100644
> --- a/sound/soc/codecs/cs35l56-sdw.c
> +++ b/sound/soc/codecs/cs35l56-sdw.c
> @@ -265,11 +265,11 @@ static int cs35l56_sdw_read_prop(struct sdw_slave *peripheral)
>   	if (ret == 0)
>   		prop->clk_stop_mode1 = !!clock_stop_1;
>   
> -	ports = devm_kcalloc(cs35l56->base.dev, 2, sizeof(*ports), GFP_KERNEL);
> +	ports = devm_kcalloc(cs35l56->base.dev, 3, sizeof(*ports), GFP_KERNEL);
>   	if (!ports)
>   		return -ENOMEM;
>   
> -	prop->source_ports = BIT(CS35L56_SDW1_CAPTURE_PORT);
> +	prop->source_ports = BIT(CS35L56_SDW1_CAPTURE_PORT) | BIT(CS35L56_OT25_CAPTURE_PORT);
>   	prop->sink_ports = BIT(CS35L56_SDW1_PLAYBACK_PORT);
>   	prop->paging_support = true;
>   	prop->use_domain_irq = true;
> @@ -286,6 +286,11 @@ static int cs35l56_sdw_read_prop(struct sdw_slave *peripheral)
>   	ports[1].num = CS35L56_SDW1_CAPTURE_PORT;
>   	ports[1].type = SDW_DPN_FULL;
>   	ports[1].ch_prep_timeout = 10;
> +
> +	/* DP4 - capture */
> +	ports[2].num = CS35L56_OT25_CAPTURE_PORT;
> +	ports[2].type = SDW_DPN_FULL;
> +	ports[2].ch_prep_timeout = 10;
>   	prop->src_dpn_prop = &ports[1];
>   
>   	dev_dbg(&peripheral->dev, "clock stop mode 1 supported: %s\n",
> diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
> index 74129fcc79dce..dd264c310e1eb 100644
> --- a/sound/soc/codecs/cs35l56.c
> +++ b/sound/soc/codecs/cs35l56.c
> @@ -32,6 +32,7 @@
>   #include <sound/cs-amp-lib.h>
>   #include <sound/pcm.h>
>   #include <sound/pcm_params.h>
> +#include <sound/sdw.h>
>   #include <sound/soc.h>
>   #include <sound/soc-dapm.h>
>   #include <sound/tlv.h>
> @@ -324,6 +325,7 @@ static const struct snd_soc_dapm_widget cs35l56_dapm_widgets[] = {
>   	SND_SOC_DAPM_SIGGEN("VDDBMON ADC"),
>   	SND_SOC_DAPM_SIGGEN("VBSTMON ADC"),
>   	SND_SOC_DAPM_SIGGEN("TEMPMON ADC"),
> +	SND_SOC_DAPM_SIGGEN("OT25 Reference"),
>   
>   	SND_SOC_DAPM_INPUT("Calibrate"),
>   };
> @@ -388,6 +390,8 @@ static const struct snd_soc_dapm_route cs35l56_audio_map[] = {
>   	{ "SDW1 Capture", NULL, "SDW1 TX2 Source" },
>   	{ "SDW1 Capture", NULL, "SDW1 TX3 Source" },
>   	{ "SDW1 Capture", NULL, "SDW1 TX4 Source" },
> +
> +	{ "OT25", NULL, "OT25 Reference" },
>   };
>   
>   static int cs35l56_dsp_event(struct snd_soc_dapm_widget *w,
> @@ -722,6 +726,37 @@ static int cs35l56_sdw_dai_set_stream(struct snd_soc_dai *dai,
>   	return 0;
>   }
>   
> +static int cs35l56_ot25_dai_hw_params(struct snd_pcm_substream *substream,
> +				      struct snd_pcm_hw_params *params,
> +				      struct snd_soc_dai *dai)
> +{
> +	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(dai->component);
> +	struct sdw_stream_runtime *sdw_stream = snd_soc_dai_get_dma_data(dai, substream);
> +	struct sdw_stream_config sconfig = { };
> +	struct sdw_port_config pconfig = { };
> +	int ret;
> +
> +	dev_dbg(cs35l56->base.dev, "%s: rate %d\n", __func__, params_rate(params));
> +
> +	if (!cs35l56->base.init_done)
> +		return -ENODEV;
> +
> +	if (!sdw_stream)
> +		return -EINVAL;
> +
> +	snd_sdw_params_to_config(substream, params, &sconfig, &pconfig);
> +	pconfig.num = CS35L56_OT25_CAPTURE_PORT;
> +
> +	ret = sdw_stream_add_slave(cs35l56->sdw_peripheral, &sconfig, &pconfig,
> +				   1, sdw_stream);
> +	if (ret) {
> +		dev_err(dai->dev, "Failed to add OT25 stream: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct snd_soc_dai_ops cs35l56_sdw_dai_ops = {
>   	.set_tdm_slot = cs35l56_sdw_dai_set_tdm_slot,
>   	.shutdown = cs35l56_sdw_dai_shutdown,
> @@ -730,6 +765,13 @@ static const struct snd_soc_dai_ops cs35l56_sdw_dai_ops = {
>   	.set_stream = cs35l56_sdw_dai_set_stream,
>   };
>   
> +static const struct snd_soc_dai_ops cs35l56_ot25_dai_ops = {
> +	.shutdown = cs35l56_sdw_dai_shutdown,
> +	.hw_params = cs35l56_ot25_dai_hw_params,
> +	.hw_free = cs35l56_sdw_dai_hw_free,
> +	.set_stream = cs35l56_sdw_dai_set_stream,
> +};
> +
>   static struct snd_soc_dai_driver cs35l56_dai[] = {
>   	{
>   		.name = "cs35l56-asp1",
> @@ -778,6 +820,18 @@ static struct snd_soc_dai_driver cs35l56_dai[] = {
>   		.symmetric_rate = 1,
>   		.ops = &cs35l56_sdw_dai_ops,
>   	},
> +	{
> +		.name = "cs35l56-ot25",
> +		.id = 3,
> +		.capture = {
> +			.stream_name = "OT25",
> +			.channels_min = 1,
> +			.channels_max = 2,
> +			.rates = CS35L56_RATES,
> +			.formats = CS35L56_TX_FORMATS,
> +		},
> +		.ops = &cs35l56_ot25_dai_ops,
> +	},
>   };
>   
>   static int cs35l56_write_cal(struct cs35l56_private *cs35l56)

