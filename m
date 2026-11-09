Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219610;
	b=HyIrkAcA1TMGNl6mbwrAc3/xBw/0IwO4aWv34p1C1RgsebtFs+cQsVao+u15W+kXQTo3
	 XLMD9vWOABskySqlOGDfX036vNnfKl3SJwGHZIFi3zyywAGwL6O6mf9rvO7S3Oc1ZFRbe
	 k9kuVi77va6bEcUBQevch6KG2OojvaxGTjpNPS3iPGjxgEnt8yzO2Je14aTOq8Bp5Gxow
	 949kYIDqH6YMbCAjl97rBzSu7MNwtvO7rVcVfDIdhuuYc28DOjIgLQEHcjRDW8zRiozhb
	 bESDYgGyN1fMa0oJQdfldi/wHAmN+Z6G5WF8V28xnMohkGtXw3drA5egqszBxXyTrtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219610;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=HvVYUHBOoAzAjJRPzKohu0cA+q7fpa26AKMIEUnBb60=;
	b=WBErm0QC56ZO63xPJjsbkwMLhgRwLvVRBRRMUya+UG/wbC3ffNq41r84kCKmMLFA17CJ
	 m41pzhHcAm7V8Qz11IhZAO9W9QZ+IAD2OBkxACZoLRPptfdfk902ya+siXKWnZW7DRjY0
	 1RUQQP0mfh+Mon7feFSTcQXnf3UCEj1+R7f2v8aMS5DjctsJjtemPgUIsV7XbKlKyfywz
	 iLtmJR8dhAc6cAorNnVJ9LmVnEzfJb/U8N5/g9qMQnJC0GnxJwPygbQpO73xv76BOl9/B
	 K9TDI1nCM3WdI4VVqUqnLUvz1O1FZmxPgcUvyXwdj45uMId7uazNn63ldTJ8osaCFhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m4SGef4f;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5D606A322;
	Mon,  9 Nov 2026 10:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4D5D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m4SGef4f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794219610; x=1825755610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5RJ9G5cztkvT4K6je/5Jl5iGCmxJySnlDnuLAkGyqM8=;
  b=m4SGef4fM8iHSS8wpwRnBOjfNO3Kg3qyJGocfwiLVDEj4ZRMpZYuZYrl
   BPXg0Iap98xmMxVaqZSTwgDFeMk9YNUXaTLmF3lNl5WWP8wLYxqZn9hyt
   ms9gZoA2Tg9fHEdsBIcfjR241R4I7gzA++4OWvOVSNGwa8fp1NIukT8Nr
   cp6ojl1pd9bpabU9cbnAxQD5/tmLjY9QTFRp1WtSpvSdHkp320kjcIgo/
   QL0bm+WDvOB2cGyldHO4WAQ8bywyXig2U35/QZiOTmHWjjP7Ka7TL8Wi+
   +Bs/jbcSVmmJuzxVicelZDx4iX+nFCxJkXJ503mI1n/dRiT5x9kV5dZtT
   A==;
X-CSE-ConnectionGUID: qLpV3oR1Sj6LlO2BSXEvPw==
X-CSE-MsgGUID: t0A/ubZIQ4yjUXzDFcNImw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2927810"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2927810"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 02:20:10 -0800
X-CSE-ConnectionGUID: a620QZrMQOCcQg+W+iem8Q==
X-CSE-MsgGUID: XH3BteTzRDW/G4WLIa4qHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7959247"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 09 Nov 2026 02:20:07 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 18C0399; Mon, 09 Nov 2026 11:20:06 +0100 (CET)
Date: Mon, 9 Nov 2026 11:20:06 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Atif Ashhar <atifashhar@google.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Release slave SCL hold in
 __i2c_dw_disable()
Message-ID: <20261109102006.GJ176724@black.igk.intel.com>
References: <20261104133745.1432212-1-atifashhar@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261104133745.1432212-1-atifashhar@google.com>

Hi,

