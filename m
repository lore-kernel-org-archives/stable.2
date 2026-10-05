Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE82282F24;
	Mon,  5 Oct 2026 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212317; cv=none; b=hfuoOCS48Sc9CFn6oT/HCGVslwHhRYruiAT8PDo9hCfjUC2Q0vLRvrur1xoVuzHC3TZOfs2xQxbCdCD1uCPT3oHv/B0rq2vjSoy0pTE3o83UO5jPnielVM3KAoYTJ3e3w2iajiAJfhtlOrq3Qqp5KkicXYslfr8bOMNgu8vJmoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212317; c=relaxed/simple;
	bh=JYwDZJzPrynMXUZ/ZBYJWDi3oZr3f7C9JztTMkiLc0E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IkQZkNg8B/Y84nA3Kbd13mdHakVB48NxubyzVAmiq/2iOKhMLVrrBuBEB3UumoNBo/wgM9LpH01GQ/eh08RXbMp/mziy1N4UYf1Mzp88SvwVpN+PsM2Jx215abTBweQl7GKwDXWMz+QgoylVgOFnOO+kvXrClF4E7ma077IQdDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=faPwb5eB; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="faPwb5eB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=sL4fTAox0bszhk/TX15GUFX/qSeEq9hiFyTMi07J3pI=; b=faPwb5eBZTBaAFc93tbOVqKfsc
	oOHJWKwQU5AluRLgQ/DbvX/11553MCmHcAk56xYXdVsviJU9F4NogOs+RPxtnH8wZgQi97kjCsl/e
	WAS3BIPLENhHi2fpYeDAQrt6rOSyW5mD6psuJUfG5CvqtERSAcc6rIn4wTRFgYBDXsnE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xDk98-000000001KT-2JWV;
	Mon, 05 Oct 2026 10:58:32 -0400
Date: Mon, 5 Oct 2026 10:58:31 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
Cc: Linus Walleij <linusw@kernel.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 =?ISO-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>,
 Alistair Francis <alistair@alistair23.me>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, <linux-input@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Jerome Oufella
 <jerome.oufella@savoirfairelinux.com>, Felix Boucher
 <felix.boucher@savoirfairelinux.com>, Quentin Lehoux
 <quentin.lehoux@savoirfairelinux.com>
Subject: Re: [PATCH 3/3] Input: cyttsp5 - only launch the application when
 in bootloader mode
Message-Id: <20261005105831.707c00e5775df6672cfbfead@hugovil.com>
In-Reply-To: <20261002183529.166248-4-marc-olivier.champagne@savoirfairelinux.com>
References: <20261002183529.166248-1-marc-olivier.champagne@savoirfairelinux.com>
	<20261002183529.166248-4-marc-olivier.champagne@savoirfairelinux.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Marc-Olivier,

On Fri,  2 Oct 2026 14:35:29 -0400
Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
wrote:

> The driver unconditionally sends the bootloader LAUNCH_APP command at
> startup, assuming the device always comes out of a reset in bootloader
> mode. This is not true in general: reset-gpios is optional, so the
> device may already be running the application when the driver probes
> (for instance after a driver reload or a warm reboot without a
> power cycle). The running application does not answer the bootloader
> command, so the command times out and probe fails:
> 
>   cyttsp5 1-0024: HID output cmd execution timed out
>   cyttsp5 1-0024: Error on launch app r=-110
>   cyttsp5 1-0024: Fail initial startup r=-110
> 
> The mode the device is running in can be told from the report ID
> carried by its HID descriptor: 0xFF for the bootloader and 0xF7 for
> the application. Add cyttsp5_get_mode() to read the descriptor and
> decode that ID, and only send LAUNCH_APP when the bootloader is
> running. The HID descriptor is then read again only after the
> application has been launched, as it describes the running mode, and
> startup now fails if the application is not running at that point
> instead of going on with the bootloader descriptor.
> 
> The same problem was previously addressed as part of a larger
> series that did not get merged:
> https://lore.kernel.org/all/20250110-nekocwd-upstreaming-cyttsp5-v3-0-b33659c8effc@gmail.com/
> 
> Fixes: 5b0c03e24a06 ("Input: Add driver for Cypress Generation 5 touchscreen")
> Cc: stable@vger.kernel.org
> Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Assisted-by: Copilot:claude-fable-5.1
> Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
> ---
>  drivers/input/touchscreen/cyttsp5.c | 76 ++++++++++++++++++++++++-----
>  1 file changed, 65 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscreen/cyttsp5.c
> index beeb7d5bcd2c..e88fcc11716e 100644
> --- a/drivers/input/touchscreen/cyttsp5.c
> +++ b/drivers/input/touchscreen/cyttsp5.c
> @@ -70,6 +70,10 @@
>  #define HID_BL_OUTPUT_REPORT_ID			0x40
>  #define HID_RESPONSE_REPORT_ID			0xF0
>  
> +/* Report ID found in the HID descriptor, identifies the running mode */
> +#define HID_DESCRIPTOR_BOOTLOADER_REPORT_ID	0xFF
> +#define HID_DESCRIPTOR_APPLICATION_REPORT_ID	0xF7
> +
>  #define HID_OUTPUT_RESPONSE_REPORT_OFFSET	2
>  #define HID_OUTPUT_RESPONSE_CMD_OFFSET		4
>  #define HID_OUTPUT_RESPONSE_CMD_MASK		GENMASK(6, 0)
> @@ -807,24 +811,74 @@ static int cyttsp5_fill_all_touch(struct cyttsp5 *ts)
>  	return 0;
>  }
>  
> +/*
> + * Returns the report ID advertised by the HID descriptor, which tells
> + * whether the bootloader or the application is running, or a negative
> + * error code.

Remove ambiguous first part and use just "Return whether the bootloader
or..."

> + */
> +static int cyttsp5_get_mode(struct cyttsp5 *ts)
> +{
> +	const char *mode_str;
> +	int mode;
> +	int error;
> +
> +	error = cyttsp5_get_hid_descriptor(ts, &ts->hid_desc);
> +	if (error < 0)
> +		return error;
> +
> +	mode = ts->hid_desc.packet_id;
> +
> +	switch (mode) {
> +	case HID_DESCRIPTOR_BOOTLOADER_REPORT_ID:
> +		mode_str = "bootloader";
> +		break;
> +	case HID_DESCRIPTOR_APPLICATION_REPORT_ID:
> +		mode_str = "application";
> +		break;
> +	default:
> +		dev_err(ts->dev, "Unknown mode, report ID 0x%02x\n", mode);
> +		return -ENODEV;
> +	}
> +
> +	dev_dbg(ts->dev, "Device is in %s mode\n", mode_str);
> +
> +	return mode;
> +}
> +
>  static int cyttsp5_startup(struct cyttsp5 *ts)
>  {
> +	int mode;
>  	int error;
>  
> +	mode = cyttsp5_get_mode(ts);
> +	if (mode < 0) {
> +		dev_err(ts->dev, "Error on getting mode r=%d\n", mode);
> +		return mode;
> +	}
> +
>  	/*
> -	 * Launch the application as the device starts in bootloader mode
> -	 * because of a power-on-reset
> +	 * The device starts in bootloader mode after a reset; the

If I remember correctly, some devices may launch the application
automatically after a reset (and some configurable delay), so maybe
modify as:

    "The device may stay in bootloader mode after a reset..."


> +	 * application then has to be launched explicitly and the HID
> +	 * descriptor read again, as it describes the running mode. Skip
> +	 * this step when the application is already running.

Drop last sentence, as it is already implied and obvious by first
comment line...


>  	 */
> -	error = cyttsp5_hid_output_bl_launch_app(ts);
> -	if (error < 0) {
> -		dev_err(ts->dev, "Error on launch app r=%d\n", error);
> -		return error;
> -	}
> +	if (mode == HID_DESCRIPTOR_BOOTLOADER_REPORT_ID) {
> +		error = cyttsp5_hid_output_bl_launch_app(ts);
> +		if (error < 0) {
> +			dev_err(ts->dev, "Error on launch app r=%d\n", error);
> +			return error;
> +		}
>  
> -	error = cyttsp5_get_hid_descriptor(ts, &ts->hid_desc);
> -	if (error < 0) {
> -		dev_err(ts->dev, "Error on getting HID descriptor r=%d\n", error);
> -		return error;

Your above comments about re-reading the mode should go here, for
better readability and understanding.

> +		mode = cyttsp5_get_mode(ts);
> +		if (mode < 0) {
> +			dev_err(ts->dev, "Error on getting mode r=%d\n", mode);
> +			return mode;
> +		}
> +
> +		if (mode != HID_DESCRIPTOR_APPLICATION_REPORT_ID) {

Combine with above if() using else if()


> +			dev_err(ts->dev, "Application not running after launch\n");
> +			return -ENODEV;
> +		}
>  	}
>  
>  	error = cyttsp5_fill_all_touch(ts);
> -- 
> 2.34.1
> 


-- 
Hugo Villeneuve
