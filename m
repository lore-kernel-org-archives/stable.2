Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906799;
	b=gBV1dzec4T7Nl5DmlTnQOm1ujztMd2xYab+Cd+wo59wReDJH3zE9Dna0JTI45mKBPv1a
	 sA+Nvr7tanz3nZb9YXbJW2uSFo6Mteqw5aM5kZQI8cpawg4aMj+DWmULSUK4lpiqvYsSx
	 WFTxr/jhbeAceM1KoCE7tfNqYbnIN5LF/5BEb1AE6DSAbSdrkmcF65AN6pRaB198/42bG
	 3oeq9HBcrP3+QDYEQjJyDHlres9lu3zPIzoRSJUZXzrJx0h/4ZL1xaSns+KkAA9/pZJXh
	 ypmWyOU8uauSMYkxRpTbDX/OfNn2mSo9jr3ZBm/m1s8CV/1GcKbBwlW2BmV8QLs+yeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906799;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TZphQxclz2gFW9ezkdnyrlJdzJISPtOa2u0+oLIYQtA=;
	b=nSMFeacMqwe0Tnn1NXZbr3CNBFO0l6LlVECnghGZwNexEegH0HkiuV33kZjHUmSols5S
	 /2DxRCuq9eGeXIw3/CQnIwHo/F4q30x3JuGXpFjjtc2gRlgo9k7eXxQxPD8J/qqMh1Z+N
	 6Eu/VucBg/lgBMYtsnXCE/uo8xu3ooM+/FzhLqFrfnFI1uPdU5sYBH78LEw0PSoX8YUfv
	 m9pzg65XCdFGOzDtoxtgOJMKfvdJqkmVPB/LsyRECgUyRdzsAjKCgMq3+b9gUJNP6wtDJ
	 pD+j8YqhNoLLgMtKsaTY8EPqg44lh+WiMcfyx2hYYfsFTy7N3EMEMHab9y0DAT0ZKYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=maryasin.name;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F8606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 481F8606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=maryasin.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso3636492a12.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 11:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793906798; x=1794511598;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TZphQxclz2gFW9ezkdnyrlJdzJISPtOa2u0+oLIYQtA=;
        b=ti/K4vJ6MpNeOt1PoSNVlL6nuMVS/ZP/mxY/ZK83xM6kVk+NzNS5kI7odjmaDSLN7q
         mT9R765ZJ0bWTK3BwZpVBNvuycdGt4FFAQedtBziniIXVw+/O1LJapvQnF1I6NBed10Q
         KEBbL/N8vn1q/NJwIXRzxVDfNTlKuQaO1p4yyBVKNtywBtaVtFB/xjo4LnNY74Xg3UDT
         bAU0HmlRrmhZ+1LhkZh0mG1/VXSG7XGuOWOYsS5Fmr/FFJA8Th5o4JcYmMPC4oWBwoU3
         xmbpFojcCL95T77QGyEkN8L94n6vLxh+0PSZFDaoE7vlzy4nnBhrUEo0zcDLYRfU8NpX
         IXGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbeSo+c780Po1hJ/k/uHfcaXuZS3Ttz/rf9N0eVf+9T1yL5x4zUW29y/Ffuah9OHbmNeaXZJw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ydAZi2tV2g6Lwk2871X8FtsFZKzGma/LKT0ktsfyAcLMtFswB
	puTurI0ItJ9f6F6GTIJo0s1V9yJpBKAbEGMBnDiIYMaW9M86svjBtHguvdkrB1nCmUdeoA==
X-Gm-Gg: AYBFou1EFnEvGEZ56nVSCzHpwXvX68kEOkfvDJkLuTbrk8Ku7OPgBQ/gUagTpP4YqIt
	WAyN39t+stISahQa1zMnjWczA1FPR+7ME38BksiGd+eMOb5DSqrXp8Dw8dTBmAvE1XO4t5RZR4C
	ztFdnIbnD8Y+nQVJREh20eIS4KVf+I7rpEcqsYQPev2HRe3ZkPLa485OGL1iSan2lPmZcCCGf6H
	Fzr3GTbQZhQia4yayV9sTblq0wVnyaxzbsCycqy5X5jwRRenKbQ/eioVjfD9srxZl2py0mJ+h1X
	+V0o3UFL37XYCs11sKwKxmy5imqj5n33MYKonO2cbmw7CVYeZl7kA6FVxyshV9Eb+/rt/E6q94Z
	eJEQp3FC9oxhVTCxM4fV7Q4oxxZNAb9ZySE/b6kM7Uh5BmUb/u+YcwcLt1BUj9r3VA2mNwVuzXz
	N8omxQvlmzeowvedYJTIGHHfkKAzUdN1ysbuiwdYia8kMZOZ7k66v2VHIaaDbszZzPyqP7e6OSV
	jNmiQcnWvLGj37Uv01oDs378KXj8Idk9B8EYdUn+zx/2IU7zanxJac6Y2sWj3RT+B4EydtvEx7t
	Z9RUO18D8nvC3w5H26Z3YCwNacpMiazOKjACNeC/n+Wgy7Z4BxrqXB78RUDp74KF4CKgHug3MHP
	znnsQFQJgENei6om/hZTOyRljMSHmnMmaBGzG4W53M3AhQM4cpaNQsVER5K97P29sDia3t8LH2V
	US9RCcVj8Ewybf
