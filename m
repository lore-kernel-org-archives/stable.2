Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983380;
	b=GTjPGUUGqtwhs0d6anHlY1N++IELoH8pNCKb25/UaJEK2IrLUuJ/e0BxBy8JoaoXrB5a
	 Fv4EqpbeMtyqgTRTQ7MQ4xI3Ic5MuTOIQX4ZQPkXfapJZ2NOIw7pBIDXZ71oxqjkjYZc2
	 TWN9spQeSO/hv7lLRuL0UxLxcF8qXTcrkJdThj89JOhM609HblSICddk4G0Xk20hZuWZM
	 bUZDw0rsXUSWKv9KW2/azGzQiue85lO7p542NuCTMJUedBzIWT9mYaxNteNOw84+Vhp/8
	 JGM0cuMuELK8ts2oZ2zyfUOv7GWNEMt41STwHPX3q3W1ScJirLKhHOd8RYQIptm39+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983380;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=sOSTmZKcrJ1kJMPBeiZzfbNHAaw+xN5ssuPT1uHWyXE=;
	b=PxHvAeMi8P0lEUEKgUQG9LVfIehsx6ubxoMii0v6lB391E5FAdesXtKHdWAduNYaqkCI
	 Mc34192dMCO8RSirl48i/4wZGppDGLTmThR4wc5HsWtFAjghQyHIWPZvgsbYc1gB2Y3PV
	 p7hpUUH+wRPVfFs6FjN1sC6pNWdPKRhPQINlqA5vY+KsPaPbN8HheuaB9Nt0GiSam61DP
	 9bbZqQhTY7BzQzE/99MPgVNapcggdtqAPiJDEwz+U/fznph8BViWfwwCoERO4waB45lrO
	 r1NDFXDhPSGWTWnfjbTv8Hg5lR/vc4erjzgC1C+rH5qHF4rvqIcVyjF8PmgJz/Xf12w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OfKfcCJu;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627BF606A326;
	Fri,  6 Nov 2026 16:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 627BF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OfKfcCJu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793983381; x=1825519381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DtSzl4OkluS1AquIQlPMXdHmZEU1A74G5s2HtG/AMYY=;
  b=OfKfcCJu+UKgaDTLw8R/sSrBnZ1J4c+CMzhv/B6ZkMWw+sPcrGD1fafs
   RL1a5obKXJiDax5M6TqKBtmRk9SVorO6yjq/w0VnBzJzBqZ5DiYBiAAaL
   zHPQMgcjNLQbJsroNwrYl+b4r7oA6a3wCCOo1+hcwCdmrZjaNHyTZEtjQ
   6lNUpn/p1od4DXyubLt9+mcfCjOQPOVGu3Xon8ft95OvXZ5UEV9er3Uw/
   G272RGOAlkUme2mXjm3kGg4XrlBIDux87byp+OARPN+G0hUdSjUKB4McO
   QmQxXF6nM57RTP9DxMcJaj5hIq22z5CCP9MPlgqM9DRIWeQ8PtmJRv1OL
   A==;
X-CSE-ConnectionGUID: IWkc9kqQTlSa/OPtASAeOA==
X-CSE-MsgGUID: 5Z4vJdz6Q6+0KFVHCcoEng==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2832121"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2832121"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:43:00 -0800
X-CSE-ConnectionGUID: 5kTaVGYwRrOE2rN5egO1BQ==
X-CSE-MsgGUID: ASPBrMcTQrOOcy2RCl6P+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7747948"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 06 Nov 2026 08:42:58 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id E1E3699; Fri, 06 Nov 2026 17:42:56 +0100 (CET)
Date: Fri, 6 Nov 2026 17:42:56 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: kernel@resetko.pl
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Pearson <mpearson-lenovo@squebb.ca>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] usb: typec: ucsi: acpi: Rename the Acer zero
 version quirk
Message-ID: <au4DkMViEzQEHLHd@black.igk.intel.com>
References: <20261103-ucsi-lenovo-t14g2a-v2-0-e85c659b56a2@resetko.pl>
 <20261103-ucsi-lenovo-t14g2a-v2-1-e85c659b56a2@resetko.pl>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261103-ucsi-lenovo-t14g2a-v2-1-e85c659b56a2@resetko.pl>

On Tue, Nov 03, 2026 at 05:10:20PM +0100, Stanisław Titenko via B4 Relay wrote:
> From: Stanisław Titenko <kernel@resetko.pl>
> 
> The quirk added for the Acer Nitro ANV15-41 is not specific to that
> machine: it substitutes UCSI 1.2 when the firmware reports a zero
> version, which other platforms with the same firmware bug need too.
> 
> Rename ucsi_acer_read_version() and ucsi_acer_ops to
> ucsi_zero_version_read_version() and ucsi_zero_version_ops, so that
> they can be shared with other machines.
> 
> No functional change.
> 
> Cc: stable@vger.kernel.org # needed by the next patch
> Assisted-by: pi:claude-opus-5-5
> Signed-off-by: Stanisław Titenko <kernel@resetko.pl>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 5697ccc24ec3..47ba0e15b8ba 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -121,7 +121,7 @@ static const struct ucsi_operations ucsi_acpi_ops = {
>  	.async_control = ucsi_acpi_async_control
>  };
>  
> -static int ucsi_acer_read_version(struct ucsi *ucsi, u16 *version)
> +static int ucsi_zero_version_read_version(struct ucsi *ucsi, u16 *version)
>  {
>  	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
>  	int ret;
> @@ -138,8 +138,8 @@ static int ucsi_acer_read_version(struct ucsi *ucsi, u16 *version)
>  	return 0;
>  }
>  
> -static const struct ucsi_operations ucsi_acer_ops = {
> -	.read_version = ucsi_acer_read_version,
> +static const struct ucsi_operations ucsi_zero_version_ops = {
> +	.read_version = ucsi_zero_version_read_version,
>  	.read_cci = ucsi_acpi_read_cci,
>  	.poll_cci = ucsi_acpi_poll_cci,
>  	.read_message_in = ucsi_acpi_read_message_in,
> @@ -194,7 +194,7 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Nitro ANV15-41"),
>  		},
> -		.driver_data = (void *)&ucsi_acer_ops,
> +		.driver_data = (void *)&ucsi_zero_version_ops,
>  	},
>  	{
>  		.matches = {
> 
> -- 
> 2.56.0
> 

-- 
heikki
