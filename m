Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB60381EAB
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786990126; cv=pass; b=uVKZ5jFtZIAF+PRYKROKKsshEo20MWJ7u24J45CoYUiIXVw+69JDIMKY9SRxEp7uYPKaoGNW+6/tvCwUehLnPd1tw94hydHZik+9NFxlx3/1NRYOY1LCS1he4tr9hsKmzQx5Fwx4mBFLZl3ttWfqgdj5GJ9bkxWtfYw3n+1T1DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786990126; c=relaxed/simple;
	bh=g9vm5w6edydR/psOaPLVrWIm43mfOABWY3KZ4s6f9J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IpbBJBT9j2d8Lsk/VibyUW2Z6fQfV6xIF5DYIJx6eDuY4qtZoBDZeTxIz+c5isBvaCpwG4ZUqKLAl8Z6BUJ2dn2rIU66XbKOeGuG3O3R3ybXv4r5+cVcJ0zoSQJNca9weoQY+fnTnAbdiFxeFKqz/OR3x9mj1Vu6dwwFvIh/dbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWHhQg4D; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWHhQg4D"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5c5ad240851so78579e0c.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:08:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786990122; cv=none;
        d=google.com; s=arc-20260327;
        b=TbAITtCQQTKeThy+IgEskZvCkZY1gIRKJ67bebCm+lPFL2Z8z3junT0BtypIAkBRTf
         /9APcYjl8CCwUtbhE/r7BIQRBhkbx01O8RudOsYTddSasvAKZWjhznjDIBVs2ttFKttQ
         d/MB/e97NvOgGYCCh7K0NDzos6TZQCpf+1Tu/aYc9qxKv/JzDakTxlGDf35TaXVenmWl
         9qBaOhMlkFymhM30U0G5MG8JZsL1lDTDPhokPmT3N873cZwIZ06jTwLEODHzz0+o1PNa
         9VWge6yZPo+JO5Q0rN4qyv1xtskBz1w8b3G2H4kXTV1aJs0D+Nf0ps//2rytPXSVkDBR
         Uybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G5mJBVeRBN256FUPWqFXAEOzYwxXlado9G43KCVVgU8=;
        fh=rTflyyXGjp/326wdUHDSKjZun+sys9aYiTyHshH4hUM=;
        b=DRdV/TYqQLexTwFK1wsR+Ruc+OcU2mUi3BEKMp4ml7GlfhuFZEf1U0/Sql2DjgIWYq
         hGWo9aN/zZ4C1Ofy3cX09Q7b0V44u/Pn/RcLyFV1Q91RHcZn2NqFZw1aflH1Eggo0pAy
         NtiZVS2iNBjx13+ys+yfDqGisjFI0np6lNCE2jRnxchYJAGuKf4GA/EUDDLWh6fVNZ+D
         lX5tWIPmgiS6E3KEkwRBmHpzCN+qVrbyZzTwE2pvUOPi80mJM6rlkRqrVFJz3TrvzDC2
         lty2QsNPQrdeBStmIBovyqX/f1RR0XCSdh5IjrZFsgZJLl9bSR1rsUmjKXHqbCCoGyil
         9pxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786990122; x=1787594922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G5mJBVeRBN256FUPWqFXAEOzYwxXlado9G43KCVVgU8=;
        b=BWHhQg4Df0G4Rm6VKsGONzMO4otwcPwIq8sHSLOt5GLLVFrjMsFRPRS0akYr9QAkm3
         CsbGg2oTdBDbAfDUlDnz8Ea42ugJaOJLwKeyS6nrq4pE0/2LZWB1kGcqyv2+XraQ4Bdc
         Pc//YYPeKcf8+vNfOz6dBX3w+UMV+85clBEM+NYLoZza36N30MnVzEZjeqsW5gG1Tv7T
         D1Q1RE/MtUM694HEXDdoP89V5KzDxZC+pxbhictqby7StjSesm9eVjgGqBJ/SiBmdLVa
         C4DcqaiNhMvhqvKSsaRDsqiah82WBC6VjfxNa6aD4Pp3FVzVKZm6OE9vgs5SYOpamCm/
         a26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786990122; x=1787594922;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G5mJBVeRBN256FUPWqFXAEOzYwxXlado9G43KCVVgU8=;
        b=qgziJR/He4wnQx34ujDjT1FQIXRYEfH1+U3t6csWCXI/0yZJBqsBG0q0l13B1TNUcR
         PRbS8gZLR33pOkBUHFr0fVJefaVzBgH7UpmSlyg+d0TycA+NJ5f3gkfKcN/f8Jznbkj3
         NKJllRXorHwR9v2Ip3L3jrlFrxeMaYm/aZ8V1T8ZdfiCLmeMZXKHhnobf/QRuE/p4bqd
         Jvaid3f3qZRn8dN7PKLiLkonzr7S+7yHs0ZQ35RvMrL4Glf1wG3dtTyHeUjh/CBCpVFc
         UXtFYeCF93NQPjiZWE6H0cRTbAjnuhfxePfBt3HKBEWVyaIPkRu9h+wqUr07JMnrBgiq
         UVUA==
X-Forwarded-Encrypted: i=1; AHgh+Rr+5InEU4RnAQXMXlaloN8lUYj9ysezfe7srnuIqc3i3KTQXB1VsdqTipYCUjgswXnpwj8eS74=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr5dbhU0qexfhZWLE4KG8tae3NMimZ6mD6GQ2byRjpvjFxC0E0
	QpwMNlEan0ZOEU2Tqlrj2+u9LHw4awCcxcbLNtU6nfAzvoadmlo2c6XG1JFYj29HuE4pXguRd2S
	U2GFbdD4nq3CZSPzIm055IYifE0uK5rM=
