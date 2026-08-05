Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27AC3E6DCA;
	Wed,  5 Aug 2026 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919919; cv=none; b=EuznWKjm0MY8nIWd+wIku01bSULRPQ8qowbG3abBn5PiOmu6bB5feGxkQz5Bige127E5Gn83XPZ9z8jeTJOU7NO4Lt4cfN1+Sjd+X7/Wmg/OqenCnXnqCSPOCxC4HJdy6rG9QV5ulxIFPDKGExvZgqDfoU2/mwDCNq+wBUImwJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919919; c=relaxed/simple;
	bh=P71HUfJrfRGSkXmaA9Xr2AdPFU/87wQn8Yd35RjDs0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkiHMUZ4Y7oB3/f1OSjmRxSNyKGrwvLIDdTOtZfpKwjaHeSlkAsZjYixAdlHjIoAslEUUfAEIpqZ4GUp2IlC9Qt6DIul6lT3Xo9eVbXgxVa/iU01gKHF+/Qjm9+UjWybeI0eKs3tyjSZF+W9k2VYEQCW72+nO8UotRfXtkcNoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuAGevii; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuAGevii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785919918; x=1817455918;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P71HUfJrfRGSkXmaA9Xr2AdPFU/87wQn8Yd35RjDs0o=;
  b=ZuAGevii+SkKGUNw/IEcm3V66DpW/7dbFgwBNeBcDzEPMD0xMlKWwSR4
   3vvkG/eVU9hcm8gGkP2HyohadNdPzIHmdzZJv0nOcNL1LuaIYS1bmjygT
   l1h8cJIul3oXZ1tSsnQG+vh0QraxxBy4olHuPIhiHUwMdOfdKLiF8HOvs
   XKbFj/+AvDQI1Igsj9fmqFY2VGZpnE3ZfxgjPFRpaKeMQbLPSmsWOOhJ5
   gx0YihIifzioUKhcjZ8WxStC9PnRtrxiCqQEwJF8MB2tYVrAxKr7d8VKJ
   4pc7m0DCeQM1UR7+vCB2bIP216eO9mn0wYm2sGo570SSNp4YYGDJGsWIx
   Q==;
X-CSE-ConnectionGUID: VrEH7xTNRLeNI1iVM7q7WA==
X-CSE-MsgGUID: vWqyLzKJS8WjkGHTov5eNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="109275439"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="109275439"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 01:51:57 -0700
X-CSE-ConnectionGUID: 2NO5KUsDTGGDNf4XKgXWug==
X-CSE-MsgGUID: XYsDiTi0SQuIsVB3/QJvrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="260477182"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.246.218]) ([10.245.246.218])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 01:51:54 -0700
Message-ID: <7f7b5f6d-cead-4741-9b44-411ea56052f3@linux.intel.com>
Date: Wed, 5 Aug 2026 11:52:32 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
 Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
 Paul Handrigan <Paul.Handrigan@cirrus.com>, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, stable@vger.kernel.org
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
 <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/08/2026 11:40, Pierre-Louis Bossart wrote:
> 
>> reg_defaults must be sorted by ascending register address as
>> regcache_lookup_reg() locates the entries in it with bsearch(), see commit
>> fd80df352ba1 ("regcache: Add support for sorting defaults arrays").
>>
>> These three tables have entries which are out of order, so the binary search
>> does not find part of them.  For those registers regcache_reg_needs_sync()
>> cannot compare the cached value against the default and reports that a sync
>> is needed, so they are written to the device on every regcache_sync() even
>> when they were never touched.
>>
>> The patches only reorder the existing entries, the text of every entry is
>> kept verbatim and no default value is changed.  Each table was verified by
>> evaluating the register addresses and replaying lib/bsearch.c on them.
>>
>> Entries not reachable by the binary search, per table:
>>
>>   cs35l41_reg           2 (of 47)
>>   cs35l45_defaults     36 (of 73)
>>   cs4265_reg_defaults   3 (of 16)
>>
>> For cs35l45 this is nearly half of the table: the DSP1_RX*_RATE and
>> DSP1_TX*_RATE registers sit in the middle of it while their addresses are
>> far above everything else, which cuts the search off from the whole
>> 0x4c40 - 0xf010 range.
>>
>> Found by an audit of all reg_defaults tables under sound/, the SoundWire
>> codec drivers are fixed by a separate series.
> 
> Wow. Would it make sense to have a regmap helper to double-check the
> addresses are indeed in-order in those reg_default tables?
> I am not sure how this requirement can be enforced by just inspection, a
> warning would help detect this sort of issues on more platforms.


I had this first:
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index be167ee6f57c..7d2f74494645 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -187,6 +187,9 @@ int regcache_init(struct regmap *map, const struct
regmap_config *config)
 		if (!tmp_buf)
 			return -ENOMEM;
 		map->reg_defaults = tmp_buf;
+
+		/* regcache_lookup_reg() bsearch()es this array */
+		regcache_sort_defaults(tmp_buf, map->num_reg_defaults);
 	} else if (map->num_reg_defaults_raw) {
 		count = regcache_count_cacheable_registers(map);
 		if (!count)


But it would run for all regmap on boot and I think that would be a big
hit on boot time.
I guess, a debug kernel option could enable ordering check for defaults
in regmap and warn if it finds such?

-- 
Péter

