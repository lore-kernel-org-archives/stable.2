Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793202516;
	b=SAtmQSAZc9XAeFTC3CEaqzXOxgz04PX4BHF+SHrGtA/42Zsy5zoAdOcloNj7G4KXsJqm
	 Dx8g0/379zd7aK8GHA7Bd1OmC5hrF3aMfNC8NXQIqcNv/0NLmFq12n9yvqgoF3OC+hyZp
	 Pv0VhzdaqnINuxBdGQ8rViPJibjw+wxETcRnsn9vRazsCBygbmcVwPE7EvA/KJT2aW70r
	 5P1A7ceAdbkXJW52EcytDbOIQew0AWLUBF3RUQQnyOp5CpfQNiG32E0nCPSmgLuxeYPgg
	 tmJm49z31Iwo7kf1ih/qIvaCMhMbG1/BWDMm5oAtkdNlvxXP8lu+jpU19ZhZFRjBdfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=P2Gtmc+yPPyy4dGekEnPEtmKjhHWq0oqn8nEo9QjzPA=;
	b=fCbLw6myvka+nRCi+xKfacXfWrmn9Pl1ffRDZapFLQFQTuiGXk1vlaHOZBeO/e/lqtoc
	 JEtESyTUiY/tPgjriqSZJm04yU1toPOWSjeFg13qBq2i0on0VjG6GDBHTnQsQh6JGYBL3
	 7bu2ParrLs9cNO1LYZAOXB2In8gZ46EJIsFtzV3A2YVYl089OiT5bTHIMXSU4ftn7dT9a
	 LIA7N/zOWK3qIrYTPqV5yWBEbmP7eo+wKKAkW5pdlVuATJ/PRhOWOfJ34hv9EQMkiunjk
	 2bzKHretwxiBXOwZ/GZFi31xB3QHZ1fGgNSmEx6UeDxmdf6vsTSeBJIZDSu9OBBZlOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sR9JdKFc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3091A606A326
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3091A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sR9JdKFc
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b40fc523faso1444442a12.3
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793202514; cv=none;
        d=google.com; s=arc-20260327;
        b=gqOVBvb2k9Z4nvfYL+U9xzNIdvCRtNkHde5ITOkssvf3Fl4l4ItJSemG2CoCuj2e7X
         fZfuIgKGGuGjOAGVgM0X41C3gPpySn/MKswJOYypO9+zBvjxGw1pwDD4Mg7OtyRWBVFT
         4gT0pqjEEvXNOIxd0mbsIwaq7IfERbQKOl6Ufk7KCXKQfCwCv2kWS33q/sYTFT0bcJqS
         eiBLUtAyVK8GxqknaTvaDGx14bN0pmAmV49Tin8SOl3gadwEQ1RtkCeMSpshVJvlq3VZ
         UiuMGjHWg1uL7AcrRqaFbFL4PiRKOMjSDuW0lXAvzb3+dDrREzaYV/xWsNwXzSNurv0Y
         zPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P2Gtmc+yPPyy4dGekEnPEtmKjhHWq0oqn8nEo9QjzPA=;
        fh=tqelp0smEiCW9onC9DF7aiXGY9wpAVV/j4mcBqdr6D8=;
        b=qjbPkuAc36FU7Rluk7gt6skB6vnhVKKFwEj+MRwFSQmqeUHGgopPhD6kklEG04wNoG
         wWASKU1aew/JV3zy5qIYZEC9XZz3KNTH4ZMeJEccUPEH59osxCDGi2z/EdD/n8VH1uSW
         wT3BYtXpSHEIwUn3JPgnHq4Sbbm2Lv83TsD2oxFcezPvw5tUwitUJ097KALBrBcHyPeH
         6QdfkJb/ud/MSYBM0sqZ74zdWw7hbj7PiF4ktbJT0m5rH0dYrU05mkJdyLbbLMwCb18z
         JuOlh0Ucv18Vy/8wola/Rn/BqPDAZzm+Gw8tsAcFVbjjIyULSqW4GRGezMYDdviE8wW0
         7ZEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793202514; x=1793807314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P2Gtmc+yPPyy4dGekEnPEtmKjhHWq0oqn8nEo9QjzPA=;
        b=sR9JdKFcgs0bpN4QkQ2MTdIADGBy0OfZK9Uc2xzngxH1OUHE6XPlgmotix5n04kE4V
         tKXhDVWcUi7R8x+WsSxO2XKULm2UrCLa5ugS8f2l/Nicboyg/Xq7P2T+CyBQwzwtUuSA
         00kvck2jyr72g40j3aOA8r0nVAnGYbDjdTazXmR+zx5OSZKFqq0rBsYi04jxNiTiLr2b
         b4k1CJpjGAKX5SIh8b5X0Vz9tLapvrzMIh1IAEh+zcElg7kBwxHx+E4aiBCISBHpzRVy
         sK/o6PxDR0wcadqZ7HwH7sh84bKXO5+wNcvDUBoiIhOwr2Otqj8bsp55EB6PBwliFnGI
         NU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202514; x=1793807314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2Gtmc+yPPyy4dGekEnPEtmKjhHWq0oqn8nEo9QjzPA=;
        b=wkXN/NBaRqmDhMJCUPuqfz3UqatXNoy/qWugX6xsD1rMPoSo+ZWreq+J/9NYc5Zkm5
         QcNn3o40ZYhKQruO2l0CSYUlaEM4HOstc97rKgdaec0PjkT3t2gT13IB1I5wjZ2a4OzE
         geDGHJ07MYDEVKf1Sl8cx1n7CbV4zW5iaKkPW5o0uqBa3YFoxNc5VEvJJ82Kh3BNnBw8
         LdlaDzcFYR0Q15K9e7FjAhg6+yLTsAyuLvrn86VnHbWT80s6s1RYRJ6lmmXFeuYT7EhZ
         l5a4MiMrNJHvvCv2cOTBqGd88h6vejap/wXLYTIiOw+qdmwxiCyv8SbXwczWysbbNfeN
         +ieg==
