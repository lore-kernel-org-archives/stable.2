Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFCB309F08;
	Fri, 21 Aug 2026 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345534; cv=none; b=nHxua+eYUX0JhpJvHgwtCmrCPrzgbr5tkLDu6aN70esCEKO1kPQm115nqN44wWXaEQ0CQeRbu1gIjKoYPghBaxA9ufxuyj6kVHDB7lOazrisq96PBe/sesBrJtiaUt7GKeuhvLpLwDs5UDUsRGhheUlQuGQtvRW8WGMz1sfI1t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345534; c=relaxed/simple;
	bh=iOqH32fLIga+ET+v5Yf6kVIvtpvzNvuXR4wOCzzgIC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYJng5kzrCcBMTmKJn0m9u3yGUeIaEHf1PBm8QlXc2yOR1iDNVIWDNMemFCXBLObiFLBNBk1eaNcXpFDdWvjJ2bFqvXXjW1TeZSkhXvXB6fqTEcgEi/ywQ3PGtx6HflQ5SQkeaPxbH3NeSZyYrkfE2QM2ElqL4SC4DxCWMXfa9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0LxTIuM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0LxTIuM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440D11F000E9;
	Fri, 21 Aug 2026 20:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787345532;
	bh=DuzWbq6Hw4BKCs0wVHsd3ZxMem9mh0J6/r8iLMFHiq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K0LxTIuMP2pyhKld6xjot+7cNM0+qB/e75rlq11hwDIQFuhDQvRC97CaxXHT6Z1lu
	 Ifz+ua9KgqjZkjB8TIWr7lnmKrThVYrs1Y7ZwrcUvGf/UykcYxCb2fx+nN5Om7AQek
	 ZCfU3lnw9ylsqVQEw3UhO2cBBKvMHk3mJMa6WENplSV2P69sXIzE4fAVEF9ur6wCJM
	 yZRsX8mWlkoLeT/U6FMgrZJMZjwYeV2tI3upQR9YEHHtFyq7ZxOTv2t7OYMx4swL5Z
	 HQjLJGfcrrgSSY6IiNhEPcQ3wnOjRNr6b9LtautwcIDguASlJgVvpKiydJX7f6qga+
	 rB482PFt4cxqA==
Message-ID: <95146b5a-80d2-4e91-855d-6577f2f31f0e@kernel.org>
Date: Fri, 21 Aug 2026 15:52:10 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: pci-quirks: always assert xHCI OS ownership
Content-Language: en-US
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Rishabh Jain <rishabh.jain1198@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260815014534.77850-1-rishabh.jain1198@gmail.com>
 <69fdc442-a4f2-42e0-80f6-6b35cbc207bf@kernel.org>
 <20260816220306.64c615f2.michal.pecio@gmail.com>
 <2d13e2ae-f5da-4951-bbe4-be7bb0b296cf@kernel.org>
 <20260819001511.45b3621b.michal.pecio@gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260819001511.45b3621b.michal.pecio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/26 17:15, Michal Pecio wrote:
> On Sun, 16 Aug 2026 16:00:47 -0500, Mario Limonciello wrote:
>> On 8/16/26 15:03, Michal Pecio wrote:
>>> Not sure if this has anything to do with PROM21, or if some BIOS
>>> is just trying to use the xHC at resume because it's permitted to.
>>> Then it makes too many changes for Restore State to still work.
>>>
>>> Potentially, such bugs may have happened and been left unsolved or
>>> "solved" with RESET_ON_RESUME quirks and other hacks.
>>
>> What do you think about making this a series with each of those
>> quirks dropped one-by-one?  The head patch (a variation of this one)
>> could go to stable and the rest of the commits dropping those can go
>> to linux-next.
> 
> Hard to tell. All we have is a wild theory. I couldn't even test what
> happens when the BIOS claims an unclaimed xHC during resume from S3,
> because my BIOS doesn't do that even when I clear the "OS owned" bit
> before suspending.
> 
> Those quirks may be wrong in the sense that they weren't specific to
> the particular PCI IDs, but to some particular buggy BIOSes or kernels
> in the past. Maybe those problems don't exist, maybe they still do.
> 
> I have completely disabled RESET_ON_RESUME on my test system with no
> apparent ill efects so far.
> 
> OTOH, I tried disabling the "broken streams (UAS)" quirk on ASM1042.
> While the kernel crash which those chips used to cause has been fixed
> long ago, it turns out they just don't work correctly (Set TR Deq is
> a No-Op with streams). So I'm not rushing to remove this quirk.
> 
> Regards,
> Michal

So maybe we try with dropping RESET_ON_RESUME quirks only in this go around.
