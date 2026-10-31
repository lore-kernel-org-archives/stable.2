Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793457221;
	b=2iYJDarrALcAli8nitE39VLFWu+YtpJyZICf1zAnVVrEv1Wz3PNqFYgoTVbkMC6HldSF
	 Q+VuJGoRjwf2vUzSnL3npm4d4SarGe3hdSaxRFhCUCVOXJbkHraMosrGh32XAVhGPij5a
	 jFD6/wK28a2isA3jug1sng7chNvOQuNJKsd4tRELppUrmS4I6rHXT3sEjxSPVQoW/rRGd
	 2Vu40XVVswf2ya4XQkpubb+s+ABhYfnThQ5Pj0fRyU5NnAbeEHZZ8iMnT1WprnxFmqQF9
	 b50rV471+gQ8tb3IfpiEtDY2ppOCCY+raobhP+FauxlLsp/dqmcIkgtjKQ8dP+oV9wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793457221;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=CpmG+w1cUEyYOKO0WqpqNz1n/OIJYn6Xqe9owcdFtJA=;
	b=3l8HmNFsqJPkWzZrxnJZJnamrrm3cC3DNdKzJbSpJmXhd5fyAwrmEigYC88KlYC1Xw24
	 rUjP/PcFknT6ZUE8aFP9frsiCsN6NIcxzFRlNiD86m0jLHeVezsy8IVIRDPtKCDF//WvZ
	 CW/mNuqIcti49RXYQGsKhniqEHh/neIJrP8MzPNh++7+ZIZtMzLxxVk/UACxWZCebaN3e
	 KHgff2Gfksr9IgN4UIc209EbL/lA5H6mLU2ucvTNPeqA4o9bULel8MajQVWdvMPT05GCu
	 1X4MMDSoJpguF7d50Rvm9bpPNkknHHwRDzvCPNpRxPRoV4hCM8iN1dLKcalvonAuNtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sneemgp.com;
	spf=pass smtp.mailfrom=sneemgp.com;
	dkim=pass header.d=sneemgp.com header.i=@sneemgp.com header.a=rsa-sha256 header.s=protonmail header.b=CyfD8fY5;
	arc=none smtp.remote-ip=109.224.244.21
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E08606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 14:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9E08606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sneemgp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sneemgp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sneemgp.com header.i=@sneemgp.com header.a=rsa-sha256 header.s=protonmail header.b=CyfD8fY5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sneemgp.com;
	s=protonmail; t=1793457218; x=1793716418;
	bh=CpmG+w1cUEyYOKO0WqpqNz1n/OIJYn6Xqe9owcdFtJA=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CyfD8fY5IMWwgh5UPs3jM8KoTAMmO/67tg4G43cE0mGf+lr501cFcu+LjPCzFbU69
	 yn+3jS2E3fvHckhfIR3oTWKrFNB6cpX3BDiFITO9O7l8I/xztdtfZ7pVN7LC5diyKy
	 I+bwzVnP9rkFNqXHrym04fu4pHXoygPl7xy/5+J9f8ZDHTKy5AMzEH9wzYg40cviFN
	 +qIxbOvL3+jOksNTIEIdvEPSaDGF2jsqT3kDiJqIr+0s34BJiK9u8vT2duVsaSB6kG
	 t4hvaaIptrzMJxunkOGPIxSL0j0Ik5ZZZXiEJJkllUPoTGjyoGnGEsGFyN4mlQoeAE
	 bosrZTTOch8Dg==
Date: Sat, 31 Oct 2026 14:33:34 +0000
To: stable@vger.kernel.org
From: Hernan Ganzo <gp@sneemgp.com>
Subject: Re: Patch "ALSA: hda/realtek: Limit internal mic boost on HP Pavilion 15 (103c:2164)" has been added to the 6.18-stable tree
Message-ID: <_qThFfZK8-pRf-XOBVpJMZ37PBYmR77II7bWziL9jioxFnQvk4bX3Al5UvTsk-_Da03GdvX5wnwQ_DHMfmmiNcnbHL5qeJl_Oozdo9HBgfE=@sneemgp.com>
In-Reply-To: <20261031133920.587065-1-sashal@kernel.org>
References: <20261031133920.587065-1-sashal@kernel.org>
Feedback-ID: 19666359:user:proton
X-Pm-Message-ID: 1da7e51856c458bde38c598c850b0d061af8c60a
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thank you for let me know.
Cheers
Hernan Ganzo

Enviado desde un correo electr=C3=B3nico seguro de Proton Mail.

El s=C3=A1bado, 31 de octubre de 2026 a las 13:39, Sasha Levin <sashal@kern=
el.org> escribi=C3=B3:

> This is a note to let you know that I've just added the patch titled
>=20
>     ALSA: hda/realtek: Limit internal mic boost on HP Pavilion 15 (103c:2=
164)
>=20
> to the 6.18-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>=20
> The filename of the patch is:
>      alsa-hda-realtek-limit-internal-mic-boost-on-hp-pavi.patch
> and it can be found in the queue-6.18 subdirectory.
>=20
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>=20
>=20
>=20
> commit 58304eaec016fa3fa3a2ff3bc3afe0ac27d19dd4
> Author: Hernan Ganzo <gp@sneemgp.com>
> Date:   Mon Sep 21 21:55:38 2026 +0100
>=20
>     ALSA: hda/realtek: Limit internal mic boost on HP Pavilion 15 (103c:2=
164)
>=20
>     [ Upstream commit 786fb6b3f513937f712db5a9ba6a12cbc6982ba9 ]
>=20
>     The HP Pavilion 15 with the ALC3227 codec (SSID 103c:2164) exposes th=
e full
>     four-step internal mic boost on pin 0x12: nsteps=3D3 with stepsize=3D=
0x2f, that is
>     0, 12, 24 and 36 dB. Combined with the ADC capture gain of +30 dB the=
 analogue
>     cascade reaches 66 dB, and the internal microphone clips on the ambie=
nt noise of
>     a quiet room; the upper two steps are unusable at any useful input le=
vel. This
>     is the defect class ALC269_FIXUP_LIMIT_INT_MIC_BOOST exists for.
>=20
>     The machine matches no SSID quirk and falls through to the pin table,=
 which
>     selects ALC269_FIXUP_HP_MUTE_LED_MIC1 through a pin signature shared =
with
>     several other HP models. Add an SSID entry instead, using
>     ALC269_FIXUP_LIMIT_INT_MIC_BOOST_MUTE_LED: the existing fixup that ap=
plies
>     alc269_fixup_limit_int_mic_boost() and chains to the same mute LED fi=
xup, as
>     already done for 103c:218b. The boost becomes 0 or 12 dB and the LED =
handling is
>     unchanged.
>=20
>     Tested on the affected machine by selecting the same fixup through th=
e model
>     string (snd-hda-intel.model), which bypasses the SSID and pin tables,=
 with the
>     driver confirming the selection:
>=20
>       snd_hda_codec_alc269 hdaudioC1D0: ALC3227: picked fixup limit-mic-b=
oost (model specified)
>=20
>     With that, Internal Mic Boost reports Limits 0 - 1 (0 or 12 dB) inste=
ad of 0 - 3
>     (0 to 36 dB), so alc269_fixup_limit_int_mic_boost() clamps this codec=
's internal
>     mic pin as intended. Note that /proc/asound/card1/codec#0 keeps print=
ing the
>     unclamped hardware caps (nsteps=3D0x03): that file reads codec parame=
ters uncached
>     by design, while the fixup overrides the driver's cached parameter th=
at the
>     control is built from.
>=20
>     This does not by itself make the default capture volume sane -- the r=
emaining
>     12 dB on top of the +30 dB ADC gain is still hotter than this machine=
's usable
>     operating point. It removes the two unusable steps from the hardware =
range, which
>     is what a quirk of this class can do.
>=20
>     Signed-off-by: Hernan Ganzo <gp@sneemgp.com>
>     Link: https://patch.msgid.link/20260921205538.41192-1-gp@sneemgp.com
>     Signed-off-by: Takashi Iwai <tiwai@suse.de>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>=20
> diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek=
/alc269.c
> index bc87062f86da7..10d930d8fed72 100644
> --- a/sound/hda/codecs/realtek/alc269.c
> +++ b/sound/hda/codecs/realtek/alc269.c
> @@ -6707,6 +6707,7 @@ static const struct hda_quirk alc269_fixup_tbl[] =
=3D {
>  =09SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESE=
NCE),
>  =09SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
>  =09SND_PCI_QUIRK(0x103c, 0x18e6, "HP", ALC269_FIXUP_HP_GPIO_LED),
> +=09SND_PCI_QUIRK(0x103c, 0x2164, "HP Pavilion 15 Notebook PC", ALC269_FI=
XUP_LIMIT_INT_MIC_BOOST_MUTE_LED),
>  =09SND_PCI_QUIRK(0x103c, 0x218b, "HP", ALC269_FIXUP_LIMIT_INT_MIC_BOOST_=
MUTE_LED),
>  =09SND_PCI_QUIRK(0x103c, 0x21f9, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
>  =09SND_PCI_QUIRK(0x103c, 0x2210, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1),
> 
