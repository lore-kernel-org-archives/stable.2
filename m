Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADD51CEAC2;
	Wed,  3 Jun 2026 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507627; cv=none; b=J/DQ7sJEHSYlyb0DJ49QZ8aJOEQLNUZaWyO2hQPqglvE5zbhanNLyi1xDAHHpdir8JmiujqO6fEDUO4pdm9tgLlCk1xa8bXmAOaaZG2vfSHwTBk3WzhTtA5qDyMPFx9bVa0Ik7s0ph3tERZGqrZbEjbOCSvI2AaQH48MEk1fLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507627; c=relaxed/simple;
	bh=UVvNrn/3xlqp1WnAhDjUrcaAgH2tqNYL66yMuvxS2RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q07QVZuY7SNLCq3Xi0ecXHIc7WcNSu8J4d7/XEzpx0c30ZnBVkX1wsRSD1JzjcJEzPYN++PwTZRK+BjKxgR7sUruwx+/YDsrqY5zUgB+senOyLr4aWBaauEpUxI3lSGHkzXMBDDPkqjn9wHTZcQwOlyknP329rHyCRuc4Z2Dbos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0JLZJ+P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0JLZJ+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646AD1F00893;
	Wed,  3 Jun 2026 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780507625;
	bh=xcmJvqISsNraB/smBz/xdAVYY/K30DCW6Tna1tXZpkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K0JLZJ+Pcd+Ryu1Ecw9KWzuM7Bn73VQz3sJnVstxF7HTlu/gpJZU7I2TYaYjntY1j
	 m0b6tayoFakFfSeAmmXRd6KkwkhX3WNJs+LhFGf/S4R+iHpk5y+hNDt8F1So5waIYh
	 NlYG4AlJhQDwl1kgqhMWn6cpA2wn8wDpN9hnEgZoIxRfM4xS/NbXek1+QKuDsDQY/z
	 V1ZDbFhOvLDq6JWtpPg/zTigAkWjLYg9Q1aV7tGqbLCNxz1B7fv0uEEt7OXoREXlOU
	 5hMEm7a6BuXEl2o7P8BbrYL+6Wx66+3p/YXOt1WtQhwKpso4cFONCDr/X519wZ7qy8
	 k2Jtl5h0Xf0xw==
Date: Wed, 3 Jun 2026 18:26:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: rohm-bm1390: notify trigger on all
 error paths
Message-ID: <20260603182658.2c3c6efa@jic23-huawei>
In-Reply-To: <aa2c2f98-454d-489c-a652-b8023b0773bf@gmail.com>
References: <20260517160801.269-1-sozdayvek@gmail.com>
	<20260518094238.1986-1-sozdayvek@gmail.com>
	<20260518161516.53f21777@jic23-huawei>
	<61d9cec3-6aed-416f-9604-94fe94cb2e3b@gmail.com>
	<20260520120822.351aa58f@jic23-huawei>
	<0d58842a-aa5c-4d12-9435-3264070038cc@gmail.com>
	<aa2c2f98-454d-489c-a652-b8023b0773bf@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 May 2026 11:21:40 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 22/05/2026 15:38, Matti Vaittinen wrote:
> > On 20/05/2026 14:08, Jonathan Cameron wrote: =20
> >> On Tue, 19 May 2026 08:48:13 +0300
> >> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >> =20
> >>> Thanks Jonathan,
> >>>
> >>> Your post give me something to think about ;) =20
> >>
> >> This is a can of worms.=C2=A0 More below.
> >>
> >> I'm unconcerned as long as (and ideally someone should check it)
> >> we can get of being stuck by unbind/rebind of driver.=C2=A0 Anything
> >> else is best effort.
> >>
> >> =20
> >>>
> >>> On 18/05/2026 18:15, Jonathan Cameron wrote: =20
> >>>> On Mon, 18 May 2026 14:42:38 +0500
> >>>> Stepan Ionichev <sozdayvek@gmail.com> wrote: =20
> >>>>> bm1390_trigger_handler() returns from three error paths without
> >>>>> calling iio_trigger_notify_done(). The success path at the end
> >>>>> does, so on a single transient regmap or read failure the trigger
> >>>>> use_count is never decremented, and the !atomic_read(&trig->use_cou=
nt)
> >>>>> guard in iio_trigger_poll_chained() drops every subsequent dispatch.
> >>>>> The buffered-data flow stays wedged until the trigger is detached.
> >>>>>
> >>>>> Funnel all returns through a single done label that calls
> >>>>> iio_trigger_notify_done() and reports the outcome via IRQ_RETVAL().
> >>>>>
> >>>>> Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
> >>>>> Cc: stable@vger.kernel.org
> >>>>> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com> =20
> >>>>
> >>>> These error path 'fixes' are fixes for hardware failure - so if=20
> >>>> anything
> >>>> they are hardending=C2=A0 against a possible error condition. I don'=
t mind
> >>>> that bit it's not a bug to not do this so fixes tag an stable are not
> >>>> appropriate for any of these.
> >>>>
> >>>> Note however that hardening against these conditions is not this=20
> >>>> simple.
> >>>> It takes careful analysis of exactly how the hardware behaves and wh=
at
> >>>> each error condition 'might' mean.=C2=A0 Whilst they are probably ha=
rmless
> >>>> I'm also very dubious about taking them without comprehensive testing
> >>>> on the particular device. =20
> >>>>> --- =20
> >=20
> > //snip
> >  =20
> >>>>> @@ -639,7 +642,8 @@ static irqreturn_t bm1390_trigger_handler(int=20
> >>>>> irq, void *p)
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D bm1390_pressure_read(data, &data->buf.pressure);
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (re=
t) {
> >>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev_warn(data->dev, "sample read failed %d\n", ret);
> >>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 return IRQ_NONE;
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 handled =3D false;
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 goto done; =20
> >>>>
> >>>> Hopefully all this stuff is unrelated to the trigger.=C2=A0 For thes=
e it=20
> >>>> is fair to
> >>>> ack the trigger and the interrupt.=C2=A0 Curiously the driver does i=
t=20
> >>>> partly for the
> >>>> next one (IRQ_HANDLED). =20
> >>>
> >>> I would keep the IRQ_NONE here because, if we keep constantly failing
> >>> the reads, then the bus is likely to be unerliable - and disabling the
> >>> useless IRQ is probably very sane thing to do. It should help debuggi=
ng.
> >>> What comes to acking the trigger - I am starting to agree with Stepan,
> >>> we should probably ack the trigger in any case. If we don't ack the
> >>> trigger, then the IRQ_NONE does not serve the purpose it is intended=
=20
> >>> for. =20
> >>
> >> The interrupt that we'd get spurious detection on here would not be=20
> >> the device
> >> one it would be the software emulated one deep in the iio trigger stuf=
f.
> >>
> >> Might still be useful for debug. Anyone fancy hacking an error in and=
=20
> >> reporting
> >> back what we actually get from the debug hardware?=C2=A0 (with that tr=
igger=20
> >> acked
> >> as you suggest?) =20
> >=20
> > No promises but I'll see if I can try out something next week... =20
>=20
> The week has been horrible... I only had around half an hour for this=20
> (just now). Quick:
>=20
> +++ b/drivers/iio/pressure/rohm-bm1390.c
> @@ -621,6 +621,16 @@ static const struct iio_buffer_setup_ops=20
> bm1390_buffer_ops =3D {
>          .predisable =3D bm1390_buffer_predisable,
>   };
>=20
> +/*
> + * Test case where IRQ status is nopt read (acked). Useful for=20
> evaluating the
> + * impact of returning the IRQ_NONE from the trigger handler. define=20
> also the
> + * TEST_FORCE_IRQ_NOTIFY if you wish to cause the trigger to be notified.
> + *
> + * Note, in case it is not obvious, this will cause IRQ storm.
> + */
> +#define TEST_FORCE_IRQ_NONE
> +#define TEST_FORCE_IRQ_NOTIFY
> +
>   static irqreturn_t bm1390_trigger_handler(int irq, void *p)
>   {
>          struct iio_poll_func *pf =3D p;
> @@ -628,12 +638,27 @@ static irqreturn_t bm1390_trigger_handler(int irq,=
=20
> void *p)
>          struct bm1390_data *data =3D iio_priv(idev);
>          int ret, status;
>=20
> +#ifdef TEST_FORCE_IRQ_NONE
> +       static unsigned long int first =3D 1, first2 =3D 0;
> +       ret =3D 0;
> +
> +       if (first) {
> +               pr_info("Skip read\n");
> +               first =3D 0;
> +       }
> +       #ifdef TEST_FORCE_IRQ_NOTIFY
> +       status =3D BIT(BM1390_CHAN_PRESSURE);
> +       #else
> +       status =3D 0;
> +       #endif
> +#else
>          /* DRDY is acked by reading status reg */
>          ret =3D regmap_read(data->regmap, BM1390_REG_STATUS, &status);
>          if (ret || !status)
>                  return IRQ_NONE;
> +#endif
>=20
> -       dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
> +//     dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
>=20
>          if (test_bit(BM1390_CHAN_PRESSURE, idev->active_scan_mask)) {
>                  ret =3D bm1390_pressure_read(data, &data->buf.pressure);
> @@ -656,7 +681,17 @@ static irqreturn_t bm1390_trigger_handler(int irq,=20
> void *p)
>                                      data->timestamp);
>          iio_trigger_notify_done(idev->trig);
>=20
> +#ifdef TEST_FORCE_IRQ_NONE
> +       /* HACK, return IRQ_NONE and see if IRQ gets disabled */
> +       if (!(first2 % 1000))
> +               pr_info("Hack, return IRQ_NONE (%lu th)\n", first2);
> +
> +       first2++;
> +
> +       return IRQ_NONE;
> +#else
>          return IRQ_HANDLED;
> +#endif
>   }
>=20
>   /* Get timestamps and wake the thread if we need to read data */
>=20
>=20
>=20
> resulted:
> root@arm:/home/debian# /iio_generic_buffer -a -c1000000 --device-name=20
> bm1390 -T0 > /dev/null
> Enabling all channels
> [  115.098819] Skip read
> [  115.102442] Hack, return IRQ_NONE (0 th)
> [  116.459049] Hack, return IRQ_NONE (1000 th)
> [  117.851037] Hack, return IRQ_NONE (2000 th)
> [  119.214843] Hack, return IRQ_NONE (3000 th)
> [  120.598114] Hack, return IRQ_NONE (4000 th)
> [  121.960255] Hack, return IRQ_NONE (5000 th)
> [  123.322424] Hack, return IRQ_NONE (6000 th)
>=20
> //snip
>=20
> [  237.726666] Hack, return IRQ_NONE (90000 th)
> [  239.095910] Hack, return IRQ_NONE (91000 th)
> [  240.481233] Hack, return IRQ_NONE (92000 th)
> [  241.846072] Hack, return IRQ_NONE (93000 th)
> [  243.206432] Hack, return IRQ_NONE (94000 th)
> [  244.570636] Hack, return IRQ_NONE (95000 th)
> [  245.928964] Hack, return IRQ_NONE (96000 th)
> [  247.286839] Hack, return IRQ_NONE (97000 th)
> [  248.647986] Hack, return IRQ_NONE (98000 th)
> [  250.011214] Hack, return IRQ_NONE (99000 th)
> [  251.368583] irq 64: nobody cared (try booting with the "irqpoll" optio=
n)
> [  251.375463] CPU: 0 UID: 0 PID: 835 Comm: irq/63-2-005d-b Tainted: G=20
>          O        7.1.0-rc1-00002-g3b459deb7222-dirty #249 VOLUNTARY
> [  251.375501] Tainted: [O]=3DOOT_MODULE
> [  251.375511] Hardware name: Generic AM33XX (Flattened Device Tree)
> [  251.375525] Call trace:
> [  251.375545]  unwind_backtrace from show_stack+0x10/0x14
> [  251.375607]  show_stack from dump_stack_lvl+0x50/0x64
> [  251.375646]  dump_stack_lvl from __report_bad_irq+0x30/0xbc
> [  251.375680]  __report_bad_irq from note_interrupt+0x2b4/0x32c
> [  251.375722]  note_interrupt from handle_nested_irq+0x13c/0x14c
> [  251.375758]  handle_nested_irq from iio_trigger_poll_nested+0x4c/0x68=
=20
> [industrialio]
> [  251.375917]  iio_trigger_poll_nested [industrialio] from=20
> bm1390_irq_thread_handler+0x54/0x7c [rohm_bm1390]
> [  251.375994]  bm1390_irq_thread_handler [rohm_bm1390] from=20
> irq_thread_fn+0x1c/0x78
> [  251.376028]  irq_thread_fn from irq_thread+0x18c/0x324
> [  251.376057]  irq_thread from kthread+0xf8/0x130
> [  251.376091]  kthread from ret_from_fork+0x14/0x20
> [  251.376114] Exception stack(0xe0355fb0 to 0xe0355ff8)
> [  251.376136] 5fa0:                                     00000000=20
> 00000000 00000000 00000000
> [  251.376156] 5fc0: 00000000 00000000 00000000 00000000 00000000=20
> 00000000 00000000 00000000
> [  251.376175] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [  251.376189] handlers:
> [  251.498714] [<2ec7a5d9>] iio_pollfunc_store_time [industrialio]=20
> threaded [<7f4268a2>] bm1390_trigger_handler [rohm_bm1390]
> [  251.509974] Disabling IRQ #64
>=20
> Message from syslogd@arm at Jan  1 01:17:33 ...
>   kernel:[  251.509974] Disabling IRQ #64
> [  252.822500] sched: RT throttling activated
>=20
>=20
> Things I very hastly picked up:
>=20
> 1. The throttling mechanism works even though the handling is invoked=20
> via iio_trigger_poll_nested(), Probably because this propagates the call=
=20
> to the handle_nested_irq() - which does bookkeeping.

Great.  At least it squashes something.

>=20
> 2. For some reason (which I didn't have time to check yet), the=20
> beaglebone black which I used to run this, was not completely blocked by=
=20
> the IRQ. We can see the "Hack, return IRQ_NONE (xxx th)" -prints=20
> emerging just fine.

After the Disabling IRQ #64 message?

>=20
> And now I must run. I hope to be able to dig some more details next week.
>=20
> Yours,
> 	-- Matti
>=20
>=20

