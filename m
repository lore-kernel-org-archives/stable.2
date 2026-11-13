Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794549683;
	b=zHXrqowcOOCxmlMKj7+xdMZQK5/1M/TxcN/sw8rroHEiarYL/zbJL2jiH99vlsNet+/v
	 vUFHPD62vU0swK6rY5LdsIX0ipvgqXGMsM9pqiRLwgED5w1o9iFD3zg4sOFVDnc/YjP1S
	 jyPqa3Qi5LJDrdsyMcyy+9VV75ZGvfXpV1hgh2HXoYhZor5Oxn4PZEAzICSwb4BvV0ty7
	 poCU9/+NBQ/yv5siB87Rsjfgoo1AbB47XpM0qEmQxeRKdyzSN0KB7h3q/yfYrzB/dYeWV
	 o1YTmy8BQmRpj0M0qftBo4VouoPbkfB8oPH0p+PM/tnDwFvB0k6Ajk3He56gMn0xS+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0wsol+Mni3pVGty65QPaUG6kYkYqkEsMrdRPAXbVUGE=;
	b=x5Fc69O0TAmRUBGJPPG541vDI1P1BkwqQjLJEfqfA1vfusJUMkkHNFfTh8QLBFsHJKyp
	 ZVgGFxPJx4uxyU0qw6nRWXTfV2uo+bHjdR7LZodWDrAVPSrCfaL+Xd5BFeRLx/kKwoI5l
	 7Lefp635vJT1Gdn1LNB5mT1JfE2thdEsKviY9ri0yaXdLqKeXPaQzXT/w8vu/7g6qIcVf
	 i2W0gmt9iZ1O1GDSdjC36o9iTOWl958uioU/hf0Z23aAB/FltFDV/MJ3MBg4TUklVkn27
	 ekEaJNxOQUgcCR77JidFs1F8jOpNUy6R2csvrJxdU8RmIi3e5+JuxFSLAEdGpj1qc4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="JV5Ui/fM";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2074606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 06:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2074606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JV5Ui/fM
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b30cbfa628so6467657b3.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:01:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794549682; cv=none;
        d=google.com; s=arc-20260327;
        b=Oc54u2c6xwvCHD5Y/NY2wDJg31f5rRREyenbXCrYQG7Uobe/k4IAZWzYnWfwSBy8Gm
         BPuEBRFjL8C1RtR3PVaLYiYADUMWByOGdzKQEHCHz7PzH5XvMi+Z8NdNTrHBuy6xWE4+
         2CjpOQHZiZrnYrOZPZdn5f+u+Um2fKFVYUfAQ+vGdBlaK9m8+cAFIMYaZKxTgnh4Xh46
         7/xyMNTLw+bhwBIMbwWOH6waTGPw3rXWfiK4pFhsaq06Jy761F/u7cX6bXEhn/P11PBY
         RbSJtfLanFhbQnLLPn6nIT7l4oEgACmzot4q+MOyZd/Y4OTVmRWv1sQVfHdbLftjnA5s
         3fDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0wsol+Mni3pVGty65QPaUG6kYkYqkEsMrdRPAXbVUGE=;
        fh=+EEi4MVGc9QooihC9QgFowBKCn/oMw4xrO9bj7IJwyg=;
        b=mk/KnURsI1cuqKbQd4EPQNjN467dznwd9AIzB8R4+6MM5fJheoTbW9yW8VCQfrYULF
         cTaBwckCXq+q8rlZ1dIL6V7po3HcI13MZTGeMnMP1Xu6hGpYZcSGnQfTL2gFdzX/N6cC
         1xmn+1Z4ha70nFAoN+/kdbVB+p3/qXqB9+BbepPwR7II2LSzNoY0VBjJMKAOBfTkZW61
         SqHvj00de8PXQgLBP/R0ylNesH/eRyuNTWxfYsV4x4dIxpzamzY5BXHDeL8xG6guI97f
         w78GuUXvDIYXiyRNmQ2mG6SZn82QvKmVWVXz4NsSGBpXPBAArNCbtYo7KRCIwxZo3afr
         ZxzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794549682; x=1795154482; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0wsol+Mni3pVGty65QPaUG6kYkYqkEsMrdRPAXbVUGE=;
        b=JV5Ui/fMb+EZK4MuX+mzfFOxOk/sGuf81ovXRjwIHWbo0As8IxrbfzlA7h8E7MigVw
         /mGg5KoBLHCj94pd/RG+xDAi/p9HhMw/tFGLHAWKAl2zvtMQ2PJiUTYdfpAIXuDs5We4
         WUQR3EuUT1Iz/duhfVt3OKnSLhXWTbZe0L24JB7FgijjzrrkXv/AUaXzd4OPZ5ynSflZ
         DOzwuXiAf2/xLdHl1cqcCSEvanP+9bkPHc8mSk8VsRNGhOPJ4W89p3yCh1dtlpO6pGLq
         g8Cj1rLjfrBKcG/l8bOnYSikb+DNbR19rNmT6q8ywRboFTHJZM31A3RCtEkvcBiu3cld
         YDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794549682; x=1795154482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0wsol+Mni3pVGty65QPaUG6kYkYqkEsMrdRPAXbVUGE=;
        b=GY0/opkgVZT5gUvkiyRvCh1r+d39xDJ1rBa0QVnrBEdZA3fXl4ql7OE8bsorqb7OzT
         dvYIJZqFk2A5Ymjx7HhgjvSJ7AjCCn/282WGAq5S4GnMb15KPr+tZdXlAu41AYj8Gnr7
         kylw5Qf8Sp2nsOL3eX6uHYO4WBn77y2vQldFFNC4R1H9r4Am/C44b0lGUZOY9pGhw9vi
         JNPATfKwmf3+LlHJhfzWoUwH2t4KLj8lbTbkNn21q/JGpvKV339sQVRF0+TITQpE0rbB
         sRPvxLNhM10z9njgE5JjlKMFGjKutiHBtJKoVHLeAvHQEHGNEhK+1jxON8LuVRQ9EiLu
         rawQ==
