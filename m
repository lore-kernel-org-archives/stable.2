Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C1643CE71
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583439; cv=pass; b=i/1x9hRCfvl1lYRkgjfZSMyRYocHywrBdFOdTSfsvgfdeDbhe3YHRJq9UR354EtWc4bmmZHY3kiBtgc+qa7y6I448M8L12O1q+960p84snG5kUKvAStFSFjt70CbJA9bp6TiIgRem594kwMescIbFOCZQ0m32A6Q7S8jLNTVpmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583439; c=relaxed/simple;
	bh=aYwJC4BScg6xo8RaWoJ6AsT9nwuM3VqyxukWf+p+5lw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txiy9OQ16az2tnsMwjVpAwyeBaTwAbxzg5hbdN5v5UOuS3ChCT6kXhM7oe6bwziFTs16zRA5LOwpL/sL9bwTG0z4r/cygw0mmR+O5X3bHjmahZORcVzCtSOlIrhuGWpBFyF7fFgbmXIY867HkEl2YlTqMwpNgMqcbPjCsannVaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENaQt00N; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENaQt00N"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6abc27842b6so2007889a12.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 01:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790583435; cv=none;
        d=google.com; s=arc-20260327;
        b=E0yl/F7/o5E4/yhZJ2M+8gH/Q2j3YFj3TLdkNmEQHpg5hV7hQqHN1E6ShpeJf7JqsR
         67xEkMagJlSaw0YAmC4NPm74IIRy0G+hSmJyycLQBg9GWa+vbkimPLh5UpMKn4qEE1lo
         0R1t1H1vBDQjQJQzrU0daFUuRm1xkSLmOS4VHhXYgUKydakwoYGq544DZx84Jq9Q52NP
         PPYcjotvMv7RaoGInHZaioIeo/Zvav2cTAatQFSnYsmgVqfpp7fliRSW4vDXeTfk/euw
         0E3QSJ5g9RR27a8CMXqZsibIVLz+PESCcEEO8/e0cK/1o9v4ChGEMarZV+JUvcvjKWCF
         PZpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x52vdN3RGFH8b7Z3g2Hq5cceezp96zx3/fKU5lU+Vhs=;
        fh=JuSfdgwWvqyR1aYNmsEyUZj9qIshf1pdWAOJwt41Cpc=;
        b=YinXiJdesWa5LLZ1OUxiiKdCwolujuifiu5lmTb0Nuh/bCaZPq4sE/2WdgYxS83eR8
         BxF5Obe2gG1mO8tFsl3sixUJoRKMnFfmrsFXYOexV1JQ3YXr+ilY4u7HX4NoUg3fb3T2
         GJ4J+6y0MKPMmLDl6/OtBV8gY/fP0W0sL17WzbPs5DRRwyh3nl9nI33KerfR5h2yh5rZ
         Zu195RAWZQWlmcfSR78b9v+yRZJgz/diOeIwZVSwyy3l2YcNJvPmcjZIgGCKR6xjXi3Y
         dJH2YLoNaiG5dEqsl677Oo1jCd4xx6dKOuksy38h4kK853UxXro1IynWzaHYbZt3N3Nd
         9p0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790583435; x=1791188235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x52vdN3RGFH8b7Z3g2Hq5cceezp96zx3/fKU5lU+Vhs=;
        b=ENaQt00NIoQUsVZvGPkqqNpXP27pDX6aTNu0QCWi0I1BU7j/Xr30D6NLo+A4hyUutI
         oknIti4ILVzeEN95I4SSm5RYTBLlCllslerIvW7oKN3dAb8jGeKUkTbTbmKa7l0BOfJS
         uXZ4gbVJNTndhQyl2zhXLry/oXT6DsOheRKF+zpTQQ01Nnck9iMhKOFUq6qZxPrQo/CM
         XOtxR65WpnNeTGsJPvRduINwA9aSrd9C3bJ/TWfrWtNdgDiIMew+KjVQ2zW6RRNy42ZE
         qp5DlQfzqimmBZdsixxl+R8kmHVMQgHJjpc+shh6ghvoNvg4kQjQVIa+FzcD7T5Dr4x5
         3ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790583435; x=1791188235;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x52vdN3RGFH8b7Z3g2Hq5cceezp96zx3/fKU5lU+Vhs=;
        b=w5EJwfH/5CNYUJnslsqRuK8d1sbHpb9pdRPewn5H8yJ4jDpmKJCNUDcafKDVl7Y8dJ
         eL/LDx9VrUi80bYLXmqTP2jkryp/SF0RzwKA/wFEwQDOPmYtgnTUiUjTRBZEFu9nWuhF
         1eLRt4CIU8p+LctFsCu/0+KdxfPmWFdJP3UaNr1EPTzbIZUcDcq8sPIafSNBzlcAQAhq
         PIIZKJvVzKMaLaQISQQrOU3DeS2OR1QsEuVvc2UYncn8eEwEQA9Ai3Kj+4onV6vbA/7C
         rRjDMGpwDfPk09Lt4LaMCazbNGdPCB0TmXH7ErWTdOTJOgpqDnS3ZqIM4WgTt41xQ/zh
         i8mw==
X-Forwarded-Encrypted: i=1; AKwUvBzD0FAwTFzqge+9Vbo7ClJIUrB+yuZqFk/odz9K7rgsiIRyJydIOqFwciT1ZZx7t6gTqxdlcOc=@vger.kernel.org
X-Gm-Message-State: AFuF++mTKO9R8iGR1POERLmSt8Tz6Jrnw0BZlimQ3Oqejzx2wCEe3Zbn
	BKV63/KAXvJ+Y2zV4zlnlrFuX7FKzFwhQdIU41FnrKMcDyO7YzXMsBYDZuQx2S9D2IoRDX+9qUZ
	9kDDLMe1kLxf18HDnUssXLk9/LNPzf5Y=
