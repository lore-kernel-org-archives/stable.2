Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C7C3F12CE;
	Tue, 21 Jul 2026 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654801; cv=none; b=fnmDesLgKwCgxwKdzHCW2RL0jb+QGSpShtu8+WqTOf0mz+0edwgmjA3rcbn3unf2GWZJN/s7cHmthv+Lp1UMTNKASxL+eiaNGQfYFMGxe1kHkw3rG11uO7iqgRqXU/dN9wxOg8NeyeKqvd/w04j5QXeoSrWE3F6K67u9aYRpk60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654801; c=relaxed/simple;
	bh=lvlBRscIBLmn6CL3Xef9dxfc8Ddavm8m+UaiaIrOdUQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SvanoAtjQKfhr0hNMgewv+aILM2635VPtzMF0Os4zD+m5rIHqj075s3JR+rTfMex5OZ11wH2tcTpbOfRkZOQBq/qs3hE68YWUHHp1ZzD96UaIWjgI0gejbv8Xn6DIZJV/bILqitw+NF3HU1DTCOttO7ljTWYCqTcuHVUMpWLnsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XggiKeMg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XggiKeMg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784654800; x=1816190800;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lvlBRscIBLmn6CL3Xef9dxfc8Ddavm8m+UaiaIrOdUQ=;
  b=XggiKeMgq+5Y5d3ChQOTFJ69iaWGBNBR2j+rx7lOVCIYPFafC2dVO1Pa
   R5hZRZok65Sz4e7Xfcwu3zZ6Lb5Fbh7V1ut3JM/Y6NFij7gahklbzCbDr
   mWSVA1ok1JGNL9GQ5Z0dnZ7Gflzxnh5I3RABVi2Oowahfyg7RiB1IYu4g
   /VijAdjSKlkmGaPVMidS3yrD/iA59Zel/FLWBXpMpaqdukHkhyFt+xYIf
   ol/4k7E7bMllLZH9kaTQAjzTrRarQfLxQgi/OieJyQYTSQ6WDrlYK5D5z
   UwyGt8ou8EQb/nxCgRvRCGQQkQWG4ZTfc2Dzj7lobrMnNaTEtQ9UQiMoH
   A==;
X-CSE-ConnectionGUID: YbNGBnZ2QUGdRf+/1BpvmA==
X-CSE-MsgGUID: Sg8HG6qaQRm2hRUampK11w==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="95628420"
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="95628420"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 10:26:40 -0700
X-CSE-ConnectionGUID: HEJiXACORUCG437DOJnh6w==
X-CSE-MsgGUID: krY8MNYrT92jSgfAlktwuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,177,1779174000"; 
   d="scan'208";a="256608538"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 10:26:37 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Jul 2026 20:26:33 +0300 (EEST)
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
cc: Azael Avalos <coproscefalo@gmail.com>, Hans de Goede <hansg@kernel.org>, 
    Matthew Garrett <matthew.garrett@nebula.com>, 
    Pierre Ducroquet <pinaraf@pinaraf.info>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    jianhao.xu@seu.edu.cn, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: toshiba_acpi: use brightness_set_blocking
 for LED callbacks
In-Reply-To: <20260618052751.3859461-1-runyu.xiao@seu.edu.cn>
Message-ID: <cd147fb1-e4dc-0793-1d35-5e51077742b5@linux.intel.com>
References: <20260618052751.3859461-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 18 Jun 2026, Runyu Xiao wrote:

