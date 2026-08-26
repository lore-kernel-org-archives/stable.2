Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29C22B594;
	Wed, 26 Aug 2026 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751622; cv=none; b=KBWILxc5L4YLBeNd11vDXuTO8VlcfW9bfPIjOFiJfApgU0o48fkDJ0JifZBCxIYmNX5DT6Wq3NOctbA7GT+UL2xHl1s8cCGbO/JjuStV11wd+THSurl7acmHSO1FhEvfZ8tNEPJybwtsQ9G0nKE6kBXQ2t0uIWl7pfdBHnobpng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751622; c=relaxed/simple;
	bh=Fyp0nxIFNbe7zfR3Ow2mQCN57LdW8YlyAjLbvJz+CCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttmnxMhyy/2aTuKTGG2hLf8GJuf2v1W03dVpcE/GSKDJdVCUDDDHI/md3eJPGMsWBhkWt0PCnOMntuhWn0WrvPDNF4JtDuY3s7rykKC+sMxK1XtM+Xwret8TWaaufr48Ss/SbBBMXrG5PEJzfzHou5yY6+eeaBrLFZaI+Y+t5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VQmjg79/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VQmjg79/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787751620; x=1819287620;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Fyp0nxIFNbe7zfR3Ow2mQCN57LdW8YlyAjLbvJz+CCE=;
  b=VQmjg79//QHEnYeMi2wCnPHBQLLHhN549G9uMgSFEHQoAfYS3P9pSkym
   b8/MVszLPe2Cw3zwrZ5hjxRjlRzqBlAouVeBYC4vt6WHhDdVAdKiK8SX2
   eH4oyH81oXXp9HzCbytNCMeEyoREuLfvmnAPx/bYSv0B26TK5ckfrYG7/
   MRlarVis05f9nZkt2pXsdAhx1laqhpSqvNPmVRk3/Gnk8L4Zm82Y10dDc
   d8rl+fHgOBbToVCqS/J/3v2F/7DttZsDS45IntOJ4sSknRbl7M3/flZdV
   weWf3N9ahLQu5En3S/2s29wc769ZQnLzdSBh+/BNsiUhLnEyqTQwKIg9M
   g==;
X-CSE-ConnectionGUID: OHx+Q8L+TwmWTq7f5agPmg==
X-CSE-MsgGUID: vTeNLC/uQ9SEOcX1spkozQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88152217"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="88152217"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 06:40:20 -0700
X-CSE-ConnectionGUID: wmZm78pzQvK22Badz8sj1g==
X-CSE-MsgGUID: jd1MBS+bQSy9zvancwsbTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="264980330"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.245.238]) ([10.245.245.238])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 06:40:16 -0700
Message-ID: <d5a395f7-06ad-401a-b026-e975f620f017@linux.intel.com>
Date: Wed, 26 Aug 2026 16:40:14 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.12.36+: usb: hub: post-resume delayed work
 triggers > uncorrected MCE / data fabric sync flood on Threadripper 7970X >
 (bisected to aec11e5f9c45)
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
 Mathieu Fluhr <mathieu.fluhr@gmail.com>
Cc: Michal Pecio <michal.pecio@gmail.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, linux-usb@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 Forest <forestix@gaga.casa>, Slavik Dev <developer.slavik@gmail.com>
References: <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
 <CAPyJwA9R=p8_uxyYODb00g_nUq26SRsWHBGgAAJnR0YMTRRo4A@mail.gmail.com>
 <CAPyJwA9P48LDcOr7u_iT1WPFBCHxh9w6cxFvyi5GS3syM6crbQ@mail.gmail.com>
 <07435e6b-ee30-4c85-8c8b-0ce3a4ead1d9@leemhuis.info>
 <aosGtkE_diwVJJtB@eggarch> <20260823174059.46fec036.michal.pecio@gmail.com>
 <aoser8dLytrwqBC2@eggarch>
 <CAPyJwA8m_Xd2oyV1i9k+-6f7A-j0FiC97yXL=Ci8ZAErs5W4vA@mail.gmail.com>
 <ao1ovvdPAy6n_F7I@eggarch>
 <CAPyJwA-QALkCQn8J1+=U-nuE_7WSEPhVcUEKb+MMYMaA_1AVjQ@mail.gmail.com>
 <ao7aLXk9q_v_jEyX@eggarch>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <ao7aLXk9q_v_jEyX@eggarch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/26 15:35, Lovekesh Solanki wrote:
> On Tue, Aug 25, 2026 at 11:43:22PM +0200, Mathieu Fluhr wrote:
>> The patch you sent makes the issue go away. I am now running the exact same
>> scenario for 2 hours, without any crash.
> That's good, thanks for confirming.
> 
>> However, I am not sure if this can qualify for a proper fix, since I
>> do not have any
>> external hub connected to my motherboard: All my USB devices are directly
>> plugged into root hubs (and at the moment, there is only a keyboard and a
>> mouse).
> Yeah that's the point it only skips the 200ms hold for root hubs. The
> external hubs still get their fair hold since a parent exists for them.
> So external hubs are completely unaffected by this patch.
> 
> On 'proper fix', I think it is, even if we keep this bug seperate for a
> moment, it makes sense to not give root hubs hold they don't need.
> 
> I'd love to hear more thoughts on the patch.
> 

Roothub needs some time to settle as well, but 200ms might be excessive.

xHC can triggers wake (PME) when a connected USB3 device starts signalling wake,
but port registers changes are not always visible to driver before link training
between roothub and device is successful.

My educated guess is that 120ms should always be enough for the roothub.
This is also the lecagy msleep() still apparently left in xhci resume
to detect port changes in xhci runtime resume if there are USB3 devices.
That msleep was supposed to be removed now that we got the hub changes.

This 120ms can probably be further tuned for roothub in some cases,
especially if resume is due to userspace action instead of xHC wake signal (PME).

Mathieu, would it be possible to test different values for
USB_SS_PORT_U0_WAKE_TIME in hub.c? Especially 120ms is interesting.

See when system no longer crashes

Thanks
Mathias

