Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793922989;
	b=WPEpk6TtfkW7YNpuRZZOMacIgRVnF7HGNdGdIHP/3RsFmIMX3UkRvxUQ6y7dqmfOruEg
	 OXtR7qDgw2X95ECq0/wRHKziIbI5fwC0ZSzlWBSY3GhoeRC+Mdi+1eFrcW7eKNMzSuBxa
	 I6nOzfC266hLjuZRR8fmiKOaN3UbNqwq86k3wCQ5ZsKA0l1A7czjQQJfyU4MUY5z2gFip
	 uWBG4PG9gaA+M3UjA7PQdLhSo4aunWhjBCbJwmcID1HL1wya3Hl3eRn/lpQvs2yBsBWrO
	 oyYhACNIZmBfjKYlWImPUKEoPIUxQ/5dxrOQ+Skfu6ryRcrUkTIx+kohPAff2H7PDbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793922989;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Xeo8mejeTn2es9Yu6qh9AX3+Oz1tjzirKy+z9YOighI=;
	b=XrYwNZWYF53kZI4EoH8+RkQVWXGpJ4aGl4lGEqyto66me6SuQ791LfvWgHSOVCEY0JR3
	 EXrAoG/b/gzmWMBOv9mwp4um7+DkzeMGZRkdqf4CFKzAmDaEa7JpqyqK/DWT5y8uAIIp0
	 QZoxELnFTJ8X21SMf90mZI8D+HgOHmftNT2+yx7r+We7R+DefRmseiUrIBQ8BNWRl+urE
	 /Ef4F/B/J2WWbubrD7evDJb9pJ2EApeFyqQFXaBR64eIOtQHtloLm6Sbr/Yef2nDeEFE7
	 aISt1N+VKT6yzRVfvLaOderVT17AMS7bXaIt0kiNH7UsMqldUNUlNLJ+Ji2erD+fG2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=liQzJoL5;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E26606A31B;
	Thu,  5 Nov 2026 23:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52E26606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=liQzJoL5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793922989; x=1825458989;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Xeo8mejeTn2es9Yu6qh9AX3+Oz1tjzirKy+z9YOighI=;
  b=liQzJoL5XVS+2BO6K5HmwvT1vm9gRhgdqOCYBSDkfYw0Wb4+rRpnyUGK
   G7cPwdlFyijhqTCojVCk5m74DfhZ+NG1Uf9YA54SxzT+erYL5nMXO2oV0
   ovVAnzwbuTlaAHeHJrG64SMuwzvPJs6y0mFWJl/xxer1InBA/fF/dqIh4
   EBRkKcAcsjZhbDxPZ0+0kSUrfVKmYR94BuK4gRDsfgsB5ntI8trk+2vAV
   aiR92r02WiLD8zqNNM3CdwTqQMtp9dYWFQjlrx3YCvhAQiN/Vug+P4yr9
   2vL9h0yi2WVeFJ5SQVrGI4xs8r0IOGlbgSaWFIlfeJ7YM0DEyNiDSkwu+
   Q==;
X-CSE-ConnectionGUID: FZGZ4KDIRxKEqjP1oemK6w==
X-CSE-MsgGUID: zEu0f/XHS3mbRO84t4sLUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2631822"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2631822"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 15:56:28 -0800
X-CSE-ConnectionGUID: +9owbXuAQwqBtrnAaS0iTw==
X-CSE-MsgGUID: L8tGT14dSKyEBfO+y+pRuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6973326"
Received: from spandruv-mobl5.amr.corp.intel.com (HELO [10.124.220.35]) ([10.124.220.35])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 15:56:26 -0800
Message-ID: <53c382715b89d26f77f495f79036d31850bf453d.camel@linux.intel.com>
Subject: Re: [PATCH v2] iio: hid-sensors: fix fractional part for unit
 exponents -7 and -8
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: =?UTF-8?Q?=D0=A1=D0=B5=D0=BC=D1=91=D0=BD_?=
 =?UTF-8?Q?=D0=9C=D0=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=D0=BD?=
	 <simeon@maryasin.name>
