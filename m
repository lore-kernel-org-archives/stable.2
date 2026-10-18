Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C6F44C65C;
	Sun, 18 Oct 2026 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352225; cv=none; b=F5pWDuPhQblk+Y6tQDajDBJQ/59SJ3cdz0Ok4V9IZTn/xZYpNM32QPCMLT5vUWc17URssKdmOBsR/TACs5/wG1EjQ2ise/unm+Kcp9NYqZIxXaT0j+GlXyjJHVU0LOtkypBv1n+Xa3eAnaKhl4Zmr0t65x+Ov53WgbmN6ww1hjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352225; c=relaxed/simple;
	bh=+lkzv1nIujjADe9M+ODI2JBHaDE42pNs/R0S/HkrsAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zt36opjU5nM/g2Q7BNEKqWuM1fpnh63n6kjVXFl048My/sQRaDwqpMYEBUWgQE6vHtTLzyBI6EVgZ9ZgSFKP8OAJomL0M+Bhq+98oMBb25MFdcDWrCI/leccY6ek8F/ae2snDDKQcLkzUNgo1Rn0ipMP/chII2JTZEuw6xIL+tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3Qg1nKy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3Qg1nKy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197E81F000C4;
	Sun, 18 Oct 2026 19:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792352223;
	bh=uXgeWb/bXquyutYkQI36XTSM3XnvuepdGbMmycLYci4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=D3Qg1nKyMiKQelakRnt3CcacLAYOumSf45oxZ66xGEkrt2bl92zrWkLsqfhuq6GjY
	 t+bVazW9YRc1+2qdgGTFlko7imL7A/UlFKuFXEFNQoEZlGwT3Lf3v+yTVre6Hh9l7j
	 df/KW8VFuyKXVRQSi9bvlFVaBtUHy9lYLHgCcUQ1YhH1Ac6MouULlfBGsYJxE18mNf
	 /mKcWcPJkYbgbhmFpO+ChxvOkOsqEuKK7cojnd91hPiN/dGpek50CIu4JWKKWgXMqj
	 OXBlNIf/1oOlp4ZRelxJt+jqzSBxV5IckreG6R6peurnN6QAUkLukLXphS2WVOdnNl
	 fPsq8z2aXfnag==
Date: Sun, 18 Oct 2026 20:36:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maximilian Czirr <maxx-cz@web.de>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, stable@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, "Zhang, Lixu" <lixu.zhang@intel.com>
Subject: Re: [PATCH] iio: hid-sensor: Fix scale for magnetic north heading
Message-ID: <20261018203659.4f2b886e@jic23-hlaptop>
In-Reply-To: <20261007000107.16533-1-maxx-cz@web.de>
References: <20261007000107.16533-1-maxx-cz@web.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Oct 2026 02:01:07 +0200
Maximilian Czirr <maxx-cz@web.de> wrote:

> hid_sensor_format_scale() applies the HID unit exponent only when
> the usage and unit match an entry in unit_conversion[].
> 
> Rotation-from-north support uses
> HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH, but that usage has no entry in
> the conversion table. As a result, the unit exponent is ignored and the
> heading can be exposed with a scale of 1 instead of the scale specified
> by the HID descriptor.
> 
> Add a unitless conversion entry so the HID unit exponent is applied to
> the magnetic north heading. A sensor reporting an exponent of -5 then
> correctly exposes a scale of 0.00001 instead of 1.
> 
> Fixes: abea9c62c32f ("iio: hid-sensor-magn-3d: Add support for rotation from north")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maximilian Czirr <maxx-cz@web.de>

+CC the hid-sensors maintainers + Lixu who has been helping a lot
with this driver recently.

> ---
>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index 9e7c26e37880..26f8554d18a5 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -38,6 +38,8 @@ static const struct {
>  	{HID_USAGE_SENSOR_COMPASS_3D, 0, 0, 1000000},
>  	{HID_USAGE_SENSOR_COMPASS_3D, HID_USAGE_SENSOR_UNITS_GAUSS, 1, 0},
>  
> +	{HID_USAGE_SENSOR_ORIENT_COMP_MAGN_NORTH, 0, 1, 0},
> +
>  	{HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 0, 17453293},
>  	{HID_USAGE_SENSOR_INCLINOMETER_3D,
>  		HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453293},

