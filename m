Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41556329E4B
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377216; cv=none; b=hiHAhUeaWZAdzPleZHpL3ui5LVm+RBuFo5y35DQY4AykcgqtS1h87l0altxNCmg52m+mW3klg/5RgdbgRYiNoLBMtCvBOpyFr4oJ5tfUjJR8NDOTL70A4Ef2qhgSopFL/L6q4eOV0N0lG6g1pY+NVVo2mgiHBBs7qjfyOGlk4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377216; c=relaxed/simple;
	bh=Ro0N5PxSzkcGfaO2q/mC90NvWjxKhBcpNAXq9iivlfY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=KjRgYg2r6BwigMb15W6vANBQPLMaTrPE3ZuTtVIMNb/ZOI/cl8D0O/xvsHbXK4nDxXY1XW5kPb491nO/6Rp12cfQKVpu76OG1GKGTbWuyTf/rjMBrSiXU6u2nY2/+FlMl/CEOnIFoKvJtmJvEyqhOwKmIYVGypROEOO7E8n9n+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT+OA4U5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT+OA4U5"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1600d040e4so4626066b.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786377212; x=1786982012; darn=vger.kernel.org;
        h=user-agent:mime-version:date:content-transfer-encoding:content-type
         :references:in-reply-to:cc:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uZhcRyQnA3+vAWSpQZGi/HC8GMXRR5Rr60F2e5thEwg=;
        b=RT+OA4U5/7tLyre4qZ86ziuaIsqXwkP0Ur9dH1tflt0XuIriW2DUyPXDCfDFPyiw+Z
         L1BFOkg1b8YR0+xyX47osdKB0AWBiT0yAAcCQQmPf3Irn7gKoRneKAoZLHbNApBvkBNt
         MCxUDCXZ6fPherp9DZAB42SG+Cn/VLM0AyczUZ3briCIYjRlKvosaAw6EqubJZ/b7utK
         jaaf0j/dWUwPxxFHXqqe0veKcbZE/C64pS2KDC0IeXK1KIkCmk+Rz+1Rb6y7NHmpQGjt
         NS/uIJv9BU7lr/+rrtlv94ZVi+OJh2O+900u1Q+TsEDkcMT1zOSxlSkNHd1vXuCNN4s3
         MpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786377212; x=1786982012;
        h=user-agent:mime-version:date:content-transfer-encoding:content-type
         :references:in-reply-to:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uZhcRyQnA3+vAWSpQZGi/HC8GMXRR5Rr60F2e5thEwg=;
        b=bfO8pO6ykSObCzG4u1wy+qZMOBdffA6RflaXE7+qILTbSyx26UUJcBZ34DlizbbFXL
         7BoDKysCYu3fBsnYyO8ISsYVd4WPCUuo36YQgRWULicLVV2ay2HPCxzkGu6aWNvdWu3t
         vENOX4AGwedwBR6Stqzhxb6CFbAr9xszz1gJ109H5RF5GI+k0Yp7mE/Dm3U8p6xEsCGF
         9RiP+W8KAgQ6Kbquu4h6ihwcLDwka6GwNLj8jBcQGt0N7H/INdH7Gro3UH8lET3B5QAt
         r591zvPwfCcDJ3XERZmNJcWd4QmAFveaH2h7ZHyDyD/fay4F39LhCZyky85IpRL0CAI5
         RnzA==
X-Forwarded-Encrypted: i=1; AHgh+RrCCPZLwisVAmYGCpw7FJ1QtTHXW77RwFL2REamz3lWNisr9th+/BWvscFdJ3O7thU64qv+UMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIx5ExzBTcHYHm7tNXDYCzEXw9th2xuNFJs06ZjpFME50gUY/+
	Etk6jLbtk8QsNzdAyp8e0O8ekfaE6FXl1fAmmul0+ESmlxcbzPuN2t8g
