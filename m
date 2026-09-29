Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F217D3E2AD7
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 03:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651205; cv=pass; b=EwwhxPY7BvNbKSPMXrjgGo89pV1ydW3BLhFALxbYkYI3OtY3HcCtTKJvUmqwZXdihHOqCQtreKQ1+tN8Ky/RMyxg2b+kIJ9kF6PzD9GiCagEdGNDmc7oQHkVvt5KFC6TTPSADmAjCByLgQH2eCVBrXlIaXh4blKgR/50uhTfXbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651205; c=relaxed/simple;
	bh=drFBxzfc6W2PaLGZNBuSoVjThY1JgVwWxNvEN6zvNfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBLzNJx7Nt5MAOLtsVTb9DZe7fu8G4MJbM3RV/O3nzvey0FDDo8JFtJASIyUcCdanVCBlPhxGmyVh/zHlHicaJ6YE34RyZmexzRp5CWW7GuBSEtPDNgl138ppkZnRCtAwzFXPWX67hcKV1gdr+YiWvbi7wFA7XYE1ifsA5D7U3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWrX4yDA; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWrX4yDA"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb8b78d6cso52820a12.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790651198; cv=none;
        d=google.com; s=arc-20260327;
        b=jmbN37J084nqaJGmgihKD/tgOTb4LQ+mbUaoVevBue5w/UoeTMrXiFMnC3apjD+dot
         oZJlA6sUFmAcjPxLAraVHG4FVcFrLB/5TsaoUaqURoigdeqKH0K/FWBnhLPOFbjN242p
         CVODCmNrn4Ao8syObPOpGOKUDakKZBxoLTyrfq0dMlPzrQMltKYG6RAlpLcBiFuG7n0q
         ftqFJryi91htqzT4qZyZwYrWA2rb83qR9Sek9d9Rx885qW8/efyKLc1/I3x5f83keETa
         lOu5BUU1iqsFVIaXl12I+wxGsa65ZW4BP8iLpqZ8PAWfQfYpsI5jW3hN1bnoMtY+gb9Y
         Z/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GsgcGMq63dxBO6lpCOoish/kEuxevaMsXSsx8TcWvog=;
        fh=m4N9lzbihGOZYOpTqWJfoYy7hR7FqA2eLS8hslaSTKk=;
        b=jWozxZ1JQVTbTdg3s7GaxQ3RMBMA7glpHUcxk6sBzKTRdBoveRtkEQvFTUgWJ08Bgu
         JJY6KSREDlV9SKvr+ewiserhU9ckdgRQJVENkfoHaHlbGB1b4aHumFTZjjbQ/4s9vIcI
         2phRpyw/taSZGK4P8qmq/FU2ygsvsuEoe3q5cSbE/ii4fYiTiHVNcoVvUb9bDXMYKfcc
         JrkrJ39COZ4cRmCNrARWjn987yHVqfRzkRTLUf863Kt6l/hubIpLka6BFBFTPh5WVeyY
         mw/SL5LIzIQJ0qZKLSBaaiTLoXiaQ1hcmYKiE/xI0tpWOJ/sqyPXw8/GM0wUif+PCtr5
         LQpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790651198; x=1791255998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GsgcGMq63dxBO6lpCOoish/kEuxevaMsXSsx8TcWvog=;
        b=kWrX4yDAa4RF9Glu41S/GnWcgrNxZd8gOe2sNxpzDU7tLw4CGL6aO4lBL1jY8rwAqY
         NsMxS0KyxvgWvsrSH4uoMKp/KsHCAIph2e/ZoIQsCxRss3uRoHcCVMKS74M26yM4PrLU
         qGm7/6YB6q6Vl4XT2KXAlBeFIIz/oP/O4URoAFukMEWKMlTezySm053hR/Q79oL/EkOB
         PMTzmR9w8Mgvxh2XTdwzHBqsm/rpW3kkbzrcm6Am7dlc0qnlnTEKItjMKQqOkc15EjY7
         6O8caKHkhrKqQo7ZY8L8tJR+1BF+P2GZUOx3olhhXP01sTrge7XiSE7fzwDY0sEMDiy0
         /ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651198; x=1791255998;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GsgcGMq63dxBO6lpCOoish/kEuxevaMsXSsx8TcWvog=;
        b=DL1X9FfbOxj/2QBaEPOH5Bmu4vYZskqtIc07ttjl4FCy/t0qL84acJSJBjHn5fxr0s
         1w5RiYT1DJwB8qAm6OglQKGHzx5m1Sub6ZTHaABR47fQbIDkvaDrO4mEGGWUtD/MyZb/
         swaAtQendkzjGs8GPNp4oIVHHdut3+e7IqBDCLsoYVKyPSM3ufFiMJ4UVohv8B5qjLur
         1QZu+dBpmI1wLjsWh8WYYVqBm2161eP45RJDHOfC4P0maR3ftpq8zf559ySbQ8Tm4csy
         eHmNXZjO0r5bH6tpphWIvpWjFVP7Evg3xF7HkQ20txy5yifIzd+hBY3/pHP5KtHyrlIw
         5uWQ==
