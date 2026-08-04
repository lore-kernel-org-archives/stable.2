Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03135410D19
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878669; cv=pass; b=h7WTrG4JxKSQgaDUr96Hs6+8+5iIu+VyeiYQFCMGzhmfybNjEyGfIIqprG7s6cwKeSkbrLTA9S0Ezd/5TBpSHsTyXHmWBm21SZkx9CH+TeM66lqM/JBU+h5QodVYG5DT92QzJp3/kG1KwfkN/K0RobiqbVeVeBnHmjqfBX9Eddc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878669; c=relaxed/simple;
	bh=qhoplxcsPlPlQxGa9N6TxJszQtVQ0ovzhzuZ6wX4cLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDzOTDSrUBvO8Aq2xICdIz/WmYXKcRjJqJnmUAy0l1E/hG5sYBOFqGH6Cz/bwppW/01KLK0NlRmZMenhHVIuwzNzb5U/RhFhqPx6RjfZmc/X/uoB7F4CeOTEJMyEf9mCL3A71pnqv4l1TGCy4wAOPWDRE2GZocZL4ZDaSMR8qwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAnjo+j2; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAnjo+j2"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8efec2c28f8so2135686d6.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 14:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785878666; cv=none;
        d=google.com; s=arc-20260327;
        b=CRZ4/DAkywxbJlSa9GE4+Dq8U/lZNNg0GUmJQTyHIxBXCnFYGZR4xdf7IgxiGp16PN
         3H7O7F4PcNpYBCSgCeJ2Nf0XDuUNaTmtlAu3x1IkijJGN4U0jIJyaaLk2UCrLwVmfHXL
         YBWAhrGRQxKM797WXJczSVD8HvPtflKI9AfmKv/gQbiWO1XDwFXXu2gFIuTDpdju7wpV
         SIN4HyDk7X1WI4sS9qHMK686XdTxpxApjOCO6ixk5QfPF4Bp9Y9bk0XbXuFv/dw6ml2H
         N0rKcLFD6NeVlCpQHcAm+4cU7PPd9eMMdSVRRV66UGArMP8vMgDmq9UW+3iHIWZboIg9
         krXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gq+MUKDacKd20nIARJewZ4iMEg7AQMRnpuihSwEKTAs=;
        fh=sc30mgPCYHYwu+7+AeNJe16ZDhjJR2CLlNYkXdIiGPA=;
        b=k77aMnwbY+JKYnNkhG0m+ziXMcBAoc2G+629hC438ECt0/bVok+28RSXkdPG21pQmX
         9+q6CofDVatCoEMLvNohXlkk7teraaw3KtyW+kaZ5SF9kNXjbbY/OoBeXOsho+sagOGD
         tp8/TCQbJHGYTvqqxkBzCaxX+FdQnj72+4mnGBozAd4Yz7IjGjKzI/MmnaYEIyYuL4F6
         yLAKSkGu9wdzoNt8FnHv89wO+BkfJSZ92dVm1b3F3OanjkGXWkG0VoZBj0SrbNr4R326
         dmTl+y+JrWfSeorE2d95EqwZnJMLe2pfGvSdG2oFaCMA08tn/qFJRBah9ey3d52IcMuv
         EhFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785878666; x=1786483466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gq+MUKDacKd20nIARJewZ4iMEg7AQMRnpuihSwEKTAs=;
        b=kAnjo+j2q0Omt523pF2ZO1HKyGh8SmDgc5X6JGPCiQnK6qsp2eipIx7XfV1vZ/VTJK
         8YkDhgxK5fbDiLyi90DTlOc8sNbmPGFiH7H90CFVe2h+1u9tw3SKJTppzqFjEsz7nVYj
         tNZUWWXFEcLg3knj4jn1BZAL5ri/5zpdTqyKSo9tx+nFLbjWCY4m/2++hz3uteDNeVX+
         uguIKtBiLSoMMUEKL6MJPq8rWS3FicF6ehvG1PHWka5DvI+OOUUXCaWFypSSxmW1Z6xZ
         qU6miCWGV8woJ8a6+gJo6AUYweaQ/mpszdAewyKfYghCaB7NPmDscGjoqqgU3GPlgmXP
         4Thw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878666; x=1786483466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gq+MUKDacKd20nIARJewZ4iMEg7AQMRnpuihSwEKTAs=;
        b=T/lrYds8ymUXoqxBvDXBJRsS5rW9evZwd4ivH1lS3KNTtHPf7p8XLvhvlEdnaI5+mH
         6wO0m9S5Egmw+8GloSQ842wUdvkKU8tnbvHnZ2WNF8Gb4poGAUa6ZNh4vBHh7PDEFMUr
         ZYlHedgzCFF0B+UdKeWDWd0XwIvtXcOEvpiolODMKqeUoX8WdZqwN4zJ0KIojF54efRJ
         x1xMFODWGKBJ/CE9+tRtsRIWt427nmeabkVFKct61rygD56M+6b8J8vnXiXEx8jHGJg/
         qXNx3Nz5i78FqzsOkTSYSUTPD+3YYq69TFfaDdlIwedvgSyFlk7CMdnGbwgonzIYbr4P
         MRwg==
