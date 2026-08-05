Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4E0314D13;
	Wed,  5 Aug 2026 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921902; cv=none; b=Zp/njmIEHt9Nt3PX4OVyKeLXGNrPSl/Vt3uqZttcm3oPXp6z0ucgNYbuYLzcQyKMsZg20YROEEKhbT5I3bCNL/JFbYcwrqSYKl8ABpy7G7k5qzUQhoMMH7Z3bcekp2h9ohLS2axZI7QzR+cSk+WKETW3lpw35Md/mKWdpxSEVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921902; c=relaxed/simple;
	bh=SMIDjwLwN0QEkGXukuE17Y3XfoujsB+xS4XpgFB0B5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U8e/C4YA7ZNr1I11Hw2TrqESf18Whn+BEYbguLnlp3jYWXErj6Gq3eGf6selsZwHGhhjDlrxyE235EKUY5xqrjkZ8RkQ6XrWsEEW4O1mhEsoqhOweBe/D9GXQ6uBRJaBUY5TMWqvRS9F2Co6gCAaFgybMlAWcwHSD4HW3s6f+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lqr27Afa; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lqr27Afa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785921900; x=1817457900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SMIDjwLwN0QEkGXukuE17Y3XfoujsB+xS4XpgFB0B5g=;
  b=lqr27AfaLcqnMl5VemEFbPmHkTmbV3NVPlzR4tOmizPe3T/NYv3WSzht
   fnGHDpiesv6KaHuIy2rEqJB/gJfFdA/hFshdAY3FTcohsuUYe17xAuwUg
   LX4XZfDtE+Otbk3ckf1xAfLiVoCM/c4+SgveLVbwhHmASzmGgQmrNuEwi
   0KPNscVNMT13yTm7ooewdSdiB4DRkB9RMcD2WlYyvjmq3CyvmS32BXK2C
   y8VJXGTQ8X2ljcQyWjbddmIdDD23QzpJnxLdKzinMR5Hjk9RFKhwQCurc
   FaSSFGdGlCT59GCE42hIhlJL3/fUzchGxcxDmeFduI9n/Hnne8ZmfJMz1
   Q==;
X-CSE-ConnectionGUID: gQ5UHBx6SXeVzS3RSMErCg==
X-CSE-MsgGUID: tRno5vnVQ42GAIVLex66Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86691322"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86691322"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:24:58 -0700
X-CSE-ConnectionGUID: 6op22QXNRBea9C/c8haxDw==
X-CSE-MsgGUID: LCJ0+bGzTCm4fy3lHtYzkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="258415248"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.246.218]) ([10.245.246.218])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:24:54 -0700
Message-ID: <35eec730-d418-4f24-bbda-369bbff42026@linux.intel.com>
Date: Wed, 5 Aug 2026 12:25:32 +0300
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
>> Wow. Would it make sense to have a regmap helper to double-check the
>> addresses are indeed in-order in those reg_default tables?
>> I am not sure how this requirement can be enforced by just inspection, a
>> warning would help detect this sort of issues on more platforms.
>>
> It does seem probable that anything that relies on people just
> remembering to keep a large table sorted is prone to breaking,
> especially if the addresses are provided by named constant instead of
> a list of hardcoded numbers.

We have seen these 'soundwire_intel.link.0: Msg ignored for Slave 6'
type off messages in random cases, but with a series which check the
regcache_sync return value some codec's resume started to fail.
"*: Propagate regcache_sync() errors"

So, yes, register values generated by magic macros are hard to keep in
order, I completely agree.

-- 
Péter

