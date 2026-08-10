Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D242BE7DC
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786368780; cv=pass; b=EbCCsjwUqmX3LRgxFgV1CoVhVSpfBWHO6YBSxqLsF6YE7CcOT3WJxzs+EyLBgHJhca14kz1513FNq9Xbl7eLl1Eq8K7cMNq+NtlJXKKRBgmlaO3XMRcRKzibEBWNgznpQahsJo0cGAOwhbd13uDcFCABs3mcXQAFSgpBdkDQMpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786368780; c=relaxed/simple;
	bh=j4fdJB83OgkfpDFpn8eOXag7cSqCJ6o/mUw8wWH5rc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiZpNVWehafiLa8mAgRLgyIixe2nPCeJWIbQXvCKRycL+FVyNxzpdXHZPZKwfZ7K5RaJCwdx+pWS8EewRl5wgkr5of8MjK5gV9TUdwXvBR4ELVC5vyK99nClL8nu9ukhbflK0nTZdqYYjxTcxZxvwUV8vFnyfbtK842AtzwX5uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apTmBob4; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apTmBob4"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4a43c2a126fso451320b6e.3
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 06:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786368777; cv=none;
        d=google.com; s=arc-20260327;
        b=O4R9GWsLw2jSZzSWCTQ5UY6kTk15rMW7+hTiNUSTVp4m+vlDTO0oZGOU/eXU8oViO7
         cXWgSRJ5ZX8AyvN6M33iaZat9P04YbCCDXlBjm40U+Smc4UOKoM2/LYSEcrNmowkhsDh
         piLCdvoHSbXB8xUfyW2mP8PVYMFONe/KyMEusV1GKv5JPv9ogq61e3bxRWgTx2hXlANw
         6UgaWsqvl4+tKMW6W0l4rDECHwlsaok1cfDTaMSAP02BTyLgQ1T+dDfUqDRP/LnuGHYL
         v/cgzSA39NdeyH1S0MsGh1z5Ckb/Cm734/ZYqPlx2r5cytl3RnwrYV4kJq9O7Bjrx2/I
         TjEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=roc9S1a5x2gvGrqXEh82i6BdFvHALhfABuncZ0V+eZg=;
        fh=8t8lTZhJu8btg1Ix9B9d/m/PlxJ8eU7i25bQu6+5wrY=;
        b=OfTc34COn9btRa1EFJ2jtsUAtCrbzS1OcDXI4d15WWSdG6M/9tPryct9pPxwq/dgJw
         hchcwJNnoFOFa/Yh/2jVnsR1zP/lwkPe5JD2TBbFOsrRGTPpxn9GC2qDpm3F2LAoX3DG
         P8Y8a3jWBN2GmCXJmdIkdS57fcVOqGOCMHBbta/PLXMfAy06qADtidKpxACCHfiRoPEA
         brOMB4C7p3N+JHgMG0nHnF9wRNGbQ2K+rRD5qanGa2db8DORAXxzZyvSbDUlZB0xTHNn
         bTZQ9RqBCOirFr6/U9aigoHPC1o1A5YkcLpV+yuJoCX+L1Xylqb3z5R0n7F1KBs7vEEG
         8Fdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786368777; x=1786973577; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=roc9S1a5x2gvGrqXEh82i6BdFvHALhfABuncZ0V+eZg=;
        b=apTmBob4QIr3twF45Vgg+rTrZD0GB0olkQzlq+ySNkICwvn5TjNTPZc6fiVqwpO0cl
         UfUj03HmEsA+tujX/3hZqhT7Smgcbqvbmr2YrcfFMIDyXRYG4xkqth+EW7/tNZXTWTn8
         99krUXsIMfnDAHn37g6itmmcdxU1jtmzxVFt+JwD2CB6WkurOS3cW1cu0hHaLxQLK+u4
         5JJwYnohVlNVq0yHGz9GU+/wTEAvUMTaqywA2mPW7o7oBkNf/O0KuK90x/LAEigl7MAq
         WICl4vYhI5WeI1guwhW/DI55mwRDQ1k1j6m4c5483jlYPaAkcIAy9nNlk2fDqvxfkssV
         tdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786368777; x=1786973577;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=roc9S1a5x2gvGrqXEh82i6BdFvHALhfABuncZ0V+eZg=;
        b=q7VjF8RN9nR1Y9vrJSYjYx5c+REw8DMLW1Dr5by0O2jbSlV6kpkzdaMKFxPpmMDjK9
         pLhAuqN9vGAZE9OhotvP4ngUJHPEh2Kg/WFQdDfBmkbhqjngRYS5Wm26nLC4WUEhmFXB
         5uiKu9GsSX+8/tq9niFoZZ2/AnShJ43VOULQxYWREENEFvfn6CtFbMgm5aFYfoMvkUpS
         K8I+xOYGbcpIEFpQF7mwROSJysSlj1bPaz54vtxvGXkFtJNnWckL43jDaj0CzKq7UA4Q
         kjaZgFNK25qh3rwK9Ni88b/NW4P5YNL1bpOcMNb2qed1cMGF3DhezgjnOHhC5ll+zQ6W
         vU8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrxTSHFKfhOM8638l9JaNp5o3DtMUULfTsv5RtMgqyEW9OjXIp5gOr8Ugw2c880GKb+YeBBXkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW+yvUoAK5yXouCHMtK2Sw2nCBSgDW7+/y8E+NEiZJAkDf8idm
	vI0CYZu6PM0n9lWRK1SJ0otPEKvbp8Y6XoNQjtEmWhHbyeqAcOisCC+KzR6n19tRrVDELmtTnL3
	8GwZCnm0byTDtrUgK3lvUKsXEFrAbpJU=
