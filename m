Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D13546ED;
	Thu, 11 Jun 2026 09:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168934; cv=none; b=VUd8KoxAukzy2rxzNbFxZGJitPvmLiFSCOEGkeXjM9gCFwe7ltvckLJMzOjGNUf/t8Rwayhh59eE249MJRSExAaqqHel9xytFRJz+XfuJTGl1PPXVkRTIk6IPrhwb/gZ75w95aK8VUwWF31ioQuGsIRLjtmjVCffWuAuQdehSrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168934; c=relaxed/simple;
	bh=9dOwlq1ZJAzjZVJ7G/FREjR9Du4oROYSoKMF+/A0j5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCrrZFPLbOVNV3G3jiBblxCarnb2mNLVIqIC2j8GOt1vsXTQSLXTCul2QAOmuLHPpwrAaUQDeFxXdP3B07gdAYW1gp2K3H8W7mDoMYK/DV9oYE5hRXyOijUrtGLF+A8O3rjqEIPeJmBRaRvzS7NsH/P3m9FTG3MgFyhWlpQSMcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zwn3hk9u; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zwn3hk9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781168933; x=1812704933;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9dOwlq1ZJAzjZVJ7G/FREjR9Du4oROYSoKMF+/A0j5M=;
  b=Zwn3hk9u/2uXGu0CUTvDRFTmawUndrhZLpELfpBSwcpQLJkpHPnBwwVA
   GOARaR+XDjjHG+XNTEMMEqwYOE/FE47kwk6XZDcqMfQrGONfiLWE696sV
   cN1AnZH3bCmiSFLTmVKpV97IZ0bQLhfUnDh2lruLrTbigWeZUR267aPhh
   UcX+V+8M/eAJvI6GjJSun/7g0mC8S2zbh9Kaksi543f5hJUxEuE0n4zyg
   rdI1h073xf0Z+1XqSCsfMxf5Cu5uoqVlEhibzWh+daPlkKvz7evJfepq7
   cgGFRS2gAHG8c/p4afH4xnFfv8ik3BIY6MjzhcyeVLWAz4i7t6d7yXc2S
   w==;
X-CSE-ConnectionGUID: Fmu5CyfAQ0+PG4QxQGOnAA==
X-CSE-MsgGUID: 1u2OtcQjRyi/Qqetk6RUUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99400456"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="99400456"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 02:08:52 -0700
X-CSE-ConnectionGUID: qnb7Nqr9Tu+e3JIvc57UNw==
X-CSE-MsgGUID: GcE9VWftR4mL6Mc2qenqmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="276614160"
Received: from carterle-desk.ger.corp.intel.com (HELO [10.245.246.63]) ([10.245.246.63])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 02:08:49 -0700
Message-ID: <5e05e954-338c-4a87-8a60-1fd2bd6bb8ce@linux.intel.com>
Date: Thu, 11 Jun 2026 12:08:57 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda/hdmi: disable KAE for Intel Panther Lake
To: Alexander Kaplan <alexander.kaplan@sms-medipool.de>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 stable@vger.kernel.org, "Shankar, Uma" <uma.shankar@intel.com>
References: <20260610174834.6301-1-alexander.kaplan@sms-medipool.de>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20260610174834.6301-1-alexander.kaplan@sms-medipool.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 10/06/2026 20:48, Alexander Kaplan wrote:
> On Panther Lake the keep-alive engine poisons the display side of the
> audio path for multichannel PCM.
> Once KAE has been active in the running display power cycle, the first
> 6 or 8 channel stream on that pin plays silent and wedges the pin.
> All subsequent streams stay silent regardless of their format.
> Only a display power domain cycle recovers the pin, in practice a
> reboot or one suspend cycle.
> 
> The wedge sits behind the audio converter.
> Sample counters in the display audio register block keep running during
> the silent playback while the output stays dead.
> The wedge survives clearing the KAE bit ahead of the stream id
> programming, fully quiescing the converter (KAE bit, stream id and
> format cleared before the multichannel setup), a complete codec and
> controller reset through a driver rebind with the keep-alive kept off,
> and powering down the audio well for ten minutes.
> The sequence is harmless when the keep-alive was never enabled in the
> running display power cycle, which isolates the KAE hardware as the
> trigger.
> 
> Easy reproducer on a sink whose LPCM capability is limited to
> 2 channels:
> speaker-test -c2 plays, one speaker-test -c6 run plays silent and every
> following speaker-test -c2 stays silent until reboot.
> With enable_silent_stream=0 the same sequence plays normally.

