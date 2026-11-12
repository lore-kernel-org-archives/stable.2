Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794496797;
	b=Ds5UowxG7xXXv8xMVG8n/lc/76UoLOgR6vACBjOBp5JPfTmaWbtDb68h+e7NSgU8TaJ7
	 qP79BX8rJ10GFuJNlEWIuPigJB3ywzgQmbOjzihCDn5ztsQLKvtK90BAAlhROGD8nYn2F
	 Cx98JMSIdzFCs/kZFkOXgqjA31PHuzzqK3D/7O1SLqLqxvC1ZJq/uTzZxaYBgNCZNdZlT
	 LkIFQAXDTpqKBnT7zDV9W+fZuoMHzoUGoHQKwowsVz0K38UjMqrgsORir5+++bPH1K3d5
	 YDWwDAunpFYl4M4UdH0p8SDiGPVyaIhGo00iTq6h8DNxDMRfNVCW+9RpTHmKgLdZz0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XCU5YMgEOGMwVe29N8gNhg5ChZqSGt6pfW7EISgqdek=;
	b=M5R1QPCZqaZDv7LCNtMF2FkbMUb98z5Kp+uKE5y2RIuqmKTs29pka8kCfPddgUwAXUKq
	 KoclAt2kVf+lV66YEJC6UrbAurzDmX2kd7IwxEoLkGXLWICsIWfbXnFlxR4Kgb2aF5M5A
	 pxqQWVFzjNU4PkeKgivdwP0lbDnLGr/4HBo8akqhbxhTzKLlDafe1LuowlvHX1XK/BOJZ
	 eSW2WvO9up83zF+KtwHPgLDBeWl9Eo69mn+GE+YLIThAjbBUF9I0C4SBe5l8qejcZ/9jx
	 P0p/HW13FeIYcuwO/KtrjrJZl2LJpe/CaNQt78aM/iEdzOb/LfxmhtJqhYYXjTDyMhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H7dcQg+J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533DF60A382E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 533DF60A382E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H7dcQg+J
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so30770635e9.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:19:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794496796; cv=none;
        d=google.com; s=arc-20260327;
        b=LsOS4BcPqIYYyuKBss4rSuT/Bm2NUdqjOhfqL0GrQTas5OUyZzFDkYr0dHpB2PF38j
         hcKE0M6npUbQszIo0xClJZsP/DI3nFj12WOinCuoFiDa/a5n4l/lkJsGa5TsJuUlNwjf
         DRVORvPSmEJSjvfwXKXBUZxOyb3BTEzp+WL4vEPf4My2IWZ/1qIxj2GvLA0XxxBpw5r1
         ztYyiCaTNIS+MTbJgqhFwqEm9FVfFoFF7lEIj1lV7oE3CbJzMDqa9SaGvwQKxO5D/yE0
         YnY8ZEuVc/WCbjh7KmeKFXh7FgPk9AhuU2Gyz9qts0IGDLkqj+k4a2FElZ7zb0EdpDIW
         4s4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XCU5YMgEOGMwVe29N8gNhg5ChZqSGt6pfW7EISgqdek=;
        fh=2jxxX2JGKHEzVH/WWmR/iBxZtTSQrNgKHLtq1j9XVjY=;
        b=lfSyQBPOGo58JcNHnwO+ZTE5R+AD3vtwlHmT3zKLG9DuNt+jO0w1PruVGfDp2QY+4Z
         okf3It1CxD663qKNAu0wEzmlh8x5uzorSP8gEptTAoA+0VHN3nm1g00Dua+cq5E1qpbf
         GnuPDJzL1DwM4t1O1S5JaetjFeQTgYPUjPHz4cPpcOfZPww6o0L+BcFEImkrK1FcskOK
         aTGN61pYX0gIPPAQWJkyFlM9zLwYVi4JXpfWliieblt+rWecaIYKDmxMNpqYX6ABkSQG
         pv1QFnxXiTn9jE16qzjVab7wnib90pPYuj6zxSSWdLjhpuYErfjKftr8ok4rg3fjw7AG
         hU6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794496796; x=1795101596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XCU5YMgEOGMwVe29N8gNhg5ChZqSGt6pfW7EISgqdek=;
        b=H7dcQg+JeXmIUtaBoHOBZEkaRVl7MEvQtQTBpyHbMB2ZB3FXidPoh0FB/5NyyB1soA
         7ZSCH98M5G6uv4ZAw1wS+1I4Dlsu0+fyL3KpPyW2aGFlpxT3AONO3MrJRpN9BcHNBp9F
         7a2CZebhKKJ53YLYTHD6GgN/Lav0R9quZPccjsWUOtDbgO0CGyNDDEHIjhm6Z1ZF9vRj
         rO2SWeDet42ODC9K78dzBKa6reZAebmBvxhzHdKr1wOggPAgohTNm10Gn09V+imLQ5RK
         RvwR+31dnwnoQWkHnqnFvpnPIiKEVimrCk3ybSxZvj16i4HCvob+y3LYB3DGJiCWw+UE
         JJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794496796; x=1795101596;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XCU5YMgEOGMwVe29N8gNhg5ChZqSGt6pfW7EISgqdek=;
        b=pP9RCbteQZkraD64aa7jm8t9Gz6YTjpCyDDxqOc3AYnlt1b7INRoyhqEXa+4ItXiEL
         bn9XTuifU8kXCn3QAY288JFC0rImA0wio4KhYOR3jw5PXPEgtNwAHxfUHpI813Klv/YO
         HH+1GE5RMfKpWpDaUd+b44eMx7td8vD4VeHIJ9U9WaWXHtK59J8FI3dd7EcWYMLPut55
         DCRC0IP608uanG3vuBtAgv5sqUb6eRnJeKkZC81QdPCpNdIKuuJoZdOumOobgLnljKeV
         sCebB74OncD/SbMkIQRilFutAiEWNDIBOzdquj+EA5A0vnDwp4o458wasJo11R7R380C
         GO6w==
