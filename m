Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFC440862D
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787221800; cv=pass; b=oK/g2NJ/nGrcrRgVQnWk5bP+bXVvkMSXskprp1dhpce1UCSgXTAOYTK1/ZJSRIrSRZHcWV42vDchxzsVMpvwy0Zo9OXUz/lM6U9wdwyh5OFYq3ZL0/2I9DqMQnaKHlwRUpES+QHqeHuY3xRtit3F+PRPN8NpzQ9aBzyC+AzGk4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787221800; c=relaxed/simple;
	bh=ilYAz4FnkicbNJ4PjalFroSEFvj7gvAVONxsroYezKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mp/aOZoj9x1/l8FE0Bx7ow1z4kLvSl/cQmhZt7DpgkpsOEgefP7QezG/QUOEfcSFvllme2zVHKE3I6Z8MN2kUCdLiwIbB2JT+vnX9joaXH3lH7kq+7Nty+JzbfE8DBauprFnFq0coVDQFHw7y8sUojocvEFuvJ2CmjDIwxDEHW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQzrHf77; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQzrHf77"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39ca300db70so21383611fa.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 03:29:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787221796; cv=none;
        d=google.com; s=arc-20260327;
        b=by0Gfu8aKt/FU7RtFLJLRj293i/ACReP7NYX/KRl8DftBKanVOhsZDYgo1VHLTqlp/
         oz3FzIlsVPWrdD+7gaFN3E/u+eOESWdUPXICDAbqupwMoX3lspUtOOIiRtCkT0m2SuhP
         eG2gptQxlBOAYh9q2O8GnTir9VPKWI9zpcydsPER2vqgOiCaQR4WFRcc07v27294SgeE
         5bg18pFY+wnQlgedRs1/uTUn3QbVpQBsbQVSJBNpg9UjZgrAEw3j01fDdqHk1WNiPiIp
         fKL281K7agRjJQafdqVEeBXl1IcuWNJnXH6EusmlcxoiZiYgHCqzhAHNK++OitQExDGp
         jn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gHTtDnXZCHKa5y8EGgqexs176ovYBZq6I1x2ikTmc/A=;
        fh=SI/BfW0jQkaFBN0GrijovW6D1l3pyF3Q6txFzC7m35o=;
        b=K/u70wuTnt652s/rP/Yn31Ji0zsmzRG6Aipk88eUMZlsrhqOfcOjNJwg9RlBDudsIU
         P2+30Dg070iJlISbfV8+x13w5Hgyu26DS6R1z4+K7avoW2/n/JfDVNnHX2xVpcOjyWMm
         I/66KWE7L8+8+wP1m4vtc3pJIo9VfJQ3wQUUBELW/QIsVZ1JUICSqgaAHk6QizMdXViF
         5lootqdjLvST3EBeLcPW89lHk7d4k+omOQuIypvr6hZOpH20zrtOLzN/PreTu3BxRh4Q
         +TDtpbWrNWsTHsV2zhahVnOKlNMrNFkO4XervmjvrBudO6U/ttBaT4hoo/oDCS6tlBQ4
         WcPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787221796; x=1787826596; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gHTtDnXZCHKa5y8EGgqexs176ovYBZq6I1x2ikTmc/A=;
        b=dQzrHf77UWW74LrS3gqqEkzgy3KecO6UTzP8+fVaq61CJNiv9qHywqmfHwDlMP8CL3
         D9+4ebWusZKwQqFXVMdk3bfIp9lY8Rar3dsn3UplApmg+67X+9Os9n5v7fmpX3WIU6Ye
         1t3+hv6o5gK1meQG3peayFDTyHLHWT/idgjN3GSWeqnPqjAMYcOtA0sd59Ow+kuiVCbs
         f21mjYCGgu3uu6dzjln37hrSoGaEY2duhX7tiomoBhs4GnD7z2vwjhhNXkN76Q8eSUZL
         ON/pYxL+dP0hcBQ+iAjKglJ04lhXOqLzb7yeYCXwxAhVTfmLEcoJ0JiHJo3JNJfwjw07
         bUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787221796; x=1787826596;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gHTtDnXZCHKa5y8EGgqexs176ovYBZq6I1x2ikTmc/A=;
        b=kRKbbIHM0u72GxaFC3FI/pUwUQy4b2VLQqWJsOxV7eYJnyEofTxUhg/bLMP8CtHQUS
         AqwL+z+PLC6oN3Mx7wpjKF2jp4lqVy/6WNvd1+yEWXmy0DMpEHEE11P2GpFCr9hc2bJ8
         KeT4up/spjGImIdZ3m2U6gv4Hp49b0+x856nzBY6aYZWSTxnylXuFGFtPweH/kK2H0RF
         OkkNhmPYIvlFxdYMpk+avkPNaqWCaIs373N/gZU1y0HfqLXhB2YBJiQI+hSgkHlVZjFe
         TRAjQgDXHIP2ucHAg1p2HKtCTMYar4dzhM22gyIQOiwWIU5Iw8wSFWg0Z6qqRY2g2ibp
         l7+Q==
