Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583319;
	b=Ib9pAvOb1cW3xMLcg47QM7Gq8je84YhEkmKO0/AhbdbRQwIv436pTXAHvTFzjqZqhPGP
	 BORCSJZY7zERh3mKjYKzwyq6Xm0NwRMJotFn7+BqH56LSf4Jdn0SOu1WjCfLTmD2qYMI3
	 yZa2cDZnPteAM/OX2hUCBiCedAeywFU6Vffg4l82DCYg4/Nb2XshdOZaM/dBiCW5Vez5w
	 4/J2iALUBj3MLyfCsRMCItlyEJdZr76dwnqkaqPQONub8A7GtD+VkMm7yQO8BJi9ZgdYa
	 lu0ZUSbUhh+TE7jWYRjLVnYNJXBbxHR3gCGvRiJStEnfdCOc1K6mwbRujjZ4wi+02qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583319;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=P+P5ZMQTBAwifUc4og7voZXXPSPAoXdrR3ly/exkImc=;
	b=1M+HlccLKEk2Ok5hJ1KRxVgsLCdP9DCj8kFhDXZLzMfgu6LQL0JKeQEu2Ud/xsapWLhz
	 OyBWFXZxFVDA6RMWbiQxSQzrfFOYImw3ttuOlmvi+MexSADBjfcEHA6Em3VI1igcTvCgE
	 /elXgpNYb+OKxq5L+/fctaVx29noRPMGaBFB5rXy366ec39GOaTnNx1z1+Iac6/P2vzim
	 7S6RSjd3WYyxfth1iE6Wcc16Cq+YQmbbv2SeyLEb225lIN7U2ZIp9lXkZHnrdrIH75R3+
	 53rZDBoRwQJmp8rbNw8eaiRkGJMtvclyTHp+pHn3NY2zI/QTwQM9YZbE4+9VDqiwEKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIAXE+9t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E24606A328;
	Wed, 21 Oct 2026 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIAXE+9t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D641F000C4;
	Wed, 21 Oct 2026 11:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583319;
	bh=P+P5ZMQTBAwifUc4og7voZXXPSPAoXdrR3ly/exkImc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UIAXE+9twiE2YHeUN7Y9SD9H2FrwBPp0T+KEKufY7AGbTtLYv0cxySK0uYXAj57GO
	 msSiSqwWKhvotgBfsZZoQjmD6r2bPxl0XbHoMSRl2KgtRbqqpZlF0SOh4QyDusDxbx
	 OnxtNB983yISKBOeZ3EdQTbo/ofK9sqijAbC/S0n8sVuM5wiQBQS8ZHI5uRBpmg20M
	 AekqusowJ0X3TLrQI3dQn6nZ/SkCQNViPQ1Uzy7RC0o7rxVkswn2HSGEMq/HUdRiN0
	 IAme8nSXbSqXyXBuCLzYIm4IdtQA0Oc8gME2vigxscYgX+FRkZotMV3zQLcLCGL3eJ
	 Jh4zjjvB+OJLw==
Message-ID: <4ef66cfe-9ff8-4d26-87de-48485e9d4fa3@kernel.org>
Date: Wed, 21 Oct 2026 13:48:35 +0200
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
Subject: Re: [PATCH v6] can: dev: can_fill_info(): don't wake up controller if
 interface is down
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, mkl@pengutronix.de,
 kernel@pengutronix.de, haibo.chen@oss.nxp.com, shawnguo@kernel.org,
 imx@lists.linux.dev, stable@vger.kernel.org, netdev-bot+sinfo@kernel.org
References: <20261021023334.11803-1-chunyuzhiqiang@yinhe.ht>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20261021023334.11803-1-chunyuzhiqiang@yinhe.ht>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/10/2026 at 04:33, ChunYuZhiQiang wrote:
> If the interface is down, the CAN controller might be powered down, the
> clock disabled, and/or its external reset asserted.
> 
> Don't call do_get_berr_counter() or do_get_auto_tdcv() to read the CAN
> controller if the interface is down. This fixes a generic logic problem
> that exists on all platforms.
> 
> As a result, IFLA_CAN_BERR_COUNTER is no longer reported for down
> interfaces, and the automatic TDCV readback is skipped. The other TDC
> parameters are still reported, as they are meaningful while the
> interface is down. This is intentional: the counters and the automatic
> TDCV are not meaningful in that state, and calling into the driver can
> wake a runtime-suspended controller or touch registers whose clocks are
> gated.
> 
> Fixes: ec56acfef2af1 ("can: flexcan: flexcan_get_berr_counter(): switch on clocks before accessing ecr register")
> Cc: stable@vger.kernel.org
> Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
> ---
> v6:
>  - Only gate do_get_auto_tdcv() on netif_running(), as suggested by
>    Vincent Mailhol and Marc Kleine-Budde. The other TDC parameters are
>    still reported for down interfaces.
>  - Adjust can_tdc_get_size() so that only the automatic TDCV size is
>    skipped when the interface is down.
>  - Keep the berr-counter gating unchanged.
> ---
>  drivers/net/can/dev/netlink.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 6f83b87d54fc..ae0cef791ef3 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -517,7 +517,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
>  }
>  
>  static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
> -			       u32 tdc_flags)
> +			       u32 tdc_flags, bool auto_tdcv_running)

Nitpick: I think it is slightly better to pass dev rather than
auto_tdcv_running:

	static size_t can_tdc_get_size(const struct net_device *dev,
				       struct data_bittiming_params *dbt_params,
				       u32 tdc_flags)

The reason is that by passing dev, it would be easier in the future if
for whatever reason we need to retrieve other values. (And to be
honest, I was not going to comment just for this, but because a v7 is
needed anyway, I think you can add this small change while at it).

>  {
>  	bool tdc_manual = tdc_flags & CAN_CTRLMODE_TDC_MANUAL_MASK;
>  	size_t size;
> @@ -538,7 +538,7 @@ static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
>  	}
>  
>  	if (tdc_flags) {
> -		if (tdc_manual || dbt_params->do_get_auto_tdcv)
> +		if (tdc_manual || (dbt_params->do_get_auto_tdcv && auto_tdcv_running))

And by passing dev, this becomes:

		if (tdc_manual || (dbt_params->do_get_auto_tdcv && netif_running(dev)))

making the pattern slightly more consistent throughout the file.

>  			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV */
>  		size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO */
>  		if (dbt_params->tdc_const->tdcf_max)
> @@ -548,8 +548,9 @@ static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
>  	return size;
>  }


Yours sincerely,
Vincent Mailhol
