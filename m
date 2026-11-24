Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795532572;
	b=M4AKMEXgCf9bD+2p+9PlFGNWmZCHfaaFbOzRLX5efWVRxeJiMnrdp192ua920aLInA/2
	 cPoXKpb+YquaEnihfX2XgDlqgOBtGqVWNTFz1WvtIQgW+HeWYO+0u2eL9EhUjjqZbc60O
	 QT3DcP0sqAa08qck5q3khGhiV8ta2I5sEj1G2Wmw9rFb/p26PeACSmb2yhfmDFOSONj3x
	 3Z9ltHE8K06Yk4dg5RqzBkESmwvu3HBkLPu5pAktNjuJT+ZSF0IDDCJVTYbwhN6f9d0Vl
	 W8JfAISx24bnZD2MpzBYku3mgFHDCz7Fkc+jZrkHsslvWIGtCckHBScB+2WVtH5R6GA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=15qhdURAff4Y2KbNVFJtyqKm6cg9Ddnc33WPFF64dLk=;
	b=oQfvpVJeYb43l8ZJkthtnT697fLY8w5tr9NwnaSUMpa7mrj1eVR38DQ0jZENG9Jj5j0M
	 fSXejNCgTmCZcmsU48V1i8+7WnfuX3WP4FYh1mKg3jEUz9sPS/rkN9iJCR/NtElBl++sw
	 3DON2/LS2mox7KgcU+lhAlhSJNjOVRp8XbGRnn9q1lfeGz8T/KLa5H7zBwUG/cMWfnpQV
	 CdQHiP0T+lJbcwOyPWaJDiZSTjXPAYZcUVvPYbYYEg9RuApuLFXsy2MZ1heEqmcKpsIpG
	 QiJhzvJLbW3QPYZ4oaiKRPSmbepkX1gJlA2JSVlaLAaX14jxANKBk20YlN1dBP82mUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r7bZyl4z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8553606A323
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8553606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r7bZyl4z
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b531cd9bbaso35863867b3.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 07:02:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795532571; cv=none;
        d=google.com; s=arc-20260327;
        b=dYydIXs+BHPJxJl3qsobG/cWQ0MdktEET1ELMdSBZ3W46lQV4nUZZqTmsU7COBswQl
         qn3v+vE9+q+2qJ7Dzt4StqseRGH4+3pozpqhjsiiHyfUzbQ9San5rDiT4jmPpFnC5/6l
         wEjFNunnFxZs6LTsJOkGbwxjDG1rKM3hHcByrSU7J07k7fdnJBkLGWsefN4ssKjgFDNt
         mfmoNSjzhp96H0aI/KILPtRks8xyVhXmwvPkmF5FRt3dhmH9geUbBeU/TgjiVbbAw4B+
         sDMNatRhooAp0Avg04tdRuiIhQNvHsKuvca57GOyLRFuSpTCgpvlfd9bAgb9WWAegw1p
         uOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=15qhdURAff4Y2KbNVFJtyqKm6cg9Ddnc33WPFF64dLk=;
        fh=XEH981/h7SXDlFvEn/hWgBbcs3k/+cSyHorKrBbmYAw=;
        b=VUGNFiiBm/FRSHIS+mqF9DUxwj8FYQwityI4JXOW6U2d1KwlJFfwhI0yK4m7e2ydVP
         D/xTuKx/GDpHQudzVZxLwv1VBeTThUGRaljey5VupjXM1TkiBpzih2nLrrMlVUSAkC6V
         uolFDtKVJm6f7hR3DHdDIsP2OZ5BkRrDpk/fLUiyHp7WEmWLudgcf6hd48AFRnxe3Zdy
         JaRSFbiS2/uXi/cb0IlxEWpDJuIBu5UUhnBZ6+Q0H8+GWSoVS+8LkSDnbbEBVyH1cLs/
         uLDb+w7TJ6W6FJ3yhNP4vmq76h9izSOOKKt4JumH4zhw4xxiUBzQBC3Qy+U8jw33xZ/q
         vwKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795532571; x=1796137371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=15qhdURAff4Y2KbNVFJtyqKm6cg9Ddnc33WPFF64dLk=;
        b=r7bZyl4zJUFbtDloS96gjqVcF/HEKin3TvDEpPfRVdV/vlcCu63rkuoEQzURQjDD1F
         qDxUNisfRi5vhJqJl/JQJSTw7gmq4P1r/+QRIXmrDexCPQorEL0fPkp7qPH6ghBZJRgN
         n4DtsATmv5Qezhn/4OnKAicIHfHI379jaTS2bAG0jqAc9bMEaiQAM48A4C3lA5ZbY7lc
         PQ1GLXHbxqwnXTOsgBVfjr1E5VM47M7TwsUWIB1zHCYd51u8UPsMwSsFpljTLPrGqkJs
         Qns6YwdAY172Q7JlCFGSYYEfjlyVOfNyfWFfwlbycqO6tmYYB50pY58dKnKWm1IAnpLG
         h0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795532571; x=1796137371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=15qhdURAff4Y2KbNVFJtyqKm6cg9Ddnc33WPFF64dLk=;
        b=d5lVTIbi5iMUmrXQ4mSkbSAmljdhOhQqD+JpipIKC/S1l1mNS+qAxTn/aKgLjRMQun
         xF0TfkZnN5Sn6GpQDkYKi4HUg8iXM0b4Yv++FMyRkHloOe/FII0DT/JvfVDuWgDLev+t
         IKRYTbu9xSXPISUVRcC48SQ0H8sd4zZG//xzZOpM+OWS5olK+xiGG7Xyk7V4u3oT/56o
         WerJvzjm+HHi5iVYSelgkUYacxeU+magV3AshM8xI9mRbUHLWr49JxdGHi8KXbWAGhnz
         Z3ILgSCFqOGivob1l+gR7Se9/jUOYD3GMGJljR89yXRwIovqW/6/usgH0TlGpxyaZ3YM
         nBsA==
