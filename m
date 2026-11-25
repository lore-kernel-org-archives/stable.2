Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600478;
	b=0FCaPA++gLT5WSRh11ketBK+nD3f1sYarCmEWr18l8g+nwexjIsVMgs823/fpgIRnCtq
	 VP0Nh+yztnrUt+M1m0BK4CtphU+hq7wwmFDBX5zD+BfjqyUjjO8THnm2zlE5NL/2qZtsb
	 b1QfKEZ0SHMHhBCnPE5KM/b87gRICwKkoCFMK4egQ7tPYt5unJy6DF8CjBWDQqaD1xAib
	 lh5FAG1oV/oVpO5oICboWSLbLONtKZ6Ulr5pua+EXhHTOEdz9Y8mH1HENP8wyyXEK/uM+
	 Qm7nRSBSlH5pxdvEgNlJgWFtBWXOMbqgZMzYP3hFcA9RO47jtGI5q4KtjukMbhGAMUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600478;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=dqnz7tnQzFb2HN0hOtO2CiNCBvpHNLSCg8i+yat24bo=;
	b=39IFJfuhK+g0ToVHK5iiFCF1UXLOnQXNtvSZdGnYZy0yq/720ZqLajM7SAybG3Dh5dL2
	 BAmemPdwaOFyQWalPihwA1mwM9VCKIHMdahk7+djKHR4KHLpSxf+PVX2dUn+Om3ArEYyN
	 hoyDDZbixjeLOlL+3pkzhWYMeiP1f+8u2LhpvpgQZT9vDPN715eSSrhNKLZ+nmQAyrtC0
	 64lEerClvOONPs/WiQRgTWoCMBUBlyXjEvQlgKv6EH3ffh6vcf45e1bYXZmgqda0d3R7c
	 Y9pN33G9QIBFJZzZD+1/h/NHHcDqXs/bAK9rCAVL6eiwv7HZuUGJGufyYBA7aNUtmuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WvFi5WPm;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575E606A31E;
	Wed, 25 Nov 2026 09:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C575E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WvFi5WPm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795600478; x=1827136478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XWxk3vK6jv02zeSEEzuxFHI0iOUhlAdNAfWwuGdbcyA=;
  b=WvFi5WPmshfyWrHOjTE+3/XioZ8nAigmEUlpb2udA6CHveYypN8jcXej
   qHzologSEwfsNEFZlweAcDnF6UUdMhqsggmWvFCTxpla47VFpoKVj6cBh
   wJJKyXyVEZP6byXx47jxMv/9MqwPEcQV+kBnk3wcbOe6bJFsVlBNVHPix
   dTUOdbIpBzpG5RToHqKtrX4JjcvH/DJsrzf/U68lbobiXotxAmoKkjfBq
   ksUbh0JrFfK6573etWmhsdZgGXqP0PsFIERGKvGaDeyTciLEypTcu/XZ+
   /B/9cTswgoEgf4Hs3uxCYSgecn85rUIAjkpT3xn6D8j4jzkZpM/KBo3lj
   A==;
X-CSE-ConnectionGUID: lnoFRgx4Sa69hW4sYEHKrQ==
X-CSE-MsgGUID: UkU6SoczQNWAxAHyFP0rww==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4384705"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4384705"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 01:52:17 -0800
X-CSE-ConnectionGUID: q46k8xxESn6mKQhvpju/yg==
X-CSE-MsgGUID: h68w84LlQUS5SwvE3n+86A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11845909"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 25 Nov 2026 01:51:15 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id D2FBB98; Wed, 25 Nov 2026 10:51:13 +0100 (CET)
Date: Wed, 25 Nov 2026 10:51:13 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: fusb302: Keep interrupt flags across a
 failed register read
Message-ID: <awavkaJN9zbouVvU@black.igk.intel.com>
References: <20261123-fusb302-irq-read-error-v2-1-5539a09127d8@flipper.net>
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
In-Reply-To: <20261123-fusb302-irq-read-error-v2-1-5539a09127d8@flipper.net>

