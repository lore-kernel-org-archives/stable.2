Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179128;
	b=5l3SBbQ2YXhynC3/8cCsis6sOBWBujqB6trXJnwS4bQsL67YLepdQBSFH8imCRS2rdQG
	 9R6bnaHBFtexXPuHFuCf2S5JM/lxGE6/mDlzPcHGlv+5HcuSwsCzu6+udDU7T+0JA6OAC
	 LOBqQD165+uv6nUtycZM94L0P2Xo+epCiCP1RNAkMTHBjaPKdhxiyOzPEMZr9ItF/Qrc5
	 gsdWH8xFNi6Ej+/u0mM3o1Fl/+3oRmQOTcg0U3768NYgFBc64BF5ZaNE36uACwGinmz5T
	 iDZg9P/7gS9LK7xnl3IDMXgMk2HtfB1idfE+nWqXRMzU4NwFTvgNUAIp4K+QZ6dcBFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179128;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NleNAGBpwDLYHMnTJho5Ff1F01uR68kWg4mKc/YYzG4=;
	b=hQT7+NPzC4vSfgAbaTorBPxI8jdj67a1toE+q90TJFEJiAZk7pzR99/nNpNDpDSao2HE
	 WIrNG0M1tT7/d/RGAuN5CXDrRUIO+MTtsfT282fbS8PKQ5U0cwH/aM1+8Q7fkNNpohrH1
	 nPKU5PXEiazwN68S5UEHwj3gYJU5az7ApPI0xKrKSPzJCHlFeGSUHQIceOKAYw6WCt5N3
	 KnD76eKHnMKbKJPxShYm1s512FgwjiZiuvHgFryQZFexB34292YbeE+2dcw7YtOR37FAq
	 xi488mdChRncSMwboUPrSk3F7tWsr1HsaU6KqFcQT94UWK2qiO3WOVSTv82L18wyfzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ShDh4F/t";
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFEF606A320;
	Fri, 20 Nov 2026 12:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BFEF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ShDh4F/t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795179128; x=1826715128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oRsMfGOGJCDM2bFiwqpgxiyol8Y8Ruky6SMqqAiGSiE=;
  b=ShDh4F/tqdx8VaoUV1LY7JRu9lr2TZTVGFiTDqKDbvpkcT7whCkuQOku
   Llvc4idAyYf3dZ3W215yokVVr7Vw/qcPnizUw7+TJFS0W0nlUoq6GwiTp
   QOGGSGCQt26klQG9satWuzc6sBtuCs4Ml/H6G8/CqhhJppxSnlos1SB1j
   gyRqU1mjjo0Una1/ePGQP+o3ctBo/FU1G854vZsqoN2c0fiVTUg2vhIRp
   gg0D6Ah1MAkHuPDzHaHcSqN7/eZ9OODbfHT71Z2J6ifsTxPg19FO1Iv3I
   I8W01WTbJxRYbtnxTRDoEpzizaHorITCXcx8a2VHuGwcWfsTVW+cDgv1X
   A==;
X-CSE-ConnectionGUID: 6wx6yEkxScGLwZLrYXvW6Q==
X-CSE-MsgGUID: h3veYJixR9C0sJOXcVzKgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3972123"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3972123"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 04:52:07 -0800
X-CSE-ConnectionGUID: M9qPvv5KSxejhozI3CUVzw==
X-CSE-MsgGUID: MITR5MhgSVCHrO/InrDD+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="11053530"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 20 Nov 2026 04:52:04 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id EAD5F99; Fri, 20 Nov 2026 13:52:02 +0100 (CET)
Date: Fri, 20 Nov 2026 13:52:02 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Atif Ashhar <atifashhar@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Wolfram Sang <wsa@kernel.org>,
	Luis Oliveira <Luis.Oliveira@synopsys.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: designware: Release slave SCL hold in
 __i2c_dw_disable()
Message-ID: <awBCclrtdWSNHl67@black.igk.intel.com>
References: <20261104133745.1432212-1-atifashhar@google.com>
 <20261112145238.3736264-1-atifashhar@google.com>
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
In-Reply-To: <20261112145238.3736264-1-atifashhar@google.com>

On Thu, Nov 12, 2026 at 02:52:38PM +0000, Atif Ashhar wrote:
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
>    clear pending RD_REQ/TX_ABRT interrupts, write a dummy 0xff byte to
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

I don't have time to test this unfortunately :( But it LGTM. FWIW, if
it's okay by Mika:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since v1:
> - Use lowercase 0xff instead of 0xFF in regmap_write(), comments, and commit
>   message (Mika Westerberg).
> - Explained on the v1 thread why writing a dummy 0xff byte to DW_IC_DATA_CMD
>   does not generate unintended bus traffic when immediately followed by
>   __i2c_dw_disable_nowait().
> 
> Link: https://lore.kernel.org/linux-i2c/20261104133745.1432212-1-atifashhar@google.com/ [v1]
>  drivers/i2c/busses/i2c-designware-common.c | 46 ++++++++++++++++++++++
>  drivers/i2c/busses/i2c-designware-slave.c  |  2 +-
>  include/linux/designware_i2c.h             |  1 +
>  3 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
> index a1eca6cd4b75..46866baa9d9c 100644
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
> + * pending RD_REQ/TX_ABRT interrupts, feed a dummy 0xff byte to release SCL
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
> +		regmap_write(dev->map, DW_IC_DATA_CMD, 0xff);
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
> 2.56.0.567.gdb80ae8cd5-goog

-- 
heikki