X-Forwarded-Encrypted: i=1; AL+hErGqTLBguLTsuEgIy/E6SVnK0DBwrjJIe48RJ3Y601+o2Cfz5dtv68FQDN+Z6xjeSNSKJuaHdJk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/j0Vp4Qyfsh9fL+/7rDmHlkDqZ3Zm49RjsBCkjtcgcldgja5mQ
	9nr7PZ+jWhT9ipt9keRRaTLokmravW/NYJed7VATOPF4SC31Ba2KZk0feyz8hLnP1T7Qqnt2rkX
	BaG1uHGatsz7UJrr8hbEM3sZXdFX83uU=
X-Gm-Gg: AYBFou2Qb4JrEABdv50fNvxjFAcSQ6YE1PVLfypqa0954exlVb4kQ5Gd8yrXdv/QA+l
	IlYlDv0+PZz58KAs/JyfJNdc99x7GuUYa54B/R7j7P9lMeX84rBk8csrBNYKc3ctTiym6U3t9h5
	jP5Goi3/tJOJOxKsfCZMtg2L9XPrHS2nY+5hfnzHx942mFCUAs4RPodBSk173Dj1q6hK6x60JaV
	Kaw8CzMNIVvNImYlNueITJh/tfOAyAucXPSLvnrc6HFv1nEfwJZqVf1Cyf86KEvRhqqufLTUFi4
	bIfvJt8crZTIAoXYC75TYApVWCcrd7259D7LUGiWbX7AAJnnlGTs57pMxhbw7zvgIhKbOafzvVt
	pdYsRB4FnnZVZT7ZVlo+Ma29y2KeF1SDVC8Na9rgGkXrT6DebpNajkPVyB/1Rkyftdwr0cQ==
