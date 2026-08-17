Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E973D4133
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974500; cv=pass; b=rngxjNzYkXtqeiCAwYwb0LR5Xi4QborK5Bbi4N5enRPH3wExgh4HhC2abFZmacNKba49d+QF3lkktbRZOMFZIhuIHDf1yROeN7SVP3jvYX5Y8DmaabxPAA5Z57QK2G0hQMMz5jCZOjTty5QwGJSmkC/wSd1nXyJn/UrbMLv3sLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974500; c=relaxed/simple;
	bh=nqI3jg67KA3IMhPePXOc6LbjzHjaub66adXfe4jkGsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oO7qfYitu5F1pwdPK3MGGKFncWnxEL/JZvYLPveC42TDid4IvgNqhiOoXbTKF8fJDm/MTxAW+cpIzlfKg1mvKRWd+D1/LQtk9zT5fwBhjpv4rG1YGc0OmyxlquV0y5eDDqpsp9LAeoJpNbeIScMFKJpTjWKn36c9vj+4XZ3vM6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQx9VsXE; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQx9VsXE"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39ee96f8047so23631021fa.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 06:48:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786974492; cv=none;
        d=google.com; s=arc-20260327;
        b=kRKbrJjVX0UDIlMVEkdxGsUBhZFedVY6M4uh85CP/FBrvRH5hOzC0i4iYnpIn/8b/X
         v/chKqAGCBOOAFe1io/wxIewJHby04CdzhgaFnF4LOC7YIFte2Q5qvGe5buQp1XZ9Eue
         pQmgmBh27YpDItZAjXsqijkUmUO3WR5ALmAUAQGHyyiVoJtOYne2pUd0iiJA+RM91ny3
         njdZCaDl0yNr6VXW0MBXW6Q46JOCq5x3uPo18/ZJDYvY1fxJ3rK/2MjFRWDwfGxdH3HI
         fQBVsljy/UopCEqTOOTZKQSwMO7kzCb3mk4DX41m5dzoj6OBI742b4eC7ThAVyRGTIwk
         2UZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=B7to3S/vyHJi4C50qM1skSCpv39eeSlcQqbFpwDuuSA=;
        fh=O6z/pQ6rOHm4mJ3s/8aKiu0ZUNvmez7h+JKjbwnIadM=;
        b=E0JYAD2oE+Lin3fL0rosi0Sfe8UH9ME5n0E5/laSxFGBTUwvYD0Vspciec3PqccLY9
         5bubuCtJvATO/XvUJoC5JV67nldgSwPvqUkuHaSclYi10t2L8TUKDT5SXgu7Aln2vo7z
         sHsqgBwHyoYdN8SF2bazS1gsVCQCofDd5sQmT7l210uxFPrsKsciFNNvjp6qDlgXs0VF
         5r0p50aHRFpZ4eXA+EMqMs2fsSZhDbu0uDl6Y5H3OmCUEn6M+8Fm5nQZMFDw6BOTyRIV
         hKOQ1jEeMWYrS46p7J8J3A9GtC4k5qwozx9Xq0gzRw39PnfeDU4EVHe9ToBNIAQRGWTE
         g2hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786974492; x=1787579292; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B7to3S/vyHJi4C50qM1skSCpv39eeSlcQqbFpwDuuSA=;
        b=ZQx9VsXEX/UMMykIL14c4AULivEUev6dy906AsNuyVkxHiVMoY3YusNetbghnNVlF+
         LXOms/XNB+J7Rvi/ekD/I/1wu0Vzw5kRzIcbWaUPhcLchrlP/3iHNv7nCE13pVj/oC7C
         N7AOlvH3m1LZmQrvKy4AY6I87o3SouFIcfb9TRuarnU8YoNy6g4nPehsQ4wohUjTV5bh
         UkByC8a4INxijrcNnaCZLuzK/WW+YUVacCQ0R187CKw7GI8LS/NaJNC9aIrV1158YFDG
         Tp5J4ivLwKnqJLncfSkGNbPHSRS+/OKBYWnE9se/bW0J4iSvfr7PUwq9ZgkRyc5tbq2y
         VhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974492; x=1787579292;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B7to3S/vyHJi4C50qM1skSCpv39eeSlcQqbFpwDuuSA=;
        b=Eur7ElVNu7LJkVEdPQBf+f/nVhK1b9PTE+AKEp8LDfKO/GScJtKSCrGpDRyuhGf9yi
         Kd/tEsqwoIPux4BjqqwVeeFVERLlpH9WL/4p9FvUbMTM4qvorsGb3udDO6E48T4tXdle
         mEWBU5+Nn9mS9B2VRrnT+g07VkppIZDd+lZbeKxlShOV6helQjoRtIOlKxgk+WU1uwCx
         NEQfK182XGK1d9wS2BrcuVXBR/49stsnEHvp+hkoudoW+WmBeF+tERc6pfYLnSOpuUQ3
         uOzkq18SFNiG1FPkrHBwmF/wh9/J/4OcW5BOZYIBy++UBRcR2IW2kS2hapo3N9cUcQrY
         UPfQ==
