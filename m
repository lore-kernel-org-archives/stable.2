Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600515;
	b=yhpHLrrP56elcuMKain6O2FvDNJucjbl6r5rvprOWaPhO6tZRstHa+gRPMHaTXAaG4eR
	 ZvoGL+Ox4k60agvlCM21jE1WoHAAIrct4Nq2BAFA618Hgy7LiXUp95QpxlCmSViv+RWrp
	 KxfSh+Io9ovoZ3UQqW8hKce6cZuScLgXiBK2cxqHapoOuI9vZ6peawYLN16J728F1RcNY
	 uzV5HZ39CSD+rsthHdA8CCrHPa6uH6/s9uy0nbl5WSGf74y2UKI4fDrKN0wRKKNM0QlX5
	 yeSGV78pGJhtDEaYIGI0rFSK5fMT2Nv/x9HCuRjbosMLYPSKv5NVsanM5BsL2j9rkzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600515;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=040FOdqnpTNASkay7M14wcibzu+az+nvPJ9a+Cwpw/Q=;
	b=uerqDP3pqBQRI4cIHsuyU446FeC0TzGrqXDVA1TmoY5I4csvrrzjkRRRKt6mLUwRDfpB
	 UVTtqmpqSJOuR5rpeJEZ2eB8l0V6Azt2xSn7+2QL/GEtH7ps/IAvJ6uIfuE49kzMSI3Lg
	 qkBc2hXuOTmGCBV7xVS2SO1A5uWSGKwjhnn7OzHB8nPa8V4LV11fH9IGYlqjxCXEtLuQp
	 jVKTVomRTr7YFvzgEtGfQFt/EMbW0IayUK+Mi9+dO6ykEfAlpIZVWindqlx5H+2cY7Swp
	 2Vm0HM0SE+mXL2EGlMtWgQBepDSk+hJPopeshf9cKi91+gYVYw8Kqm5p06fmBmoqGHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i5NRnWww;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C7C606A329;
	Wed, 25 Nov 2026 09:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71C7C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i5NRnWww
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795600515; x=1827136515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Q9ObH0jG5UL8tjJetphdQtlshFhsvvHLNH8+nuFuwAU=;
  b=i5NRnWwwrUnLbM2oRn9KKz7TZpH4FC5+4znEOSEGkS/r7lvthG0fUu3N
   FsArcVUG0RapS6yTsoMR4CwzTyBRd72B8qtvfstQqKn4Ioah9EUI063Ew
   v/JUmKC1nUNcmU9cicbAi9jv7eUEfvZ1grc+h4E1j4ej5Y5UXqrSR5Vbo
   EJCfF/LVutLzFVBgQE/qpKAcSey4nOdjo4C689Ds0bK2ddThHfz8Vwpal
   yYaDsHneRtOn/SgnPutlRccN5CR6sqX/fb/wTIAkStwazzl/f29z9hgOd
   izJUEBZpUPxETrhPYwkCzlhfzyRuEGDcWtZOSCA4L0d7uXndoOw9CkK4a
   w==;
X-CSE-ConnectionGUID: mVO03WKgSYyberc+qYuaDw==
X-CSE-MsgGUID: YnviYn2nRM6wVcc7RK4tHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4384901"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4384901"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 01:53:54 -0800
X-CSE-ConnectionGUID: 4cNH+2CoR3W8LU1POLAoPw==
X-CSE-MsgGUID: 2ARkSPQQT5CvFBm3FVuIwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11720277"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 25 Nov 2026 01:53:52 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 539A598; Wed, 25 Nov 2026 10:53:50 +0100 (CET)
Date: Wed, 25 Nov 2026 10:53:50 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Juan Yescas <jyescas@google.com>,
	Amit Sunil Dhamne <amitsd@google.com>, kernel-team@android.com,
	linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: tcpm/tcpci_maxim: fix invalid wait
 context
Message-ID: <awawLjDE_AWj5Qkc@black.igk.intel.com>
References: <20261123-max77759-wait-v1-0-6fa54a751bb7@linaro.org>
 <20261123-max77759-wait-v1-1-6fa54a751bb7@linaro.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261123-max77759-wait-v1-1-6fa54a751bb7@linaro.org>

