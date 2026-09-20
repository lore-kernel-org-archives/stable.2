Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6DC47669C;
	Sun, 20 Sep 2026 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944768; cv=none; b=F7bfFzTHSd6L20sqKS3wa3oufxMTrbEFQZCHC2RwFVuz2AETQGZ35pADeiyuOz/o8cKYbuwwfpCHXTzWL3/jCkcVXP9BNjg0j0o4vG5BehZ63Zkxg1+wIq8NLOvbJJip8AXD6WsVr21ejD6CBKfi7blpWIcehi0PownknH+lrY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944768; c=relaxed/simple;
	bh=JL7oHdRycpkm4v5R27PDCRQuE7B3vLqMlbSolGaYTS8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=dpv4euTTLKkDpiUWdzyeh901vOcgazMMlBf42ng2obEEiLUUg9L+xuUjCwHRgmVcn1Q9p9j6HFBbeY6Jk5hXFVd4iqKCy7whQRmBj4Svv6IcZ8IVIh3LInZ9DNi+hn31qcgZUQaEKCJbbNu+B0u+AOULxH7MAGsZ0KKXi/mLQZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HqPN1RY5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HqPN1RY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3471F000FF;
	Sun, 20 Sep 2026 22:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944767;
	bh=xXhmMA21QdzZqb09bhDHerHohiuDmZJzbPzUcaexYW4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=HqPN1RY5xeWyE6D3fAxkZWEnHWZGJcDfQU7+k9VepFNAHMHqnSolObu4zeFjGJbcg
	 i4HHbFYliTK269tIWARdaYygJx7IBn5G344B8LHO0qqKs3M0wMeA6K2UI4mBIYfjno
	 h7+C13j5KdDnlgX2a4GWWYIB0A9Gg+m8pqux4q8P7fGYQHxbPoS7OrTUNDO0DZeHiM
	 f9TiHbCrztt1ycfcZiA9E6p7O/aqnxXocUuKYVeKP6xNuICxp6Dn/M3oDMIcTviuiv
	 HZ4ENcTfoZZKIWHSKA0+OhOkZUtOZdD7yHTxWl3eu4bxKO3hra+8HQ0CXLYe741ImR
	 oO9+aqwiIBNLg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 06/11] iio: dac: mcp47feb02: Avoid unjustified probe
 error on missing label
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 sashiko-bot@kernel.org, stable@vger.kernel.org
In-Reply-To: <20260918-mcp47feb02_refactor-v7-6-82ca794eafe2@microchip.com>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
 <20260918-mcp47feb02_refactor-v7-6-82ca794eafe2@microchip.com>
Date: Sun, 20 Sep 2026 23:52:29 +0100
Message-Id: <178994474989.706584.9748807873575009212.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=JL7oHdRycpkm4v5R27PDCRQuE7B3vLqMlbSolGaYTS8=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqsGOxpcO7EjAFi1c6PSEhHHhR6QumCkU939xFI
 lNiNzqtRtOJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCarBjsREcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiAD1EACzwk+WRb7MbkvG975Xn3ZhplTq4mSK41Xl48nJlmVTzWz
 WbRtHu2i55deCdd6pdc1tUrwZ9SHWfCfAjTPfKjoq+8xsd9yIGAMoC4tTNmyKzWfBU/JKG5tYtl
 Ni98iV+4lh0fwh/yaXLkFozUJSUAROCwOHpSmmB/Qg9eA5i0UmUKJhcSTDxPIz32DXGvV7yicqt
 W0UBayX9u0Hze8wTf7owtlB+dvtC145AqiLPKctAZHxLvzF9HdaNampFE78sBTDuKHul/A5k4IN
 eAqQ5O6jKwPXam8K82Gkc8iaqYyR5hrO+gcGKLYByeUJLw/Vz3WI0kb1T86be2MBZdlNDol541L
 HAmvZMwtaeLW5w8IdozGxYKF/QtmbSEm/8XB6pQufQXHIXMwQrPw/70AhsBU87uBV8oZosI/KXL
 CfJc9sPYe38fBWGQZMDB9UuW+3smuHv8sASAQxS9HHOlTU4i9MAc9p0J5MhVhwRdgsQqoamI1Ne
 zo07CQyU8tGapGzf0v75cwdQnED1AXSMeS0jPb8WDb3kIDUqJeXilWF6h7VxP+Jvxpyy35btxqj
 KJ9sH3qoXFUuHJr1+CLqhbXqsVFkJ2OpT1nNsxcR6Oi7fz+pR79fjYkqMtEZczFWfNxVMSahlRO
 vtGgQeKNPGoDkoUyLnw6HYvtBIq99gvEyKT+Lvw==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Fix unjustified probe error on missing optional 'label' property by
> replacing dev_err_probe() with dev_warn_probe(). Correct %pfw usage by
> passing the child fwnode handle directly in the error message. Besides the
> probe warning a read error is returned at the attempt of reading a null
> label.
> 
> Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/all/20260804134616.1D8A21F00A3E@smtp.kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
>
> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> index 9d4ba95da84a..43cf69e43a41 100644
> --- a/drivers/iio/dac/mcp47feb02.c
> +++ b/drivers/iio/dac/mcp47feb02.c
> @@ -921,7 +921,10 @@ static int mcp47feb02_read_label(struct iio_dev *indio_dev, struct iio_chan_spec
>  {
>  	struct mcp47feb02_data *data = iio_priv(indio_dev);
>  
> -	return sysfs_emit(label, "%s\n", data->labels[ch->address]);
> +	if (data->labels[ch->address])
> +		return sysfs_emit(label, "%s\n", data->labels[ch->address]);
> +
> +	return -ENOENT;
>  }
>  
>  static const struct iio_info mcp47feb02_info = {
> @@ -976,8 +979,7 @@ static int mcp47feb02_parse_fw(struct iio_dev *indio_dev,
>  
>  		ret = fwnode_property_read_string(child, "label", &data->labels[reg]);
>  		if (ret)
> -			return dev_err_probe(dev, ret, "%pfw: invalid label\n",
> -					     fwnode_get_name(child));
> +			dev_warn_probe(dev, ret, "%pfw: invalid label\n", child);

Sashiko says:
[Severity: Medium]
Since the label is an optional property, fwnode_property_read_string()
returning a non-zero value is a valid and expected condition when the
property is omitted. 

Does this unconditional dev_warn_probe() cause unnecessary warning spam in
the kernel boot log for valid configurations that don't specify a label?

-
I think I agree on this.  We should perhaps wrap this in a
property_present check.  If it is simply not there carry on without
a warning print.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
