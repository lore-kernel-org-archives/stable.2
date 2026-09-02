Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACA03793A2;
	Wed,  2 Sep 2026 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.171.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337365; cv=none; b=kVxNhSFqKKdCIbYJUWA4LS7LfBvqRVSxb6SOq9ADzJrVHJwTiZ622sLr6MOImwSCqW6JCtXmvIveluDiuE+KXdVdT1+SeQblvDwdZe3qYmz5CDEPh0CJfOVSDdKYfqiRi7j6old3A0TngS3nx19xkgxsurBx+iDuDiThVXcLu8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337365; c=relaxed/simple;
	bh=hioswMSn+AjQXC6h4CTqNz7ZVZz3AXK2HleSF5/4bxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGB8IuTHW584phvRVonZIoa24SdadPqBx+J6gaIhjhV+DyY7fGFDGIx4PHjWq0Kz1CNYv0VTgpUDimhX2tnRcg8L4iGLwekESahuaIv7/uU0E+3WbqhAtbiEg0PBGNGOg+AKdzcfcIGpb4RI7XT/xHfORgFCbE22u1/rLbCGNqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org; spf=pass smtp.mailfrom=datenfreihafen.org; dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b=AaNRseBQ; arc=none smtp.client-ip=78.47.171.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datenfreihafen.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=datenfreihafen.org header.i=@datenfreihafen.org header.b="AaNRseBQ"
Received: from [192.168.2.30] (unknown [46.253.254.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: stefan@datenfreihafen.org)
	by proxima.lasnet.de (Postfix) with ESMTPSA id 18780C01B4;
	Wed,  2 Sep 2026 10:22:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
	s=2021; t=1788337361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PYG50JCd+g+sfQ4pjUpRPP9jXBl0g/4zEJdEKNzdJxY=;
	b=AaNRseBQh6rhWD4LactBTwSHnFz0xy1P6ftWoq1gwz0RHaxiQC3gA1jYo5pGg6MWP8xQsh
	85edmU/bHDp6mQCBJauvD2fFz1ukoJupn/LVBh8LKR69+QKoXubvscZ0w3/UGay4oocbrY
	KLDVAxYP/kLJBTWsKh/p35O5dZRyL9vXkJCaJPz9CvF4ue7p49pKQIsklpvysKpRC67Fu+
	dGmKSzdGmuKnszvqyeuNghmiFv3GWY6YkUPfAGyQSsoKJg4e7zUtp7UECmat2ej4W7Pn8Y
	Rsz1p8sNLbuR8LMaQRa8l96qE7frqTyUeLVIKIRoNb99/0vDEDsNcxHj3MbomQ==
Message-ID: <cdc984d3-4ce4-4a57-bdd2-19f05d89e584@datenfreihafen.org>
Date: Wed, 2 Sep 2026 10:22:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ieee802154: hwsim: free PIB after unregistering
 hardware
To: Yousef Alhouseen <alhouseenyousef@gmail.com>, miquel.raynal@bootlin.com
Cc: alex.aring@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+4707bb8a43a42fca2b97@syzkaller.appspotmail.com
References: <20260627235805.17310-1-alhouseenyousef@gmail.com>
 <877bncnx25.fsf@bootlin.com>
 <CAMuQ4bWf+o_ZDMXn1tTw30veo-30Mt9XZehT8BPErJ30Kx_95A@mail.gmail.com>
 <87jyr8jgr8.fsf@bootlin.com>
 <CAMuQ4bWObh9FVFifH91UMcdugn6YD79T1wAqeJ2owBnzsMdnCA@mail.gmail.com>
Content-Language: en-US
From: Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <CAMuQ4bWObh9FVFifH91UMcdugn6YD79T1wAqeJ2owBnzsMdnCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Yousef,

On 7/18/26 14:20, Yousef Alhouseen wrote:
> Agreed. I'll use rcu_access_pointer() in v2; it expresses the final
> pointer fetch more directly once unregister has quiesced the updaters.

Did you send a v2? Did I miss it?

regards
Stefan Schmidt

> Thanks,
> Yousef
> 
> On Mon, 06 Jul 2026 17:10:35 +0200, Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
>> Hello Yousef,
>>
>> On 03/07/2026 at 04:19:42 -07, Yousef Alhouseen <alhouseenyousef@gmail.com> wrote:
>>
>>> Hello Miquel,
>>>
>>> After ieee802154_unregister_hw() returns, the driver callbacks that
>>> can replace phy->pib have been quiesced, and hwsim_del() has exclusive
>>> ownership of the final teardown. The pointer is no longer being
>>> fetched inside an RCU read-side critical section, so rcu_dereference()
>>> is not appropriate there.
>>
>> That's right.
>>
>>> rcu_dereference_protected(phy->pib, 1) expresses that there can no
>>> longer be a concurrent updater at that point; the protection condition
>>> is the completed unregister rather than a locally held lock. The value
>>> is only fetched so the final object can be passed to kfree_rcu().
>>
>> While I believe this is indeed true, it actually feels slightly overkill
>> since there is no updater anymore and, as far as I understand, the only
>> thing that we need here is to get the pointer value for freeing, right?
>>
>>> rcu_access_pointer() would also be sufficient for that limited use if
>>> you prefer it, and I can use that spelling in a v2.
>>
>> If you don't mind, I feel like rcu_access_pointer() is exactly what we
>> need here. It is also more understandable, even though I agree in
>> practice there are no differences in this case.
>>
>> Thanks,
>> Miquèl

