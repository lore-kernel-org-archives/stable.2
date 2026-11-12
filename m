Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794480549;
	b=nfMBU3yYB/+lsjI9gdKgc6lHgZk56QcoVu6nRa5SrMBDMLhXqrpPbmhdi4cfIKvvzOK+
	 V55EdpVOs7gWQzDXeM2Lbg9MFple2dIuJTHhOa+xwb8pfvz3VTQDVJchoKVJxoOORyZLe
	 RxkVN4BQgBfb4qsFo2COChfKnEfH0kxNi/0/CqQVLMYlPLpbZ3fj35TYqEwiCRZfMpZ5q
	 HMJ/RInHEbZvcfWZdSM4UcZ8O2nBgVSTKg94ikBbol22I1Ve6pmScKzbuKHbIUpdHIjyL
	 b6VY1gpGAXCeIxJuaP7Yu4zKjz2KRsKKLNjr8WbkT8DoxVTHkcXOfDvgcmY+SFNRxJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=djeywF8NU6JhVA2LA1RCUZwnghPMCvDfZV9losxqGOA=;
	b=F1Vx4UtWVaDnSkXMAcUoP7vzq5DAv3pjJgPiaLhFLWFajwvK6T+sDFFDbGU8a2vKsXQ3
	 8/yLTMsUnKdidNNG4EMeN3zY7beg5kZqmyZBjs7BCWP8bRHIEslJeoWanKUWHkx7cJKFj
	 wQQdebGIHgOGXB/grHDxmjm2s2aYPvRMmU7ayHdsVaGVKR/a/iyq8gkgL4sD16hjLr/Er
	 shZqwuqV68t1BUOcyo8zGHHrtVq89g//W7xOffI4QFPCp20VmDjBigB8IMGVYbvnFtZF1
	 R93JNKKEspw/6uf+P0Bo1DO/Y27BrVZO/9zNk+NSUEv0H0SKcOfE1TYKZuMNuldanpw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoTjQFN6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD5606A895
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12AD5606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoTjQFN6
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67bee1f693bso3786117d50.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:49:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794480548; cv=none;
        d=google.com; s=arc-20260327;
        b=Xh8hocDCrn1E8snfLYuwHO/O3ekAc9fXegu1cbexAgUQGw/OJZTPn42GhfoBD5Ee9/
         D/7oxTc51yXtyZ+XVnJPLGLdYm4c4IH31UeRIrAKFrbjoXClSdm2nenjAKQ7TwDwjDCf
         qOi7QF1qEFWJ+Xmer7zFUEH5Murxo40vw+DqqMIaMzVVCk9DM4bCq8bEFD6Hn6JQH8OB
         CktMGm4Rb3VuxuPsVBvAbUp7vc5TQAK9V9ikXPLt8rE4Wiud8wvTb32OLdVCV3QCCBZY
         31PuVPPBIf/Os8UJxQp6yXyGQbiUj/1xotfbZ3BhBYkudinQLqiat99BWtjULFVrrand
         RBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=djeywF8NU6JhVA2LA1RCUZwnghPMCvDfZV9losxqGOA=;
        fh=TW73CLWFjzQcs6YG2vnqkpPqlfJ7rlMAp9CTLSZUhqI=;
        b=JARJCe8MKTMkLS48P+52Jjpxgm/QP1Nm7ju2DyksFIW/G365PWJFrt/6iXq540YZzd
         SWu/CZINVBe09LNPV7ruOB7cyZWPay+u1O56L5hL8E3Sn3BXWn721eG43hd/EiBaS/0w
         M2XUxQ+Ml1bCrBadaztGTYNOWktE4awqGDGifGz8t1qJ+Z1486BolBjbdh1EpRSPw6h1
         AV3sbzWFpnyHy9THeoK68dpFCvXZze/KP1Mi5iPOAK7Pnzn3O9lLRr8+HnXKXKvNNsOp
         XNGYGGns3yn/9Xa6FK6QXll+l5r2Fbd2J8alGSEDZIp+0r3ZdtlBzOFn/+9l9QIFacsm
         wmrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794480548; x=1795085348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=djeywF8NU6JhVA2LA1RCUZwnghPMCvDfZV9losxqGOA=;
        b=FoTjQFN6HKDx5jy184j9d8fpoMU4ig57gFse8f6Zw3tpbWpaNUmen+l8TbMwQBr98F
         K/SiCATGkVA9+PDnMnd6K+vLTL7VHcOGARIWGB8zphm16QHjJZedmPhD3jBD2BF+C9c7
         kNCNCVexmmltKENgVFxOIkw6b8haSD94a6w777S1gmlPmi/CWmymacrjWz+qjgEQ4les
         aWFplqMgHU41kjoCKAVuj2uYEtZRpsbYzOjL+vf3T/6aioIWB3COME6Ddaa9OeTHuLtj
         vfuJmQWzbAqh0KqYRXabp3fdx/m3JZiBIzTE/wMc8SmsU4RrWLnZO9LkGS/ftCdSbSIm
         Fa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480548; x=1795085348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=djeywF8NU6JhVA2LA1RCUZwnghPMCvDfZV9losxqGOA=;
        b=ums+xUcQLFW20yql4ILp19TwRD0u9jlwS03VT6GHhciT7wIAV7lX2r/VLZeGwEwS9k
         DAXisUVEKHKWr4ZhfVm2b4MciS56Jtml7X3mmAFMPXdEgJFNPJ1vaQPxWJ0hSgiBlfyv
         4iF7abjZqQBWTZwxz7JALARK/4hm4ugcUPbGNWDkbluMzP12ew6gtumm8ofyDTH2M+4t
         n+funOZ3BrL399AFCPy2kuPfppO7XVSGWXBGl99ewJEEpK441nBBHVs/9eT0Fu3xZM2A
         V/dZM4rJ9V+wRRRSIzclV4XfdqAFN/IaOw4zEXEcDgLnaUu00uCYJQIqO5UU9T4BgjrF
         a7ZA==
