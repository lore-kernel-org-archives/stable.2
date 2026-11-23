Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=145.239.82.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457255;
	b=qPk750NkXnQWp5bmr5ebveecqYWUTb5LoUtCYhyFWbs7PmZ2OrHc93TNVVZWkx4f076e
	 +6UsP+5ZPWMlHVSR1xGPrYF0oXiz0XpESItw9gXQy9peIBlUbn8km0BDZq7wEmoWyhseH
	 5GSK9h3zf3XoLhEKcTZtSz8++YL9klwNzhnvCmixFWheSib5rytcGRpZVP7AY33U5w6e+
	 BKGfAPqfMlrFlf4R51ASDeoc8Oe4Wpy7Bw5N7fMk+yQBSRuGLRm+7mOd3lOZARL8f0ebK
	 TBLz+3oVNPmZbY1dIkFRWz01Ps+DWGy6t7fevMUXRwB8NvFNnrWHOehptWyZ49fpf1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457255;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:
	 Disposition-Notification-To:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Sender;
	bh=6b5/gSRFYVQxbGpZr4BwafOmkvBNL0mPfWWVRMwohUI=;
	b=AIAEj1yTM+z0tMhOYCawaNMxpbfAmKRpxxcl21hHAG/pBNCGS/AzrmqFkHtffNMdply8
	 /yj3iXmPLVKTF1BowX7+bX5ca61G4b6dSQ3/G38GSoRIsp9oRI6IaEsT5suOsr6Y52ZhY
	 2BBk4VL5NfVg2pndN4Zb70f+hyKExantaw0Qb5Tkb9F16ViDkWrPLZuniPLot5zQ53RbZ
	 lHPiT+YA5GaRQkkXO68Dihq39tnK3El6loxTw54f6gTeYpIl+JRfw/3WM33jWIcT7GiaD
	 9BN7vFztF4R6Pz3SM8kJGAVYXI2V8ZFNfV5Ydc/IzsAYFaFFUksasSxc4ye8z5BEFUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=maciej.szmigiero.name;
	spf=pass smtp.mailfrom=vps-ovh.mhejs.net;
	arc=none smtp.remote-ip=145.239.82.108
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE10606A31E;
	Mon, 23 Nov 2026 18:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FE10606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100.1)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1xVYRw-000000016i8-1Pqr;
	Mon, 23 Nov 2026 19:07:32 +0100
Message-ID: <aca74a0e-2672-4b93-b94a-e80b8fee5c9b@maciej.szmigiero.name>
Date: Mon, 23 Nov 2026 19:07:27 +0100
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
Subject: Re: [PATCH net] net: wwan: iosm: always send the host sleep message
 on suspend
To: David Westen <davidlwesten@gmail.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 netdev@vger.kernel.org, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, m.chetan.kumar@linux.intel.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261122050039.861287-1-davidlwesten@gmail.com>
 <925a4f3f-95bb-496e-be19-abf96af34d89@maciej.szmigiero.name>
 <813dc217-9753-4f9a-bf1d-1d8878dc9012@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Language: en-US, pl-PL
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
In-Reply-To: <813dc217-9753-4f9a-bf1d-1d8878dc9012@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: mhej@vps-ovh.mhejs.net

On 23.11.2026 04:05, David Westen wrote:
> Hi Maciej,
> 
> Thanks for taking a look!
> 
> On 11/22/26 12:01 PM, Maciej S. Szmigiero wrote:
>> On 22.11.2026 06:00, David Westen wrote:
>>> This ignores the BIOS RTD3 setting for system suspend. The setting
>>> only selects the sleep protocol; the PCI core chooses the power state
>>> without it, and here chooses D3hot, which the doorbell protocol
>>> doesn't survive. Honoring D0L12 literally would mean keeping the
>>> device in D0, as commit f4dd5174e273 ("net: wwan: iosm: Keep device
>>> at D0 for s2idle case") did. That was reverted, D3 being the expected
>>> state.
>>
>> I have mixed feelings about this.
>>
>> Your platform specifies D0L1.2 as the target state so I presume that
>> is the state that the platform expects the modem to be put into?
> 
> It turns out it doesn't specify anything: the WWAN _DSM function 3
> returns no result here (BIOS 1.56 and the latest 1.68), so D0L12 is
> only the driver's default.

The driver code does only care for value 3, any other value or absence
of value is taken as D0.

Unfortunately, it's not known whether Lenovo intended this empty return
value to be implemented as D0 or they just neglected to put a value there.

>> The reverted commit f4dd5174e273 on the other hand always put the modem
>> into D0, which was incorrect in a different way - as, for example, my
>> platform explicitly requests D3.
> 
> Agreed. How does yours request it, through the _DSM returning 3?

Yes, the method explicitly returns 3 for that "WWAN" GUID on my (HP) platform.

>> Could you try the reverted commit to see if D0 actually works for your
>> platform?
> 
> I tried f4dd5174e273 on 7.2.15. With it, the modem is no longer put
> into D3hot, but it still crashes during suspend-to-idle: when the
> resume callback runs, the modem already reports CD_READY, the same as
> without the commit. So it seems it's the FORCE_SLEEP doorbell that the
> modem doesn't survive, whether it stays in D0 or goes to D3hot.

So I guess this test settles it - at least for your platform.

I would cautiously proceed with unconditionally using D3 (as this patch
does), however would be ready to revert it and use a DMI-based override
list instead if it turns out that there are platforms that actually
require D0.

> David

Thanks,
Maciej

