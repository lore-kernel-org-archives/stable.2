Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E654AAC51
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364287; cv=none; b=lOh0IfjYwC0fbWzRhEoMVypM0RNm4V24OHzwbKTOji1TPAVZ3O5JTZSxVvxAoOWDwjgKmmsAaCPmBF0zj7NcvozWUu3YLx0CULJtdEVrEqNan9kPE96SFK/4RZa6vbALOaKgMkgFWzMXYb7Z+pgLx9IR2Jw8OgP2Kq3Po5OvNMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364287; c=relaxed/simple;
	bh=7S/MKduvHW3eZ0cEHVQzZei57mdgxITKfqv+Mzb0+Os=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=NfFpV0lrvYrDBn/0u64yUrT4LZLrC5JSTNgtzGGnMQ2oeGijva2Cz6Pb+aWI3R+Z73PLYeQRTwUp1bmeoLs2U7Z7j+lGc7emUmEREUVywar+1shjAcXMaF2YnADZvveeQ98XzlI+pAjN9quYgV1GF4bA8hbDrLA4a5xIOvJU/ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKG+lVrw; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKG+lVrw"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-982db8d3b1eso362036241.1
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 12:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790364284; x=1790969084; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7z+aHZZJ9kwGfOKnNeUVi/yULRqMkVDfnGrm/awK8nY=;
        b=JKG+lVrwLdmlikedoA8gbiM81wgJyXjc0pz4aWuQitS9ASmGKngljtPdEq3yEvgLzq
         q+SrLZ3f3afE9DP+25yhYei3Emuq8JLXQLn4CkV3CAO0sfmPKdJzSApTfB+KVaaIskrA
         guE+xzs1K9B0a1FELOZah79veNvkmGAKrBR+3Uyp3ajC9nJBHqo6pOrgLKz5d2EoP0l5
         FtTGwmN4mqa+0KmWqlAsm9Y9U/D0QcZ73CszKIvpKW/olxCfmYukI64RE1lCKE7wT9k8
         BVL0zPRWm8zk4yrPrLdwy6rd+hQl1vlevIjA6HPzpyURSpfmi92hCukqIWcTo6qj6iEL
         bYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790364284; x=1790969084;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7z+aHZZJ9kwGfOKnNeUVi/yULRqMkVDfnGrm/awK8nY=;
        b=HS2Jt8mB8uDApnEZDOlVADBv16aahogRG9vKXEic+QhdMIRPTqkKlXhvF+YoW0sSAN
         lX79/BsRl1qJQEm9LrFgO5EUgBKst6GizTt3IDglRv2ZU4Mj63N/rIKy389gvv/7NLIy
         kVcNqLSDsNVcpdo9aOZ7t7/4PApHhg4Aov3592Z6bXmvF9je8hLQGIQzmp8MaiFQusih
         BBbiLMMpBuVBY8jfxA4HZzJRLdTF78hkORuEG+WhVB10Nte6kn1DM9mIstsOrj2D8t8r
         nIhDxUe+Rv63dr0B77pLrwLpNW1n31Z9RURbbBnnzDUGrYpPSCvU13DzPQ+q3uq1vPb5
         iN/A==
X-Gm-Message-State: AFuF++mTe8SlTlharKNzBXw9O20CldtthaaH+92DeSijvP/VZQIz0+x8
	h3ROPMjYYNUn+lOnx4jhXVvvrUFQ9AIVoCBvJ2/+e1mSeD83ZuljQZ8k
X-Gm-Gg: AYBFou2kfwlTKvHNM0OEYVPZ/HL8wGHIux0zQFbPUWfWe4W6EJwpyJb7+XYqSsjiv9L
	IrlZ1UNttFORe12yT5VecYBV6CIQuZwJ7h18CX/ZreiXoVkjiY/chYHc8aTq62HslrwVbmKz6ox
	RRR1DqLhtxp+o5EaeHnk5gG2gMawbuBr8VV+5LztfO2wXWDDg84v3y9pq0Eo1uxzVmHM2RurAgU
	Fys2+/QYE9DxYgdMqKF9Tgfb4r8r23Rj1xXaTnYhjTqCUZLUkmQwmTOxwxSmCKmuZblItOjimWK
	L+6jfTX3eQT0jk2O35lRano8AL888aSU+891ND7oq4WCyxeaK3efxZdP2FCGTV8ZmSn7TUnnZUx
	RBTnDegkQovr951VdQMMjCTnRpvOtwbvwHtwKudAdhbLfwRT81VzT17OSD3uqIls6BleJdDtH5n
	ItzNA+zBgqQc5Hwhis7dqRp7PQzYTcA4atib1wmDbJOcYwTyAJEAkLClXhGZBJA+KjIoO2Y2kSp
	+2eRX+kCPQVDVANZb0FEciL/7KHJ4PJyh4YxzxR
X-Received: by 2002:a05:6102:8098:b0:7a7:1db6:c769 with SMTP id ada2fe7eead31-7b1c751f1e3mr1094309137.22.1790364283907;
        Fri, 25 Sep 2026 12:24:43 -0700 (PDT)
Received: from localhost (host-190-210-193-94.iplanisp.com.ar. [190.210.193.94])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9861b0b6ce4sm3698675241.13.2026.09.25.12.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 12:24:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 16:24:39 -0300
Message-Id: <DLON63JAAXEO.18FNAXS16CHHB@gmail.com>
Cc: <stable@vger.kernel.org>
Subject: Re: [PATCH 7/9] iio: adc: ti-ads1018: reject devices without match
 data
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jiale Yao" <yaojiale02@163.com>, "Kurt Borja" <kuurtb@gmail.com>,
 "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260925125754.2162337-1-yaojiale02@163.com>
 <20260925125754.2162337-8-yaojiale02@163.com>
In-Reply-To: <20260925125754.2162337-8-yaojiale02@163.com>

On Fri Sep 25, 2026 at 9:57 AM -03, Jiale Yao wrote:
> SPI driver_override allows a device to bind to this driver without
> matching either the OF or SPI device ID table. In that case,
> spi_get_device_match_data() returns NULL.
>
> ads1018_spi_probe() immediately dereferences the returned chip
> information to initialize the IIO device, causing a NULL pointer
> dereference.
>
> Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
> data") fixed the same driver_override issue in another SPI driver.
> Reject devices without match data before allocating the IIO device.
>
> Fixes: bf0bba486b5b ("iio: adc: Add ti-ads1018 driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Reviewed-by: Kurt Borja <kuurtb@gmail.com>

> ---
>  drivers/iio/adc/ti-ads1018.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
> index d9ec4a8d7ce5..8f2d03eee77b 100644
> --- a/drivers/iio/adc/ti-ads1018.c
> +++ b/drivers/iio/adc/ti-ads1018.c
> @@ -624,12 +624,16 @@ static int ads1018_trigger_setup(struct iio_dev *in=
dio_dev)
> =20
>  static int ads1018_spi_probe(struct spi_device *spi)
>  {
> -	const struct ads1018_chip_info *info =3D spi_get_device_match_data(spi)=
;
> +	const struct ads1018_chip_info *info;
>  	struct device *dev =3D &spi->dev;
>  	struct iio_dev *indio_dev;
>  	struct ads1018 *ads1018;
>  	int ret;
> =20
> +	info =3D spi_get_device_match_data(spi);
> +	if (!info)
> +		return -ENODATA;
> +
>  	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*ads1018));
>  	if (!indio_dev)
>  		return -ENOMEM;

--=20
Thanks,
 ~ Kurt
