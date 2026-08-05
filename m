Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E143CF1E1
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785951363; cv=none; b=MadVCOvPW2SVRLXu3q4Xv2Z4KFTqprNqRcUDUHHO7taplPFeyXvmgKV60WgC7SBNwg9Y+vOQ342W8pOVs45jGOdS6ClrBdXG2ul9UYRvzZPv5Tfv/nTeADOmKwO/Qx3OS6vzBl38eXO60dTTeZg+9Ibq5ZAFB92WOzfR/CiDl80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785951363; c=relaxed/simple;
	bh=9dqorHKYzxEJyKXFMaxkG+Of7cFvmeyfyPIVRmTm/rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNQVUbaJUsK8keB64/HT8Up9gKpmgKnxtrtmxavofMb1usOrgfuz9l0dVmByWKdX/+c7RW162YmNZG13jAPdBfvziCjWWvUqZuNSGduRESBLOPgW+SOjPI0u5SJ2EzF+QLOsxWUINtdKic3y7J+GQ4jzhRhAx/STQcDInPjVYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM6QMS94; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM6QMS94"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0481F1F00A3D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 17:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785951362;
	bh=3+W5ZEC0FG5qpRnN/ibUCo/W/Wu2WQSN8/Be7jtuqkQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LM6QMS94K2wiqzBU/KDmcU958DNLeQoRF5CVFune1Vp3tKQXe/iq0PQ899yFwlgbr
	 VgoZmGRtVeUaJjqBtl0oSV1oCAbKZ8K9pUA0LHU/28Z62b27E/gnGtZNt+bGkRiw6p
	 /A5ieJHieby7JhMNa9UQ9e3xHWMt5hLbY0sZZNps4Rfg3yovppFYnKiOWEn+bmExF5
	 4ffrgv86yT2SXtZMTq43R+hg9iYj+wA5q4XB7OdZuc7BZh1FS8E1ByfcO4pbIQx1hA
	 VBEzfox+e7zvWdGnPTsMKMdjOAYWfNCzlxcqlx9rRI1A8CznlsW/V52rM3onItc8VH
	 SILXyLk+LATBg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b29599b81cso1666997e87.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 10:36:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrGqyVVoerihNd8HLB9Yb63gQ6ptaxaC9Enl4WRsH1e5jrNpsEsFNkI6qzBtyUwCWKPpj+h+s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyenWEwyX7lklXedic1C7nMsZ2n5MdmER215WUyKAJwX4gp6E/g
	K4B7PIW7DolJwGnpiPrNEkNX2dwls0LR6bdeqpbLm6OZnodABF5KY2mqCTyHg98FY8aFG9i0+Cb
	M+RFNlB98H8MY4w4nU8HJS0XqKullWrs=
X-Received: by 2002:ac2:538d:0:b0:5b2:b0eb:5313 with SMTP id
 2adb3069b0e04-5b2f4cb32c8mr827411e87.29.1785951360433; Wed, 05 Aug 2026
 10:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8829E8C06120473E+20260731070714.1287959-1-raoxu@uniontech.com>
In-Reply-To: <8829E8C06120473E+20260731070714.1287959-1-raoxu@uniontech.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 5 Aug 2026 19:35:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iTbz=BMfbeVVDyjmcv_u1x8Sqn3b4sn6x5qCGU=KYqFg@mail.gmail.com>
X-Gm-Features: AUfX_mx09HwPA0HuNuBUf5IDSLBJrYfQ8CBXSFG6Rce_--GAi-EMl7Km2SGBekg
Message-ID: <CAJZ5v0iTbz=BMfbeVVDyjmcv_u1x8Sqn3b4sn6x5qCGU=KYqFg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: TAD: report expired alarm status through RTC
To: raoxu <raoxu@uniontech.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 9:07=E2=80=AFAM raoxu <raoxu@uniontech.com> wrote:
>
> From: Xu Rao <raoxu@uniontech.com>
>
> acpi_tad_rtc_read_alarm() always sets rtc_wkalrm::pending to zero, so
> RTC_WKALM_RD cannot report that a TAD alarm has expired.

Well, "pending" doesn't mean "expired".

> ACPI 6.6, Section 9.17.5 defines _GWS as returning a DWORD bit field.
> Bit 0 indicates that the selected timer has expired, bit 1 indicates
> that it caused a platform wake, and bits 31:2 are reserved. Therefore,
> only bit 0 maps to rtc_wkalrm::pending; converting the complete _GWS
> value to bool would incorrectly treat the wake-source bit or a nonzero
> reserved bit as an expired alarm.
>
> Read _GWS for the AC timer, reject values wider than the specified
> DWORD, and report its expired bit through rtc_wkalrm::pending. This
> matches the existing read path, which reads the AC timer because alarms
> programmed through the RTC interface set the AC and DC timers to the same
> value.
>
> Fixes: 7572dcabe38d ("ACPI: TAD: Add alarm support to the RTC class devic=
e interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/acpi/acpi_tad.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
> index fc43df083738..610840c6240d 100644
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -51,6 +51,9 @@ MODULE_AUTHOR("Rafael J. Wysocki");
>  #define ACPI_TAD_AC_TIMER      (u32)0
>  #define ACPI_TAD_DC_TIMER      (u32)1
>
> +/* ACPI TAD wake alarm status flags (ACPI 6.6, Section 9.17.5) */
> +#define ACPI_TAD_WAKE_STATUS_EXPIRED   BIT(0)
> +
>  /* Special value for disabled timer or expired timer wake policy. */
>  #define ACPI_TAD_WAKE_DISABLED (~(u32)0)
>
> @@ -709,6 +712,7 @@ static int acpi_tad_rtc_set_alarm(struct device *dev,=
 struct rtc_wkalrm *t)
>  static int acpi_tad_rtc_read_alarm(struct device *dev, struct rtc_wkalrm=
 *t)
>  {
>         unsigned long long retval;
> +       unsigned long long status;
>         struct rtc_time tm_now;
>         struct acpi_tad_rt rt;
>         int ret;
> @@ -740,7 +744,14 @@ static int acpi_tad_rtc_read_alarm(struct device *de=
v, struct rtc_wkalrm *t)
>         if (retval > U32_MAX)
>                 return -ENODATA;
>
> -       t->pending =3D 0;
> +       ret =3D __acpi_tad_wake_read(dev, "_GWS", ACPI_TAD_AC_TIMER, &sta=
tus);
> +       if (ret)
> +               return ret;
> +
> +       if (status > U32_MAX)
> +               return -ENODATA;
> +
> +       t->pending =3D !!(status & ACPI_TAD_WAKE_STATUS_EXPIRED);

ACPI_TAD_WAKE_STATUS_EXPIRED doesn't actually mean a "pending interrupt".

>
>         if (retval !=3D ACPI_TAD_WAKE_DISABLED) {
>                 t->enabled =3D 1;
> --
