Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794083913;
	b=RiCf7aWyq8DN0I1+Iw6CAbKzMbOG+qdSqsVfcNb4vegJGFb6+uJSdzf7ljgU0zWVqlAf
	 eysqIC2AJL/yQi6LOg15e1rmMA9+Hs4tsohAUJz9RqfA55kZGalyiqx57z9qG5wEdPJhb
	 xMuoksZCgmRx/VG2q3yd9oxRgZpbK4mfjL+ek030nu2sNMZ57oparbwV6tT0MGbUDdVhb
	 Jc0/N3hn342ekOxpf3YLsuvMA5cd/xC46XZ1ZOQ7u6U3+O7euc+yC+miVjTB/bYiaylhX
	 uCtr0u+fHZaBJ0q2hTxHUP/Hv93hEYt4Ua7BabaMGwuaCqd/Gnon/5YsmKyCujL2tUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794083913;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=k1NDAYVTI0gMo1fR2XywehCeetsAagr1fmpBupImFSc=;
	b=3vljWQK0cLJcSmD0DNQoyPlo2GZEAuyzkIeBVXiVp0md9gEwiKX/SnuHC0juNbUAkI8w
	 girk158eUfQJ3+0MBjpKa71jfPXAG/nSfTrOXrlGzGNu5uGuHD1vXavgPT6pMEZ99mkYj
	 7AUMMJW93LbzY0+5vsR2Mfl0hP84jZWOcmkO2ilEzCZSxaQUsuUsspssQMgqVexJ8W3HC
	 sZY3ZL4PKEuOYVYfGUEZsWw5cWVuhj1RFpKgwJQNEP92gr7LZwW84vXgCYUfN0ah3Y6Tw
	 Y6UvEzU8zP3Ll765vNgoLdRyNkvsNAxP7+KhyEdAt+CxDkdRKDWnRvFD51+ZeIszF2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODo+SvZu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C91606A32D;
	Sat,  7 Nov 2026 20:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ODo+SvZu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC7A1F0089F;
	Sat,  7 Nov 2026 20:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794083912;
	bh=k1NDAYVTI0gMo1fR2XywehCeetsAagr1fmpBupImFSc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ODo+SvZu9laO+Oezbbdm7auRwZ4BUbLEDE7CtQPCh1paxKDuQQDXOzxXJvS2bKNz3
	 q58qVh8HIV2pCX25GANZCwWWnADgt4f+XPppYMZT6g2AIfakc52tYnfNWwnZ91u7Hs
	 nFNYzVW6jNv1l4MsclMtSuZKkuoS721BmV9JyRWgVd8oje2WuwLvK5Z3FMleN3xoPz
	 1cH2mthCBAywtwIIwzCq6sf3pJMmKIlNuKEEXdbgGDtKQBGPIoWW94JbwtAlfHswAv
	 aZZgu8BrtdpcsvBOPHHpyIsUMH1+zlCB2nX1RdxehXeua0MLtTUnRYl7m2V4q0RtVr
	 ECW+1jCccXlIw==
Date: Sat, 7 Nov 2026 20:38:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: =?UTF-8?B?0KHQtdC80ZHQvSDQnNCw0YDRjNGP0YHQuNC9?= 
 <simeon@maryasin.name>, jikos@kernel.org, bentiss@kernel.org,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: hid-sensors: fix fractional part for unit
 exponents -7 and -8
Message-ID: <20261107203825.6988b783@jic23-hlaptop>
In-Reply-To: <53c382715b89d26f77f495f79036d31850bf453d.camel@linux.intel.com>
References: <20261104165319.1890851-1-srinivas.pandruvada@linux.intel.com>
	<CAM2dg7dnvj7X3Fo9r_=Pn=EHxUwyFEwQN6XdLLPmOAdaY76JfQ@mail.gmail.com>
	<53c382715b89d26f77f495f79036d31850bf453d.camel@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 05 Nov 2026 15:56:26 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Thu, 2026-11-05 at 22:26 +0300, =D0=A1=D0=B5=D0=BC=D1=91=D0=BD =D0=9C=
=D0=B0=D1=80=D1=8C=D1=8F=D1=81=D0=B8=D0=BD wrote:
> > Tested-by: Semyon Maryasin <simeon@maryasin.name>
> >=20
> > Here is what I observe with this patch:
> > 1. Enable sensor and run xxd /dev/HID-SENSOR-2000e1.3.auto
> > 2. In the second terminal, do rmmod intel_ishtp_hid
> > 3. Observed result: xxd stops with "xxd: No such device"
> > 4. At the same time, in kernel logs I see the following:
> >=20
> > =D0=BD=D0=BE=D1=8F 05 22:19:16 dook kernel: hid-sensor-hub 001F:8087:0A=
C2.0005:
> > timeout waiting for response from ISHTP device
> > =D0=BD=D0=BE=D1=8F 05 22:19:19 dook kernel: hid-sensor-hub 001F:8087:0A=
C2.0005:
> > timeout waiting for response from ISHTP device
> > =D0=BD=D0=BE=D1=8F 05 22:19:22 dook kernel: hid-sensor-hub 001F:8087:0A=
C2.0006:
> > timeout waiting for response from ISHTP device
> > =D0=BD=D0=BE=D1=8F 05 22:19:25 dook kernel: hid-sensor-hub 001F:8087:0A=
C2.0006:
> > timeout waiting for response from ISHTP device
> >=20
> > No system crash, so I suppose this is okay?
> >  =20
> That is fine.
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

>=20
> Thanks,
> Srinivas
>=20
>=20
> > After subsequent modprobe the sensor initializes and works properly.
> > No kernel crash with this patch.
> >=20
> > =D1=81=D1=80, 4 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 1=
9:53, Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>: =20
> > >=20
> > > split_micro_fraction() scales the remainder to micro units by
> > > multiplying it by 10^(6 - exp). The unit exponent of a HID field
> > > goes
> > > down to -8, so exp can be 7 or 8 here. Then the argument of
> > > int_pow()
> > > is negative, which the unsigned parameter turns into a huge power
> > > of
> > > ten: 0 modulo 2^64. As a result, the fractional part of a value
> > > read
> > > from the hysteresis attributes is always reported as 0.
> > >=20
> > > Divide by 10^(exp - 6) in these two cases. This matches the reverse
> > > conversion in convert_to_vtf_format().
> > >=20
> > > Fixes: 73c6768b710a ("iio: hid-sensors: Common attribute and
> > > trigger")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com>
> > > ---
> > > v2:
> > > - Fix __udivdi3 link error on 32-bit by using a 32-bit divisor
> > > - Address Andy's comment:
> > > Keep no % divisor in a temporary variable next to no / divisor
> > >=20
> > > =C2=A0drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 7 ++++=
++-
> > > =C2=A01 file changed, 6 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > index 9e7c26e37880..d44091faf122 100644
> > > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > @@ -96,9 +96,14 @@ static void simple_div(int dividend, int
> > > divisor, int *whole, int *micro_frac)
> > > =C2=A0static void split_micro_fraction(unsigned int no, int exp, int
> > > *val1, int *val2)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int divisor =3D int_pow(10=
, exp);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int rem;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val1 =3D no / divisor;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val2 =3D no % divisor * int_po=
w(10, 6 - exp);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rem =3D no % divisor;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (exp > 6)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *val2 =3D rem / (unsigned int)int_pow(10, exp - 6);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 *val2 =3D rem * int_pow(10, 6 - exp);
> > > =C2=A0}
> > >=20
> > > =C2=A0/*
> > > --
> > > 2.56.0
> > >=20
> > >  =20
> >  =20