X-Forwarded-Encrypted: i=1; AL+hErFqT6CuZtmd5BMXzK4AkftowoLVepGE2Fo9mx1OYXoCOhTulqSgB6A7OTP4SIsGdSuCJax8Nl4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/2ayso2Xh4MEEgQuDvaJxz33muMIMNxZW3gTn22wIF3ULlN/Mq
	jnOcMkasF5Neu/btEWsVNP/jhoX5Shi9a1bK3rwBwPmK/9gE3dID6Qg9oxZk2VEJPpM+aCt7QX9
	iw7ppPNgjK/P0jQCNM6oSNA5TMhD0/ag=
X-Gm-Gg: AYBFou2dptx/Z1n2VXUBHfbHG1+1e0tfPvjgrjJfBhyi9jUM5CpATN+SshSDwy5GcwL
	4y2lSC6AWTxnOh27dlUKnTjeX7XKjAnuciOlsJJkbpsFDHjukR7Z8NPk4jwgzpj0zDRWCjky4JY
	1/QvWp5xOYS2f4SwAe6YjkNq9r9aKy96ib96i2qTVYFqKDUfZDyFAeiczUUyf5xCJ8/SU6NI577
	jjCbwq48XsQ8woqCg/8vo6SkE20wA8a93p67pKQn0/zg+rZ+Onhs4PhQTF9G82QrTDlVtz1E0ML
	WaZKNkHrmUXFkMLO6grKovrgieTQJaiRh5d54CL00GlcDVJZrhfv/tk5TaPGnCp51fhiRNdAqg8
	eZglR8V2efE9C9c2bmpF1T8O8Gog5+IGUM0VCzA==
X-Received: by 2002:a05:600c:4f84:b0:4a1:e92b:ae4a with SMTP id
 5b1f17b1804b1-4ba093b9a3cmr106590855e9.21.1794496795435; Thu, 12 Nov 2026
 07:19:55 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-tas2781-v1-nocrc-fix-v1-1-a769c27f21ce@gmail.com>
 <7cd4c010f13ee085e3aa4396705b6b06ed58f7e1.camel@irl.hu> <504167422048bb8197a1ca3fac079cec9dea1ae7.camel@irl.hu>
 <CAN6p6iiFz-JXOt9iFUPa3x4Aqu2c96=ERf0AMZ6pPVWspd=jLw@mail.gmail.com>
In-Reply-To: <CAN6p6iiFz-JXOt9iFUPa3x4Aqu2c96=ERf0AMZ6pPVWspd=jLw@mail.gmail.com>
From: Mohamed Yassine JEBABLI <med.jebabli@gmail.com>
Date: Thu, 12 Nov 2026 16:19:43 +0100
X-Gm-Features: AclHuK-U1bKsRdqloiglORwVbHTYD3ELvn-XYZ_Olj9JVapFRVasjDHISUDa0vE
Message-ID: <CAN6p6ihogRNOPM4siK=QykMk_XDD_Essf04OW8d5Q52vORNA4A@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/tas2781: Only accept CRC-less V1 data if all
 entries are valid
