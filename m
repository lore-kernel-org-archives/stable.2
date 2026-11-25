Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600505;
	b=3sUzv7TO5CjBTe73RbNGQHdwPaG9Ft41r/PIlAiOdZ6LLjyt6ahQKqTWK8xi9SQzTq1w
	 3jSyhRWWrlbBNgWI0hfdjI6wxtyBXLTAG9p2bDcKBiJCN8X5QCsTaHp0veAlKFBv/IMQi
	 9etyCw+t4f5le/YUFzUHefM14jE5MKMmTA5avJ7r47h6iFOFlob/73K3ttPdHNI9y8sEt
	 xKhJ0J6kRa0TA/vWQb8os7k0oHhRJDlNlcit/ukTF/1uC/vBy9kYMI7fMKoG6LRol6coq
	 wUVvoIRXFSQoh+HdDEZaTo5eWKZC3VsvH8f9boH2LMoCLlv7jdIuNyYFkFV0ofSvSXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600505;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=23A6Rapc9OJA728oCv5yZ/rNwc86GAIb2CFho1UI3xo=;
	b=B7Z1w57PptJbxP4uaSqg+2slhv/LJGUjzJbEvm38BbtzMm1NSwlfTz4BJPJ/poc6nbfu
	 4VnckHM/SaTTkxPPiedtQafbV0bKmBdZg0U24AEibHqYGfEsEgTGwTDF+T0t0/xyFRH/r
	 +xD6RAYoHZDMet62EsV3d+vAxa8hxLTszYA1meuZ2NZ307+EcJsQV1GcV+41GkeTOWGou
	 9Y6lNTzKuRA7aptzM7rXezgtK/n1ls1Rng6j9q1x1FsiJhXVHyDLpJV13ltuKD3Lpguq+
	 sfWxbO3JG6D3pKo6rwwUy+XSHumZ/k+EbVy1NGmNxQpa1YI/DxONe355AQARGwI4dbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ONbYBuOk;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8445606A31E;
	Wed, 25 Nov 2026 09:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8445606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ONbYBuOk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795600505; x=1827136505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xv0jn623MXDtX5o3iA9r3WdbV+vh52UkWWWP/m0Z5pE=;
  b=ONbYBuOkA/0iIFiB7QAfVmFwGoN5zfuWY/PZMcnwO4ACcv9B5zhW43qr
   fLjnCUfcE0KZcBXg9DSX4Jpiaye3RQUqDuZvwnORMbXfmgKJfOkmk6jAv
   gXnV/+6+gtMFeYb7SiP1jHymByIViRS9dyqgAgy4noHKVJ5btlV91Cd5V
   Bx3F20imDyKpSy7HG660ohxf4qORHTiNOEyw33YPYVMI9B9Sskn9ELjDh
   i262bUEdxwSQYNPVUI/7AwPym52l6cJiuopHpfFKOEO+M8LfJTtQ4RkpF
   DxFWIfdQcGdhKTcsZljPuZWMKKRNLFWhq3yFdoEzx+kEEdEflV+l8UknY
   A==;
X-CSE-ConnectionGUID: 6/GNhg1FSa6zT7x67ro+sQ==
X-CSE-MsgGUID: CxaBmIrrTUew4Id0AcQllw==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4509993"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4509993"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 01:55:04 -0800
X-CSE-ConnectionGUID: jL89jCuSRuufP+MKITSw7g==
X-CSE-MsgGUID: WzZ0tPeVSjKlkv1Zawcr9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11824548"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 25 Nov 2026 01:55:01 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id EC15398; Wed, 25 Nov 2026 10:54:59 +0100 (CET)
Date: Wed, 25 Nov 2026 10:54:59 +0100
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
Subject: Re: [PATCH 2/2] usb: typec: tcpm/tcpci_maxim: init wakeup before irq
Message-ID: <awawc7aqPfzDhirq@black.igk.intel.com>
References: <20261123-max77759-wait-v1-0-6fa54a751bb7@linaro.org>
 <20261123-max77759-wait-v1-2-6fa54a751bb7@linaro.org>
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
In-Reply-To: <20261123-max77759-wait-v1-2-6fa54a751bb7@linaro.org>

On Mon, Nov 23, 2026 at 01:03:07PM +0000, André Draszik wrote:
> max_tcpci_probe() requests the TCPC interrupt before it initialises
> the wakeup source of the device. Since the interrupt is level
> triggered, an already asserted alert can trigger the interrupt handler
> before devm_device_init_wakeup() is called. Its pm_wakeup_event() does
> nothing while the device has no wakeup source, so the wakeup event of
> such an early interrupt is not recorded, meaning the system is then not
> prevented from suspending for PD_ACTIVITY_TIMEOUT_MS while handling
> that alert.
> 
> When the driver unbinds, devres works in reverse order and in this case
> removes the wakeup source before it frees the interrupt, which leaves a
> similar window.
> 
> Call devm_device_init_wakeup() before devm_request_threaded_irq(), so
> that the wakeup source exists for as long as the interrupt handler can
> run.
> 
> Fixes: 6f413b559f86 ("usb: typec: tcpci_maxim: Chip level TCPC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: André Draszik <andre.draszik@linaro.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpci_maxim_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> index 6e202171f57a..2bb306b6b1f9 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> @@ -528,16 +528,16 @@ static int max_tcpci_probe(struct i2c_client *client)
>  
>  	chip->port = tcpci_get_tcpm_port(chip->tcpci);
>  
> +	ret = devm_device_init_wakeup(chip->dev);
> +	if (ret)
> +		return dev_err_probe(chip->dev, ret, "Failed to init wakeup\n");
> +
>  	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL, max_tcpci_irq,
>  					(IRQF_TRIGGER_LOW | IRQF_ONESHOT), dev_name(chip->dev),
>  					chip);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = devm_device_init_wakeup(chip->dev);
> -	if (ret)
> -		return dev_err_probe(chip->dev, ret, "Failed to init wakeup\n");
> -
>  	return 0;
>  }
>  
> 
> -- 
> 2.56.1.750.gf70dc682cf-goog
> 

-- 
heikki
