Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9E53F12E2;
	Mon, 24 Aug 2026 12:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575817; cv=none; b=IgjV9XuMWDYqFxRbxpZuDTJCgRtgXRMZoZ1ENWmiy3ScDjtuALkSedDWnWvHzc8W1ZFITIHneULrwa+Pl4LxhDAC1GVIgIUSdOAYxukb1mUyIGNxXLmieqBuqOqazIXomaPuXXrDMUtURHnybZg5WOMwrJPm0KujPFHjweQC14E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575817; c=relaxed/simple;
	bh=8dyoGwYqE0+oRO6D3D9z7RssrqIoCJbmCBSreTo1NAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2CK4X2OwGWi7/xcWlrtVbdxrDKvqsC6GAf8JwHkAIGsuRwBgzLPvyoAgtU4c2N6542YxTj8S5E0Wm2OUszufoFIPmWZF99UUjrgyg18u519CNz6zbMzYEXawlvw3O3LdAiIzPWS+w4/A+q309aiWq4hr0uZ9L0qrI/JB1RTIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdMhbhYF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdMhbhYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0C01F00A3D;
	Mon, 24 Aug 2026 12:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787575816;
	bh=MZoj6aqj5U4tkAqvvKrf5s16sOmkfsLcKydVscu9oUo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HdMhbhYFiAxTvLaBruA4+2xYgwpDB1+h9q8noenekDfsbZPf5jQzN8J7IysEsmfaE
	 WGLUjWdT1LBt2ZlpG5eUILxsQBtaRgaN1FByMQjjJX2pNc1Q1d8++g3AX5UUPqW7Hk
	 jIRH8ShhSK0bCI/ZlUZc1IxlPUESt1FM43GTahz4g2UlKmmdqRsQMQuk8OYW4AqDzj
	 cdL583jH7G2XgSKqaWcgY57OPTf4lLubqVLt7PuY3CF1Anqjdw3prQkIPeHgyJnLI9
	 kcZALF6GJ5nZXYlOHL/QPhiYle6dVXbbh5ywq0YgbC3Rcxo+b7b5GrmLObCZQMoJ5g
	 GUuiwlj51hWXQ==
Message-ID: <ad7fba18-57d0-4f04-9c31-7ada3daf2d41@kernel.org>
Date: Mon, 24 Aug 2026 14:50:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] thunderbolt: Hold a router reference for each path
 hop
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Konrad Dybcio <konradybcio@kernel.org>,
 asahi@lists.linux.dev, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260823-b4-tbt-fixes-v2-0-26a18a426c9f@kernel.org>
 <20260823-b4-tbt-fixes-v2-1-26a18a426c9f@kernel.org>
 <20260824104237.GF893316@black.igk.intel.com>
 <295cce78-47d2-4a6e-af90-696edb60a05d@kernel.org>
 <20260824113759.GH893316@black.igk.intel.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260824113759.GH893316@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/24/26 13:37, Mika Westerberg wrote:
> Hi,
>
> On Mon, Aug 24, 2026 at 01:06:12PM +0200, Sven Peter wrote:
>> So unfortunately the entire USB hardware is best described as horribly
>> broken :(
> :-(
>
>> For USB2 already we only ever receive a single hotplug interrupt in dwc3. If
>> the first device is unplugged and another one plugged in nothing happens.
>> The only way around that is to tear down dwc3/xhci and the PHY completely,
>> assert all external reset lines and then bring them up again.
>> Upstream drivers/usb/dwc3/dwc3-apple.c contains more details in the very
>> first comment at the top.
>>
>> With USB4 this gets a bit worse: There's a block called "ACIO" (Apple
>> Converged I/O) which can only be brought up correctly after the PHY has been
>> switched to Thunderbolt/USB4 mode. This block has a co-processor which then
>> exposes the host router, NHI, IOMMU, etc. to our address space.
>> We then have to write cable information into a vendor-specific capabilities
>> register and only then do we get the hotplug event and the link comes up.
>> This register appears to be effectively write-once after each boot of the
>> co-processor. If I try to write 0 that still works but trying to write the
>> value for the next connection then crashes the co-processor with a very
>> helpful message along the lines of "assert 4357 violated".
>> So there's no way around first tearing everything down, then shutting down
>> the co-processor and the entire ACIO block and then finally bringing it all
>> up again after the next cable is connected. I've tried to find ways around
>> this but didn't succeed without documentation and could only reproduce what
>> XNU does.
> Thanks for sharing the interesting details! I totally understand the pain
> of reverse engineering things. The initial USB4/TB driver was also result
> of a huge reverse engineering effort by Andreas Noever, but it was and
> still is functional, and we still support Apple TB1/2 hardware (although
> not too much testing is done these days, I fire up my Cactus Ridge based
> Mac maybe once a year).

Hah, nice! I wasn't aware the initial version of this driver was built 
for Apple hardware!
Let's see if we can the Apple Silicon changes into a shape where they 
still work 10+ years from now as well :-)


Sven

