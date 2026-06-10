Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4717B44CAC9
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106398; cv=pass; b=PLf9pmdh07TfdBljN2mcA9ofdtA1aXPRuDF0pm7ZGv/Vt89kJqWDqX9i62eZQyzNj7uCNBBXmeAWcodeC8VM9Xe5Wi1FY8DbyXN6Lp1Uc3xLClzV8Gqz86ihanvUpeRA0Bv3QQMGuMGgQulLt2gTL+GQt189M8PhMYP6a1hK6yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106398; c=relaxed/simple;
	bh=LlejGVeNf9MQGP7Vy3nqTh4i/eTPk2UsDb5dGTTrY+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPzH8nnrjCqNzlqem2BH1wKT+GMhFATY0UGBcRFCoe98++5mC4hG4aOwYcX0XF1lkL0JLVREETLlNTQ2SmbwxR0Dw74z2pxJimaumE1+P3qToih2ekwih1DIyexaVX5Ehy/ifa+H1naZO4XotMzLJwLZN2HjFgnca3tHCNW5UBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIrA328K; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIrA328K"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490cdae130cso24069155e9.0
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 08:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781106390; cv=none;
        d=google.com; s=arc-20240605;
        b=Gl/cWcmSY4x006eZM4cd7FzQrMbAXZdZApeFpWK+5olOjEvaO9TzZOafSQI9fBDCOC
         rRG+0aDbQnCw3Zkv7q/kBiBksiYzSb1XKyBKgViJXBDky5mdSX+CztbOgOKOmUAb+yRZ
         Dvjsf0H/b4CqV1iqleCix1RjCYbIOKWV9nbZV8stfQQ7eQ6dFzYQE1VGJiSCkxsIpHhG
         5DIKa18Q2HyDmJ1aK5Yz/m2msnLCrCgpqo98RI+6SoxLIH/FAsX9DmGljUj/90EwGj3j
         OZXegfH1Ad78qE4WkPhXZGnmv8KD1LAGMZE09AeWZ9A4YxZvvft0ijW1QtY83QxqGyyf
         8NYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XqG4ljBRMg6T+iBhzxWIdZtfPAihqeidlqyYpKSsuio=;
        fh=KizBRK/oUYfdm52gcHMYWa2n6lnlucwx3wuqbm287H8=;
        b=i+Up4IKNTB7nThYYHpxJ8+P+wJcA2+/48nyuPBJiitAfgkP8r5HjsnQcnZyZntIkxi
         ospJvLBG8BReJMbJ3jnmOGN3Uq8lHgj1TTQejPYpXNrrf6RxMFj1CBWEK6BMUw2dm0Hl
         dMjjdcMfffGSjWorUGf/pBLuB/gjgepmXt3vS1iWWo7PFg6Wyi3tEtJwdFQyv2crgl7s
         NXMzKW3DkfV2ubxc3k/gkHzO7bwb0Mw3867zn4welyNK9dC1SAX417gRoz8lT8G0QWN0
         OAu215rS6r4paRUxSoegdqK3+lEa9Bp94mdcZwXn7H+hZvX378BlOx0XjWAMpFBpeHx4
         t+4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781106390; x=1781711190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqG4ljBRMg6T+iBhzxWIdZtfPAihqeidlqyYpKSsuio=;
        b=UIrA328KJJ5thGMbSB/tZ7y88EyGTbWj3TSMy6ls04PM0wNq0ptS3G6B1DZcWWY64D
         GHK/49b+J0Ops8ny99z1EAd4LUIuUkWly2c1lXXWjhzjoyO+KWrukoUP5bQasU4gZyAQ
         SBPHK3gJc1N3ASRZxkS4L8ly3nPivAaW+JL10HoFti84aBYDHQ6h0EbvE0snbrz7rm6m
         vIxPtlVa7dD9qi63IRH5XELJPlZyzws9OYMgd2Y1hkvjeV6TELD0bh5v/Hb9yngJe22u
         kxx2KQokrpZ/yeNuZGiwI7ZAC4I4ZKfbPZivUm+GtVVi6uDbOTVAgeF4XMzZT4mpyV21
         /+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781106390; x=1781711190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XqG4ljBRMg6T+iBhzxWIdZtfPAihqeidlqyYpKSsuio=;
        b=E3WPBGHQrdoK7AxwYTi6y0BIbcBWBGjTI630SMmd94hZPAE8z7cZD3cYugw5Kohra+
         ebZlh/EeCz2sofb7AxiwBjIEtQT98hpyMkewqgOWrmeitgN+fy2X87M2/rn6rGcxWZAL
         DrCrnlDOE2bAgQz1BPYhEQMGzuEj8HoWdpKXhYLi9TAf/OfuSQrA3Gd9Z3X4t337BZUz
         +jaQTBTgNRjsIveEqkDXMsBQJv8lsmyTIjGqFxLvbmMPyoW5kpbs+u7vTxBdP9jAfaUd
         BwbQZLz3MsYWynLqWcDmbqk7vomTAexhMQXEHTUaKpyNcA9u8ef90cH/JWYV4DWnn9F7
         VZJw==
