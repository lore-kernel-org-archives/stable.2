Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.141.101.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111309;
	b=yw9Vpj58VVTT7U+99l9wFZD/IkqztKh+wDZaOsyyHyIiUmhpK6CoGQRgxdwATzyUwDGq
	 b3mLYhS1cP184EVsGD7gAvktTXaJ4vOwGqUtPlhpzdY4nMSz+6VQ3S1PUfhGuDe3H5tnd
	 9FFt519flbqW9rApZesid+U2GK33XZ3rQLhBJ/Px2WNwMGzfvgLnT/ldV3Unpi70Aor6/
	 VqSZYCf+bGt7Ly8SrP3f4iD4JKBOnDfsyBOa7ejc+6GJoEC3iS5oNQ8XVD0E2A81t4W8E
	 n7pzRFogVNwXLe2q5wpbjTUTRV9hcsynqsnsGn01bpsj8j0xuNBAGcqqlklKpqZHPnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111309;
	h=DMARC-Filter:DKIM-Signature:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding;
	bh=DfV5N4zWSrtKq10PfP/SOZJ72/oV9CeuGrUUxT46ju0=;
	b=NZuJoVP3SK28JETXyT1MxNTpSttL8RACri6aJY1GRjCZVbdRTUQrGVD1fu5s0EOhrlpk
	 LEGFJ5rmNYVvRXCD160oA3uDqDgTh+exMZAivvob7s+Y2xifbOgsCJJC/tzP9EU68h8Uv
	 qw7bKUV3s+EVAwMVSzN6KPTu2bPtsLd2sqDzC1b2rR609xaBpjZKAFcOaghNh62ye+BYA
	 rYmX0MZFrvtbhWdfQdaVaq9gqoXrR76Qo6K+/5ujjBDf60wDyyJA1IlZX1DyMzD2WS12H
	 tKN0NGyUTXx6095/HW5ycZiY/eBqNyxSuhjOR32LGxy5j+1eSdIaDk10uzJ/vVQL0uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trvn.ru;
	spf=pass smtp.mailfrom=trvn.ru;
	dkim=pass header.d=trvn.ru header.i=@trvn.ru header.a=rsa-sha256 header.s=mail header.b=BomuMWEu;
	arc=none smtp.remote-ip=45.141.101.25
