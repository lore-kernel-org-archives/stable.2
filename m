Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917C18A92F;
	Wed,  5 Aug 2026 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929863; cv=none; b=nxtHWQZTRquGiP4HmpGBt2sj+F/bljWaWq2o51RwfGPq+j1eejddJiNP36R1S4zpHpO32ZyHyfS05vvy9DXLR+vNoHMbogIsjpCFgy2VHnatGW+xqYuT54cfWeBmrc7rE0I82etsy2O4t456h9B3j06hEsBGArontcfeiDm4w7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929863; c=relaxed/simple;
	bh=UlEEzMhqDNPmUj2dhtHqPGK/w65l0L21DwcbdIuQnfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOnD7SPn4PE4zgeKfIk23y6f8cG4WLU+KayhrCVnILPmCcow8hISHlrtj4ji7lmHeMEUu/L6r7zBXOlqXrcz+HakD0mQYhIwcu2p9rP+UisycEJz5Iyoz3ePBKTH7+YQQCf061qCijHOtQCCEkTRbCwlBT0GRG3Xb78Y5yPIEkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1b5hPyI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1b5hPyI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785929861; x=1817465861;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UlEEzMhqDNPmUj2dhtHqPGK/w65l0L21DwcbdIuQnfE=;
  b=Q1b5hPyI5UBn+TvpUiVnVY1xlRm7J5owwBSnu48XpQcg37+EGYga8wmd
   qA2MMRVo9s67R8DLAp7DHRHxQK5AxeqbvKJCcTG3ooMyn1cK1dAUJmw21
   5VrQR8QSDYzRe/sZ2uavoLt0/Y75J9ICfs1WS4t6LiJ/hOjKSsD6OM5Ya
   HK/2ulhYQt8mwkA2qbsEc+IHQ0cLfgd/75YgzqIQMTEAZnmhfFaHq1JYU
   9QDxaHl8TTrdn3FzPDmDiB/Wjf4LLfntgZMeGZFNea7M+tuRXoAwoo4Gv
   B9OJq9KgQF/3V7VbtnVCPWS4mPxzmw1c8AxI2w0rwZ9zSit5Acj4yztiL
   Q==;
X-CSE-ConnectionGUID: q8j76lwDTrGOhxQuUDr7CA==
X-CSE-MsgGUID: KpMIx8P4TxyKRiVT28eY8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85476855"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="85476855"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 04:37:40 -0700
X-CSE-ConnectionGUID: gEqcl7BMQjmhbSOhreitgg==
X-CSE-MsgGUID: vZ+TIrYzQLiRk1/REYcnFg==
X-ExtLoop1: 1
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.246.218]) ([10.245.246.218])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 04:37:38 -0700
Message-ID: <a050a28a-1908-4cd9-b3fd-971e9fc5b7a0@linux.intel.com>
Date: Wed, 5 Aug 2026 14:38:16 +0300
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
References: <96c0cebf-3ec3-4136-b010-32187ff8c870@linux.intel.com>
 <anMBeeNG1fDpFHzN@opensource.cirrus.com>
 <81391ad1-1097-43ca-8729-ae01c00db3b2@opensource.cirrus.com>
 <4c407a93-7cb6-4a44-a7b6-4d972e714b4e@linux.intel.com>
 <ffa045f4-dfb1-4ec8-b9f5-ce2205e83fb5@opensource.cirrus.com>
 <5d84444a-c472-4881-9432-e0dbe5610696@linux.intel.com>
 <anMMIH29hLtOH3kX@opensource.cirrus.com>
 <9eadca12-1968-49cc-8704-bb6f37dccb95@linux.intel.com>
 <2585c2ec-1146-4a48-9169-274449d1bbda@opensource.cirrus.com>
 <272f965d-4265-4467-9cd0-20259e107eff@linux.intel.com>
 <anMfDz2CkDDIsVce@opensource.cirrus.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <anMfDz2CkDDIsVce@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/08/2026 14:31, Charles Keepax wrote:
>> I can send more fixes while I'm at this for the clear cases, for Cirrus,
>> Realtek and TI I have sent few patches.
>>
> 
> I was just having a look at cs42l43 so you can skip that one
> unless you already fixed it up.

Thanks, I will leave that out from my side.

-- 
Péter