X-Forwarded-Encrypted: i=1; AKwUvByT/GGb3G9B4N6jftN0JF6dzdMMDvIwbu3vUMw5GVS+ilXOyRkIXZt1HLcfh8TLGm0KSJFzIlE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIaGqRlbIC3iXnt8zSuHwSDRTUEKnEji453Oc/4dkHICWEP0/rJ
	ol95nvA8NHcIaw15hWQgk31kC2SRrFcHTgIcoc7kIcIhNzcNGUao4gsu/FiBi4ZgAHXHpp8Ivpb
	qtlnmKW+IssCCrPlazrs1QYxHaVePWo8=
X-Gm-Gg: AYBFou0Dw7RF/LiYHCGKEBxVTYnxYzHfiQrwPl0We/u+lf0BDs19arBQxLWwon0bgRy
	NI/pQsSZbCFBxWLiktPB9ppTT+mXoeQDQdWjo/lm19ofE7Do0EoRjWgAFeGd0Sx3mR6T8rqJJHe
	kaqbWdD+JjcrRxtiPlNWiCqa4boI3iLR1tZPLyZJ8MRTXLjeGwh2+Cyl42agAXlYis6DwmPY7ai
	IZWhEKlDbt+8r9CEdxHhFwKA7knTd0li0uLvT8n0QBRH24Jts6fm8y68KI0hPqzRQ0YgkWf9VeF
	BTQcGUt4mfeaEi8EZz9WeEL8dNkiJ/gclFSn/L8a/10I0GIkhsS4/fty0RJOTxkbAYqK
X-Received: by 2002:a05:6402:1d55:b0:6aa:7fb:7678 with SMTP id
 4fb4d7f45d1cf-6aae8a518b4mr7987012a12.6.1790651197346; Mon, 28 Sep 2026
 20:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790561983.git.zhoubinbin@loongson.cn> <502911659e15a51c4e98c11f3cf476dd5f92e75b.1790561983.git.zhoubinbin@loongson.cn>
 <0aaf7166-378c-47d7-98d4-1004fdaeae7b@oss.qualcomm.com> <CAMpQs4+uWMfFib7MhRcc7o-QMXkFrFCtdcGj04y56u44JL4iOg@mail.gmail.com>
 <ed99f62d-cf90-4ba9-89b3-08dbe7f7227e@oss.qualcomm.com>
In-Reply-To: <ed99f62d-cf90-4ba9-89b3-08dbe7f7227e@oss.qualcomm.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 29 Sep 2026 11:06:25 +0800
X-Gm-Features: AclHuK-pCkswqNWZEVmRnm0h2nAuqgvV_q4b0kCJUY7w_QKyo1tWrrar9EH7iE8
Message-ID: <CAMpQs4+hATFf+0w6Wq09RoZB1JJ5L_GP0aWxcGAeraTW7Gfy0w@mail.gmail.com>
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

