Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326123BAD9A;
	Thu,  8 Oct 2026 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446040; cv=none; b=YpDoIXB5Y3O5TZZUSMp9BNUDbfPoXoyvmZ+/mM4l9qgZfQHHolEC3PAWTZU7lzkSoblQ3gtT8VR/nDjLEeMtcTCni8RI477rqrcoT+HqhdObuenMqtPJX6anUf5dA3F6Uj1YoNpH1kgs0M8RmBfJrBN7+nqscWekCn6X1OReWDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446040; c=relaxed/simple;
	bh=TQqiUxdiJk3lKT/9jhWHvX+7gNvaeJ/T7tMH7E1afqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKJ8RNCsp7xf9gqh5r2oOdUdP4S2jsIl9a/sFFJAmizxSYnzWzgVTKXdy1xFCHaL9zZ5fPGkt+egesbo4Baa7R4z9E4y9SQ4cS+eF/HK+Lum9GUNAxYSsEb4ZPTjbX3G3x5ATs9R6/qEc6tPXZiLexSlMmzbfENUz2OrPps40wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMx0XEDL; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMx0XEDL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791446038; x=1822982038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TQqiUxdiJk3lKT/9jhWHvX+7gNvaeJ/T7tMH7E1afqY=;
  b=BMx0XEDLBKGjHrm3ZksT5epq2zFyejsJnaGP+JgBvq+4U2yrawyHJLAb
   WLL3HL2ulmSzJqKXZnNkGaTSpnd5s7fH3tJb3BVlQW5JHE5ES63a7m4Ib
   oRpjd6O3Vrr5Rb3ltU3vSRH6v3HRvR2Iu//H3pyQPsdJRkMsEzwu1ADAI
   fNtZDex23gd+Xiuie/dttHKhz3hX4mRS0X2TRRyaKMt1QsaK/kV8eRlRw
   YnAIZQlYk9S21KG65eEK8VtGzTmS1RiCVD7O0Nw+kJK/6kooCr05DnLUT
   qqO5sreAI8llksNgnCAIYBKk8lsg7cA/a70zJIyLP9aUbjkivFi5xv6aN
   A==;
X-CSE-ConnectionGUID: xsAWgJlcRISKCr8nHfqQcA==
X-CSE-MsgGUID: y4Tx3WLbSK25Flh4oQmuYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="229670"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="229670"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 00:53:53 -0700
X-CSE-ConnectionGUID: pP7hUfakSheA9dcv1iutYQ==
X-CSE-MsgGUID: 8p1CsQRdRpGA6BpA+NXL+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="1796356"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.245.74]) ([10.245.245.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 00:53:51 -0700
Message-ID: <4fb417d8-94c3-473f-95bc-8d15b7c98654@linux.intel.com>
Date: Thu, 8 Oct 2026 10:54:13 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ALSA: compress: fix buffer leak on repeated
 SET_PARAMS
To: Takashi Iwai <tiwai@suse.de>
Cc: vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
 pierre-louis.bossart@linux.dev, linux-sound@vger.kernel.org,
 stable@vger.kernel.org
References: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
 <20261007132509.18237-2-peter.ujfalusi@linux.intel.com>
 <878q49obcu.wl-tiwai@suse.de>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <878q49obcu.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 07/10/2026 17:04, Takashi Iwai wrote:
> On Wed, 07 Oct 2026 15:25:06 +0200,
> Peter Ujfalusi wrote:
>>
>> snd_compr_allocate_buffer() unconditionally overwrites
>> stream->runtime->buffer with a freshly kmalloc'd buffer whenever the
>> driver has no ops->copy and no preallocated dma_buffer_p. SET_PARAMS
>> is permitted repeatedly while the stream is in the OPEN state, so a
>> local process can loop SNDRV_COMPRESS_SET_PARAMS and leak the
>> previous buffer on every call, exhausting kernel memory.
>>
>> Free any framework-owned buffer before replacing it, mirroring the
>> ownership check already used in snd_compr_free().
>>
>> Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
>> ---
>>  sound/core/compress_offload.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
>> index 7c397b1c9231..c0ed76e1c844 100644
>> --- a/sound/core/compress_offload.c
>> +++ b/sound/core/compress_offload.c
>> @@ -613,6 +613,10 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
>>  			return -ENOMEM;
>>  	}
>>  
>> +	/* a prior SET_PARAMS may have left a framework-owned buffer behind */
>> +	if (!stream->runtime->dma_buffer_p)
>> +		kfree(stream->runtime->buffer);
>> +
> 
> I'd rather put to the else block above (or even better, if
> (stream->runtime->dma_buffer_p) block above that point).
> 
> The code is specific to that condition, after all.

Yes, that is true, but then we would also need to add additional check
in there and free only if the allocation succeeded.

I think that would somehow be a bit more convoluted to grasp at once

-- 
Péter

