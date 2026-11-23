Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795474617;
	b=1C4EjOuJGs7i6WJhNtNre1gP3qUrx25AglahMOhmwyrZc+GyAq+F2mfMdSycXKLV3KdH
	 F+jgrwtU5OC8vwIOvactnVIY9NDOp8RJac1CazUbNi9VTFYyN+xod9n1jwaJ5koj2KmbA
	 76hJ1uBbBiUnplsrFnAqLrC1Gc4H22/1Hf3FtNJE59lVi94wHnTnFGq6P7ZnBf6ytZEtd
	 rqU1vrLSdxKyxLESTV5Fdlh6FJ8Gn7fX17EsQ2uAYzyiqINdbXJNwk3FvQyae9Ok0+MqK
	 ngAsBEXXGa8FrT4zjjRFW9YteXoZWwXV+aLZNAv6i49ivmyK0XcPBW0Fq2OttJbWuPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795474617;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ox4lVWTWljMCxphpdX85M6KsxZIbVHHmOCYGYN/v0aA=;
	b=TznEXDX7b8Q6ryBaKaPlSFarTeIIXmh7E9yE/F3j8/kuR8StwPwe19DO1kACR+eN620l
	 fcGERfXtE2M9vr5RP+cNOtVWC8yIrcNxebRJ692mI80EHxF+MfB8QNgWxKz4Q7xy37o/9
	 mkOn8T9hmI64tiDLyGtb7Uylpwz3GgCytYshTMbT8TY5BY++7+GVYHNLHhHq3UFE1XOpJ
	 tR4qT6N3sSPcBTHLvqljKS/gJBk1ia/+LnxqoOBVnbrs/fL3bgVzNTVvPAXl0kNbvwdoO
	 lA6fRch9Q26EFwlShkTz443ZsBeWu0539Ucu7VWts/Z+qOEi6NJZjw3tkIo+BcAywDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hM1Q7imo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F9606A31E;
	Mon, 23 Nov 2026 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hM1Q7imo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9271F000C4;
	Mon, 23 Nov 2026 22:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795474617;
	bh=Ox4lVWTWljMCxphpdX85M6KsxZIbVHHmOCYGYN/v0aA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=hM1Q7imoK8qWdRiM+erSD+rF7W3mh2Dybxh8kHnLLMO6XjkKrYq4HuPnKHypANwb0
	 gAOgM8se4G9ldMsk1AfNTk4TB0b4jRiKYebQ9cY9/0M9sQIR2xphdfeM9Bd4Ks1z+l
	 iPOoMfYlkCyaPvpYngdYJ0uxx0c4EKlp0V9W5oIUw66JecFlNtWVvlt+3WqSspSca6
	 X+yreN+blu1DJnTQCDnd69OWwyvWIKYOt14JLzlo6LsVOuQeWlfhhW9SgKFM5MLom0
	 90NYPiBiYl5XdS1A3fvUf1XkX6pO3EPmKqh8xPJsWiWI4ET4MxdCk5fBNQ8WRVmaxY
	 o9bM/fP6lrhcw==
Message-ID: <8c0a616b-e7a5-4043-bc86-3bee5d0c9e48@kernel.org>
Date: Mon, 23 Nov 2026 22:56:54 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH] nvmem: keep write protection disabled while writers are
 active
To: James Hilliard <james.hilliard1@gmail.com>,
 Srinivas Kandagatla <srini@kernel.org>, Khouloud Touil
 <ktouil@baylibre.com>, Bartosz Golaszewski <brgl@kernel.org>,
 Linus Walleij <linusw@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261117-submit-nvmem-wp-serialization-v1-v1-1-539d121f8f5e@gmail.com>