X-Forwarded-Encrypted: i=1; AHgh+RqkABxCOyyapv8DgxULg+/cbXZHtVJj5EPvQh0ePrXHIhrL9mR0Dm3xSxjwbtx94Z8iJf3R1lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVaP3lJCMCHGtxCxEeaYLuH84317r5ro/enkEt3vdrBMyv08j
	O8z3uKwoR3YHmLxln5X8Q4gvzoiD5uGeMYE3R9ARXxJc/xLR2AvgL352XVJ3NRvdav4PpvsnAYX
	cOub/piPnk48Tyn1b5fEOKB3Wy0jrEjY=
X-Gm-Gg: AR+sD10cR8StLrdb9f9ck4BPyNYVT4ym6PzFw7AEW3aIvkU+E9p3RRIt/tk0oz1+aEU
	JwPCsSBvkhMLmmdQCY+DUPOvvPkyozT1Pd1xhGNw4dXLzLymZYx0UEbJL1rEj4kvDOcBNzOKoT/
	FM5q0nNz+LLo4RTnf1WHJunYW5P41O5k05NT4yJ0t7kcsgn5/DIO7HtWdzixI6+HcpNQgEfEy6U
	X3ZbJ7QWukrdxLILKeR+hoLS8cesQShCvKNH7hEiqOUujfZybR0viVLWBQHs0+EZGb3E+nNsatc
	Ly70sFvP0A/97ocUoe4oP1FvcEJVrQXll3hYW2r1BZkWuAzEZUFfg69ieQF5yXNtPBXD2pqrUq0
	AMtbGB8x7YEYCKz/3sjeNMi4=
X-Received: by 2002:a05:651c:a105:20b0:396:7e66:45ba with SMTP id
 38308e7fff4ca-3a1899c93d3mr20170021fa.8.1787221795510; Thu, 20 Aug 2026
 03:29:55 -0700 (PDT)
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
 <d6c8f19e-f154-4b57-9101-cf3b73e9794f@kernel.org> <CADOrJmYxKTyDkKPaKCpH37RsyyZJZ+4uReE--+uvnHmEdNJVOw@mail.gmail.com>
 <c38cb98e-0746-4b28-b0c9-ce59e8338048@kernel.org> <CADOrJmb8CTkjRFp7OjynfQSFm3fHT87wemUM4X5yJjTtS=C7tA@mail.gmail.com>
In-Reply-To: <CADOrJmb8CTkjRFp7OjynfQSFm3fHT87wemUM4X5yJjTtS=C7tA@mail.gmail.com>
From: George Valkov <gvalkov@gmail.com>
Date: Thu, 20 Aug 2026 13:29:42 +0300
X-Gm-Features: AcwNN1W--3JEaqfbnjrk9l_aNGSOT-_KL7O3smYd-mfsUY6q4R3owlstmMzx5Og
Message-ID: <CADOrJmYdg6_BLdgY3yEDkn5ugBDwUNUyArffrCB7GWJkHqQRwA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: net: wireless: add flag marvell,ignore-regulatory-hint
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, briannorris@chromium.org, johannes@sipsolutions.net, 
	andrew@lunn.ch, krzk+dt@kernel.org, francesco@dolcini.it, 
	johannes.berg@intel.com, kees@kernel.org, miriam.rachel.korenblit@intel.com, 
	rafael.beims@toradex.com, avraham.stern@intel.com, error27@gmail.com, 
	s.kerkmann@pengutronix.de, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, conor+dt@kernel.org, 
	Frank.Li@nxp.com, chunfan.chen@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Aug 2026 at 12:33, George Valkov <gvalkov@gmail.com> wrote:
>
> On Thu, 20 Aug 2026 at 11:14, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On 20/08/2026 09:50, George Valkov wrote:
> > >
> > >
> > > Krzysztof:
> > >> regulatory-hint for me means usually regdb, but even with your meaning
> > >> you tell SW what to do - ignore hardware regulatory information.
> > >> Property should not tell what SW should do with hardware. Property
> > >> should tell what is happening here in the hardware. In this case: what
> > >> is the reason behind.
> > >>
> > >> IOW, why user of a board in country X, where regulatory data says X,
> > >> should have the correct regulatory data ignored?
> > >
> > > Because users in X buy a board for X and the regulatory data says U.
> > >
> > > Indeed when the ROM regulatory hint is set to US and the driver
> > > reports this to the OS, the wireless-regdb restrictions for US are
> > > applied. This would normally be fine, however the third radio in
> > > WRT3200ACM and WRT32x, reports US on all models including those sold
> > > in the EU and other non US markets. This creates a conflict with
> > > radios 0 and 1, which report FR and also with my correct setting: BG.
> > > With the wireless-regdb restrictions for US, FR and BG applied, radio
> > > 0 refuses to start.
> >
> > So if you move with your router to US, you would need to change DTB?
> > IOW, the DTB is per user? This is obviously wrong... What if one device
> > has correct regulatory data written and you ignore it? Why would you
> > ignore it? If you decide to ignore correct regulatory data, then you can
> > as well ignore it unconditionally and this property is not needed.
>
> All radios on these devices operate according to their certified
> region. The firmware for all radios is closed source, locked-down and
> there is no API to change any regional settings or affect TX power. By
> design, the regulatory information for this platform is configured
> from the devinfo partition mtd3:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/marvell/armada-385-linksys-rango.dts?h=v7.2#n106
>
> cat /dev/mtd3
> admin1_passphrase=[...]
> admin2_passphrase=[...]
> cert_region=EU
> default_passphrase=[...]
> default_ssid=Linksys07770
> deviceType=urn:home-linksys-com:device:Router:1
> devinfo_version=20160121.1
> hw_mac_addr=[...]
> hw_revision=1
> hw_version=48SAM203.0GA
> manufacturer=Linksys, LLC
> manufacturerURL=http://www.linksys.com
> manufacturer_date=2017/12/26
> mfg_data_version=1
> modelDescription=Simultaneous Dual-Band Wireless-AC Gigabit Router
> modelNumber=WRT3200ACM-EU
> serial_number=[...]
> sw_version=v1.0.0
> tc_passphrase=[...]
> tc_ssid=[...]
> uuid_key=[...]
> wps_device_pin=[...]
>
> The intent of these patch series is not to make the radios operate in
> a region other than the one they are certified for, that's obviously
> not possible. As described in the commit description, the goal is to
> allow the platform to use the correct region, which is stored in the
> devinfo partition. The hard-coded region in the ROM of radio 2
> conflicts with the platform region and should be ignored, otherwise
> radio 0 and 2 won't even start. And yes this applies to the case where
> the user bought the device in Europe and has configured their correct
> country.
>
> With routes that allow the region to be changed, a user can move from
> EU to US, set the region to US and use their device.
> This is not the case with this model. The radios refuse region change
> so the user should not use it in other regions.
> For models sold on the US market, all 3 radios report US. The platform
> also enforces the US region from the devinfo partition. Even if we
> ignore the ROM hint from all radios, the platform will still use US. I
> don't see any regression. My changes are carefully scoped to a
> particular device which needs them and do not affect any other
> devices.
>
> > > Would you approve any of these or suggest a better name for the flag?
> > > Should ROM be in upper or lower case?
> > > I omitted 'in-ROM' to keep it short, because the driver check line is
> > > already longer than 80 characters.
> > > - marvell,ignore-regulatory-hint (current)
> > > - marvell,ignore-regulatory-hint-in-ROM
> > > - marvell,invalid-regulatory-hint-in-ROM
> > > - marvell,invalid-regulatory-hint
> > > - marvell,invalid-regulatory-ROM
> > > - marvell,invalid-reg-hint-in-ROM
> >
> > The point is that the regulatory hint is NOT INVALID. One device was
> > sold in US with US data, so how could it be invalid?
>
> US devices have no issues, because all radios report US.
> I would love to ask Linksys the same question.
> My router was sold in Bulgaria and radio 3 reports US. Others bought
> it from the UK, DE, etc - same thing. Please allow me some time to
> install a clean firmware and I will post the output from
> iw reg get
> so you can see the incorrect regulatory hint and mix of three regions.
> This will take some time, and I will be left without a working Wi-Fi
> until I recover using UART.

