Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571814;
	b=q9vWKRD7HOxgDpwRCivB9J4AZI2yY2xxQ1+o3wuKFkKCaq2rbGeBB1yZrle+Tfc720Z+
	 iOj8w3hYPkmR07GA1CNFcAjcVoEgk9Gvp22d+cUCNA9PP5FFLvRcCoh4A/fjqrU6GooiB
	 /3nKrPrxnswkql1zuA81fgDXBeFDHUCanh6iB8obrZCIqWgxNKfi+JI9Zu2RBKRMAz/m4
	 g3aenikrhbvzf5Ym3JW5x04CzIxUBOK7jS/4iookZyP8tGQUyHLDbGLKFuwvYFX1inZLK
	 4ktpOT2O8lmYDL5UCPkbYCGEcfIi8neuHDrmtBTgSksK4mQxdG0JaQv4gXlBxDgcfkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571814;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:
	 Organization:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=xIcArboitsfpMIN3qkJKxbHLZpo/1KLF9LV7OZj2dS0=;
	b=YaXzxhrANhCjp1KEWItWxvXMrSAhAJt0Sa+BmW7HqckZcAge9RyvlcPJ8pZ64QLdixX6
	 fpT/dPdV+USTnnrQXNBcKCeH5YfhBDXrDEIIAFQDmiThxOENFsjXKXqDQLuWARk0Dq76s
	 /9tHKjsYDhJZ2SMqpm7WoWx8iG33E7T9NSgUA8G55hlQJrqJy0XXBYtP/KA3Vi8QKdfnr
	 hra52WKNb+NqnX0LRX0SISjFGVfA5RzCqcCKGbdGw/7gCLMXRdzOF3tITpDKZ5oigkIvr
	 I2WPUGpMXO81cLjC9yr5jPNuKYma+BRPjVvVvXKR2URoNdfuwcbaEK8ssjHzCgtLi9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iMKhTJ3B;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7666606A323;
	Fri, 13 Nov 2026 12:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7666606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iMKhTJ3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794571813; x=1826107813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/0EEmLsHHL8gr4y4eRnm0mgFUrZzQD9UrA1F7TiJFwA=;
  b=iMKhTJ3BWVZ5IaF46w25cuP3mB56diD/favTciSFuUJNKdp9HjcJTgpt
   1+nOqhT4rizwVTFW/iFcMYCXdn7AqTTyk0Gp/BTFtj7qW4da+k0u0bSTs
   1kpsXyCME20kh6SRk/9iWlr08KUbojSKqZcLJnyIXctyGYw1hy9ux7ouC
   QRP9q1QVenQFd+IbG6qc2cZcVnxQVwGShFZArpM3pczMm2I41DsLcJFcD
   XG9PxOeuwkNk/5r20g7IVIlpBiPgjS6EANKSaQdLr9zCkP6tJvcSutpSy
   t3FVMgzHSZDgi+u5wByv64UDZrYz4PdwsleU+VMid1if4iOnN6XfO6FqI
   Q==;
X-CSE-ConnectionGUID: K90s/Zy+T/6ux7g7cRqLpQ==
X-CSE-MsgGUID: yMMlG4FsRGeimABAsA33Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3358936"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3358936"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:10:13 -0800
X-CSE-ConnectionGUID: JjY9PcHpRFaKIrgtp4PxNw==
X-CSE-MsgGUID: dSXePXggRvi2CwIWOehD1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8905586"
Received: from slindbla-desk.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.217])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:10:12 -0800
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id BD9E4121B76;
	Fri, 13 Nov 2026 14:10:12 +0200 (EET)
Date: Fri, 13 Nov 2026 14:10:12 +0200
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: raoxu <raoxu@uniontech.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: property: Fix leaked buffers after skipped
 properties
Message-ID: <avb-JJur-yeedbFa@kekkonen.localdomain>
References: <DC796DD7AB1437C8+20261112090954.1388267-1-raoxu@uniontech.com>
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
In-Reply-To: <DC796DD7AB1437C8+20261112090954.1388267-1-raoxu@uniontech.com>

Hi Rao,

Thanks for the patch.

On Thu, Nov 12, 2026 at 05:09:54PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> acpi_data_add_buffer_props() compacts successfully parsed buffer
> properties into an output package, but stores their separately allocated
> evaluation buffers in props->bufs using the original input index.
> acpi_free_device_properties() only frees entries below the output
> package's successful-property count.
> 
> If a property is skipped because of an invalid format, invalid types or
> a failed object evaluation, later successful entries can be stored past
> the range visited during cleanup. For example, a failed first entry and
> a successful second entry leave the allocation in bufs[1] while cleanup
> only visits bufs[0]. The evaluation buffer is then leaked when the
> properties are destroyed. Lists with no skipped entries do not exhibit
> this mismatch.
> 
> Store each evaluation buffer at the current output count before
> incrementing it. This keeps the ownership array compact and aligned with
> the cleanup bound without changing property order or buffer contents.
> 
> Fixes: 103e10c69c61 ("ACPI: property: Add support for parsing buffer property UUID")
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> ---
>  drivers/acpi/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 8ee5a1f0eb48..fb6b214f2335 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -523,7 +523,7 @@ static void acpi_data_add_buffer_props(acpi_handle handle,
>  		obj->buffer.length = buf_obj->buffer.length;
>  		obj->buffer.pointer = buf_obj->buffer.pointer;
> 
> -		props->bufs[i] = buf.pointer;
> +		props->bufs[*count] = buf.pointer;
>  		package++;
>  		(*count)++;
>  	}

-- 
Kind regards,

Sakari Ailus
