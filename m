Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793883035;
	b=0OWifo5sTKWnNf2znAGV7hHeeHq+hhN3ejvFoEWK3kNYaQUnMMR6uaRKtOn/q2HnLEYk
	 GBExhPHXEsiTJjKNUwmHwyIrS6RjmyggsjTdw39ZMDnFxE/NWZCDhqun59oowSPi97lpQ
	 FDR/gmZ3OyPGBrzY9SyTI0LzLE+eumj5UwEdm554rsLdVt1BNL+MGPGM00F56GA38JLf/
	 p+LVybqG8d/1A+iycfdCFiKoaCRcyaiY27hd39rL+zpwZEUvOZz5DPTZChmtpy7J/l0dL
	 VI8xjmGjRoYwSqtMleRovLdtL+5uOyURoDZpiuG11oAFr8CLokYLMenylkUJ+MKzS8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fxxRNtZaPILmzYTmPUqnBJD2qtrA6bhJsu6TXNOj87E=;
	b=aJBtKrmM25IM+qrf15C5K2Eh2C1vKbvqP5jxUMclYyKSXWXFCnQXOl/qUzz1kE9cWmAd
	 Tpjs6DulUnl/rMG8djxiq/WH88LL5dSu95qxsW8lYQ3kEZz/+dtsp+KrqWUdW8AloTwgC
	 SMYKFmi5zyvyb+fflbjABvwgcQltgA1rgLwM7tEkIBCc89KlqxpoXjowYnz+wekIZO3cN
	 0ATt5lHRKnCqia4FmENrOaKVeL9WStkCX9U2UWDz8Z11YsUKcJobUd4ujKSZBmJ2ugy50
	 wVsy9ZIaz6moAMDAZa5Wa9eJmIQ28jQn7HeHndAldPGuXTQIjprDcv0LWq4h3qWz2AQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=luxonis.com;
	spf=pass smtp.mailfrom=luxonis.com;
	dkim=pass header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=AaPhrYO0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AFB606D817
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7AFB606D817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luxonis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luxonis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=AaPhrYO0
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so2909984a12.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 04:50:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793883032; cv=none;
        d=google.com; s=arc-20260327;
        b=Chi30Kuot6SbEAcbGU4Mea+W/YQwzXiMgkIbI83UJZYnozgtH7bRcrwH/YpGhFi2aL
         AGvRoUt2KZK69Nb913n0dNDA7QjoFCd++zkHkyjQW7tC9LEWOUMoFcCn+eIgDgNcYBr0
         rA54pZ+eWFWkpauR9+C6+ycY+JtHNPsMop1ZYc7ueD2qUpaKobvPfeUon4U7V/LU4em1
         1LzAF/k/frH+JUCGeXaUH6fJMu1dSvzDAgDahprNgMDHeIyYL+YmZEKNYXytolOXxSQd
         lcMzO0/h6jbk3T5p1jwDdDOMlieds3dF7XcxgP5R+gO3oLhSZ+9Qmh/X2MC7ujOxxqE4
         dN4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fxxRNtZaPILmzYTmPUqnBJD2qtrA6bhJsu6TXNOj87E=;
        fh=NlnP5uLJa0WxL2fK4j5nuRPaHaV//txKeygXnR3oeBc=;
        b=E01AY3fayIL+U19EAU3dANiR9pi+tYYNhE4/L1ernCO4NtGWilyC4KmLFeo7Y2ZXd4
         kJuPG70AnONAFP1gIosdge5IX0/hJ+gLs1fgNhRX+9y9FCUFWhAsZKGixVGwBRLPq5Ac
         6BlpuGBR82W7B6buvIbne8m+K4SvxaQklZxzKl1CLCcOlOGH50cHSy9wcE+5GnsyU+EQ
         i8K+a/gbFvuzgXcWfrIzw9Q7/DHbuuHznORvJU5UoB3mShyW41YHU8TM7YAsc1YB4EpJ
         EumapC1jNgoyUvAMz8Pj2cstMIqKa9zVLAaoJzf/0Yiqi8zEsmLiR1LeBgzwC+9iUZ0q
         E2jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=luxonis.com; s=google; t=1793883032; x=1794487832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fxxRNtZaPILmzYTmPUqnBJD2qtrA6bhJsu6TXNOj87E=;
        b=AaPhrYO0r4u+Q7lIQ1qSS8rg//A/haANyRTxqzSDHNs7Q03zKmtWqm7rlMoajRbBmI
         7cdjypj1nI9ME4l0tPc0b7Ri3I3BIN5ONdDTohhgf6lbMGst/wBW+2L5hHgsV1lMJk4M
         Y4NX9T63xg/3kD/JsepvUbCUttxaXeZ6BOtbdt2eIMLysFDiKSo/AAxIiuDm8Z2LsD5B
         Fvew1vb9VYJM3z5tihBk/Dkn6wkbnq8YyKjMdguAcsS86uhTdbxi48DAkSdhibeb28HS
         Jwdcd2Rw2eHR9zGFveYtdorgxtszrX5NiNgrStV9aSWwN/OB0zxg9SiSXI3jarirxT87
         1g/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793883032; x=1794487832;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fxxRNtZaPILmzYTmPUqnBJD2qtrA6bhJsu6TXNOj87E=;
        b=RVGG7QKQaC4Afc97sU3hfwoSCHnsiRo7sVeSyZe2aX2h7ACbRzhiWkE1eM+lpCSaW8
         1sv+LmppZBJilr4kv+nGgHZFRtbbNPIJ1Vo2neM/d3qVYCexxklqZ78xJzGScHNtLJ48
         7Fo+0xKKgRgTbUakYRypGnmj6fcTVPO86Eor1/wzj+LbJpuf7kct4yrftRsj4AkMmRxa
         PmnNCC6AE09Pe9YdH+ppjn+WApBSV60XbzB4CjzXZHBAdaB8dwb+wub2O/0qd7A1876R
         mZNpezVWIp7jBfirrV+CIZyHXd2iPLDTKJjAOAsJDyRbmyq0kZ6ehI3zyMSV3kko9+50
         KXzQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdpKDHe47S0OtoCSUDE9tJYWY9I3lkXfXs75U8CMFaSq9oue5YuVIdJR92wc65inBRbwG/wkA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Bcab+i9HNTk5OSRqn8ywTO9Pw0M1U6adXH7kWc5CVYrYAcU1z
	/599x9F71HRvxwDXp+9Vav2JyVxQfNn5xAgfRqyjCVVufpyV8Yu2oRz7EyjypoYsoHfbEC+VLXd
	R8vTx7v1J1zqxKEkkcyqdOifBuwX7kPFZp1S3j9c9KA==
