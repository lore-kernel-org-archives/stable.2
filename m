Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793579721;
	b=ifHoOdtTRm80JrF+iNe0qdtAMCWDlurAvM0BqvsQkp2QPP7bWrHMl9OwOTU/qwd1/rp0
	 dgLl8mqTE+vOFk7wn0Dq+vLbL2fiPXN2CkbtMHMB5IkBXQKjWdbwwJ0GmUuAGh8y4IvhK
	 nDgj138GCWxZK+TMqjgfzq0o9MEEoj48FvHm1avMqpl8PXzgYqnLHEyRiRC6iQNBzeDmk
	 BIwJMhvTvOx8Oq7MBZTAWXWfR/gBGXD8tIjxzhdMgsYBjhZpauVwfIr1VT5VEJesGmpOH
	 A+9I4GTGFg37XmbDZNn6AsZ3QcFuVBogdLdllX2Tm1VvcxXW+Cu7bmYlWx1k4DQpRAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793579721;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8SUppqzDkXZVo2rKPjuLwlQndY7TV/SzNPbAnMITqUc=;
	b=YJsaGLLtAaXM/ORVDw8cuEk6XcZrsne5DwwBID3njcSzfWb3iiQQ3NhM56+OrImDYBxN
	 BQZkCBQ4Ju8PV+QeqlEzOJJIEVn4zsfGGZzcyqefPaDLGp2ZSGV41mxIcIck+GryUJSVP
	 EHr4axcPhzfykcOyReoHH23t9DRfuWihqFMskLyEMerS2PVZ9R2NkWOU76EJnxbWiHIYH
	 mdVYxMA4zyWJ4xOwHYUdf2Pe/oDU+AVxGZEwS7Jh+2wGB2+q5BL4qUxTjeR50AmJMZqYb
	 u6OwGZPPeTKT8pCrgp3xqgGNRukX8BHkXmeSlMVcPD1QizijqzYa7w8rAU2LhFuYsfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ad9Dkymy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85413606A324;
	Mon,  2 Nov 2026 00:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ad9Dkymy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83321F000C1;
	Mon,  2 Nov 2026 00:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793579721;
	bh=8SUppqzDkXZVo2rKPjuLwlQndY7TV/SzNPbAnMITqUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ad9Dkymyif5MYR/q6mfBMKTB0IH93qnCp6j2sIYoAMG8aAuMq6pdvM7VKAXWxvDyU
	 q7c7AZZdSSx4X0cO3Q+gINN+GOrfcIwHrAxOvRxPNI+FxVQmqF1eF/JdhPqFUQJaCL
	 Hmivehk130m/tNeR5CIeZTedqVkpflxAEvoP8EBL8XzyCy4sHdLpfxCgZKh9Ks0OnS
	 cclsTWofbZxB0q/kUimt7L2lbdiK2a2jKi4Q7IZFK0Vi+bbbkIyrbOobwl1CLxWjBz
	 2p7XLe/kfs2aR9t/URqoE0hV1p/AQ8EX+If9JXcJWBXoUMVLx4yvzB1ysfCMW8Za5k
	 TVMvSM1ekedqQ==
Date: Mon, 2 Nov 2026 00:35:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Maximilian Czirr <maxx-cz@web.de>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, stable@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, "Zhang, Lixu" <lixu.zhang@intel.com>
Subject: Re: [PATCH] iio: hid-sensor: Fix scale for magnetic north heading
Message-ID: <20261102003513.2796a9a9@jic23-hlaptop>
In-Reply-To: <20261018203659.4f2b886e@jic23-hlaptop>
References: <20261007000107.16533-1-maxx-cz@web.de>
	<20261018203659.4f2b886e@jic23-hlaptop>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 20:36:59 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed,  7 Oct 2026 02:01:07 +0200
> Maximilian Czirr <maxx-cz@web.de> wrote:
> 
> > hid_sensor_format_scale() applies the HID unit exponent only when
> > the usage and unit match an entry in unit_conversion[].
> > 
> > Rotation-from-north support uses
> > HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH, but that usage has no entry in
> > the conversion table. As a result, the unit exponent is ignored and the
> > heading can be exposed with a scale of 1 instead of the scale specified
> > by the HID descriptor.
> > 
> > Add a unitless conversion entry so the HID unit exponent is applied to
> > the magnetic north heading. A sensor reporting an exponent of -5 then
> > correctly exposes a scale of 0.00001 instead of 1.
> > 
> > Fixes: abea9c62c32f ("iio: hid-sensor-magn-3d: Add support for rotation from north")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Maximilian Czirr <maxx-cz@web.de>  
> 
> +CC the hid-sensors maintainers + Lixu who has been helping a lot
> with this driver recently.
> 
Srinivas, another one for you to check when you have a moment!

No huge rush - I'm just having a scan through what is outstanding
in patchwork to make sure I didn't miss anything.

thanks

Jonathan
> > ---
> >  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > index 9e7c26e37880..26f8554d18a5 100644
> > --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> > @@ -38,6 +38,8 @@ static const struct {
> >  	{HID_USAGE_SENSOR_COMPASS_3D, 0, 0, 1000000},
> >  	{HID_USAGE_SENSOR_COMPASS_3D, HID_USAGE_SENSOR_UNITS_GAUSS, 1, 0},
> >  
> > +	{HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH, 0, 1, 0},
> > +
> >  	{HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 0, 17453293},
> >  	{HID_USAGE_SENSOR_INCLINOMETER_3D,
> >  		HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453293},  
> 
> 

