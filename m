Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DA33B635F
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212227; cv=pass; b=TrvkzUbse05l8RuAAgu/b0FtrbACiH6A2+5ZV23w26BdpAF64lJUz4tQEyG4nJHJXPkhgKtZrg1jL6oQm+7wSU4/dU8qthZ7ut+u3TX1O+pBzME1tNlsfRXH6WcyfURyOXXocbunIubzwrNKCj1Eu7pNZqCJiamYjtoZcyo8KA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212227; c=relaxed/simple;
	bh=/xEwob/gybZt/V2Uua4aPALijOLg3lbe/x/lAhgXJ5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5eIb7CTS34ldCCWRg0hxhaXnY9dxxKJ8B+alhb8u5TAWtK5fepxqspPwFPFfi2Hq9R+ddz5N1eNDU+tJu16UrXC9Tw7n+qg1UXkZeZwWPDoaB3NGbsr2xLbaRb2fYs9umnYmpw+6mag3J5/7p41adf10QX/EHZSVWGJA7Hg6QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+NozPVT; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+NozPVT"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39c8e65e3f5so17968031fa.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 00:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787212223; cv=none;
        d=google.com; s=arc-20260327;
        b=a8bTj/CztG97VHLdYvPSDCWrmi88zTCHGa+1kRVEk/A+3E/08v0mFna5/HfBzVns+c
         F1DkoxOOvZPbUfIFTVbaGQMsXBvxhkesJms4HGQ6ptD/hMQqRjElxCKt6pRoImv0URWi
         hqKjlgUQR4GO9BKzDgSvJhFw/b508b99b2+JsyuFGMeeSDYdoaOKOraxgnqzzip6OmRO
         tQvt8qK4oqPmVIkWxAazB9SlHgw2wlfeKZPq+UA/bUeYd+rRa66lwKfzzjlgX9xvVOk5
         wZscC9wbCahIIaso0gzOa/uVluDZqhhk4xqjcXNd/9vPKL75WN7LqehSWhqoyYd9tNi+
         K+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0TAyv372/LEkCsLr0cT5JC02uRbKUvvVi2UV1V38EE0=;
        fh=Lk0Qb/9i09W+pueB1s5lRZa5DYMnqmZM5+2W2zwTX9A=;
        b=m2GhdQczNRoqPJYdPuMYV1HNjJ+I4mX/2p1cNHv4vQmG9yxbvLliVstx/7lMe/X5oT
         g4Emwi43xp9HItUeYZfNBY3HXe4m9j3x6DeeukKkhqwe0Azsgdgi4qKLNSWbCe88DNKf
         H4gTf+UbiqXVL67UoabwIAVHwwoBAXrKjYGsdDogmM2iiz87h7U8Ja0uzCQqGBRg0GAP
         24jaozIlPT7sy//j2oEuwNsBa3vEmNk5XgoPD2NrkVRmOv/LURVRLEco02BOgSfD+XJ5
         g4ecID3aXK2qShIrQMuaF4u8Y1Bz8XUQKkmMzNFsQhHFm96lhft7zrlSbdYmZNN1S03p
         gVkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787212223; x=1787817023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0TAyv372/LEkCsLr0cT5JC02uRbKUvvVi2UV1V38EE0=;
        b=X+NozPVThnjNcOMBrbFHG4dbjIRWL3hwUxoinz/yUAvk5BcVnYnO+RFqmEIg6O4sNZ
         dV/V0PhANjitd3hWX8YeX6AGcFlG7LkLrs48R8CPDkOeRTqkjCfdNkKg7OFjEzkWabg7
         bHGcfQSSCOTqSL40ew7j/V7YNa+a2sBjZ54c8qlCHFGDyRJx5lcZ0nj0cZ0qWggeGsk1
         T1uOqy/xehSxEeA7enyke3rTS5i47u5Mu5oMWZHC0N2c+MWW6LQX4DFW3P5uhdc+4mUL
         0BoFYC/R5PnkZzHolGT/Swon1fzFDfPoEOt5edA013XiI9L73vWYwbXopEsdCJsG6s5j
         WFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787212223; x=1787817023;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0TAyv372/LEkCsLr0cT5JC02uRbKUvvVi2UV1V38EE0=;
        b=cHlui/TQVEHPNq2F57LZGdEQFlLfKmAuDwyQju/Nm76/4jSnOUWSW163dE1Wh0LLhj
         Bkoh3FIgrPUfU43BQIhBuUg7JQ27QOezWmssCKxoBP+U9SE3zqmCDGKp6wrBaDdHU86x
         BYKcB5HATnMYHDsHwX3se2SlLwT/aKOzJ6VbNLiyjAKpQ0LpgwZw9ryT2oasW1L40PRA
         6/Pc75tSjP5iY1Edx7Ehy71uj/Ki5HoEwWe9QiFbJZywCznV7or/n+zsZND2GQdFwaOH
         J8ndRnQV51CbeeNmiD0nqWKzgp0h4wTKLo3P4cOhLNfO9sxm8Ou8Kq+x5L8VGXNLInQ0
         jQcw==
