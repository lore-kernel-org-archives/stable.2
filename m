Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083772;
	b=PnNUA0LGHQwxVD7kPdgeCAFmPawXHNufRm8qoXRaqA1z5hWV/um0MYKEomc5FdFa14m0
	 YIIwchJ0aI5TRw0No97OL4bS3i7iVMVziQjZ3EP94hEmHZlVj2GsHOEB5OlhiiEkqvbzG
	 QafbpE76GxbX2Ymgu/A/Ek6q5m7R5SU61NlIO0LR7e31YqO0fi3zpChDLyKM7L6gR4CZD
	 90VjML3CMGXEhSOoSRtr3+4GNczffuPXU3mFwejRfgjKqP5FyupDE0OEoxYLj8q6LpMeG
	 xa5nMRVpJqurSZWh0nbLnd7oiHqPMdzMZpV4Cemby49HqxVyP7UZTAj8OWF3n2+A1Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083772;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=N/deVLPQFEhJh77MD1UFDSSYM7btoOQqpL3gIwm0SgM=;
	b=BC2Cx0atO07wBDQ8EzdHOpL5nxUfJITLGN2swvvMm1gGjkBhjZBRYZx9DtJEcE3ZNYsK
	 haS6UF4rwI8xu+ywm/ZfNCtZsqUmseiQ3xpzQ4U81BJAERYjSf6iVW3XmcTjgBRiX7+9K
	 AvDnDK/wuGLPDjeh+JTJgR1wkIFKEk81jKO8jDTzU6HRizpL2uz1cQHwGD+jyIR+GE/k3
	 lGKcFAVWCriTyikmyMvuCPDIgM1+bbEljAxBpVhpcg74eUrINcQ8ujrqDfIR+AhF3qsX7
	 /jfTBMbZVYSjn9EKYkucOjW5xQyeiSfnJ/RlusrUFObesN0ib5Ytmgk/OddYsgsWwDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0qpsQf3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55592606A333;
	Thu, 19 Nov 2026 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y0qpsQf3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4A71F000C6;
	Thu, 19 Nov 2026 10:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795083772;
	bh=N/deVLPQFEhJh77MD1UFDSSYM7btoOQqpL3gIwm0SgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y0qpsQf3PbyON2nvrB+3ZwghxvjVh9hpwZiJhx6h8fcbIofAB6ZA2fF7+DhpaJMDP
	 qhCfvR9qsrfRmo0pdXyw18AO86CvACelRlD6kEPCdfa9O5xfFSFCk07dKvGharjXu+
	 VufbpGiQESPHh04AG8tcGzAgLNqYpdf5F6ps1dW2Ma5jEGt45rWY1uf+nKAs/Hs28U
	 M1pWL7T6VCy2VxyZy5r3AYrpohsGG8qrGFkzmPh48Wz1GKDRFeKx5PMShHyK4v+d7g
	 oAKWI12PGHz2iGyW6ht8i1xuh3+z1YeUsZoFGZXkpTUScPFepgA3TutAf5t7bejGd4
	 0XqN/27wPZejw==
Date: Thu, 19 Nov 2026 10:22:46 +0000
From: Lee Jones <lee@kernel.org>
To: joseph@telaak.dev
Cc: Pavel Machek <pavel@kernel.org>,
	Griffin Kroah-Hartman <griffin@kroah.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 02/11] leds: rgb: ktd202x: Fix an out-of-bounds read
 with unused channels
Message-ID: <20261119102246.GO98456@joneslee-macbookpro.roam.internal>
References: <20261109-ktd202x-et6326-v2-0-56e97c226658@telaak.dev>
 <20261109-ktd202x-et6326-v2-2-56e97c226658@telaak.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-ktd202x-et6326-v2-2-56e97c226658@telaak.dev>

On Mon, 09 Nov 2026, Joseph Telaak via B4 Relay wrote:

> From: Joseph Telaak <joseph@telaak.dev>
> 
> The LED array is allocated for the number of child nodes, but
> ktd202x_chip_in_use() walks it up to num_leds, the number of channels of
> the chip. With fewer LEDs in the device tree than channels, for example
> two LEDs on a KTD2026, it reads past the end of the allocation and the
> __counted_by() annotation hides that from the bounds checkers.
> 
> Allocate one entry per channel.
> 
> Fixes: 0ebdb7210943 ("leds: Add ktd202x driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joseph Telaak <joseph@telaak.dev>
> ---
>  drivers/leds/rgb/leds-ktd202x.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
> index 539cf425cdb7..482af28e8370 100644
> --- a/drivers/leds/rgb/leds-ktd202x.c
> +++ b/drivers/leds/rgb/leds-ktd202x.c
> @@ -537,6 +537,7 @@ static int ktd202x_probe(struct i2c_client *client)
>  {
>  	struct device *dev = &client->dev;
>  	struct ktd202x *chip;
> +	unsigned long num_leds;
>  	int count;
>  	int ret;
>  
> @@ -544,10 +545,13 @@ static int ktd202x_probe(struct i2c_client *client)
>  	if (!count || count > KTD202X_MAX_LEDS)
>  		return dev_err_probe(dev, -EINVAL, "Incorrect number of leds (%d)", count);
>  
> -	chip = devm_kzalloc(dev, struct_size(chip, leds, count), GFP_KERNEL);
> +	/* Loops over the LEDs go up to the number of channels, not of child nodes */
> +	num_leds = (unsigned long)i2c_get_match_data(client);

Nit: Too squishy - '\n'

> +	chip = devm_kzalloc(dev, struct_size(chip, leds, num_leds), GFP_KERNEL);
>  	if (!chip)
>  		return -ENOMEM;
>  
> +	chip->num_leds = num_leds;
>  	chip->dev = dev;
>  	i2c_set_clientdata(client, chip);
>  
> @@ -562,8 +566,6 @@ static int ktd202x_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> -	chip->num_leds = (unsigned long)i2c_get_match_data(client);
> -
>  	chip->regulators[0].supply = "vin";
>  	chip->regulators[1].supply = "vio";
>  	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(chip->regulators), chip->regulators);
> 
> -- 
> Git-155)
> 
> 

-- 
Lee Jones