X-Forwarded-Encrypted: i=1; AL+hErEIyi/XpFFCi6FRkd/y3fZEgKec9vCEaTjlxQOUxeObL+4us6GTvUB+yEUXg56oTzEgHESLkCo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8cftyjaa/OqHS04b/BWhC/82L5dmlFCgLejGpmyruTjc9fcIhL
	DsocsdgnxGCF2rIyTVJymJR8wUtbaCxyRl7/RB7fWI/u7gVmQNtz1ntpE4rgxsJhkMCbhasBqAi
	AKcsaTDacWInTiUErERtH5GtRTYWWr2U=
X-Gm-Gg: AYBFou1xHA3P25wD8zteZMrYJzdr4CkkNkbUD0C6mbIS/oDNiC0kqXCi8VoleGNshBK
	JkLH+5TYoCioIrMeYRGCo/XLiCDTEqKBwnGWCW3BX+mFr3xv+2jThiVTbatBa0MdHqkI93tunbP
	wIUk0y8cPbC/Rw2rTNADobS4WS1C0oeAlUdoh1gG+6ZjuSAmNIS9/Pc1KzTdS0NTww96hUcIBZp
	swjZUpGVEkjAl/hG1YLc3caJMvU+fGzHlqrmz7nNbjyu/UJf8Fok6wohOgL37O3ZGAfDf/dKmfP
	LA08LNeMCA+DS/sLPgleBDob/nF9p04L+1nJ2tOzu5DLXMLEdju601GYilBkt5/6aOOzmx3ju/Q
	Y+DZw4g9X2Z7w33xdpnjQHRrn+u4QnV1c0uc7dBBeju1BzvQmJlPLEefILlEShMa/uapAEh8=
X-Received: by 2002:a05:690e:458a:20b0:679:bad8:7dd0 with SMTP id
 956f58d0204a3-67c67f00246mr2870020d50.27.1794480548052; Thu, 12 Nov 2026
 02:49:08 -0800 (PST)
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
 <CAPb1+K2BxnfQ7VUQ15td5f9pVhn-ARSM9EjfOU8WuW72o+cvPg@mail.gmail.com> <2f722967b6db0692d4dd4164aff39b62@gmail.com>
In-Reply-To: <2f722967b6db0692d4dd4164aff39b62@gmail.com>
From: Gideon Heinz <gideonheinz02@gmail.com>
Date: Thu, 12 Nov 2026 11:48:56 +0100
X-Gm-Features: AclHuK-kGykkeazgcRdIxLsRXEFTifsTMFIGeK5tG_bdJlYg18i60d5dyzfQ1AM
Message-ID: <CAPb1+K1J2F-=cJF_+Z+RkA+9uLD8-15m3hDv71DSPG47XLJttw@mail.gmail.com>
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

I tested the out-of-tree equivalent you suggested, ff->destroy =3D NULL;
in hidpp_ff_stop(), on top of the 33-patch v2 module (G920 046d:c262,
7.3.1-1-cachyos).