X-Forwarded-Encrypted: i=1; AHgh+RoV8NxJbtErpeMVTJgmeRPdgiYU8fWYKL6Skjm+z5Nve86MW+7uBUj4QSwJCslvUgNwd4YvOGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEs+mrUHTS211yJFR6VTQSln5draYi1Nzt53je0uwu6mvg3yBl
	m1g5gCbqOrCmsdQriF0xJWX1CRYcScr/CzQ6baFev/+E4f7UVTD5x2+noRe6Xons9yswE3efHJD
	ATWmY84Wd+mzBR07Gj/2jardrla5iYuk=
X-Gm-Gg: AR+sD139NKfTHvlxIH7aU8jHEJwAxikDEZIKjQ/nmM/HrdjYp1Xr5f00vFMxcZADDMQ
	bryJi5ITKgajjBzQLi0tOThlzdJjFduBs91LEBkHuOgpjYJDXgshiSPVLqEbRBQ3u2t0nZaNCEN
	/om9AWm49G7jBSZcSAo2DaBZvdjyghCIdLd76hRYHQIHy31Om7u8T/RD1P+rHahNnsgaZd1LPfM
	nJ3s7ZmrJYaivr0aQPpxWB1LAcWtNgWRD0tHfapwN7+vqy3wBJj3QekuRSOiXGSo7OXGmhayQQQ
	E+DVyBYh2rYu3mJEpSmZxPmz0/Ha100FPekm+x86oAGzEzzg7iQW1DuqwtxePRea5U63bYzSb8k
	TwerjnJyLY0/0SB7spPOWME/5
X-Received: by 2002:a2e:be21:0:b0:3a1:3299:4b72 with SMTP id
 38308e7fff4ca-3a132994c9bmr27554591fa.5.1786974491759; Mon, 17 Aug 2026
 06:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <anoYr9H4KojJv-aZ@google.com> <20260814125025.90522-1-gvalkov@gmail.com>
 <20260817-hairy-serval-of-refinement-49039a@quoll> <CADOrJmb3uJPpYR481rB-CnL0A9B_5PQ683XP+Gdis47uihqMBw@mail.gmail.com>
 <9b3b6f29-35a8-4b79-a002-bd0aac5dbee4@kernel.org> <CADOrJmZRBQb9u9oi2m=4iJuKDLVi6HNjOoSurRwE5QKPB_LetA@mail.gmail.com>
 <2f264b09-98e9-4260-b413-97a494ba789f@kernel.org>
In-Reply-To: <2f264b09-98e9-4260-b413-97a494ba789f@kernel.org>
From: George Valkov <gvalkov@gmail.com>
Date: Mon, 17 Aug 2026 16:48:00 +0300
X-Gm-Features: AcwNN1XSM-kUj0y-bm3ADk8-VJqO006hhwhFkIs6frzRNq7J5ZP1Fvf40UVJSGU
Message-ID: <CADOrJmbTyrGGkq+9OJDXCgTa2HvNo8BWxoE6yjafcrOq7WNamw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: wireless: add flag marvell,ignore-regulatory-hint
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: briannorris@chromium.org, johannes@sipsolutions.net, andrew@lunn.ch, 
	francesco@dolcini.it, johannes.berg@intel.com, kees@kernel.org, 
	miriam.rachel.korenblit@intel.com, wenst@chromium.org, 
	rafael.beims@toradex.com, avraham.stern@intel.com, error27@gmail.com, 
	s.kerkmann@pengutronix.de, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, Frank.Li@nxp.com, chunfan.chen@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Aug 2026 at 16:25, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 17/08/2026 15:20, George Valkov wrote:
