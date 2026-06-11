Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476B43BA235;
	Thu, 11 Jun 2026 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781170425; cv=none; b=sexisG3Y4gmK9cuiHfjuIi9Dhh3JMWvvpUBm7SwKEP/fomd+j7KwJywAHRUMGebZ5szw3ZTFnALfbwd2CXh+SljPjBuHZJD56JIqx5QibHy3lkY/1WJPe7qy/1Z00wlehe8WMfLxFyOu1OiUvl4yUQNz8lNwy8yzIrgu5po6UyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781170425; c=relaxed/simple;
	bh=qOCCFlc+PSyf1avdq3ICE35rnneoH7tC3PkRXdj2zcI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fd+VxuIXyzo7uPD8+ObeogSHhOw8Psk1hzZUBVvTEI8ScmxwWrPT1YU2OvISeFqy3DDbFP9rwYodvzRNRYC4+ETMDA9zDdp7f8JQNPfIsUP5bmX4KEjWFnOIV78HBZqk8994sgWIdq6b6NlTq6iph1JmgupF50GxDZDZvPFen6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ldQ+n31G; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ldQ+n31G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781170424; x=1812706424;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=qOCCFlc+PSyf1avdq3ICE35rnneoH7tC3PkRXdj2zcI=;
  b=ldQ+n31GgVZFPgtvc6UGdf/SYRiduxToyf8bjMSjdbArwgq8z83lo+r1
   1gDL4CizTb8bpAFVTvCMdHjTAKQY272wwGVorgpAzXjwY+vra84ZtN3AB
   Czg+i9Yw0RaKaiqVk+wfDgKiiLCm1BD9MNaX0+SvJb9MReApHODLm1uxy
   Eqig+9uQbAVOHGCdPEiQW7w4zOek0wh+3AYhMKxKK7OESSajKM3uXDw9a
   +O8bwMuldfv7Y1CYJmLWmTlVEhdD5cCgP4dbTyiWZKbXHfC6znyJPvpWM
   +IyAYETqmPbBtfg+rlBJS7kfNHwgqTyYtsTwVnrnwHpm6Mwu9K9yK9YLV
   g==;
X-CSE-ConnectionGUID: G2olyCWYSmiMlkNqDVa5DA==
X-CSE-MsgGUID: 2GU4A7v4S7mFTYFXvFhWEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="92543609"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="92543609"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 02:33:44 -0700
X-CSE-ConnectionGUID: IFfu+EXtSfq6SIViYZWVpA==
X-CSE-MsgGUID: YEEHzjp7TKmCkXnMGfQFpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="243988556"
Received: from carterle-desk.ger.corp.intel.com (HELO [10.245.246.63]) ([10.245.246.63])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 02:33:41 -0700
Message-ID: <ec0d51a0-a31d-4c06-92f6-e38c408884b9@linux.intel.com>
Date: Thu, 11 Jun 2026 12:33:50 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda/hdmi: disable KAE for Intel Panther Lake
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: Alexander Kaplan <alexander.kaplan@sms-medipool.de>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 stable@vger.kernel.org, "Shankar, Uma" <uma.shankar@intel.com>
References: <20260610174834.6301-1-alexander.kaplan@sms-medipool.de>
 <5e05e954-338c-4a87-8a60-1fd2bd6bb8ce@linux.intel.com>
Content-Language: en-US
In-Reply-To: <5e05e954-338c-4a87-8a60-1fd2bd6bb8ce@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/06/2026 12:08, Péter Ujfalusi wrote:
> My setup is: laptop HDMI -> SYNIC HDMI audio extractor -> HDMI KVM ->
> monitor w/o speakers.
> I use the extractor to grab the audio and it is clean every time I play
> audio to HDMI.

Just to rule out iffy equipment on my side, I have connected the PTL
laptop to my Denon AVR both in SOF and legacy HDA mode. I cannot hear
any issue regarding to audio on my 5.1 speaker set.

> Can this be somehow related to the DP-to-HDMI converter? Have you tested
> that with other machine?
> Or a combination of xe2+DP-to-HDMI?
> 
> Ccing Uma for display side
>> This may also fix the silent Dolby TrueHD passthrough on Battlemage
>> reported in
>> https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7515.
>> Battlemage uses the same keep-alive code path and TrueHD passthrough
>> is the same first-multichannel-stream pattern, but I could not test
>> that hardware.
>>
>> Workaround for affected systems without this patch:
>> snd_hda_codec_intelhdmi.enable_silent_stream=0.
>>
>>  sound/hda/codecs/hdmi/intelhdmi.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/hda/codecs/hdmi/intelhdmi.c b/sound/hda/codecs/hdmi/intelhdmi.c
>> index 6a7882544a..52997caae9 100644
>> --- a/sound/hda/codecs/hdmi/intelhdmi.c
>> +++ b/sound/hda/codecs/hdmi/intelhdmi.c
>> @@ -791,7 +791,7 @@ static const struct hda_device_id snd_hda_id_intelhdmi[] = {
>>  	HDA_CODEC_ID_MODEL(0x8086281e, "Battlemage HDMI",	MODEL_ADLP),
>>  	HDA_CODEC_ID_MODEL(0x8086281f, "Raptor Lake P HDMI",	MODEL_ADLP),
>>  	HDA_CODEC_ID_MODEL(0x80862820, "Lunar Lake HDMI",	MODEL_ADLP),
>> -	HDA_CODEC_ID_MODEL(0x80862822, "Panther Lake HDMI",	MODEL_ADLP),
>> +	HDA_CODEC_ID_MODEL(0x80862822, "Panther Lake HDMI",	MODEL_TGL),
>>  	HDA_CODEC_ID_MODEL(0x80862823, "Wildcat Lake HDMI",	MODEL_ADLP),
>>  	HDA_CODEC_ID_MODEL(0x80862824, "Nova Lake HDMI",	MODEL_ADLP),
>>  	HDA_CODEC_ID_MODEL(0x80862882, "Valleyview2 HDMI",	MODEL_BYT),
> 

-- 
Péter