Normally I have KAE disabled for power saving reasons on my laptops, but
did a quick test on my PTL:
# cat /proc/asound/card0/codec#2 | grep KAE
  Digital: Enabled KAE

speaker-test -c2 / -c6 works as many times as I run them in all permutation.

> 
> This is the failure class already known from commit 6ab6f98fcdc9
> ("ALSA: hda/hdmi: disable KAE for Intel DG2").
> Handle Panther Lake like DG2 and fall back to the older i915 silent
> stream method, which uses the regular stream path instead of the
> keep-alive engine.
> Like on DG2 this keeps the codec powered while the silent stream runs.
> 
> Cc: stable@vger.kernel.org
> Fixes: e9481d9b83f8 ("ALSA: hda: add HDMI codec ID for Intel PTL")
> Signed-off-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
> ---
> Found and verified on an ASUS NUC 16 Pro (Panther Lake H, codec
> 0x80862822) driving an LG TV through a Synaptics VMM7100 DP-to-HDMI
> protocol converter, kernel 7.1-rc7.
> The poisoning is independent of the sink and of the video mode.

My setup is: laptop HDMI -> SYNIC HDMI audio extractor -> HDMI KVM ->
monitor w/o speakers.
I use the extractor to grab the audio and it is clean every time I play
audio to HDMI.

Can this be somehow related to the DP-to-HDMI converter? Have you tested
that with other machine?
Or a combination of xe2+DP-to-HDMI?

Ccing Uma for display side
> This may also fix the silent Dolby TrueHD passthrough on Battlemage
> reported in
> https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7515.
> Battlemage uses the same keep-alive code path and TrueHD passthrough
> is the same first-multichannel-stream pattern, but I could not test
> that hardware.
> 
> Workaround for affected systems without this patch:
> snd_hda_codec_intelhdmi.enable_silent_stream=0.
> 
>  sound/hda/codecs/hdmi/intelhdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/hda/codecs/hdmi/intelhdmi.c b/sound/hda/codecs/hdmi/intelhdmi.c
> index 6a7882544a..52997caae9 100644
> --- a/sound/hda/codecs/hdmi/intelhdmi.c
> +++ b/sound/hda/codecs/hdmi/intelhdmi.c
> @@ -791,7 +791,7 @@ static const struct hda_device_id snd_hda_id_intelhdmi[] = {
>  	HDA_CODEC_ID_MODEL(0x8086281e, "Battlemage HDMI",	MODEL_ADLP),
>  	HDA_CODEC_ID_MODEL(0x8086281f, "Raptor Lake P HDMI",	MODEL_ADLP),
>  	HDA_CODEC_ID_MODEL(0x80862820, "Lunar Lake HDMI",	MODEL_ADLP),
> -	HDA_CODEC_ID_MODEL(0x80862822, "Panther Lake HDMI",	MODEL_ADLP),
> +	HDA_CODEC_ID_MODEL(0x80862822, "Panther Lake HDMI",	MODEL_TGL),
>  	HDA_CODEC_ID_MODEL(0x80862823, "Wildcat Lake HDMI",	MODEL_ADLP),
>  	HDA_CODEC_ID_MODEL(0x80862824, "Nova Lake HDMI",	MODEL_ADLP),
>  	HDA_CODEC_ID_MODEL(0x80862882, "Valleyview2 HDMI",	MODEL_BYT),

-- 
Péter