> > On Mon, 17 Aug 2026 at 14:07, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On 17/08/2026 12:43, George Valkov wrote:
> >>> On Mon, 17 Aug 2026 at 11:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>>>
> >>>> On Fri, Aug 14, 2026 at 03:50:23PM +0300, Georgi Valkov wrote:
> >>>>> WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
> >>>>> from the mwifiex ROM, which conflicts with the platform regulatory
> >>>>> configuration on units sold outside the US market. For example:
> >>>>> - phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
> >>>>> - phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
> >>>>> - phy2 mwifiex 2.4 and 5 GHz, hard-coded region US
> >>>>
> >>>> v1 as reply to v3 in big thread. How tools can parse that?
> >>>
> >>> Hello Krzysztof,
> >>> I apologise, I forgot to add the v4 tag to the subject.
> >>> I have documented the changes between each revision.
> >>> I saw my mistake after sending the mail. But I wasn't sure
> >>> what to do? I will make sure to add v5 to my next revision.
> >>>
> >>>> Does b4 diff work?
> >>>>
> >>>> b4 diff '20260814125025.90522-1-gvalkov@gmail.com'
> >>>
> >>> What is b4?
> >>
> >> Tool used by maintainers and contributors to handle/send patches. See
> >> korg docs (or just google "What is b4 Linux kernel").
> >
> > Thanks!
> >
> >
> >>>>> When the system boots, it detects a conflict between the user selected
> >>>>> region and the radios, e.g. BG FR US, and applies extreme restrictions,
> >>>>> preventing use of 5 GHz and DFS channels. This also affects phy0.
> >>>>>
> >>>>> Add a device-tree flag, which allows affected platforms to ignore
> >>>>> an incorrect regulatory hint from ROM, so userspace can set the
> >>>>> correct platform regulatory domain.
> >>>>>
> >>>>> [1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
> >>>>> [2] https://github.com/openwrt/openwrt/issues/9956
> >>>>>
> >>>>> Tested-on: WRT3200ACM, OpenWrt
> >>>>
> >>>> Not a valid tag, drop.
> >>>
> >>> I believe the tag is helpful because it describes that my changes
> >>> have been tested on a certain device and platform. It's a common
> >>> practice in OpenWrt contributions. My last two accepted patches
> >>> have this tag. Should I still remove it?
> >>
> >> Drop the tag everywhere and instead on the patches which were possible
> >> to be tested mention how did you test it.
> >
> > ok
> >
> >
> >>>> And you cannot even do that, otherwise explain me
> >>>> how did your device execute THIS (exactly THIS) code?
> >>>
> >>> I am not used to your terminology and this gets me completely confused.
> >>> You have not quoted any particular code change, so I'm not sure what
> >>> you are referring to. Here is a summary of the patch series:
> >>
> >> Tested means executing or parsing or using the code on the device under
> >> test. How can you execute/parse/use this code on the device?
> >
> > Test procedure:
> > Compile, FLASH and run OpenWrt firmware for WRT3200ACM.
> > This compiles the Linux kernel along with all dts files and drivers.
> >
> > 1. Before the fix
> > Notice how each radio has its own country:
> > iw reg get
> > https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
> >
> > If the user sets their correct country code, e.g. BG, then global
> > will be set to BG. This conflicts with FR from phy0 and phy1.
> > And also conflicts with phy2 which reports US.
> > Result: the main radio phy0 does not start.
> >
> > 2. With the fix applied
> > iw reg get
> > phy2 does not appear in the list, so there is no conflict with the US
> > region. I can address phy0 and phy1 later in another PR. They need
> > a similar device-tree flag in the board file. The actual driver is not part
> > of Linux. So I'm not sure if there is any place to add documentation?
> > Result: phy0 and phy2 work. 5 GHz and DFS work.
> >
> > I also used this test code to confirm that the flag is set:
> > mwifiex_dbg(adapter, ERROR,
> >             "[%s][%pfwP] ignore-regulatory-hint %u ++\n",
> >             dev_name(adapter->dev), dev_fwnode(adapter->dev),
> >             device_property_read_bool(adapter->dev,
> >                                       "marvell,ignore-regulatory-hint"));
> >
> > [   19.927595] mwifiex_sdio mmc0:0001:1:
> > [mmc0:0001:1][wifi@1] ignore-regulatory-hint 1 ++
>
> You are not responding to the actual problem.
>
> In very simple words, like one or two sentences, explain me how this
> YAML file affected `iw reg get`?

It does not affect `iw reg get`.
I was asked to document the flag there, before I use it.
Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml


> >>> Patch 1 documents a new flag: marvell,ignore-regulatory-hint.
> >>> Patch 2 adds a device-tree node with the radio and the flag.
> >>> Patch 3 skips the regulatory_hint() call when the flag is set.
> >>
> >> I can read your patchsets and above does not proof how can you test binding.
> >
> > Ah, you mean how I tested if the device-tree changes are valid?
> > I have almost no experience with dts. I ran this command before
> > sending v4, and I think it seems fine. Here's a link to the output:
> > make dt_binding_check
> > https://httpstorm.com/share/.openwrt/test/2026-08-17_mwifiex/dt_binding_check-01.txt
>
> This is a make process, so build stage. Nothing related to testing on DUT.
>
> Building kernel (and running standard tools) is not testing, so I repeat
> - do not introduce "tested" statements to commits which is impossible to
> test by the definition of "tested" in Linux kernel. We discuss all this
> in this very specific patch, not some other patches.

ok, I will drop the Tested-on tag for patch 1 and 2.
For patch 3, which can be tested, I need to describe how
I tested the changes, e.g: iw reg get, and print the flag.

Note taken. Thank you!

Georgi Valkov
