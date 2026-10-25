Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792966135;
	b=eq7P6MM2yEgC+BUKgLVciVknndowOamhinuEhDjEtSjeodjsuhDDW/6YMRsvJHvhyrXR
	 zyx6Okdozkh+KE8AE7rJBRcm9+NDqriTZvh7dltdEIrG9W2xiYF+MJWMeZntjM7QSpgw+
	 CTavwYzc2K5+8+/ag0qk4HgO8s3hlyShedyRY23dH6kdGsjf+Sz9zDTk7bl93EdLPufqg
	 4nmx+W+AwXiWI+WUXOxdLZWPxvIrYmLxF18hOEnpgV8pjHVEFBKZ0sZsYymeuG8vjPU+Z
	 udOeboTFaRM2jZVlS6VMTi+bmSgK2VJgiRs1a6E17trQvAiHO4cCcJ9DPCZQLAeZGqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792966135;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BS1wy6y71AT4G6D0FqXZfBfAhN/LIpTG4QlMWSRqW1Q=;
	b=DDnX1VsWBhN9/+pVHMu60qOIDS8zE8bfA6KMjjbQMBOlHh8dgXGCwwN1Z+J6w5bV3nlq
	 Rs4+xYfMZZpDd2pVj6NYhItBKA1MYdfuhI7lZrNmElFjI5XyAU6v6FuRG6lVM7ulYyBeh
	 ivvq3I/ovwGS8lLUTyDAbaEif9QCWwB3heNYxV8pqCRKVqc7GGBlJ5tbXpd5m3ItkwNKg
	 ELi884cJb1M86xv8azKbcoHjxNG6AnwGtiYHUShBhwAGpVdcbUo0k0riGtkVn+6LmBS2C
	 yT9KcqnNt7SsG+7Sy0vaJmbCyoxIbHttMYZ/oq/CwTdQqNpuEahvy0wmET0nV351vQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxUQWmpp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF2A606A31A;
	Sun, 25 Oct 2026 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxUQWmpp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449F01F01825;
	Sun, 25 Oct 2026 22:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792966135;
	bh=BS1wy6y71AT4G6D0FqXZfBfAhN/LIpTG4QlMWSRqW1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QxUQWmpp/B+bARYpJDb0keBYbYwyOI5ak6inCGWofikHWUYxo5ubPE17je5I+pnDy
	 sqyw+buogUlxr/eHW7syvp5BZJDHXVumPsChiMlzWQutww1qnFCvA/wx2+j15iqQJg
	 pqvQu55MR99gLsTkc9XeMYYXjzMecwSMBLeW/YRaSz3eOn64D/tOxUyfOBdGWcKoEP
	 bsUlpqPHexUSbUO6UVgZtU7c/YlrjEse2gNmzCbG48Jd66z8pTEbzznHgOQk/B5w1x
	 ZRprhYEwTg9Yfgar+hDFJ5Z0/L9A/VcPyaFb0f5upkX+F+LidAiVKEtps2xEQwScPZ
	 QVeyNxHG4U9Bw==
Date: Sun, 25 Oct 2026 22:08:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: cm32181: validate ACPI object type in
 cm32181_acpi_get_cpm()
Message-ID: <20261025220847.0fa74000@jic23-hlaptop>
In-Reply-To: <20261025180323.3641477-1-tristan@talencesecurity.com>
References: <20261025180323.3641477-1-tristan@talencesecurity.com>
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

On Sun, 25 Oct 2026 18:03:22 +0000
Tristan Madani <tristmd@gmail.com> wrote:

> cm32181_acpi_get_cpm() accesses cpm->package.count and
> cpm->package.elements without checking that the returned ACPI object
> is of type ACPI_TYPE_PACKAGE.  If firmware returns a different type,
> the package union members alias onto unrelated data.
> 
> Add the missing type check after the ACPI evaluation and before
> accessing the package contents.
> 
> Fixes: d34ca613b939 ("iio: light: cm32181: Add support for parsing CPM0 and CPM1 ACPI tables")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Can we use acpi_evaluate_object_typed() so that we failure the
earlier call?

Whilst we are here can we also swap the kfree() for ACPI_FREE().

Jonathan


> ---
>  drivers/iio/light/cm32181.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
> index b32a94028f091..1528465be6adb 100644
> --- a/drivers/iio/light/cm32181.c
> +++ b/drivers/iio/light/cm32181.c
> @@ -121,6 +121,11 @@ static int cm32181_acpi_get_cpm(struct device *dev, char *obj_name,
>  	}
>  
>  	cpm = buffer.pointer;
> +	if (cpm->type != ACPI_TYPE_PACKAGE) {
> +		dev_err(dev, "object %s is not a package\n", obj_name);
> +		kfree(buffer.pointer);
> +		return -EINVAL;
> +	}
>  	if (cpm->package.count > count)
>  		dev_warn(dev, "%s table contains %u values, only using first %d values\n",
>  			 obj_name, cpm->package.count, count);

