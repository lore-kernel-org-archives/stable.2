Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493850;
	b=vMNyLxJOmpQZMDjVgYqhPqesB/IrnBsBfGSYNEheAu9XXqhcjIFEgtW7tKGRYKKHgi18
	 aEHxiS6WKh67nw5i9CyYukSFAY5X4wf1XJul2Vhf++Hwp/cEQD3YBKHltBC94pPNOa5kU
	 92t6dEC0H0lf8aIPglJrmoi8iGG3oeYerM/mKkwnToe2+lbVKb6gHdJgbADzJ3ICULrTE
	 RtChnQ/B+xh9T2mqtN1/z0rOKFIxLeQ8Jyss5hTlSmFMyax5x68RP1IIx6LcQPAUaNdqC
	 ZdOhHSiftpXuUdAdF2nrf4P0mRJ9qyN1kaubnfwfVOIVHuK2iotO6dRycnsWPLhnhqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KDorLWQoT10iz7RcVWyX2HruLQSjSSle3gMrpViB5i4=;
	b=ggS97cQTkKjm8tnnxBwwrptqXLSC6U1n2+GZQgNrMtcmN4jaKUO6ixncWVNZ4HvMdZaK
	 3dfgZmD8lGnJveJSlcEQrWEHRk7qwI9fU/fnjOIThv1wk1pdjxNDpu5vrFWyjoJR/ipw+
	 neIO1QtMOJ9NlwvXGDJyVD41ccPQfOiaw/QX0lFFqpf/cWkhE/foyChnX1sVWwjg+7bPE
	 nFY1rD9zN1ybrTSbE09Wmf02XOO4NJY7R/TAp9cLkVxpZQW+7MhBcgVyMPdnyuiDx3022
	 JH2s9vk0tVXTNWkqDV3LWoBlFtP7T7/xYlz7eu3tpKOZsaL6jrIrYbPvj26cWppIgFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DcKWEVpj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1B6070384
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 14:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69B1B6070384
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DcKWEVpj
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b30477a320so34111177b3.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 06:30:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794493848; cv=none;
        d=google.com; s=arc-20260327;
        b=JlO4Hblwuprl5XSKxL2SpXRRNgcAYjl6bpJjkxFWLnVKEg36My6c5HQsG2SJ/XvhB5
         4NYaHSMFNGNU8MyVEziPPNEfmOSJLiKa3R5ddWG4E3HFXbM6ljcy4UA0NQxRJzv/HGOz
         U9vTum/5Ryr0bgboXvW8DRcHXFAalLt8Z+Bzbyqy35FcFwlY5agdNsE6/UtFy5RpqhwV
         aNwSMawAp5P0YiF49+5bTSUljSTLxxpwX4hXa+9V82gplWhR/6p1cg5e9rqAJqOSuLIr
         Cn4UBe2NVp/kIHo8B7VIfHe+1FgVNw/Yctj9n311740o1GLN228Wuo6J2URjn3X3b/pU
         ry2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KDorLWQoT10iz7RcVWyX2HruLQSjSSle3gMrpViB5i4=;
        fh=14dSW2igIhBcAaTWww00Mqv3KSFkIY4FVDf5EGD72z0=;
        b=Z6Mqo3OjOP6AFKorcH2MrlnHS7YzH0X5ASpSe6k91281Sfvf1o2hf9+haH/bnHB6bQ
         DUOPOOcbw/7YlWdKVtoux1KDOS7NgUQUQHfmuHdQ5uG2lZKoevg+CCFn7XoN9kS6ygkg
         yfM1kIodeoL3q2ikn7mRXysuw/zUq4KIX0ZcQvqgfzDcejsbXLl236AL1a3rbGXBqHLP
         e5k2dkqabutiiiXRKTtD40YoGuzhPH6G0X7+YOcd1S9YeW9mrjCYcA9G4rOMSJEZz9QL
         +nC0muaWlb9RvKva4dlNi84U089zj8xHrqFKeypxpUNQQjsifVvawFKJJnA+wyNnQ55E
         ciKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794493848; x=1795098648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KDorLWQoT10iz7RcVWyX2HruLQSjSSle3gMrpViB5i4=;
        b=DcKWEVpj8YpbDNWMt3c4JqsN9IG28+vbifdzrZMH1B7YRtvNooZ/K32p4sx7lUYZae
         NnA79TskAoVtFjCECY+CIYGUgAKohJKT+SN6wLG0YTmkdsfo/cVgZUGQBqseltSfxsCm
         +m060AhbLi8lpNCLS9vltY+8QwUsmYF3ICVGpPJXMZ83e/QiIVHToYmTX16nB48lpZjX
         Y4BaaMQCSOpW+vTirOtTMqHvNnqp+Dyl0fIyIzZheJpMOK3tdRr6u4/VKUc/3SO/7/S5
         wREdAxyXMqHhDfBV8c3wFXyQMDkBN0sXVYJU7PY1CYELoX0mD80I/KnThA97yafwcIQb
         8bAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794493848; x=1795098648;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KDorLWQoT10iz7RcVWyX2HruLQSjSSle3gMrpViB5i4=;
        b=vi4VV+uMQTmBgupSHI60xe9hYPjrCgL9v0wid4GvX+fN2EPGJ1nIWcRuAWjknlZfxW
         kGZuR7vpQqxXhRwKpaDQZTL46ICgs6dv9z+sCF/rStD8avjKkLAxCTBiuSF3o1DqdQUA
         A1MyU5Aw21ODFY4mVNRpN+Rml9FMrWSr9jEuNi0Aer0oR7/v/WGgG73CKC1d4ndWWG5D
         UdDECEfCzPCPd8OSl9aFYOPsdRykHtq9POdFK1Gfu8yURS0In9onSXVI64aiHfzQQk0t
         hChMVHCldvQHH2ZhuzGpq3UK0U3J2L+WkXfZa+D4RimKRTeM1Z53AOHlqoWXGtG0srd8
         w8AQ==
