Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793063390;
	b=PKnVj24gfpdbKeCfllJ0s86W9q76LwrvsImZVWuU1En+q2WN4abBk2gXVtVfbfNpmUls
	 0qmexvEtqGHLWEK/2eoZLox7RMUJdaNT+WWas1DXVm2Kr1V6UGdLkFPahPdT9+DvjjY2B
	 +AhW+iEGeYYiAQRM+m+H4uAfuhdmcZ2xJyXF7KVWCucVHf07dq5tmQG8UlG0i56TgIXJ2
	 N0PeJB1rtSR90n/V6xyHSy02SJez4o6eqKNR3yzq9pkD0Msl+3rg7X5U27IaeALnIH6vS
	 DbPcINGB1zw58T7sMfBLgn1RNK1gt5TkZVvG9/ldBZtvb5Hf/cyDvz7rtubjdmWvwFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793063390;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=xvbMHvz44q6egU6UHmyrVq7TTu1E+YqD75Q/63ez7/E=;
	b=QwMFUgi+vx4G4JfIE0FsKmGIccMoFAwXjMDUJMakkfSHkTguww/fFYmEAtGw3fKvd+U6
	 SnvFCWYGPeIwP1fi5B8homEUmuHS98v6MrKUuSPqyUvwFiNN2DeXDuO3TZwyDrHyJqoaS
	 +uZ19SjnfLXdiI7wfBTPwrg6RTSkOdwemtKJsHDdEX9Ov9bBwWvaCG6/axmWvNF+Oqr3j
	 kw1vIRqwWswW3075Fhsc0OTMwiEPxt8C0o/5jlv8rQigJsclKHC0IJTlK/d/7EW7J1TkC
	 HYYzN/qutQbB7oOELiIWw9uWttK7Bpo490SJIP0OoyRWUDG1IyHzWn1rKkjLO2qz6fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lo0Ng5hz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE52F606A31A;
	Tue, 27 Oct 2026 01:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lo0Ng5hz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D781F01825;
	Tue, 27 Oct 2026 01:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793063389;
	bh=xvbMHvz44q6egU6UHmyrVq7TTu1E+YqD75Q/63ez7/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Lo0Ng5hz8D5+SDQAjVUXEG5RLC5UI/0jmIzSkgDXLA5n5GAHaW8Oh1aTN4hjv+4Kk
	 rkwRMMVR3PMQ/DWSQeqfhIkm5ZquVb1v1P4e7SoVZ0uXBU/byB1X9Kt2C74RtAeE95
	 qWssxbEj4By1bw4wQhiU8+RyzNFZFlx78nfKZLMYaKe5X5+aKXmBfGLAfVXjvSJ467
	 V4+i3BPf7oL6NoXervU+TGZvFJj+GgdcitMPhHXPDJI4qF+HGihS3yfYBf9FTDVigf
	 P0ouiL73T13nx31OGf6HGJVf5eGK5H/Yf8zxbQanMAMIa1wZ+Y8BOMVmfy1mOyGIub
	 M0vzk6bc7TRxQ==
Date: Tue, 27 Oct 2026 01:09:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Marius Cristea <marius.cristea@microchip.com>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, tristan@talencesecurity.com
Subject: Re: [PATCH] iio: adc: pac1934: validate ACPI _DSM return type and
 bounds
Message-ID: <20261027010940.50bd884a@jic23-hlaptop>
In-Reply-To: <20261026230910.2569782-1-tristan@talencesecurity.com>
References: <20261026230910.2569782-1-tristan@talencesecurity.com>
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

On Mon, 26 Oct 2026 23:09:10 +0000
Tristan Madani <tristmd@gmail.com> wrote:

> pac1934_acpi_parse_channel_config() calls acpi_evaluate_dsm() four
> times to read channel configuration but does not validate the returned
> object type or array bounds:
> 
>   1. No check that the returned object is ACPI_TYPE_PACKAGE.  If
>      firmware returns a different type, accessing rez->package.count
>      and rez->package.elements on a non-package object produces
>      unpredictable values.
> 
>   2. The loop bounds use rez->package.count directly without capping
>      to PAC1934_MAX_NUM_CHANNELS (4).  A package with more elements
>      than expected causes writes past the fixed-size labels[],
>      shunts[], and active_channels[] arrays.
> 
>   3. The bipolar and sample rate DSM calls access elements[0] without
>      verifying package.count >= 1.
> 
> Add ACPI_TYPE_PACKAGE validation after each acpi_evaluate_dsm() call,
> cap loop iterations to PAC1934_MAX_NUM_CHANNELS, and verify package
> count >= 1 before accessing elements[0].
> 
> Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
I should have mentioned this for earlier patches.  This is
to my eyes not a fix, it is hardening against buggy firmware.

Now I'm fine with doing such hardening but we don't want to
suggest it is something folk should definitely backport.

> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/iio/adc/pac1934.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> index de59dc27c4405..43c4705c27be7 100644
> --- a/drivers/iio/adc/pac1934.c
> +++ b/drivers/iio/adc/pac1934.c
> @@ -1101,8 +1101,13 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
>  	rez = acpi_evaluate_dsm(handle, &guid, 0, PAC1934_ACPI_GET_NAMES_AND_MOHMS_VALS, NULL);
>  	if (!rez)
>  		return -EINVAL;
> +	if (rez->type != ACPI_TYPE_PACKAGE) {
> +		ACPI_FREE(rez);
> +		return -EINVAL;
> +	}
>  
> -	for (i = 0; i < rez->package.count; i += 2) {
> +	for (i = 0; i + 1 < rez->package.count &&
> +	     i / 2 < PAC1934_MAX_NUM_CHANNELS; i += 2) {
>  		idx = i / 2;
>  		info->labels[idx] =
>  			devm_kmemdup(dev, rez->package.elements[i].string.pointer,
> @@ -1130,7 +1135,13 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
>  		return 0;
>  	}
>  
> -	for (i = 0; i < rez->package.count; i++) {
> +	if (rez->type != ACPI_TYPE_PACKAGE) {
> +		ACPI_FREE(rez);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < rez->package.count &&
> +	     i < PAC1934_MAX_NUM_CHANNELS; i++) {
>  		idx = i;
>  		info->shunts[idx] = rez->package.elements[i].integer.value;
>  		info->active_channels[idx] = (info->shunts[idx] != 0);
> @@ -1141,6 +1152,10 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
>  	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_BIPOLAR_SETTINGS, NULL);
>  	if (!rez)
>  		return -EINVAL;
> +	if (rez->type != ACPI_TYPE_PACKAGE || rez->package.count < 1) {
> +		ACPI_FREE(rez);
> +		return -EINVAL;
> +	}
>  
>  	bi_dir_mask = rez->package.elements[0].integer.value;
>  	info->bi_dir[0] = ((bi_dir_mask & (1 << 3)) | (bi_dir_mask & (1 << 7))) != 0;
> @@ -1153,6 +1168,10 @@ static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
>  	rez = acpi_evaluate_dsm(handle, &guid, 1, PAC1934_ACPI_GET_SAMP, NULL);
>  	if (!rez)
>  		return -EINVAL;
> +	if (rez->type != ACPI_TYPE_PACKAGE || rez->package.count < 1) {
> +		ACPI_FREE(rez);
> +		return -EINVAL;
> +	}
>  
>  	info->sample_rate_value = rez->package.elements[0].integer.value;
>  