Same reproduction as before: fftest holding the event node at the
effect prompt, rmmod hid_logitech_hidpp from another terminal, then
entering -1 in fftest.
This time fftest exits normally, the machine stays up, and there are
no errors in dmesg.
The only message is the single =E2=80=9CUnloading HID++ force feedback.=E2=
=80=9D at rmmod time.

I=E2=80=99ll try your input core patch on a rebuilt kernel later and report=
 back

Thanks,
Gideon

On Thu, Nov 12, 2026 at 3:43=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Gideon,
>
> On Thu, Nov 12, 2026 at 02:30:39AM +0100, Gideon Heinz wrote:
> > Hi Dmitry,
> >
> > I tested v2 of the series on my G920 (046d:c262). Everything on my
> > list works except one scenario that takes the whole machine down, with
> > and without your series (last item).
> ...
> >  - rmmod with fftest holding the device open: rmmod returned after
> >    2.99 s with "Unloading HID++ force feedback" and nothing else in
> >    dmesg. When I then exited fftest (entering -1), the machine went
> >    down: the first time with a garbled panic screen that I couldn't
> >    read, and on later attempts as a total hang with no output. The
> >    same sequence on stock Arch 7.2.11-arch1-1 with the unpatched
> >    driver also hangs the whole system, so this predates the series.
> >
> >    To reproduce: with the module loaded and the G920 plugged in, start
> >    fftest on its event node and leave it at the effect prompt, run
> >    "rmmod hid_logitech_hidpp" from another terminal, then enter -1 in
> >    fftest.
> >
> >    I could not recover a trace yet and will send one if I manage to.
> >
> >    My guess, from reading the code and not verified by a trace:
> >    hidpp_ff_create() stores hidpp_ff_destroy() and the other FF
> >    callbacks in the ff_device as pointers into the module. With fftest
> >    holding the evdev open, the input_dev outlives the driver, so when
> >    fftest closes, the final input_dev release calls ff->destroy in
> >    module code that rmmod has already freed.
>
> Thank you very much for the thorough testing!
>
> Your diagnosis is spot on. Opening /dev/input/eventX pins the evdev cdev
> (and through it input_dev), but does not hold a module reference on the
> underlying HID driver. When rmmod unloads hid_logitech_hidpp while fftest
> still has the file descriptor open, __input_unregister_device() disconnec=
ts
> evdev (flushing effects, closing the device, and marking evdev dead so al=
l
> subsequent ioctls and writes return -ENODEV) and runs ff->stop(), after
> which rmmod frees the module text. When fftest finally exits and closes t=
he
> file descriptor, input_dev_release() calls input_ff_destroy(), which
> invokes ff->destroy() pointing into the already-unmapped module text.
>
> Rather than working around this in individual drivers with a separate
> ff->stop() callback, input core should call input_ff_destroy() directly i=
n
> __input_unregister_device() once all handlers are disconnected and the
> device is removed from sysfs. At that point nothing touches dev->ff
> anymore, and calling input_ff_destroy() there guarantees ff->destroy()
> always runs while the driver and its module are still loaded (while the
> second input_ff_destroy() call in input_dev_release() becomes a no-op onc=
e
> dev->ff is NULL).
>
> Could you try the input core patch below (with patch 22/33 "HID:
> logitech-hidpp: shut down G920 force feedback on input unregister" droppe=
d
> from the hid-logitech-hidpp series, since ff->stop is removed and
> hidpp_ff_destroy() will now run on input unregistration)?
>
> Alternatively, if you prefer to test with your out-of-tree module build
> without rebuilding the kernel, you can test the equivalent effect by
> setting:
>
>         ff->destroy =3D NULL;
>
> inside hidpp_ff_stop() in hid-logitech-hidpp.c.
>
> Thanks.
>
> ---
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Subject: [PATCH] Input: destroy force-feedback device on input unregistra=
tion
>
> When an input device is unregistered while userspace holds an open file
> descriptor to its event node, input_dev_release() is deferred until the
> last file descriptor is closed. Because input_ff_destroy() was only
> called from input_dev_release(), force-feedback teardown (ff->destroy
> and freeing ff->private) could run after the parent driver had already
> unbound, freed its device state, or even been unloaded via rmmod,
> causing use-after-free errors or page faults in unmapped module text.
>
> Commit ef166ce08801 ("Input: stop force-feedback timer when
> unregistering input devices") added a separate ff->stop callback for
> ff-memless, but left ff->destroy invoked from input_dev_release().
>
> Once __input_unregister_device() has disconnected all input handlers
> (which flushes effects, closes the device, and marks evdev dead) and
> deleted the device from sysfs, nothing accesses dev->ff anymore. Call
> input_ff_destroy() directly in __input_unregister_device() so that
> ff->destroy() always runs synchronously while the driver and its module
> are still active, and remove the now-redundant ff->stop callback. Keep
> input_ff_destroy() in input_dev_release() (where it is a no-op once
> dev->ff is NULL) to handle input_free_device() on devices that were
> never registered.
>
> Fixes: 509ca1a93836 ("Input: implement new force feedback interface")
> Cc: stable@vger.kernel.org
> Reported-by: Gideon Heinz <gideonheinz02@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/ff-core.c    |  2 +-
>  drivers/input/ff-memless.c | 23 -----------------------
>  drivers/input/input.c      |  5 ++---
>  include/linux/input.h      |  3 ---
>  4 files changed, 3 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
> index 0e5d1d1ceb46..133b4622dc49 100644
> --- a/drivers/input/ff-core.c
> +++ b/drivers/input/ff-core.c
> @@ -338,7 +338,7 @@ EXPORT_SYMBOL_GPL(input_ff_create);
>   *
>   * This function is only needed in error path as input core will
>   * automatically free force feedback structures when device is
> - * destroyed.
> + * unregistered or destroyed.
>   */
>  void input_ff_destroy(struct input_dev *dev)
>  {
> diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
> index d1fefd1dfc0d..3069436148ec 100644
> --- a/drivers/input/ff-memless.c
> +++ b/drivers/input/ff-memless.c
> @@ -483,32 +483,10 @@ static void ml_ff_destroy(struct ff_device *ff)
>  {
>         struct ml_device *ml =3D ff->private;
>
> -       /*
> -        * The timer is normally shut down in ml_ff_stop() when the devic=
e
> -        * is unregistered. However, we still shut it down here as a safe=
ty
> -        * net and for cases where the device was never registered (e.g.
> -        * error paths during probe).
> -        */
>         timer_shutdown_sync(&ml->timer);
> -
>         kfree(ml->private);
>  }
>
> -static void ml_ff_stop(struct ff_device *ff)
> -{
> -       struct ml_device *ml =3D ff->private;
> -
> -       /*
> -        * Even though we stop all playing effects when tearing down an
> -        * input device (by the way of evdev calling input_flush_device()
> -        * that calls into input_ff_flush() that stops and erases all
> -        * effects), we do not actually shutdown the timer, and therefore
> -        * we should do it here to prevent it firing after the input
> -        * device is unregistered and its associated resources are freed.
> -        */
> -       timer_shutdown_sync(&ml->timer);
> -}
> -
>  /**
>   * input_ff_create_memless() - create memoryless force-feedback device
>   * @dev: input device supporting force-feedback
> @@ -543,7 +521,6 @@ int input_ff_create_memless(struct input_dev *dev, vo=
id *data,
>         ff->playback =3D ml_ff_playback;
>         ff->set_gain =3D ml_ff_set_gain;
>         ff->destroy =3D ml_ff_destroy;
> -       ff->stop =3D ml_ff_stop;
>
>         /* we can emulate periodic effects with RUMBLE */
>         if (test_bit(FF_RUMBLE, ff->ffbit)) {
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 210635ef147e..7be69deed8eb 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -2286,10 +2286,9 @@ static void __input_unregister_device(struct input=
_dev *dev)
>                 input_wakeup_procfs_readers();
>         }
>
> -       if (dev->ff && dev->ff->stop)
> -               dev->ff->stop(dev->ff);
> -
>         device_del(&dev->dev);
> +
> +       input_ff_destroy(dev);
>  }
>
>  static void devm_input_device_unregister(struct device *dev, void *res)
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 3381608127f7..02047cc45d04 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -549,8 +549,6 @@ extern const struct class input_class;
>   * @set_autocenter: Called to auto-center device
>   * @destroy: called by input core when parent input device is being
>   *     destroyed
> - * @stop: called by input core when parent input device is being
> - *     unregistered
>   * @private: driver-specific data, will be freed automatically
>   * @ffbit: bitmap of force feedback capabilities truly supported by
>   *     device (not emulated like ones in input_dev->ffbit)
> @@ -579,7 +577,6 @@ struct ff_device {
>         void (*set_autocenter)(struct input_dev *dev, u16 magnitude);
>
>         void (*destroy)(struct ff_device *);
> -       void (*stop)(struct ff_device *);
>
>         void *private;
>
>
> --
> Dmitry