X-Gm-Gg: AR+sD12J2hfgr5Z1/2c2T7TiOvMWp7HlgIlAOMYLuOnB725eotib4bMJ030vIoFouNT
	O0CfHtDsFfiTSAc5u705r7l9jV9G9VnKhYAsbUTQL76FgHKqhIQPEfb4ZoBLj9WCbIZSzPJWwkp
	DXndcUwgNan33+n7ot7ejegGvtLEhdcIaYyLA9YvwDN85iKr0wZJmxycwuliL2b66pm9mzAO7K1
	soCA7hcQLoQqQsL2g7nbcHoLjDNHY06hw7thScHtn3FGkftp73QE8Bqe3A03tqVyqbylomfDeCM
	+nvCIlXZRegsMI0K10Zw+8S2qVbYDewrLlTdwEAfqkNPhlY=
X-Received: by 2002:a05:6102:6888:b0:745:17b0:10d5 with SMTP id
 ada2fe7eead31-76f2cd6ba90mr1698150137.3.1786990122356; Mon, 17 Aug 2026
 11:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710194638.1502-1-saileshnandanavanam@gmail.com>
 <bc13f78b-287c-4832-b2f1-a68e7b35b57d@oss.qualcomm.com> <CAF+TLO0F9jQ0+pPei7iFDqcC-gKd44gc5SXa-o_dBKzNsHKU=g@mail.gmail.com>
 <CAF+TLO0S-Sp9PWKhvGeRfnxMaV7ZH=Ncr-p4NAu1pvE8odLTjA@mail.gmail.com>
In-Reply-To: <CAF+TLO0S-Sp9PWKhvGeRfnxMaV7ZH=Ncr-p4NAu1pvE8odLTjA@mail.gmail.com>
From: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
Date: Mon, 17 Aug 2026 23:38:55 +0530
X-Gm-Features: AcwNN1XbJOOIvkV8kvtl_H-i18dMwgL565JAwIvCltqfJM4L9alfTNXqZpQAn-0
Message-ID: <CAF+TLO2YiAUe0Yqzg5fa7-wKUVcjWUzULszhxYbzLqFak_zk9A@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom_q6v5_mss: Fix off-by-one error in
 regulator error cleanup
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, 
	quic_akdwived@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Konrad,

Following up once more =E2=80=94 still hoping to understand whether your
comment was a correctness concern (the err_enable/err_set_load
fallthrough into err_set_voltage) or a preference on the label
structure itself, so I can send a v2 that addresses it correctly.

Happy to rework this either way once I know which direction you'd prefer.

Thanks,
Sailesh

On Sun, Aug 2, 2026 at 3:12=E2=80=AFPM Sailesh Nandanavanam
<saileshnandanavanam@gmail.com> wrote:
>
> Hi Konrad,
>
> Just following up on this - wanted to check if you had a chance to
> look at my question above. Happy to send a v2 as soon as I know
> whether the concern is about correctness or the label structure.
>
> Thanks,
> Sailesh Nandanavanam
>
> On Sat, Jul 18, 2026 at 1:27=E2=80=AFAM Sailesh Nandanavanam
> <saileshnandanavanam@gmail.com> wrote:
> >
> > On 7/17/26 3:01 PM, Konrad Dybcio wrote:
> > > The first two labels only unwind a single regulator
> >
> > Thanks for taking a look. Could you clarify whether this is a
> > correctness concern (e.g. the fallthrough from err_enable/err_set_load
> > into err_set_voltage not doing what you'd expect), or more a
> > structural/style preference (e.g. avoiding three chained labels in
> > favor of a different approach)? Happy to send a v2 once I understand
> > what you'd like changed.
> >
> > Thanks,
> > Sailesh
> >
> >
> > On Fri, Jul 17, 2026 at 3:01=E2=80=AFPM Konrad Dybcio
> > <konrad.dybcio@oss.qualcomm.com> wrote:
> > >
> > > On 7/10/26 9:46 PM, Sailesh Nandanavanam wrote:
> > > > In q6v5_regulator_enable(), when any operation fails for regulator =
at
> > > > index 'i', the error cleanup path unconditionally calls
> > > > regulator_disable() starting from index 'i'. However, regulator 'i'
> > > > was never successfully enabled at this point, resulting in an
> > > > unbalanced disable.
> > > >
> > > > There are three distinct failure points:
> > > > - regulator_set_voltage() failure: voltage was never set, load was
> > > > never set, regulator was never enabled.
> > > > - regulator_set_load() failure: voltage was set, but regulator was
> > > > never enabled.
> > > > - regulator_enable() failure: voltage and load were set, but
> > > > regulator was never enabled.
> > > >
> > > > Fix this by introducing three separate error labels to handle each
> > > > failure point correctly. For the failing regulator at index 'i',
> > > > only reset the resources that were actually configured, without
> > > > calling regulator_disable(). Then roll back all previously enabled
> > > > regulators using 'i--' in the for loop initializer to skip the
> > > > never-enabled regulator.
> > > >
> > > > Fixes: 19f902b53b47 ("remoteproc: qcom: Initialize and enable proxy=
 and active regulators.")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Sailesh Nandanavanam <saileshnandanavanam@gmail.com>
> > > > ---
> > >
> > > [...]
> > >
> > > > -err:
> > > > -     for (; i >=3D 0; i--) {
> > > > +err_enable:
> > > > +     if (regs[i].uA > 0)
> > > > +             regulator_set_load(regs[i].reg, 0);
> > > > +err_set_load:
> > > > +     if (regs[i].uV > 0)
> > > > +             regulator_set_voltage(regs[i].reg, 0, INT_MAX);
> > >
> > > The first two labels only unwind a single regulator
> > >
> > > Konrad