Received: from box.trvn.ru (box.trvn.ru [45.141.101.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D607606A31B;
	Tue, 27 Oct 2026 14:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D607606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=trvn.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trvn.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=trvn.ru header.i=@trvn.ru header.a=rsa-sha256 header.s=mail header.b=BomuMWEu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
	t=1793111306; bh=zNMftRUuBvruOeVGocwap0mYj/aFJkc298OWpafECXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BomuMWEuYhCHT5QsWoBA6hdSIAHaKsLz0PAYIg/9r+Gnp2TkTJ1rVeBeGcCBbjCNK
	 8wHS8N9bwN4/44CXefPhmFggTpZJgvK9msVXJ9JD9tqx61/jYVedkFJ0pcgGq0Zu3Z
	 OwJwrZJrcoFeO41QQ7nxVMvcirhA/x30l7kY2Pfww4AZaB5mYLSk2Vxyo+8k+md1w0
	 b7fgfiG/WJ/z7/8DZ14h44XAZ2TkfX0Opaxk01XnNEYPR4fpmpLZqI8/n7jTVCTkkr
	 qQsKnQnAiq5nSbVpjs4MvUES6IEVwxaKqheUz1earU6HFP9kkj42gKbIxlzm+3ghs/
	 ++Knk4qyrA9fw==
Received: from authenticated-user (box.trvn.ru [45.141.101.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by box.trvn.ru (Postfix) with ESMTPSA id 086AA22E58;
	Tue, 27 Oct 2026 19:28:26 +0500 (+05)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 27 Oct 2026 19:28:25 +0500
From: Nikita Travkin <nikita@trvn.ru>
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Nikita Travkin <nikitos.tr@gmail.com>,
 linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 18/21] leds: aw2013: Unlock chip mutex before registering
 LEDs
In-Reply-To: <20261021123406.3163547-19-lee@kernel.org>
References: <20261021123406.3163547-1-lee@kernel.org>
 <20261021123406.3163547-19-lee@kernel.org>
Message-ID: <d6e007b237b996ccbbfa634eb7cad9f5@trvn.ru>
X-Sender: nikita@trvn.ru
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Lee Jones писал(а) 21.10.2026 17:32:
> aw2013_probe() holds chip->mutex across aw2013_probe_dt(), which calls
> devm_led_classdev_register_ext().  When a default trigger such as
> "timer" is configured on an LED in the Device Tree, the LED core
> synchronously activates the trigger during registration and invokes
> aw2013_blink_set() on the same thread, which attempts to acquire
> chip->mutex and deadlocks.
> 
> Reset the chip, disable the regulators, and release chip->mutex in
> aw2013_probe() before calling aw2013_probe_dt(), and update
> chip->num_leds before each LED is registered so trigger callbacks can
> enable the chip cleanly during registration.
> 
> Fixes: 59ea3c9faf32 ("leds: add aw2013 driver")
> Closes: https://sashiko.dev/#/bug/linux-5e2c9083-b95b-4aa4-aa0a-b0be8865ff12
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Nikita Travkin <nikita@trvn.ru>

Thanks for making those fixes!
Nikita

> ---
>  drivers/leds/leds-aw2013.c | 54 ++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/leds/leds-aw2013.c b/drivers/leds/leds-aw2013.c
> index dfeac8b2993f..c947cd068963 100644
> --- a/drivers/leds/leds-aw2013.c
> +++ b/drivers/leds/leds-aw2013.c
> @@ -271,8 +271,6 @@ static int aw2013_probe_dt(struct aw2013 *chip)
>  	if (!count || count > AW2013_MAX_LEDS)
>  		return -EINVAL;
>  
> -	regmap_write(chip->regmap, AW2013_RSTR, AW2013_RSTR_RESET);
> -
>  	for_each_available_child_of_node_scoped(np, child) {
>  		struct led_init_data init_data = {};
>  		u32 source;
> @@ -305,19 +303,29 @@ static int aw2013_probe_dt(struct aw2013 *chip)
>  		led->cdev.brightness_set_blocking = aw2013_brightness_set;
>  		led->cdev.blink_set = aw2013_blink_set;
>  
> +		mutex_lock(&chip->mutex);
> +		chip->num_leds = ++i;
> +		if (chip->enabled) {
> +			ret = regmap_update_bits(chip->regmap,
> +						 AW2013_LCFG(led->num),
> +						 AW2013_LCFG_IMAX_MASK,
> +						 led->imax);
> +			if (ret) {
> +				mutex_unlock(&chip->mutex);
> +				return ret;
> +			}
> +		}
> +		mutex_unlock(&chip->mutex);
> +
>  		ret = devm_led_classdev_register_ext(&chip->client->dev,
>  						     &led->cdev, &init_data);
>  		if (ret < 0)
>  			return ret;
> -
> -		i++;
>  	}
>  
>  	if (!count)
>  		return -EINVAL;
>  
> -	chip->num_leds = i;
> -
>  	return 0;
>  }
>  
> @@ -393,25 +401,27 @@ static int aw2013_probe(struct i2c_client *client)
>  		goto error_reg;
>  	}
>  
> +	ret = regmap_write(chip->regmap, AW2013_RSTR, AW2013_RSTR_RESET);
> +	if (ret) {
> +		dev_err(&client->dev, "Failed to reset chip: %d\n", ret);
> +		goto error_reg;
> +	}
> +
> +	ret = regulator_bulk_disable(ARRAY_SIZE(chip->regulators),
> +				     chip->regulators);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"Failed to disable regulators: %d\n", ret);
> +		goto error;
> +	}
> +
> +	mutex_unlock(&chip->mutex);
> +
>  	ret = devm_add_action(&client->dev, aw2013_chip_disable_action, chip);
>  	if (ret)
> -		goto error_reg;
> +		return ret;
>  
> -	ret = aw2013_probe_dt(chip);
> -	if (ret < 0)
> -		goto error_reg;
> -
> -	ret = regulator_bulk_disable(ARRAY_SIZE(chip->regulators),
> -				     chip->regulators);
> -	if (ret) {
> -		dev_err(&client->dev,
> -			"Failed to disable regulators: %d\n", ret);
> -		goto error;
> -	}
> -
> -	mutex_unlock(&chip->mutex);
> -
> -	return 0;
> +	return aw2013_probe_dt(chip);
>  
>  error_reg:
>  	regulator_bulk_disable(ARRAY_SIZE(chip->regulators),