X-Forwarded-Encrypted: i=1; AHgh+RoSz9UrKkjEQSNYDptrZ7T+OVY9UgN8iasr0qHu1vSS5a2xHp+uP5MPxn6Gkh1J1PrIv3kO37A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLlfe5CTKwhiWkJKNDXznUhNpOk2fXbccPs4hjGQRI5NcSK3Ln
	6UtzyV+xXRwBO6yVZNHFEMSlevPVxFclv+HWL+lL5W+enOFWo5CJUIxleivWtY8hMG5Qn9bgmch
	sGu4DfnNI/f3rmnYOtm02DDX7nCPjpI8=
X-Gm-Gg: AR+sD13U3046UVxb3ll4tjz6kTuLDBocUCF6YopsCOw4oA9IAz4XpfsPwXhQtRFl9yv
	wxmewtAUpEVfvge5tFaJJQDVwVPfrU216LnrcO2FlE6Qg4HahdhO8xr4A6Z+NKDvzXcLW3JAcbN
	BewldFJdOrvdvp9CdQCsllxEynKvg7NsQ/TeCkicR77wq/UnhahhbGJ/LSs5QouRdXbreNUbY7n
	Q8PQsWUMWD/4o4jfrYjPyyjsMDjnXu4ARK3keQIJcx/8pUrIWnshnXNt8lxQ/de/J1bPexEE/2K
	/D5IfunIXHPxn8TkhPPTLL6P7hGO1pWa0lfDwxHZXeuUHw==
X-Received: by 2002:a05:6214:29c5:b0:8ee:b05c:596f with SMTP id
 6a1803df08f44-908813906a1mr24331156d6.29.1785878665744; Tue, 04 Aug 2026
 14:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804-oxp-fix-v2-1-b2d56e4c8a2c@cherr.cc> <anJGWjlmRxNMoVLG@pve>