X-Gm-Gg: AR+sD11a8j0FWMU7OqcobmsEHkrgrwf+IEIkUzS5d0VqPAA1hi93UC0aUpAyNnnLeiW
	yXj6BBDLO4i6mVfn+HlWXOAMB/r2NxFf9UZ5lvnywcgkzo/tTMKEOjc/4Z9MTlZup8tHSKXD+r6
	cysqVfpg0bMvOqyixBgq4a5czaZ3ACWnI9SoDKl9LETXidYYA1Z929E15+gc0b3UKhAHVttGaBc
	ZTspdGvHD1mGqufFFor9KSZt9QXd1uHsNR+YpgrquDJ4DYijI8n3uHqF0bKEXr/3azU+tjw2bhg
	qClzFVlcJx0RxTBYqGncvVBvPzbjmsW9LHsu9WVFTyiMzULGNfk2TPMwECnTncMUx2qBnwezncq
	cJYxnu6cPirNL7MGKXK8tcYLXDNgDSV8h455FIVB+XEQ3V0mE4xIEZ/t5Ogq1pQghegD1HSBTzb
	AWMtREXQ5e31rxwkox17m91+j7Zdy+n6MIj9N+dQJli+fpqCwPSHLtJQIk4yGXVCHiCWW2/jirQ
	joIS0tk2jcLVriLinmUpAN8JBKicrV4+Cx0T+NoYMv0zbEQ/OU4eFXI
X-Received: by 2002:a17:907:a890:b0:c16:aee0:5422 with SMTP id a640c23a62f3a-c208d3d7dfcmr802842966b.6.1786377212359;
        Mon, 10 Aug 2026 08:53:32 -0700 (PDT)
Received: from [10.198.255.130] (polaris.rmrf.org. [70.34.242.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1e7c9d912sm4208903a12.2.2026.08.10.08.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 08:53:32 -0700 (PDT)
Message-ID: <6b68d04721562e51e8d26bfb1450b4f9d9e73d2c.camel@gmail.com>
Subject: Re: [PATCH v3] ALSA: hda/realtek: Enable micmute LED on HP
 EliteBook 6 G1a p/n: AD3Q9ET#UUG
From: Denis Batishchev <ii343hbka@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: tiwai@suse.com, perex@perex.cz, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <87tsp2asuv.wl-tiwai@suse.de>
References: <20260810151440.2306217-2-ii343hbka@gmail.com>
	 <87tsp2asuv.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 17:48:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-9 

Hi Takashi,

Thanks for pointing that out and applying it to for-next.
I'll pay closer attention next time :)

Thanks again,
Denis B.

On Mon, 2026-08-10 at 17:38 +0200, Takashi Iwai wrote:
> On Mon, 10 Aug 2026 17:14:41 +0200,
> Denis Batishchev wrote:
> >=20
> > The HP EliteBook 6 G1a (SSID 103c:8e0d) uses a Realtek ALC236 codec.
> > Without a quirk no fixup is selected and the mic-mute LED stays off.
> > It needs the same ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk as the
> > already-supported 14" variant (SSID 103c:8dfb), so add it.
> >=20
> > Signed-off-by: Denis Batishchev <ii343hbka@gmail.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> > v2: fix indentation (per Takashi Iwai <tiwai@suse.de>)
> > v3: fix indentation, 2nd trial (per Takashi Iwai <tiwai@suse.de>)
> > ---
> >  sound/hda/codecs/realtek/alc269.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realt=
ek/alc269.c
> > index 6b36c730c..bcbdafb42 100644
> > --- a/sound/hda/codecs/realtek/alc269.c
> > +++ b/sound/hda/codecs/realtek/alc269.c
> > @@ -7544,6 +7544,7 @@ static const struct hda_quirk alc269_fixup_tbl[] =
=3D {
> >  	SND_PCI_QUIRK(0x103c, 0x8dfb, "HP EliteBook 6 G1a 14", ALC236_FIXUP_H=
P_MUTE_LED_MICMUTE_VREF),
> >  	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP=
_GPIO_LED),
> >  	SND_PCI_QUIRK(0x103c, 0x8dfd, "HP EliteBook 6 G1a 16", ALC236_FIXUP_H=
P_MUTE_LED_MICMUTE_VREF),
> > +	SND_PCI_QUIRK(0x103c, 0x8e0d, "HP EliteBook 6 G1a 14 (AD3Q9ET#UUG)", =
ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
> >  	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP=
_GPIO_LED),
> >  	SND_PCI_QUIRK(0x103c, 0x8e11, "HP Trekker", ALC287_FIXUP_CS35L41_I2C_=
2),
> >  	SND_PCI_QUIRK(0x103c, 0x8e12, "HP Trekker", ALC287_FIXUP_CS35L41_I2C_=
2),
>=20
> The table is sorted in PCI SSID order, so it should have been put at
> the one entry below; for saving the internet bandwidth, I corrected
> locally at applying now :)
>=20
> Applied to for-next branch.  Thanks.
>=20
>=20
> Takashi
