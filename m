Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842073A9605
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920398; cv=none; b=S38Oet9WVdU4ZnqwyrFW3vmKEg9UuKuKFMAR+4DUK1REBTr0dom09vpY0opwnHVpQq+ZTRq49mA5FwIbSbcW5KG5G6RQi98/ZdeLPqWlfMDNwCp/CmnTqyrtm590iHaPO5qGPIvV4aciwC9stZHJ5ujCCqtQdDx/NTeOYA6p7LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920398; c=relaxed/simple;
	bh=fGF+pa4s8F09BN/lkBOue+jfHJLZ42gi9qRgZf6dc60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIeWaNS+IOvdSip4D5nK0eOLiqOt7c0nz6kb8MNLNLlsSjeBojKoIG1bCnuiu1UmUNwKZa0yQ3QfxpLuLmvFmXOUoZeLeD9bZ24II1zPvPe9n1gUsIrWblseIid/gjUNUu8X18BDvVcEfzhlwcaUkCSCRs5DwlmeFAxHxMre3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LkcwjNAI; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LkcwjNAI"
Message-ID: <edf84874-d9f3-4211-bf66-6bcfb57613bc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785920384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xe25BJj8DLtuKfOIiA2O0lcCWo9fhXBLYL06nNzac4Y=;
	b=LkcwjNAIIEGjm2Fg/9Unz5cVl4PFtLsSVzxUVVATPwqF3KaC0ITOGd+feyrzCvaNZPG3Ss
	Lygb+VO34bTWOr2NM6B/kqZZvELeatWo1cwLc+s6r8gah4X7LVtIN+4m4a3VSQa6LX1x70
	e2Ymlkq8FtG7hq9eiFn2OsBQSJSr6KA=
Date: Wed, 5 Aug 2026 10:59:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
 Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
 Paul Handrigan <Paul.Handrigan@cirrus.com>, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, stable@vger.kernel.org
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
 <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
 <7f7b5f6d-cead-4741-9b44-411ea56052f3@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <7f7b5f6d-cead-4741-9b44-411ea56052f3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/5/26 10:52, Péter Ujfalusi wrote:
> 
> 
> On 05/08/2026 11:40, Pierre-Louis Bossart wrote:
>>
>>> reg_defaults must be sorted by ascending register address as
>>> regcache_lookup_reg() locates the entries in it with bsearch(), see commit
>>> fd80df352ba1 ("regcache: Add support for sorting defaults arrays").
>>>
>>> These three tables have entries which are out of order, so the binary search
>>> does not find part of them.  For those registers regcache_reg_needs_sync()
>>> cannot compare the cached value against the default and reports that a sync
>>> is needed, so they are written to the device on every regcache_sync() even
>>> when they were never touched.
>>>
>>> The patches only reorder the existing entries, the text of every entry is
>>> kept verbatim and no default value is changed.  Each table was verified by
>>> evaluating the register addresses and replaying lib/bsearch.c on them.
>>>
>>> Entries not reachable by the binary search, per table:
>>>
>>>   cs35l41_reg           2 (of 47)
>>>   cs35l45_defaults     36 (of 73)
>>>   cs4265_reg_defaults   3 (of 16)
>>>
>>> For cs35l45 this is nearly half of the table: the DSP1_RX*_RATE and
>>> DSP1_TX*_RATE registers sit in the middle of it while their addresses are
>>> far above everything else, which cuts the search off from the whole
>>> 0x4c40 - 0xf010 range.
>>>
>>> Found by an audit of all reg_defaults tables under sound/, the SoundWire
>>> codec drivers are fixed by a separate series.
>>
>> Wow. Would it make sense to have a regmap helper to double-check the
>> addresses are indeed in-order in those reg_default tables?
>> I am not sure how this requirement can be enforced by just inspection, a
>> warning would help detect this sort of issues on more platforms.
> 
> 
> I had this first:
> diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
> index be167ee6f57c..7d2f74494645 100644
> --- a/drivers/base/regmap/regcache.c
> +++ b/drivers/base/regmap/regcache.c
> @@ -187,6 +187,9 @@ int regcache_init(struct regmap *map, const struct
> regmap_config *config)
>  		if (!tmp_buf)
>  			return -ENOMEM;
>  		map->reg_defaults = tmp_buf;
> +
> +		/* regcache_lookup_reg() bsearch()es this array */
> +		regcache_sort_defaults(tmp_buf, map->num_reg_defaults);
>  	} else if (map->num_reg_defaults_raw) {
>  		count = regcache_count_cacheable_registers(map);
>  		if (!count)
> 
> 
> But it would run for all regmap on boot and I think that would be a big
> hit on boot time.
> I guess, a debug kernel option could enable ordering check for defaults
> in regmap and warn if it finds such?

reordering the tables could take time even on a perfectly ordered case,
I was only thinking of throwing a warning with a simple loop on the table.
Maybe also something for kernel tests? A warning would require user
feedback whereas a formal test could check for hundreds of regmap defaults.
