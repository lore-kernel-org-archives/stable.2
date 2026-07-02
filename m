Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81651331ECC;
	Thu,  2 Jul 2026 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987625; cv=none; b=eyh/BGFJM6MS1eWYjwB2LJkqh+604JhcpPoYzHZeZ80su2xDLkWWX4xHTVo3Rqo4J09vKBidCyjW7LaW54FH7Ifn6EHq+0s7A55woA4oiBi7/gIdAjxP+NNJa+gpDdtGVPdXFkFyP2bHoaVz3eMW5PuqKMD/bTZW1ADwfdXCSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987625; c=relaxed/simple;
	bh=NTj3SMMZi59FJRD9neVtVzHFkfFu2Xfyy21Th1lSVS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNKdG5YbWreGkBDyoKrGQhDsnnpDml1E6h2OjROkWzQDDLE15O9FbOjZEdsAG9vd67eXFtU5B7OnjjUopHUOTdDdKHJS05WOeuctr5xCt2witCuNtn6svxXCWzyQ2Dj6MFOPpXl6AWRBepqdVpfoCuADHp5l6EDxHr9TnrRmSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoEffApH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoEffApH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542001F000E9;
	Thu,  2 Jul 2026 10:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782987623;
	bh=pKlN1lKaCwCvx1qCw5sm035UekJag3BuZwX6Ys1gvfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aoEffApH4IBz8kezLe9+FkUVXNGpPyQofj9vfgPMO0KOpfiVQkvgN/6AKCdt9IaVs
	 nSr79KXJA08JeirgAgP4Hv2w/DbO6Ck1Pozv69YwgyJ4Mr8pgH6v7EGUPxyCT60lR8
	 Gzwt9GhG3oxWgwx5B75V7H2omx3Rc/cm5LbLYn4NakO87macqnhrXDcH6YhtrFEaxF
	 fSmfjnazZ9+1I/nemiHNsHTyrSMB8HR/KqdL6h1a49Qreix3uK2ORI9WZh38yEL63/
	 hTFmVBwwsmfga0QcE/KbgfZ7tT9Ziv6dc16mlSABhuyBUnZ5Zysmpk3BuxS+fflXGJ
	 Bpyi3g6JEyClw==
Date: Thu, 2 Jul 2026 11:20:18 +0100
From: Lee Jones <lee@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Pavel Machek <pavel@kernel.org>, linux-leds@vger.kernel.org,
	Andreas Werner <andreas.werner@men.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>,
	Bryan Wu <cooloney@gmail.com>, linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] leds: lm3530: use brightness_set_blocking for
 sleepable callback
Message-ID: <20260702102018.GH2108533@google.com>
References: <20260615145756.1019184-1-runyu.xiao@seu.edu.cn>
 <20260615145756.1019184-2-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615145756.1019184-2-runyu.xiao@seu.edu.cn>

On Mon, 15 Jun 2026, Runyu Xiao wrote:

> lm3530_brightness_set() talks to the device over I2C and can sleep, but
> the driver registers it as brightness_set.  That leaves the LED core
> free to invoke the callback from atomic contexts.
> 
> This issue was found by our static analysis tool and then manually
> reviewed against the current tree.
> 
> A minimal Lockdep reproducer that keeps the original registration and
> call chain is enough to trigger the warning: lm3530_probe() still
> publishes lm3530_brightness_set() as brightness_set,
> led_trigger_event_atomic() invokes it under spin_lock_irqsave(), and
> the callback reaches i2c_smbus_write_byte_data() as its first
> sleepable edge.
> 
> Lockdep reports:
> 
>   BUG: sleeping function called from invalid context
>   i2c_smbus_write_byte_data.constprop.0+0x14/0x30 [vuln_msv]
>   lm3530_brightness_set+0x4e/0x66 [vuln_msv]
>   led_trigger_event_atomic.constprop.0+0x2b/0x40 [vuln_msv]
> 
> Convert the callback to brightness_set_blocking so the LED core only
> invokes it from a sleepable context.
> 
> Fixes: b1e6b7068f02 ("leds: add driver for LM3530 ALS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
> Notes:
>   - Validated with a grounded Lockdep PoC that preserves the
>     lm3530_probe() brightness_set registration and the
>     led_trigger_event_atomic() -> lm3530_brightness_set() ->
>     i2c_smbus_write_byte_data() path.
>   - checkpatch.pl --strict: clean.
>   - Not tested on LM3530 hardware.
> 
>  drivers/leds/leds-lm3530.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/leds/leds-lm3530.c b/drivers/leds/leds-lm3530.c
> index e44a3db106c3..ba744961ebcd 100644
> --- a/drivers/leds/leds-lm3530.c
> +++ b/drivers/leds/leds-lm3530.c
> @@ -301,10 +301,11 @@ static int lm3530_init_registers(struct lm3530_data *drvdata)
>  	return ret;
>  }
>  
> -static void lm3530_brightness_set(struct led_classdev *led_cdev,
> -				     enum led_brightness brt_val)
> +static int
> +lm3530_brightness_set_blocking(struct led_classdev *led_cdev,
> +			       enum led_brightness brt_val)
>  {
> -	int err;
> +	int err = 0;
>  	struct lm3530_data *drvdata =
>  	    container_of(led_cdev, struct lm3530_data, led_dev);
>  	struct lm3530_platform_data *pdata = drvdata->pdata;
> @@ -344,6 +345,8 @@ static void lm3530_brightness_set(struct led_classdev *led_cdev,
>  	default:
>  		break;
>  	}
> +
> +	return err;

What makes you think that the original author didn't want these failures
to be non-catastrophic?

>  }
>  
>  static ssize_t mode_show(struct device *dev,
> @@ -438,7 +441,8 @@ static int lm3530_probe(struct i2c_client *client)
>  	drvdata->brightness = LED_OFF;
>  	drvdata->enable = false;
>  	drvdata->led_dev.name = LM3530_LED_DEV;
> -	drvdata->led_dev.brightness_set = lm3530_brightness_set;
> +	drvdata->led_dev.brightness_set_blocking =
> +		lm3530_brightness_set_blocking;

We've had no complaints about this in the 15-years it's been
operational.  I think it's safe to conclude that this isn't causes
anyone issues.  I'd be concerned that these changes, although seemingly
correct on the surface, may cause problems for users, which would be
unacceptable.

>  	drvdata->led_dev.max_brightness = MAX_BRIGHTNESS;
>  	drvdata->led_dev.groups = lm3530_groups;
>  
> -- 
> 2.34.1

-- 
Lee Jones
