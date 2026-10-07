Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F221F3F54A4;
	Wed,  7 Oct 2026 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791358131; cv=none; b=tskAbd1gib7FQ17MU+U+zIEX32DQx8PA5zy6mSUE0D9LPND2nX8P/gpdLoB9NuIRfU6nz3XX+zb2OzwOT/IcdbVeUBvK5KRtK2us+STkGJCMqOMkx6+kkWDe1SjZZqMF/JnA2cp5mFIwrDKaC+Zg2gpHiRWsMRIzem74X1bB79c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791358131; c=relaxed/simple;
	bh=bE0o1OhHMVxB5nkNmg717lZZLE67jZ+Gfb85A76k0vQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nLAK6eS5WVb9V9MheINAMvKpZq5iCAZF59JuiSbq5uAopggVuXSyCx7j/ANqJcHeSrM7aFda1eVap6KSOv4i3r6A7kF9oDbFLozPZPL8fM9dlqFJmWJIVimg+R4/AQr/BRLMBnZNPRKsHl7EW+FXli0v273JDIeI4K5cbb9BNRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=oxxB0BFM; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="oxxB0BFM"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 134F4A0920;
	Wed,  7 Oct 2026 09:28:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791358125; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vgkGUd8JtaSuC4+b7Qt5KPtg73uAgRkx9hsuh6n+8AU=;
	b=oxxB0BFMonnbdf8gRA+SwAQS5Kkxnq/8ew78jgHDhYUY1E0BQ6Pw1ndcKuS5UHKu/VhVfk
	EnQ94iGHNr73jLdpVzW3AGjLIoZ3ISOkpiyMik5udfxqV5bmywk1cY3e+UHi7VLr/Bm256
	bx3+EjwxmomO8rn4XZ2fbrHeJQ2Y6PiPMPrmJnjFMCZdhlCWvrnBM80BdGDimRSAQlo38q
	obyBrFVzIKpu/Nw0tu11c01h58WpBNKtFBrpaeQWi/1ULhIcSwgvyqYHPb4s4Vx1/+TEON
	NlBrgLEZtsCiG6bC3QLB4KuOWyWd6X6PoXh0uELnYAwoJobnZpbTfqCar4Fs1g==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Oct 2026 09:28:34 +0200
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
In-Reply-To: <37f9ba8b.1682.1a114eb8ca0.Coremail.taozj888@163.com>
References: <20260930113520.392025-1-taozj888@163.com>
 <b06cb02d9b26ceff272d7e34927a7eac@tipi-net.de>
 <DLUC9MKOACM3.OPW5RYHOYZV1@bootlin.com>
 <7cd93a53.199d.1a10724a8ae.Coremail.taozj888@163.com>
 <3e1515e162d084e2200eeaa6074bfbaf@tipi-net.de>
 <37f9ba8b.1682.1a114eb8ca0.Coremail.taozj888@163.com>
Message-ID: <8862468e085097a9dc658034e951d8f9@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 7.10.2026 07:52, taozj888 wrote:

> [...]

>>>>> This will just hide the error message, but the split/drop is still
>>>>> present.
>>>>> How about limiting JML in macb_init_hw() properly?
>>>>> 
>>>>>          if ((bp->caps & MACB_CAPS_JUMBO) && bp->jumbo_max_len) {
>>>>>                  u32 jml = bp->rx_buffer_size - NET_IP_ALIGN +
>>>>> ETH_FCS_LEN;
>>>>>                  gem_writel(bp, JML, min(jml, bp->jumbo_max_len));
>>>>>          }
>>>>> 
>>>>> The code above is untested, so probably needs further tweaking. An
>>>>> alternative could
>>>>> be to handle the split frames in gem_rx() correctly.
>>>> 
>>>> I agree with you but to clarify for Zijin: if you do this then it
>>>> should
>>>> be a separate patch as changes are pretty unrelated.
>>> 
>>> Yes, with your experience in this area, maybe a separate patch for it
>>> is preferred.
>>> I think the error reported is not just related the Jumbo frame, but 
>>> the
>>> jumbo frame
>>> would trigger the error. So rate limit printing this kind of msg is
>>> needed but not
>>> totally hide those msgs.
>> 
>> Which other cases do you have in mind?
>> 
>> Rate limiting the message in this patch is fine with me. I can look
>> into the JML patch separately, or you can give it a try.
>> 
> 
>>> [...]
> 
> 
> Currently I have not direct cases here, but for some tough network 
> environmets,
> there may be some error pkts received, especially for our customed 
> HW/SW network requirement
> which may trigger this kind of message.

If possible, can you tell more about these custom HW/SW requirements 
regarding the macb?

> [...]

Thanks,
Nicolai