On Mon, Nov 23, 2026 at 01:03:06PM +0000, André Draszik wrote:
> Lockdep reports the following with CONFIG_PROVE_RAW_LOCK_NESTING=y:
> 
>     [ BUG: Invalid wait context ]
>     swapper/0/0 is trying to lock:
>     (&dev->power.lock){-...}-{3:3}, at: pm_wakeup_dev_event+0x38/0x80
>     other info that might help us debug this:
>     context-{2:2}
>     locks held by swapper/0/0: 0, on CPU#0
>     Call trace:
>      _raw_spin_lock_irqsave+0x60/0x98
>      pm_wakeup_dev_event+0x38/0x80
>      max_tcpci_isr+0x2c/0x58 [tcpci_maxim]
>      __handle_irq_event_percpu+0xc4/0x4d8
>      handle_irq_event+0x4c/0x100
>      handle_level_irq+0xe8/0x188
> 
> max_tcpci_isr() calls pm_wakeup_event(), which acquires two spinlocks
> (spinlock_t): dev->power.lock and the lock of the device's wakeup
> source. On PREEMPT_RT, spinlock_t turns into a sleeping lock. Since the
> interrupt is requested with IRQF_ONESHOT, max_tcpci_isr() is never
> force-threaded and runs in hard irq context even on PREEMPT_RT. Taking
> a sleeping lock in hard irq context is invalid, triggering the lockdep
> report above.
> 
> Move pm_wakeup_event() to the interrupt thread max_tcpci_irq() instead.
> Drop max_tcpci_isr() altogether, since its chip->port check is already
> duplicated in max_tcpci_irq(), and request the interrupt without a
> primary handler.
> 
> Note: Moving pm_wakeup_event() to the interrupt thread doesn't allow
> the system to suspend before the event is reported:
> suspend_device_irqs() uses synchronize_irq() to wait for the interrupt
> thread to finish, and pm_wakeup_pending() is checked after
> suspend_device_irqs() returns. Once suspend_device_irqs() has armed the
> wake interrupt, the interrupt core reports the wakeup itself and
> doesn't call the driver's handlers.
> 
> Fixes: 6f413b559f86 ("usb: typec: tcpci_maxim: Chip level TCPC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> index a19f52515429..6e202171f57a 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -411,6 +411,8 @@ static irqreturn_t max_tcpci_irq(int irq, void *dev_id)
>  	irqreturn_t irq_return = IRQ_HANDLED;
>  	int ret;
>  
> +	pm_wakeup_event(chip->dev, PD_ACTIVITY_TIMEOUT_MS);
> +
>  	if (!chip->port)
>  		return IRQ_HANDLED;
>  
> @@ -430,18 +432,6 @@ static irqreturn_t max_tcpci_irq(int irq, void *dev_id)
>  	return irq_return;
>  }
>  
> -static irqreturn_t max_tcpci_isr(int irq, void *dev_id)
> -{
> -	struct max_tcpci_chip *chip = dev_id;
> -
> -	pm_wakeup_event(chip->dev, PD_ACTIVITY_TIMEOUT_MS);
> -
> -	if (!chip->port)
> -		return IRQ_HANDLED;
> -
> -	return IRQ_WAKE_THREAD;
> -}
> -
>  static int max_tcpci_start_toggling(struct tcpci *tcpci, struct tcpci_data *tdata,
>  				    enum typec_cc_status cc)
>  {
> @@ -538,7 +528,7 @@ static int max_tcpci_probe(struct i2c_client *client)
>  
>  	chip->port = tcpci_get_tcpm_port(chip->tcpci);
>  
> -	ret = devm_request_threaded_irq(&client->dev, client->irq, max_tcpci_isr, max_tcpci_irq,
> +	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL, max_tcpci_irq,
>  					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), dev_name(chip->dev),
>  					chip);
>  	if (ret < 0)
> 
> -- 
> 2.56.1.750.gf70dc682cf-goog
> 

-- 
heikki