iw reg get
global
country 98: DFS-UNSET
(2400 - 2472 @ 40), (N/A, 20), (N/A)
(5150 - 5250 @ 100), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
(5250 - 5350 @ 100), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
(5470 - 5725 @ 160), (N/A, 24), (0 ms), DFS
(5725 - 5730 @ 5), (N/A, 13), (0 ms), DFS
(5730 - 5850 @ 80), (N/A, 13), (N/A)
(5850 - 5875 @ 25), (N/A, 13), (N/A), NO-OUTDOOR, PASSIVE-SCAN
(5945 - 6425 @ 320), (N/A, 12), (N/A), NO-OUTDOOR, PASSIVE-SCAN
(57240 - 71000 @ 2160), (N/A, 40), (N/A)

phy#2
country US: DFS-FCC
(902 - 904 @ 2), (N/A, 30), (N/A)
(904 - 920 @ 16), (N/A, 30), (N/A)
(920 - 928 @ 8), (N/A, 30), (N/A)
(2400 - 2472 @ 40), (N/A, 30), (N/A)
(5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
(5250 - 5350 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
(5470 - 5730 @ 160), (N/A, 24), (0 ms), DFS
(5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW
(5850 - 5895 @ 40), (N/A, 27), (N/A), NO-OUTDOOR, AUTO-BW, PASSIVE-SCAN
(5925 - 7125 @ 320), (N/A, 12), (N/A), NO-OUTDOOR, PASSIVE-SCAN
(57240 - 71000 @ 2160), (N/A, 40), (N/A)

phy#1
country FR: DFS-ETSI
(2400 - 2483 @ 40), (N/A, 20), (N/A)
(5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
(5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
(5470 - 5725 @ 160), (N/A, 26), (0 ms), DFS
(5725 - 5875 @ 80), (N/A, 13), (N/A)
(5945 - 6425 @ 320), (N/A, 23), (N/A), NO-OUTDOOR
(57000 - 71000 @ 2160), (N/A, 40), (N/A)

phy#0
country FR: DFS-ETSI
(2400 - 2483 @ 40), (N/A, 20), (N/A)
(5150 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
(5250 - 5350 @ 80), (N/A, 20), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
(5470 - 5725 @ 160), (N/A, 26), (0 ms), DFS
(5725 - 5875 @ 80), (N/A, 13), (N/A)
(5945 - 6425 @ 320), (N/A, 23), (N/A), NO-OUTDOOR
(57000 - 71000 @ 2160), (N/A, 40), (N/A)

global: country 98: DFS-UNSET
phy#0: country FR: DFS-ETSI
phy#1: country FR: DFS-ETSI
phy#2: country US: DFS-FCC

- phy0 does not start
- phy1 works
- phy2 works

And my country is set to BG
# /etc/config/wireless
config wifi-device 'radio0'
    option type 'mac80211'
    option path 'soc/soc:pcie/pci0000:00/0000:00:01.0/0000:01:00.0'
    option require_mode 'ac'
    option cell_density '3'
    option legacy_rates '0'
    option htmode 'VHT80'
    option hwmode '11a'
    option country 'BG'
    option channel '100'
    option disabled '0'

Other users report the same:
https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699

You can also search: WRT3200ACM DFS, there are endless comments.

Greetings!
Georgi Valkov
