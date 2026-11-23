Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795394050;
	b=NCQO59CG4dgIQ4TXnpm0r8lb7wSNcbm7mlSQ6C4UIUTPkr2WgYoVRhXOWLjBOHIO/Bqj
	 4NZE2n+W5RzfKO+mCF7zgW+ft+HvaEqnavx0J0hc5eKXnoopOJRbsjttwS73/AME0ZTaL
	 PqPJpkx2lmBXrIb1/i8OJ0Tr5zKSP9VrsxLDZFk1oKsWkQMBZv54b8HLSk1SGGsT6JzT7
	 FYNLRnnO7Fg0pkcz7Xx5qY6Rk5JSPDgE3xY5wMoFxUf8r8zw1zxrGd5dBsp8pHqWzSL6l
	 ABcX6sw68NFTXXH2UPUJFtV44YSeRosM38dxl4fV411/KZV1hVz28By1gNnBUixXVYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394050;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9ZARRww83aYBINOJfyNSwgaV7V0AEF7p7ZuaSacjrq0=;
	b=xgj1yxtZWHgfbHrUHD8glME0DmJREoADrESUHOoGeugKW0VuWTbMpF5OiDE2iGL7pVz2
	 lSWHMl6P/zSSznZoSN5sXDxaUVj1Y4zr5KXSewhasK2EpyxczobUVNd54BtNsGvYmBPhp
	 QE4Ho+UNk8Eg2ch8TNzDPQ9U4U7riuqCPsSamHwYzGWvN8PnZfpAS54CP+pYM5V5e6OHc
	 CYkcktR69jFQ7bnpkyHOhbfm30k6TLhG92hS1b/OaC9iMKVc5ZNaOh8//x9mc25jqD86N
	 VQr/eN9hOqTMWBzBOydaa9lhdyC3fHJI/nhLvqnUoZhS/Xhe5mSNeS9NfKF801a05vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ndsFjmm6;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB65606A31D
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FB65606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ndsFjmm6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795394049; x=1826930049;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w/G5WFe1K+6xiCtCgpGOi5b4JMR+uWhUg/gfwb7h2Pg=;
  b=ndsFjmm69QdwqJabB+pnXvbfJEqSJE7B4e8L6qNj1rxkte7xPtbnQ+PM
   zFstNILR1h/sLekPCVN77FqfkQA+44a6e+9NdsuqCj3fTCYUF+IlVyC3x
   L6+qf+OoaH5oSL/ReC+S4SX0YhWMn2mYWNhZoSDHJkQqnMSG8+gcmYdzD
   YckDIHKfnMv0ppQfXCRhvtPwqmwgdtJp27xSnoS139oJ346numiTfFY+V
   U3QY83G0Z3/01O+okQFONRjbn5lLqQw95JmhrHeVjOFlYcVGLT+PwBHjJ
   AlAeT4Ml/AZxqRaqGLDbRYXms0CfUgmXTewQx9v0/zmFx5GB+d6lbPbhL
   g==;
X-CSE-ConnectionGUID: jbCk2yuaQkuWIipLQa+OOQ==
X-CSE-MsgGUID: gvXTaIucQMKOOkvP+/OkrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4186706"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4186706"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 16:34:09 -0800
X-CSE-ConnectionGUID: kI1NlR4EQCmTrOEs6Weukw==
X-CSE-MsgGUID: bjzCT/KSSB6MlrmfakjQ0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11256454"
Received: from unknown (HELO [10.238.0.68]) ([10.238.0.68])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 16:34:07 -0800
Message-ID: <3746e269-9de6-4b7d-a31d-d62219acc9b0@intel.com>
Date: Mon, 23 Nov 2026 08:34:04 +0800
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
Subject: Re: [PATCH 6.18 0942/1005] KVM: TDX: Enable Bus Lock VM exit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Sean Christopherson <seanjc@google.com>,
 stable@vger.kernel.org, patches@lists.linux.dev,
 Nikolay Borisov <nik.borisov@suse.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20261104211043.516122098@linuxfoundation.org>
 <20261104211109.504581890@linuxfoundation.org>
 <dac4e304-98e6-4e61-93f4-8d971069d936@intel.com>
 <2026110539-lived-blast-ef64@gregkh> <auyRq2HXJIfMXgBh@google.com>
 <20261106-re-kvm-tdx-bus-lock-drop@kernel.org>
 <6e48bcc5-8f7c-4e5a-9e34-1cab1c53dd92@intel.com>
 <2026112012-hardener-radish-1583@gregkh>
 <5f94f0aa-80ad-4aac-8b91-5e1aba36ca2c@intel.com>
 <2026112026-plank-heavily-4ef8@gregkh>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <2026112026-plank-heavily-4ef8@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/2026 11:31 PM, Greg Kroah-Hartman wrote:
> On Fri, Nov 20, 2026 at 07:43:32PM +0800, Xiaoyao Li wrote:
>> On 11/20/2026 2:38 PM, Greg Kroah-Hartman wrote:
>>> On Fri, Nov 20, 2026 at 02:23:41PM +0800, Xiaoyao Li wrote:
>>>> On 11/6/2026 9:19 PM, Sasha Levin wrote:
>>>>> On Thu, Nov 05, 2026, Sean Christopherson wrote:
>>>>>> Yes, please drop it.  Thanks!
>>>>>
>>>>> Dropped from the 6.18 queue only: 7.3 has the prerequisites.
>>>>
>>>> Can you pick this patch for 6.18 queue now? I check the linux-6.18.y, which now
>>>> has all the prerequisite patches now.
>>>
>>> What is "this patch"?
>>>
>>> You dropped the context...
>>
>> Exactly this one:
>> https://lore.kernel.org/all/20261104211109.504581890@linuxfoundation.org/
>>
> 
> Please just put the info in the email itself
> 
> {sigh}
> 
> Now, to make it even easier, just send the backported patch properly and
> we can queue it up that way.

Learned.

It's good that Sasha has already queued it:
https://lore.kernel.org/all/2026-11-20-1-daily-reply-0010@kernel.org/

I'll make you folks easier next time.
