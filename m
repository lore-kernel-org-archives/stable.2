Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD0267B07;
	Mon,  3 Aug 2026 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723895; cv=none; b=u3pHY2zkNuqXONJQpQkr0QYGWyBSyQw+6GtsltRGGwoh4fbcD8+PK/Wni72LRgIeWL0Flw82TplDXX041bdpbokD0VMy//0mVt76RyqqrBRGkCTZYHS7C3XooxifmdCNHwjLoA8qpwvGFIsSYmI81GmVlot7fq3xauYrVFIGEF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723895; c=relaxed/simple;
	bh=TnloNG3nyTvN95QXspzsAKEZhIb1g3pkwCbMvt05xTA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sM6WywpkIrW2PAGNlWH1rAHCJnwtrsYC4nnSQWT7rXAwVs48PAZE4CR6CleWYQbn6whPAy+MDNYi+Wjwl21YwsUNfEnl9rFCB78T9+XZBrLZ9p4iyXz91cxkRx4RK83SweB8TV4gxTuw//toiX3zS09xYRZsUszqbVm9hyCaLvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ranostay.sg; spf=pass smtp.mailfrom=ranostay.sg; dkim=pass (2048-bit key) header.d=ranostay.sg header.i=@ranostay.sg header.b=H6D1Xltk; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ranostay.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ranostay.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ranostay.sg header.i=@ranostay.sg header.b="H6D1Xltk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ranostay.sg;
	s=protonmail3; t=1785723882; x=1785983082;
	bh=Ol4ZXF2kk2y+41SXRJwYuL/nCwLep1FT+iOV7QVA9nU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=H6D1Xltk9iJJiaNkzd+YJiQKxG+4T4npGGp89SO/Rs8lWJJjOu7g1+QqGNjRikPzj
	 VLjH1oIpZjoU+5n7b7J2e5x04AERt9G7S++XDzwNtiqJ9Sl6vPOtdr1U70lNu28UYj
	 ink3ehybaYOlJPjsQiDG93jOBIt0SQx4TGDzt2IVn0/pnY26gA6mQvmDRS3H7ny3MW
	 Rna2Tr7EoV12cRFN33oQdCiXIHJqMicIbDFZhXowwvShDtGv2/IfXlsyNxKVNDcdCh
	 pJbJQO47niggsgz23J1TamVXP4YX7q/DbjeiYM3+//LeGlO1qpshcHoyJW8egaKR+r
	 oGs18g9SSY9Kg==
Date: Mon, 03 Aug 2026 02:24:38 +0000
To: Jonathan Cameron <jic23@kernel.org>
From: Matt Ranostay <matt@ranostay.sg>
Cc: Fan Wu <fanwu01@zju.edu.cn>, mranostay@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: atlas-sensor: use iio_trigger_poll_nested() to fix remove UAF
Message-ID: <PT1b4dloegkgrgv26ZJLYsrFQCIfsP236gwpWOn_IxzyZKkz9TV21c4wtPPHKWG6iEfj90YqAQATzTV8yT3T7C6tCRC9egl9PlsU7G0780I=@ranostay.sg>
In-Reply-To: <20260802193224.1a565cbe@jic23-huawei>
References: <20260802071858.430780-1-fanwu01@zju.edu.cn> <20260802193224.1a565cbe@jic23-huawei>
Feedback-ID: 87502384:user:proton
X-Pm-Message-ID: 19f989b1121f095cbff6b30e8ae20145f10caa2f
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, 3 August 2026 at 02:32, Jonathan Cameron <jic23@kernel.org> wrot=
e:

> On Sun,  2 Aug 2026 07:18:58 +0000
> Fan Wu <fanwu01@zju.edu.cn> wrote:
>=20
> > The atlas driver requests its hardware data-ready IRQ with
> > devm_request_threaded_irq(); its threaded handler queues an irq_work,
> > atlas_work_handler(), that calls iio_trigger_poll(data->trig).
> >
> > The IRQ is devm-managed, so free_irq() runs from the devres unwind afte=
r
> > atlas_remove() returns without flushing that irq_work.  Once a buffer i=
s
> > enabled, conversion-complete IRQs keep firing and queueing it; a pendin=
g
> > irq_work can therefore run after the unwind has freed atlas_data/indio_=
dev
> > and the trigger, when atlas_work_handler() derives the atlas_data point=
er
> > via container_of() and dereferences data->trig, a use-after-free.
> >
> > Call iio_trigger_poll_nested() directly from the threaded handler inste=
ad
> > of bouncing through irq_work.  free_irq() then drains the threaded hand=
ler,
> > closing the window; other iio drivers with a threaded data-ready IRQ do=
 the
> > same (e.g. bmi270).
> >
> > This issue was found by an in-house static analysis tool.
> >
> > Fixes: 7103b99b031c ("iio: chemical: atlas-ph-sensor: reorg driver to a=
llow multiple chips")
> > Cc: stable@vger.kernel.org # v6.4+
> > Assisted-by: Codex:gpt-5.6
> > Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
>=20
> Added another email address for Matt.
>=20
> There are reasons why he might have got the irq_work route but I can't
> recall if they applied.  What we lose here is the ability to hang
> other consumers that need a top half of the trigger.  If that doesn't
> matter then agreed your solution is the cleanest path forwards.

Hello all! Looking at the 'git log' and 10 years ago so it I'm only doing c=
onjecture on what I was probably thinking back in 2016.
If I recall the reasoning was to allow other consumer iio triggers (e.g. hr=
timer timer or sysfs)
to map to the atlas sensors.

Thanks,

Matt

>=20
> One day someone will get the time to make combining nested
> trigger handling with top halves cleverer than current approach of
> just not running them.
>=20
> Jonathan
>=20
>=20
> > ---
> >
> >  drivers/iio/chemical/atlas-sensor.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical=
/atlas-sensor.c
> > --- a/drivers/iio/chemical/atlas-sensor.c
> > +++ b/drivers/iio/chemical/atlas-sensor.c
> > @@ -13,7 +13,6 @@
> >  #include <linux/mutex.h>
> >  #include <linux/err.h>
> >  #include <linux/irq.h>
> > -#include <linux/irq_work.h>
> >  #include <linux/i2c.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/regmap.h>
> > @@ -88,7 +87,6 @@ struct atlas_data {
> >  =09struct iio_trigger *trig;
> >  =09const struct atlas_device *chip;
> >  =09struct regmap *regmap;
> > -=09struct irq_work work;
> >  =09unsigned int interrupt_enabled;
> >  =09/* 96-bit data + 32-bit pad + 64-bit timestamp */
> >  =09__be32 buffer[6] __aligned(8);
> > @@ -437,13 +435,6 @@ static const struct iio_buffer_setup_ops atlas_buf=
fer_setup_ops =3D {
> >  =09.predisable =3D atlas_buffer_predisable,
> >  };
> >
> > -static void atlas_work_handler(struct irq_work *work)
> > -{
> > -=09struct atlas_data *data =3D container_of(work, struct atlas_data, w=
ork);
> > -
> > -=09iio_trigger_poll(data->trig);
> > -}
> > -
> >  static irqreturn_t atlas_trigger_handler(int irq, void *private)
> >  {
> >  =09struct iio_poll_func *pf =3D private;
> > @@ -470,7 +461,7 @@ static irqreturn_t atlas_interrupt_handler(int irq,=
 void *private)
> >  =09struct iio_dev *indio_dev =3D private;
> >  =09struct atlas_data *data =3D iio_priv(indio_dev);
> >
> > -=09irq_work_queue(&data->work);
> > +=09iio_trigger_poll_nested(data->trig);
> >
> >  =09return IRQ_HANDLED;
> >  }
> > @@ -666,8 +657,6 @@ static int atlas_probe(struct i2c_client *client)
> >  =09=09goto unregister_trigger;
> >  =09}
> >
> > -=09init_irq_work(&data->work, atlas_work_handler);
> > -
> >  =09if (client->irq > 0) {
> >  =09=09/* interrupt pin toggles on new conversion */
> >  =09=09ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> > --
> > 2.43.0
> >
> >
>=20
> 
