Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095020;
	b=qkMRcB3KhmSLhIk4sPv+aXcDfunFsW7nA3+u4avRQVRQkf+grx2eWUqYxCFRwwhYUOyQ
	 P4VAC8L7OhNdoi6EZzculM4L0hXk57uQy+OIfWIjLl1aRqV6Qvxmfb+QxvOqdA9LLdyqo
	 6Y1edkICSP/G9gfGYf+NcsMTIpn8JBVb3XUAkSVA2seeKILj4A7bIsNx8jcNJ7HLOePY/
	 Rosbp0E46lr8P2Zkwu29YXL+w/sEXAoiUcGvu6ftGCnFkuORJ2psPhocV0FtnHNjObPGc
	 WVyV5fAXK0SdgM0WiO/QmRS/HjhLm2yLAGxm7NOFNTvXXahCqIroQkdFcrVse3eRVsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095020;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1EYEvcD7siuOpXvwY3Vf+JekvZisCcVk18ZnieT9Z+s=;
	b=qGy+PqJXyi76j/diZ4wQLnheZlEoo0D4hCRYbnNGoaDsUMlInc6WWBIYmSrK0/7akuk0
	 dHI8D2M1xeqQm631dmL+VLKUxhzg6tp5xueQBjIAYkjI7KE97SyiXuttTHJPF9mepT+75
	 sF9BZt6mD1sALgjXl9akSP1T81W/bi3R0j+BtEEd3bnoY2kdE6Xf8Ei9HcNPZ7aMmJbg+
	 ZuLS2hZplpvXWD4zbn4W8mOXxJFFkDafre+BZr4RLZ/TD7xVUiL36xqJLSawjQJOOeY8G
	 PRoBzjRit08x+Ix8ZtxfYwuW0ZdpkOAeTZsYjVXXQseiRJihuXiilRygHEAdeaFXdAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zt+d127U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2A9BD606A324;
	Thu, 19 Nov 2026 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zt+d127U
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 891DF1F000C6;
	Thu, 19 Nov 2026 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795095019;
	bh=1EYEvcD7siuOpXvwY3Vf+JekvZisCcVk18ZnieT9Z+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zt+d127UIL3Qg/8heu+JJZBZ/UiI98B0QpqkL/6LVP2N5D+D3/JFhX6yJgys2I2Kr
	 BD6CzPELRUlVKs9TiV+BgaBK87vsQYeZ/9yycDz8Dkqc8BrKGzmE4TAMJI890jjHw2
	 h+dYG9QPXcFcK2S35y0KH4zCL/ToVIifI91xdGgz3+fVxeFq20LBpsJTYtkQyAdnqS
	 kGqetxtcZ29IjRnG+N/muFfLVU7QjhIcphYQxuK/l9e69XlDkAgLoWYQ7DxNsT5/2o
	 uDjdOYmfjRrN4UN/+0sAd+A3WREYD9FHi9kLH9aeUGJD1g5+wD+JhRLPB4prVqzzAE
	 MPnTyBPCm61+Q==
Date: Thu, 19 Nov 2026 14:30:15 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] gpio: aspeed: Fix potential coprocessor bank map leak
Message-ID: <fvehiq2zts6jevimc2fmzttgh2h3v7s4hjzsasfx64cnhqy37p@qqejcrujd3q5>
References: <20261118-324f82bd41-gpio-aspeed-0@mail.sdu.edu.cn>
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
In-Reply-To: <20261118-324f82bd41-gpio-aspeed-0@mail.sdu.edu.cn>

On Wed, Nov 18, 2026 at 10:21:19PM +0800, Guangshuo Li wrote:
> The coprocessor bank map is allocated lazily but is never freed when
> the GPIO controller is removed. Its only owner is the device-managed
> GPIO private data.
> 
> Register a cleanup action before adding the GPIO chip, so removal frees
> the map after removing the chip and before freeing its owner.
> 
> This issue was found by our static analysis tool under development.
> 
> Fixes: a7ca13826e47 ("gpio: aspeed: Add interfaces for co-processor to grab GPIOs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
> ---
>  drivers/gpio/gpio-aspeed.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index dc53b2decb66..bb30bbf8c60b 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -1300,6 +1300,13 @@ static const struct of_device_id aspeed_gpio_of_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
>  
> +static void aspeed_gpio_free_copro_bankmap(void *data)
> +{
> +	struct aspeed_gpio *gpio = data;
> +
> +	kfree(gpio->cf_copro_bankmap);
> +}
> +
>  static int aspeed_gpio_probe(struct platform_device *pdev)
>  {
>  	struct gpio_irq_chip *girq;
> @@ -1364,6 +1371,10 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
>  				gpio->config->llops->reg_bank_get(gpio, (i << 5), reg_rdata);
>  	}
>  
> +	rc = devm_add_action_or_reset(&pdev->dev, aspeed_gpio_free_copro_bankmap, gpio);
> +	if (rc)
> +		return rc;
> +

You have the address of the device that binds to the driver in struct
aspeed_gpio, why don't you just use devm_kzalloc_obj()?

Bart
