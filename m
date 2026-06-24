Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8847377ECA;
	Wed, 24 Jun 2026 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320765; cv=none; b=JAR8VfUxsAwSu9IIU23dVETmUAxQ4ZyVBwjbp8dArYdGvK3MvddUGrOSDmVllMkrWscHSHTsRauULGslpnCyqwzUka5JEGNBkHqWWqH9BoEr6XFLpCTE4/duLfcuwGAYqbPTotFd+d7LyXM8De5TXjlV7CmAd2x+PEY1gMDO8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320765; c=relaxed/simple;
	bh=YCDGEuINTLe++ujMs0MLsvBendFNcyERfYr932ENZlY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h1I6cm44QdM6ba71p99AOfKq/lgi32wx5O/DhIVg8WSQahsQDBVprY46YHxr5eX4YC4mkyqnsogWppw8szUvcS6fgRg08OsI/VZjwyzPCv/9GYABoMCipXoGPjLSuGdHab8nbbMzUF07pX1H118vJoEikuuJ1mtiuTOvkkXX8qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAbFzUeU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAbFzUeU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782320763; x=1813856763;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YCDGEuINTLe++ujMs0MLsvBendFNcyERfYr932ENZlY=;
  b=NAbFzUeUJY1E9YIY5LQvqx1LHGSF47mGBW7g+8N84azQbBf/QbcH6AYz
   FWjedB/oL8TOnekLZJKxbO45gGD1ESv9igr4cxw3jfC0Hw2TDeeQ+7kJi
   5VUr40syok9G7UCFJA+CjtIHAJJQ9Sz6tcMls6dw2f3wTEbmbysOCmPAz
   /bHNsUiyDzr+4Gbi2ZEzVHDp4xgIZfcQy5BVHCctOwJ7s0Qr1cFp2UJtQ
   ZvQBWVJZE4FcBtGLS2K0pA+lWwXot6DCVk3ezc3EvyR5zjnOukITP4TJ9
   MVQBt+wXyrkk4m5ikS56OSzoVRUUfZfwzQBfavRF5GqEJFB8Yuw6HIU9v
   g==;
X-CSE-ConnectionGUID: H6CTjG0KSK2ovFUoynmwEg==
X-CSE-MsgGUID: z0bREPv0TnikE0tdX+c8ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="70599477"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="70599477"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 10:04:57 -0700
X-CSE-ConnectionGUID: CGqLnAELQLinR1/MALmkCg==
X-CSE-MsgGUID: 53XqoACrRRKO7EfJ4Y9shw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="255030529"
Received: from zzombora-mobl1 ([10.245.244.173])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 10:04:54 -0700
Date: Wed, 24 Jun 2026 20:04:50 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
    =?ISO-8859-15?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@intel.com>, 
    =?ISO-8859-15?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>, 
    Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
    Jaroslav Kysela <perex@perex.cz>, 
    Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
    stable@vger.kernel.org, Uma Shankar <uma.shankar@intel.com>
Subject: Re: [PATCH] ALSA: hda/hdmi: disable KAE for Intel Panther Lake
In-Reply-To: <178196763509.3248.8656978100050911066@sms-medipool.de>
Message-ID: <b6e4caac-53f1-729f-51d2-aa0ca514ab04@linux.intel.com>
References: <f7d26e4d-8810-430a-b727-52c00d2d6edc@intel.com> <20260612181314.5577-1-alexander.kaplan@sms-medipool.de> <e5a56b3c-1fd7-35ad-f072-e490e2b471a9@linux.intel.com> <178196763509.3248.8656978100050911066@sms-medipool.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hello Alexander,

On Sat, 20 Jun 2026, Alexander Kaplan wrote:

> thanks for the quick test patch.
> 
> I ran it on Panther Lake with PTL kept at MODEL_ADLP so the KAE path is
> active.
[...]
>   # speaker-test -D hw:0,3 -c6   (silent)
>   hdmi_pin_setup_infoframe: pin NID=0xa channels=6 ca=0x0b
>   HDMI: KAE 0 cvt-NID=0x3
>   hdmi_pin_hbr_setup: NID=0xa, pinctl=0x40
>   i915_hsw_setup_stream: HDMI: multichannel stream, disable KAE
> 
>   # speaker-test -D hw:0,3 -c2   (stays silent)
>   hdmi_pin_setup_infoframe: pin NID=0xa channels=2 ca=0x00
>   HDMI: KAE 0 cvt-NID=0x3
>   hdmi_pin_hbr_setup: NID=0xa, pinctl=0x40
>   HDMI: KAE 1 cvt-NID=0x3
[...]
> So the wedge happens earlier in the sequence, as you suspected, not at
> the re-arm.
> The trigger looks like the multichannel DMA start itself once the KAE
> block has been active in the running power cycle, below the codec verb
> level.

thanks for the quick test. I'm working with our display folks to test
this out with some Synaptic DP-alt HDMI converter. This same test
worked ok with one converter (Lenovo USB-C to HDMI Adapter GX90K37871),
but I'll try to get someone to test with more converters. Given you see
this with multiple DP-HDMI converters, we should be able to hit this.

And a bit suspicious how this could work with the Lenovo adapter. I wonder 
if we have something else differing in the test setup. Given you cannot 
recover by unplugging and reconnecting the converter, it would seem the 
issue is on transmitter side and should be visible with all DP-alt 
receivers.

I filed a bug to Xe/display to track this effort:
https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8412

Br, Kai
