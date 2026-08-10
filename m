Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857F03C2796
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369621; cv=none; b=ODiSIoUL3DBHtdpyoMXrOyYmm+71iWpoxORYjkdLEnIAocBOkxCsllfj3SWDmfaD1gUsqlV8lXqLcG9G4SFyeXwXO43fHdm67RwjpkJhsB6MGZFi06V2fCgQ7RtG4mfuZ5W7S0Wulwyf/re12qya1FIMp5vB2Gb7bjNYvJOmac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369621; c=relaxed/simple;
	bh=nGvLBkBDKOaRJg4kSHLzaeM3hbIwICruJFemXkd3omU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=C5IwfOdMD/mflaa0rzKOO59FBr0CHTnBIIsydfAp/Cq9daCdcq4fXU+NbercBp0Xz19pE6WTQt2WogiFmY3Vlo2y+ZziM0XSc6b9QxTkMQ1AjCJtt8FGimEVydYlJUpgwzHtYcrCH/wtq0AEoYsrFaYhEwBIeIYiRwLvsUezN+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU3Ykl4g; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU3Ykl4g"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c16794450aeso238810966b.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 06:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786369618; x=1786974418; darn=vger.kernel.org;
        h=user-agent:mime-version:date:content-transfer-encoding:content-type
         :references:in-reply-to:cc:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VkmuAyNmOKZH0mWQNQTduJMEBCH2vZax1Arre+veBLc=;
        b=MU3Ykl4gy1SpdHXXV/w910+ztPPb7zDY9Nc4HV+fJes77Yo2H/wTlVmLA1uLX7SZ8s
         Z80iuPtP08Ksgtfeyb+1PbgaEOlw3gB7mK5XZnzxxQFVqYVipCiFpc3qJc1FOmvF41E7
         Uqq8DAeFikyUkXnXQcoWiSb1PswlCC3leATmvwiSfFF0SEt5CtyHctLPHLJeFMr6KjKG
         +jhsUz+twOs1CGpqYC6Lmtmw5Abx93/arioKY2TOByEk7nMlNGGK0MdcZiux71T1TG+9
         2m6teyijcu23CGyahoVeDzN98ie3sgO+pgfDFEua1u+M2D+76g/mtRS2I2k8bRrmzhrr
         lAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786369618; x=1786974418;
        h=user-agent:mime-version:date:content-transfer-encoding:content-type
         :references:in-reply-to:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VkmuAyNmOKZH0mWQNQTduJMEBCH2vZax1Arre+veBLc=;
        b=jkR4641Va/8bbKBaKXLUot7hlIlfBiXlLq5cbw3JMaGqYyKLJuSpJ50ezB/GanlWIy
         YH9f38Y3MXe/VWNT/z2LW5Yh5MZ1Rr/pAqR0eUJnPOTxK1QSuM/JLlxsGNZZ2LTptBZ/
         AcWvt7AI6j+YDGpqnLrFlGGsGzQ9eRTy81v/DLbp9WZVCMg2eeLQRLBndYUEdFQal+Hc
         Ae5se20ZMflkeczxRFeubrzQl/xV29QL/i/hHaw1GjBefr72FcbjOEUVvuBIBnjriNcr
         Cv5bnvhvo+YEmTqg7sYD5NslZ5u4DqkO68mXWVcIQdGzeTQSrKwsouelPf4YS6/+2bJi
         RERQ==
X-Forwarded-Encrypted: i=1; AHgh+RpuTy2Jzs3IhMWI02xk8jUJBoCT9I7Buq2FqlL0DyyqgYn81ObeYdeDLGXCbCxOumQU6H6WD48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV8syApARkES0TyxpCAGFPJoy1K/zVV6ssPPMi/T1gQxJfXJa9
	CKZY5mllQaOhUm36Fo7AsrLQZsb8DsTr2IB4yQDKjXy1nHDT4PVJ1Mpw
X-Gm-Gg: AR+sD12owWVYi9ajquyydnG1d7B5ry+eQlcLo8Rzkzvn1YqZUg/akd4yStUqGkDMNh9
	XiGSpSWE3y6t89V6kjsCUmYYYp8dS6z5x9ohCbY1SXWa+oYvycb6dV7Zqwxx7WbgRpQGTunC6oh
	rKqjVIengyiEj8iUUTuX/HNtttKZK7alBxZvWTnachag7MXPHUW6d46GuCacnr/TGSHtkuJXPsP
	PGu3Lrl32VZkhFgboPnAe+x1LtEAPbnGVmQBA274NYegqlNuMTUka+SSQDG+OwwcMCH5579DLBG
	kw9lK4Yax+KYN7rNQOmb0yeGRoGmnGPVrULrpjTjHBtm1CmOqEVjUglFDdh/X1bEXKzDhfaVNNr
	Fpjj4O3siHiYL7NT3f+R9pqsgd0K4sKsLLCJr73hPYnLzV8g1LoTBZ27wF7FQvJCfmGg3I2QUWA
	dMSPx852WyJhx/98tlyPluaK5VsFi6UQzIzE6UXxMi33shNL7XF23n5kec+liTnYwJvEdkFwe47
	Km2ARktDvEuQtB677K426K2/gzYVOt1SXGDGJOv659m
X-Received: by 2002:a17:906:4795:b0:c15:d0b6:495c with SMTP id a640c23a62f3a-c2039e6acefmr2013592466b.29.1786369617351;
        Mon, 10 Aug 2026 06:46:57 -0700 (PDT)
Received: from [10.198.255.130] (polaris.rmrf.org. [70.34.242.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a29a28sm387425366b.7.2026.08.10.06.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:46:57 -0700 (PDT)
Message-ID: <1ae066f5cc91a5e6e043177774cf6ee699a7b2f5.camel@gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable micmute LED on HP
 EliteBook 6 G1a p/n: AD3Q9ET#UUG
From: Denis Batishchev <ii343hbka@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: tiwai@suse.com, perex@perex.cz, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <877blyccxq.wl-tiwai@suse.de>
References: <20260810125209.2014042-1-ii343hbka@gmail.com>
	 <877blyccxq.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 15:41:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-9 

Sorry. I'll double check what I'm doing wrong.
At first I used spaces that's true.

On Mon, 2026-08-10 at 15:39 +0200, Takashi Iwai wrote:
> On Mon, 10 Aug 2026 14:52:09 +0200,
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
> > ---
> >  sound/hda/codecs/realtek/alc269.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realt=
ek/alc269.c
> > index 6b36c730c..ef8beb928 100644
> > --- a/sound/hda/codecs/realtek/alc269.c
> > +++ b/sound/hda/codecs/realtek/alc269.c
> > @@ -7542,6 +7542,7 @@ static const struct hda_quirk alc269_fixup_tbl[] =
=3D {
> >  	SND_PCI_QUIRK(0x103c, 0x8df1, "HP EliteBook 630 G12", ALC236_FIXUP_HP=
_GPIO_LED),
> >  	SND_PCI_QUIRK(0x103c, 0x8df7, "HP Z66 G6", ALC236_FIXUP_HP_GPIO_LED),
> >  	SND_PCI_QUIRK(0x103c, 0x8dfb, "HP EliteBook 6 G1a 14", ALC236_FIXUP_H=
P_MUTE_LED_MICMUTE_VREF),
> > +        SND_PCI_QUIRK(0x103c, 0x8e0d, "HP EliteBook 6 G1a 14 (AD3Q9ET#=
UUG)", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
>=20
> Hmm, it's still with spaces instead of tabs?
>=20
>=20
> Takashi
