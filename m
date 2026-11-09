Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228488;
	b=NpXAOUvJ05Fs+SExk/HKSOVd/rUPYO0S+F9F5xaDYwCEf6dxMUiKbb2vOVp5FES8+K+R
	 gedcqiGVplG50M3u0nQa81oY4CsdB8yYoiCkLvhuT3Rw71OtRRbgVPakJ/+HaQmtS2Kjg
	 bd+0QD4WSM//Frv34q+Ea7vb3r9WbDCpKnBEp9Wx3DRTOyNGwTVfySW76Q4At7NqwqrrZ
	 ASOTuLv2JmTiCbOYi1KZ7/4IOwbS6Cv+wMCzao3U6Rer1Txn+fgQTXkzLanTiji93CJlU
	 C1hcKSDK03idSW4syD0LceyYA6O/1YgZhdI5vKmwwxddR6MaYW4WaKnhPFrzVUmbyoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228488;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1X9s5IVbMUai+Vm6HPMBjGkej0DDcgknG4OycOL8pUw=;
	b=tq7qygiEGBT3w/yQD9ATgXi8uRUy6Tffa8ADUaBZbupWE28nLkgcskDAZevS7s87nQFT
	 yfP3EvJDBQEk9u6FOHQg93H5f+vJh6DHV0BNGCueKKQYzL0wjm0x5uxzevfadW0CZV6+4
	 hzxetopwE+yT5104wJXk0/BqJLRHBdUaPWS+bi38QaX+ogJRmqe5PeenCr8yJjuNkidh5
	 r+dpA15mrW0VhM8vps+GC0N3rE3zcB+8watlGGOkOqqt7/F+hU92quNAsFG6p2geL6vzx
	 Nw1GUZfiFg4BkuysX+tgXjAA1m54CP7SFvmfByO56IO1kbEuDObQJhDT4rMoK4tCwQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtOrCjKW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90995606D801
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtOrCjKW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68A81F008A3;
	Mon,  9 Nov 2026 12:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228488;
	bh=1X9s5IVbMUai+Vm6HPMBjGkej0DDcgknG4OycOL8pUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JtOrCjKWYALGyur1/jNlt2Xj6Rmz1LfH815Wvu29Dn7eKSZg0H/PQIlYo8PUYESac
	 A1T8poP2LU0ju6HggHKjDMQA45ke7eKfnA+tID0/a9lje+EphToS/hKUWFjIX+2HAP
	 DsDZgBNawcyKHY9yBpROqyN4of8SzEQ/Y67mpQIfjo+2iV8SBa0ZfIals0mFPAJ0wU
	 c74CbeHB7ET9ZdldVAjtaP2ChDADwNXxh0KUt6FH4LLIq7udVe5hwKBJMQ87VuzKlN
	 MRkdFot5mG6Itp3T97dsSSaAA+ytfSmUYeGeSpuWRu9Ked2msuE6UFDdR5Ib+uJh1w
	 JSpRCh1DXp2WQ==
Date: Mon, 9 Nov 2026 07:48:06 -0500
From: Sasha Levin <sashal@kernel.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Abdifatah Suruur <suruurism@gmail.com>, stable@vger.kernel.org,
	Florian Westphal <fw@strlen.de>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.12.y 1/2] Revert "netfilter: nft_byteorder: remove
 multi-register support"
Message-ID: <avHBBj7mqIlk4vdm@laps>
References: <179422696909.5131.4005481731765358036@gmail.com>
 <179422697447.5131.3947908931395034167@gmail.com>
 <avG7oLUJ39PZCken@chamomile>
 <avG95PtnRweYD0KJ@chamomile>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <avG95PtnRweYD0KJ@chamomile>

On Mon, Nov 09, 2026 at 01:34:44PM +0100, Pablo Neira Ayuso wrote:
>On Mon, Nov 09, 2026 at 01:25:08PM +0100, Pablo Neira Ayuso wrote:
>> Hi,
>>
>> On Mon, Nov 09, 2026 at 03:22:54PM +0300, Abdifatah Suruur wrote:
>> > This reverts commit 3c5fb3a6c8118d15e60295e76fb5b879021eef43.
>> >
>> > The upstream change removes multi-register byteorder support and is
>> > tagged stable+noautosel because nftables versions before 1.1.0 can
>> > generate length/size combinations that the removal rejects.  Backporting
>> > it to stable can make existing rulesets fail to load.
>>
>> Yes, so why are you posting this as is?
>
>Apologies, I got this all wrong.
>
>I thought you wanted to pull in "netfilter: nft_byteorder: remove
> multi-register support" but this already slipped through -stable?

We were asked[1] to backport it.


[1] https://lore.kernel.org/all/ataIP3xm8DDtO82v@strlen.de/

-- 
Thanks,
Sasha