> The Toshiba illumination, eco mode, and keyboard backlight callbacks all
> go through ACPI/HCI/SCI helpers that may sleep, but the driver still
> registers them as brightness_set callbacks.
> 
> This issue was found by our static analysis tool and then manually
> reviewed against the current tree.
> 
> A minimal Lockdep reproducer that keeps the original registration and
> call chains is enough to trigger the warning in all three cases:
> 
>   toshiba_illumination_set() -> sci_open()/sci_write() -> tci_raw()
>   toshiba_kbd_backlight_set() -> hci_write() -> tci_raw()
>   toshiba_eco_mode_set_status() -> tci_raw()
> 
> All three paths reach ACPI object evaluation while
> led_trigger_event_atomic() is still holding spin_lock_irqsave(),
> and Lockdep reports sleeping function called from invalid context with
> acpi_os_wait_semaphore() on the stack.
> 
> Convert the three callbacks to brightness_set_blocking and return proper
> status codes from the firmware transactions.
> 
> Fixes: 360f0f39d0c5 ("toshiba_acpi: Add keyboard backlight support")
> Fixes: 6c3f6e6c575a ("toshiba-acpi: Add support for Toshiba Illumination.")
> Fixes: def6c4e25d31 ("toshiba_acpi: Add ECO mode led support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
> Notes:
>   - Not tested on Toshiba hardware.
> 
>  drivers/platform/x86/toshiba_acpi.c | 42 ++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index 5ad3a7183d33..22a831c9e8c4 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -486,8 +486,8 @@ static void toshiba_illumination_available(struct toshiba_acpi_dev *dev)
>  	dev->illumination_supported = 1;
>  }
>  
> -static void toshiba_illumination_set(struct led_classdev *cdev,
> -				     enum led_brightness brightness)
> +static int toshiba_illumination_set(struct led_classdev *cdev,
> +				    enum led_brightness brightness)
>  {
>  	struct toshiba_acpi_dev *dev = container_of(cdev,
>  			struct toshiba_acpi_dev, led_dev);
> @@ -496,14 +496,20 @@ static void toshiba_illumination_set(struct led_classdev *cdev,
>  
>  	/* First request : initialize communication. */
>  	if (!sci_open(dev))
> -		return;
> +		return -EIO;
>  
>  	/* Switch the illumination on/off */
>  	state = brightness ? 1 : 0;
>  	result = sci_write(dev, SCI_ILLUMINATION, state);
>  	sci_close(dev);
> -	if (result == TOS_FAILURE)
> +	if (result == TOS_FAILURE) {
>  		pr_err("ACPI call for illumination failed\n");
> +		return -EIO;
> +	}
> +	if (result == TOS_NOT_SUPPORTED)
> +		return -ENODEV;

So this has not been observed on some HW after 
toshiba_illumination_available() finds it supported. Adding the check
looks just extra churn to me and IMO it would be fine to return -EIO if 
it suddenly stops working.

> +
> +	return result == TOS_SUCCESS ? 0 : -EIO;
>  }
>  
>  static enum led_brightness toshiba_illumination_get(struct led_classdev *cdev)
> @@ -624,7 +630,7 @@ static enum led_brightness toshiba_kbd_backlight_get(struct led_classdev *cdev)
>  	return state ? LED_FULL : LED_OFF;
>  }
>  
> -static void toshiba_kbd_backlight_set(struct led_classdev *cdev,
> +static int toshiba_kbd_backlight_set(struct led_classdev *cdev,
>  				     enum led_brightness brightness)
>  {
>  	struct toshiba_acpi_dev *dev = container_of(cdev,
> @@ -635,8 +641,14 @@ static void toshiba_kbd_backlight_set(struct led_classdev *cdev,
>  	/* Set the keyboard backlight state */
>  	state = brightness ? 1 : 0;
>  	result = hci_write(dev, HCI_KBD_ILLUMINATION, state);
> -	if (result == TOS_FAILURE)
> +	if (result == TOS_FAILURE) {
>  		pr_err("ACPI call to set KBD Illumination mode failed\n");
> +		return -EIO;
> +	}
> +	if (result == TOS_NOT_SUPPORTED)
> +		return -ENODEV;
> +
> +	return result == TOS_SUCCESS ? 0 : -EIO;
>  }
>  
>  /* TouchPad support */
> @@ -737,8 +749,8 @@ toshiba_eco_mode_get_status(struct led_classdev *cdev)
>  	return out[2] ? LED_FULL : LED_OFF;
>  }
>  
> -static void toshiba_eco_mode_set_status(struct led_classdev *cdev,
> -				     enum led_brightness brightness)
> +static int toshiba_eco_mode_set_status(struct led_classdev *cdev,
> +				       enum led_brightness brightness)
>  {
>  	struct toshiba_acpi_dev *dev = container_of(cdev,
>  			struct toshiba_acpi_dev, eco_led);
> @@ -749,8 +761,14 @@ static void toshiba_eco_mode_set_status(struct led_classdev *cdev,
>  	/* Switch the Eco Mode led on/off */
>  	in[2] = (brightness) ? 1 : 0;
>  	status = tci_raw(dev, in, out);
> -	if (ACPI_FAILURE(status))
> +	if (ACPI_FAILURE(status)) {
>  		pr_err("ACPI call to set ECO led failed\n");
> +		return -EIO;
> +	}
> +	if (out[0] == TOS_NOT_SUPPORTED)
> +		return -ENODEV;

Same note here.

I suggest you just do the callback changes and leave these error code 
plays out of the patch unless some hw actually needs them.

> +
> +	return out[0] == TOS_SUCCESS ? 0 : -EIO;
>  }
>  
>  /* Accelerometer support */
> @@ -3366,7 +3384,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  	if (dev->illumination_supported) {
>  		dev->led_dev.name = "toshiba::illumination";
>  		dev->led_dev.max_brightness = 1;
> -		dev->led_dev.brightness_set = toshiba_illumination_set;
> +		dev->led_dev.brightness_set_blocking = toshiba_illumination_set;
>  		dev->led_dev.brightness_get = toshiba_illumination_get;
>  		led_classdev_register(&acpi_dev->dev, &dev->led_dev);
>  	}
> @@ -3375,7 +3393,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  	if (dev->eco_supported) {
>  		dev->eco_led.name = "toshiba::eco_mode";
>  		dev->eco_led.max_brightness = 1;
> -		dev->eco_led.brightness_set = toshiba_eco_mode_set_status;
> +		dev->eco_led.brightness_set_blocking = toshiba_eco_mode_set_status;
>  		dev->eco_led.brightness_get = toshiba_eco_mode_get_status;
>  		led_classdev_register(&dev->acpi_dev->dev, &dev->eco_led);
>  	}
> @@ -3391,7 +3409,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>  		dev->kbd_led.name = "toshiba::kbd_backlight";
>  		dev->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
>  		dev->kbd_led.max_brightness = 1;
> -		dev->kbd_led.brightness_set = toshiba_kbd_backlight_set;
> +		dev->kbd_led.brightness_set_blocking = toshiba_kbd_backlight_set;
>  		dev->kbd_led.brightness_get = toshiba_kbd_backlight_get;
>  		led_classdev_register(&dev->acpi_dev->dev, &dev->kbd_led);
>  	}
> 

-- 
 i.