X-Forwarded-Encrypted: i=1; AKwUvBxnxmZHYF4Fh+roSk4KLgFexTpvJFzYPNY28LOAbH5m7yJhhiYDQ2S9hQv6oIWuUkIplym3vys=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbpzSA+JqQVEEB7x1Fuh3DaXbiC8jQxBobeaaVFwtp2kptKdVE
	3/DS/dlku3Q1NVFpYW9e9bVH9AQUr0qrNocQTGvRoDDlRWYKvwDlwWKB/cFK79sgvOL+gCOTr7Z
	TwVIeT4QzL7rz6GHj/8Oj62/JgY5YeGk=
X-Gm-Gg: AYBFou0CnL8k1EGwCNly34E4of69bG9Nc5yMxQDsrepWHwajEbeY9svdaCGaakrHxlY
	lynDwCcvmdaHfWdPOx69cD5l5225ALafruT1V/4u9yLaolSDqkAyo4ZLuCekWWmZwj+Wgw7FVyX
	EYtsDF1MXkHU9MhtFFJQ+pdlCeH9Cy1kfwhqbRQDTCaqAaAdek8LkabB4YNxALIM/sW4KyMbRxQ
	FHobbcdtdb3Hbqei0jSPNkRmYH6D/f6SJyXseVI0W1OtWN8I9vdjf6wNF4xwAtIbrb1Xr5OnJUW
	jLMdcXeKaW785aUqAzMMIIIBh14WPHzWAYneePfJnJ201bXBNfMG8/oKkxPCSIbwNcZP834sanU
	d0YYHs/rvqA5zKg3sDCBnL7CDL2sJa60ZchGdR+UC42ILqKgHmWZ+R9EhR4CBkpYCMtv+8g==
X-Received: by 2002:a05:6402:4414:b0:6b3:c0f2:eccc with SMTP id
 4fb4d7f45d1cf-6b49cbf6a9dmr2006612a12.27.1793202514481; Wed, 28 Oct 2026
 08:48:34 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <P4wUBaI--F-9@tuta.io>
