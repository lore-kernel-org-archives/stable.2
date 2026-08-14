Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C06C3D6CB6
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786717721; cv=none; b=KnJ7zkYKTVosvZfVjg7EShHqGYwXlUCKMqLPUHufBejUsmb59Br/EZgLQuwlG9avZ3G41pVTCih1Kco4KC/Eq+bA+v15C0iGO4DrbFhvyjtzzO91skA8gIDdjIqYl+sd1FZFPTd6T8ZdRJFoxc+iXofBjbTPPNXo4EYZLwXkwHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786717721; c=relaxed/simple;
	bh=sC/DjGTUMDQx1nZ/tDtuJ6mj5RHkTCeearjIOXa7Ae4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N3i3G48nv5PM+fNX2umBun9L73aK4Yknef2C/wHQwTfolBulXEU4iFY/mK1AyPJLKu/EXrgMEax0Y6ng5pWV+2d+DDGZJEnkHr7C7PoLDQkiqZgQdQWn+PUi0RW/UiSHV+GjL9INITsNjN1Y05BHAvllYkGxnIilVeJXaHcRdrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1D11F00A3A;
	Fri, 14 Aug 2026 14:28:31 +0000 (UTC)
Message-ID: <34ecdd48-17e7-4d53-89ba-b9dfdfaab537@tuxon.dev>
Date: Fri, 14 Aug 2026 17:28:29 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Use -ENOTSUPP instead of
 -EOPNOTSUPP
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>, stable@vger.kernel.org
References: <20260814142719.2949254-1-claudiu.beznea+renesas@tuxon.dev>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260814142719.2949254-1-claudiu.beznea+renesas@tuxon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Please ignore this and the other similar ones. I missed to mention the target 
branch.

Thank you,
Claudiu

On 8/14/26 17:27, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> commit c1492da3939c89372929e062d731f328f7693f1e upstream.
> 
> The pinctrl and GPIO core code make exceptions for the -ENOTSUPP error
> code.  One such example is gpio_set_config_with_argument_optional(),
> which returns success when gpio_set_config_with_argument() returns
> -ENOTSUPP, but reports failure for all other error codes.
> 
> Returning -EOPNOTSUPP from the pinctrl driver on the unsupported pinctrl
> operation may lead to boot failures when pinctrl drivers implements
> struct gpio_chip::set_config, the system uses GPIO hogs, and the
> struct gpio_chip::set_config implementation returns -EOPNOTSUPP for the
> unsupported operations.
> 
> Return -ENOTSUPP for the unsupported pinctrl operation.
> 
> Fixes: 560c633d378a ("pinctrl: renesas: rzg2l: Drop oen_read and oen_write callbacks")
> Fixes: c4c4637eb57f ("pinctrl: renesas: Add RZ/G2L pin and gpio controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://patch.msgid.link/20260515124008.2947838-2-claudiu.beznea@kernel.org
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [claudiu.beznea: fixed conflict by dropping the code not present in
>   v6.6 stable]
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>   drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> index ac629c72d592..b713cc8e0fde 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> @@ -710,7 +710,7 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
>   		}
>   
>   		default:
> -			return -EOPNOTSUPP;
> +			return -ENOTSUPP;
>   		}
>   	}
>   
> @@ -759,7 +759,7 @@ static int rzg2l_pinctrl_pinconf_group_get(struct pinctrl_dev *pctldev,
>   
>   		/* Check config matching between to pin  */
>   		if (i && prev_config != *config)
> -			return -EOPNOTSUPP;
> +			return -ENOTSUPP;
>   
>   		prev_config = *config;
>   	}