On Mon, Nov 23, 2026 at 02:34:10PM +0400, Alexey Charkov wrote:
> Reading INTERRUPT, INTERRUPTA or INTERRUPTB clears its flags in the chip,
> so bailing out on an I2C error in a later read loses the flags already
> read. On Flipper One, a NACK on INTERRUPTB just as a source raised VBUS
> lost VBUSOK. The driver kept treating VBUS as off, so TCPM never attached
> as a sink and left every Source_Capabilities unanswered.
> 
> Keep the flags pending until they are handled, and retry the reads a few
> times, as such errors pass. Otherwise a flag left pending waits for the
> next interrupt.
> 
> Fixes: c034a43e72dd ("staging: typec: Fairchild FUSB302 Type-c chip driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v2:
> - Added stable
> - Rebased onto current linux-next
> - Link to v1: https://patch.msgid.link/20261117-fusb302-irq-read-error-v1-1-a85d45b91912@flipper.net
> ---
>  drivers/usb/typec/tcpm/fusb302.c | 62 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index 83bd287dadc7..9fb76fdd3b7b 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -100,6 +100,10 @@ struct fusb302_chip {
>  	bool intr_togdone;
>  	bool intr_bc_lvl;
>  	bool intr_comp_chng;
> +	/* interrupt flags read from the chip, but not handled yet */
> +	u8 pending_interrupt;
> +	u8 pending_interrupta;
> +	u8 pending_interruptb;
>  
>  	/* port status */
>  	bool vconn_on;
> @@ -1499,6 +1503,43 @@ static irqreturn_t fusb302_irq_intn(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +/*
> + * Reading an interrupt register clears its flags in the chip, so keep them
> + * pending until handled: a bus error on a later read would otherwise lose
> + * them. Such errors pass, so retry a few times.
> + */
> +static int fusb302_read_interrupts(struct fusb302_chip *chip, u8 *status0)
> +{
> +	int ret, tries;
> +	u8 flags;
> +
> +	for (tries = 0; tries < 3; tries++) {
> +		if (tries)
> +			usleep_range(1000, 2000);
> +
> +		ret = fusb302_i2c_read(chip, FUSB_REG_INTERRUPT, &flags);
> +		if (ret < 0)
> +			continue;
> +		chip->pending_interrupt |= flags;
> +
> +		ret = fusb302_i2c_read(chip, FUSB_REG_INTERRUPTA, &flags);
> +		if (ret < 0)
> +			continue;
> +		chip->pending_interrupta |= flags;
> +
> +		ret = fusb302_i2c_read(chip, FUSB_REG_INTERRUPTB, &flags);
> +		if (ret < 0)
> +			continue;
> +		chip->pending_interruptb |= flags;
> +
> +		ret = fusb302_i2c_read(chip, FUSB_REG_STATUS0, status0);
> +		if (ret >= 0)
> +			return 0;
> +	}
> +
> +	return ret;
> +}
> +
>  static void fusb302_irq_work(struct work_struct *work)
>  {
>  	struct fusb302_chip *chip = container_of(work, struct fusb302_chip,
> @@ -1521,18 +1562,17 @@ static void fusb302_irq_work(struct work_struct *work)
>  	intr_bc_lvl = chip->intr_bc_lvl;
>  	intr_comp_chng = chip->intr_comp_chng;
>  
> -	ret = fusb302_i2c_read(chip, FUSB_REG_INTERRUPT, &interrupt);
> -	if (ret < 0)
> -		goto done;
> -	ret = fusb302_i2c_read(chip, FUSB_REG_INTERRUPTA, &interrupta);
> -	if (ret < 0)
> -		goto done;
> -	ret = fusb302_i2c_read(chip, FUSB_REG_INTERRUPTB, &interruptb);
> -	if (ret < 0)
> -		goto done;
> -	ret = fusb302_i2c_read(chip, FUSB_REG_STATUS0, &status0);
> -	if (ret < 0)
> +	ret = fusb302_read_interrupts(chip, &status0);
> +	if (ret < 0) {
> +		fusb302_log(chip, "interrupts left pending, ret=%d", ret);
>  		goto done;
> +	}
> +	interrupt = chip->pending_interrupt;
> +	interrupta = chip->pending_interrupta;
> +	interruptb = chip->pending_interruptb;
> +	chip->pending_interrupt = 0;
> +	chip->pending_interrupta = 0;
> +	chip->pending_interruptb = 0;
>  	fusb302_log(chip,
>  		    "IRQ: 0x%02x, a: 0x%02x, b: 0x%02x, status0: 0x%02x",
>  		    interrupt, interrupta, interruptb, status0);
> 
> ---
> base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
> change-id: 20261116-fusb302-irq-read-error-8a3ca5ef9ebc
> 
> Best regards,
> --  
> Alexey Charkov <alchark@flipper.net>

-- 
heikki
