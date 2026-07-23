Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBABB3C5DD4;
	Thu, 23 Jul 2026 09:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798920; cv=none; b=Ng/9gPDcEZf0nK/wJ9b+Xlu+UWJKPavCRg5TOJUAdStnyp+N13gGG20lJPctGmKyfHBSisBwW05HiNseXu0puchCdmaXC1eUwS8noA7CI1R02UaKmzTrR95YOJh5L4Dpmxg8tin6uOfgoNT9OKS7KULNsji5oBfm79gfUg4wzig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798920; c=relaxed/simple;
	bh=qwlb+IvyEWpjUo1K7CVYOI60Uq7utJOWMfS0YAQ7Vbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXbh0D/r03sNWKyXXp2eAC5xvGOzl7tDuAGgR3lrLQMR8yj3z8JJm31WuT/d7su4Znt6UFRras6iA1UQIn1W5n25Hb4e/JTXkMO482d6jnO/FYcow5udGI2MqrBFfMLwknjat6M1O6l3xuS6IeL6A58jFqi3At3T8im3p7oBHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6XlVNwg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6XlVNwg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784798917; x=1816334917;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qwlb+IvyEWpjUo1K7CVYOI60Uq7utJOWMfS0YAQ7Vbo=;
  b=L6XlVNwgKuGDVoH8ERto7B5HSF4+nXHNF6jQCdGj1Rqe7PbIN4YHUFlR
   029bJE2nx42hCeBzHyFXvzxkESP2GOHPUmE6y+2fPZFb/Yz9p7JOIZTW2
   l9fQz/5+tPeGjqFBkAyzTTKpC2quyf/O8RNxfCARJtqnWHxiajmxUIpFS
   e5JuRWWDzCkWTUwmGDPXBMn5gYDcJEx0YE806gMmggL+j1dnorwnrHwhR
   7z/hC/4C1RSKid1iT22THd1xBCj1D3e95mvWqn85le8HW9L73hqTLtzo6
   bjzQ8BCmaUPY1jQfql0EqTMDa/q4u7ReCRHXgELXrnnoP2/9xZhASI750
   w==;
X-CSE-ConnectionGUID: lzInlwE2Qo6mq4yWxGToqg==
X-CSE-MsgGUID: 5KB9iEuORQylceIPWIvHew==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85394820"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="85394820"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:28:36 -0700
X-CSE-ConnectionGUID: hc3RqUe2TcC1y60p9D0eww==
X-CSE-MsgGUID: CEzddS6dS0eahVZ2NEGmKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="262135089"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO [10.245.246.159]) ([10.245.246.159])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:28:34 -0700
Message-ID: <ed393a64-0b24-462e-a59a-b784831ac810@linux.intel.com>
Date: Thu, 23 Jul 2026 12:28:59 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda/hdmi: stop KAE before multichannel infoframe
 setup
To: cluster@cluster.wtf, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 stable@vger.kernel.org
References: <20260722220309.24432-1-cluster@cluster.wtf>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260722220309.24432-1-cluster@cluster.wtf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 23/07/2026 01:03, cluster@cluster.wtf wrote:
> On Intel Meteor Lake and other ADLP-class display codecs, HDA Keep-Alive
> (KAE) silent stream stays active while idle and transmits stereo silence.
> PCM prepare programmed converter channel count and the DP/HDMI audio
> infoframe before KAE was stopped, then re-enabled KAE during real
> playback. Reconfiguring an active keep-alive stream to 5.1/7.1 can hang
> the display audio codec until reboot. Stereo playback is unaffected.
> 
> Stop KAE in a new pre_prepare hook before infoframe/channel-count setup,
> do not re-enable KAE while real PCM is running, and restore the stereo
> silent stream from PCM close when the sink is still present.

I think this has been fixed by
https://lore.kernel.org/linux-sound/20260715180610.1371243-1-kai.vehmanen@linux.intel.com/T/#u