In-Reply-To: <anJGWjlmRxNMoVLG@pve>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Tue, 4 Aug 2026 14:24:14 -0700
X-Gm-Features: AUfX_mznOw_7JiYF__-vYe-VFVFf4YkwSS6Io4SwesibnWPrVP7sa-DrKQAlbF8
Message-ID: <CAFqHKT=AEy0-AZsUmcFGbo1iQ00J+ZMdY_9dNJp64wq1QSk6Gw@mail.gmail.com>
Subject: Re: [PATCH v2] HID: hid-oxp: fix UAF on pending work in remove()
To: Shengzhuo Wei <me@cherr.cc>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Zhouwang Huang <honjow311@gmail.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:06=E2=80=AFPM Shengzhuo Wei <me@cherr.cc> wrote:
>
> On 2026-08-04 17:50, Shengzhuo Wei wrote:
> > ---
> >  drivers/hid/hid-oxp.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> > index 20a54f337220dc2aee3483a14d542b66c487bd60..abd622ff1b26b312ad9c8a4=
375822832f8371533 100644
> > --- a/drivers/hid/hid-oxp.c
> > +++ b/drivers/hid/hid-oxp.c
> > @@ -1501,14 +1501,14 @@ static int oxp_cfg_probe(struct hid_device *hde=
v, u16 up)
> >       drvdata.gamepad_mode =3D OXP_GP_MODE_XINPUT;
> >       drvdata.rumble_intensity =3D 5;
> >
> > -     INIT_DELAYED_WORK(&drvdata.oxp_mcu_init, oxp_mcu_init_fn);
> > -     mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffi=
es(50));
> > -
> >       ret =3D devm_device_add_group(&hdev->dev, &oxp_cfg_attrs_group);
> >       if (ret)
> >               return dev_err_probe(&hdev->dev, ret,
> >                                    "Failed to attach configuration attr=
ibutes\n");
> >
> > +     INIT_DELAYED_WORK(&drvdata.oxp_mcu_init, oxp_mcu_init_fn);
> > +     mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffi=
es(50));
> > +
> >       return 0;
> >  }
> >
> > @@ -1552,9 +1552,9 @@ static int oxp_hid_probe(struct hid_device *hdev,
> >
> >  static void oxp_hid_remove(struct hid_device *hdev)
> >  {
> > -     cancel_delayed_work(&drvdata.oxp_rgb_queue);
> > -     cancel_delayed_work(&drvdata.oxp_btn_queue);
> > -     cancel_delayed_work(&drvdata.oxp_mcu_init);
> > +     disable_delayed_work_sync(&drvdata.oxp_rgb_queue);
> > +     disable_delayed_work_sync(&drvdata.oxp_btn_queue);
> > +     disable_delayed_work_sync(&drvdata.oxp_mcu_init);
> >       hid_hw_close(hdev);
> >       hid_hw_stop(hdev);
> >  }
> >
> > ---
>
> Hi Dmitry,
>
> Thanks again for the v1 review. Sashiko's v2 review raised two points I
> want to act on:
>
> 1. "Uninitialized work struct access during early raw events" -- agreed.
>    v2 moved INIT_DELAYED_WORK(&drvdata.oxp_mcu_init) to the end of
>    oxp_cfg_probe(), widening the window in which an early status report
>    could mod_delayed_work() a not-yet-initialized (zeroed) work. I'll
>    fix this in v3 by keeping INIT_DELAYED_WORK() before
>    devm_device_add_group() and moving only the mod_delayed_work() after
>    it: the work is then initialized before any raw event can arm it,
>    while a probe failure still can't leave it armed.
>
Hi Shengzhuo,

I dealt with this when writing the hid-msi drivers as well, and
Sashiko will continuously come up with new issues for each revision.
The next issue is going to be that the attributes are initialized
before the setup function has run to query the device after the MCU
will accept messages. The solution I found was to move
devm_device_add_group to the end of the init work queue once the query
has been completed, then inform sysfs with a `change` uevent. Perhaps
that pattern will be useful here.

For ease of reviewing, below is the cfg_setup_fn from that driver

> 2. "Global workqueues permanently disabled on inert interface removal."
>    The driver keeps all state in a single static global drvdata, and
>    module_hid_driver() binds it to every interface of the device, so
>    oxp_hid_remove() runs when any interface is unbound. With
>    disable_delayed_work_sync() and no enable_delayed_work() anywhere,
>    unbinding an inert interface disables the works for the still-bound
>    gamepad interface. cancel_delayed_work_sync() (v1) re-enabled them,
>    so it didn't have this side effect.
>
>    This looks like a symptom of the static-global-drvdata issue rather
>    than disable_delayed_work_sync() itself -- with per-device drvdata
>    each interface would have its own works. Before I send v3, would you
>    prefer to keep disable_delayed_work_sync() (and address the
>    multi-interface case via the per-device drvdata refactor you
>    mentioned as a separate patch), or go back to
>    cancel_delayed_work_sync()? I'll hold v3 until I hear from you.
>

I had planned on devm_alloc the drvdata per device once the msi
drivers are done. If you are willing to take that on I'll be glad to
test with my F1 Pro. Out of curiosity, do you have a device available
to test as well? If so, which model do you have? I can ask the
community to test on any device family that isn't covered.

To your question, I don't think the bug fix switching to
disable_delayed_work_sync is worth the side effects without first
addressing the global drvdata issue. That would introduce a true
regression to fix a theoretical logic bug. I would rather you either
switch to the devm_alloc drvdata first or hold that change until I'm
able to do it later myself.

Thanks,
Derek

---

static void cfg_setup_fn(struct work_struct *work)
{
    struct delayed_work *dwork =3D container_of(work, struct delayed_work, =
work);
    struct claw_drvdata *drvdata =3D container_of(dwork, struct
claw_drvdata, cfg_setup);
    bool gamepad_ready =3D false, rgb_ready =3D false, gp_registered,
rgb_registered;
    int ret;

    ret =3D claw_hw_output_report(drvdata->hdev,
CLAW_COMMAND_TYPE_READ_GAMEPAD_MODE,
                    NULL, 0, 25);
    if (ret) {
        dev_err(&drvdata->hdev->dev,
            "Failed to read gamepad mode: %d\n", ret);
        goto prep_rgb;
    }
    gamepad_ready =3D true;

prep_rgb:
    ret =3D claw_read_rgb_config(drvdata->hdev);
    if (ret) {
        dev_err(&drvdata->hdev->dev,
            "Failed to read RGB config: %d\n", ret);
        goto try_gamepad;
    }
    rgb_ready =3D true;

    /* Add sysfs attributes after we get the device state */
try_gamepad:
    scoped_guard(spinlock_irqsave, &drvdata->registration_lock)
        /* Pairs with smp_store_release from below */
        gp_registered =3D smp_load_acquire(&drvdata->gp_registered);

    if (!gp_registered && gamepad_ready) {
        ret =3D device_add_group(&drvdata->hdev->dev, &claw_gamepad_attr_gr=
oup);
        if (ret) {
            dev_err(&drvdata->hdev->dev,
                "Failed to create gamepad attrs: %d\n", ret);
            goto try_rgb;
        }

        scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
            /* Pairs with smp_load_acquire in attribute show/store function=
s */
            smp_store_release(&drvdata->gp_registered, true);
            gp_registered =3D true;
        }
    }

try_rgb:
    /* Add and enable RGB interface once we have the device state */
    scoped_guard(spinlock_irqsave, &drvdata->registration_lock)
        /* Pairs with smp_store_release from below */
        rgb_registered =3D smp_load_acquire(&drvdata->rgb_registered);

    if (!rgb_registered && rgb_ready) {
        ret =3D led_classdev_multicolor_register(&drvdata->hdev->dev,
                               &drvdata->led_mc);
        if (ret) {
            dev_err(&drvdata->hdev->dev,
                "Failed to create led device: %d\n", ret);
            goto update_kobjects;
        }

        ret =3D device_add_group(drvdata->led_mc.led_cdev.dev,
&claw_rgb_attr_group);
        if (ret) {
            dev_err(&drvdata->hdev->dev,
                "Failed to create RGB attrs: %d\n", ret);
            led_classdev_multicolor_unregister(&drvdata->led_mc);
            goto update_kobjects;
        }

        scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
            /* Pairs with smp_load_acquire in attribute show/store function=
s */
            smp_store_release(&drvdata->rgb_registered, true);
            rgb_registered =3D true;
        }
    }

update_kobjects:
    if (gp_registered)
        kobject_uevent(&drvdata->hdev->dev.kobj, KOBJ_CHANGE);
    if (rgb_registered)
        kobject_uevent(&drvdata->led_mc.led_cdev.dev->kobj, KOBJ_CHANGE);
}
> The remaining sashiko items look pre-existing and outside this fix.
>
> Thanks,
> Shengzhuo
