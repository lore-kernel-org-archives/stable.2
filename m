Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEDE3AAF76;
	Sun,  4 Oct 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791122811; cv=none; b=HiWpu+NT+9hPAItSi7Zx6hgrqnRpNE8SMsy5s7r4GoHMoc3pgmjzei873rGwK7Tw8LFsq79XiYPzzLPlEhaiDRrPL1mci8bnre8iKEk0GQ1PU1CmM1XyBAajU6nHTiJ2usg+GN4oIc2XMaQZbUKVduRrcer0ZR0Vs7+0iDT4F+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791122811; c=relaxed/simple;
	bh=6TQU99ZxPLl25Z5d8u7Lw2UQbiSmpsjiuw/9CUgNGVA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rHffX2BIzzGw1YcAfM4CXCFGfgoYRh6D0XjCokT13cvzYciT0XbQf64W/cfIpzQ5AC5qnWbZRKw9KQVSd6N5/jMHQ3Mnrh1+Y/tCsU/FJ80xw2zACjFn05k7dqlxsCgLKNrAhXeKAuooa6HVOC6QmGEQGgns6JamKd+wX3gyHPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=4CrKI84a; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="4CrKI84a"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6EF9BA4AAA;
	Sun,  4 Oct 2026 16:06:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791122797; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=V6NodY8DyUMIuCa57++t9sOldBOCncTm1xIwkM0+LBM=;
	b=4CrKI84aynEGEmycx52axRHFafVllW2P96SkEDtbvSvoWeqLPtqvnkoyvJ+ikurwwhUSlj
	FwVnldO1OGM2cEiOSnkvjou77BDvKBgonYZY7BT6QEItX8PdwVDXJ0M5bn/1BJDXd/Sa1p
	N+oE8gKqZ7cEaUxwSeXWFGNPdaHbbCmzhhUKaSO7RMphIIlurmrvIb1d/4inmM1JYwq8WH
	/sv7jSg/s0l2Fv1DtdJ7gKJ5dffPf8TAsJrL3sxD/W0vumTfKB9lhgf/qhqduMYUHZnxL+
	1BSs+xmCmBs9NdiYdt6jvIGq3moRJXzCMaiIEz46VUMYUB+WVQ4XE886JSto0g==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 04 Oct 2026 16:06:24 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: taozj888 <taozj888@163.com>
Cc: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 stable@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik
 <jeff@garzik.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: macb: rate limit netdev error info print in
 the data path
In-Reply-To: <7cd93a53.199d.1a10724a8ae.Coremail.taozj888@163.com>
References: <20260930113520.392025-1-taozj888@163.com>
 <b06cb02d9b26ceff272d7e34927a7eac@tipi-net.de>
 <DLUC9MKOACM3.OPW5RYHOYZV1@bootlin.com>
 <7cd93a53.199d.1a10724a8ae.Coremail.taozj888@163.com>
Message-ID: <3e1515e162d084e2200eeaa6074bfbaf@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi

On 4.10.2026 15:40, taozj888 wrote:
> Hello Theo, Nicolai:
> 
> Please see answer inline.

> [...]

>>>> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
>>> 
>>> IMHO the correct tag is 4df95131ea80 ("net/macb: change RX path for
>>> GEM")?
>>> At least the gem_rx() messages were introduced here.
>> 
>> The patch used to touch macb_start_xmit(), which explains why I told
>> Zijin to target the initial commit on previous revision.
>> 
> OK, I will still use the initial commit indicated by Theo.

Please re-read Théo's reply: he only suggested the initial
because v1 also touched macb_start_xmit(). v2 doesn't anymore,
89e5785fc8a6 is no longer the right target. Please use:

Fixes: 4df95131ea80 ("net/macb: change RX path for GEM")

> [...]

>>> This will just hide the error message, but the split/drop is still
>>> present.
>>> How about limiting JML in macb_init_hw() properly?
>>> 
>>>          if ((bp->caps & MACB_CAPS_JUMBO) && bp->jumbo_max_len) {
>>>                  u32 jml = bp->rx_buffer_size - NET_IP_ALIGN +
>>> ETH_FCS_LEN;
>>>                  gem_writel(bp, JML, min(jml, bp->jumbo_max_len));
>>>          }
>>> 
>>> The code above is untested, so probably needs further tweaking. An
>>> alternative could
>>> be to handle the split frames in gem_rx() correctly.
>> 
>> I agree with you but to clarify for Zijin: if you do this then it 
>> should
>> be a separate patch as changes are pretty unrelated.
> 
> Yes, with your experience in this area, maybe a separate patch for it 
> is preferred.
> I think the error reported is not just related the Jumbo frame, but the 
> jumbo frame
> would trigger the error. So rate limit printing this kind of msg is 
> needed but not
> totally hide those msgs.

Which other cases do you have in mind?

Rate limiting the message in this patch is fine with me. I can look
into the JML patch separately, or you can give it a try.

> [...]

Thanks,
Nicolai
