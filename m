Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793244019;
	b=N330xUYEMO4Ezob0MtlZBEfFjgc42ipEwumQgIA3NkY3BFwXYcR82FaKNEmy+pV3LRY0
	 gOFX/YbjPDnJPAhIBWZwOCHoKheWIG6Mylw45a2VYJT/G7ch4usYSDX+hYO9/lZtq7HWa
	 0VxkEzvWdWqjFl9g3gRWW31zQhh9/T88m6kvu+pazSxc4bcvUAVC8i1ZHBcW63weWdDEU
	 hJ3X7ZQ4iw8fhOcAfkKXvNsm5RADDHtFBAQyfzBj+niECRliAUf68kP9RQ7Jhl4pvlCSy
	 wA9YE3IK33gfCO/A+snpDEQpYGV81YXP/d//jgsVWTwdEWMF+aIb4+8wwiMzNmmVySQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793244019;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=rSQkAOKR5bFEK2ZK8iFhsDUkpEktpbQDGx/eUl+yZ6I=;
	b=4euhCJwCToUKI9mdGpeBcDqI6LEDfCnM1JH4ALD6JkJRK5oA5QeveQRE1jo4Et2T9xMh
	 60jqIPYXbcz7Nf9sNr2CeDy0IrJeR+tswYowmXntzX/iLFvEgnV2RawBWp/L4g7sEAgZm
	 9Sk571kt6q6kAXZaLUD0xU7SeH6amkIL7cdNLW5whrYlVtZ53Ij6FZ30/6s/2vuxOan/a
	 jt6J479OO3MqZ0ChvoVpYu7Sf50wBBoWh/fBZjBZtxgltXWimf7qfZcfNR+29iaai0i+/
	 5l2qNY3Wr02WU1Y99Nw6v5Fo2pD05x/5qLgSuTZRptIwOjJBDxqeB5A4imtcRNKkq0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBu2+GfL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6F606A31C;
	Thu, 29 Oct 2026 03:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBu2+GfL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D64C1F01825;
	Thu, 29 Oct 2026 03:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793244018;
	bh=rSQkAOKR5bFEK2ZK8iFhsDUkpEktpbQDGx/eUl+yZ6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QBu2+GfL3gAEa48ZEj7VXYH1/5tQkMkwMWrq9pvs9mwVAULLmFo0dJy1yrlYGAaM5
	 YBg5sHSs23Fu5SFcrSxVncCAEOoSqrLwaf96tCr3umj47TXjlXyYCYza3VpOwQJ7R2
	 Pp3oGwDO2mrw9HXh/1i1yNxh+WhSFjgYqsAZ/F9Zzzl9zVyRugOkgf7ZRTayAqGv53
	 c1dF+Y0E0TjiS2VLjbUZWgip7yKz74/k5jlw2dTWTeQjaoztWU3MDDOEfzX+DgGn2C
	 irMWUqdIBNJAqpE/nEu1F1BGO+/G99tUcd+6oKB2zektoU5yHOdPYarHr/Kai0bV7K
	 ll5FvNrPY0AxA==
Date: Thu, 29 Oct 2026 03:20:15 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
Cc: Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_uart: check ACPI companion
 before use
Message-ID: <auK7bwHt8_qPThml@google.com>
References: <20261028051200.145621-1-yaojiale02@163.com>
 <20261028051200.145621-2-yaojiale02@163.com>
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
In-Reply-To: <20261028051200.145621-2-yaojiale02@163.com>

On Wed, Oct 28, 2026 at 01:11:59PM +0800, Jiale Yao wrote:
> diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
> index d5b37414ff12..779aabd16674 100644
> --- a/drivers/platform/chrome/cros_ec_uart.c
> +++ b/drivers/platform/chrome/cros_ec_uart.c
> @@ -223,9 +223,13 @@ static int cros_ec_uart_resource(struct acpi_resource *ares, void *data)
>  
>  static int cros_ec_uart_acpi_probe(struct cros_ec_uart *ec_uart)
>  {
> -	int ret;
> +	struct acpi_device *adev;
>  	LIST_HEAD(resources);
> -	struct acpi_device *adev = ACPI_COMPANION(&ec_uart->serdev->dev);
> +	int ret;
> +
> +	adev = ACPI_COMPANION(&ec_uart->serdev->dev);
> +	if (!adev)
> +		return -ENODEV;
>  
>  	ret = acpi_dev_get_resources(adev, &resources, cros_ec_uart_resource, ec_uart);
>  	if (ret < 0)

NACK, acpi_dev_get_resources() already checks `adev` and return an error
if it is NULL.