Cc: jikos@kernel.org, jic23@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 05 Nov 2026 15:56:26 -0800
In-Reply-To: <CAM2dg7dnvj7X3Fo9r_=Pn=EHxUwyFEwQN6XdLLPmOAdaY76JfQ@mail.gmail.com>
References: <20261104165319.1890851-1-srinivas.pandruvada@linux.intel.com>
	 <CAM2dg7dnvj7X3Fo9r_=Pn=EHxUwyFEwQN6XdLLPmOAdaY76JfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-05 at 22:26 +0300, =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=D0=
=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=D0=BD wrote:
> Tested-by: Semyon Maryasin <simeon@maryasin.name>
>=20
> Here is what I observe with this patch:
> 1. Enable sensor and run xxd /dev/HID-SENSOR-2000e1.3.auto
> 2. In the second terminal, do rmmod intel_ishtp_hid
> 3. Observed result: xxd stops with "xxd: No such device"
> 4. At the same time, in kernel logs I see the following:
>=20
> =D0=BD=D0=BE=D1=8F 05 22:19:16 dook kernel: hid-sensor-hub 001F:8087:0AC2=
.0005:
> timeout waiting for response from ISHTP device
> =D0=BD=D0=BE=D1=8F 05 22:19:19 dook kernel: hid-sensor-hub 001F:8087:0AC2=
.0005:
> timeout waiting for response from ISHTP device
> =D0=BD=D0=BE=D1=8F 05 22:19:22 dook kernel: hid-sensor-hub 001F:8087:0AC2=
.0006:
> timeout waiting for response from ISHTP device
> =D0=BD=D0=BE=D1=8F 05 22:19:25 dook kernel: hid-sensor-hub 001F:8087:0AC2=
.0006:
> timeout waiting for response from ISHTP device
>=20
> No system crash, so I suppose this is okay?
>=20
That is fine.

Thanks,
Srinivas


> After subsequent modprobe the sensor initializes and works properly.
> No kernel crash with this patch.
>=20
> =D1=81=D1=80, 4 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 19:=
53, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>:
> >=20
> > split_micro_fraction() scales the remainder to micro units by
> > multiplying it by 10^(6 - exp). The unit exponent of a HID field
> > goes
> > down to -8, so exp can be 7 or 8 here. Then the argument of
> > int_pow()
> > is negative, which the unsigned parameter turns into a huge power
> > of
> > ten: 0 modulo 2^64. As a result, the fractional part of a value
> > read
> > from the hysteresis attributes is always reported as 0.
> >=20
> > Divide by 10^(exp - 6) in these two cases. This matches the reverse
> > conversion in convert_to_vtf_format().
> >=20
> > Fixes: 73c6768b710a ("iio: hid-sensors: Common attribute and
> > trigger")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> > ---
> > v2:
> > - Fix __udivdi3 link error on 32-bit by using a 32-bit divisor
> > - Address Andy's comment:
> > Keep no % divisor in a temporary variable next to no / divisor
> >=20
> > =C2=A0drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 7 ++++++=
-
> > =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > index 9e7c26e37880..d44091faf122 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > @@ -96,9 +96,14 @@ static void simple_div(int dividend, int
> > divisor, int *whole, int *micro_frac)
> > =C2=A0static void split_micro_fraction(unsigned int no, int exp, int
> > *val1, int *val2)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int divisor =3D int_pow(10, =
exp);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int rem;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val1 =3D no / divisor;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val2 =3D no % divisor * int_pow(=
10, 6 - exp);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rem =3D no % divisor;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (exp > 6)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *val2 =3D rem / (unsigned int)int_pow(10, exp - 6);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 *val2 =3D rem * int_pow(10, 6 - exp);
> > =C2=A0}
> >=20
> > =C2=A0/*
> > --
> > 2.56.0
> >=20
> >=20
>=20