To: Gergo Koteles <soyer@irl.hu>
Cc: regressions@lists.linux.dev, 
	Cristian Castellano <cristian.castellano@icloud.com>, stable@vger.kernel.org, 
	Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thorsten Leemhuis <regressions@leemhuis.info>, 
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, 
	Sen Wang <sen@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gergo,

Regarding the Q27/Q31/Q58 formats: they are not from any
documentation; I inferred them from the data. Reading the first word
of each entry as Q27 gives a plausible speaker resistance (3.82 ohm on
my Legion Pro 7, 3.64 ohm on Cristian's Yoga Pro 9), and reading the
second word as Q31 gives exactly its reciprocal, within 1e-4, on both
machines. So, for a consistent entry, R0 =C3=97 InvR0 ~=3D 2^27 =C3=97 2^31=
 =3D
2^58.

The V2 dump from the ASUS ROG Xbox Ally X thread (with a valid CRC)
fits the same pattern: r0 =3D 0x3c5f7222 (~7.55 ohm in Q27) and invr0 =3D
0x10f615d5 (~0.1325 in Q31, i.e. 1/7.55).

My guess is Q5.27 and Q1.31, but I have no TI reference to confirm it.

Finally, all testing was done on my own hardware: the original patch
was tested on my Legion Pro 7 16IRX9H, and I reviewed and own the
changes.

Thanks,
Mohamed Yassine JEBABLI


Le jeu. 12 nov. 2026 =C3=A0 16:09, Mohamed Yassine JEBABLI
<med.jebabli@gmail.com> a =C3=A9crit :
>
> Hi Gergo,
>
> Regarding the Q27/Q31/Q58 formats: they are not from any documentation; I=
 inferred them from the data. Reading the first word of each entry as Q27 g=
ives a plausible speaker resistance (3.82 ohm on my Legion Pro 7, 3.64 ohm =
on Cristian's Yoga Pro 9), and reading the second word as Q31 gives exactly=
 its reciprocal, within 1e-4, on both machines. So, for a consistent entry,=
 R0 =C3=97 InvR0 ~=3D 2^27 =C3=97 2^31 =3D 2^58.
>
> The V2 dump from the ASUS ROG Xbox Ally X thread (with a valid CRC) fits =
the same pattern: r0 =3D 0x3c5f7222 (~7.55 ohm in Q27) and invr0 =3D 0x10f6=
15d5 (~0.1325 in Q31, i.e. 1/7.55).
>
> My guess is Q5.27 and Q1.31, but I have no TI reference to confirm it.
>
> Finally, all testing was done on my own hardware: the original patch was =
tested on my Legion Pro 7 16IRX9H, and I reviewed and own the changes.
>
> Thanks,
> Mohamed Yassine JEBABLI
>
>
> Le jeu. 12 nov. 2026, 15:43, Gergo Koteles <soyer@irl.hu> a =C3=A9crit :
>>
>> Hi,
>>
>> On Wed, 2026-11-04 at 16:55 +0100, Gergo Koteles wrote:
>> > Hi Mohamed,
>> >
>> > On Tue, 2026-11-03 at 10:27 +0100, Mohamed Yassine Jebabli via B4 Rela=
y
>> > wrote:
>> > > From: Mohamed Yassine Jebabli <med.jebabli@gmail.com>
>> > >
>> > > Commit 408249089c48 ("ALSA: hda/tas2781: Accept V1 calibration data
>> > > without CRC") only checked the first device entry. On machines where
>> > > the BIOS populates fewer entries than p->ndev, the remaining all-zer=
o
>> > > entries are applied and tas2781_cali_preproc() divides by zero on
>> > > playback open.
>> > >
>> > > Accept CRC-less V1 data only if every expected entry is non-zero and
>> > > self-consistent (R0 * 1/R0 close to 1.0), otherwise reject it as
>> > > before.
>> > >
>> >
>> > ...
>> >
>> > >
>> > > +/*
>> > > + * V1 data without CRC is only trusted if every expected device has=
 a
>> > > + * populated, self-consistent entry: R0 (Q27) * 1/R0 (Q31) must be
>> > > + * close to 1.0 in Q58.
>> > > + */
>> >
>> > Just out of curiosity, where do Q27, Q31, Q58 come from?
>> > I couldn't find anything about these.
>> >
>> >
>>
>> I think it would be good to be able to see which commits were generated
>> by an LLM. This way, people wouldn't have to scour the internet trying
>> to verify hallucinations. Furthermore, it would be possible to see what
>> percentage of the kernel consists of public domain/LLM code.
>>
>> Best regards,
>> Gergo
