Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984088;
	b=n+tjvDa6KUP/SAXnuHWurZ2RxLZdVI8tGeog7lZMRW5QFfzBJJdNStcXTegh6hK6s7iq
	 5KdeTIbIKXREZ9Eh2mpCX96bipdL5MZsuMFMfCCa3X9Fi4jkTAla1xnX3PIF+NIve8aB1
	 IYQSzBXUCZQBlV3+KmfaNGN0JXk0efZAogaWDrPCRAmUTRvmOfBCixB0NWaDL/67EGeFE
	 61vByCMW1DR6jCy2FQvOAT+PaoY3BL773f0cet919zGv42LjrUbQ8Ut3Atg5ZYAPeTFud
	 OUA0Ea15fc5vb2uXs0/33/t5iQWjrR9OKVuW4FG9Rcy8iIHW3scYP60UGOfIQLod/eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984088;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=aMkNODpgmrATQj9IJM1uUkWpNaC4E1VN8irZG6ufRFk=;
	b=lkH03iaMyiztI3F/JWdUimAttzj8BXU/slStmO1YmbzPoYqyA596aJ+0Q5z0K8mC+DOw
	 NhGYxFoWkrNVFkWR6MhfLUedRZuJEKExwb30ALlsqkhQbDioMhUjKgV7aFtaGaJ+KP3xu
	 GtuGeZrMTSkcXQwVjh4O7zdMt9iVHXUyVLZar0/Up/bU2tyrgKyXM8nVRp0U0e+sgSK23
	 Pe9Nf5uBi15wo3R4SX7XHeM/7mF6m8yyFVgxqgYM9bEJ3UJ4bbY6LCE1b/zH3x1vb+qfA
	 L5asO8cqqAiqiSm+xtvEb4nfUSf8dNke16M6E7QEp/KvmFb0rGD+cOiHnhm0jiMarLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dVhij0Vq;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB2606A333;
	Fri,  6 Nov 2026 16:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4CB2606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dVhij0Vq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793984087; x=1825520087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=2eYSqUY3MBYHNEI7ajOhy1qNC3zyWNYaIFvCKPEt7QI=;
  b=dVhij0Vq7LRlhEH2mjlAU+NcrfmlBX2BSCum1u+ayfKBClAdCIWxxJ0+
   XOxxgatCoSPjCb230iqZ+BCtpKoNjz3h0sQoauaCFB64Z1lgARQ1zAnX8
   8LxwpetGN0+i9D2AlyWRmpC8gbQ3RWLLa7yWr92AMZBJdFx4Ezf39/4Ij
   s5vRAZBRKvCJpOem1wuGsdqsn90PJifSP630qZr4l09/sYe69RqCUMwK7
   mY9B/lXL5FHqFwWZ5OqAIOXQk53jLjx2mSczZUh/nY57630nKD80MWqAm
   P1kzUnLhYsohQK7oZBRQE7nJg+xYg3RB/Rd+lqLcZlVmiCoc33PFHMLqK
   A==;
X-CSE-ConnectionGUID: CXKo7q3LTeSvQ3oKqeEZ5w==
X-CSE-MsgGUID: 7aniMfXaToOuk0LXcl7chQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2839675"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2839675"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 08:54:46 -0800
X-CSE-ConnectionGUID: sKufzv3BQouUdvVh1X1Dsg==
X-CSE-MsgGUID: uIddZaQJSsebZHvi4d2y7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7182453"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 06 Nov 2026 08:54:44 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id ED21E99; Fri, 06 Nov 2026 17:54:43 +0100 (CET)
Date: Fri, 6 Nov 2026 17:54:43 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: kernel@resetko.pl
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Daniel Dev <daniel.dev@noex.uk>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: ucsi: acpi: Assume UCSI 1.2 on Lenovo
 ThinkPad T14 Gen 2a
Message-ID: <au4GUwhJz1jxYnqF@black.igk.intel.com>
References: <20261103-ucsi-lenovo-t14g2a-v2-0-e85c659b56a2@resetko.pl>
 <20261103-ucsi-lenovo-t14g2a-v2-2-e85c659b56a2@resetko.pl>
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
In-Reply-To: <20261103-ucsi-lenovo-t14g2a-v2-2-e85c659b56a2@resetko.pl>

On Tue, Nov 03, 2026 at 05:10:21PM +0100, Stanisław Titenko via B4 Relay wrote:
> From: Stanisław Titenko <kernel@resetko.pl>
> 
> The Lenovo ThinkPad T14 Gen 2a exposes a functional UCSI ACPI PPM but
> the firmware leaves the VERSION field of the UCSI mailbox at zero.
> 
> ucsi_register() rejects a zero version with -ENODEV, leaving the
> system without registered USB Type-C connectors. Without an OPM, the
> embedded controller does not complete DisplayPort Alternate Mode setup
> when a USB-C dock or monitor that supplies power is connected after
> boot, so the display stays dark while USB and charging work.
> 
> Use the zero version quirk for the ThinkPad T14 Gen 2a, matching the
> two board names of this model (20XK and 20XL).

So is the product family the same?

Could you use DMI_MATCH(DMI_PRODUCT_FAMILY... instead of adding
separate matches entry for both?

> Tested on a ThinkPad T14 Gen 2a (20XK) with BIOS 1.33 (R1MET63W):
> both Type-C connectors register, and plugging and replugging a USB-C
> monitor with an integrated hub and power delivery brings up
> DisplayPort Alternate Mode each time.
> 
> Reported-by: Daniel Dev <daniel.dev@noex.uk>
> Closes: https://lore.kernel.org/linux-usb/b1Wn_eFvTFShGbd970WWl4CWhge_6P2x7Wb6rab3QHNlE4OJ4p__O-QN3B6I-308ftr5oV5Zr7vywA0vdvmtNw6E0YJnVM2ek_5DcFnkXB0=@noex.uk/
> Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
> Cc: stable@vger.kernel.org
> Assisted-by: pi:claude-opus-5-5
> Signed-off-by: Stanisław Titenko <kernel@resetko.pl>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 47ba0e15b8ba..d752fc7b61ec 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -196,6 +196,22 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
>  		},
>  		.driver_data = (void *)&ucsi_zero_version_ops,
>  	},
> +	{
> +		/* Lenovo ThinkPad T14 Gen 2a */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "20XK"),
> +		},
> +		.driver_data = (void *)&ucsi_zero_version_ops,
> +	},
> +	{
> +		/* Lenovo ThinkPad T14 Gen 2a */
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "20XL"),
> +		},
> +		.driver_data = (void *)&ucsi_zero_version_ops,
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
> 
> -- 
> 2.56.0
> 

-- 
heikki