X-Forwarded-Encrypted: i=1; AL+hErEB8op8pSBK+h9vtwo0p/MdBldI1MbE+4BmQ34wdwsjpfRUUQFpacGlL3byXE2KpyVKAi+7JHQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WiCw/xQexX17QzAImxwgLK6iuHB26ggnWJgaNtNjIAA0hXGI5
	FpdpFMdGfotKHmAFvYItP/ij5ndjyLHR06K8komftd0CHcZiRvUvDezi1YyV2Cua05lVeaCvbYe
	ZxshSe11r/ZzKtEmokSVMJW5qOEyfOe6G9A==
X-Gm-Gg: AZFdTZf7kCt2GVk4LD22Kc6ryaccF8wPZ6L2cnu0TTiaN4iBMS5ahQcbNnYdeARnrGO
	jeWrKU3f91nBVNsUF9jaW0B6t3bBs+Rwr07A4N2WY8AixM3neU+L287Y853pnwhj4ZvoLbYFVHT
	KIIoyfqk/M+i8nLy68BIMiX8V7kpGnQFiUTKln36m3CBjvw8SuKO3Bun60gSW7ZarFiZgkfItUq
	j/ZgUaej9Z4vb+SgAbj+22yrVQxfliMYX8PvgO+KayWXT0pZQ8uEzgTWn0RexJ3O9dbMMLQEkMI
	c3g0luI1bAPxdc6NvtTDsAxuSeEWI2Wg8Rv0Vgzly3R0NJhZz2VnSXzXdGtLQy4/WtRhcxtSqW6
	j2w/q/VFAspe0SdYuqiahLZo/k8uM4jzCKUQ/gI05H00DeaKhwD65vwM5R1+ua4Vupw==
X-Received: by 2002:a05:690c:6c8a:b0:8b3:33cf:1fdf with SMTP id
 00721157ae682-8b52043a56fmr73445267b3.14.1795532570462; Tue, 24 Nov 2026
 07:02:50 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120150008.1144420-1-ekffu200098@gmail.com>
 <20261120150008.1144420-2-ekffu200098@gmail.com> <874id6cuvh.fsf@igalia.com>