X-Forwarded-Encrypted: i=1; AL+hErEHouwwgDYUSqMl8rOMTQ+xnXd86DrAPzM6Hh6NusZqnPDm9U8tgjdIMxkROC9fNLzSYIepyWQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hLXf98rwmPjfPR4uEWNJnsRZ8437bFpMauAdjQ62AVHOi4qD1
	VaFq4Y5CKD5IqdT2dIIk5fRbqd9lT+rPInZfMQt7TT8UQmQCwYmO+t4qv/OJbpLV2T76t0um9lV
	j39owhH5dmHPrXBbzoYTtVdWsKjUm4qI=
X-Gm-Gg: AYBFou3pdNfpsmWO0vPePLcAlzIYj7nZjqO/d7WM1C/0Zi6zwHQv+9hcDKU38ILsiRE
	zjEHQXUf0RruIUR0jQwrk5RhLKBSxiV1swDoZ2jDT8TNkds7J9CYXnebAWtQKJRAR/gpNOllkhR
	LTI99SmCIfc3pCM0dDl/JU9/kHVXZRQsvfdohT2Biyvq/zLg9CtX2vkIhzfAbaQhcp9kuT9l8RR
	ATxULjGP2LpwYEgJtuHhg5w3JCQwrp0VPcjgVx+mUA3Iq3dFvzd0tPMKJ/9J7TyiMf0KOUg50xg
	HzWlKpjkNYccy2usM2wLWxBKO37/hmsFw8AgddD3NLzZytdFs+6vxxSzPiXtkC3EkxW0nAsIiKN
	CuKN97w2NzQ52RG048ySmeRq7xfRcpPWURNKB5dz2BAH0lgpZ1R/E4WPNS838wMt0Y246+f59l8
	nHga3Od5XJTBQ+xAkl
