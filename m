Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA503242D9
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781296230; cv=none; b=bUWYPYlENc+8mYpmcL08tUIRjSwmM71/Lx8ym14iVjwUzAxS+ZEhWT6moRRjWP99DuTbT7IO8WBj5vDbBYRBJGWtT+6qXzBBfYT32SU9AIFxWqHhboL3cwNaxJ8m0xKb7yGhmtczBlry4s/7s3SnYMOsU48zjNnuMX1AKgCXk+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781296230; c=relaxed/simple;
	bh=Lt0k7jTl9l5Je/muEANY8WmcYg3cqaLLaJEUOSsDldY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=SNK2SouFRwGZZlQXK3nbfkUCcHB6QTz0lbCThgHXH/TOexER4tj6aVXhr5Oxw2IwPzPOnyVXZHh+iVAd1D3rc2ZCd6xyTpGZvMxX0LEjvTAl1MzAzulW3OknGZUizAiF2GwAlIfU15xhVeR4Y+5ZYBdAhvunznILE/r0noGotbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2vliFHj; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2vliFHj"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490cdae130cso7546765e9.0
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 13:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781296227; x=1781901027; darn=vger.kernel.org;
        h=user-agent:mime-version:date:content-transfer-encoding:references
         :in-reply-to:cc:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8htq1iA3RMdrMAEb9/pJl3QbqhjPj8uKRlayNFVpG8w=;
        b=S2vliFHjQ0WyVNDCV+A6eTsG9B3JMAPFGST8SX8NRhzjG09q0GfP1qcw0Q3jUJhnMj
         djeRNlkP/WCxqgLpAqffcuUTa4NM6Fy9/mVK08yXrs+sXHtoh9vY+yu+EXvmzbkHnJB+
         dFAzl/8tqGVd1Ce9nFFmzOzSVpFGqzlxKVwUSjCtOXTsl5RsvuRW3ni4hJ9kdrzW/fX9
         HmiK5kMEUW9xRPvzzFDMeyOHBZr44FZKMEv/1/KR9myLW4FpLRYNjTDctXwvmxtbEqYO
         A4ceJzSCZnKnejFEZQYuo09QSaTyEYCykcU6u/CdoNlVzcTOEJqhy62OF1Be4Pp9kilD
         dyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781296227; x=1781901027;
        h=user-agent:mime-version:date:content-transfer-encoding:references
         :in-reply-to:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8htq1iA3RMdrMAEb9/pJl3QbqhjPj8uKRlayNFVpG8w=;
        b=FI2qY70hHM4Kg/GDIMDF6KTmvQzFL+dlN3zfdnE85eF88u/0RjgrSmV6aWQ3vnriU+
         T8DrLzs5D8A6UCiFcHR7B9HeAub3rYIuo8jcppLU9m3ZujFW4D2ua7661/0B7aaCK6im
         bAFqEYFOBDJlDCzkiLWGPe3D0nmOTGL2eRqWdm+CcRhwZj3Y38z4sPqVonE+/Gwey8qH
         nRaZdBMZ364J8ZFNMGh2O+Exx67Qh29C67wJR1qgouK4GjboNvPx1+stLNRBIdokyknJ
         3NI4z6sfIkItT376a3J41npwvwxc4yDbNA0a3YaHDeTaVJoSrK76lqWEt9zgnVU0WO63
         mU1A==
X-Forwarded-Encrypted: i=1; AFNElJ/UVluqfVYeoX2iYQqTzNu3sOXeQb5oi1kIerZy8UQb/y1GSSd0rG8LRczOovTzI6u424Fgals=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRtkVQEsCK9VKcSZ2/+pOx9rMxMY4B9UZdYTxJMoelQJwbRX0H
	IeVm/RrGwctpqSCMXK3f7rZaeiVDOZxkvFeobdeWF/S8Lq64iyjZkNN7
X-Gm-Gg: Acq92OGWNR1MKW+d65YqyQ8cgPd/Gq8a/XoX5nIGa9ibQd21p40oT7fkcGBe8xQdZUL
	iP6cw7jLMvpm5yFbSkEEpNg0Dautv5NaK74rXiCPW9n/B4cKfYVg6bmvl7mDJG14TUeU7+9o3ch
	iGOdBSsY7Z0CNWPZjLeve9cKK7jbHRb8Umi4hhayB4ZmYoyAHzkaN7cTOKb5FvUnmv0XDe6R8FA
	qRQ5UlThJSWgXE9Mcu1CfY83SCZcSJBeLAOT+8NNiOE8b/8p1WXKOZC4/NMnuJY+xvi37GmP3TA
	V0iekG/2zdOFZ2R+5yYznnqYooB57WCY81h7hSXtGEbrj5kdiVrOhgphE/s9jcQs7ZnbdDuqUkT
	6pDRsQyqQjxjEsKx73E+pH5EwQOh4LnnjS59Oj5dmPgbhV/cEdPfBPHmdYNsEjIBxjuijtTLMQf
	r4sNE4JAnbGin3kGhmuY8nvZxzSrzlVX43NUhpPOtw1d7u560cSdTpdCqbe3JK1gHimqLQVFKj7
	O/7FHHWbpCo6IxOukMV5yj3G2RYxe1wAiM=