X-Forwarded-Encrypted: i=1; AHgh+RopCAL+49P8nqbUcR8+C+Er4qJm5QJJQ1YnEL4PPXcee0SKpDY7IwP3YJH9er/Ju0gECpw4+2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT8u5iTppY0lt6x0lbAX+QfbYK+4/gOKfGWtR2i+lP6glvcwYG
	IQfb0WRRfKfSsGkIRjiY+CwvjrzAr6GulaJRpL7B/OVLuOA1HqbN/PnD7iVHO9XYJi9ZRTS8bC9
	T2R7qH7e1eZQasT7dNgunRJvGIPpFiRo=
X-Gm-Gg: AR+sD12+GgwuEqUJtoXIcT3W3Qgw0xx2viZYn0+UwSonDDRIkM7uU1v+VkyrhBwLhSS
	3D7nue8hveRDPaz13ydurIkpCvyxUpR+16Y8i4kN6F0Y7QlGrYiRhmxo7mXl1gYCxKcpPG59KVP
	r7c+HqwmfnnYITND3NHWVAznq3Tgfm10N/kxbKszDEuwfgassut/nGT53/SXe/i7SzBtoXK1B4i
	zJY85zDHaEbil3SDTOR4EAwGq0bIlctCLXs4ETOeaQxdt0w5bLuog7qUgIOw57kaQ7JjfZmFUg3
	W7Aaf9e1S9Ntjq7h9zcBZBjRNdDSbLQnHXUJAq2A07ezgVRjtIFoX/CH3lmSOFMyc/MCkk5cdM1
	rBcq1fdISio9oq1/BVDdZh2xSxw==
X-Received: by 2002:a05:651c:199f:b0:3a1:1d3b:67f1 with SMTP id
 38308e7fff4ca-3a1896d9d67mr21587801fa.7.1787212223022; Thu, 20 Aug 2026
 00:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADOrJmbTyrGGkq+9OJDXCgTa2HvNo8BWxoE6yjafcrOq7WNamw@mail.gmail.com>
 <20260817215428.84740-1-gvalkov@gmail.com> <20260819-generous-nickel-dalmatian-b6bb08@quoll>
 <CADOrJmYfBe3ADun_kFjFSH6YOSTX7Vu3UsFsL57yuRdaQ=eJCA@mail.gmail.com>
 <e554c007-67e3-4fbf-b85e-5de02f649e83@kernel.org> <CAGXv+5H7AhZgZ06r9KO3HLZ9Cymkai+Cv9SgVTuSC1PjgGf8hg@mail.gmail.com>
 <d6c8f19e-f154-4b57-9101-cf3b73e9794f@kernel.org>
In-Reply-To: <d6c8f19e-f154-4b57-9101-cf3b73e9794f@kernel.org>
From: George Valkov <gvalkov@gmail.com>
Date: Thu, 20 Aug 2026 10:50:10 +0300
X-Gm-Features: AcwNN1UED2d-bg9Uini4u4mWy-mvYyG-FuFnU3Li4w7hQPYNR666nZuf3FB7ICo
Message-ID: <CADOrJmYxKTyDkKPaKCpH37RsyyZJZ+4uReE--+uvnHmEdNJVOw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: net: wireless: add flag marvell,ignore-regulatory-hint
To: Krzysztof Kozlowski <krzk@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc: briannorris@chromium.org, johannes@sipsolutions.net, andrew@lunn.ch, 
	krzk+dt@kernel.org, francesco@dolcini.it, johannes.berg@intel.com, 
	kees@kernel.org, miriam.rachel.korenblit@intel.com, rafael.beims@toradex.com, 
	avraham.stern@intel.com, error27@gmail.com, s.kerkmann@pengutronix.de, 
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, robh@kernel.org, 
	conor+dt@kernel.org, Frank.Li@nxp.com, chunfan.chen@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Aug 2026 at 09:53, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 20/08/2026 08:42, Chen-Yu Tsai wrote:
