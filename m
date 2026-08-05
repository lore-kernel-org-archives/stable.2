Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2823F38E100;
	Wed,  5 Aug 2026 10:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785925051; cv=none; b=YTfNEkmP8/hAUKBn+gmaxowK1wwFbKcQihCZM/x9B1JV6hLoWokuC64VSG0wtR/vFnf4Yk9f5LpSHXjj6XM3J/0ABDXjm0XVXVULh9cO6WKjWMqDEKy2IP7/dWPEZWRUWIkU/n6u8P0/fA1lpVXK8Xj8FoGheuTr26rvIzb0qAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785925051; c=relaxed/simple;
	bh=sq38C/LN3LBHFhxbHEpsv2PkDxjJFr2ef2lBv96rKHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oNcq+Q/sKauLlnNVr0Fh1lmoMJOXRMXkE8iiA8oCUS3kI0ViiHKEztn9P486g9ub6NgxbznCutKk/qXW6ASu6CUYH2O8nCODqikndBNl91TjSIouEdHNq/KV2wIzPT6/j96N4zwPnrln9QneLGl/UZExKYjiQk1zNCgbrfS9Uf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=czacCiQB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="czacCiQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785925049; x=1817461049;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sq38C/LN3LBHFhxbHEpsv2PkDxjJFr2ef2lBv96rKHc=;
  b=czacCiQBK4ZG1CSmKvpl0IuX0qy2WpKNbi/Q/pM/oMNunqdzAAX1Td0s
   aJJc63h3wdQcnBpEicxxDk6wW3CPUnjDBRxnlZCMYJEstzCQwMJ1g0Ygp
   WhinG3ycjfciYMJQjLe4aMtTTzD+vCO5Gnnfox7efNS38OsI/E9PLcbbG
   rI1MnwEv8RVpo+Y/MjVXyORk6PW7qZu6C+KsxMkJRuXaZj5uSDUS5yBRz
   XpWejQBnpZxj1m2pE12yNbjb/h6PPUhyry7hjgCbTAZBmST2d7MOs9LVB
   tRbybpRjthEV77E6siDJZ7+sxn4LV+SBd+CzM2Bz8dwHDlddTf4gfnGol
   w==;
X-CSE-ConnectionGUID: ZEqVFGatRBOXSfeN26GUww==
X-CSE-MsgGUID: okqkOwNvR/O+storLu8Whw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="98000028"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="98000028"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:17:17 -0700
X-CSE-ConnectionGUID: 1o5fOGNRRHqbflCpIpC9Zg==
X-CSE-MsgGUID: EYOLB273SpWEjyQJqa3Dmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="258429956"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.246.218]) ([10.245.246.218])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:17:14 -0700
Message-ID: <9eadca12-1968-49cc-8704-bb6f37dccb95@linux.intel.com>
Date: Wed, 5 Aug 2026 13:17:52 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
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
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <anMMIH29hLtOH3kX@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/08/2026 13:10, Charles Keepax wrote:
>>> I don't think we need to sort them. Just fail, so that an unsorted table
>>> must be fixed.
>>
>> That would be a big regression all around the place, ordering w/ the
>> debug message if developer is interested is much better.
> 
> I think I would come down between the two of you. I definitely
> agree with Richard on don't sort them, just encourages drivers to
> be wrong. But I also agree with you, don't hard fail. I would
> vote for just print an error message and carry on. That way no
> regressions, but also a nice big warning message to let people
> know what is wrong when they see problems.

I usually try to avoid alarming/annoying users with error messages, on
the other hand I agree that w/o some pressure, these will never be
corrected at root either ;)

On the yet another hand, if the regcache have means to fix this, it
might be put into use as well.
A dev_warn at max to get attention or info level perhaps and fixing it up?

-- 
Péter

