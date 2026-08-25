Received: from mta1.migadu.com (out-93.mta1.migadu.com [95.215.58.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D3123643F
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787628871; cv=none; b=sPUyl80yfIg3wz+hxknPMF3/N/T+me+dSlTWnomZr8g+otHQVL4nxumh2bmvOnmlqFryXkc8SVvq5KGj33e3+3uVKecXFh4IuBASlljcIo4zh58ag/chi2sYx52zsJUwjKkfKgvWFvJcv3lx7hsHYbw/FFCGtfpAEvKnmYDjBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787628871; c=relaxed/simple;
	bh=eSABOAXqj4oWn6u8Az5xzjeD/NF4DiV3b5/D4qwM62U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eO+kK6CiXp7CB+t63pgigdKElH4lVv6weI1agVJD6uIMyh5syQhcrD7XJOks7WOKLgYBgthNKYcDCyHMMCnOiP3IbGWshcGvTMvY6DDUanP0pu/Kkn8QKebYpFDWMsTDL+BVhs3c1DBHrbXbze0Z3CI3rGTKho9sE2k7zVE7SPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TznODQW5; arc=none smtp.client-ip=95.215.58.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TznODQW5"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eSABOAXqj4oWn6u8Az5xzjeD/NF4DiV3b5/D4qwM62U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787628867; v=1; x=1788233667;
 b=TznODQW5kHJmpGMrdKjpKZB3hrjprTO3g7xnMRNfdBuPXjX99A5zbMTu+OUmy41hlN5sFqen
 HKa3QLfGg05/VlJkfIvTcQU3XAuEGqh2FVcImsX9z5feuGkWxP2668wzq4XtnWNOGRaun4LZ9mk
 CN8kN9ZiKw1lm8wNev36VO0k=
X-Envelope-To: stable@vger.kernel.org
Received: from [198.18.0.1] (116.128.244.171)
	by smtp.migadu.com with ESMTPS id 6881395ec596a024;
	Tue, 25 Aug 2026 03:34:17 +0000
X-Mizu-Trace-ID: 6881395ec596a024
X-Migadu-Flow: FLOW_OUT
Message-ID: <749d7a16-df31-4bcc-822b-3153fc69d072@linux.dev>
Date: Tue, 25 Aug 2026 11:34:04 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: phy: fix NULL deref in IRQ handler after
 unbind
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>, stable@vger.kernel.org
References: <20260824120703.107412-1-xuanqiang.luo@linux.dev>
 <e289a01b-d0a5-4296-b8b1-9b5935ee6854@lunn.ch>
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
In-Reply-To: <e289a01b-d0a5-4296-b8b1-9b5935ee6854@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrew,

在 2026/8/24 20:54, Andrew Lunn 写道:

>> The IRQ is requested at attach time and released by phy_disconnect(),
>> so phy_remove() cannot free it without a later double-free.
> So this sounds wrong.
>
> If you unbind the PHY, you need to also unbind the MAC, since a MAC
> without a PHY is useless. When the MAC unloads, it will call
> phy_remove() so everything unwinds in the correct order.
>
>      Andrew
>
> ---
> pw-bot: cr
> 	

I agree that the MAC should normally be unbound before the PHY.

Also, the paragraph about freeing the IRQ in phy_remove() was
misleading. It was not relevant to the change being proposed,
so I will drop it in v2.

Do you mean that unbinding the PHY first through sysfs is not a
supported operation?

The same sequence was used to reproduce the issue fixed by commit
c2b727df7caa ("net: phy: Avoid NPD upon phy_detach() when driver is
unbound"), which made me think that it should at least not crash:

https://lore.kernel.org/all/20200917034310.2360488-2-f.fainelli@gmail.com/

If this ordering is required, would the right fix be to enforce it
instead?

Thanks,
Xuanqiang