> > On Wed, Aug 19, 2026 at 8:27=E2=80=AFPM Krzysztof Kozlowski <krzk@kerne=
l.org> wrote:
> >>
> >> On 19/08/2026 13:42, George Valkov wrote:
> >>> On Wed, 19 Aug 2026 at 12:42, Krzysztof Kozlowski <krzk@kernel.org> w=
rote:
> >>>>
> >>>> On Tue, Aug 18, 2026 at 12:54:26AM +0300, Georgi Valkov wrote:
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/net/wireless/marvell=
,sd8787.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,sd878=
7.yaml
> >>>>> index 930b700b73d0..5f235cb9f3e5 100644
> >>>>> --- a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787=
.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787=
.yaml
> >>>>> @@ -59,6 +59,12 @@ properties:
> >>>>>      description: Calibration data for sub-band 3 in the 5GHz band.
> >>>>>      maxItems: 502
> >>>>>
> >>>>> +  marvell,ignore-regulatory-hint:
> >>>>> +    $ref: /schemas/types.yaml#/definitions/flag
> >>>>> +    description:
> >>>>> +      Ignore an incorrect regulatory hint from ROM,
> >>>>> +      so userspace can set the correct regulatory domain.
> >>>>> +
> >>>>
> >>>> Same comments, so you just ignored entire feedback?
> >>>
> >>> Do you mean this feedback? I already replied to it:
> >>>>> Anyway, property looks like SW choice. You must describe hardware
> >>>>> instead.
> >>>>
> >>>> I am sorry, I do not understand what you want me to do?
> >>>> Can you please send a diff or a clear description suitable for peopl=
e
> >>>> who have way less experience than you?
> >>>
> >>>
> >>>> Again: you need to describe the hardware, in commit msg, in property
> >>>> name and in description. You cannot tell SW what to do, that's not t=
he
> >>>> purpose of bindings.
> >>>
> >>> I still don't understand what I should do?
> >>> Can you please show me an example of the changes you want?
> >>> Else I'm likely to make a wrong guess and implement it. That obviousl=
y
> >>> won't help.
> >>>
> >>> The commit message already describes the issue with WRT3200ACM and WR=
T32x.
> >>>
> >>> About the description, do you want me to do something like this?
> >>>     description:
> >>>       Ignore an incorrect regulatory hint from ROM,
> >>>       so userspace can set the correct regulatory domain.
> >>> +    WRT3200ACM and WRT32x are known to need this.
> >>>
> >>> About the property name or flag, do you want me to add a separate fla=
g
> >>> for each affected hardware device?
> >>> - wrt3200acm,ignore-regulatory-hint
> >>> - wrt3200x,ignore-regulatory-hint
> >>> - the list may grow if someone decides to add other devices
> >>> - and the driver will need to support all of them
> >>> - that doesn't make sense, because it isn't scalable
> >>
> >> You need to describe the actual problem in the hardware or firmware, a=
nd
> >> then name the property and description accordingly. "Ignore regulatory
> >> hint" is clear instruction to the OS what it should do - ignore the
> >> wireless-regdb package/instruction etc.
> >
> ChenYu:
> > You probably have it backwards. The driver is taking the hint from the
> > hardware ROM, which is fixed and thus wrong once someone carries the
> > device to a different country. I.e. it is a quirk saying the _hardware_
> > region should not be used.

Almost. I bought the router in Bulgaria and I am in Bulgaria.
The ROM hint is US. More details below.


Krzysztof:
> regulatory-hint for me means usually regdb, but even with your meaning
> you tell SW what to do - ignore hardware regulatory information.
> Property should not tell what SW should do with hardware. Property
> should tell what is happening here in the hardware. In this case: what
> is the reason behind.
>
> IOW, why user of a board in country X, where regulatory data says X,
> should have the correct regulatory data ignored?

Because users in X buy a board for X and the regulatory data says U.

Indeed when the ROM regulatory hint is set to US and the driver
reports this to the OS, the wireless-regdb restrictions for US are
applied. This would normally be fine, however the third radio in
WRT3200ACM and WRT32x, reports US on all models including those sold
in the EU and other non US markets. This creates a conflict with
radios 0 and 1, which report FR and also with my correct setting: BG.
With the wireless-regdb restrictions for US, FR and BG applied, radio
0 refuses to start.

Would you approve any of these or suggest a better name for the flag?
Should ROM be in upper or lower case?
I omitted 'in-ROM' to keep it short, because the driver check line is
already longer than 80 characters.
- marvell,ignore-regulatory-hint (current)
- marvell,ignore-regulatory-hint-in-ROM
- marvell,invalid-regulatory-hint-in-ROM
- marvell,invalid-regulatory-hint
- marvell,invalid-regulatory-ROM
- marvell,invalid-reg-hint-in-ROM

Krzysztof:
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets.

I used these flags to keep everything in the same conversation:
--thread --in-reply-to
The documentation states I should always start a new thread for
multi-patch series. Note taken. Thank you for the links!

Kind regards,
Georgi Valkov
