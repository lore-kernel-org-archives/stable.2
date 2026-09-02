Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C247F765;
	Wed,  2 Sep 2026 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351050; cv=none; b=tKeIN6XSB1TNTyXik2EX/1IS2noqblGF3u91N7gOTRcI7Fj+d+e3oPbWNDN+y3U20cDZQev2akwXHFiQRO5yay/ONykWAJu04dhrFIzeNattrRt/p6BVtZu9ikH81zcC6p2liExumgYjNmu0BBTjLbBIYmxxTK1ZhPWjgU6sKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351050; c=relaxed/simple;
	bh=Kr7MS00zL27KryVG9u/GBNLnFb/YTHSznV5JXBMOWP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rI+oZUynRxPfOSsGNoVzt8+n7B/2+Iifr7LdCExogx5b5gWueOtNR/FL3SJApptqUfWnsbOGKwdjP0ORmjou3cwkY+X1IixAwRomWQsY3JaDFnAnEFM3pVE1XK12TADdh56QSoxmCbjCJb1QNAnk7QilkESqaDU/s08pW8hDMho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ol0XJpAY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ol0XJpAY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788351048; x=1819887048;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Kr7MS00zL27KryVG9u/GBNLnFb/YTHSznV5JXBMOWP8=;
  b=Ol0XJpAYIejL6HdXg8OVk3nf5g7TiLC3R0U1Z09MmlmgK/sQwMN3BGh9
   KWwLauAqTNSGV8xEbj3t/D5mV2fwx1/yqDVW6vPJqvT3UKtCiibNi6HjJ
   a+uDnjgWnlwVdF2pGZdhAg9oQYesnn4TADOqAVNWEdAiBGJZEdVMXjx9i
   1UTfOVcgsz7tDs7K0TCpHWdcax/ZrfbbpRA5mQTyG6ZO0RcIEFVt/dY8x
   R7XVBssS0ffoVLTS3rlkHMR4KaHej8kw3+KDL+bkG9IuR55GbsZco78vg
   ruH5dn5VxPTMA0F1QYSfdEO0Y4Lsn4VCCBqJawjEYXpt/hQWKCB+WysPZ
   A==;
X-CSE-ConnectionGUID: TF3XXTCKThiZiiHp+f2QwA==
X-CSE-MsgGUID: dK0T1YQMS9mozO3u0fkYCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88852606"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="88852606"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 05:10:46 -0700
X-CSE-ConnectionGUID: 3/lnpXtdS4mzBMiRf4umow==
X-CSE-MsgGUID: zcQiUidaQzauIXnb12Kvow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="267634669"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO [10.245.245.167]) ([10.245.245.167])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 05:10:43 -0700
Message-ID: <1be8e57f-9abe-4b34-bc09-e7934a2fa1bc@linux.intel.com>
Date: Wed, 2 Sep 2026 15:10:41 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xhci: drop 120ms U3 LFPS wake retry wait from runtime
 resume
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michal Pecio <michal.pecio@gmail.com>,
 Mathieu Fluhr <mathieu.fluhr@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <20260831190349.29590-1-lovekeshsolanki00@gmail.com>
 <20260831190349.29590-2-lovekeshsolanki00@gmail.com>
 <a6a8526f-4b6f-46f7-9d02-05bfe3efcd48@linux.intel.com>
 <apbrp8EaJoIfEg5X@eggarch>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <apbrp8EaJoIfEg5X@eggarch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/1/26 18:50, Lovekesh Solanki wrote:
> On Tue, Sep 01, 2026 at 03:53:47PM +0300, Mathias Nyman wrote:
>> I looked into this again and remember now why we didn't remove the msleep(120)
>> earlier.
>>
>> If we want the hub driver to keep us awake to detect delayed port activity,
>> then we need to wake the (root) hub driver in xhci resume.
>>
>> That means always calling usb_hcd_resume_root_hub() in runtime resume cases where
>> resume is caused by usb device remote wake. (xHCI PME# in PCI case), even if there
>> isn't any port activity yet.
> Got it, thanks for the explanation.
> 
>> We don't currently check if runtime resume is caused by xHC PME# wake in the xhci-pci
>> driver. Not sure if there's a driver api for it.
>> Instead we in resume sleep for 120ms if there exists connected and suspended USB3
>> devices without port activity, and then check again.
>>
>> This msleep(120) is unnecessary if runtime resume was caused by userspace instead
>> of usb device initiated wake (seen as PME for PCI hosts)
> So the better implementation will cross into the PCI side, are there any
> plans to implement that? Or any interest in it at all that you know of?

It's possible PCI side or pm core already provides some easy way for xhci driver to check this.
This specific issue is currently not on my todo list, yet.

> 
>> Probably best to just take Patch 1/1 and look at this xhci resume part separately.
> Do I need to resend the 1/2 Patch independently now that this one is
> dropped? Or it'll be taken as is..? I'm still figuring the process out.

Maybe better to send it again, remember to include Greg k-h and Alan Stern

I have some minor, mostly personal taste based nitpicks that could be changed
in the patch. I'll reply with those comments directly to it.

Thanks

Mathias


