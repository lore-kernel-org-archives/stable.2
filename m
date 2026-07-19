Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0342A3597B
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784463376; cv=pass; b=tfpJXT0T9K8nL7oe8Oz9yYeo2xytE9MGeQumi+jR1I3SRvTFz4yJMPykOIblDhWbeV9P/XZeVJ1U3IKdDq43PPnzE9reS8LmI+txGrPJqPz2FalNVh5o90nbVHksggqpmifRloNSOjc9zBvYVHNdgABEe7SDPTLS60+/r5ZpOiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784463376; c=relaxed/simple;
	bh=7k1ompG3OU00AioG3cVhRo2AcAAVm/R4Z0VlwYZ8v38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KS97cczQTMALbDy7ed/R0uGkDtGu25kfJTcwHIklc0GYVMfTSV75lS7CfmLR3+lWg6WVMdjYNJdgnPwJk2vAs5wCmutAxmuXF4Ul7y2pDG7aMI7cPk8WPONX53pG+YUcM7Nwk0yZBxTYIu9J1hSG/fh91hN+ODkgioLvhKoGnZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6WrBuf+; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6WrBuf+"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52192509869so14875811cf.1
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 05:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784463374; cv=none;
        d=google.com; s=arc-20260327;
        b=Jzf9flJM3/amWmu/gjKStr4m+Y22gyIgd0NjJRgh/m0MFy4hrQBPoqpnj4Yq5Vew0v
         IS7z99n6KAYpaq5lC4TJtVvsTN+IvpAnrEvQH4Nby7vlB8m53fZ6KDWTBWoYd9/V422I
         ImgH1ig1OhuWqI39oAlFrQo0eqsD3qQ0di6SUa/VTSEkZdJOsR5PT85jmWtW70GyY1pG
         ufXm3kD/JNnRIT8Qd3rbapIHZSp/kBcTrKd+lq+KfQg84iyo9w2u8AB1D9Z0NIegQ5dM
         0BFjFfv8XQVfJ8yCTt4zAWZHcHY8S0xBGxc7s6+H/XPSV53eoipRITjnF0FSEPS0UAmz
         6ARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U0fzMhiju8K2JgRkrOvtst8zgzDyvx9Ag1u6YBLmwqk=;
        fh=zUvsQudktgMk6i9GtDxM/3AzEsR3b4J4W8dgQBEyyf0=;
        b=qaA3keDxM2uoLg5rij6gLONQpS187MPy7qLMVTd2EczRt/1sX/YsJBux3hw93OXxHZ
         u9x/wctGPDdF7e5gZgBnrgFDb0OnAXMdj8a6MIqfvpCfQsqGmKf83g1vweVdeJr2CRV3
         ys79F21IK85tnJjxEOiQWQQVE/gLvmPknGNwlw1ckVWrrqBRKNhxB+tq6hNdYy8HHJNP
         QvT5o7tn0K8h2TV/ARXBrF4mcs3TH437TmVsYszU8hZOqXk/SAcyGjwPCYeCK2Yil5/u
         cb+ULnSF2BRpkvg+51LWoUUCGqOdUYHJ9URkSRtvkWKVKx6PBfvPSp2qpjScy+RW53/m
         vrrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784463374; x=1785068174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U0fzMhiju8K2JgRkrOvtst8zgzDyvx9Ag1u6YBLmwqk=;
        b=U6WrBuf+9z7yrutMtr+QOuySIQOx2pKgfxP5graAPr97T3S07X8NRaEMuDu4+f5F4U
         9t0vDfV7DnERrFnMtgfij5itkxWc6lWnfKMyayQFrg0kNLYrSvIYEOR7ej66P8s3jO4u
         TMBCoKv4roXvZ4Zyp88qs1WCJuXDOduo0hMZZ73Zmea3uyaTvSi8EvJoTTvqRRJssqzf
         +zctM0MM9tbfq0XbCcB6GrlqU+ivOnPwGNg5gJg0kWyAEd0p+6LPMG7EApN8Y9fRTge0
         VoDiW5IukyNMO7ormjajO+bh/wu46rp5HDZl7RIJwmX6tcMlD/xW92gKOYNTJgyGrrtU
         nqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784463374; x=1785068174;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U0fzMhiju8K2JgRkrOvtst8zgzDyvx9Ag1u6YBLmwqk=;
        b=I/TmCkEnd/PNR+Sa1vdNl+rMrVWtwXOt7b7WWYJD752c69TgxBmYvtVWF0QiR71h56
         r2DbXtAjk/l/BdJ05y4YKztpF03pqm3F6H98QJOnImusbetXfsiA7SGSepOpZLC0psf8
         daH9yb9ZWZlC/Y4r6dmKPZmGRCOAfHbqcxyyC2XmuKVJLXtZkRwO4cDbH1tzvRF6BwY0
         nAMyULyHB+YDhOoxGO5C8WGVFpM7/pDxG40afTpTjkM2ZAsKo/Hmt41SEmsTRqCuZLOV
         u5TeaigrSoyaCLGKH4i+BEL9FyQqctkuTvZkpAoOXKFI5qwAs7oPL8uwFQspGDFqsu6F
         GXPQ==