X-Gm-Gg: AYBFou0z0rdRuruOrSg9gMdb5Zh+jh7SzDRdAFQDOsttEi5s++Nagw9MuCCrdyOKfDg
	daSA9yCLKwlKu23uGEiPkiH5uGgJWrQaX1NOYYV7agVpBwPQLfLBEZ56x1CR2JeIB4RpT/jqWY4
	i6a4OGatO/YKvmwW6rLNb6WRRSfkDyUuHkA37aa1tzQWe3pkgLvbosHNlPNJTOytO2MXQpcJPah
	cegiYMHlZfdZUDjtZMgrmPD+xFudoQ6j0jVH2QXTV/7GIyCLsdfkifCgA2rXytGxCNx90pQm6/O
	R0IChMJOlW7VuNYMEM8LJyBmt7ATH2yBDRg3HEsRekFAaqJma5gy36ihYg==
X-Received: by 2002:a17:907:c491:b0:c26:1648:a06f with SMTP id
 a640c23a62f3a-c2ac253fd57mr1046162166b.42.1790583434617; Mon, 28 Sep 2026
 01:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790561983.git.zhoubinbin@loongson.cn> <502911659e15a51c4e98c11f3cf476dd5f92e75b.1790561983.git.zhoubinbin@loongson.cn>
 <0aaf7166-378c-47d7-98d4-1004fdaeae7b@oss.qualcomm.com>
In-Reply-To: <0aaf7166-378c-47d7-98d4-1004fdaeae7b@oss.qualcomm.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Mon, 28 Sep 2026 16:17:02 +0800
X-Gm-Features: AclHuK9Vua98KWEJM57MhTJw4SsJBaEsxZP1W-rR6PIaRSRBPFPETsYhRw_q6Fo
Message-ID: <CAMpQs4+uWMfFib7MhRcc7o-QMXkFrFCtdcGj04y56u44JL4iOg@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] thermal/drivers/loongson2: Correct thermal sensor
 registration loop
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel:

Thanks for your review.

On Mon, Sep 28, 2026 at 3:15=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 9/28/26 06:44, Binbin Zhou wrote:
> > The registration loop in loongson2_thermal_probe() incorrectly uses
> > dev_err_probe() when the sensor is not present (-ENODEV). In that case,
> > the driver should continue to the next sensor index rather than treatin=
g
> > it as a fatal error.
> >
> > Fix this by correctly handling -ENODEV and only returning on other
> > errors. Also add a final check to ensure at least one thermal zone was
> > registered.
> >
> > Cc: stable@vger.kernel.org
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/cover.1783670011.git.zhoubinbin@=
loongson.cn?part=3D2
> > Fixes: e7e3a7c35791 ("thermal/drivers/loongson-2: Add thermal managemen=
t support")
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >   drivers/thermal/loongson2_thermal.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loon=
gson2_thermal.c
> > index 4d40fc706a53..99b7392fc68f 100644
> > --- a/drivers/thermal/loongson2_thermal.c
> > +++ b/drivers/thermal/loongson2_thermal.c
> > @@ -160,16 +160,18 @@ static int loongson2_thermal_probe(struct platfor=
m_device *pdev)
> >
> >       for (i =3D 0; i <=3D LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
> >               tzd =3D devm_thermal_of_zone_register(dev, i, data, therm=
al_ops);
> > -
> >               if (!IS_ERR(tzd))
> >                       break;
> >
> > -             if (PTR_ERR(tzd) !=3D -ENODEV)
> > +             if (PTR_ERR(tzd) =3D=3D -ENODEV)
> >                       continue;
> >
> > -             return dev_err_probe(dev, PTR_ERR(tzd), "failed to regist=
er");
> > +             return dev_err_probe(dev, PTR_ERR(tzd), "failed to regist=
er sensor %d\n", i);
>
>
> >       }
> >
> > +     if (IS_ERR(tzd))
> > +             return dev_err_probe(dev, -ENODEV, "No thermal sensor reg=
istered\n");
> > +
> >       ret =3D devm_request_threaded_irq(dev, irq, NULL, loongson2_therm=
al_irq_thread,
> >                                       IRQF_ONESHOT, "loongson2_thermal"=
, tzd);
> >       if (ret < 0)
>
>
> The [no]error paths are confusing and prone to error, eg: 'if there is
> no error then check if there is an error', 'when exiting the loop
> without registering any sensor, then we assume tzd is -ENODEV'.
>
> Please make a less cumbersome and implicit checks here. For example
> count the number of sensors and then do the check against.

I thought about it, and you're right=E2=80=94I made the logic here too comp=
licated.
Let's use `sensor_count` as the counter. Is the following check logic clear=
er?

        u32 sensor_count =3D 0;

        for (unsigned int i =3D 0; i <=3D LOONGSON2_MAX_SENSOR_SEL_NUM; i++=
) {
                tzd =3D devm_thermal_of_zone_register(dev, i, data,
data->chip_data->thermal_ops);
                if (IS_ERR(tzd)) {
                        if (PTR_ERR(tzd) =3D=3D -ENODEV)
                                continue;

                        return dev_err_probe(dev, PTR_ERR(tzd),
                                             "failed to register sensor %d"=
, i);
                }

                sensor_count++;
                break;
        }

        if (!sensor_count)
                return dev_err_probe(dev, -ENODEV, "no thermal sensor
registered");


--=20
Thanks.
Binbin