X-Received: by 2002:a05:690c:7283:b0:8b0:6866:c5b6 with SMTP id
 00721157ae682-8b3a7db56ffmr37674567b3.9.1794493848329; Thu, 12 Nov 2026
 06:30:48 -0800 (PST)
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
In-Reply-To: <CAPb1+K1J2F-=cJF_+Z+RkA+9uLD8-15m3hDv71DSPG47XLJttw@mail.gmail.com>
From: Gideon Heinz <gideonheinz02@gmail.com>
Date: Thu, 12 Nov 2026 15:30:35 +0100
X-Gm-Features: AclHuK8KZbxnWeenAYFUPa7Ekefs4jSpSOYWOmDdf9hDYZ9zxZiKaZHuzCKQgDw
Message-ID: <CAPb1+K1pr7wtp-CCE4x4i4HzVkGfpiyXRBdqWJ-fmJpx_-pfqA@mail.gmail.com>
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

I tested your input core patch (=E2=80=9CInput: destroy force-feedback devi=
ce
on input unregistration=E2=80=9D) on a real kernel: CachyOS 7.3.4 (stable,
which already has an equivalent G920 init fix) plus only your patch,
with the stock hid-logitech-hidpp driver. The hidpp series is not
applied, since it doesn=E2=80=99t apply to 7.3.4 as is.

Same reproduction as before: fftest holding the G920 event node at the
effect prompt, rmmod hid_logitech_hidpp from another terminal, then
fftest exiting. The machine no longer goes down. The module unloaded
cleanly and the system stayed responsive.

One observation: with the stock driver, rmmod blocked for about 3
minutes. After =E2=80=9CUnloading HID++ force feedback.=E2=80=9D dmesg show=
s 12
=E2=80=9CFailed to send command to device!=E2=80=9D lines, 15.36 s apart (t=
he 3 x 5 s
retry per command), then rmmod returned. I assume these are the queued
effect erases timing out because the transport is already closed, and
that the series=E2=80=99 changes to hidpp_send_message_sync() and the
synchronous erase would remove this wait, but I have not tested that
combination on this kernel.

Tested-by: Gideon Heinz gideonheinz02@gmail.com

Thanks,
Gideon

On Thu, Nov 12, 2026 at 11:48=E2=80=AFAM Gideon Heinz <gideonheinz02@gmail.=
com> wrote:
>
> Hi Dmitry,
>
> I tested the out-of-tree equivalent you suggested, ff->destroy =3D NULL;
> in hidpp_ff_stop(), on top of the 33-patch v2 module (G920 046d:c262,
> 7.3.1-1-cachyos).
>
> Same reproduction as before: fftest holding the event node at the
> effect prompt, rmmod hid_logitech_hidpp from another terminal, then
> entering -1 in fftest.
> This time fftest exits normally, the machine stays up, and there are
> no errors in dmesg.
> The only message is the single =E2=80=9CUnloading HID++ force feedback.=
=E2=80=9D at rmmod time.
>
> I=E2=80=99ll try your input core patch on a rebuilt kernel later and repo=
rt back
>
> Thanks,
> Gideon
>
> On Thu, Nov 12, 2026 at 3:43=E2=80=AFAM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Gideon,
> >
> > On Thu, Nov 12, 2026 at 02:30:39AM +0100, Gideon Heinz wrote:
> > > Hi Dmitry,
> > >
> > > I tested v2 of the series on my G920 (046d:c262). Everything on my
> > > list works except one scenario that takes the whole machine down, wit=
h
> > > and without your series (last item).
> > ...
> > >  - rmmod with fftest holding the device open: rmmod returned after
> > >    2.99 s with "Unloading HID++ force feedback" and nothing else in
> > >    dmesg. When I then exited fftest (entering -1), the machine went
> > >    down: the first time with a garbled panic screen that I couldn't
> > >    read, and on later attempts as a total hang with no output. The
> > >    same sequence on stock Arch 7.2.11-arch1-1 with the unpatched
> > >    driver also hangs the whole system, so this predates the series.
> > >
> > >    To reproduce: with the module loaded and the G920 plugged in, star=
t
> > >    fftest on its event node and leave it at the effect prompt, run
> > >    "rmmod hid_logitech_hidpp" from another terminal, then enter -1 in
> > >    fftest.
> > >
> > >    I could not recover a trace yet and will send one if I manage to.
> > >
> > >    My guess, from reading the code and not verified by a trace:
> > >    hidpp_ff_create() stores hidpp_ff_destroy() and the other FF
> > >    callbacks in the ff_device as pointers into the module. With fftes=
t
> > >    holding the evdev open, the input_dev outlives the driver, so when
> > >    fftest closes, the final input_dev release calls ff->destroy in
> > >    module code that rmmod has already freed.
> >
> > Thank you very much for the thorough testing!
> >
> > Your diagnosis is spot on. Opening /dev/input/eventX pins the evdev cde=
v
> > (and through it input_dev), but does not hold a module reference on the
> > underlying HID driver. When rmmod unloads hid_logitech_hidpp while ffte=
st
> > still has the file descriptor open, __input_unregister_device() disconn=
ects
> > evdev (flushing effects, closing the device, and marking evdev dead so =
all
> > subsequent ioctls and writes return -ENODEV) and runs ff->stop(), after
> > which rmmod frees the module text. When fftest finally exits and closes=
 the