X-Forwarded-Encrypted: i=1; AHgh+RqiHjqzSwxl3Fg2h02vArJfmPH/XGo898nKsE9ZYI7kQltBjbpIOrKEHxHK3GituFPrK26+PMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEG/wHKCrNXdrNsnL0Na4ZAKMGrTzYqo8zvoBUYZJgmWg6O4gB
	J6g+ZRMDFiAGBzWaXSOq9zeo2RDtCBgKQSYAQ4bppgmaTtlZmsoI6pUTOYNUClw2UNMSc4j9k0G
	AsSIUmHgjl/Z1USP4EWyszfe7UsxbJFQ=
X-Gm-Gg: AfdE7cniwUWbuCFZFzpB/FdfnwMfMhULA8DHcNXEEsjCP0negfcFnHy8oVNcVXsbkWY
	qwXIUoSaNXOFZ4pvYohWJTsL7jW8uAv2NzjSo/i+4xjx1Qz+NKpMArcoxJM0dHBk4p4w9fQZI/S
	Peo0gp57IkQNA9da9goYrsMHTp7WAF3ZfMtP4PVnA8fEJet63XB7/8XrhzNS217NgGcHmu0oq+W
	o9PlOeAomHizmNgZFLr3d4dmB+XuuMjaEwupOmsyTTXxXXpShdlcy636HTmfZhGxdDpMErhq6ZR
	OTsujtPvUaRD/+vggNc=
X-Received: by 2002:a05:622a:22a2:b0:51c:7b12:1211 with SMTP id
 d75a77b69052e-52140344f93mr93303961cf.79.1784463373833; Sun, 19 Jul 2026
 05:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719000752.75936-1-zoone.rupert@gmail.com> <alyTjkq2bCuTE3OO@ashevche-desk.local>
In-Reply-To: <alyTjkq2bCuTE3OO@ashevche-desk.local>
From: Rupert Zoone <zoone.rupert@gmail.com>
Date: Sun, 19 Jul 2026 15:16:02 +0300
X-Gm-Features: AUfX_mzSykWwwbvhk-HtZVX9fE65Bl6c47yBUyOuOxGzhzAqaReG3QAU0-ag74g
Message-ID: <CABpb+S4sg=HtYRAKOBcx+rH+1LnNbxqvfsxRuW=_kShGc4d6Og@mail.gmail.com>
Subject: Re: [PATCH] iio: pressure: dps310: fix NULL pointer dereference on
 ACPI probe
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Eddie James <eajames@linux.ibm.com>, 
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  On Sun, Jul 19, 2026 at 12:06 PM +0300, Andy Shevchenko wrote:
  > As a quick fix this patch is okay, the proper one is to go with chip_in=
fo
  > structure in the driver_data. where the name will be defined.

  Thanks for the review. I'd like to keep this one as the minimal fix so it
  backports cleanly (it's Cc: stable). The chip_info/driver_data rework is =
a
  good idea, but I'll do it as follow-up on top rather than fold it into th=
e
  stable fix.

  > On top of that mutex_init() should be devm_mutex_init(), which is a fix=
,
  > and some cleanups:
  > - unused i2c_set_clientdata(); may be dropped
  > - C99 initialisers in ACPI ID table
  > - IWYU principle for the header inclusions
  > - some unneeded GENMASK()s due to use of sign_extend32()
  > - perhaps converting to use get_unaligned_xx() where it makes sense
  > - use time multipliers in _read_poll_timeout()
  > - use fsleep() and time multipliers instead of usleep_range()
  > - get rid of min_t(); perhaps replace with clamp() or min()
  > - use SI multipliers from units.h

  Agreed on all of these, including the devm_mutex_init() change. I'll send
  them as a separate cleanup series once this fix and the triggered-buffer
  patch are in, so each change stays easy to review on its own.

  Thanks,
  Rupesh

On Sun, Jul 19, 2026 at 12:06=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sun, Jul 19, 2026 at 03:07:52AM +0300, Rupesh Majhi wrote:
> > When the device is enumerated through its ACPI HID (IFX3100),
> > i2c_client_get_device_id() returns NULL: the ACPI-derived client name
> > does not match the driver's i2c_device_id table. dps310_probe() then
> > dereferences that NULL pointer in "iio->name =3D id->name" and crashes =
the
> > kernel during probe.
> >
> > The IIO device name is always "dps310", so set it directly and drop the
> > now-unused device-id lookup.
>
> ...
>
> As a quick fix this patch is okay, the proper one is to go with chip_info
> structure in the driver_data. where the name will be defined.
>
> On top of that mutex_init() should be devm_mutex_init(), which is a fix,
> and some cleanups:
> - unused i2c_set_clientdata(); may be dropped
> - C99 initialisers in ACPI ID table
> - IWYU principle for the header inclusions
> - some unneeded GENMASK()s due to use of sign_extend32()
> - perhaps converting to use get_unaligned_xx() where it makes sense
> - use time multipliers in _read_poll_timeout()
> - use fsleep() and time multipliers instead of usleep_range()
> - get rid of min_t(); perhaps replace with clamp() or min()
> - use SI multipliers from units.h
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
