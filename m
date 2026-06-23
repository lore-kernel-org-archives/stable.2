Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D0F38B142;
	Tue, 23 Jun 2026 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242624; cv=none; b=lMrHSb0na2xm3P46w4gFHGkpUMDpDgsvpBGKn7EVMQnvMvE6lGvHzAoSycUi3zgKBRFLPO30rc6vR4q9/qf1h69sC8fX1iC9XblEiI3TkfvLVSx7sWkfkcLctreauhZfBqsKvrbgIEVHToq2RLbXfpfcG2OiiT2kCQYb9hU8fuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242624; c=relaxed/simple;
	bh=O7DR9ILkd2nJoHBh2TQnDbYT3Y7Ne14/dVuQzQqfa9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdlo3GaTifF/lhesZvYzgEMoxkN7MG8lljtf7FHw6nQednR8JfRW7xy0kndH1SJW08xQFj/H2KBuqwpAt6TRM4TWDwyPJv47yHJ4Fb/SAspC28z2YtW9lrEaNqjZBp/xMyadO+s8fYWSIv2tgi7Z5PXb0XLgoSAU3RXnAy11ck4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WShvWu8F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WShvWu8F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1B61F000E9;
	Tue, 23 Jun 2026 19:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782242623;
	bh=/eUnBmyw2rFOllRrbRo6eVqfdlq5TkvvC1+VM9YXfiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WShvWu8FV9VtCbeNSuU3WtBZKK/Ri3PUigE77CXwQuUY0D3+bwB26QgV+gnHoITwV
	 n7K3XMkwYI71pqkqNpj5mv+02apbsy8aGitAfGB/8T6XQwE59w+PMP5dZATy+g+Jlm
	 B/cc5C+aRK4aBueXfjtAwsozb3Zrck8Af0uYhTAGnByUGn5cKojNNwdfyfy5Vbrm3f
	 bswxYtvL5qtpB6dnfEtg6WIg8UVvlym6aANEoHU4dVfxM0xPMpRoZN24DmZcAn8t8B
	 Oyp5fWMyGs/lLSnBAl6UrDe4TZFjYO27HxPVf9dlk2X23M0+NkDrVnemc5xWBNhdZs
	 AfRFMm5ZD/Sdg==
Date: Tue, 23 Jun 2026 20:23:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Herman van Hazendonk <github.com@herrie.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Denis Ciocca
 <denis.ciocca@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Denis Ciocca <denis.ciocca@st.com>, Linus Walleij
 <linusw@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: common: st_sensors: honour channel
 endianness in read_axis_data
Message-ID: <20260623202334.2217b1d4@jic23-huawei>
In-Reply-To: <ajJwzsIMxX3Ew1x_@ashevche-desk.local>
References: <20260616-submit-iio-lsm303dlh-magn-fixes-v2-0-063edcf74e60@herrie.org>
	<20260616-submit-iio-lsm303dlh-magn-fixes-v2-1-063edcf74e60@herrie.org>
	<ajJwzsIMxX3Ew1x_@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jun 2026 13:02:54 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jun 16, 2026 at 03:02:04PM +0200, Herman van Hazendonk wrote:
> > st_sensors_read_axis_data() unconditionally decoded multi-byte
> > results with get_unaligned_le16() / get_unaligned_le24() regardless
> > of the channel's declared scan_type.endianness.
> >=20
> > For every ST sensor that has used this helper since it was introduced
> > this happened to be fine because the ST IMU/accel/gyro/pressure
> > families publish their data registers as little-endian and the
> > channel specs in those drivers declare IIO_LE accordingly.
> >=20
> > The LSM303DLH magnetometer however publishes its X/Y/Z output as a
> > pair of big-endian bytes (the H register sits at the lower address,
> > 0x03/0x05/0x07, and the L register immediately after), and its
> > channel specs in st_magn_core.c correctly declare IIO_BE -- but
> > read_axis_data() ignored that and decoded as little-endian, swapping
> > the high and low bytes of every magnetometer sample. The LSM303DLHC
> > and LSM303DLM share the same st_magn_16bit_channels (IIO_BE) and
> > were therefore byte-swapped by the same bug; users of those parts
> > will see different in_magn_*_raw values after this fix lands.
> >=20
> > The bug is most visible on a stationary chip: in earth's field the
> > true X reading is small and the high byte sits at 0x00, so swapping
> > the bytes pins sysfs X at exactly the low byte's pattern (e.g. 0x00F0
> > =3D 240). Y and Z still appear "to vary" because their magnitudes are
> > larger and the noise in the low byte produces big swings in the
> > swapped high byte:
> >=20
> >   before (LSM303DLH flat, sysfs in_magn_*_raw):
> >       X=3D240 (stuck), Y=3D 12032..23296, Z=3D-16128..-9728
> >=20
> >   after (direct i2c-dev big-endian decode, same chip same orientation):
> >       X=E2=89=88-4096, Y=E2=89=88210, Z=E2=89=8880     (sensible values=
 reflecting earth's
> >                                 ambient field at low gauss range)
> >=20
> > Fix read_axis_data() to dispatch on ch->scan_type.endianness and
> > call get_unaligned_be16() / get_unaligned_be24() when the channel
> > declares IIO_BE. Existing IIO_LE consumers (st_accel, st_gyro,
> > st_pressure, st_lsm6dsx and others) are unaffected because their
> > channel specs already declare IIO_LE and the LE path is unchanged.
> >=20
> > While restructuring the branches, replace the previously implicit
> > silent-success-with-uninitialised-*data fall-through for
> > byte_for_channel outside 1..3 with an explicit return -EINVAL. No
> > in-tree ST sensor publishes such a channel, but the new behaviour
> > is strictly safer than handing userspace garbage. =20
>=20
> Sounds like inevitable change in ABI, but worth doing it.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Applied to the fixes-togreg branch of iio.git. I'll wait until after
rc1 to send a pull request though (and rebase on rc1 in the meantime).
The other patches may have to wait, I haven't checked yet!

Jonathan

>=20

