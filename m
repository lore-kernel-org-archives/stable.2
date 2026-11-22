Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795381365;
	b=HrTuJAj/LstJynMuZG8Du7gUwtrFiO/wLDE4WEl3ZJLInd1qxSnZLwh+GOsUMOu9UDD0
	 e1di/Dm3Bqa1gr5l6W5KyrmHqsiG6SNfoWblo7RtIs5JVW7PLxeyTMh/8EcuytBmyutLW
	 yxK32TCkm47BHFTn2JnPeD8mHkfw4FqYljISIGr6RKR3mfe9hWKfEhZx5BVwiNzni6EIL
	 04iuCYtm0AZKsHlPkpWuVhS5PvJBWuYEvu2mtcqlAjYQXvNSLRvhSLahDSgo5tbrpr2nY
	 4PupIgGGfK8P6OHElrfC5/5M9PB/5U8zfT81/F5osH7C9ivrDZqxgHSMDB8tVhS05MQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795381365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pn7AXOK0vv7XoUam0J0U7bLVZ6v8zi99slOsZ4hNcmM=;
	b=HjkMDMgI2ZMAuPG/igp09dUNoDBahaSWznw9alvrCQTAHMyomIxIKOeLgv2CGVRKF/tN
	 xhLtYQRvN+6NVCv8JRbHCGzphC71jcIxSGsOMK1BvxhaoC6mASV11D0JFYNLHBQEx0k+D
	 lkh3WLU4qQWtJMpz9EQIheZT2QWNws7xpatMQKPxzik4jn4O0EusIH1XZm4xJFX6NWkR2
	 FCErYHmLSie1laxwx/Xsn5BgziDGk9S7a48EPiaSMuXiAEvw83plaFHNMLhZ7+N2Bwax4
	 SIUTTCKc/W0viFfux0GtsVAoPtNxBa2knzd8OWNCuv/E+prOZmQRpinZBsFHYaw8uHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zlsBYq18;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DED606A31D
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 21:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90DED606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zlsBYq18
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cdb9f760337so1817012a12.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 13:02:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795381364; cv=none;
        d=google.com; s=arc-20260327;
        b=cIVtUQkxUN5Bwsu4htjwsuj3yCrgpWhxWijUejBCSqU40uiLVP551QVk4BzYFDu0pL
         xZU54FbYJ1251qsR5aJADo9u7sviKICue3NGiV9SM+p4nBZn5IZb1910oj4AEiaTel2d
         aiN5Y3gbgFDMsuNdAx9v8GDTMy1VMhXc0q1hQNsJM3dBpcCnc0ufFnmObK6L7o6wj6BS
         0d7riL1VF+05+ZgYvlKPRo812hDPaRgdrY77SKk+mSeXcEG3hStZdyjjbKCr4mfsI+S+
         D5tnpdUNX/+uquwRkHZknOgw0NYL2STeuifCv9IcKwANRRFK39Ijsz/7zOaP41U7T3XI
         YLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pn7AXOK0vv7XoUam0J0U7bLVZ6v8zi99slOsZ4hNcmM=;
        fh=Aw9WPzEYOMp6Qegjhwaj/Jepa6iFEAZ/PcSqVqsUjaE=;
        b=DJHyDxZ0tc+fFC8Jz8kkxQcvfz1noa3FmM3BrxHr7YBan0L6Cp/TS8datAX58XbVdz
         nB0LnwavdaQMPimeH8moFRCYXcK0C4uLp8Ti8Yk7yyo+TVF7TMXawzqKfbOEkzBE3j5z
         fNbMYFuieq+h/DKXNoS+u0AL02KNg041S6ztMYsw0Q96sKP9E//jKITvTzs1e2kEPhjj
         7syoswJWkIhpkm7bHhNwdj+dnndKi297/WBpVAgEapbTz1RNmlgbNoUEv68axKb6gbJR
         h05rvpEIJwP2zi1VLw8DeLWMwVSqz6FRqxqAkd0CNUUBd8LfH2Pbxo+LEl5ZssHdbjpy
         P5Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795381364; x=1795986164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pn7AXOK0vv7XoUam0J0U7bLVZ6v8zi99slOsZ4hNcmM=;
        b=zlsBYq183P2jR915rVTxFxauPzMtvP/3QFSR94XstIUIk1+DQECZlj7+o2TCBTwO4Q
         OQ+ry/tgUEUfXH7JkwtfbQgmYmGWP+sWmdEcSi47N1Tf9NGyLKDKI6NiEk/Q7/eG18UF
         uovr7R4wYDgZC5HeOyVSSh6XTUW0oK4TTmdRi7p+bx2HychGJFIz3H99RjLd9/MX+YGH
         rOayRZIQj3i7bi+YFqt16rsfPngcVCvVhFZEC5s1UY/sU+1MrNWV3E2DSk8yo4uV3N8H
         EZug8sN4NQE4GBGoBtLRyflLwIrBc9/DDBx4x9SO7ZWe54jl2xq3Ob7I70FvrohJNZdU
         dkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795381364; x=1795986164;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pn7AXOK0vv7XoUam0J0U7bLVZ6v8zi99slOsZ4hNcmM=;
        b=sjHKJ6kt7cR2G5lZGfeTCBUm8UzJhzi7ndinQTvz3RG78veZz0afbQ6WArLnu0DghV
         IAzcyWORYgFLuS6E2S/Qqo7tgDfUSgKgtDL7pmFm+F+68PYZJNB5MOHWBiWViu4AGSeV
         RJ7BlgKI2fPirsypArUZ7BIXFkklhtLQFuv1/pG+3WTnEY6BG1qJ78pyAMbzRsQEcQQV
         vXSZ6shfaC8cIrHlssJXexJmX1t5u69CxVLp2AzPErwwD2MPHKY0A/7Kw8qt43A1yhfB
         sbqGM+AeG/v1AD14jzHpbm+rRENzT5TGWl8H/Py596WP612+Z8MrQ+EM8d71jNPFefas
         AdDw==
