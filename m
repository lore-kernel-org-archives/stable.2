Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017CC4D9540
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790785645; cv=pass; b=pK5nHGXkyv6PqWTAshQmBDF9U2hwYVZJSZwY//smwJ9aThx6qvUj3Umjp6sYTvmrlp3dEvgjoWPRHrypunwR6aLRLlUB/7zGOchxlSXv8WtDAAMEiqwIme6tAmeowgbqpOX9qPwV7YhLkHog6x3DdrclHxw9gQ7CwKc++FzSj5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790785645; c=relaxed/simple;
	bh=wNXYSE+BizmuyxUThnUdjTsMAxh7gdhvWAllvmS1uH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQeWikWgBEfKbQqKS8imTMqa3x/ZJicER3TmpqFWEuvC0kMAvtAI5/7Rn7vSVYNvlGe4GDg1snFLZQTEpP7wourxOVaHYxh7TUeFGtlN8hqPEkbYIDB6TKBhWEFKZw2ETpFIk9Gpq7DqDCBaBceQ9emjjgobkJK2G9Dli4ZTuGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCRnRObt; arc=pass smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCRnRObt"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6ae193113acso135877a12.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 09:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790785639; cv=none;
        d=google.com; s=arc-20260327;
        b=mpQNJJ+pIa1jug/sOyGrL7qkMnI21fsra+o6Tsw6CXrEtHRRZ6Qj+GG449CIVt53Uy
         YjfsksPO9NXsFnYmA9UwrLts9vizlKKBK4IztPzRl5QzP0Rvd5rdEZCrdMtiTOkdKnu5
         pjQ8cQssCW5u26b2xVg6EIHU7d+qJes5mgvHpX7EfyMB6AUXJOoSVeZDD29/VvDNoASN
         MJgYcSz9bSzjfMKFtArO9LSn/M+rOHiukuW5MB+JlRYbzs5acIpVRC4foxxza3BXqK9/
         ZZxpLUOU+fjreofbUtXRjzWwFuCaA7th2rGvblYFIB2Ff7xoTuAEnQ3tPW5ECnO17KwR
         Ztcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OjQa1xcY55UbS6TWLrXPiY91xlqpQ/9/JSfN7qtQQBw=;
        fh=tySrtJ96UvWubT3ao6aMeBvqNFPBP6ie4mlrks2KYA0=;
        b=RIsDqV/73JNxTcc/L2ialHlXGwN8HnU7z8yTOX9Z8skk+V5m0QttTVMNgar8skp4Bi
         UcaSU94+6jAJTHKxg46eFqLijcx7s7jpM2IM4RzDVapcTxGRU27dHxAf4U2cUxERtlVN
         enV47funpGBBJTCNJQPeg5QoM23WOyyr6VOxHr2lRyUWLGCBTLCqB6ZIXa13L4gko+dQ
         UaZ3kovG0+bi3mlQVLu+HUO36jqrsKUx7I9Bf2wF4Zmfi6eyHHjwA8Orc1E/4C//zOVy
         zEaeYbf5CFTZPt8oOZWT0fnOduipLzDarsiBeBtmlPDjD/LuKPkas+h1cp4kDhEEGXzY
         vevg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790785639; x=1791390439; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OjQa1xcY55UbS6TWLrXPiY91xlqpQ/9/JSfN7qtQQBw=;
        b=eCRnRObt+X44KIPVjho4/LwPoyBMKjaIoOI3zyPae8q5trpBDO3MlICdfEVCsAt1EK
         yJMdSXgoHF64NSm7k7rYm6QMY9C3toMewwYlGdY+Kd2bkkobpzJb/a4RAlcMKITIugTv
         ZT/Mou38QDS7UPsN41OddrJAT5dbWqt5J3wDDEyPnHYArMGn6OSluSFxbR1YaoC2dX/q
         VKRyE8FQT9MgwXwtuJCo+1n4gXIg1YCp7geF9guTRpL7njJXXtKOOXfkYAIfnj7zEuQj
         D0uxCT39Q8Sk0/PNIaEO6TW4p2YhXxsLQ+esmvAWoYrdd6CvigsrMAXUE82SWEdLmAJW
         64og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790785639; x=1791390439;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OjQa1xcY55UbS6TWLrXPiY91xlqpQ/9/JSfN7qtQQBw=;
        b=1IOdB67n0MIYND0XHhtCtT8lb1QdZr1jsV9+MK5EIKa1ASjOHIpOefJyPpOe+LIh3x
         +zr2uDyLeg6OLIuWNqjFAHAuQtEV3tM+CbDKGEzuMxjbHhDzsCKrXzAQZbgIPBnB4rJ/
         qWOxoeKMGGDcOTRQ9nriVWfpQmCwc/dZbWfeRMV2d14YZDoixwIJmuz+takmokWaTV/3
         qRF0yQX4ATqZ8y7uSvTlUMORJUXnZX0jsTRKdfGYxgWc9Cl3HkQ5jNN/5RwwSUGMgSbk
         Kj9udeQhg2II7y+LOs3YSvJLdL1P31yV86+KjAvpMGWyQoSChRfRixsoYshbB/jyz8kT
         f4fw==
X-Forwarded-Encrypted: i=1; AKwUvBw+8Zqz4dUxFGKApz5p6FBdhQSnSo/1XEXDaXInb3rrFJY2xQw4OrnXtghqJ6e4eYWGh0w6Hhc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSZ+8Tio9O+bg5O9h0DM0joulfjqGrwKa0Rf9T8ukSLnghzN54
	mJbrkk6pbzwVnS4ElbKB3qFf8Z9fCWQPJGRH0q385Vx8gxhNAYTMyDzbJabdhA7UApd4DhdjPCF
	jh5/9iFNEcmCueNQkckXJfVYQfGg9UbB/ZJ+F1hhoZEM0