On Mon, Sep 28, 2026 at 9:23=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
> On 9/28/26 10:17, Binbin Zhou wrote:
> > Hi Daniel:
> >
> > Thanks for your review.
> >
> > On Mon, Sep 28, 2026 at 3:15=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@oss.qualcomm.com> wrote:
> >>
> >> On 9/28/26 06:44, Binbin Zhou wrote:
> >>> The registration loop in loongson2_thermal_probe() incorrectly uses
> >>> dev_err_probe() when the sensor is not present (-ENODEV). In that cas=
e,
> >>> the driver should continue to the next sensor index rather than treat=
ing
> >>> it as a fatal error.
> >>>
> >>> Fix this by correctly handling -ENODEV and only returning on other
> >>> errors. Also add a final check to ensure at least one thermal zone wa=
s
> >>> registered.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >>> Closes: https://sashiko.dev/#/patchset/cover.1783670011.git.zhoubinbi=
n@loongson.cn?part=3D2
> >>> Fixes: e7e3a7c35791 ("thermal/drivers/loongson-2: Add thermal managem=
ent support")
> >>> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> >>> ---
> >>>    drivers/thermal/loongson2_thermal.c | 8 +++++---
> >>>    1 file changed, 5 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/lo=
ongson2_thermal.c
> >>> index 4d40fc706a53..99b7392fc68f 100644
> >>> --- a/drivers/thermal/loongson2_thermal.c
> >>> +++ b/drivers/thermal/loongson2_thermal.c
> >>> @@ -160,16 +160,18 @@ static int loongson2_thermal_probe(struct platf=
orm_device *pdev)
> >>>
> >>>        for (i =3D 0; i <=3D LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
> >>>                tzd =3D devm_thermal_of_zone_register(dev, i, data, th=
ermal_ops);
> >>> -
> >>>                if (!IS_ERR(tzd))
> >>>                        break;
> >>>
> >>> -             if (PTR_ERR(tzd) !=3D -ENODEV)
> >>> +             if (PTR_ERR(tzd) =3D=3D -ENODEV)
> >>>                        continue;
> >>>
> >>> -             return dev_err_probe(dev, PTR_ERR(tzd), "failed to regi=
ster");
> >>> +             return dev_err_probe(dev, PTR_ERR(tzd), "failed to regi=
ster sensor %d\n", i);
> >>
> >>
> >>>        }
> >>>
> >>> +     if (IS_ERR(tzd))
> >>> +             return dev_err_probe(dev, -ENODEV, "No thermal sensor r=
egistered\n");
> >>> +
> >>>        ret =3D devm_request_threaded_irq(dev, irq, NULL, loongson2_th=
ermal_irq_thread,
> >>>                                        IRQF_ONESHOT, "loongson2_therm=
al", tzd);
> >>>        if (ret < 0)
> >>
> >>
> >> The [no]error paths are confusing and prone to error, eg: 'if there is
> >> no error then check if there is an error', 'when exiting the loop
> >> without registering any sensor, then we assume tzd is -ENODEV'.
> >>
> >> Please make a less cumbersome and implicit checks here. For example
> >> count the number of sensors and then do the check against.
> >
> > I thought about it, and you're right=E2=80=94I made the logic here too =
complicated.
> > Let's use `sensor_count` as the counter. Is the following check logic c=
learer?
> >
> >          u32 sensor_count =3D 0;
> >
> >          for (unsigned int i =3D 0; i <=3D LOONGSON2_MAX_SENSOR_SEL_NUM=
; i++) {
> >                  tzd =3D devm_thermal_of_zone_register(dev, i, data,
> > data->chip_data->thermal_ops);
> >                  if (IS_ERR(tzd)) {
> >                          if (PTR_ERR(tzd) =3D=3D -ENODEV)
> >                                  continue;
> >
> >                          return dev_err_probe(dev, PTR_ERR(tzd),
> >                                               "failed to register senso=
r %d", i);
> >                  }
> >
> >                  sensor_count++;
>
> If I'm not mistaken in the previous version, the loop exits at the first
> registered sensor
>
>         if (!IS_ERR(tzd))
>                 break;
>
> Here all the available sensors are registered

The name `sensor_count` might be a bit misleading, but here the loop
exits after the first success:

                sensor_count++;
                break;

Let=E2=80=99s rename it:

bool registered =3D false;
...
for (...) {
    tzd =3D devm_thermal_of_zone_register(...);
    if (IS_ERR(tzd)) {
        if (PTR_ERR(tzd) =3D=3D -ENODEV)
            continue;

        return dev_err_probe(dev, PTR_ERR(tzd),
                             "failed to register sensor %d", i);
    }

    registered =3D true;
    break;
}

if (!registered)
    return dev_err_probe(dev, -ENODEV, "no thermal sensor registered");
>
> >                  break;
> >          }
> >
> >          if (!sensor_count)
> >                  return dev_err_probe(dev, -ENODEV, "no thermal sensor
> > registered");
> >
> >
>

--=20
Thanks.
Binbin
