Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795378817;
	b=lC1qFAUtd8BuG/v7R0ewSHqepf6HbIBbTUail8Q6TUwXrTZjJhUMpD8J5NTGKO71YoO0
	 x8Pv4iKJOmKRTZ+7v1FRBTQZqPCQhbZCFaJnEcmowHLNWM8oqqQL66RVXSmfi7+dCj1s6
	 9YiuqvziAJm+//XdsJWHSHqfxQCRFBtI1euYRhlne0gKusLmUVSMoU3/ilwzhzWIklO/f
	 tWCj/HiGJl4bX2/3rMauAUN2fEVyNlxsEN0sceItQnA+04yj3V0SbIsOpejlyORGk/6lj
	 R22WebyDaemwWUVeoBdmf0Gabi5NswAIMDcN0pRBY5vJBk+6qyVTtKxFFYYpEfR8syw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795378817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kC307rNk6+C1niL7I+z7w4CvnqbVu1GxCYbOm7Tl96M=;
	b=yNETKGg2Vh2OkeLnkaTjxTQLauSsnTeTYI5ojI76gn/4hRJcbYzOSq/2oOFcCYwMPE5N
	 jfaLm1+R8lny6SA9Q20/77YeAkWiTdceHzjM4QLyIhxe2K4LHJI76tqk3Br31UtlW6rW3
	 h2iYnLYtJIK8w944fLg17vDrj8iz/vV4YePmsCm2PpkIeD+S8wHPwiwMWu+8MlGqtlHai
	 9jSgQ/Yw6cSepArUuneES52Gxs4SSztlkB2TP78E1PXxrrZwbOAq2tOxxMxDXPYPgqcxq
	 h1wtPKcRQWUiy9wd39Sp83NniO0u88L27tF52zJUa4C0F5bI+8f8yhuLGbnbBnTitVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xsgrvLte;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67FC606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 20:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D67FC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xsgrvLte
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdb684859cbso1477146a12.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 12:20:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795378816; cv=none;
        d=google.com; s=arc-20260327;
        b=rxNKU+qm/695g4kt8QSRbxCgHgHKgTp6Bm2mvZz4xXT25pVIuPFt/XwZvg7sdYBAK3
         2F1M+JJnB+rLS6SISpsneWXE4K6GRjuPddraRNsC8ola/iztbp2z922YSgYsRWnbDOmf
         oqqwPgF2igySpXtIuiTcP7d9hA6xd3zrQMzzpxGrC1Ibamg/uZjQKr+UIKCmm91qLB0K
         RpuLNEJoOLMkn9y0BYxS4h8II7/244Z+tsdAs92qZg+ryNI7m5+U4zJvu8Hey3bslpIc
         IaZ0j3vnUCLEwJ2tL1BRPl9zanbFat4zRdCseHp2EuzL6dtZ9CQyiPStVzZvgyeYN13p
         MpKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kC307rNk6+C1niL7I+z7w4CvnqbVu1GxCYbOm7Tl96M=;
        fh=cgJmA3DkmZ0SpQUgtOTl9puGQB9kvY43BEvzRiM3Sb0=;
        b=q9hmdEN/YT/Znl5oiZoaneTSsSH4r8fbAEzkT2+g6zgbr4X7VYI6vNbrw5d/FGu3jl
         rY9P+rZ6E3zcvRTNiRImBmEUYkpcY0Eg9KqR+EMQelnas+SGeJ3NHNMEGvwMrzNNNaW/
         S0xjoA+MJg0k9XqbMqG5Z9c1AX2zvPej7HwQBmkQdr5CbmtAbf9U+ApC9cPx+dHqJmKc
         M7sFAQ/k3fHw+1o75L96fHCl+3AjviJlm5mBIp5up0QbvRMKAIKT5HHnA+ybEeKhGbub
         Juyf0RjLXbFveFgKeVXMNkiDhkfTl5306kaVN/IukTF1r4Ib748EYjbZEwu2zv3fqIAG
         LTTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795378816; x=1795983616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kC307rNk6+C1niL7I+z7w4CvnqbVu1GxCYbOm7Tl96M=;
        b=xsgrvLteeAUUvjJzZ5BZEvywpZJbedVUEn4pL+xUny4QNb2ce5CkYBrs49QaDiMDhn
         lwIwGhl2LPPKX5+lQ3nbRnhDsNAjDk2bGodR9NJDOkvu8qRxKS1mPeJBtkPEy//VRWCf
         vb8a0wNpJl+ez2af53JCGawfY0NgRPiGJAoT9kqVvHRlud29kDS6YiQCGoPOyo7pv9z3
         oxuOQWT/aKgqi5Hippc888/bWoTnlnIIs1WT9rcDTKmf2eVgfFyCgIKxtl0GnxRoZpUq
         Q3G5e+oTrsby+2XPOffYjbMpLiUD+TsfDgN6MTJppbgNx7JPgkGKELYH38RAXW0ZMvug
         mmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795378816; x=1795983616;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kC307rNk6+C1niL7I+z7w4CvnqbVu1GxCYbOm7Tl96M=;
        b=qZsSsCCfqNkHGQRPOMChXzd1flZ/3E97W4RG1hLO3PzmPSTPBNqiybwi3waWLXMnLk
         QxmxHTVN4JI2ZxJ6cjkx8WmfSV61qVtlkxNrTyF7ZHdWjInhRI9ccPhqMLRZgTPiO6IQ
         +MTuqPYlLPWYQ8wr+He8kcKdK62BRcwYUIT3dwKmuC15v6l5p6r6vUI3FA42ydnRCNsj
         tRNnCedq+X/JamDioxAgpfCS0vWy/cAsaBHz9nD6gGpEVdfYKxqH2LlZPGFe7/REKs/5
         1yGG9fIh6Sl0abRjwADkUyHaJCQJLkBEliTMTcr85Zegb8zpAtxkMxuZWV6tTf5tLsQD
         FK7g==