> > file descriptor, input_dev_release() calls input_ff_destroy(), which
> > invokes ff->destroy() pointing into the already-unmapped module text.
> >
> > Rather than working around this in individual drivers with a separate
> > ff->stop() callback, input core should call input_ff_destroy() directly=
 in
> > __input_unregister_device() once all handlers are disconnected and the
> > device is removed from sysfs. At that point nothing touches dev->ff
> > anymore, and calling input_ff_destroy() there guarantees ff->destroy()
> > always runs while the driver and its module are still loaded (while the
> > second input_ff_destroy() call in input_dev_release() becomes a no-op o=
nce
> > dev->ff is NULL).
> >
> > Could you try the input core patch below (with patch 22/33 "HID:
> > logitech-hidpp: shut down G920 force feedback on input unregister" drop=
ped
> > from the hid-logitech-hidpp series, since ff->stop is removed and
> > hidpp_ff_destroy() will now run on input unregistration)?
> >
> > Alternatively, if you prefer to test with your out-of-tree module build
> > without rebuilding the kernel, you can test the equivalent effect by
> > setting:
> >
> >         ff->destroy =3D NULL;
> >
> > inside hidpp_ff_stop() in hid-logitech-hidpp.c.
> >
> > Thanks.
> >
> > ---
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Subject: [PATCH] Input: destroy force-feedback device on input unregist=
ration
> >
> > When an input device is unregistered while userspace holds an open file
> > descriptor to its event node, input_dev_release() is deferred until the
> > last file descriptor is closed. Because input_ff_destroy() was only
> > called from input_dev_release(), force-feedback teardown (ff->destroy
> > and freeing ff->private) could run after the parent driver had already
> > unbound, freed its device state, or even been unloaded via rmmod,
> > causing use-after-free errors or page faults in unmapped module text.
> >
> > Commit ef166ce08801 ("Input: stop force-feedback timer when
> > unregistering input devices") added a separate ff->stop callback for
> > ff-memless, but left ff->destroy invoked from input_dev_release().
> >
> > Once __input_unregister_device() has disconnected all input handlers
> > (which flushes effects, closes the device, and marks evdev dead) and
> > deleted the device from sysfs, nothing accesses dev->ff anymore. Call
> > input_ff_destroy() directly in __input_unregister_device() so that
> > ff->destroy() always runs synchronously while the driver and its module
> > are still active, and remove the now-redundant ff->stop callback. Keep
> > input_ff_destroy() in input_dev_release() (where it is a no-op once
> > dev->ff is NULL) to handle input_free_device() on devices that were
> > never registered.
> >
> > Fixes: 509ca1a93836 ("Input: implement new force feedback interface")
> > Cc: stable@vger.kernel.org
> > Reported-by: Gideon Heinz <gideonheinz02@gmail.com>
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/ff-core.c    |  2 +-
> >  drivers/input/ff-memless.c | 23 -----------------------
> >  drivers/input/input.c      |  5 ++---
> >  include/linux/input.h      |  3 ---
> >  4 files changed, 3 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
> > index 0e5d1d1ceb46..133b4622dc49 100644
> > --- a/drivers/input/ff-core.c
> > +++ b/drivers/input/ff-core.c
> > @@ -338,7 +338,7 @@ EXPORT_SYMBOL_GPL(input_ff_create);
> >   *
> >   * This function is only needed in error path as input core will
> >   * automatically free force feedback structures when device is
> > - * destroyed.
> > + * unregistered or destroyed.
> >   */
> >  void input_ff_destroy(struct input_dev *dev)
> >  {
> > diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
> > index d1fefd1dfc0d..3069436148ec 100644
> > --- a/drivers/input/ff-memless.c
> > +++ b/drivers/input/ff-memless.c
> > @@ -483,32 +483,10 @@ static void ml_ff_destroy(struct ff_device *ff)
> >  {
> >         struct ml_device *ml =3D ff->private;
> >
> > -       /*
> > -        * The timer is normally shut down in ml_ff_stop() when the dev=
ice
> > -        * is unregistered. However, we still shut it down here as a sa=
fety
> > -        * net and for cases where the device was never registered (e.g=
.
> > -        * error paths during probe).
> > -        */
> >         timer_shutdown_sync(&ml->timer);
> > -
> >         kfree(ml->private);
> >  }
> >
> > -static void ml_ff_stop(struct ff_device *ff)
> > -{
> > -       struct ml_device *ml =3D ff->private;
> > -
> > -       /*
> > -        * Even though we stop all playing effects when tearing down an
> > -        * input device (by the way of evdev calling input_flush_device=
()
> > -        * that calls into input_ff_flush() that stops and erases all
> > -        * effects), we do not actually shutdown the timer, and therefo=
re
> > -        * we should do it here to prevent it firing after the input
> > -        * device is unregistered and its associated resources are free=
d.
> > -        */
> > -       timer_shutdown_sync(&ml->timer);
> > -}
> > -
> >  /**
> >   * input_ff_create_memless() - create memoryless force-feedback device
> >   * @dev: input device supporting force-feedback
> > @@ -543,7 +521,6 @@ int input_ff_create_memless(struct input_dev *dev, =
void *data,
> >         ff->playback =3D ml_ff_playback;
> >         ff->set_gain =3D ml_ff_set_gain;
> >         ff->destroy =3D ml_ff_destroy;
> > -       ff->stop =3D ml_ff_stop;
> >
> >         /* we can emulate periodic effects with RUMBLE */
> >         if (test_bit(FF_RUMBLE, ff->ffbit)) {
> > diff --git a/drivers/input/input.c b/drivers/input/input.c
> > index 210635ef147e..7be69deed8eb 100644
> > --- a/drivers/input/input.c
> > +++ b/drivers/input/input.c
> > @@ -2286,10 +2286,9 @@ static void __input_unregister_device(struct inp=
ut_dev *dev)
> >                 input_wakeup_procfs_readers();
> >         }
> >
> > -       if (dev->ff && dev->ff->stop)
> > -               dev->ff->stop(dev->ff);
> > -
> >         device_del(&dev->dev);
> > +
> > +       input_ff_destroy(dev);
> >  }
> >
> >  static void devm_input_device_unregister(struct device *dev, void *res=
)
> > diff --git a/include/linux/input.h b/include/linux/input.h
> > index 3381608127f7..02047cc45d04 100644
> > --- a/include/linux/input.h
> > +++ b/include/linux/input.h
> > @@ -549,8 +549,6 @@ extern const struct class input_class;
> >   * @set_autocenter: Called to auto-center device
> >   * @destroy: called by input core when parent input device is being
> >   *     destroyed
> > - * @stop: called by input core when parent input device is being
> > - *     unregistered
> >   * @private: driver-specific data, will be freed automatically
> >   * @ffbit: bitmap of force feedback capabilities truly supported by
> >   *     device (not emulated like ones in input_dev->ffbit)
> > @@ -579,7 +577,6 @@ struct ff_device {
> >         void (*set_autocenter)(struct input_dev *dev, u16 magnitude);
> >
> >         void (*destroy)(struct ff_device *);
> > -       void (*stop)(struct ff_device *);
> >
> >         void *private;
> >
> >
> > --
> > Dmitry