X-Forwarded-Encrypted: i=1; AL+hErEvd378Z2UxKTjuAcKwTENTbSExCIZfT5bBWXBfOVjbAFVPtgODwxpeAhggrAnPme7dKCgl7Wk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9CYgwZ1kZfM1OWvS03bHVofG8ZvZeGE9Y97lF06qGXasNXJj/p
	Dlh2PSwNQmpqjtWu507bGXAju74d0ALC2FcI8iKIoCRVz1LHAFZlpHY5C5/YMT7+ZT194f5wVog
	bFxjTIlVv+qLRcbE/4mNgbEEkyl1a0JA=
X-Gm-Gg: AZFdTZdAb5MpyELjs86/deKrkw1lybZY87K96EpDjV6XTR+DMJEkphTCye4mFUepoiM
	1ut4dVAwUehcR0lg2Qw+MY2mKRO66+vhPWCOVbfvQCZXUxQywVCn2gohtK5nymOsMabBB6S5TAx
	m4xytERh4zQGwD2UnbFH4WDfkW4jEaHiMfEEnrVc+mqTPYL1KWCr2d5IUusT2DVllIXYtX1C6kN
	PcjPnNnhxBdtUuwsqBI3EDJMuAjr2kqnk8uqLRlXyoSNHGitm4weFK8GMhLDA1+QLQMp1KVk0lQ
	9zZF1qj0HCOCxrW38EWOyTfb9P2oya8vr+pfIFiCDKzm/STNbiXL8TXqidGO6v10NQ6Ll1hmyhz
	nYJwd7ufnNhOEVwr3nNl3dzdof++KFwkctpDTjZOhHvMNiS4vm3Q+svrXC57/PSXIkmdZTw==
X-Received: by 2002:a17:90b:554e:b0:3ac:860e:1af9 with SMTP id
 98e67ed59e1d1-3b41c981a67mr6077104a91.41.1795381363876; Sun, 22 Nov 2026
 13:02:43 -0800 (PST)
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
In-Reply-To: <CAH5Ym4h8-1mc+DX0Si7XROeGn9M72bQC+ooM05Y7ZmgTo+ON4w@mail.gmail.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Sun, 22 Nov 2026 13:02:31 -0800
X-Gm-Features: Aa3M54oHW1FHI6GaA1OK0id-oEs8UcKMQfeywYsbJpKdYciL2E1UJ9KIq7wOQ5I
Message-ID: <CAH5Ym4jkX_tD58Gtd-mzruB+hqHK7s_9knNWh+gMqUjwuYyVPA@mail.gmail.com>
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

On Sun, Nov 22, 2026 at 12:20=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> w=
rote:
>
> On Sun, Nov 22, 2026 at 10:01=E2=80=AFAM Nicolai Buchwitz <nb@tipi-net.de=
> wrote:
> >
> > Hi Anandu
> >
> > On 20.11.2026 08:49, Anandu Padinhare wrote:
> >
> > > [...]
> >
> > > @@ -6164,6 +6205,8 @@ static int stmmac_napi_poll_rx(struct napi_stru=
ct
> > > *napi, int budget)
> > >       u64_stats_update_end(&rxq_stats->napi_syncp);
> > >
> > >       work_done =3D stmmac_rx(priv, budget, chan);
> > > +     if (unlikely(stmmac_rx_refill_needed(priv, chan)))
> > > +             stmmac_rx_refill_timer_arm(ch);
> >
> > After a successful retry, doesn't this leave the last received frame in
> > the ring until the next RX irq? Could the poll refill first?
>
> Do you mean "first as well" or "first instead"? Because "instead" can
> cause avoidable packet loss:
> 1) Initially, network is idle and ring is full of empty DMA buffers
> 2) A burst of exactly one ring's worth of packets arrives
> 3) The RX irq fires and stmmac_rx() attempts its refill-first (none
> needed) then depletes the ring to the maximally-dirty state; the
> refill timer is armed

Thinking about it more: the "unreachable packet" problem happens at
this point too, even with the "first as well" behavior.

Maybe the best way to resolve it is to adopt stmmac_rx_zc()'s behavior
of refilling during the loop?

> 4) During the 10ms timer period, more traffic arrives
> 5) The RX irq doesn't fire again because no additional DMA is
> happening: there are no usable buffers in the ring. So we're forced to
> wait out the timer.
> 6) Any packets during this time (beyond the RxFIFO's capacity) are
> discarded by the hardware
>
> But, "first as well" sounds good to me: before entering the main loop,
> refill 1 buffer (if possible) just to ensure either the IRQ fires
> again immediately (if the FIFO is holding onto another packet for us),
> or the inaccessible ring slot is clean (if the FIFO is empty).
>
> Cheers,
> Sam
>
> >
> > > [...]
> >
> > Regards,
> > Nicolai
