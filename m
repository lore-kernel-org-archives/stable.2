Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABB440A93A;
	Wed,  5 Aug 2026 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923937; cv=none; b=cpcpIilG9totYoYdJknHHvWz9AAqJ8Cd+4+kfuozGOov+MTmu1GNLaW9qAtixK9mGnya2r0hiFXEwyqQOCG3CZliRmMUq3+IVGX7YORMBlif0j4Yt8oMh6zP9dc8KP+Jk/VhfUZSvIpIjFKB8VzRbL6xAO8aN6b3hbv6TKN9xj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923937; c=relaxed/simple;
	bh=sF0OGd1ob8oRw3chFtxg+BWQSg3uRNKOpuLbm5fVoiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pHjcoWHL2GfhCR29pwjLzvSj0kedlfMDPXF5IK0GeGVyf9X61CVka9PPIbRsccKKAgt9mcS7Y7VNDby//vvTW4fcT6Qlcj3tHdCB/C1wpKmL5IXNTCpjKW/lTz3BU694iC+ceLQTUAdDCUWutiFibfstv/oRGay3u91pcXNHsME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mESjoHeO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mESjoHeO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785923936; x=1817459936;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sF0OGd1ob8oRw3chFtxg+BWQSg3uRNKOpuLbm5fVoiY=;
  b=mESjoHeOaGtG4VCMbxpI7aYDIvFEuOQlSjLw/kDKmggROMYRCAtyh7Dz
   TnD1Nn/+F2RKB6eP5Nzwt7oZck3ikCQXQCPKGqMoLwNO7kXwca5JqlG32
   zqRfWAK3zzxpl27LIoHe1+G5l5PHgDOlAwHdGOG4CAU0C93Ajujs67G3k
   TqZAboVxEwalVmW1IgFfIpofS3mHu4SvR9mCoT5XHUD5M9KSv1h4dZ4Az
   U0hK71xuzgAS1IjWWC0tkE60Oezn6wPGyu9OGyJQ5yBnItoj1Ja9+C+o9
   KD10IuqWGKmmX3wzpThYd0IY8qtUvFpYVrGKJh74x/a0PEpwGiIsXbpC4
   A==;
X-CSE-ConnectionGUID: 3M5D4rNNRaCjFssHuXri+w==
X-CSE-MsgGUID: lIWEsoJuQkaF1gtwAF78aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97087661"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97087661"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:58:55 -0700
X-CSE-ConnectionGUID: LWrKA3Q6QMWFmeNvsskuxg==
X-CSE-MsgGUID: iNl4/XToSBepdCBp7tjw2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="260490359"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.246.218]) ([10.245.246.218])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:58:52 -0700
Message-ID: <5d84444a-c472-4881-9432-e0dbe5610696@linux.intel.com>
Date: Wed, 5 Aug 2026 12:59:30 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
To: Richard Fitzgerald <rf@opensource.cirrus.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
 Paul Handrigan <Paul.Handrigan@cirrus.com>, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, stable@vger.kernel.org
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
 <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
 <b5631801-2904-48e3-b4f7-9ad6009c1198@opensource.cirrus.com>
 <96c0cebf-3ec3-4136-b010-32187ff8c870@linux.intel.com>
 <anMBeeNG1fDpFHzN@opensource.cirrus.com>
 <81391ad1-1097-43ca-8729-ae01c00db3b2@opensource.cirrus.com>
 <4c407a93-7cb6-4a44-a7b6-4d972e714b4e@linux.intel.com>
 <ffa045f4-dfb1-4ec8-b9f5-ce2205e83fb5@opensource.cirrus.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <ffa045f4-dfb1-4ec8-b9f5-ce2205e83fb5@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/08/2026 12:56, Richard Fitzgerald wrote:
> On 05/08/2026 10:52 am, Péter Ujfalusi wrote:
>>
>>
>> On 05/08/2026 12:38, Richard Fitzgerald wrote:
>>> On 05/08/2026 10:25 am, Charles Keepax wrote:
>>>> On Wed, Aug 05, 2026 at 12:10:10PM +0300, Péter Ujfalusi wrote:
>>>>> On 05/08/2026 12:00, Richard Fitzgerald wrote:
>>>>>>>> Found by an audit of all reg_defaults tables under sound/, the
>>>>>>>> SoundWire
>>>>>>>> codec drivers are fixed by a separate series.
>>>>>>>
>>>>>>> Wow. Would it make sense to have a regmap helper to double-check the
>>>>>>> addresses are indeed in-order in those reg_default tables?
>>>>>>> I am not sure how this requirement can be enforced by just
>>>>>>> inspection, a
>>>>>>> warning would help detect this sort of issues on more platforms.
>>>>>>>
>>>>>> It does seem probable that anything that relies on people just
>>>>>> remembering to keep a large table sorted is prone to breaking,
>>>>>> especially if the addresses are provided by named constant instead of
>>>>>> a list of hardcoded numbers.
>>>>>>
>>>>>> Should regmap check the table when the regmap is first created?
>>>>>> As it has to search the table during normal use anyway, one extra
>>>>>> walk
>>>>>> when the regmap is created probably isn't a serious overhead.
>>>>>
>>>>> But it will be done for _all_ devices which uses regmap on boot, small
>>>>> things do add up, see my reply to Pierre-Louis.
>>>>
>>>> Indeed, if we were to add some sort of auto-checker it should
>>>> be guarded behind something like perhaps a Kconfig option or the
>>>> DEBUG define.
>>>>
>>>> Thanks,
>>>> Charles
>>>
>>> regcache_init() already walks the defaults table checking the stride
>>>
>>>      for (i = 0; i < config->num_reg_defaults; i++)
>>>          if (config->reg_defaults[i].reg % map->reg_stride)
>>>              return -EINVAL;
>>>
>>> so checking that each entry is larger than previous is trivial extra
>>> overhead. I think most regmaps are cached.
>>
>> Right, I think this should work:
>>
>> diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/
>> regcache.c
>> index aa8f2efed779..ce4b11d8a758 100644
>> --- a/drivers/base/regmap/regcache.c
>> +++ b/drivers/base/regmap/regcache.c
>> @@ -123,6 +123,7 @@ static void regcache_hw_exit(struct regmap *map)
>>     int regcache_init(struct regmap *map, const struct regmap_config
>> *config)
>>   {
>> +    bool sort_defaults = false;
>>       int count = 0;
>>       int ret;
>>       int i;
>> @@ -149,10 +150,15 @@ int regcache_init(struct regmap *map, const
>> struct regmap_config *config)
>>           return -EINVAL;
>>       }
>>   -    for (i = 0; i < config->num_reg_defaults; i++)
>> +    for (i = 0; i < config->num_reg_defaults; i++) {
>>           if (config->reg_defaults[i].reg % map->reg_stride)
>>               return -EINVAL;
>>   +        if (i && config->reg_defaults[i - 1].reg >
> 
> You could test the stride of defaults[0] first before the loop, and
> start the loop at i = 1. Then on each loop you can test [i] against
> [i - 1] without the need to check i != 0 every time.

OK, should be better like that

> I don't think we need to sort them. Just fail, so that an unsorted table
> must be fixed.

That would be a big regression all around the place, ordering w/ the
debug message if developer is interested is much better.

-- 
Péter

