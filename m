Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84FA2773F7
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 10:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782037475; cv=pass; b=RVw3Uren1cwTLaw4uXEjazPHVZZI5acXT9yZinOF7BhBuFWH0X4K1lOSgSNaSqH7GVJKc0ev+8mUOh8pEFE7gpS2aKmgcGGWJ+d1TjjJDJ2W5x85I9deFkgBhsdO3ZjyFXc7hoScqxMM+wvOUzgaIeJNOFCXUyT+Nx+x9DcE+fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782037475; c=relaxed/simple;
	bh=W4TDKJC+abNfGZZm3nLu3Y9unMh1uoL0yEu61M4eCFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wl66hgkQEWvIeT2GOTYkUmL6Pg4+kv4/LC/wb1YIUFWOsi1l3vA1UCM0x30yG8t6okIZ3mqZ6dvlNktQqtBFNcHgHFM/IkTkHdAlX3Frt3R1lTY8IGDkNW4oi072Ba8lzCZ+w9s+taGVA0vGuVmHkQNS96bRfL9v1n6hgBSo0vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=icKwojMt; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="icKwojMt"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c0b9328c4aso23894985ad.0
        for <stable@vger.kernel.org>; Sun, 21 Jun 2026 03:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782037472; cv=none;
        d=google.com; s=arc-20240605;
        b=bFQvJW46SMMhWpLmeUwqj+asteBXmp+h+MDjtYjnUnaRAkJGp2897DEffibOGjVuaU
         JAEDtCTtCX93jTgfSemOoj1lmoQr5dYXMszUGiSV6MOKkxm1Tu3PesnSK7jQCfR0tFor
         ltCTI04JrVnm8gBdWoCi6GrgaF+Xb8pbWVbuAFBF5RntNDrBpnKGUWEfh0DgYOB6i8F2
         X63hhZ6ZUcaUBhmkjuQkCVFORPqp9VwQ16mGaT03VTYkBvtHa6V0/qSTtVGbYfggiUuO
         iQQ9XscqZT/DfRudNyWtNLEIdOYKzJJjeLmbZnK8xK6aFboepdKLHvjnn0WHwqHEUJhu
         2tFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zPsiAR+MabBF88h2oEH/QhoFjtwrYM0AHuhcbXT9hmY=;
        fh=A7+9PX9Vm3F3K7Iu5aAe32z31ajcDvr4WdQmBvbBKfE=;
        b=cUo7zDbh40SLpPy7IpnGXot7EsfqJIn8IeH9PhR34fjbWFkcjGJY9ViNK1PdDzg8/K
         ldL375HLaeng76hly63+f6XqBjI+PMqi3j/FHGsAGNJ1H0uNgGLpBssOLt65AmYQ6LNb
         6Zl/gSpH5oWPWC06HiaDAZH5jq6kQF5AM/COp4Yg5/AqY7+gC0tk0+5iAofEcF3mJMMW
         jDKbCckFUTIFucnkiJS7ZOQi+UrK82TpQZfrvVajxamQniIV2AtPAF3skE2XeXVcEXg4
         QcDB7RRO7JXvgjUoPN2UMYfubAX4iS0uHyKB5NoaV7w5GYhYz8hZdpv8yX0nr1iLgby6
         vmrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1782037472; x=1782642272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPsiAR+MabBF88h2oEH/QhoFjtwrYM0AHuhcbXT9hmY=;
        b=icKwojMtKvLCnWfqNEEYtNaDWlCdCQYThDMARLyS0dWcH7rfb/jHZHz7bgkAPusGGq
         yTMliHmcn1T6GlOGuvmd12k6lf4qc8+Ymyv0P7vJ7a+a9puj319vCbzCy+4Q7Vyw69wC
         rkrY0jrilc/qp5iC7VnwAAqYcEXH/cM2EpYx86zzAtxrJiE3HhFZ2D7EyKfApEZhpVK2
         CE/+ZqvJ3RuPxqXcZmk0FiK4jLlUqPsfoFuKOM5d70MEABmt8JgxM3EKmWZBNd1Bc2Xz
         GBCkJZgBY1McmNGZ/dvJjABGRT4krI3HEGSSIgLW9z3dju5XGKOwfPzs38fG6HqsOmb1
         JmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782037472; x=1782642272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zPsiAR+MabBF88h2oEH/QhoFjtwrYM0AHuhcbXT9hmY=;
        b=bG7uQU3gwK4mDfGyWU/0WuQSDd6aJwl0Cdg8XFd+uZqEHvHu9aKd6L+qFGNTS8usxQ
         vDktc1D20vDrPijLRYXTvr7b3VgdvcbtTvqqRzqAKevGRox782eFRqN5gA7aZpbwlRzB
         ssurTRBsUx8zRUQEgUJ7YoSydFpwY84HYYZ1HdnRoQM5gHW3sQ3rpXeVfpPjjH2izCgR
         SpALnzbKCIpUXDOzMNyX4JVhd8ojAKAXLgmVqDi4zxNJv8UeJ9Ws6WiAI0dXPMD0+Q8O
         9EyDt5nyn+o7ExqR2/SWkUh4F8qT4PqiPbMrHbuixJPDMaqPw4Mjw+Yb5B6nUvJNn9rh
         5R/w==