X-Gm-Gg: AYBFou29Y3h8a+KvdEkkRj1FUcrCBWa3jJCq6OxomZ951f5l0SVuVarPv43raicjK2b
	tYgm17krVBgKpYHO3UQLSvsFZ8TBrCORvH7EKWwSVnLpYDQ5d5vrLh4NE7zJUdomgRC5MvlL8Rf
	vgkrUybKFyYvrfoJpph9DVlsPWSJUj3VcL6LzUkjIt0yPrRbKE9J7s3lZ5QteOUDAbnRd2FUmlu
	ylIrIQZa5zsdrcOo3urjH4o5hDsysXyG92DHB/gp/2MCSqZD4bbYG6xptE/y3qlh7soZ0vk8XQK
	fQ0wZJ1+8LaFaBn6yUFw+jJeofq783SygsnrY7EIZQYLkYT5fqSsOOvAJHnV5rCYrQjXM6ztIva
	FUUndhyhU6iU=
X-Received: by 2002:a05:6402:538b:b0:6aa:ab56:aa93 with SMTP id
 4fb4d7f45d1cf-6ae199450c0mr1576865a12.3.1790785638560; Wed, 30 Sep 2026
 09:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926184154.3017929-1-nicoyip.dev@gmail.com> <arzUadtDI86btAMj@hovoldconsulting.com>
In-Reply-To: <arzUadtDI86btAMj@hovoldconsulting.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Thu, 1 Oct 2026 00:27:06 +0800
X-Gm-Features: AclHuK-2olRzMYoDYcjB0InIT-BBwwmXaknCmT4Wi79CIumBAaiqda3Jqn9g6oE
Message-ID: <CAAo+4rXdFLRgLcY5WZ12yc3RyyX-JRnmvXo2Zm7oJ4pC540iGg@mail.gmail.com>
Subject: Re: [PATCH] tty: Serialize saved termios access with device registration
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Wed, Sep 30, 2026 at 5:20=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Sun, Sep 27, 2026 at 02:41:54AM +0800, Chengfeng Ye wrote:
> > tty_register_device_attr() frees saved termios data when reusing a mino=
r
> > number without serializing with tty_init_termios() or tty_save_termios(=
).
> > The tty_mutex held by the open and close paths does not protect against
> > this registration-side free.
> >
> > For example, an n_gsm mux reconfiguration can register a device while i=
ts
> > previous tty is being released. tty_save_termios() loads the saved poin=
ter,
> > registration clears the array entry and frees the object, and
> > tty_save_termios() then writes through its stale pointer.
>
> Thanks for reporting this. The intention here was that the TTY drivers
> would not be reusing a minor number while it is still in use, but that
> is clearly not adhered to everywhere.
>
> > The saved-termios
> > copy in tty_init_termios() is vulnerable to the same lifetime race.
>
> How could this happen? TTY drivers should hang up their ports during
> deregistration so this shouldn't be an issue unless we have a driver bug
> (which we do in n_gsm apparently).

Right, I did not reproduce or otherwise establish a valid interleaving
involving tty_init_termios(), and the KASAN report only demonstrates
the use-after-free in tty_save_termios(). That statement came from an
LLM-generated draft, sorry for the confusion.

> > KASAN reported:
> >
> >   BUG: KASAN: slab-use-after-free in tty_save_termios+0x39a/0x3d0
> >   Write of size 44 at addr ffff8881012e8180 by task poc/114
> >
> >   Call Trace:
> >    tty_save_termios+0x39a/0x3d0
> >    release_tty+0xb3/0x7a0
> >    tty_release_struct+0xa0/0xd0
> >    tty_release+0xc1b/0x11b0
> >    __fput+0x2f8/0x9e0
> >    fput_close_sync+0xe2/0x190
> >    __x64_sys_close+0x78/0xd0
> >
> >   Allocated by task 110:
> >    tty_save_termios+0x2c1/0x3d0
> >    release_tty+0xb3/0x7a0
> >    tty_release_struct+0xa0/0xd0
> >    tty_release+0xc1b/0x11b0
> >
> >   Freed by task 113:
> >    kfree+0x131/0x3c0
> >    tty_register_device_attr+0x498/0x8b0
> >    gsm_activate_mux+0xfb/0x210
> >    gsmld_ioctl+0x92f/0x14d0
> >    tty_ioctl+0x915/0x1240
> >    __x64_sys_ioctl+0x134/0x1c0
> >
> > Serialize the saved-termios copies and reset with a private mutex. Taki=
ng
> > tty_mutex during registration would invert existing driver lock orderin=
g:
> > UART registration holds port->mutex, while tty_find_polling_driver() ho=
lds
> > tty_mutex when calling uart_poll_init(), which takes port->mutex. Keep =
the
> > new lock confined to the saved-termios operations, with no driver callb=
acks
> > inside the critical sections.
>
> I'm a bit torn about this, but I think we should avoid adding another
> mutex in favouring of making the saved termios reset opt-in.
>
> Clearing the saved termios state on device registration doesn't make
> much sense if a minor number may still be in use as an open TTY would
> prevent the termios from being reset.
>
> I've just posted a patch for this here:
>
>         https://lore.kernel.org/r/20260930091938.1715754-1-johan@kernel.o=
rg
>
> Johan

Thank you for preparing the fix. Making the saved-termios reset opt-in
is a much cleaner way to address the demonstrated issue.

Best regards,
Chengfeng
