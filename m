Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793639710;
	b=xeraoRHXe+QecY48zYRl5cj4iOm8h1TQZIwiBKKLU21Ek+r2eVRROVWgyEmBbLSSruss
	 JNlNZRBYwPO5ISbBxUWUc95fxOm8TNs7PKrVY4T6AB2KyJ3nzwzYv8QRqO6IPplYMOhHH
	 8wVmMoSGfI9sRlF5nFTATyrHLZKhWvMAdLYUIAqNkknOps/YooXLhanF5qt3rLrElK5R1
	 nclweISuosLp3QPVSUmRVjZn9QCMl6/b8eAPW4nknVCF2cnZ5aIn23EChREGjIDVvFAW2
	 uOzttflFSPyLbmDLWIisiRZ94KVud62sDopr5wdKIR0IFJTEpfhlt67L9FFH2TL81fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793639710;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=NavCnIFm0AweVazWDKe4qhf+cy2p1D0G3tM/6sqx7S4=;
	b=GeQSX5lxJmTzV2gBZdN2yR3i5mbJefW2A9i4y9xxlVO7aPa1vEDFuxn4FBEqCPav84Z3
	 pw7lhS6QBPpLqTOgBLhiNQQA8kn5/+ZGYSWRQ8tNwicBMsGcFf+uZDAuiZztufTL8IWj0
	 sjZ1a68tbVCDi4NgUdjBXsw0LUFyA4WuMOvQhSUqMt7IxO6wpELzPVOTn2AJP6EYSViFH
	 9avdpAyaBy0+gw2y8Nkusden1qQ625TVJWuO3twFB3lWmdKo/Mu9Lm4KOLM3e26KJ9s7e
	 +KVG1WuFYfln1IigmAIxDHU55GR86Da1e4fJ5xZjeTa0fLVJnsNfrgeFbwVqn7uka1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jCxpMyMs;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A1607220F;
	Mon,  2 Nov 2026 17:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 885A1607220F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jCxpMyMs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793639709; x=1825175709;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=wgA3wRQC1afllMNVeVGhV6lujmKAxOGnZcEDZZ2xY+4=;
  b=jCxpMyMsUZud47oD6hZFBvij5dFPfJgboIcJax/ksBnK4XlkANSqm2ht
   WvqkprKhjViylIWcwcJzavWRv9MKJGwThCU2FU57WWNmXYP0iw3Xy4CHa
   3RBNhAIO52Bwa6xbcKXoisyQ5DFjjluJLes6Cp5VvOC+wapHKEvLlxP7N
   k2/7dLatl7AlhA5QXzqLXg8vOX8joJTyZANxnaFGJTnXJLpNAqMxhtLoa
   87qbPQqz55QR3PHTwHzWdPHJg4NkQZlsYVGDLoVgmx82vmteOGqj9o5Zj
   U4SDGXuK6vzfoF6td14KWZd1ESUINg1flvFev1OJ82m8vGOKMnfHATCRu
   w==;
X-CSE-ConnectionGUID: FgKjec9ER/CqYHSlqpf1NA==
X-CSE-MsgGUID: 6F0362yBRoum9W/Jtjm7xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2221776"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2221776"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:15:08 -0800
X-CSE-ConnectionGUID: E6CLiraZQueMZNKb7ENaFg==
X-CSE-MsgGUID: itX1B9qMRoewQ2rvGh6tug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="8017180"
Received: from spandruv-desk2.jf.intel.com ([10.24.80.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 09:15:08 -0800
Message-ID: <fa1b3732119eafd8dd6944b9324518213026fd0b.camel@linux.intel.com>
Subject: Re: [PATCH] iio: hid-sensor: Fix scale for magnetic north heading
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Maximilian Czirr <maxx-cz@web.de>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, stable@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>, "Zhang, Lixu" <lixu.zhang@intel.com>
Date: Mon, 02 Nov 2026 09:15:07 -0800
In-Reply-To: <20261102003513.2796a9a9@jic23-hlaptop>
References: <20261007000107.16533-1-maxx-cz@web.de>
		<20261018203659.4f2b886e@jic23-hlaptop>
	 <20261102003513.2796a9a9@jic23-hlaptop>
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

On Mon, 2026-11-02 at 00:35 +0000, Jonathan Cameron wrote:
> On Sun, 18 Oct 2026 20:36:59 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Wed,=C2=A0 7 Oct 2026 02:01:07 +0200
> > Maximilian Czirr <maxx-cz@web.de> wrote:
> >=20
> > > hid_sensor_format_scale() applies the HID unit exponent only when
> > > the usage and unit match an entry in unit_conversion[].
> > >=20
> > > Rotation-from-north support uses
> > > HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH, but that usage has no
> > > entry in
> > > the conversion table. As a result, the unit exponent is ignored
> > > and the
> > > heading can be exposed with a scale of 1 instead of the scale
> > > specified
> > > by the HID descriptor.
> > >=20
> > > Add a unitless conversion entry so the HID unit exponent is
> > > applied to
> > > the magnetic north heading. A sensor reporting an exponent of -5
> > > then
> > > correctly exposes a scale of 0.00001 instead of 1.
> > >=20
> > > Fixes: abea9c62c32f ("iio: hid-sensor-magn-3d: Add support for
> > > rotation from north")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Maximilian Czirr <maxx-cz@web.de>=C2=A0=20
> >=20
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> > +CC the hid-sensors maintainers + Lixu who has been helping a lot
> > with this driver recently.
> >=20
> Srinivas, another one for you to check when you have a moment!
>=20
> No huge rush - I'm just having a scan through what is outstanding
> in patchwork to make sure I didn't miss anything.
>=20
> thanks
>=20
> Jonathan
> > > ---
> > > =C2=A0drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 ++
> > > =C2=A01 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-
> > > attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-
> > > attributes.c
> > > index 9e7c26e37880..26f8554d18a5 100644
> > > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > > @@ -38,6 +38,8 @@ static const struct {
> > > =C2=A0	{HID_USAGE_SENSOR_COMPASS_3D, 0, 0, 1000000},
> > > =C2=A0	{HID_USAGE_SENSOR_COMPASS_3D,
> > > HID_USAGE_SENSOR_UNITS_GAUSS, 1, 0},
> > > =C2=A0
> > > +	{HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH, 0, 1, 0},
> > > +
> > > =C2=A0	{HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 0, 17453293},
> > > =C2=A0	{HID_USAGE_SENSOR_INCLINOMETER_3D,
> > > =C2=A0		HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453293},=C2=A0=20
> >=20
> >=20
