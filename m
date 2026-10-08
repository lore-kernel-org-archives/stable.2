Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BB83B8D7B;
	Thu,  8 Oct 2026 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791440731; cv=none; b=bR3/xOXwsjW9ovCWpvQ5vFTcwM2E+gxquo8n4thmhVxrOT6LWzivXUey57BSa0kCitQ37Qu8B2wglfMNBghSXga/wlr30CyzbmRDccwakveYTWCABazTXrCYjGBHaX6zeaXLMtGoT1bl3yj8703fmveqZ6y1p9c8qb/xS6qiPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791440731; c=relaxed/simple;
	bh=Q+WBv5i7cElsl/i/bqgUmIX4amMHRNIiPl+FzrJzopQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m43qYTPDPH8C2mUztifzZ1xoG4cXwbVgiuuMQGEfUK7gVUPen5qyX7tHYH1tBa4b4eDlhxZN7FJxwUCx0B2EPq6DT0l6WcPXLNOjq/TuOyMOvjsH8xlANXxN0eEPkly1vFN089Edx+JUB2zxuoWYaHRuXNKbJ20YPOhH4K2PAB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QHPWqAv1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QHPWqAv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791440730; x=1822976730;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q+WBv5i7cElsl/i/bqgUmIX4amMHRNIiPl+FzrJzopQ=;
  b=QHPWqAv1q9NaHK0GuP0TkRsoTKCH2gM6GlxEo18BA5TIbebjLWpGItGB
   u7bo5Vmcg9xIJTTsR+b6XV7416gIYFriXo2ZMTcNTO4ZlEoylXHlz3yZk
   Y1UqOql7ps/WLmGWZLhX+f9U9oa1qugKZTXmhUCb8be6FDNmUFpDOit95
   j3YK6aWrdBWhi8FH9Mx9S7nyXzBcHAokQ59Gauf4gclYjESbmPkgzSL7E
   NSp/eDUlNW8qPQjIw1rHHq98TMWZ6CVos/GC6IqhENc/O0I7BQ4EV24xe
   8C9xOTKwg/O6pUtA2QbO5AYUGgLs/KRM+PhVrYaofxl02xr3ovoAhgkcb
   g==;
X-CSE-ConnectionGUID: qvpMONMBRE6FEuFy1Uf3DQ==
X-CSE-MsgGUID: MAlcGyOpTraqrrPvMRgwzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="223181"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="223181"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 23:25:29 -0700
X-CSE-ConnectionGUID: MmsQmbLlSIuMZwYOCOxZFA==
X-CSE-MsgGUID: 1BBc8OD2Q0ygvY2YuO66wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="264432"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.245.74]) ([10.245.245.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 23:25:27 -0700
Message-ID: <1acd072e-2b87-4083-84cb-9de6252b4382@linux.intel.com>
Date: Thu, 8 Oct 2026 09:25:49 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ALSA: compress: fix buffer leak on repeated
 SET_PARAMS
To: Vinod Koul <vkoul@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, perex@perex.cz, tiwai@suse.com,
 pierre-louis.bossart@linux.dev, linux-sound@vger.kernel.org,
 stable@vger.kernel.org
References: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
 <20261007132509.18237-2-peter.ujfalusi@linux.intel.com>
 <878q49obcu.wl-tiwai@suse.de> <asZSywHEbx-u6uBs@parshuram>
 <6e27af41-1ba4-4d3e-a128-c2d1402a8f6e@linux.intel.com>
 <asZZJ--dC9M7jx4A@parshuram>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <asZZJ--dC9M7jx4A@parshuram>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07/10/2026 17:37, Vinod Koul wrote:
> On 07-10-26, 17:25, Péter Ujfalusi wrote:
>>
>>
>> On 07/10/2026 17:10, Vinod Koul wrote:
>>> On 07-10-26, 16:04, Takashi Iwai wrote:
>>>> On Wed, 07 Oct 2026 15:25:06 +0200,
>>>> Peter Ujfalusi wrote:
>>>>>
>>>>> snd_compr_allocate_buffer() unconditionally overwrites
>>>>> stream->runtime->buffer with a freshly kmalloc'd buffer whenever the
>>>>> driver has no ops->copy and no preallocated dma_buffer_p. SET_PARAMS
>>>>> is permitted repeatedly while the stream is in the OPEN state, so a
>>>>> local process can loop SNDRV_COMPRESS_SET_PARAMS and leak the
>>>>> previous buffer on every call, exhausting kernel memory.
>>>>>
>>>>> Free any framework-owned buffer before replacing it, mirroring the
>>>>> ownership check already used in snd_compr_free().
>>>>>
>>>>> Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
>>>>> Cc: stable@vger.kernel.org
>>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>>>>> ---
>>>>>  sound/core/compress_offload.c | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
>>>>> index 7c397b1c9231..c0ed76e1c844 100644
>>>>> --- a/sound/core/compress_offload.c
>>>>> +++ b/sound/core/compress_offload.c
>>>>> @@ -613,6 +613,10 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
>>>>>  			return -ENOMEM;
>>>>>  	}
>>>>>  
>>>>> +	/* a prior SET_PARAMS may have left a framework-owned buffer behind */
>>>>> +	if (!stream->runtime->dma_buffer_p)
>>>>> +		kfree(stream->runtime->buffer);
>>>>> +
>>>>
>>>> I'd rather put to the else block above (or even better, if
>>>> (stream->runtime->dma_buffer_p) block above that point).
>>>>
>>>> The code is specific to that condition, after all.
>>>
>>> I would block calling snd_compr_allocate_buffer() for subsequent
>>> set_params, it should not be allowed.
>>
>> OK, let me see how it should be done. I'm not sure of changing other
>> params are permitted either, but imagine:
> 
> I would split it up for next_track and open, so that we have clear
> flows.
> 
>> the application calls set_params first then after some deliberation and
>> before starting it reconsiders and wants to have bigger/smaller buffer.
>> I know, they rarely do, but if such application assumes that the second
>> buffer setup is valid, while we kept the initial one, things might break?
> 
> Hmmm, do we really want that. they can tear down and reopen in that
> case?
> 
> If we split as above, in next_track case we can apply codec params while
> ignoring buffer.. wdyt

What if we just refuse consequent set_params in OPEN state?
That does not make much sense and can collapse patch 1 and 2 into one.

> 

-- 
Péter

