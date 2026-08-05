Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4678242B331;
	Wed,  5 Aug 2026 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929121; cv=none; b=tFTVuknHmkH4xLGftkSj1/UM+Gymslndu0nnQx4SkZmMFc6AHrzdLEgOtfnkU0DTnHhXFxuavLIV3heygEXc/tw3XhZwlC8ZhsBU1Ky9ZlSSv1YRPfwbiCwOqmy1PSrx/lX0u/ZwAjWN4+EquC/AZ2uhJcDRS1tXdDxpu5/ADLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929121; c=relaxed/simple;
	bh=u8T2KJlRmfViBB0JWYPqN+GnpLzZTe+MLCp5VYkJBT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNZIqqXr1FSCEyl+gmVO5iaN/geJxmnTYhly4yBgpBap+kQv/gNNIbynq4JMkn52hkRESnoU1qh8k87druUqvjJTzluuH9jNnITcmGn5D2Qf0ljWevStwzJKTvZm5cELXEzOTs48019NojwX8qXGEOZbq9PshNckwUUZsIzUUEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWSBt8xo; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWSBt8xo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785929118; x=1817465118;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u8T2KJlRmfViBB0JWYPqN+GnpLzZTe+MLCp5VYkJBT4=;
  b=EWSBt8xovYgH58smtmGz7zFmL79jzs1xDFQ2W18QxY2PIO6ACQp9GhJS
   JstMj/abLewptKwRVR5lwY6uuHhZaapP1Cf/stZDfx3arAhmy5NIVMwL0
   nh3rGw6YFcn/HWzMsSXD20SB4O+Iqq//7ra9jT+6ldIZPe4TRPVzGXjPI
   L4Hlfd2ZytZGxYgJfd8Tdm8DdBYpl13Vu4BTFLQOoSFwHnG8cO9L2fcUh
   0K9sMYYas1oA1M0mJyvj0kQgaZflf9mdiMbVnTlkMLYv4qY0yleQOk6cI
   n+o3zwnNIIleSzOcqr/ckPgDrqfrO4MjZZwtYkq821u4gj5v4ULJHFMwA
   A==;
X-CSE-ConnectionGUID: Nkok5jeBRFKfgNDi5n6ZMA==
X-CSE-MsgGUID: Y0YVXpHRT9a55ZuAh96ZvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85475661"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="85475661"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 04:25:17 -0700
X-CSE-ConnectionGUID: RfK/XcB5QTW9GF7Kwa1HBg==
X-CSE-MsgGUID: Tnzs3S2NQPyrW3fSvvJp7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="285154820"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.246.218]) ([10.245.246.218])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 04:25:14 -0700
Message-ID: <272f965d-4265-4467-9cd0-20259e107eff@linux.intel.com>
Date: Wed, 5 Aug 2026 14:25:52 +0300
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
 <5d84444a-c472-4881-9432-e0dbe5610696@linux.intel.com>
 <anMMIH29hLtOH3kX@opensource.cirrus.com>
 <9eadca12-1968-49cc-8704-bb6f37dccb95@linux.intel.com>
 <2585c2ec-1146-4a48-9169-274449d1bbda@opensource.cirrus.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <2585c2ec-1146-4a48-9169-274449d1bbda@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/08/2026 13:36, Richard Fitzgerald wrote:
> On 05/08/2026 11:17 am, Péter Ujfalusi wrote:
>>
>>
>> On 05/08/2026 13:10, Charles Keepax wrote:
>>>>> I don't think we need to sort them. Just fail, so that an unsorted
>>>>> table
>>>>> must be fixed.
>>>>
>>>> That would be a big regression all around the place, ordering w/ the
>>>> debug message if developer is interested is much better.
>>>
>>> I think I would come down between the two of you. I definitely
>>> agree with Richard on don't sort them, just encourages drivers to
>>> be wrong. But I also agree with you, don't hard fail. I would
>>> vote for just print an error message and carry on. That way no
>>> regressions, but also a nice big warning message to let people
>>> know what is wrong when they see problems.
>>
>> I usually try to avoid alarming/annoying users with error messages, on
>> the other hand I agree that w/o some pressure, these will never be
>> corrected at root either ;)
>>
>> On the yet another hand, if the regcache have means to fix this, it
>> might be put into use as well.
>> A dev_warn at max to get attention or info level perhaps and fixing it
>> up?
>>
> I asked Codex (GPT5) to search for all reg_default tables with out-of
> order entries or duplicate entries, looking only at those assigned to
> struct regmap_config.reg_defaults (some reg_defaults tables are used for
> patching - those are allowed to be out-of-order).
> 
> It came up with this:
> 
> Restricting results to tables referenced by struct
> regmap_config.reg_defaults, 39 files violate the rule:

and some of these have duplicate addresses with different default values.

I can send more fixes while I'm at this for the clear cases, for Cirrus,
Realtek and TI I have sent few patches.

> 
>   drivers/firmware/cirrus/test/cs_dsp_mock_regmap.c
>   drivers/leds/leds-lp50xx.c
>   drivers/mfd/cs42l43.c
>   drivers/platform/mellanox/mlx-platform.c
>   drivers/power/supply/bq25980_charger.c
>   sound/soc/codecs/ad1836.c
>   sound/soc/codecs/adau1373.c
>   sound/soc/codecs/adau1761.c
>   sound/soc/codecs/adau1781.c
>   sound/soc/codecs/cs35l41-lib.c
>   sound/soc/codecs/cs35l45-tables.c
>   sound/soc/codecs/cs4265.c
>   sound/soc/codecs/cx2072x.c
>   sound/soc/codecs/lm49453.c
>   sound/soc/codecs/max9860.c
>   sound/soc/codecs/ml26124.c
>   sound/soc/codecs/msm8916-wcd-analog.c
>   sound/soc/codecs/pcm512x.c
>   sound/soc/codecs/pm4125-sdw.c
>   sound/soc/codecs/rt1019.c
>   sound/soc/codecs/rt1318.c
>   sound/soc/codecs/rt274.c
>   sound/soc/codecs/rt286.c
>   sound/soc/codecs/rt298.c
>   sound/soc/codecs/rt700-sdw.h
>   sound/soc/codecs/rt711-sdw.h
>   sound/soc/codecs/rt715-sdw.h
>   sound/soc/codecs/sgtl5000.c
>   sound/soc/codecs/sti-sas.c
>   sound/soc/codecs/tas2552.c
>   sound/soc/codecs/tas2764.c
>   sound/soc/codecs/tas2780.c
>   sound/soc/codecs/tas675x.c
>   sound/soc/codecs/wm8996.c
>   sound/soc/fsl/fsl_easrc.c
>   sound/soc/tegra/tegra210_admaif.c
>   sound/soc/tegra/tegra210_i2s.c
>   sound/soc/tegra/tegra210_mbdrc.c
>   sound/soc/tegra/tegra210_mixer.c
> 

-- 
Péter

