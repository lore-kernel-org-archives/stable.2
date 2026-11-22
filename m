Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795383289;
	b=zmqmgU9r5gdKmuSHIjG58oDtKuPUV7l+r9OirOzD56Dz6wGgzLhO9aX6U1w0I4xeEpbJ
	 uUp7PwHRPdAIhyLl6jxIpriOylahsBj9ESFxF1sOjiP1pMoC2hCmrAGQPwMsGTCKKMrxr
	 WsaeHXEXoh9e0LY5/o1+C1o26yUH95PDjKLfDqnl75loiFVLZ7BcvXkQxkvvmeIgnsjSn
	 rT2zGYD0RDnm/Y8lfrYSyxfnsEFoXBfJZOBZo3f2jD/JEf91/ReGXqTFwRbddxoTjS6wR
	 K36LI5qi/5sQhHWI6uvs4ky0m3FX2vHcyl4GKsPFLozKvykl3HtS90rDCvU35AbFSdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XPYrCbu4T8TJmTKZRllmVp6cNeS8O7+5fQphOJsL0qY=;
	b=mLdFE8KB3gjhDYeYIApXCK6t4v0rMwz5MVNPGYHCHTdja2mMB2bqy6LHzOkSS9EcwdGs
	 5L18Otb7mFb7dtKmqN34vLxsKRstMbuXIXknlFl7u0BykaEJY3/L6dQWEN+87enkzcy23
	 USOcWI9N8o5mA8H59xcVbYRMGs57JQ0HpzlxvOpFzo5HQV6RR+TntY+ytrN6KjD+MQ3l9
	 aqdvHlibgmfl0KK37/H5WAGR8gNPEDNYO8aZ16ku1hyGEFnBTUsOBL47gopNqcsxqsF+Z
	 jSLC6kVtWj4+qPAttr5rOsjVvJOyApo3OcBM1GJqVChw4F8kWQc6/V2GG2pJvvXIevg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L48SGs+q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D83A606A31E
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 21:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D83A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=L48SGs+q
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f03920c4a0so16024585ad.3
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 13:34:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795383288; cv=none;
        d=google.com; s=arc-20260327;
        b=ZpwCWaN/YApC34X/2OAimXO+KQhMKYDmiHS4oX5HKeSnEbatYMAbqlisqddWYuo/V9
         AYQh2rHvtopCytZQQWMrSJ/hQPs4G2teSL+F2tyAeVIvKAszyxPwlBXq33qbaAgAQ5mz
         m5QctYDeRly5YKfk1AYMEPaMVSiv6rpn8GOP8JnSRxMTHwbs0qZwQ827lQsb5mTE7IMZ
         Qo/Jh/+UiconOUbVELIxu1SOM6yHRQIFx+39TBXvCoO6bF/o4TlydJcW1IFQ7Ll4svJx
         54Y55C4uWcq/X6WhSK84KU5AzDMRNfgjxqoTPnKTYs0kb2L8dEZLC1LeXcVZPbm5cqNw
         SWyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XPYrCbu4T8TJmTKZRllmVp6cNeS8O7+5fQphOJsL0qY=;
        fh=y6HizDr5jJu17JYCleKNEfEtco4fJPpb43zbLko36co=;
        b=GFKxH/6Me8bkpp/qfFyn/LiUfy9wdlVqYpt5BXnz5obRXun+yFkkBPFKP1JchZrUDe
         1fdGWa133niOd5grZ+8lJyZaR5eYYYVUSVIxGf7c+/Wp2JFhZw7rzGDNq//cCt3XH/G0
         baKIF/bz91+kk6tJhFKX48Odr9WjctVyekU0Nb9EKEN9pAEh/VOgRNUYxt9Ogf9qrxoU
         wbdCnMNaR6TUYx0JkB1ITX4UCThY8wMRYMWCtX0QntYWo0p7DaPrGgteIbYyHMlnb3N4
         GH6Lv97+W0HxhXLTcMFeMyeWF3Iu7KaBpGx6AfB/SiW/ukfddJJRDCSyY3svDdjvO6sp
         Kylw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795383288; x=1795988088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XPYrCbu4T8TJmTKZRllmVp6cNeS8O7+5fQphOJsL0qY=;
        b=L48SGs+qITSiU9hSWY4o9yQj/aAnGU6HZ93xE0Olg0EWUzUN6CvNjvrp5INE026cGL
         m5+b38kIjvEV2FS5GipiC9A5XaQ1sQcUh1JC6pv7PmVZOtknNfL4ut0ivMegw4yoKYII
         ODqiQseoTD6yv+FbbokDjsVdRvfZAFx+EYFUKaSKT4tLNLy6GJi3CSAHO+pj+8DBcNnk
         g3MlHrBmg1XIsQyJYOtVqFnT5RX6vev9FXIR4wIYG5EMU/jYpc2f3/yntxpvfPHIfY9M
         n3R5Ww8jncIYH1BR6AQwQc/6TnbXSniQDHGBGeKXtVhZuR9CufKnHMncu8IE2i7y/okQ
         IZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795383288; x=1795988088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XPYrCbu4T8TJmTKZRllmVp6cNeS8O7+5fQphOJsL0qY=;
        b=zmCuXusgaz48fbFk9EMXdM3MlzZjuj3WJPWO8XI/hO9OnoagaNvZr2dX8C+uHc/DmM
         TH0irULFpidMEEZEZEFEmCTAGG+8W3LWDInvvTYMqoAemP8n6DxpfxETGxVHvunC12tK
         2RzMraVt8iu2Bg6UmtsgFcghGGnyzUAbVrDhAnUs3joQITGHAMAX7arAhfOdz7/I9YGS
         4bhEqcBNelcdd4XsrHVFXcPgNm0/8FoGgOlNLDn6NBdCj+oVxXaBE5pju7B1T2mE/eqY
         VdBJ7A/5e5jMUAGYjWqGGDNlcnTCY5LpE0O8DZ+p2xpD+lHnx2S7her06ykeCh/AMQeW
         vCBg==