X-Received: by 2002:a05:600c:2d88:b0:48e:7854:1608 with SMTP id 5b1f17b1804b1-492200e24cfmr7047295e9.25.1781296227009;
        Fri, 12 Jun 2026 13:30:27 -0700 (PDT)
Received: from denis-elite6.lan (178-222-30-44.dynamic.isp.telekom.rs. [178.222.30.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203d05d1sm19055385e9.12.2026.06.12.13.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:30:26 -0700 (PDT)
Message-ID: <81d699c6fafb51c3f5d5adc657057706b07d9ee1.camel@gmail.com>
Subject: Re: [PATCH v2] ALSA: hda/realtek: Enable micmute LED on HP
 EliteBook 6 G1a
From: Denis Batishchev <ii343hbka@gmail.com>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: tiwai@suse.com, perex@perex.cz, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <aiggF41W3LlKDts4@geday>
References: <20260604131518.45993-1-ii343hbka@gmail.com>
	 <20260609135607.3960625-1-ii343hbka@gmail.com> <aiggF41W3LlKDts4@geday>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 22:30:20 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-9 

Hi Geraldo,

Sorry about wrong email threading. That's first time I'm sending patch to k=
ernel.

My laptop's SKUs is AD3Q9ET#UUG.
It's HP Elitebook G1A 14" too but with a bit different audio chip as I unde=
rstand.
And quirk is indeed copy-pasted but with different device id.
I can change quirk description string to reflect my laptop version.

Best regards,
Denis B.

On Tue, 2026-06-09 at 11:15 -0300, Geraldo Nascimento wrote:
> Hi Denis,
>=20
> On Tue, Jun 09, 2026 at 03:56:07PM +0200, Denis Batishchev wrote:
> > The HP EliteBook 6 G1a (SSID 103c:8e0d) uses a Realtek ALC236 codec.
> > Without a quirk no fixup is selected and the mic-mute LED stays off.
> > It needs the same ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk as the
> > already-supported 14" variant (SSID 103c:8dfb), so add it.
>=20
> What is your exact variant of this hardware? Also please refrain from
> sending V2 in response to V1: it makes patches harder to track.
>=20
> >=20
> > Signed-off-by: Denis Batishchev <ii343hbka@gmail.com>
> > Cc: <stable@vger.kernel.org>
> > ---
> > v2: reword commit message as was required by Takashi Iwai
> >=20
> >  sound/hda/codecs/realtek/alc269.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realt=
ek/alc269.c
> > index 78a865709635..8eebf91595d3 100644
> > --- a/sound/hda/codecs/realtek/alc269.c
> > +++ b/sound/hda/codecs/realtek/alc269.c
> > @@ -7274,6 +7274,7 @@ static const struct hda_quirk alc269_fixup_tbl[] =
=3D {
> >  	SND_PCI_QUIRK(0x103c, 0x8df1, "HP EliteBook 630 G12", ALC236_FIXUP_HP=
_GPIO_LED),
> >  	SND_PCI_QUIRK(0x103c, 0x8df7, "HP Z66 G6", ALC236_FIXUP_HP_GPIO_LED),
> >  	SND_PCI_QUIRK(0x103c, 0x8dfb, "HP EliteBook 6 G1a 14", ALC236_FIXUP_H=
P_MUTE_LED_MICMUTE_VREF),
> > +	SND_PCI_QUIRK(0x103c, 0x8e0d, "HP EliteBook 6 G1a 14", ALC236_FIXUP_H=
P_MUTE_LED_MICMUTE_VREF),
>=20
> The description string of the quirk seems copy-pasted. Are you sure
> you have the 14" variant?
>=20
> Thanks,
> Geraldo Nascimento
>=20
> >  	SND_PCI_QUIRK(0x103c, 0x8dfc, "HP EliteBook 645 G12", ALC236_FIXUP_HP=
_GPIO_LED),
> >  	SND_PCI_QUIRK(0x103c, 0x8dfd, "HP EliteBook 6 G1a 16", ALC236_FIXUP_H=
P_MUTE_LED_MICMUTE_VREF),
> >  	SND_PCI_QUIRK(0x103c, 0x8dfe, "HP EliteBook 665 G12", ALC236_FIXUP_HP=
_GPIO_LED),
> > --=20
> > 2.53.0
> >=20
> >=20