> 
> Signed-off-by: Alexey Cluster <cluster@cluster.wtf>
> ---
> 
> Hardware / test notes:
> - Laptop: HP OMEN Transcend Gaming Laptop 14-fb0xxx
>   (marketing: OMEN Transcend Laptop 14-fb0065TX, SKU 9T0M1PA#AB2)
> - CPU/iGPU: Meteor Lake-P, PCI 8086:7d55 (Arc Graphics)
> - Audio controller: Meteor Lake-P HD Audio, PCI 8086:7e28
> - Stack: sof-soundwire + snd-hda-codec-intelhdmi
> - Display codec: Intel Meteor Lake HDMI, vendor_id 0x8086281d
> - Path: USB-C DisplayPort -> AVR "CZ350CK" (ELD speakers 0x4f, LPCM up to 8ch)
> - CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM=y / enable_silent_stream=Y
> 
> Before this change, switching the sink from 2.0 to 5.1 (UCM "HiFi 5+1" /
> speaker-test -c6 on hw:sofsoundwire,5) could hang display audio until reboot.
> Stereo continued to work. After the change, cold 6ch open and 2ch<->6ch
> transitions complete with ca=0x0b and no hang.
> 
>  sound/hda/codecs/hdmi/hdmi.c       | 40 ++++++++++++++++++++++++----
>  sound/hda/codecs/hdmi/hdmi_local.h |  9 +++++++
>  sound/hda/codecs/hdmi/intelhdmi.c  | 42 ++++++++++++++++++++++++++----
>  3 files changed, 81 insertions(+), 10 deletions(-)
> 
> diff --git a/sound/hda/codecs/hdmi/hdmi.c b/sound/hda/codecs/hdmi/hdmi.c
> index 0b6816018a42..e2a77877358a 100644
> --- a/sound/hda/codecs/hdmi/hdmi.c
> +++ b/sound/hda/codecs/hdmi/hdmi.c
> @@ -557,6 +557,11 @@ void snd_hda_hdmi_setup_audio_infoframe(struct hda_codec *codec,
>  
>  	active_channels = snd_hdac_get_active_channels(ca);
>  
> +	codec_dbg(codec,
> +		  "HDMI: infoframe pin-NID=0x%x channels=%d active=%d ca=0x%02x conn=%d spk_alloc=0x%x non_pcm=%d\n",
> +		  pin_nid, channels, active_channels, ca, eld->info.conn_type,
> +		  eld->info.spk_alloc, non_pcm);
> +
>  	chmap->ops.set_channel_count(&codec->core, per_pin->cvt_nid,
>  						active_channels);
>  
> @@ -1683,6 +1688,13 @@ int snd_hda_hdmi_generic_pcm_prepare(struct hda_pcm_stream *hinfo,
>  		snd_hdac_sync_audio_rate(&codec->core, per_pin->pin_nid,
>  					 per_pin->dev_id, runtime->rate);
>  
> +	/*
> +	 * Stop Intel KAE (and similar) before channel-count / infoframe are
> +	 * programmed. Must not sleep under per_pin->lock.
> +	 */
> +	if (spec->ops.pre_prepare)
> +		spec->ops.pre_prepare(codec, per_pin, runtime->channels);
> +
>  	non_pcm = check_non_pcm_per_cvt(codec, cvt_nid);
>  	scoped_guard(mutex, &per_pin->lock) {
>  		per_pin->channels = substream->runtime->channels;
> @@ -1732,6 +1744,7 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
>  	struct hdmi_spec_per_cvt *per_cvt;
>  	struct hdmi_spec_per_pin *per_pin;
>  	int pinctl;
> +	bool restore_silent = false;
>  
>  	guard(mutex)(&spec->pcm_lock);
>  	if (hinfo->nid) {
> @@ -1769,12 +1782,29 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
>  					    pinctl & ~PIN_OUT);
>  		}
>  
> -		guard(mutex)(&per_pin->lock);
> -		per_pin->chmap_set = false;
> -		memset(per_pin->chmap, 0, sizeof(per_pin->chmap));
> +		scoped_guard(mutex, &per_pin->lock) {
> +			per_pin->chmap_set = false;
> +			memset(per_pin->chmap, 0, sizeof(per_pin->chmap));
> +
> +			per_pin->setup = false;
> +			per_pin->channels = 0;
> +			/*
> +			 * KAE keep-alive is stopped for the duration of real
> +			 * PCM; restore stereo silent stream after close. The
> +			 * older I915 silent-stream mode keeps its own power
> +			 * refs and must not be re-armed here.
> +			 */
> +			restore_silent = per_pin->silent_stream &&
> +					 per_pin->sink_eld.monitor_present &&
> +					 spec->silent_stream_type == SILENT_STREAM_KAE;
> +		}
>  
> -		per_pin->setup = false;
> -		per_pin->channels = 0;
> +		if (restore_silent && spec->ops.silent_stream) {
> +			codec_dbg(codec,
> +				  "HDMI: restore silent stream after PCM close pin-NID=0x%x\n",
> +				  per_pin->pin_nid);
> +			spec->ops.silent_stream(codec, per_pin, true);
> +		}
>  	}
>  
>  	return 0;
> diff --git a/sound/hda/codecs/hdmi/hdmi_local.h b/sound/hda/codecs/hdmi/hdmi_local.h
> index 548241ad3fa9..20e7536efef0 100644
> --- a/sound/hda/codecs/hdmi/hdmi_local.h
> +++ b/sound/hda/codecs/hdmi/hdmi_local.h
> @@ -74,6 +74,15 @@ struct hdmi_ops {
>  			    hda_nid_t pin_nid, int dev_id, u32 stream_tag,
>  			    int format);
>  
> +	/*
> +	 * Optional: called before channel-count / infoframe programming in
> +	 * PCM prepare. Used by Intel KAE silent-stream to stop keep-alive
> +	 * before the converter is reconfigured for real playback.
> +	 */
> +	void (*pre_prepare)(struct hda_codec *codec,
> +			    struct hdmi_spec_per_pin *per_pin,
> +			    unsigned int channels);
> +
>  	void (*pin_cvt_fixup)(struct hda_codec *codec,
>  			      struct hdmi_spec_per_pin *per_pin,
>  			      hda_nid_t cvt_nid);
> diff --git a/sound/hda/codecs/hdmi/intelhdmi.c b/sound/hda/codecs/hdmi/intelhdmi.c
> index 6a7882544ab7..60ed2ffb182d 100644
> --- a/sound/hda/codecs/hdmi/intelhdmi.c
> +++ b/sound/hda/codecs/hdmi/intelhdmi.c
> @@ -418,6 +418,32 @@ static void intel_not_share_assigned_cvt_nid(struct hda_codec *codec,
>  		intel_not_share_assigned_cvt(codec, pin_nid, dev_id, mux_idx);
>  }
>  
> +/*
> + * Stop KAE before channel-count / infoframe are programmed. Reconfiguring an
> + * active keep-alive stream (stereo silence) to multichannel can hang Intel
> + * display codecs (MTL and earlier ADLP KAE). KAE is restored from PCM close.
> + */
> +static void i915_hsw_pre_prepare(struct hda_codec *codec,
> +				 struct hdmi_spec_per_pin *per_pin,
> +				 unsigned int channels)
> +{
> +	struct hdmi_spec *spec = codec->spec;
> +
> +	if (spec->silent_stream_type != SILENT_STREAM_KAE || !per_pin)
> +		return;
> +	if (!per_pin->silent_stream)
> +		return;
> +
> +	codec_dbg(codec,
> +		  "HDMI: KAE stop before prepare pin-NID=0x%x cvt-NID=0x%x channels=%u->%u conn=%d\n",
> +		  per_pin->pin_nid, per_pin->cvt_nid, per_pin->channels,
> +		  channels, per_pin->sink_eld.info.conn_type);
> +
> +	silent_stream_set_kae(codec, per_pin, false);
> +	/* wait for pending transfers in codec to clear */
> +	usleep_range(100, 200);
> +}
> +
>  /* setup_stream ops override for HSW+ */
>  static int i915_hsw_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
>  				 hda_nid_t pin_nid, int dev_id, u32 stream_tag,
> @@ -435,7 +461,13 @@ static int i915_hsw_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
>  
>  	haswell_verify_D0(codec, cvt_nid, pin_nid);
>  
> -	if (spec->silent_stream_type == SILENT_STREAM_KAE && per_pin && per_pin->silent_stream) {
> +	/*
> +	 * KAE should already be cleared in pre_prepare; keep a safety stop
> +	 * here for callers that only go through setup_stream. Do not re-enable
> +	 * KAE while real PCM is active — that races with multichannel formats.
> +	 */
> +	if (spec->silent_stream_type == SILENT_STREAM_KAE && per_pin &&
> +	    per_pin->silent_stream) {
>  		silent_stream_set_kae(codec, per_pin, false);
>  		/* wait for pending transfers in codec to clear */
>  		usleep_range(100, 200);
> @@ -444,10 +476,9 @@ static int i915_hsw_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
>  	res = snd_hda_hdmi_setup_stream(codec, cvt_nid, pin_nid, dev_id,
>  					stream_tag, format);
>  
> -	if (spec->silent_stream_type == SILENT_STREAM_KAE && per_pin && per_pin->silent_stream) {
> -		usleep_range(100, 200);
> -		silent_stream_set_kae(codec, per_pin, true);
> -	}
> +	codec_dbg(codec,
> +		  "HDMI: setup_stream pin-NID=0x%x cvt-NID=0x%x tag=%u fmt=0x%x res=%d\n",
> +		  pin_nid, cvt_nid, stream_tag, format, res);
>  
>  	return res;
>  }
> @@ -608,6 +639,7 @@ static int intel_hsw_common_init(struct hda_codec *codec, hda_nid_t vendor_nid,
>  	codec->auto_runtime_pm = 1;
>  
>  	spec->ops.setup_stream = i915_hsw_setup_stream;
> +	spec->ops.pre_prepare = i915_hsw_pre_prepare;
>  	spec->ops.pin_cvt_fixup = i915_pin_cvt_fixup;
>  	spec->ops.silent_stream = i915_set_silent_stream;
>  

-- 
Péter

