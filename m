Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=145.239.82.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457241;
	b=EgPYMWpM7V30fbFJLBKYAkjvXEsUDaXg95HXDfmvSrZJAMX1L05gw+AJrk1TawnaVXm4
	 Ptb2xeKhy7vfSVoItdGtrsryfr9cN5RR2l6P4TTBRfcmYlif43nrf1M0bMllTjcvftw2d
	 su7Ic2DDV4mhh5V2nwtDKXne5cDtP/J93BAQj+cfAt0NE9MLaCeBNcUHd41b4t2G1ylvr
	 OG8CCe3+gHyH/C2VCXEjKlsdJZ85FwvB9nf1M7lY+eWMVlfuDqReMZWslVfhUu+cXGfKY
	 Q3gH9VPpX9Wd/rKb08XaZP6HMUSWqVKOf7XArK1HybYMvp7CFFng6VsJC289/oXplaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457241;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 Disposition-Notification-To:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Sender;
	bh=bp70Jh8sDMsjODuz8bbDpOzCbB8Sp/wdentCbU1pHRE=;
	b=yUobbpzHNQ2z3h4dB2Ka/bMHfwz2O/NGjZdhRp2k/IUdh2bVyKz7XttDKRzM0Zu/Vnvk
	 vLFF3ZaEFv+mAIqp5qkdZf5BIoBon4sxlJW6PFAd1j78XpNQMWvyln2/fi+pelF1Snju3
	 znPYvZ+7GrFD1K2z8lCukt/fE6rOm9FM2apwv071ON9Is3BircfFHoRhfTWe2PlbeVh9E
	 dSO9bWnd9n3h1kWNus7KPx7EZlyJG6l5xBLstzG8/rqa4dmR4tMNZ4ObxlOANJ4i98quo
	 zKc2hHRFFqqKCsWwtzHOLTKM2fpAH2BtGLVyErNx3IfNB9iYEPOBhvlFjYWehkIy0Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=maciej.szmigiero.name;
	spf=pass smtp.mailfrom=vps-ovh.mhejs.net;
	arc=none smtp.remote-ip=145.239.82.108
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41A4606A31E;
	Mon, 23 Nov 2026 18:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A41A4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1xVYRb-000000016hu-1kRu;
	Mon, 23 Nov 2026 19:07:11 +0100
Message-ID: <6d09e0b3-e718-4112-99fa-bbe1fd2aa97c@maciej.szmigiero.name>
Date: Mon, 23 Nov 2026 19:07:06 +0100
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
Subject: Re: [PATCH net v2 2/2] net: wwan: iosm: fix S3 resume by re-binding
 the driver around it
To: David Westen <davidlwesten@gmail.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, nihaal@cse.iitm.ac.in, stable@vger.kernel.org,
 netdev@vger.kernel.org
References: <20261119042714.505405-1-davidlwesten@gmail.com>
 <20261119042714.505405-2-davidlwesten@gmail.com>
 <5651d569-d291-48e1-b38d-8cbdb2c2f0a8@maciej.szmigiero.name>
 <e011f909-bc90-45b0-9065-e517ffcbcf2a@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Language: en-US, pl-PL
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <e011f909-bc90-45b0-9065-e517ffcbcf2a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: mhej@vps-ovh.mhejs.net

On 23.11.2026 04:17, David Westen wrote:
> Hi Maciej,
> 
> Thanks for the review!
> 
> On 11/22/26 12:01 PM, Maciej S. Szmigiero wrote:
>> On 19.11.2026 05:27, David Westen wrote:
>>> - Entering suspend-to-idle or standby explicitly while the default is
>>>     S3 also re-binds the driver.
>>
>> I think this re-binding should never happen on s2idle, even though S3
>> might be the default mem sleep method.
>>
>> It looks to me that the only remaining case here is the "opportunistic
>> sleep" code which does not use mem_sleep_current (so won't be covered by
>> pm_suspend_default_s2idle()) - but uses autosleep_state instead.
> 
> Agreed, that would be better. The problem is that the PM notifier
> isn't told the target state, and pm_suspend_target_state is only set
> after PM_SUSPEND_PREPARE, so the default was the closest the driver
> could get on its own.
> 
> Covering both cases would need the PM core to make the target state
> available before the notifiers run, like pm_suspend_notify_state in
> your earlier S3 patch. Do you think that's needed for this fix, or
> would it be acceptable as a follow-up?

I think if this would be considered a regression when this driver is used
with opportunistic sleep functionality then such case should be covered
already in the initial patch set.

However, looking deeper in this opportunistic sleep functionality it seems
that most major "generic" x86 distributions disable it and there's no
credible report of anyone using it on a generic x86 laptop.

So in this case I think it would be fine just documenting the limitations
of this fix both in the commit message and in the comment in pm_notify().

>>> - A suspend to S3 that calls pm_suspend(PM_SUSPEND_MEM) directly while
>>>     the default is suspend-to-idle is not covered and fails as before.
>>
>> Are there any such pm_suspend(PM_SUSPEND_MEM) calls in the kernel (outside
>> some test code)?
> I found a few: APM emulation, pseries, via-pmu, ZynqMP, SCMI power
> control and the SPI slave system control driver. None of them seem to
> be x86 ones.

I'm pretty sure we don't need to worry about these.

> David

Thanks,
Maciej