X-Forwarded-Encrypted: i=1; AFNElJ/YLeZrDrMiqveXDVhI2plepQt2mug6lZDZ6H5ZTd7HI0r0gDytAbGijXmgSCOe/ajlQJubB84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+dQdTd8lJhbAQibfJpIoS5sMbh2U02lU1GTXazfySWu/0/WDP
	zPEbhgKz3v8qQ82uuSSu4Vm4hImtU+bvmrbU1ZVGbmmRLGsgsC05hOPCXMjopB8I6yneb7cSd1a
	vl2XnlJWVPxUx8BLLF0V/gOY5WDCwbIs=
X-Gm-Gg: Acq92OFsfvg60XGzyzgmdEZpvbWJUQfPsA+Gs7K85Fg4k6zT4nuVJxPbcfOcG87kFL6
	LDiZYww7cyArENaVoO3HX42vpJjzL7KczI8xYnvHu9PelhV4djFJf28unO8XJhNPihJX2e4xyti
	Ue591Fz4QWGcwDzWslaAzh8DHG9VuvCMEXsdvZ558BS0/DGLhSKiu+nAzuZb4ejPXgse7ae5HK7
	69ah5s3T2LajpzO32beMrrQMg8YIfNNafkyHJeKT8+5vZ9x1pOhNs5qrI+N9xysFvEYPgGjXw5G
	6GIXstIjD/abCG11bFm9fHbx2TAztds=
X-Received: by 2002:a05:600c:8b0d:b0:490:b9ce:a73c with SMTP id
 5b1f17b1804b1-490c55662b1mr421764765e9.31.1781106390156; Wed, 10 Jun 2026
 08:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607170959.823755-1-jt26wzz@gmail.com> <aiaTZCQLWy-96M9O@u94a>
In-Reply-To: <aiaTZCQLWy-96M9O@u94a>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Wed, 10 Jun 2026 23:46:18 +0800
X-Gm-Features: AVVi8CcoLtFn4ZVY2bNQmeRdbugLd8hTbDX-gKZVn4sspRD8xZt4FZSBjUYoMz0
Message-ID: <CALgi0X=aCS0kxLgqkoOXzwLh_2eNP14BvDk3TCciQP1bFpH5xw@mail.gmail.com>
Subject: Re: [PATCH stable 6.6.y v2 0/3] bpf: backport scalar not-equal
 tracking fixes
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	eddyz87@gmail.com, stable@vger.kernel.org, mykolal@fb.com, tamird@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shung-Hsi,

