Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795595667;
	b=spa9bUQgbmJmmK7aMPVJElMqxSIsbJr58UX39XbpQokcH+JBjEqO0Alvu0AJtOJVmQAF
	 VYSab2HSMD+ZBJTqcZSfwL6a2Kc9KosfUvdhhKDiY+NMlbf++7CUZ5JDeB1ww/R+vTrcJ
	 hL467apWVDEuf+rKrGkV+QQ3iei+7rYWpfRiri2wts/HVhWHaAu7UnxQIjZyjtkL8EsTC
	 5TYzyYKXWZA9AE3GOGBnfo6OSh7+m8gbqELrsKvRlk6orEJRvHpuEIwfMop5Pwyw9vejS
	 iDBDR30sam9KMk9LFbFojnvZYORWB8y8QSzy7lHr+S6OF2TJ8a0s+c+I5yE0kjiMLVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595667;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=QRiCR31grahnQuxKJ1Kl3FMIoePJi6t96xJxUnOrkx4=;
	b=s4krYpFxe0h/xCaQ7EWI2a9TTvl8DkGSRn0gv3zMCiKSF27ru37Knrp6MN/xX211g9Yj
	 FjTJxQwWnfNoEy4VyObnxjnXnCsxrD3ioZLl9PjQAP06nZXlkJaLWR2eqhYTFhJmzkwRz
	 7e/uqfb6OYI59vl6H3cliItEDvYCNRr0ZkZ6isFwOHzTu2JnhfsKnuYr5V6x0heBsmY4i
	 +tMky8EafdkKzpdusbPLC5dfA8osfubwWGS8acXqUNXZTiyA/Y3fmFjkpv8MaA6gDA5jz
	 REpXAeG4IJ9iRcOkK6m5PJestESxz4WKbgaEdMHhdyIKK2Z30MupfWYQrm8dYrGgmWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ebBasl13;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AC7606A321;
	Wed, 25 Nov 2026 08:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4AC7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ebBasl13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795595667; x=1827131667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B42DmryMhrT1xZx2QWPexbDfS2ooFBeHjiGyMkp5OmU=;
  b=ebBasl13Id7fkyP55Q3kKMXsj3iTZ8xKwSD/eLjkU2JuuazKz7zoZV9k
   2C45F5oEi1K6Vx0XWF1cPu3useG8dPRD7K0PGuZ+lC/+URHY4Ors8rGCt
   dQYz8TkdOfaaSKWe+zy+mA4s18782AAErcV+BIC5CLHyMIexBwoLDrI/+
   m9xYkng9sjEZY3LPC5fXb4unrBCWwhzRNlZLpXVa71DEWx5O9VDQ7Pr7D
   G83hsS0Q6MZuGlXWxAtGpY+vfQ1N7k1zjMPqTc1yzV6Y1g4qEq9yF2Qbc
   7aqEgO0Lx5iJe4z7Zhusdj7u3kJbg0SLMYGiqPpSU61tVZhF3aeJMMkEQ
   Q==;
X-CSE-ConnectionGUID: su2fkOWoRhG7tFTzX7i51Q==
X-CSE-MsgGUID: ZbQOkgHHQy2A7EUOcH7lJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4341233"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4341233"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 00:34:26 -0800
X-CSE-ConnectionGUID: rquprSAIQuWVEKVOKKdvSQ==
X-CSE-MsgGUID: QK5jFyXzQuycaspge9YnKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="12006002"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 25 Nov 2026 00:34:25 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 2D05498; Wed, 25 Nov 2026 09:34:23 +0100 (CET)
Date: Wed, 25 Nov 2026 09:34:23 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Badhri Jagan Sridharan <badhri@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <groeck@chromium.org>, linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: tcpm: unregister partner altmodes before
 re-discovery
Message-ID: <awadjwZUgA_U7ySC@black.igk.intel.com>
References: <20261120-topic-tcpm-core-fixes-v1-0-c753d1d286bb@linaro.org>
 <20261120-topic-tcpm-core-fixes-v1-1-c753d1d286bb@linaro.org>
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
In-Reply-To: <20261120-topic-tcpm-core-fixes-v1-1-c753d1d286bb@linaro.org>

On Fri, Nov 20, 2026 at 10:56:16AM +0100, Neil Armstrong wrote:
> svdm_consume_identity() clears port->mode_data when a Discover Identity
> ACK is received. mode_data.altmodes is also the count used to walk
> port->partner_altmode[] when unregistering the partner alternate modes,
> so if the partner altmodes from an earlier discovery are still
> registered, clearing it leaks them and the following Discover Modes
> round registers a second set for the same partner.
> 
> Unregister the partner altmodes before clearing mode_data, and reuse
> the new helper in tcpm_unregister_altmodes().
> 
> Cc: stable@vger.kernel.org
> Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
> Assisted-by: LLM
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index bb90211660ca..1d007e59a2bf 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2060,6 +2060,17 @@ static int tcpm_queue_vdm_unlocked(struct tcpm_port *port, const u32 header,
>  	return ret;
>  }
>  
> +static void tcpm_unregister_partner_altmodes(struct tcpm_port *port)
> +{
> +	struct pd_mode_data *modep = &port->mode_data;
> +	int i;
> +
> +	for (i = 0; i < modep->altmodes && i < ALTMODE_DISCOVERY_MAX; i++) {
> +		typec_unregister_altmode(port->partner_altmode[i]);
> +		port->partner_altmode[i] = NULL;
> +	}
> +}
> +
>  static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
>  {
>  	u32 vdo = p[VDO_INDEX_IDH];
> @@ -2068,6 +2079,7 @@ static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
>  	if (cnt <= VDO_INDEX_PRODUCT)
>  		return;
>  
> +	tcpm_unregister_partner_altmodes(port);
>  	memset(&port->mode_data, 0, sizeof(port->mode_data));
>  
>  	port->partner_ident.id_header = vdo;
> @@ -5129,10 +5141,7 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
>  	struct pd_mode_data *modep_prime = &port->mode_data_prime;
>  	int i;
>  
> -	for (i = 0; i < modep->altmodes && i < ALTMODE_DISCOVERY_MAX; i++) {
> -		typec_unregister_altmode(port->partner_altmode[i]);
> -		port->partner_altmode[i] = NULL;
> -	}
> +	tcpm_unregister_partner_altmodes(port);
>  	for (i = 0; i < modep_prime->altmodes && i < ALTMODE_DISCOVERY_MAX; i++) {
>  		typec_unregister_altmode(port->plug_prime_altmode[i]);
>  		port->plug_prime_altmode[i] = NULL;
> 
> -- 
> 2.34.1

-- 
heikki
