Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99721A6836;
	Wed,  5 Aug 2026 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921095; cv=none; b=iULwihusZ3XLTE/LgwYjHz1O1XuGqrk05TwoJmGX+LCKp9gfqoKkJM6PlxA9BrnPurWEtChGbfs+g3lCtw4ja6I428FgPaiADeRld1NyU9VE2BDX7jEOXTRW+67ojZvUI8cdUH9j17oEBFgYf4/P9hUta/NkrDx+e0qbqkjHHdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921095; c=relaxed/simple;
	bh=YSuVPINONtZ816DeWRlB0//mAPCvFD+6/XsRDQj977Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDsfw5d798LokCXQF6i68ISbUQC8mlVWBT8aPQYNHVrp8AQf7+DdQKIbSRJReaUCmO/4/oveqMWExt8EZgV6fbxbnvkMIy7okxTZ0oOkBidHaeVUJCSm3Kv5vth0Mk7kkCIGGi1g9SHPh3Su9WBC51sCO7hiHJljNrV26pNKauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaFZfPgB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaFZfPgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785921094; x=1817457094;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YSuVPINONtZ816DeWRlB0//mAPCvFD+6/XsRDQj977Y=;
  b=CaFZfPgBpzagSCRBdR5/NypKj5TqQVi+1llVulZ1wYxJrAyrlVswvOBv
   hXtJNjwBBw5jwTQIc5gwJ+vauVfO74lD34m71a7IhkapDZYXG/dDvJV1M
   pKU+TLnNHSLSFqLlR1TSHdbIYtYyuc+WgzW4pTXLsU69f9Q2uQr8R+gaU
   20EOeaQpWPv/DqpsctVpYsKxmse6xe70DVi2Abeha7XrmybGYEJwshOwj
   DX2cXq8xy+cqwfDQHzOiwOsKgoBK5VfihFBoAnNhirQh6ha/1Ws+efBzs
   WCCCJrlvlkH56VdYyyocUbPQORplwQ5tepJuBv6pmy5w31BU3a1t1d5dE
   A==;
X-CSE-ConnectionGUID: KscRj1cESjqdL5olI5nN1Q==
X-CSE-MsgGUID: PXQ+Hsq6TRGLZxSrwSGJIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86690647"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86690647"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:11:33 -0700
X-CSE-ConnectionGUID: 2m5vMOpoR6OXPQ9g3ukYew==
X-CSE-MsgGUID: jGaCB39hQMqtvTic8ecG4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="285123940"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.246.218]) ([10.245.246.218])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:09:33 -0700
Message-ID: <96c0cebf-3ec3-4136-b010-32187ff8c870@linux.intel.com>
Date: Wed, 5 Aug 2026 12:10:10 +0300
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
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 David Rhodes <david.rhodes@cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
 Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
 Paul Handrigan <Paul.Handrigan@cirrus.com>, patches@opensource.cirrus.com,
 linux-sound@vger.kernel.org, stable@vger.kernel.org
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
 <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
 <b5631801-2904-48e3-b4f7-9ad6009c1198@opensource.cirrus.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <b5631801-2904-48e3-b4f7-9ad6009c1198@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/08/2026 12:00, Richard Fitzgerald wrote:
>>> Found by an audit of all reg_defaults tables under sound/, the SoundWire
>>> codec drivers are fixed by a separate series.
>>
>> Wow. Would it make sense to have a regmap helper to double-check the
>> addresses are indeed in-order in those reg_default tables?
>> I am not sure how this requirement can be enforced by just inspection, a
>> warning would help detect this sort of issues on more platforms.
>>
> It does seem probable that anything that relies on people just
> remembering to keep a large table sorted is prone to breaking,
> especially if the addresses are provided by named constant instead of
> a list of hardcoded numbers.
> 
> Should regmap check the table when the regmap is first created?
> As it has to search the table during normal use anyway, one extra walk
> when the regmap is created probably isn't a serious overhead.

But it will be done for _all_ devices which uses regmap on boot, small
things do add up, see my reply to Pierre-Louis.

-- 
Péter

