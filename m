Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723295;
	b=FtKw4IvA6LXe1UAh6m5MgCrTdg3a0PmyOFY2C7Iz537TTjQFQkNpsfJA1Bw0exJBlgqB
	 7Y1O5iUuGokI1yA1xCUGgnU4LTiSB10iLOrQ0hXaIh0CZa59x1zxTvdG+tmzuo27wbz03
	 CLdrEexWvUZJEiNEsveNy4kYSvNl3s1NZBtl7NM4ZbLqnii4oqOuneY+Tcc59E0SNVLi7
	 wc46c3I41o9sgZi+o4rR1ZLeMvSvrR4rlt0S7EyT60M9NacvG9Uj79OvYKupVeDZ1PG8J
	 Hj71M0qSTXshdqKYJ6MOfdXEwJHgOEm32GIhOQ8MHsEsNtrpWBilF2J19SwA5VlbyNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723295;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=VJDE2VaGlBqL1jKqnMs85FG086tb9WxrYjVRcaqG+3U=;
	b=bbe7GuIWeDy5a6CaA/BmRJWAAxDJ0D4cZSdSSVtqTdb+9tgfQhKt7/CukuM+vvF/vjTE
	 gy93+69nRJvHyHgz9Fgetgp5sbqFye9XlgHgNWCYDiS6bNt5HhvqiMx+I2FBdn9I0sgee
	 AzKaETx8i00uQDRwG2jgEgmRwzEAq66bEG0gYbtqjW4TfK3mt/2a1WkXEj0Kb2aU6ODgT
	 B1uRfl9mPpdGxzYsyC0cLGvKuCF9wXToEMCcI/TdbTexZkJxv8mR5aH5chUW10sY5kpzD
	 XtrcB0Z0V65HAY0rACmafFzIJksegJwXy0JKnRqRXA7yB391ZpJYbB5uFBlOyHQkaBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkmOKoRN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F40606A326;
	Tue,  3 Nov 2026 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WkmOKoRN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DA91F000C1;
	Tue,  3 Nov 2026 16:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723295;
	bh=VJDE2VaGlBqL1jKqnMs85FG086tb9WxrYjVRcaqG+3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WkmOKoRNNL2pOzw7Uj84JOivX/pMLxbV5J7iZcjv1/TLSJ+utD3OCblyij3dq2Dnr
	 9feC+UlQytWfYP33F3owi4g37dQdcmd9vvWoi0GkgtXJ2gZThsFzLwiE/xcNRxPQOr
	 oItU+sxORR/jc77LGjAY4U774yWvwKFAbWVGltZBDKgJIg9pmWqpe2ED823z32RKMR
	 PUdljHUhVvqfLqcQL0edLv+ihXNVvKHpv66dMe5ANpDK8Y7zx+O5m9kvao4/3gvvtj
	 /QVFTqWDJuJDQ6hue9xe9d7OaJZuZmUvHvDD3uMotmu0OPT28Pui7It2ocZMK5Orab
	 15HpJk0eh73+w==
Message-ID: <5babb98b-7d6e-4f3a-b306-b40b30c4cdfa@kernel.org>
Date: Tue, 3 Nov 2026 17:28:11 +0100
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
Subject: Re: [PATCH] platform/x86: x86-android-tablets: fix codec teardown if
 poweroff handler setup fails
To: Wentao Liang <vulab@iscas.ac.cn>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261103105544.1394559-1-vulab@iscas.ac.cn>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20261103105544.1394559-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3-Nov-26 11:55 AM, Wentao Liang wrote:
> lenovo_yoga_tab2_830_1050_init_codec() stores the codec device reference,
> the pinctrl handle and the pin mappings in globals on success; they are
> only released by lenovo_yoga_tab2_830_1050_exit(). If the
> register_sys_off_handler() call which follows it fails, the init callback
> returns an error before the exit callback has been registered with the
> framework, so the codec device reference and the other resources are
> never released.
> 
> Factor the codec teardown out into a helper and call it from the error
> path of both init callbacks.
> 
> Fixes: 4ce8f4c2027d ("platform/x86: x86-android-tablets: Fix Lenovo Yoga Tablet 2 830/1050 poweroff again")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  .../platform/x86/x86-android-tablets/lenovo.c | 27 +++++++++++++------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
> index 52d96ae89078..294986f84ce8 100644
> --- a/drivers/platform/x86/x86-android-tablets/lenovo.c
> +++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
> @@ -548,6 +548,14 @@ static int __init lenovo_yoga_tab2_830_1050_init_codec(void)
>  	return ret;
>  }
>  
> +static void lenovo_yoga_tab2_830_1050_exit_codec(void)
> +{
> +	device_remove_software_node(lenovo_yoga_tab2_830_1050_codec_dev);
> +	pinctrl_put(lenovo_yoga_tab2_830_1050_codec_pinctrl);
> +	pinctrl_unregister_mappings(&lenovo_yoga_tab2_830_1050_codec_pinctrl_map);
> +	put_device(lenovo_yoga_tab2_830_1050_codec_dev);
> +}
> +
>  /*
>   * These tablet's DSDT does not set acpi_gbl_reduced_hardware, so acpi_power_off()
>   * gets used as pm_power_off handler. This causes "poweroff" on these tablets
> @@ -578,8 +586,11 @@ static int __init lenovo_yoga_tab2_830_1050_init(struct device *dev)
>  	lenovo_yoga_tab2_830_1050_sys_off_handler =
>  		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_FIRMWARE + 1,
>  					 lenovo_yoga_tab2_830_1050_power_off, NULL);
> -	if (IS_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler))
> -		return PTR_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler);
> +	if (IS_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler)) {
> +		ret = PTR_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler);
> +		lenovo_yoga_tab2_830_1050_exit_codec();
> +		return ret;
> +	}

lenovo_yoga_tab2_830_1050_exit_codec() does not touch lenovo_yoga_tab2_830_1050_sys_off_handler,
so there is no reason to store the error-code in ret before calling it.

Please just keep this line:

		return PTR_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler);

as-is.


>  
>  	return 0;
>  }
> @@ -588,10 +599,7 @@ static void lenovo_yoga_tab2_830_1050_exit(void)
>  {
>  	unregister_sys_off_handler(lenovo_yoga_tab2_830_1050_sys_off_handler);
>  
> -	device_remove_software_node(lenovo_yoga_tab2_830_1050_codec_dev);
> -	pinctrl_put(lenovo_yoga_tab2_830_1050_codec_pinctrl);
> -	pinctrl_unregister_mappings(&lenovo_yoga_tab2_830_1050_codec_pinctrl_map);
> -	put_device(lenovo_yoga_tab2_830_1050_codec_dev);
> +	lenovo_yoga_tab2_830_1050_exit_codec();

Please also remove the empty line which was there to group all the codec
cleanup calls together which now no longer is necessary.

>  }
>  
>  /*
> @@ -776,8 +784,11 @@ static int __init lenovo_yoga_tab2_1380_init(struct device *dev)
>  	lenovo_yoga_tab2_830_1050_sys_off_handler =
>  		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_FIRMWARE + 1,
>  					 lenovo_yoga_tab2_830_1050_power_off, NULL);
> -	if (IS_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler))
> -		return PTR_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler);
> +	if (IS_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler)) {
> +		ret = PTR_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler);
> +		lenovo_yoga_tab2_830_1050_exit_codec();
> +		return ret;
> +	}

Same as above, please keep this line:

		return PTR_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler);

as-is.

Regards,

Hans