X-Forwarded-Encrypted: i=1; AL+hErGACFJOvgB19wJV26H8hXGmjzlESw4RTkw4vqW41DX59yDAqTSJeOMFjOugUe/J7fwDGgvQ3z0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9N3r66aQHAP+OPPvP85vvGbCja3NAB9VYAWM0vr2dmS8mgk1iu
	EpxGbokY5K+GlI/0G3es1gpHaggPyNeiEksU7Hsgx9H/rkb6oAbMMcbo7X6bMqwTPa6+yoZsIog
	cnLNU0MazjZIxt7Nqt73m6Xty+Opc/Qo=
X-Gm-Gg: AZFdTZdKEyudL67nK3yO2V/Ne29j3WkNM9Bleat3gUVxkx9RPB9ZzMhDABtZkZ9CZPE
	9PYrQcbYQ/47913XB7+U+Ruowbxl6lXXH6gdW7BUFY4UXoaYD9TohCLsN2cR77bbimASI8X6DFr
	eG0l/tRkaNHUTYS3GaO4ZeGpTy9vHqYmbTI0JqCrKHTVDNS6UJhMkP6QBls007v2d9eRSfpjez/
	BOy70HdEi+P0eiYgAI1VM+0hkGmncKMx66gV3DHNFAPVwEWQi5Ny/I8ScMjxdo+soHqcMt3Op5k
	qa8MQKowD+nGYJSOUbFtQGSQBOBeOfQYKDhh7sphvc5MLG1YSddsZ35HcGwk9+IpnYDbEWRwcBW
	DQpAlHplV1V+nWq42cfB6v5eEcxfOnfRi7fyAGxue4xNVtgNrva/XjjBT1ZFYOgeXsOoot/0=
X-Received: by 2002:a17:90b:442c:b0:3a8:9b79:e6ea with SMTP id
 98e67ed59e1d1-3b41cb235cbmr8580615a91.59.1795378815937; Sun, 22 Nov 2026
 12:20:15 -0800 (PST)
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
 <9d8cdde77beedce76aaaa1c5a7a788dc@tipi-net.de>
In-Reply-To: <9d8cdde77beedce76aaaa1c5a7a788dc@tipi-net.de>
From: Sam Edwards <cfsworks@gmail.com>
Date: Sun, 22 Nov 2026 12:20:03 -0800
X-Gm-Features: Aa3M54o84M-uX2uQ_qZeHIKjUVqNqkyoSTJtgWDoyviNh_-BeSJ3m7iO-KDBvI8
Message-ID: <CAH5Ym4h8-1mc+DX0Si7XROeGn9M72bQC+ooM05Y7ZmgTo+ON4w@mail.gmail.com>
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

On Sun, Nov 22, 2026 at 10:01=E2=80=AFAM Nicolai Buchwitz <nb@tipi-net.de> =
wrote:
>
> Hi Anandu
>
> On 20.11.2026 08:49, Anandu Padinhare wrote:
>
> > [...]
>
> > @@ -6164,6 +6205,8 @@ static int stmmac_napi_poll_rx(struct napi_struct
> > *napi, int budget)
> >       u64_stats_update_end(&rxq_stats->napi_syncp);
> >
> >       work_done =3D stmmac_rx(priv, budget, chan);
> > +     if (unlikely(stmmac_rx_refill_needed(priv, chan)))
> > +             stmmac_rx_refill_timer_arm(ch);
>
> After a successful retry, doesn't this leave the last received frame in
> the ring until the next RX irq? Could the poll refill first?

Do you mean "first as well" or "first instead"? Because "instead" can
cause avoidable packet loss:
1) Initially, network is idle and ring is full of empty DMA buffers
2) A burst of exactly one ring's worth of packets arrives
3) The RX irq fires and stmmac_rx() attempts its refill-first (none
needed) then depletes the ring to the maximally-dirty state; the
refill timer is armed
4) During the 10ms timer period, more traffic arrives
5) The RX irq doesn't fire again because no additional DMA is
happening: there are no usable buffers in the ring. So we're forced to
wait out the timer.
6) Any packets during this time (beyond the RxFIFO's capacity) are
discarded by the hardware

But, "first as well" sounds good to me: before entering the main loop,
refill 1 buffer (if possible) just to ensure either the IRQ fires
again immediately (if the FIFO is holding onto another packet for us),
or the inaccessible ring slot is clean (if the FIFO is empty).

Cheers,
Sam

>
> > [...]
>
> Regards,
> Nicolai
