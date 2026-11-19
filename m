Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795084682;
	b=BQTXPALjHiuyOrP1tKHqSGG+COAFOUggi+234hSms2UBu56/iXmLoG1Kt58kPSDXIC1R
	 JIsXWqO9WId9mKwt+b95ioaZ9thBK0Y1yaXuzkj9ilD4ozUowTZatjFnr/9bBDd/IB1W7
	 by+qje+P3os0DSHjEgMmPtIq25eZ1IU1w4GMlaOGgFRg4yMsPnN/V+tRu50VX0xL2Jxdf
	 qxOgo9Xqm6RDeJgGWg7HvwAD92CthXrgIdDQB2wj1kSNpnWeYWmubATksPZBI+Ms0YnAz
	 ONSepK4ZwerXuC0hmugiWx6vD291mAejSvUbhdtjAFNhd4yQXrCEXLwgUVR8CCJv/ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084682;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MIajatYlF3EIxVeTZSsEVZ7p5I2aamJkZ0k2TSCz95o=;
	b=rORdaiDn10EosQexuUdJuhaWtQp060Hinh1kPKgpi6rwtSrNA+wfQ+elhlFscigtONWZ
	 q9CAA7ngNihbxqJTw3ujVLmqRMHamt+Dz+GWCIpvPejsyQja7q0MpoiwJWU8Do4gS02M7
	 oz4x0JJUl7HByDXN8iJk3uHYRkUUxiFcy0dMZTFLxVR91HrxnDdTox4krd+LpewYOsY7A
	 pNj6sfKDzHf97aE774vQY5wYGy00ZqWkuQ6gyp8r/OocUN5diBs1Qaxr3fgEfRVMMLYaX
	 UsnaN1u2QQDTqIaM19Kc9lt9CJzMDfmvVTlrFEthIQnVZcXR7wfZ79d+F9r7KOZUPdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HB/N8k3T";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99D9606A320;
	Thu, 19 Nov 2026 10:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HB/N8k3T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400D51F000C4;
	Thu, 19 Nov 2026 10:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795084681;
	bh=MIajatYlF3EIxVeTZSsEVZ7p5I2aamJkZ0k2TSCz95o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HB/N8k3TYSulYNMYpIbRhITmR8lZQfd4EIMz3JCkLqbJQ0kSoHs82/wZ4DqT9nMGw
	 RJTDYoNzWb/T8/Urz5tv62Hz1QbGw6gFdPi6cXd5OUjIluokUGapMjSp1zQdMVEgQ3
	 YDEulN6F30hYxsbQ1JFf94fElERuu87OB2sy8cN46G4aDcUrMsLc+KcHXRFJM6f2zd
	 MAfSlP5LOTGY+6MgKO7Zts8KzeeTApeR1EJ0otA85TbtUxmy7n6h8lQlm1Sqxqs13b
	 m6oXFSQSExIe8tqvy2AUkmmTjktvhwuG/f7fy70u4DfKo8ZKi6gwc8asF8AxgLnxlB
	 WplMaulHqBIoQ==
Date: Thu, 19 Nov 2026 10:37:55 +0000
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
Subject: Re: [PATCH v2 05/11] leds: rgb: ktd202x: Keep the unlit colors of a
 blinking LED off
Message-ID: <20261119103755.GP98456@joneslee-macbookpro.roam.internal>
References: <20261109-ktd202x-et6326-v2-0-56e97c226658@telaak.dev>
 <20261109-ktd202x-et6326-v2-5-56e97c226658@telaak.dev>
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
In-Reply-To: <20261109-ktd202x-et6326-v2-5-56e97c226658@telaak.dev>

On Mon, 09 Nov 2026, Joseph Telaak via B4 Relay wrote:

> From: Joseph Telaak <joseph@telaak.dev>
> 
> blink_set() switches every channel of a multicolor LED to the flash
> timer, or to always on when delay_off is 0, including the colors whose
> brightness is 0. Their current register still holds the last brightness
> they had, or the 10 mA default, so for example a red blink set with a
> multi_intensity of "255 0 0" also blinks green and blue.
> 
> Leave the channels of the colors with no brightness off, as
> brightness_set() does. A single color LED now passes its brightness too.
> 
> Fixes: 0ebdb7210943 ("leds: Add ktd202x driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joseph Telaak <joseph@telaak.dev>
> ---
>  drivers/leds/rgb/leds-ktd202x.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/leds/rgb/leds-ktd202x.c b/drivers/leds/rgb/leds-ktd202x.c
> index feea33b7e885..042de16c28bc 100644
> --- a/drivers/leds/rgb/leds-ktd202x.c
> +++ b/drivers/leds/rgb/leds-ktd202x.c
> @@ -284,6 +284,10 @@ static int ktd202x_blink_set(struct ktd202x_led *led, unsigned long *delay_on,
>  		int channel = subleds[i].channel;
>  
>  		ctrl_mask |= KTD202X_CHANNEL_CTRL_MASK(channel);

I won't say this again, but it should carry across to everywhere else.

'\n'

> +		/* A color with no brightness stays off */
> +		if (!subleds[i].brightness)
> +			continue;
> +
>  		ctrl_on |= KTD202X_CHANNEL_CTRL_ON(channel);
>  		ctrl_pwm1 |= KTD202X_CHANNEL_CTRL_PWM1(channel);
>  	}
> @@ -359,6 +363,7 @@ static int ktd202x_blink_single_set(struct led_classdev *cdev,
>  	if (!*delay_on)
>  		return ktd202x_brightness_single_set(cdev, LED_OFF);
>  
> +	info.brightness = cdev->brightness;
>  	info.channel = led->index;
>  
>  	return ktd202x_blink_set(led, delay_on, delay_off, &info, 1);
> 
> -- 
> Git-155)
> 
> 
> 

-- 
Lee Jones