X-Gm-Gg: AYBFou11Z6r49e6WAB8OvKZAnV8R3OBIbL9grfcYDfqmfUzsbpgymQWCbvXPVxfh9qC
	5xvzRQ9Dr7cqqv0mVav1pSuaa6u6gSHl2BWY8oR/6oHyB9RTUcmthLFWfpsar1VvPA07rqLpGCf
	8xg15BQKpJT058U2KiwFbyFimVlP1bllzxEYy4OtS/dFqTEy022LKrOYXCQKHvlFmMkV8BRq6O1
	X4cAQJuEamsFav5mjpxTkd5R0Wx4Njz0r763yeMoJIH6o+AQwHv7QV5TtruN3WBgOW82bHj+tQc
	MI1O54OiLvwhGElwcIq6o/vcPz4a4qZsqRf1gP2KqKmPa/6ojDiBRC34vp34xQS1PAuBO/ENhih
	ofWlPiFkC/fJISffaO0DBPhrPvohL1PHnPEsakMtX/hZV5RVHbQSepAHP+cw=
X-Received: by 2002:a05:6402:4510:b0:6b5:8227:f921 with SMTP id
 4fb4d7f45d1cf-6b58227fc0cmr1372938a12.3.1793883032296; Thu, 05 Nov 2026
 04:50:32 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101102720.702600-1-jure.rebernik@luxonis.com> <c2191a11-4148-463e-aec4-c1ffe5c732d7@intel.com>
In-Reply-To: <c2191a11-4148-463e-aec4-c1ffe5c732d7@intel.com>
From: Jure Rebernik <jure.rebernik@luxonis.com>
Date: Thu, 5 Nov 2026 13:50:20 +0100
X-Gm-Features: AclHuK_wIav0SwzrlsNwACWakZrKC3c-OCoeFKk73bmPWBjfnXtYuwCmn4ecdms
Message-ID: <CAD9jT+pAn6S_pFOZnS2ZQc=Hfb7FY6Fdop9J1-N8yHoLvHnHjw@mail.gmail.com>
Subject: Re: [PATCH net] r8169: enable the RxOverflow interrupt again
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2026 at 02:49:53PM -0800, Jacob Keller wrote:
> If people disagree, then I think v2 should just clear RxOverflow only
> for RTL8168h rather than only keeping it on RTL8125 since thats the only
> one claimed to be tested in the original commit. To me, it seems
> entirely plausible that RTL8168h also has this same behavior and
> requires the flag but simply wasted tested with this same use case.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks for the review, Jacob.

Adding Sunil Goutham to Cc, who reviewed 6994520a3328, the commit this
patch fixes.