X-Forwarded-Encrypted: i=1; AL+hErFwkSiIJADkK7vJMyB4WHUEnG+xeEWsa61fSKJWpFaauRsm1BuDR94Lp2trWk7ghot946LtdSg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jFIimJE8JBPEUieCgntiHwtKNI0fRLlqTrKN2PjJpak4pULa+
	U4U7aVF+uVi3TzEXFrIdlTWM5uHgdXg8cMgPxTROe8kAvSPAwIXWvIhlG7vYdhvxQgNLWbseQeZ
	pq3AOj2A/irYCvd9LTyn1WR1cDQsQM7U=
X-Gm-Gg: AZFdTZcqW2E8+124Ps0iVk5gCY/1eeD/yQXhGwr44B89oaWLhXjxEqxqZc+PTSI59kO
	jbu0HmllqauHNSCmXwrhMyzWA2zSCWQLQzk3UmdQBaqKu4MXw6POZntj0JGAnnw36nTL73u5z1x
	/2O7VZdNVXPxHbgOenBivA0fvbh4jGYhi3WivNH8/eqIG162M+8khAVRnYcVoEC7pWp0EshUaXt
	mr5/r5ui6BVw6xvkxm6OZrNIEsDV82SaCkbAHW4rwnzK42NlVApDBAYmKH46Fa6h4MPSC0bWVvE
	kxPhhj0cP7WfDbZLURwDTXpg2lUIPZf+A0iFrwUIPuyQtcaM0A8o8tGRrVw2FkMl1hWyNny0+nI
	OhHzVMlXuN5IPIexJmiurBb1Be883NnEXpHj2BseBnSYV9IIT9yzwb48j10jZrXI0/CN1Lw==
X-Received: by 2002:a17:903:298c:b0:2ef:d952:4a65 with SMTP id
 d9443c01a7336-2f03f1babeamr91216115ad.43.1795383287859; Sun, 22 Nov 2026
 13:34:47 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <MA0PR01MB921746F36D90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
 <9d8cdde77beedce76aaaa1c5a7a788dc@tipi-net.de> <CAH5Ym4h8-1mc+DX0Si7XROeGn9M72bQC+ooM05Y7ZmgTo+ON4w@mail.gmail.com>
 <CAH5Ym4jkX_tD58Gtd-mzruB+hqHK7s_9knNWh+gMqUjwuYyVPA@mail.gmail.com> <3303844cdf7c00c5369453eb91027c1b@tipi-net.de>
In-Reply-To: <3303844cdf7c00c5369453eb91027c1b@tipi-net.de>
From: Sam Edwards <cfsworks@gmail.com>
Date: Sun, 22 Nov 2026 13:34:35 -0800
X-Gm-Features: Aa3M54ojoA-gtiCq3dXKw6zioYXOKf9vTAqllY425ytZiRU_L22WV3K8LaUJ9aM
Message-ID: <CAH5Ym4ijMNSAWZ8k3GmwOoLDBVTy32B1uhS_fE-dGhsPkgozeQ@mail.gmail.com>
Subject: Re: [PATCH net] net: stmmac: retry a failed RX refill from a timer
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Anandu Padinhare <Anandu.Padinhare@electrifex.com>, maxime.chevallier@bootlin.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, David Wu <david.wu@rock-chips.com>, 
	stable@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 1:09=E2=80=AFPM Nicolai Buchwitz <nb@tipi-net.de> w=
rote:
>
> Hi Sam
>
> On 22.11.2026 22:02, Sam Edwards wrote:
>
> > [...]
>
> >> Do you mean "first as well" or "first instead"? Because "instead" can
> >> cause avoidable packet loss:
> >> 1) Initially, network is idle and ring is full of empty DMA buffers
> >> 2) A burst of exactly one ring's worth of packets arrives
> >> 3) The RX irq fires and stmmac_rx() attempts its refill-first (none
> >> needed) then depletes the ring to the maximally-dirty state; the
> >> refill timer is armed
> >
> > Thinking about it more: the "unreachable packet" problem happens at
> > this point too, even with the "first as well" behavior.
> >
> > Maybe the best way to resolve it is to adopt stmmac_rx_zc()'s behavior
> > of refilling during the loop?
> >
>
> Only if the ring is no bigger than the NAPI budget, right?

Right, but as pointed out in b6cb4541853c7 ("net: stmmac: avoid rx
queue overrun" -- the commit that introduced the "leave one behind"
behavior) the ring can be as small as 64 and that commit's author was
seeing budgets larger than that.

Perhaps NAPI should only be told to stop polling if we either:
a) Reach the clean tail of the ring (so we *know* there are no further
packets for us)
b) Run out of memory and have to arm the retry timer

Thoughts?

Sam

>
> Otherwise tne poll can't empty it unless a refill failed, and refill
> first
> covers that.
>
> Refill in the loop sounds good, but this would be IMHO a net-next
> follow-up.
>
> > [...]
>
> Regards
> Nicolai
