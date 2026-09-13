Received: from mta0.migadu.com (out-222.mta0.migadu.com [91.218.175.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F09F507
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789330061; cv=none; b=C7cSUqHGGKSQhXOVA+xRagPV7eA2z+jYYs2KngfBSN6QwX87WUglipH09ktvzDPPZnPx1f7/eZFqEcKKgTAVSeko7oDKSdrVKObXbcEsEwOkvxndf7ANZXls83thmdsx9OHv9rPkerSVuW0GCt1h2gaPUDK8AsiKJwFit6vaezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789330061; c=relaxed/simple;
	bh=GY58dem29aWfC0rORAlGzx0DemkGhxeoVzsVr6I9QAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DpQOp+CckRBurbbLo55rPsvRUupFaRvsE2jbh+qwBEqva00/I16hMAj6GHvwWMFvZ1wqei47vdotT571hBudEQ5hShlpawaynaWOKmqliYzXhOjmCqaqHQx4weBy3POybxEdgSvQ67slhxQE8IPla2+KxzY+U3E68jf4Wny9K+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H4hic+iH; arc=none smtp.client-ip=91.218.175.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H4hic+iH"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GY58dem29aWfC0rORAlGzx0DemkGhxeoVzsVr6I9QAo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789330057; v=1; x=1789934857;
 b=H4hic+iHesTEC+Ow2fKgsX6YwtwWqPXagn/3ms7fH/Rm4sjcCBT99GrE3LEqMHAHKpnUrVvV
 Cq6vzVE7MfBhxQqvbv8UyuH7KQt4+NqWWVirHr3nVxAMaRVUqK3Z6jKinNvpQDn/s5fuaSZNv6t
 GczAaag/XvpJMrcEVCedF7Hw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ad2a21e4a1891ee5;
	Sun, 13 Sep 2026 20:07:27 +0000
X-Mizu-Trace-ID: ad2a21e4a1891ee5
X-Migadu-Flow: FLOW_OUT
Message-ID: <d825f337-0c66-440b-b481-45b40f29b006@linux.dev>
Date: Sun, 13 Sep 2026 21:48:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: sdw_utils: clear stale RT711 device reference on
 exit
To: David Cemin <dcemin@nvidia.com>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Jack Yu <jack.yu@realtek.com>, linux-sound@vger.kernel.org,
 linux-tegra@vger.kernel.org, stable@vger.kernel.org
References: <20260912182131.1156475-1-dcemin@nvidia.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <20260912182131.1156475-1-dcemin@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/26 20:21, David Cemin wrote:
> asoc_sdw_rt711_exit() drops the reference held in ctx->headset_codec_dev
> but leaves the pointer populated. If the card cleanup path reaches the
> exit hook more than once after a failed or deferred probe, a later
> invocation reuses the stale pointer and calls put_device() again,
> underflowing the refcount and leading to oopses when later probe,
> driver bind, or suspend paths walk the SoundWire bus after the device
> reference was released. Observed as boot- and suspend-time oopses on an
> arm64 platform with an RT712 headset codec, reproducible
> deterministically by repeated machine-driver probe cycling with the
> codec drivers unloaded.
> 
> Clear the pointer after put_device() so repeated cleanup becomes a
> no-op, which also makes the existing NULL check at the top of the exit
> hook effective. This matches what commit 046173b98de3 ("ASoC: sdw_utils:
> fix double put_device() on aggregated amps") did for the aggregated amp
> references.
> 
> Fixes: 811648340707 ("ASoC: Intel: sof_sdw: avoid oops in error handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Cemin <dcemin@nvidia.com>
> ---
>  sound/soc/sdw_utils/soc_sdw_rt711.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/sdw_utils/soc_sdw_rt711.c b/sound/soc/sdw_utils/soc_sdw_rt711.c
> index 3a3a66b4b737..4707190e160c 100644
> --- a/sound/soc/sdw_utils/soc_sdw_rt711.c
> +++ b/sound/soc/sdw_utils/soc_sdw_rt711.c
> @@ -124,6 +124,7 @@ int asoc_sdw_rt711_exit(struct snd_soc_card *card, struct snd_soc_dai_link *dai_
>  
>  	device_remove_software_node(ctx->headset_codec_dev);
>  	put_device(ctx->headset_codec_dev);
> +	ctx->headset_codec_dev = NULL;
>  
>  	return 0;
>  }
The analysis looks correct, the only problem is that this code pattern
is copy-pasted with the same issue in other files, e.g.

int asoc_sdw_es9356_exit(struct snd_soc_card *card, struct
snd_soc_dai_link *dai_link)
{
	struct asoc_sdw_mc_private *ctx = snd_soc_card_get_drvdata(card);

	if (!ctx->headset_codec_dev)
		return 0;

	device_remove_software_node(ctx->headset_codec_dev);
	put_device(ctx->headset_codec_dev);


It'd be best to use a common helper and fix this across the board, no?