> More importantly, 'bpf: make the verifier tracks the "not equal" for
> regs' does not address root cause of the issue, it merely mask the issue
> by making the two states different enough that the two is no longer
> equal, which works for the Rust specific case you have, but won't work
> if the value was slightly different (e.g. "r0 =3D=3D 1" followed by "r0 !=
=3D
> 1").

Thanks for spelling this out. I now see that I did not fully
understand the point behind your suggested bpf-next-with-d028-reverted
check.

I was treating the not-equal refinement and the linked-scalar precision
issue as two ways to break the same failure chain, and chose the
d028-based path because it was smaller and easier for me to reason
about. With the `r0 =3D=3D 1` variant, it became clear to me that this only
fixes the zero-valued branch shape from my original reproducer, while
the underlying linked-scalar pruning issue remains.

> Could you give backporting the full "bpf: track find_equal_scalars histor=
y on
> per-instruction level" series[3] a try? For 6.6 it should be doable, and
> hopefully for 6.1, too, but not too sure about earlier ones. If you prefe=
r I
> work on it I can also give it a try later this week.

Sure, I will prepare v3 based on that series for 6.6.y, and then work
on the 6.1.y adaptation separately.

I tried applying the series starting from 6.1.y and still hit some
issues that need adaptation. 5.15.y and 5.10.y appear to need more
surrounding verifier changes, so they may be harder, but I will still
try to work through them. If I run into anything I am unsure about, I
will raise it earlier.

> As for the selftest, it would need to be send separately and by itself
> to bpf-next, and picked up there, before it can be backported to stable.
> I suggest you look at [4] and have your test placed similarly, and
> mention that your test specifically test a Rust/Aya pattern.

Thanks, I will send the selftest to bpf-next separately. I will also
change the test to use the `r0 =3D=3D 1` / `r0 !=3D 1` shape, so it covers
the broader linked-scalar pruning issue instead of only the original
zero-valued case.

Thanks again for the detailed explanation. I have only recently started
digging into the verifier implementation details, so this was very helpful!

BR,
Zhenzhong

On Mon, Jun 8, 2026 at 6:11=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com>=
 wrote:
>
> Hi Zhenzhong,
>
> On Mon, Jun 08, 2026 at 01:09:55AM +0800, Zhenzhong Wu wrote:
> > Hi,
> >
> > This series backports two BPF verifier scalar range-tracking fixes to
> > 6.6.y and adds a selftest. It fixes a verifier state-pruning issue wher=
e
> > an impossible linked-scalar path can be kept while the real success pat=
h is
> > pruned.
> ...
> >   15: (85) call bpf_get_func_ret#184    ; R0_w=3Dscalar() fp-8_w=3Dmmmm=
mmmm
> >   16: (79) r7 =3D *(u64 *)(r10 -8)        ; R7_w=3Dscalar() R10=3Dfp0
> >   17: (15) if r0 =3D=3D 0x0 goto pc+1       ; R0_w=3Dscalar()
> >   18: (bf) r7 =3D r0                      ; R0=3Dscalar(id=3D1) R7=3Dsc=
alar(id=3D1)
> >   19: (55) if r0 !=3D 0x0 goto pc+6       ; R0=3D0
> >   20: (67) r7 <<=3D 32                    ; R7_w=3D0
> >   21: (77) r7 >>=3D 32                    ; R7_w=3D0
> >   22: (b7) r1 =3D 1                       ; R1_w=3D1
> >   23: (55) if r7 !=3D 0xf goto pc+1
> ...
> > I also checked bpf-next: bpf-next passes even when the d028f87517d6 JNE
> > refinement is reverted, because newer kernels also have the later
> > 4bf79f9be434e ("bpf: Track equal scalars history on per-instruction lev=
el")
> > precision-tracking change. I did not use 4bf79f9be434e as the stable
> > backport base because it is a broader jmp_history/precision-tracking ch=
ange
> > for linked scalars. For 6.6.y this series keeps the smaller stable back=
port
> > path that directly follows the bisected fix: preserve scalar bounds aft=
er
> > conditional refinement, then add the not-equal range refinement in the =
older
> > reg_set_min_max() layout.
> ...
>
> To be honest I have not figure everything out yet, but I really much
> prefer we backport commit 4bf79f9be434e ("bpf: Track equal scalars
> history on per-instruction level") to address the issue instead. While
> 'bpf: make the verifier tracks the "not equal" for regs' itself is
> self-contained and reasonable, "bpf: drop knowledge-losing
> __reg_combine_{32,64}_into_{64,32} logic" comes from a much larger
> series[1], and taking that out of context seems rather risky[2].
>
> More importantly, 'bpf: make the verifier tracks the "not equal" for
> regs' does not address root cause of the issue, it merely mask the issue
> by making the two states different enough that the two is no longer
> equal, which works for the Rust specific case you have, but won't work
> if the value was slightly different (e.g. "r0 =3D=3D 1" followed by "r0 !=
=3D
> 1").
>
> The root cause to the problem have been stated by you already, it is:
>
> > The relevant pruning point is that regsafe()/states_equal() accepted th=
e
> > real success-path state against an earlier cached state where r0 was an
> > imprecise scalar and r7 constraints were loose enough to cover the curr=
ent
> > r7.
>
> Looking at the verifier log you have, in the impossible path we have
> r0.id =3D=3D r7.id from instruction 18, where as the real success path (t=
hat
> skips instruction 18) does not have that relationship, thus the two
> should be considered different, and that seems just what "bpf: track
> find_equal_scalars history on per-instruction level" solves by having
> the correct precise mark.
>
> Could you give backporting the full "bpf: track find_equal_scalars histor=
y on
> per-instruction level" series[3] a try? For 6.6 it should be doable, and
> hopefully for 6.1, too, but not too sure about earlier ones. If you prefe=
r I
> work on it I can also give it a try later this week.
>
> As for the selftest, it would need to be send separately and by itself
> to bpf-next, and picked up there, before it can be backported to stable.
> I suggest you look at [4] and have your test placed similarly, and
> mention that your test specifically test a Rust/Aya pattern.
>
>
> Thanks,
> Shung-Hsi
>
> 1: https://lore.kernel.org/r/20231102033759.2541186-1-andrii@kernel.org
> 2: https://lore.kernel.org/bpf/20260601182508.29C811F00893@smtp.kernel.or=
g/
> 3: https://lore.kernel.org/bpf/20240718202357.1746514-1-eddyz87@gmail.com=
/
> 4: https://lore.kernel.org/bpf/20240718202357.1746514-4-eddyz87@gmail.com=
/
>
> [...]
