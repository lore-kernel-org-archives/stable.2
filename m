Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D143B28D;
	Tue, 30 Jun 2026 22:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859564; cv=none; b=MDQKH4uK2a+/8vOiDuZozXlwuYp6jHIOgVlMchSAW6h8yBXXo2EP3bfJFC662Yw5SX5P9yiKWCb4xFkdC7dNH7+l13TA3YvJ6lAylBssWCyU3xvD/ZOOox+9JSq2fVXqQQxpaVd6ZN96bbnUunY0roKJoH/t8NS0GXUOnV7Mfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859564; c=relaxed/simple;
	bh=jAFuBAT9xXbB1xeE/uSftQUaSLmCxG/VY/pSUxPNaGM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fl3zIcHgBE+IDYZ7Vg/aa21tmb/lxhD0g2C2MFptB7FC9MwApAHzOpmSXEYGm6IobRqPwi3U+oOI0WVd0lqEVb936amVTNpjCdu1DDmaVcY/M/h9XSrTpRXDRTbxx4lmew6LEbMnQRTc5GsaVMxVrUEEFao7ylzo2idYfyQ7uRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ym4+Py18; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ym4+Py18"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782859563; x=1814395563;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jAFuBAT9xXbB1xeE/uSftQUaSLmCxG/VY/pSUxPNaGM=;
  b=Ym4+Py18p9znkF5H1NzY1p1dFh5LOfSbhwJE0Eg8//Wni6JNFUbI5ZIO
   foqsKCaGnR0gQp7101oJZPKrFEfrgoj08OxkeMA6v9YZUZAYD9m1/zc0K
   bsqP88rclVxCdV06R1iOAx4Dl+vPCkXWlXQgTLiGzJyfGnYVapbrvalQx
   TLUbj13dXNCUV8wchiF0WT7+BCvUbnqDMSIFP0RzNBpBYfed28nmPt9pA
   adwK5ybEqbDNXSCKFvr+tK2fxzx6O5E1YF4CeNx3PNs/oPPz8iqhxG8q1
   JuZOXZLXpk1e7f5qdtib7hsxxqbK400PR9rZBZKu0+54WASDEzrwvXQ/W
   w==;
X-CSE-ConnectionGUID: Dh5wQJGPSjG+dpStU992dQ==
X-CSE-MsgGUID: TvQmS2mSQ7S4yBb/jvbagA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="83641605"
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="83641605"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 15:46:02 -0700
X-CSE-ConnectionGUID: 9P+qy8IPT9qhnGNq1S3EnQ==
X-CSE-MsgGUID: uxI62YlzTAWutGO00C4pqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,234,1774335600"; 
   d="scan'208";a="251966044"
Received: from hrotuna-mobl2.ger.corp.intel.com ([10.245.245.166])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 15:45:59 -0700
Date: Wed, 1 Jul 2026 01:45:45 +0300 (EEST)
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
In-Reply-To: <b6e4caac-53f1-729f-51d2-aa0ca514ab04@linux.intel.com>
Message-ID: <765b713e-d2a0-6859-2923-53f8e60cb00e@linux.intel.com>
References: <f7d26e4d-8810-430a-b727-52c00d2d6edc@intel.com> <20260612181314.5577-1-alexander.kaplan@sms-medipool.de> <e5a56b3c-1fd7-35ad-f072-e490e2b471a9@linux.intel.com> <178196763509.3248.8656978100050911066@sms-medipool.de>
 <b6e4caac-53f1-729f-51d2-aa0ca514ab04@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Wed, 24 Jun 2026, Kai Vehmanen wrote:

> On Sat, 20 Jun 2026, Alexander Kaplan wrote:
> 
[...]
> > So the wedge happens earlier in the sequence, as you suspected, not at
> > the re-arm.
> > The trigger looks like the multichannel DMA start itself once the KAE
> > block has been active in the running power cycle, below the codec verb
> > level.
> 
> thanks for the quick test. I'm working with our display folks to test
> this out with some Synaptic DP-alt HDMI converter. This same test
> worked ok with one converter (Lenovo USB-C to HDMI Adapter GX90K37871),
[...]
> I filed a bug to Xe/display to track this effort:
> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8412

some progress with this. I attached a work-in-progress patch that fixes 
the issue with at least one setup using Club3D CAC-2505 DP-alt HDMI 
converter to the bug at:
https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8412#note_3543741

Needs more work still, but if this approach works, I'll send a proper 
patch later to the list.

Br, Kai