X-Received: by 2002:a05:6402:51d3:b0:6b5:7873:b138 with SMTP id 4fb4d7f45d1cf-6b5978092dcmr135261a12.40.1793906797392;
        Thu, 05 Nov 2026 11:26:37 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac44f48sm2058923a12.12.2026.11.05.11.26.36
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 11:26:36 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso3636452a12.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 11:26:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByg4EoWTUf5cNUe0wQThVKTIVaOLaoCoej4TlyEX1cFSaUaVN+OKPU/uBBT2xchM5+vn+aRMf8=@vger.kernel.org
X-Received: by 2002:a05:6402:280f:b0:6b5:8674:c01d with SMTP id
 4fb4d7f45d1cf-6b5975277f0mr197220a12.5.1793906796627; Thu, 05 Nov 2026
 11:26:36 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104165319.1890851-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20261104165319.1890851-1-srinivas.pandruvada@linux.intel.com>
From: =?UTF-8?B?0KHQtdC80ZHQvSDQnNCw0YDRjNGP0YHQuNC9?= <simeon@maryasin.name>
Date: Thu, 5 Nov 2026 22:26:25 +0300
X-Gmail-Original-Message-ID: <CAM2dg7dnvj7X3Fo9r_=Pn=EHxUwyFEwQN6XdLLPmOAdaY76JfQ@mail.gmail.com>
X-Gm-Features: AclHuK9weJ0gP1AI6YK6eNmMlqgPCqXQEUZ4hk_XFsi6eDTrhg4oCQvVn1yYuq4
Message-ID: <CAM2dg7dnvj7X3Fo9r_=Pn=EHxUwyFEwQN6XdLLPmOAdaY76JfQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: hid-sensors: fix fractional part for unit
 exponents -7 and -8
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, jic23@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Semyon Maryasin <simeon@maryasin.name>

Here is what I observe with this patch:
1. Enable sensor and run xxd /dev/HID-SENSOR-2000e1.3.auto
2. In the second terminal, do rmmod intel_ishtp_hid
3. Observed result: xxd stops with "xxd: No such device"
4. At the same time, in kernel logs I see the following:

=D0=BD=D0=BE=D1=8F 05 22:19:16 dook kernel: hid-sensor-hub 001F:8087:0AC2.0=
005:
timeout waiting for response from ISHTP device
=D0=BD=D0=BE=D1=8F 05 22:19:19 dook kernel: hid-sensor-hub 001F:8087:0AC2.0=
005:
timeout waiting for response from ISHTP device
=D0=BD=D0=BE=D1=8F 05 22:19:22 dook kernel: hid-sensor-hub 001F:8087:0AC2.0=
006:
timeout waiting for response from ISHTP device
=D0=BD=D0=BE=D1=8F 05 22:19:25 dook kernel: hid-sensor-hub 001F:8087:0AC2.0=
006:
timeout waiting for response from ISHTP device

No system crash, so I suppose this is okay?

After subsequent modprobe the sensor initializes and works properly.
No kernel crash with this patch.

=D1=81=D1=80, 4 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 19:53=
, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com>:
>
> split_micro_fraction() scales the remainder to micro units by
> multiplying it by 10^(6 - exp). The unit exponent of a HID field goes
> down to -8, so exp can be 7 or 8 here. Then the argument of int_pow()
> is negative, which the unsigned parameter turns into a huge power of
> ten: 0 modulo 2^64. As a result, the fractional part of a value read
> from the hysteresis attributes is always reported as 0.
>
> Divide by 10^(exp - 6) in these two cases. This matches the reverse
> conversion in convert_to_vtf_format().
>
> Fixes: 73c6768b710a ("iio: hid-sensors: Common attribute and trigger")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2:
> - Fix __udivdi3 link error on 32-bit by using a 32-bit divisor
> - Address Andy's comment:
> Keep no % divisor in a temporary variable next to no / divisor
>
>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/dri=
vers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 9e7c26e37880..d44091faf122 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -96,9 +96,14 @@ static void simple_div(int dividend, int divisor, int =
*whole, int *micro_frac)
>  static void split_micro_fraction(unsigned int no, int exp, int *val1, in=
t *val2)
>  {
>         int divisor =3D int_pow(10, exp);
> +       unsigned int rem;
>
>         *val1 =3D no / divisor;
> -       *val2 =3D no % divisor * int_pow(10, 6 - exp);
> +       rem =3D no % divisor;
> +       if (exp > 6)
> +               *val2 =3D rem / (unsigned int)int_pow(10, exp - 6);
> +       else
> +               *val2 =3D rem * int_pow(10, 6 - exp);
>  }
>
>  /*
> --
> 2.56.0
>
>


--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=
=D0=BD