X-Forwarded-Encrypted: i=1; AHgh+RohcxIMRitSzck1aJLB3G6+SAiPk89mO1QXChCccbi2odCLMouj/5FNFBXrNdLppYKZD0KNpOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsNUGMSaIvvViLyfGDQ1m0rCkbBl/uFwuPaYaVeMLzliGLuSfA
	59krfKcbIeBIKo5IjYgMjdxmfxJxQivM72hbJHbTqLaTPU/KSlb2phCC8DDmqfOLqyEYSDH8fw9
	DdNNPWAxkINGN5urRR2n98PUk6B3Ce6wCpk8CMQNsc4o=
X-Gm-Gg: AfdE7cnkvfBZ6CyTGJGzokSVlaeWwYru3rbqdH0nM2czkmncJRCX9iHdafNYrCFwU3b
	OXEr8fsUKLREX5zL2wpmt2VGcgxfpTPD9dlkbXt+jM/uA3dnsh0xIiyUnm/DCjHeGyFWfX0UCX7
	HrW/jM95ljstjnNEiDwQIEuEjqPU1tnH1BUXTEdEQZbrGLd6h9nMCLPauyRv9Da8bQ5M1ZyfQ+q
	T7ryc3GYTyRKJnPymG22rccO71zT1ez8kAQSF14oSQgLqVBM/CYgnTxT/ltI/3TfDT6H5cHBP5+
	ygQA/IIwjoGeW8GkuMLUndBXOG1TAHx2aa/5mfEJ3ELw/62mcVqXLOHG40mLadgM1X5cZCQ=
X-Received: by 2002:a17:902:d504:b0:2c2:8659:da2c with SMTP id
 d9443c01a7336-2c7425d58aamr62923065ad.14.1782037472081; Sun, 21 Jun 2026
 03:24:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619224818.90751-1-doruk@0sec.ai> <a2bc98ef-fae5-4309-9066-452ee780fe04@gmail.com>
In-Reply-To: <a2bc98ef-fae5-4309-9066-452ee780fe04@gmail.com>
From: "Doruk (0sec)" <doruk@0sec.ai>
Date: Sun, 21 Jun 2026 12:24:21 +0200
X-Gm-Features: AVVi8CeckJujpZJhDYoPnHubcpdWngVVOyJ4MNG1v7vRWrdv_xCClmX7LhwOXUc
Message-ID: <CAPdMp1oWXvtdvp8D0f32vpvzGa0H9PhprQcACqqoc4Gnyy=f6A@mail.gmail.com>
Subject: Re: [PATCH] wifi: carl9170: clamp command response copy to the read
 buffer size
To: chunkeey@gmail.com, chunkeey@googlemail.com, johannes@sipsolutions.net, 
	jeff.johnson@oss.qualcomm.com, tristmd@gmail.com, kartikey406@gmail.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian
sorry for the dup, didn't see Tristan's version; feel free to ignore mine :=
)

cheers
Doruk

DORUK TAN =C3=96ZT=C3=9CRK

Co-Founder


0sec

Universit=C3=A4tstrasse 33

8006 Z=C3=BCrich, Switzerland

www.0sec.ai | doruk@0sec.ai | Linkedin



On Sun, 21 Jun 2026 at 10:17, Christian Lamparter <chunkeey@gmail.com> wrot=
e:
>
> Hi,
>
> On 6/20/26 12:48 AM, Doruk Tan Ozturk wrote:
> > carl9170_cmd_callback() copies len - 4 bytes from the device command
> > response into ar->readbuf, which was allocated by the caller with
> > ar->readlen bytes. When the firmware/device returns a response whose
> > payload is larger than the requested ar->readlen, the mismatch is only
> > logged (and the device is restarted via carl9170_restart()); the code
> > then still performs the full-length memcpy(), writing past the end of
> > ar->readbuf -- an out-of-bounds write driven by an attacker-controlled
> > (malicious/compromised) carl9170 USB device.
> >
> > Clamp the copy to ar->readlen so an over-sized response can never write
> > past the caller's buffer. A response that fails the length check is
> > already discarded by the restart, so copying only the buffer-sized
> > prefix changes nothing for the valid path.
>
> This is contested territory.
> <https://lore.kernel.org/linux-wireless/26e33fea-c81e-48f4-a058-4b3bf0dc9=
5c5@gmail.com/>
>
> Original patch (as part of a series is from Tristan Madani)
> <https://lore.kernel.org/linux-wireless/20260421134929.325662-2-tristmd@g=
mail.com/>
>
> Yes, I do think each came up with the patch individually. But I have no i=
dea how
> this works with three authors / tools? Does anyone? I don't think this wi=
ll get
> any better though.
>
> > Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
> > Tested-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D5c1ca6ccaa1215781cac
> > Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend=
")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> > ---
> > Verified with syzbot via "#syz test" against the public C reproducer
> > (Tested-by above); I do not have carl9170 hardware locally.
> >
> >   drivers/net/wireless/ath/carl9170/rx.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wirel=
ess/ath/carl9170/rx.c
> > index 908c4c8..897e682 100644
> > --- a/drivers/net/wireless/ath/carl9170/rx.c
> > +++ b/drivers/net/wireless/ath/carl9170/rx.c
> > @@ -150,7 +150,8 @@ static void carl9170_cmd_callback(struct ar9170 *ar=
, u32 len, void *buffer)
> >       spin_lock(&ar->cmd_lock);
> >       if (ar->readbuf) {
> >               if (len >=3D 4)
> > -                     memcpy(ar->readbuf, buffer + 4, len - 4);
> > +                     memcpy(ar->readbuf, buffer + 4,
> > +                            min_t(unsigned int, len - 4, ar->readlen))=
;
> >
> >               ar->readbuf =3D NULL;
> >       }
>
> Regards,
> Christian
