Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0208A1A23B1
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 04:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780548200; cv=pass; b=JVHd18wIM3hzQVruKmWCJjM13n9q/3pw+MGfdL/44Suy2bp3ilQm8MmAWHuJNVK1fpsIBh3G0QRCbralFeP40IbTzdeMIsNAKVQD/vYUO8WDMrF1qLcbR9mrc8z+t6RoyOzU6DXe1L6aQ4gZNqTu02GDyi2GctKynsn3dRYbaiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780548200; c=relaxed/simple;
	bh=3RJe6dpSrTJydc+DARNysumViUAgzuKZGzr+hdLqGJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5AzJ4AIzmOJmVWkEqIBRqzHP2iw1lWvgFJR/hzm0OM36ayYqoxUEO3f61JWGCtof/Snea/QZR7A3i7VmDPOmbzU7P0j+OHmO9ol4+f7PI7i14Zw79N8Jk1Lqk4KqnxvUN4RCA1QyfYYLuEc8SxcaJe3fYLp/lmQbVLf8HELW9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7AbE/1z; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7AbE/1z"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf3781ca51so2959455ad.0
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 21:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780548198; cv=none;
        d=google.com; s=arc-20240605;
        b=F7BdqzlleQUf9drtkD73IdzIlcighfkuSsnaooiWUrfkqfoRXdVIkt+TJy93eTOYuD
         1M1rGRFmR1i33zjxS1K/KLcoasPGgAE6c/mB/pp1Go5d3CF2qQQHVpf63PnPqsGMSwe6
         Q88JFZc5vf9XAn0I0POcxlEHVwKIxPoKNw6EQ8+sdDw9Mb2ewJgAEfL8ra1gMXh8t0Yl
         JZ+Ewsoris/wf0xA1rjKQV9XZA9At043py4nmntHx34DQl/zKBjwi+9mrdz/oQh0TffT
         kkk7UUy5Kb4HXZk6/BQTVFHge9ezGh4K5ArdjrljJqz7USLO95JnMoQuHWq1V4QNA4N2
         5Byg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Q8fUzt52Ok5HtP82gixM3w+SOLiXtsoejdjp6H3nNk=;
        fh=fRZXZkPelf5cr+QNnNj2pDd2Cxmv/7SLtc/EQvW0+Fg=;
        b=CmkzDnU62NxzopeEMLu5c53LqQghqs2hmXoXsXPIffGGIjyq7q7oGL3VgFRZCNBuVa
         EOYGwby4Y8Ckbt6jKhCizqDUMsGoK4dL0nFPiEdRSdKo73BLqcMzcxA73zMAhDm6iB8X
         P3yfzDeKdBpycTiooAB/cPhsm1ouMdUishYv57fB+zDLF9KG82GzLDyE7G80v8QWBYo8
         ZQJQo3XRHez9ulHyfzYfRFyNnN4Z707ELZ0Wb8nQRJ7VY4H1ULfMD4vkDzYpN8tPdrfz
         xET5OV1p4fJwxi38oVWpIl1awAq+MdAmKBiIADSLu7OCfPonB7VS0u64uiGwwWG1moxy
         eOxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780548198; x=1781152998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Q8fUzt52Ok5HtP82gixM3w+SOLiXtsoejdjp6H3nNk=;
        b=h7AbE/1zzeaWzU5skp7+nIhxP2T1ptX4xMqBkdqESxMnCtYGKErBmSpabh3svY/Quy
         2yHY+SiyW5P2JrFTa129N/3lTyoh7/yyE50J+4y6dDibL78Y3jmvCB13nM1H6MJKJpKv
         H7BPIgnmUdFIw1Lfyz1TqNqLs8nhGvRKGw2/xknQ1sFaPnloTxdabydUhdBZaGJsTB2N
         l24V1EqCUQqEcAXULd0EyNdxAhnVau0+bxagnPDP4q1kqigllDZJuwq2ah7994eQgeyZ
         cXAP8D6nPIJH1FzDka8Dbo2Xi+I9u/XPJRZh7+JD6EL6q8B0V7lLSCqfpDtwgAztcn4A
         SxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780548198; x=1781152998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Q8fUzt52Ok5HtP82gixM3w+SOLiXtsoejdjp6H3nNk=;
        b=I+ldw1f23VfiHmg4diJHW7xUfdkuCGq0NdKsN6ZqwVXs8J49tfKCK3mZG+E5Uq8jvJ
         BAc12SP5+bRODw2tkq2uwTcDT/04dICUtJLKMKji+xqzZykswwxaeZJhORXIPXG7taTi
         8KjSrwayVCf0zGneJwqsz3b2goJL5pfoR9GQT1Z4Ke4kprOf/q8ruI4ky4pJrHXelIfA
         5hJuKRCbI5s/AxJQ+Ay5rmogu+KE1aiDsmHtJ/W0KZ5oH0Cu3QayZM2ZAz8cnaZKLJDU
         bKanftqSTFDTQhD8/3Pi1LBky9ppWbMzfszYx4bz1FFgzaOJ2rwWYMAJx7NaPPjpnhI+
         Ffhw==