On Wed, Nov 04, 2026 at 01:37:45PM +0000, Atif Ashhar wrote:
> When an external I2C master initiates a read to the Synopsys DW_apb_i2c
> adapter in slave mode during kexec teardown, runtime suspend, or driver
> unbind, the slave hardware stretches SCL low (0V) waiting for TX data,
> setting DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY.
> 
> In master mode, __i2c_dw_disable() issues DW_IC_ENABLE_ABORT to release
> the bus. However, according to the Synopsys DW_apb_i2c Databook, the
> ABORT bit applies only to master transfers and has no effect in slave
> mode. Because the slave cannot disable while stretching SCL,
> __i2c_dw_disable() times out, leaving DW_IC_ENABLE_STATUS[0] = 1 across
> kexec or rebind. Subsequent writes to DW_IC_SAR are write-protected and
> silently dropped by hardware, wedging the slave and blocking any other
> devices sharing the physical bus.
> 
> Fix this by:
> 
> 1. In __i2c_dw_disable(), if DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY is
>    set while disabling, temporarily re-enable the controller so the APB
>    interface accepts data commands without racing with the slave ISR,
>    clear pending RD_REQ/TX_ABRT interrupts, write a dummy 0xFF byte to
>    DW_IC_DATA_CMD to release the SCL stretch, and immediately request
>    disable via __i2c_dw_disable_nowait(). Also drain the RX FIFO if RFNE
>    is set during SLAVE_ACTIVITY.
> 
> 2. In i2c_dw_reg_slave(), replace __i2c_dw_disable_nowait() with
>    __i2c_dw_disable() to ensure the controller is fully disabled before
>    calling i2c_dw_set_mode(), which programs DW_IC_SAR and DW_IC_CON.
> 
> Fixes: 9f3e065c54b0 ("i2c: designware: add SLAVE mode functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Atif Ashhar <atifashhar@google.com>
> ---
>  drivers/i2c/busses/i2c-designware-common.c | 46 ++++++++++++++++++++++
>  drivers/i2c/busses/i2c-designware-slave.c  |  2 +-
>  include/linux/designware_i2c.h             |  1 +
>  3 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
> index a1eca6cd4b75..ae737928820c 100644
> --- a/drivers/i2c/busses/i2c-designware-common.c
> +++ b/drivers/i2c/busses/i2c-designware-common.c
> @@ -619,6 +619,50 @@ static int i2c_dw_set_sda_hold(struct dw_i2c_dev *dev)
>  	return ret;
>  }
>  
> +/*
> + * DW_IC_ENABLE_ABORT only aborts master transfers. If the adapter is acting
> + * as a slave and holding SCL low waiting for TX data (SLAVE_HOLD_TX_FIFO_EMPTY),
> + * hardware refuses to disable (IC_ENABLE_STATUS[0] stays 1) until a byte is
> + * written to DW_IC_DATA_CMD.
> + *
> + * Mask interrupts and temporarily set DW_IC_ENABLE_ENABLE so the APB interface
> + * accepts writes to the TX/RX FIFOs without racing with the slave ISR, clear
> + * pending RD_REQ/TX_ABRT interrupts, feed a dummy 0xFF byte to release SCL
> + * (or drain any pending RX byte), and immediately request disable again via
> + * __i2c_dw_disable_nowait() so the controller initiates disable upon
> + * completing the current byte.
> + */
> +static void i2c_dw_release_slave_hold(struct dw_i2c_dev *dev)
> +{
> +	unsigned int status, dummy;
> +	bool tx_hold, rx_pending;
> +
> +	if (!IS_ENABLED(CONFIG_I2C_DESIGNWARE_SLAVE) || dev->mode != DW_IC_SLAVE)
> +		return;
> +
> +	regmap_read(dev->map, DW_IC_STATUS, &status);
> +
> +	tx_hold = status & DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY;
> +	rx_pending = (status & DW_IC_STATUS_SLAVE_ACTIVITY) &&
> +		     (status & DW_IC_STATUS_RFNE);
> +
> +	if (!tx_hold && !rx_pending)
> +		return;
> +
> +	regmap_write(dev->map, DW_IC_INTR_MASK, 0);
> +	regmap_write(dev->map, DW_IC_ENABLE, DW_IC_ENABLE_ENABLE);
> +
> +	if (tx_hold) {
> +		regmap_read(dev->map, DW_IC_CLR_RD_REQ, &dummy);
> +		regmap_read(dev->map, DW_IC_CLR_TX_ABRT, &dummy);
> +		regmap_write(dev->map, DW_IC_DATA_CMD, 0xFF);

I'm not super familiar with the slave mode so adding Heikki just in case.
Can this cause some unintended traffic on the bus towards the master?

Also use 0xff instead.

> +	}
> +	if (rx_pending)
> +		regmap_read(dev->map, DW_IC_DATA_CMD, &dummy);
> +
> +	__i2c_dw_disable_nowait(dev);
> +}
> +
>  void __i2c_dw_disable(struct dw_i2c_dev *dev)
>  {
>  	struct i2c_timings *t = &dev->timings;
> @@ -676,6 +720,8 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
>  		if (!(status & 1))
>  			return;
>  
> +		i2c_dw_release_slave_hold(dev);
> +
>  		/*
>  		 * Wait 10 times the signaling period of the highest I2C
>  		 * transfer supported by the driver (for 400kHz this is
> diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
> index 0abcc7757b23..e51a6b60292a 100644
> --- a/drivers/i2c/busses/i2c-designware-slave.c
> +++ b/drivers/i2c/busses/i2c-designware-slave.c
> @@ -40,7 +40,7 @@ int i2c_dw_reg_slave(struct i2c_client *slave)
>  		return ret;
>  
>  	pm_runtime_get_sync(dev->dev);
> -	__i2c_dw_disable_nowait(dev);
> +	__i2c_dw_disable(dev);
>  	dev->slave = slave;
>  	i2c_dw_set_mode(dev, DW_IC_SLAVE);
>  
> diff --git a/include/linux/designware_i2c.h b/include/linux/designware_i2c.h
> index 53f37f18a722..113a9d84e34d 100644
> --- a/include/linux/designware_i2c.h
> +++ b/include/linux/designware_i2c.h
> @@ -100,6 +100,7 @@
>  #define DW_IC_STATUS_MASTER_ACTIVITY		BIT(5)
>  #define DW_IC_STATUS_SLAVE_ACTIVITY		BIT(6)
>  #define DW_IC_STATUS_MASTER_HOLD_TX_FIFO_EMPTY	BIT(7)
> +#define DW_IC_STATUS_SLAVE_HOLD_TX_FIFO_EMPTY	BIT(9)
>  
>  /* DW_IC_SMBUS_INTR_* bits */
>  #define DW_IC_SMBUS_INTR_ALERT			BIT(10)
> -- 
> 2.56.0.317.g454f8302e1-goog