Content-Language: en-US
In-Reply-To: <20261117-submit-nvmem-wp-serialization-v1-v1-1-539d121f8f5e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/17/26 10:09 PM, James Hilliard wrote:
> The core deasserts the WP GPIO before calling the provider and asserts
> it again on return. Two concurrent writes can both deassert WP before
> the first one finishes. That writer then protects the device while the
> other is still writing or waiting for the provider lock.
> 
> Count active writers per device under a mutex. Only the first writer
> deasserts WP and only the last one restores it, including on provider
> errors. Keep the mutex outside the provider callback so providers that
> forward writes to another NVMEM device can still nest.
> 
> Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/sashiko-outbox-219526@kernel.org/
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/nvmem/core.c      | 35 +++++++++++++++++++++++++++++++++--
>  drivers/nvmem/internals.h |  2 ++
>  2 files changed, 35 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 7d4cce8e2742..c0da902d909b 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -70,6 +70,36 @@ static int __nvmem_reg_read(struct nvmem_device *nvmem, unsigned int offset,
>  	return ops->reg_read(nvmem->priv, offset, val, bytes);
>  }
>  
> +static int nvmem_wp_write_begin(struct nvmem_device *nvmem)
> +{
> +	int ret;
> +
> +	if (!nvmem->wp_gpio)
> +		return 0;
> +
> +	guard(mutex)(&nvmem->wp_lock);
> +	if (!nvmem->wp_writers) {
> +		ret = gpiod_set_value_cansleep(nvmem->wp_gpio, 0);
> +		if (ret)
> +			return ret;
> +	}
> +	nvmem->wp_writers++;
> +
> +	return 0;
> +}
> +
> +static int nvmem_wp_write_end(struct nvmem_device *nvmem)
> +{
> +	if (!nvmem->wp_gpio)
> +		return 0;
> +
> +	guard(mutex)(&nvmem->wp_lock);
> +	if (--nvmem->wp_writers)
> +		return 0;
> +
> +	return gpiod_set_value_cansleep(nvmem->wp_gpio, 1);
> +}

This refcouning belong to more generic framwork, I see few more drivers
doing pretty much the same.
@Bart has this been discussed before?


--srini
> +
>  static int __nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
>  			     void *val, size_t bytes)
>  {
> @@ -84,13 +114,13 @@ static int __nvmem_reg_write(struct nvmem_device *nvmem, unsigned int offset,
>  	if (!ops->reg_write)
>  		return -EOPNOTSUPP;
>  
> -	ret = gpiod_set_value_cansleep(nvmem->wp_gpio, 0);
> +	ret = nvmem_wp_write_begin(nvmem);
>  	if (ret)
>  		return ret;
>  
>  	wr_ok = ops->reg_write(nvmem->priv, offset, val, bytes);
>  
> -	ret = gpiod_set_value_cansleep(nvmem->wp_gpio, 1);
> +	ret = nvmem_wp_write_end(nvmem);
>  	if (ret)
>  		return ret;
>  
> @@ -930,6 +960,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  	nvmem->dev.bus = &nvmem_bus_type;
>  	nvmem->dev.parent = config->dev;
>  	INIT_LIST_HEAD(&nvmem->cells);
> +	mutex_init(&nvmem->wp_lock);
>  
>  	/*
>  	 * Must happen before we assign the release() callback in
> diff --git a/drivers/nvmem/internals.h b/drivers/nvmem/internals.h
> index bc7a99f5aefb..aab2ee4f9329 100644
> --- a/drivers/nvmem/internals.h
> +++ b/drivers/nvmem/internals.h
> @@ -34,6 +34,8 @@ struct nvmem_device {
>  	const struct nvmem_keepout *keepout;
>  	unsigned int		nkeepout;
>  	struct gpio_desc	*wp_gpio;
> +	struct mutex		wp_lock;
> +	unsigned int		wp_writers;
>  	struct nvmem_layout	*layout;
>  	struct nvmem_operations __rcu *ops;
>  	void *priv;
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> base-tree: https://git.kernel.org/pub/scm/linux/kernel/git/srini/nvmem.git for-fixes
> change-id: 20261117-submit-nvmem-wp-serialization-v1-e44b68058814
> 
> Best regards,
> --  
> James Hilliard <james.hilliard1@gmail.com>
> 