X-Received: by 2002:a05:690e:484f:b0:67c:1557:7b69 with SMTP id
 956f58d0204a3-67d896b2da0mr743837d50.58.1794549681857; Thu, 12 Nov 2026
 22:01:21 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
 <CAPb1+K2BxnfQ7VUQ15td5f9pVhn-ARSM9EjfOU8WuW72o+cvPg@mail.gmail.com>
 <2f722967b6db0692d4dd4164aff39b62@gmail.com> <CAPb1+K1J2F-=cJF_+Z+RkA+9uLD8-15m3hDv71DSPG47XLJttw@mail.gmail.com>
 <CAPb1+K1pr7wtp-CCE4x4i4HzVkGfpiyXRBdqWJ-fmJpx_-pfqA@mail.gmail.com>
 <CAPb1+K1mmyvipXSx96-j-+zgxeTztLNfYYTuERw0Ykf5WDv9sg@mail.gmail.com>
 <CAPb1+K2NSGzvp5b8_CfRrDK2trD74+pCi_a+OYV4cza++DP=8w@mail.gmail.com> <5252f18157db7e26e27dd3ae2acb5b39@gmail.com>
In-Reply-To: <5252f18157db7e26e27dd3ae2acb5b39@gmail.com>
From: Gideon Heinz <gideonheinz02@gmail.com>
Date: Fri, 13 Nov 2026 07:01:08 +0100
X-Gm-Features: AclHuK_hQ0eMyCKYBJK8TqPVDkMz_GToazsA-5wv3SadGkydCXgL8Hl4QXBPYv4
Message-ID: <CAPb1+K0_UXcaZWvfmhEt4B1AxH71D8hgaEyF0juoA=cU2aT7Hg@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	=?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, Edwin Velds <e.velds@gmail.com>, 
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Thanks! Yes, please add my Tested-by to the input core patch and to
the hid-logitech-hidpp series patches when you respin (without 22/33).

Tested-by: Gideon Heinz gideonheinz02@gmail.com

I will keep running this combination on my G920 and report if anything show=
s up.

Thanks,
Gideon


On Fri, Nov 13, 2026 at 6:39=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Gideon,
>
> On Thu, Nov 12, 2026 at 03:50:37PM +0100, Gideon Heinz wrote:
> > Hi Dmitry,
> >
> > One more result, this time the combination you asked for: your input
> > core patch in the kernel, plus the v2 series without patch 22/33 as
> > the driver.
> >
> > Setup: CachyOS 7.3.4 kernel with only your "Input: destroy
> > force-feedback device on input unregistration" patch built in. On top
> > of that, hid-logitech-hidpp built out of tree against the 7.3.4
> > headers from your v2 base (630059a5a632) with patches 1-21 and 23-33
> > (7.3.4 already has a different G920 init fix, so I could not apply the
> > series to the in-tree driver directly).
> >
> > Same reproduction: fftest holding the G920 event node at the effect
> > prompt, rmmod hid_logitech_hidpp, then exiting fftest. Result: rmmod
> > returns in 98 ms, there are no "Failed to send command to device!"
> > lines at all, no hung task warning, and fftest exits normally with the
> > machine staying up. For comparison, your input patch with the stock
> > 7.3.4 driver took about 3 minutes and printed 12 failures, as in my
> > previous mail.
> >
> > If you would like me to add a Tested-by for the combination (input
> > patch + series without 22/33), please say so.
>
> Thank you again for all the thorough testing and for verifying both the
> input core patch and the updated hid-logitech-hidpp series!
>
> I have added your Tested-by to the input core patch and will merge it
> through the input tree myself. I will also give Benjamin and Jiri a
> chance to take a look at the hid-logitech-hidpp series, and with your
> permission I will add your Tested-by to those patches as well if I need
> to respin them (and drop patch 22/33 in favor of the input core change).
>
> Thanks.
>
> --
> Dmitry
