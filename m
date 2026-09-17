Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB13ACEE0;
	Thu, 17 Sep 2026 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632969; cv=none; b=LhG6gaF3vaUk58xoXcvzga3itBtRO9fTyRxBuOx4en9N608phEeh0jgpbGApbBSSR29eWDkDJiY3FBS5eSkmGSh2aiHKX6sb7C0Lf82z+e5d4S9R43lwjgdOgt6AucIHuJ10hyO73i4t+8HPglHK+0v9OqjcwaptAjb36PhE/b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632969; c=relaxed/simple;
	bh=4FaijACPNaf1LStXB+Jd5nhI2EVInJ6GpbGlED15Eeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P28YtSV0hEaYfWdK3SCeKzOgCEOUZlDuyGnRgfT1CeMSCc9ZA8ByRTXunloKyOdV4kh5thFjc3zL3lKpJQ71bxKtq9EKlVlZwf6PkQ48+T1HWZEbgG5qyVx7W4BJ0+qaJ8Ta6hRGLMptbmbUtMOWJmp0PceZxhE+TbMC3wKygZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TRXwdnP+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TRXwdnP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789632968; x=1821168968;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4FaijACPNaf1LStXB+Jd5nhI2EVInJ6GpbGlED15Eeg=;
  b=TRXwdnP+kebCs3TR1Vl1uutllCNDqI8qyIeWO3Ke3pg/hVUbDKma4jTz
   RS+vd4FoS1l1S3G6prbbuzsrPhRcO0mZuM6NbP3HPxluFxzNHAs8YZVjR
   +y/nweduI3hrXBaQTbNCH1Mxc6pIYxZGagN0G7kv5C7FUpPGoro0oMO/r
   XxZltARSc+Gg5kgeJAMpP+gVqL2I8ChYiKpgrJmyiZcZXpNMGLzwMXYX1
   IepARJQdODELmi1ryrnnIKT39Vjjn9RizcpKJzGFIllV24Oz0lBLdwDQQ
   zm8Q/3av2jHT1mUPK0PJ/GlkeZOR9chdZGkYGFKL5kBMiq+K8fo8sMXsV
   w==;
X-CSE-ConnectionGUID: EFq6BF7fTK2dMHwzv27iuQ==
X-CSE-MsgGUID: gM2W2Gc6QE6VjNbv6vrSxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88965976"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="88965976"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 01:16:07 -0700
X-CSE-ConnectionGUID: RVnitAmrTU6O27nPqhhEJg==
X-CSE-MsgGUID: 7rjVyvR6TCe04ofVW0WnKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297139970"
Received: from abityuts-desk1.ger.corp.intel.com (HELO [10.245.245.47]) ([10.245.245.47])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 01:16:05 -0700
Message-ID: <b80ab121-2409-4ea3-9649-3aea4d1e7507@linux.intel.com>
Date: Thu, 17 Sep 2026 11:16:03 +0300
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
 <1be8e57f-9abe-4b34-bc09-e7934a2fa1bc@linux.intel.com>
 <apg16LtZ-ru9MIBQ@eggarch>
 <082467bf-d045-45d7-b097-97a5790e79d6@linux.intel.com>
 <apq4FFSD2QKG-jUu@eggarch> <aqrK5PwpJodCmbdM@eggarch>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <aqrK5PwpJodCmbdM@eggarch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 20:47, Lovekesh Solanki wrote:
> On Fri, Sep 04, 2026 at 06:43:43PM +0530, Lovekesh Solanki wrote:
>> On Thu, Sep 03, 2026 at 10:42:48AM +0300, Mathias Nyman wrote:
>>> On 9/2/26 21:21, Lovekesh Solanki wrote:
>>>> On Wed, Sep 02, 2026 at 03:10:41PM +0300, Mathias Nyman wrote:
>>>>> It's possible PCI side or pm core already provides some easy way for xhci driver to check this.
>>>>> This specific issue is currently not on my todo list, yet.
>>>> Alright, would you like to me to work on this? I could look into
>>>> that side and possibly come up with an approach.
>>>
>>> Yes, please, that would be great.
>> I took a look at the PCI / PM side, and it seems to me there isn't any
>> reliable approach for xhci driver to use right now.
>>
>> The pci_check_pme_status() both checks and clears the pme status bit
>> and the pci core devours it inside pci_pme_wakeup(), and
>> pm_request_resume is async so xhci's runtime_resume may run much later
>> after the bit is already gone. We can't simply export pci_check_pme_status()
>> that wouldn't give any useful info.
>>
>> One solution I can think of would be adding a pme_wake_detected bitfield
>> on pci_dev struct, we set it in pci_pme_wakeup() when PME is confirmed
>> and we clear it in pci_pm_runtime_resume() after the driver has
>> returned.
>> Then, we could directly read via pdev->pme_wake_detected in its own
>> resume.
>>
>> What are your thoughts on this?
> 
> Hey Mathias,
> 
> Just wondering if you have looked into the proposal above.
> I suggested adding a new field to pci_dev struct for knowing whether a
> resume came from PCI PME side.
> 
> Would it be better to send it as an RFC too?

I don't think there is a need for a new PCI bus specific implementation.
pm core then probably handles this already in a generic way.

PCI core probably calls pm core on a PME, which then starts the wakeup,
pm core very likely keeps track of which device triggered the wakeup

The wakeup_source structure under power in the device structure (dev->power.wakeup)
looks promising.
Maybe we can find what we need from there. Hope its fields aren't cleared at the
time xhci resume is called.

Thanks
Mathias