-- Jure Rebernik

On Wed, Nov 4, 2026 at 11:50=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
>
> On 11/1/2026 2:27 AM, Jure Rebernik wrote:
> > Commit 6994520a3328 ("r8169: disable interrupt source RxOverflow")
> > removed RxOverflow (RxDescUnavail in the vendor driver) from the
> > interrupt mask on the grounds that NAPI is scheduled anyway when the
> > chip runs out of RX descriptors. On RTL8125B that does not hold.
> >
>
> This commit says it was "Tested on RTL8168h."
>
> > When the RTL8125B runs out of RX descriptors it sets RxOverflow and
> > stops receiving. It does not start again when the driver returns
> > descriptors to it, only when RxOverflow is cleared in IntrStatus.
> > rtl8169_interrupt() clears only the bits it read on entry. If the ring
> > fills while NAPI runs with the interrupt mask cleared, RxOverflow is
> > set after that read and stays set: NAPI empties the ring, unmasks the
> > interrupts and completes, the stopped receiver raises no RxOK, and
> > RxOverflow is no longer an interrupt source. Reception stays stopped,
> > and every frame is counted in rx_missed, until another event such as
> > TxOK makes the handler clear all status bits.
> >
> > This was observed on a machine in real use: an RTL8125B (XID 641) on
> > the PCIe bus of an arm64 Qualcomm QCS8550, running v7.2.6. With UDP
> > at 800 Mbit/s inbound and nothing sent by the host, reception stopped
> > for seconds in 13 of 20 30 s runs, losing 5% to 31% of the datagrams,
> > and a single transmitted packet restarted it. To confirm the cause,
> > a debugfs dump added to a test build of the driver showed, during each
> > stop, IntrMask 0x2f, IntrStatus 0x50, NAPI idle and all 256 RX
> > descriptors owned by the NIC. Writing only RxOverflow to IntrStatus
> > from user space, through the sysfs PCI resource mapping and with
> > nothing transmitted, restarted reception in 17 of 17 stops.
> > Reproducing the stall itself needs no kernel modification.
> >
> > With this change backported to v7.2.6, 0 of 20 runs stopped and the
> > worst run lost 0.03%, on two RTL8125B boards. It was build-tested,
> > not run, on this tree, where the single-vector path RTL8125B uses
> > is the same as in v7.2. The multi-vector mapping used by RTL8127 is
> > not changed and was not tested.
> >
> > Restore the mask of the chips that had RxOverflow before that commit.
> > Only RTL8125B was tested.
> >
> > The investigation was done with an AI coding assistant (Claude Code):
> > it wrote the HIL test scripts, the debugfs instrumentation and the
> > register tools used above, proposed this change and drafted this
> > changelog. I reviewed the change and the evidence, and the test
> > results above come from runs on our hardware.
> >
> > Fixes: 6994520a3328 ("r8169: disable interrupt source RxOverflow")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jure Rebernik <jure.rebernik@luxonis.com>
> > ---
> >
> > Notes:
> >     This restores RxOverflow for every chip that had it before 6994520a=
3328,
> >     but I could only test RTL8125B. If you prefer, I can send a v2 that=
 sets
> >     it for the RTL8125 family only (rtl_is_8125()).
> >
>
> I was thinking that it might make sense to only remove RxOverflow from
> RTL8168h, the one that the original change was tested on. However,  the
> original change is not motivated as a bug fix, and I think given we
> *know* it is harmful to have this bit clear on RTL8125B, I think I agree
> with this implementation that sets it for all device types.
>
> If people disagree, then I think v2 should just clear RxOverflow only
> for RTL8168h rather than only keeping it on RTL8125 since thats the only
> one claimed to be tested in the original commit. To me, it seems
> entirely plausible that RTL8168h also has this same behavior and
> requires the flag but simply wasted tested with this same use case.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>
> >  drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/et=
hernet/realtek/r8169_main.c
> > index cd4ebc654dd0..62709160d354 100644
> > --- a/drivers/net/ethernet/realtek/r8169_main.c
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c
> > @@ -6086,7 +6086,9 @@ static void rtl_set_irq_mask(struct rtl8169_priva=
te *tp)
> >               tp->irq_mask =3D RxOK | RxErr | TxOK | TxErr | LinkChg;
> >
> >               if (tp->mac_version <=3D RTL_GIGA_MAC_VER_06)
> > -                     tp->irq_mask |=3D SYSErr | RxFIFOOver;
> > +                     tp->irq_mask |=3D SYSErr | RxOverflow | RxFIFOOve=
r;
> > +             else
> > +                     tp->irq_mask |=3D RxOverflow;
> >       }
> >  }
> >
>
