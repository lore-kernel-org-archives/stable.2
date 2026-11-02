Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656196;
	b=Mbb/9+WkYwb35ywBNsvYUydiiIHSiEVNY4W0PpZdtuMzz+3GuHuxCprGyoRk3O/5toss
	 1eOxKsTYyU0+vT4JLS3hvGjZgJlVZdOgv7XEVS4Hz4ZSEj6ZXIzlzSvQZL8zGZbA98E/6
	 2qbFDdustbe6IRZnNQijtefN2U4BgWRuR3ySqhqjqVFSn1aCJ/OjCShd8oHs2cqS/vqbX
	 kKsgU8SSPu3W5lAJfIgRMAKMnmh4qKBCJL02doym2iKlkkH7/anA/eoVgDYmUA/ilcaVN
	 0OP7LT4847NZOWJB1omB/YoRIQOClAAMx2gkaS8bdCp27JN98d5Y6t7bUum/IrK6eYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656196;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=CId9CHPajlpjIg9hifRIjT/mpuc8nix8F228eUG1znM=;
	b=SuaRZyNasaJqAR0+CjdQUawY6cCsadWdWbbiq7NcSsXfuTA+IiQcXFTuEtKp7aj0yPen
	 LkkrTSPickrjNOAv8ZlP3Tu/R5pOw2E9yQIXti9LBcZFfXYIMb0k3awPECoKzj7cP3e/U
	 ud/GbULXwbqsu+jGc/yKro8JNpVoxOcQzSiKEsc/fc+fWN5hib3EmsM5M7hJq8Rpy1BMv
	 RGWOCzKu/zaMI0IpF0LDK6N9K+hEYI9c9DA2LJ7ITh1PDUU7WHEiwfkweoexPtp5qmYVQ
	 0H1W+fc+9MZyVE46MoY4kxpU2k7QS4HmeWCgUtYKaq9tEjmxTHGORkBmjFsb6boMLqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvJIMhGJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF3F606A324;
	Mon,  2 Nov 2026 21:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvJIMhGJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66801F00A16;
	Mon,  2 Nov 2026 21:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793656196;
	bh=CId9CHPajlpjIg9hifRIjT/mpuc8nix8F228eUG1znM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IvJIMhGJ3UzMIoV+MhiqxLIGTUhMH1CHos4+8ve4dkFJwgrG0m34DTwMgTut5ZHNq
	 eAMMZh3ADP/dg2Gik1mxcuI121HRcJzU9xp15twdsY09Zls+gm75Wt8cbvRSln5037
	 8K0aI3VW/YU8SogagDUKiC/9ddht6LJcYkTN99NPywzbRVCSE+67x0mDSIcwxfh/nV
	 0CcrA6sx9NSJEaw2RoWXkgEMd6Aq4Zah1q80TeUwVmW9N22+vjbsUPmO26WjNZ2ieI
	 UzEnxa60kLQm2P2CWwKRJjonPY/nDmIfwZQ1Kpm4CX+vAHEbUBPD6ARiWXb+mTK+/Q
	 quR4h9qptwdew==
Date: Mon, 2 Nov 2026 21:49:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Maximilian Czirr <maxx-cz@web.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=	 <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, stable@vger.kernel.org, Jiri Kosina
 <jikos@kernel.org>, "Zhang, Lixu" <lixu.zhang@intel.com>
Subject: Re: [PATCH] iio: hid-sensor: Fix scale for magnetic north heading
Message-ID: <20261102214950.6df57c10@jic23-hlaptop>
In-Reply-To: <fa1b3732119eafd8dd6944b9324518213026fd0b.camel@linux.intel.com>
References: <20261007000107.16533-1-maxx-cz@web.de>
	<20261018203659.4f2b886e@jic23-hlaptop>
	<20261102003513.2796a9a9@jic23-hlaptop>
	<fa1b3732119eafd8dd6944b9324518213026fd0b.camel@linux.intel.com>
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

On Mon, 02 Nov 2026 09:15:07 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Mon, 2026-11-02 at 00:35 +0000, Jonathan Cameron wrote:
> > On Sun, 18 Oct 2026 20:36:59 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  =20
> > > On Wed,=C2=A0 7 Oct 2026 02:01:07 +0200
> > > Maximilian Czirr <maxx-cz@web.de> wrote:
> > >  =20
> > > > hid_sensor_format_scale() applies the HID unit exponent only when
> > > > the usage and unit match an entry in unit_conversion[].
> > > >=20
> > > > Rotation-from-north support uses
> > > > HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH, but that usage has no
> > > > entry in
> > > > the conversion table. As a result, the unit exponent is ignored
> > > > and the
> > > > heading can be exposed with a scale of 1 instead of the scale
> > > > specified
> > > > by the HID descriptor.
> > > >=20
> > > > Add a unitless conversion entry so the HID unit exponent is
> > > > applied to
> > > > the magnetic north heading. A sensor reporting an exponent of -5
> > > > then
> > > > correctly exposes a scale of 0.00001 instead of 1.
> > > >=20
> > > > Fixes: abea9c62c32f ("iio: hid-sensor-magn-3d: Add support for
> > > > rotation from north")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Maximilian Czirr <maxx-cz@web.de>=C2=A0  =20
> > >  =20
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Thanks.

Applied to the fixes-togreg branch of iio.git

Jonathan

>=20
> > > +CC the hid-sensors maintainers + Lixu who has been helping a lot
> > > with this driver recently.
> > >  =20
> > Srinivas, another one for you to check when you have a moment!
> >=20
> > No huge rush - I'm just having a scan through what is outstanding
> > in patchwork to make sure I didn't miss anything.
> >=20
> > thanks
> >=20
> > Jonathan =20
> > > > ---
> > > > =C2=A0drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 ++
> > > > =C2=A01 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-
> > > > attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-
> > > > attributes.c
> > > > index 9e7c26e37880..26f8554d18a5 100644
> > > > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > > @@ -38,6 +38,8 @@ static const struct {
> > > > =C2=A0	{HID_USAGE_SENSOR_COMPASS_3D, 0, 0, 1000000},
> > > > =C2=A0	{HID_USAGE_SENSOR_COMPASS_3D,
> > > > HID_USAGE_SENSOR_UNITS_GAUSS, 1, 0},
> > > > =C2=A0
> > > > +	{HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH, 0, 1, 0},
> > > > +
> > > > =C2=A0	{HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 0, 17453293},
> > > > =C2=A0	{HID_USAGE_SENSOR_INCLINOMETER_3D,
> > > > =C2=A0		HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453293},=C2=A0  =20
> > >=20
> > >  =20

