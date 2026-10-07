Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52F14AE135;
	Wed,  7 Oct 2026 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383089; cv=none; b=UybeqMw7zH7Nz9CAQlrtte2logRDtN/kCfoPiYCY2QztK1FqQ+BLH7dRdDdNYIgrWzvb507Eu1sXMdsRzA5WfPZ1LLMiW51bK0YQhst8NlPriGGPpkDopiHAKUz6QrTRLeXYGh3+uiCX5kerpLEiOFuGiu5ZPuUBrEaDJ/nPPVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383089; c=relaxed/simple;
	bh=feKk5hylkVBkDoMxmowHKr9B9FdydMlHHPwsry4MKTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twTG0gVrfVPqaAQoSA2v06Dbw6DT4O6x/Y7QDjiqOsF7eVITU0vEUtvzraqK5Vds03ETuIHr75wH6UvCywm1z7VU+/ISfu0mbz9vd2mg4gUDViIMbSisoSo72BaC35IlPMx+6PF+4ktIOdMI8nQ3zYjFLqM0PECPO+umBem9Smg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ka4otjta; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ka4otjta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791383085; x=1822919085;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=feKk5hylkVBkDoMxmowHKr9B9FdydMlHHPwsry4MKTI=;
  b=Ka4otjta9ZZZF3obzL/bFXf4REYpjN6EN2nL74eDGjhzAnhFsRpDxNt6
   p031/tYjw97+SR/hwwSaYnXW+Aq56Fb50h+kJeRSj+mNN7Ou73PlJG8+X
   /3cQtPhA0bB8mDzLbqdq8nuLC0Iuwzm3Au1rRTadtipiymx+181dj4Qgv
   wnCqv5iCXC4SsooSWJgtQU9XtmdlgH+IZ47o24+vfPvXn73cgMuCONHsk
   9tBNN6y33UG1NNSGlW1QUNnObYW/R25YoblYZfYY9VRFLGmU0gBv1xab3
   f8cK8/K0dt0b0Ez+qIkoHW210g/pWBhr2hXhFkSdp8KljfnlcAslnpcvM
   g==;
X-CSE-ConnectionGUID: FphG3jqQRMq526KXX76tzQ==
X-CSE-MsgGUID: f9VoT6H+R1mWMiOscdMV+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="151403"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="151403"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 07:24:43 -0700
X-CSE-ConnectionGUID: fGVRmB+URaaE5YZ/FigFgA==
X-CSE-MsgGUID: ysffX+GRTcOth4l/nlfz9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="305441752"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.188]) ([10.245.244.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 07:24:40 -0700
Message-ID: <6e27af41-1ba4-4d3e-a128-c2d1402a8f6e@linux.intel.com>
Date: Wed, 7 Oct 2026 17:25:01 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ALSA: compress: fix buffer leak on repeated
 SET_PARAMS
To: Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, tiwai@suse.com, pierre-louis.bossart@linux.dev,
 linux-sound@vger.kernel.org, stable@vger.kernel.org
References: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
 <20261007132509.18237-2-peter.ujfalusi@linux.intel.com>
 <878q49obcu.wl-tiwai@suse.de> <asZSywHEbx-u6uBs@parshuram>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <asZSywHEbx-u6uBs@parshuram>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07/10/2026 17:10, Vinod Koul wrote:
> On 07-10-26, 16:04, Takashi Iwai wrote:
>> On Wed, 07 Oct 2026 15:25:06 +0200,
>> Peter Ujfalusi wrote:
>>>
>>> snd_compr_allocate_buffer() unconditionally overwrites
>>> stream->runtime->buffer with a freshly kmalloc'd buffer whenever the
>>> driver has no ops->copy and no preallocated dma_buffer_p. SET_PARAMS
>>> is permitted repeatedly while the stream is in the OPEN state, so a
>>> local process can loop SNDRV_COMPRESS_SET_PARAMS and leak the
>>> previous buffer on every call, exhausting kernel memory.
>>>
>>> Free any framework-owned buffer before replacing it, mirroring the
>>> ownership check already used in snd_compr_free().
>>>
>>> Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>> ---
>>>  sound/core/compress_offload.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
>>> index 7c397b1c9231..c0ed76e1c844 100644
>>> --- a/sound/core/compress_offload.c
>>> +++ b/sound/core/compress_offload.c
>>> @@ -613,6 +613,10 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
>>>  			return -ENOMEM;
>>>  	}
>>>  
>>> +	/* a prior SET_PARAMS may have left a framework-owned buffer behind */
>>> +	if (!stream->runtime->dma_buffer_p)
>>> +		kfree(stream->runtime->buffer);
>>> +
>>
>> I'd rather put to the else block above (or even better, if
>> (stream->runtime->dma_buffer_p) block above that point).
>>
>> The code is specific to that condition, after all.
> 
> I would block calling snd_compr_allocate_buffer() for subsequent
> set_params, it should not be allowed.

OK, let me see how it should be done. I'm not sure of changing other
params are permitted either, but imagine:
the application calls set_params first then after some deliberation and
before starting it reconsiders and wants to have bigger/smaller buffer.
I know, they rarely do, but if such application assumes that the second
buffer setup is valid, while we kept the initial one, things might break?

-- 
Péter

