Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26D372ECF;
	Thu,  3 Sep 2026 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421828; cv=none; b=PWME1eNUUpa8I8/topmzIq7ryuYSOHNL4tI9u4DAobaGKwqiMS3w6VyZ8f2EoXBlH9qAR/FcjKWd51YRyjAs6iYPhmJzS/j2hOpMjpnKqgT8blmXSYBjvBkhOoyYiPeYwI7wAs3acEGUYK8G+cXFJ5sVZSNZgpzQ7RpjNi+cNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421828; c=relaxed/simple;
	bh=QZAgyHBhSczJehaHKbUlUFyH3QPXW+Jvg2/H/kXimrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMdlajwz0B+DPWHnMU7PHbOkWVva6jHHsKahj4C1Hf2wAUQwgRuBu4vvspBFhtjLSibRUU6SwenCR3VK9QqFqRYpChsAGDcSxLzgoL6LZRsEiaZWp/me0rf8x8HcXMNcIq/srj50rOBN04wOPVEtPwXCdSmXar/d0m9RSqY0WAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bht06juM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bht06juM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788421827; x=1819957827;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QZAgyHBhSczJehaHKbUlUFyH3QPXW+Jvg2/H/kXimrg=;
  b=Bht06juMRHgL7efHOnYbO0SAQQ3G41XlonCrJm8MSZfyw9L/sCnRiBE3
   y9XIZ2vp/e9BT5+JPYd/USSI0l0nvDaVxoyxYapR0topRcUc3EpXnHY+S
   o4NcFy1K+Urt4XivhiQs2Z8JnFj0doTTUeFIfJ39oeE2f53oI2SBL6yFE
   86XdKj/oada3V2y73XvWsEmI1VzwONdZmT3KRXnLhCdyHii62l+nNdC/r
   Y2mL9Ej0+nF6C6+1j+EoUbrJcBeooGhIg3yorHCUR2Rg/2BMeCRVmd/PG
   xINU3IviL3oisDvjwpqHXK9KpFxVy7fuHwAlvlkJrQoh2n/kYkXtfiEWL
   w==;
X-CSE-ConnectionGUID: vOwJAlbyS8+T43wgqFWFYw==
X-CSE-MsgGUID: xNAyye26TpKJKH4Y+BmEYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92763787"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92763787"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:50:26 -0700
X-CSE-ConnectionGUID: nax9wzBGTBmCSEOFdLCW7w==
X-CSE-MsgGUID: nNCQsY7TRSyGJzSTIAfYFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="273800272"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.90]) ([10.245.244.90])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 00:50:24 -0700
Message-ID: <7db85d54-8fda-4fbe-bbc4-f004ebbd5e1e@linux.intel.com>
Date: Thu, 3 Sep 2026 10:50:21 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 1/2] usb: hub: use shorter 120ms post resume hold for SS
 root hubs
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michal Pecio <michal.pecio@gmail.com>,
 Mathieu Fluhr <mathieu.fluhr@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <20260831190349.29590-1-lovekeshsolanki00@gmail.com>
 <9f8fae96-0865-4b0e-9650-00e92e324f9e@linux.intel.com>
 <aphpX-0WxWQOR4mQ@eggarch>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <aphpX-0WxWQOR4mQ@eggarch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/26 21:43, Lovekesh Solanki wrote:
> Thanks for the feedback,
> 
> On Wed, Sep 02, 2026 at 04:29:40PM +0300, Mathias Nyman wrote:
>> I'd highlight the fact that this patch mitigates the AMD platform issue.
>>
>> Maybe begin commit message with something like
>>
>> "Holding a USB3 hub PM runtime reference for 200ms at hub resume triggers a
>>   AMD platform issue. Users running Android adb report crashes after adb has
>>   been polling and waking up the USB subsystem once a second for some time.
>>   Vendors are working on a solution. Disabling USB runtime PM is one way to
>>   prevent this issue, but it is also proven that reducing the hold time to 120ms in
>>   resume also mitigates it. See Link for more details.
>>
>>   Reducing the hold time to 120ms for the USB3 roothub is in itself a valid change
>>   and optimization as the current 200ms is excessive...
>> "
> I will re work the commit message in v2 along those lines. But if the
> mention of the commit 8f5b7e2bec1c is removed, should I keep the Fixes
> tag or remove it as well?

Keep it.
It helps stable maintainers know how far back it makes sense to port this.

No need to remove the point about the commit message either.
It was just a suggestion to shuffle the content and highlight the real reason
why this patch is created.

> > I could change it to something like:
> 
> /*
>   * Give SS hubs 200ms time after wake to train downstream links before
>   * assuming no port activity and allowing hub to runtime suspend back.
>   * Root hubs have no upstream hub whose wake propagation needs to be
>   * accounted for, so they need less time, use 120ms for them.
>   */
> #define USB_SS_PORT_U0_WAKE_TIME	200  /* ms */
> #define USB_SS_RH_PORT_U0_WAKE_TIME	120  /* ms */
> 
> If everything else's fine, I'll send a v2 with these changes.

Looks good to me

Thanks
Mathias


