Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111069;
	b=1IwU8iMxXcU3U9Mf4y5w8m6JS3NA4TneTT3xJ08TGXRnhLk9wgctQ8VadHr1GQt0ai8Y
	 Ue0eC2CRN4hsyyWZeothqezWE4EfXEmoQhe7zr5Y/5hl4DHJVyk8zCpZRB21T6lxDuwJp
	 aPwCoDkbMTVmGKWChBWU0vfWZsKdeXd6Wl+G2PPYwCsihuk1dv4rAEBOdXzoil9kT6X6q
	 GgFjIdX1owSTlZ97jFhM2Uy/PUGE0Ot0XMLx/s/FRLgebiLCDICEcvezFZYxHBAZMicLw
	 rUvJMri00CjRAhvWE72P+16P3OVOJ3y1TXXQgAPsKyAkeD3Zw8Ra8jUSKNjRYe17Cyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111069;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=t5hCN1t/SGhky1BnDyQgcjHCC0OqfjVCgRdQIsBZeOE=;
	b=B/9d3Mwz99yofUFYuqPTfKAoC5/gn+D08vtqe2OfFIIb1ws4pFOE84rowpwiCyNuF+/J
	 wBV04nI1fTZvJ8f2iKARkzkuOW+jWUCGG7dQ+ii8Dm6c9ed4+lZJjEy4XdJDfgtJc27JZ
	 SY/9LnEEbERWHDOg/NmtiFFyCPsYsd0ImXGDWNC/6Ns/t3z8JIpoklFrPSQHCLUQxS0vC
	 giWoG8ZUjXdmnq4SGr6FR5UHTXQEWNmas1VYxTl9QRcQGYmDCLlV031XW5wpXqudhTV3C
	 WmpeCkUsMCmmOhq2fh1WTxMyu5nPEL6WLSgJMzaI738W8bzd9B1N6ssMMgu3kcLJHNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RJVIiMYX;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031FF606A331;
	Tue, 27 Oct 2026 14:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 031FF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RJVIiMYX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793111069; x=1824647069;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oFJf0HTuSasMZkq+qzGT8EwCX/NwO9npz+BPs99+1Yc=;
  b=RJVIiMYXmGW4Mhn9zY0YAJ4aCQVPNa6uwo8kE6MBXrBvoZrZ+rnUuYUG
   tNhgLodiCzVZmTNKaCUBKFF7FTajvv4J9AIKQi/gK0/A4NK8tmUNT/9gc
   mC5EvIrF9YPwGFfVoOhQl583130iUmqymtIbjW47G/y52b+KRTfLrnMXh
   RXyL6L6ZZMh8cYVvuVA8ttTn46oyEnYAsKx2ouFORXfTTwUbgSD1OD0zb
   YSkCujXSgcua1DdTWeQFJp2SzZmzOFATe9BXS1+R7NwJ8kKv5mE2pUbsS
   /CCwnQtupRAVifIPIGmPBqnyjOLbYFttthidubGxejGL2wSkcnece91FE
   Q==;
X-CSE-ConnectionGUID: vW22BLlgSWmuStLYzu7O2g==
X-CSE-MsgGUID: nNrwX3t5RHCGj4QundMkkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1715518"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1715518"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:24:28 -0700
X-CSE-ConnectionGUID: 90lKqiZiTVazMeoImvjzJA==
X-CSE-MsgGUID: S54650HNSUCzAGBZndSDRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4949379"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.245.199]) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 07:24:26 -0700
Message-ID: <e86902e0-ac9e-463b-ad43-a41437e77a9e@linux.intel.com>
Date: Tue, 27 Oct 2026 16:25:00 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] ASoC: hdac_hda: Fix module unbind/bind via sysfs
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
 kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
 stable@vger.kernel.org, tiwai@suse.com, perex@perex.cz
References: <20261027125448.11018-1-peter.ujfalusi@linux.intel.com>
 <5b1ffe72-2e96-41f9-8c9d-1cefdac89ba9@sirena.org.uk>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <5b1ffe72-2e96-41f9-8c9d-1cefdac89ba9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/10/2026 15:34, Mark Brown wrote:
> On Tue, Oct 27, 2026 at 02:54:45PM +0200, Peter Ujfalusi wrote:
>> Hi,
>>
>> Changes since v1:
>> - Add pm_runtime_set_active() after snd_hda_codec_device_new() in
>>   hdac_hda_codec_probe() function as reported and suggested by
>>   Sashiko Bot.
> 
> Please send an incremental change, I already put this into CI.

I don't see them in for-7.4, for-linus or for-next branches, the
followup should have a Fixes tag to be backported alongside this patch.

I can use the same commit id on the other had for this as well:
Fixes: c3ec8ac82105 ("ASoC: hdac_hda: fix memleak on module unload")

-- 
Péter