In-Reply-To: <874id6cuvh.fsf@igalia.com>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Wed, 25 Nov 2026 00:02:37 +0900
X-Gm-Features: Aa3M54q7McbRkX2Kvq38FE_QJzJaOozwIIO4D-O26WWXQe2rdNcekeLEZ0LCW74
Message-ID: <CABFDxMGGtxxm5OyLiihbVLBJKihoTxtV2g-FG6rURdPWnQdwPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fuse: defer dentry_tree_work until fuse_dentry_tree_init()
To: Luis Henriques <luis@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Luis

2026=EB=85=84 11=EC=9B=94 24=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 8:49, =
Luis Henriques <luis@igalia.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, Nov 21 2026, Sang-Heon Jeon wrote:
>
> > inval_wq_set() schedules dentry_tree_work when inval_wq is enabled.
> >
> > But inval_wq_set() can be called at boot or module load before
> > fuse_dentry_tree_init() initializes the work, so __queue_delayed_work()
> > warns and the work never starts.
> >
> > So defer scheduling the work until fuse_dentry_tree_init() sets it up.
> > Also hold kernel_param_lock() in fuse_dentry_tree_init(), because a
> > sysfs write can call inval_wq_set() at the same time.
> >
> > Fixes: ab84ad597386 ("fuse: new work queue to periodically invalidate e=
xpired dentries")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> > ---
> >  fs/fuse/dir.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index da23ccd8685c..0d5d04df477b 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -39,6 +39,7 @@ static struct delayed_work dentry_tree_work;
> >  /* Minimum invalidation work queue frequency */
> >  #define FUSE_DENTRY_INVAL_FREQ_MIN 5
> >
> > +static bool inval_wq_ready;
> >  unsigned __read_mostly inval_wq;
> >  static int inval_wq_set(const char *val, const struct kernel_param *kp=
)
> >  {
> > @@ -62,6 +63,10 @@ static int inval_wq_set(const char *val, const struc=
t kernel_param *kp)
> >
> >       *((unsigned int *)kp->arg) =3D num;
> >
> > +     /* Defer the work until fuse_dentry_tree_init() sets it up. */
> > +     if (!inval_wq_ready)
> > +             return 0;
> > +
> >       if (num && !old)
> >               schedule_delayed_work(&dentry_tree_work,
> >                                     secs_to_jiffies(num));
> > @@ -224,6 +229,14 @@ void fuse_dentry_tree_init(void)
> >               dentry_hash[i].tree =3D RB_ROOT;
> >       }
> >       INIT_DELAYED_WORK(&dentry_tree_work, fuse_dentry_tree_work);
> > +
> > +     kernel_param_lock(THIS_MODULE);
>
> I wonder if this is the right solution.  The solution I had in my local
> tree was to simply declare a spinlock with DEFINE_SPINLOCK() and use it t=
o
> synchronise access in fuse_dentry_tree_work(), fuse_dentry_tree_cleanup()
> and inval_wq_set().
>
> Do you have a reason for using this kernel_param_lock() instead?  (Honest
> question! I've never used that before :-) )

AFAIU, parse_args() (boot, module load) and param_attr_store() (sysfs)
already hold kernel_param_lock() when they call inval_wq_set(). So we
don't need to declare another lock if we hold kernel_param_lock during
init and cleanup. Let me know if I miss or misunderstand something.

But using a spinlock should be okay as well. So if you prefer using a
spinlock instead of kernel_param_lock, just let me know and I'll
switch in v3.

> Cheers,
> --
> Lu=C3=ADs
>
> > +     inval_wq_ready =3D true;
> > +
> > +     if (inval_wq)
> > +             schedule_delayed_work(&dentry_tree_work,
> > +                                   secs_to_jiffies(inval_wq));
> > +     kernel_param_unlock(THIS_MODULE);
> >  }
> >
> >  void fuse_dentry_tree_cleanup(void)
> > --
> > 2.53.0
> >
>

Best regards,
Sang-Heon Jeon
