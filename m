Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2273DD861;
	Mon, 13 Jul 2026 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933537; cv=none; b=EukVUJ6Baz2lmRdpa9MSZI7BK5cwbj6I84z4GIbm+iMe46DqP0JQyJtPey9EW9kSKcZIplyzd5ebtNIJrabqRtgLNKgQcZuJpWG1CU7j5y6/pL6gFvH3zbyLXmiyF78u+J8kXK3qUiKkWZyc6qIxYxbrcKlnE4h80hxGsFHYoCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933537; c=relaxed/simple;
	bh=4gib2vhDzLFQ7tnF4IVPav8LHJ2wHdR4rw+1RbpRt2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyR7F5OUyq9NrJNjU7GCueDfemZtH0acxmY0S1XmG+tQeYIy1sLVtG2U7iisOqg/TQ0A2zpB7h1ptqjlM1sR6btQFs6KAx0u8jieHJaE9K81B3IjzdMFTl9ueBgCpa8DJY1QVZHVny+UPnVMaCzoKfsb/7yqTP9qcnFBv1OWEPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggbSnCU0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggbSnCU0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783933536; x=1815469536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4gib2vhDzLFQ7tnF4IVPav8LHJ2wHdR4rw+1RbpRt2Y=;
  b=ggbSnCU01L5bua3lFU/7OZRUx4cB7E5QRiH/E0iB31gNwbU3GjSZQEyx
   vgEgECZl4vX6K1dkknRYpRU5/pankbIkkg+2rVQM858XFDI3J2oaln4Et
   KcCToyFL9m6cdf/yXwbzPmA22mMDRvAkX8w3HlK005fjew/0KeUo5erqx
   MCZGL3KgusFc463AFfLrq/34wIogrEFpbrO2iWKbMs9YQwkb8bafGaxjQ
   s/YhY/Pdx7p9i86nr9AfuwzJz4j8TPwIycF+R7AxCl5xiqDUC5tqRntHb
   sITEi03bXd4JMdJQ1D3Wt81EGSsfzG5IShY7pYR218QiqrIu+c0bk4PdO
   A==;
X-CSE-ConnectionGUID: bR2TUSxaTrqqZlX2E+Ye/w==
X-CSE-MsgGUID: XP21mTV9ThezTRGdZ33ITA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88441025"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88441025"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 02:05:35 -0700
X-CSE-ConnectionGUID: +pIAPZXJQZGfQt6aRdDuGw==
X-CSE-MsgGUID: RlnR+4xtTdWaPqF/Bzs1WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="259793879"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 13 Jul 2026 02:05:33 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id F0D0295; Mon, 13 Jul 2026 11:05:11 +0200 (CEST)
Date: Mon, 13 Jul 2026 12:05:10 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH v2] usb: typec: tcpci_rt1711h: unregister TCPCI port with
 devres
Message-ID: <alSqRrKPCqrjufv1@kuha>
References: <20260706145312.37260-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706145312.37260-1-mhun512@gmail.com>

On Mon, Jul 06, 2026 at 11:53:12PM +0900, Myeonghun Pak wrote:
> rt1711h_probe() registers the TCPCI port before requesting the interrupt
> and enabling alert interrupts. If either of those later steps fails, the
> probe function returns without unregistering the TCPCI port. The explicit
> unregister currently only happens from the remove callback.
> 
> Register a devres action immediately after tcpci_register_port() succeeds,
> so tcpci_unregister_port() runs on later probe failures and on driver
> detach. Drop the remove callback to avoid unregistering the same port
> twice.
> 
> This issue was identified during our ongoing static-analysis research while
> reviewing kernel code.
> 
> Fixes: 302c570bf36e ("usb: typec: tcpci_rt1711h: avoid screaming irq causing boot hangs")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2:
> - Add Cc: stable@vger.kernel.org.
> 
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index a8726da6fc71..20037ef130ca 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -298,2 +298,4 @@
> +static void rt1711h_unregister_tcpci_port(void *tcpci);
> +
>  static int rt1711h_probe(struct i2c_client *client)
>  {
> @@ -339,7 +341,11 @@ static int rt1711h_probe(struct i2c_client *client)
>  	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
>  	if (IS_ERR_OR_NULL(chip->tcpci))
>  		return PTR_ERR(chip->tcpci);
> +
> +	ret = devm_add_action_or_reset(chip->dev, rt1711h_unregister_tcpci_port, chip->tcpci);
> +	if (ret)
> +		return ret;
>  
>  	ret = devm_request_threaded_irq(chip->dev, client->irq, NULL,
>  					rt1711h_irq,
>  					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> @@ -357,11 +363,9 @@ static int rt1711h_probe(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static void rt1711h_remove(struct i2c_client *client)
> +static void rt1711h_unregister_tcpci_port(void *tcpci)
>  {
> -	struct rt1711h_chip *chip = i2c_get_clientdata(client);
> -
> -	tcpci_unregister_port(chip->tcpci);
> +	tcpci_unregister_port(tcpci);
>  }
>  
>  static const struct rt1711h_chip_info rt1711h = {
> @@ -394,7 +396,6 @@ static struct i2c_driver rt1711h_i2c_driver = {
>  		.of_match_table = rt1711h_of_match,
>  	},
>  	.probe = rt1711h_probe,
> -	.remove = rt1711h_remove,
>  	.id_table = rt1711h_id,
>  };
>  module_i2c_driver(rt1711h_i2c_driver);
> -- 
> 2.47.1

-- 
heikki