In-Reply-To: <P4wUBaI--F-9@tuta.io>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Oct 2026 17:48:23 +0200
X-Gm-Features: AclHuK8ls02xbX493_Bp1EqA0zzJpZtmFJofnLekSziZPblGB53hacKp5SDR2jU
Message-ID: <CAOQ4uxhT4i=UDvLmPAunehFujouFka8UKDCuB_exR4oSx_V01Q@mail.gmail.com>
Subject: Re: [PATCH] backing-file: inherit FMODE_NONOTIFY from the user file
To: Edvard Conrad <edvard@tuta.io>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 10:32=E2=80=AFAM Edvard Conrad <edvard@tuta.io> wro=
te:
>
> On Tue, Oct 27, 2026 at 12:53 AM Amir Goldstein <amir73il@gmail.com> wrot=
e:
> > Any chance you can post this as an LTP test?
>
> Yes. Written and verified, I will post it to the LTP list shortly as
> syscalls/fanotify26. Two cases: a mark on the overlay only, which passes
> on every kernel and keeps the test from passing for the wrong reason,
> and a mark on the overlay plus the backing filesystem, which is the
> shape that deadlocks.
>

Great!

> > Urgh I hate how special case this is.
> >
> > How about something like below (untested)
>
> Agreed on the shape, and it covers backing_tmpfile_open() as well, which
> mine did not.

There is no code that adds NONOTIFY to backing_tmpfile_open()
the only code that could add NONOTIFY to backing file is from
dentry_open_nonotify()

> As posted it does not fix the deadlock though:
>
> > -       f->f_mode       =3D OPEN_FMODE(flags);
> > +       f->f_mode       =3D OPEN_FMODE(flags) | fmode;
>
> Five lines further down init_file() calls
>
>         file_set_fsnotify_mode(f, FMODE_NONOTIFY_PERM);
>
> and that helper clears FMODE_FSNOTIFY_MASK before it sets its argument,
> so the inherited FMODE_NONOTIFY is dropped again. The backing file ends
> up at FMODE_NONOTIFY_PERM, which is not FMODE_FSNOTIFY_NONE(), so
> fsnotify_open_perm_and_set_mode() does not take its early return and
> still raises FS_OPEN_PERM on the real path.
>
> Measured in a VM on a defconfig + OVERLAY_FS + FANOTIFY +
> FANOTIFY_ACCESS_PERMISSIONS build of this tree, with the reproducer from
> the patch and with the LTP test:
>
>   kernel                        reproducer    fanotify26
>   mainline                      hangs         1 pass 1 fail
>   v1 (fs/backing-file.c)        ok            2 pass
>   your diff as posted           hangs         1 pass 1 fail
>   v2                            ok            2 pass
>
> v2 keeps your structure and routes the fsnotify part through
> file_set_fsnotify_mode() instead:
>
>         fmode_t fsnotify_mode =3D fmode & FMODE_FSNOTIFY_MASK;
>         ...
>         f->f_mode       =3D OPEN_FMODE(flags) | fmode;
>         file_set_fsnotify_mode(f, fsnotify_mode ? fsnotify_mode :
>                                                   FMODE_NONOTIFY_PERM);
>
> One deliberate difference from your version: it inherits only the "no
> events at all" mode rather than masking FMODE_NONOTIFY out of whatever
> the user file carries. A user file in the HSM mode (FMODE_NONOTIFY |
> FMODE_NONOTIFY_PERM) would otherwise leave its backing file fully
> silent, suppressing the events on real files that bc2473c90fca
> deliberately enabled.

The problem is that I wanted something more generic and v2 is
still very much special casing NONOTIFY and much bigger than
v1, so there is no gain.

Let's admit that I gave you a bad advise and a wrong sketch patch
and feel free to add to v1:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

BTW, pls remove Assisted-by it is not needed and remove the
newline after cc: stable

Thanks,
Amir.
