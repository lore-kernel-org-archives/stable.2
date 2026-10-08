Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67E13DD532;
	Thu,  8 Oct 2026 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446253; cv=none; b=boUpi0JQyRx9OCG/NPl9oE5AL0CdcDQ/lwe8uRONJ9gGQ+RYKy/zQXiaMm9LvQj+Bz2nnMcCI+8PRccpUtCpM0P6jVub4qRSUXochaILPIg3wcXvul/4i/atGohhTq0mBL87QI5nbljPmj00wxO0A3P/mTSmhCeQtvHPa96SQoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446253; c=relaxed/simple;
	bh=N4k3GdIsGTayEEAP190vVXGz/8LTxMJd15sOaQ3eTvo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rSoRg9KkJFSzSgsx08mayaCqJ1pYxKRu4MusyfMMGre0SackS+7No311M3kqb/8d5Ef3zSwdBlnXtr6EKVNBedGz3SJiJdn8W6pXUy4yJ3fcg0WNqKC2dUxZriPw+veFIMAiopzjjwXaBc5glvdvnNh7LzTpkNzPI9K6aREu9DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzeqQI7L; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzeqQI7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791446252; x=1822982252;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=N4k3GdIsGTayEEAP190vVXGz/8LTxMJd15sOaQ3eTvo=;
  b=KzeqQI7L9nHjq0bCSvUn4XYLp7/HXKOb5g7t4J9Ve24cuy43Qzm0QN8Z
   wwlHqNeyqUqE8PLQdQ4QxbuiwWc0+OnyM/FkIP6vcglBZXvAyGLmMWFgm
   i0r2nuSu2CzrpkslS7fnCIp/TZWsQrw+ZpCG9KmgZfvPo6gBUEtVPQHvC
   XIxl3Qry7mfMET7Sf815bJs34OQhhux9HRg/RyP8Y9iPS0QYHUIyqnhL5
   YoL3yDaABpma7kyBs083H5RrGJkYzrXZLiqonHdka59f91Yj1bEZ3Ilig
   MLnIZhz5ygwssvKMMuLB98m/A7FGfmzM764jEheDu6jQkSU/zQ2eg5x26
   g==;
X-CSE-ConnectionGUID: gxAspJxIQGWvMdUZl/beeA==
X-CSE-MsgGUID: AWDQMV8dRF+0p9HD9cv3xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="230055"
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="230055"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 00:57:31 -0700
X-CSE-ConnectionGUID: +FwMXM4CS6W/dOox3H++7A==
X-CSE-MsgGUID: 7V12SZiXQQ6v4afKNZJS5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,145,1787036400"; 
   d="scan'208";a="1797474"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.245.74]) ([10.245.245.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 00:57:30 -0700
Message-ID: <57be379a-f230-4e5a-9f23-19d21142a33a@linux.intel.com>
Date: Thu, 8 Oct 2026 10:57:52 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ALSA: compress: fix buffer leak on repeated
 SET_PARAMS
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, perex@perex.cz, tiwai@suse.com,
 pierre-louis.bossart@linux.dev, linux-sound@vger.kernel.org,
 stable@vger.kernel.org
References: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
 <20261007132509.18237-2-peter.ujfalusi@linux.intel.com>
 <878q49obcu.wl-tiwai@suse.de> <asZSywHEbx-u6uBs@parshuram>
 <6e27af41-1ba4-4d3e-a128-c2d1402a8f6e@linux.intel.com>
 <asZZJ--dC9M7jx4A@parshuram>
 <1acd072e-2b87-4083-84cb-9de6252b4382@linux.intel.com>
Content-Language: en-US
In-Reply-To: <1acd072e-2b87-4083-84cb-9de6252b4382@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 08/10/2026 09:25, Péter Ujfalusi wrote:
>>>> I would block calling snd_compr_allocate_buffer() for subsequent
>>>> set_params, it should not be allowed.
>>>
>>> OK, let me see how it should be done. I'm not sure of changing other
>>> params are permitted either, but imagine:
>>
>> I would split it up for next_track and open, so that we have clear
>> flows.
>>
>>> the application calls set_params first then after some deliberation and
>>> before starting it reconsiders and wants to have bigger/smaller buffer.
>>> I know, they rarely do, but if such application assumes that the second
>>> buffer setup is valid, while we kept the initial one, things might break?
>>
>> Hmmm, do we really want that. they can tear down and reopen in that
>> case?
>>
>> If we split as above, in next_track case we can apply codec params while
>> ignoring buffer.. wdyt
> 
> What if we just refuse consequent set_params in OPEN state?
> That does not make much sense and can collapse patch 1 and 2 into one.
tried several other ways on this (patch 2 included) and at the end I
have ended up with the exact same patches.

Two separate issues and the two patch covers the points well.

The set_params in OPEN state is sticking out, but I think that allowing
it to re-allocate memory is the right thing:
this can only happen if the stream->ops->set_params(stream, params);
fails and in that case user space might want to try different memory layout.

I would leave the series unchanged.

-- 
Péter