X-Forwarded-Encrypted: i=1; AFNElJ8RPpY8pBVR97/P2dJ6xvZjux6NoLBi+iSAMnz1M4yiEayCoBCuuToB/0E8kuBF57cJpJ5uDg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKWmUgAZcrk/Lmn2324NvUEnODTPQwX8xytU1yzHfU4H2IqHO4
	m4bsKvaddgEeQ55fSE2ovnFTWM8jRvhfuSZ6OQg81Jb4X38jwjsnDxfzeUXfbi7jsV+dzDdeKrq
	S9p+7L1eMh2LqRbwU91jJYvmQ3E0gLw==
X-Gm-Gg: Acq92OHLoS/faLDVYcn3GxunAOX9ECuL6UmaEFEgfyuVtuyDgybFPQ370hISgwF/qGD
	gXaif59nqwUpFUtc/yZIVTTne20Oyqqh4bfv3wHuy4q52tSEopqMFLBhceMEr8mJGuWU26YGkPk
	HlpNqcmhI/u/irzHbsqdn774DM4Jo+dDOPSZR4LQh/lLdosiq8GXj5EwRgNLO//nhVdtQ0mT9nS
	sZZ92/FVfvoZMHYEiEXtnRr1lNtdypxFl3/AziGLYo3UCbtnrVggiNqg9AVkGmoNVv8YYoXYVsR
	yys6Nw5ECaVVAJmThNLk+Yl1Tkl6mxoQeJW1ZqhljStrTEJF46SvuvJv1bo=
X-Received: by 2002:a17:903:2446:b0:2bf:305a:312a with SMTP id
 d9443c01a7336-2c163fa8208mr68644605ad.22.1780548198268; Wed, 03 Jun 2026
 21:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524175552.1973-1-mhun512@gmail.com> <ahdE9G8I7kd_OoGW@google.com>
 <nr568s88-77o5-p5pn-5r1n-236371989rn0@xreary.bet>
In-Reply-To: <nr568s88-77o5-p5pn-5r1n-236371989rn0@xreary.bet>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 4 Jun 2026 13:43:01 +0900
X-Gm-Features: AVHnY4ITieUM9oAw8Yb2dovzKSILbIbJGByWFFRmd3Q98L5EffP8CtXRVS1zhQ8
Message-ID: <CAGEsz8HDzf62R016fJ9Wn_M+_pmWCT8Rk3OQJm3-MihS0MVqbA@mail.gmail.com>
Subject: Re: [PATCH] HID: wacom: stop hardware after post-start probe failures
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri and Dmitry,

Thank you both for the review. I agree with Dmitry's suggestion to
remove 'fail_quirks' and use 'fail_hw_stop' throughout the probe path.
I will send out v2 with this change shortly.

Best regards,
Myeonghun Pak

2026=EB=85=84 6=EC=9B=94 3=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 9:23, Ji=
ri Kosina <jikos@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, 27 May 2026, Dmitry Torokhov wrote:
>
> > > wacom_parse_and_register() starts HID hardware before registering inp=
uts
> > > and initializing pad LEDs/remotes. Those later steps can fail, but th=
eir
> > > error paths currently release Wacom resources without stopping the HI=
D
> > > hardware.
> > >
> > > Route post-hid_hw_start() failures through hid_hw_stop() before
> > > releasing driver resources.
> > >
> > > This issue was identified during our ongoing static-analysis research=
 while
> > > reviewing kernel code.
> > >
> > > Fixes: c1d6708bf0d3 ("HID: wacom: Do not register input devices until=
 after hid_hw_start")
> > > Cc: stable@vger.kernel.org
> > > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > > ---
> > >  drivers/hid/wacom_sys.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > > index 0d1c6d90fe..c824d9c224 100644
> > > --- a/drivers/hid/wacom_sys.c
> > > +++ b/drivers/hid/wacom_sys.c
> > > @@ -2456,16 +2456,16 @@ static int wacom_parse_and_register(struct wa=
com *wacom, bool wireless)
> > >
> > >     error =3D wacom_register_inputs(wacom);
> > >     if (error)
> > > -           goto fail;
> > > +           goto fail_hw_stop;
> > >
> > >     if (wacom->wacom_wac.features.device_type & WACOM_DEVICETYPE_PAD)=
 {
> > >             error =3D wacom_initialize_leds(wacom);
> > >             if (error)
> > > -                   goto fail;
> > > +                   goto fail_hw_stop;
> > >
> > >             error =3D wacom_initialize_remotes(wacom);
> > >             if (error)
> > > -                   goto fail;
> > > +                   goto fail_hw_stop;
> > >     }
> > >
> > >     if (!wireless) {
> > > @@ -2496,6 +2496,7 @@ static int wacom_parse_and_register(struct waco=
m *wacom, bool wireless)
> > >     return 0;
> > >
> > >  fail_quirks:
> > > +fail_hw_stop:
> > >     hid_hw_stop(hdev);
> > >  fail:
> > >     wacom_release_resources(wacom);
> >
> > I'd get rid of 'fail_quirks' and use 'fail_hw_stop' everywhere,
>
> Agreed. Myeonghun, will you send v2 please?
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