X-Gm-Gg: AR+sD10xpkrBI15WpFXuj0vSwcsSgTO8fiULKG7E6+K9OfUdOwbPdCYDpNtVgsQWtNC
	R30v3BbmemOJ6n+ZknmzarcVSAGItSQCCP85MEVIIfpcQoE+AY45ugjYIWWGTHXvYfsDiCyZb/r
	R29DQQBKlzpHKkDp/0TptkwM2zORKZIEmhf5K5Uibo0QYrH51StO05RXJuU3uL/ovOI3HXtiGU1
	GmDAoJ4WC96BMxpvxfGaaEJ2Zyp6nBbWIpP+iQi28sqk72o6et16+QuglhBUOT1G4mpRIm2lplo
	PbXnb/nEMuhf+VxyjmOoxRDiTeiwyE2xeYpS+L3oXomIxDgV6McrwoQA+9jjCVX5KcvQT2+K13L
	m0lkNXPkJyGK/ju3TJ2U0YV8zLRegNrmrGDALTQM6Nigmfo5LjeKOiJ7cEA==
X-Received: by 2002:a05:6808:309f:b0:4a4:744:a4ff with SMTP id
 5614622812f47-4b1e7709011mr939902b6e.4.1786368777312; Mon, 10 Aug 2026
 06:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810103409.133796-1-fabio.porcedda@gmail.com> <annMvEUa7sUvVIfr@gmail.com>
In-Reply-To: <annMvEUa7sUvVIfr@gmail.com>
From: Fabio Porcedda <fabio.porcedda@gmail.com>
Date: Mon, 10 Aug 2026 15:32:21 +0200
X-Gm-Features: AUfX_mxVKhydZDc9mSz7qXovjZ7jMm5XgJfbsYaYFTfSaUt4W52YohxggxigRWw
Message-ID: <CAHkwnC-RM+R08MJtwNr=QFPcA-WT-P8JFaospxF9-YKe-yVsZA@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: qmi_wwan: add Telit Cinterion FE990D50 composition
To: Breno Leitao <leitao@debian.org>
Cc: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 3:07=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Mon, Aug 10, 2026 at 12:34:09PM +0200, Fabio Porcedda wrote:
> > Add the followin Telit Cinterion FE990D50 composition:
> >
> > 0x0991: rmnet + tty (AT/NMEA) + tty (AT) + tty (AT) + tty (AT) +
> >         tty (diag) + ADPL + adb
> > T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D06 Cnt=3D03 Dev#=3D 10 Spd=3D480=
  MxCh=3D 0
> > D:  Ver=3D 2.10 Cls=3D00(>ifc ) Sub=3D00 Prot=3D00 MxPS=3D64 #Cfgs=3D  =
1
> > P:  Vendor=3D1bc7 ProdID=3D0991 Rev=3D06.06
> > S:  Manufacturer=3DTelit Cinterion
> > S:  Product=3DFE990
> > S:  SerialNumber=3D2aa802d2
> > C:  #Ifs=3D 9 Cfg#=3D 1 Atr=3De0 MxPwr=3D500mA
> > I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3D50 Driv=
er=3Dqmi_wwan
> > E:  Ad=3D01(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D81(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D82(I) Atr=3D03(Int.) MxPS=3D   8 Ivl=3D32ms
> > I:  If#=3D 1 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3D60 Driv=
er=3Doption
> > E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D83(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D84(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
> > I:  If#=3D 2 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3D40 Driv=
er=3Doption
> > E:  Ad=3D03(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D85(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D86(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
> > I:  If#=3D 3 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3D40 Driv=
er=3Doption
> > E:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D87(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D88(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
> > I:  If#=3D 4 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3Dff Prot=3D40 Driv=
er=3Doption
> > E:  Ad=3D05(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D89(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  10 Ivl=3D32ms
> > I:  If#=3D 5 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3D30 Driv=
er=3Doption
> > E:  Ad=3D06(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D8b(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > I:  If#=3D 6 Alt=3D 0 #EPs=3D 1 Cls=3Dff(vend.) Sub=3Dff Prot=3D80 Driv=
er=3D(none)
> > E:  Ad=3D8c(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > I:  If#=3D 7 Alt=3D 0 #EPs=3D 1 Cls=3Dff(vend.) Sub=3Dff Prot=3D70 Driv=
er=3D(none)
> > E:  Ad=3D8d(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > I:  If#=3D 8 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D42 Prot=3D01 Driv=
er=3D(none)
> > E:  Ad=3D07(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> > E:  Ad=3D8e(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> > ---
> > Changes:
> > v2:
> > - Add stable@vger.kernel.org
>
> Why CCing stable?

I've added it so it can be cherry-picked into the stable and long-term rele=
ases.
It should be legit for adding a device ID.

BR
--=20
Fabio Porcedda
