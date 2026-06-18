Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF24A3EE1DB;
	Thu, 18 Jun 2026 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781781198; cv=none; b=Ow3qGb3lUUT7Le9XGfryW01lwM4Bn2xWhk34ihffGOb0avnyquzmPFnDzwvw+5WEAEaMde1IJNjCRnOvoCIGgwe9yqQOdBjh/nicDomdh24ywuitwUD3p7Fysvk9QrIXPnfIF0tfgidVCIM6K9e10SPwn7NpATRUDeqSGhwPE4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781781198; c=relaxed/simple;
	bh=SexmYc3raGJTTWWvAJwngK2R5oweGHq9hSkCaNk/t7E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oiRs5J2ocsYBga4wQM2PxA4OXHovpmzAplV7JN+rH4dg0+ompeoSUZqazwPnL3TI1bjo//DErU/8paloiEI4EehcpYJ6VzKm72m/hohLnsdQaI/hXD4/CIH5n8yyFk5YocRKSx7l2r/eWBrSTGUvQJteoeMUMoMC7wxYqHsv3oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyAvz85d; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyAvz85d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781781195; x=1813317195;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SexmYc3raGJTTWWvAJwngK2R5oweGHq9hSkCaNk/t7E=;
  b=HyAvz85d22k+aBSE5NYV7FzvbZ49pIniecYB+DSrpp0AETGpfgTqbtHN
   EfH7+HivA1VSwmGkhJaheEtF6RhTwFnNdxXLdzNEGBSd8eW29aSsxz5xo
   rDQAkQkJOrkIqhGQD+1XbIN3grCbBW49lzDEc8ae6LszyflkLbZWjV2jS
   NtKbJF7zrmpABZ0pc6RKUsWqNGZN7vNvUtpW6m3YaSndwRcGRQmackEAE
   Mfav+sKw44BAMfFuIMcKU/XD4IuM0HF9fLdYKezn16tRtQprAejDk6/V1
   KcRvyH4IJvXFOKIEGD44NfKaQbCqEWjogJK8JCl9JIy6UwTCkyP3oJHMT
   Q==;
X-CSE-ConnectionGUID: bbSv1/WuSbaooNH+sGvcZw==
X-CSE-MsgGUID: hR43GDi2TiKtqUVqyDZJ/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="82510587"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="82510587"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 04:13:15 -0700
X-CSE-ConnectionGUID: NodSaJeHQoWWY68QIbNlXA==
X-CSE-MsgGUID: iGItxHOSR8WwPGXbD7T0xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="253445719"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 04:13:11 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ma Ke <make_ruc2021@163.com>, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 simona@ffwll.ch, hansg@kernel.org, matthew.d.roper@intel.com,
 vivek.kasireddy@intel.com
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, Ma Ke <make_ruc2021@163.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/dsi: fix i2c adapter reference leak in
 i2c_adapter_lookup()
In-Reply-To: <20260618110446.518501-1-make_ruc2021@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260618110446.518501-1-make_ruc2021@163.com>
Date: Thu, 18 Jun 2026 14:13:08 +0300
Message-ID: <8f89e5af148cab8daca10ca4f7214e4e9207c29f@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 18 Jun 2026, Ma Ke <make_ruc2021@163.com> wrote:
> i2c_adapter_lookup() acquires a reference on the i2c adapter through
> i2c_acpi_find_adapter_by_handle() but not releases it.  Each
> invocation of this ACPI resource callback leaks one device reference,
> potentially leading to resource exhaustion over repeated driver
> load/unload cycles.
>
> Calling path: i2c_acpi_find_adapter_by_handle() -> bus_find_device()
> -> get_device.
>
> Found by code review.
>
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> Cc: stable@vger.kernel.org
> Fixes: 8cbf89db2941 ("drm/i915/dsi: Parse the I2C element from the VBT MIPI sequence block (v3)")
> ---
> Changes in v2:
> - Changed email to trigger CI, no code change.

Sorry, that won't do anything. Please just let us deal with it. :)

BR,
Jani.

> ---
>  drivers/gpu/drm/i915/display/intel_dsi_vbt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> index fe12041e913c..2097c5d17cb7 100644
> --- a/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> +++ b/drivers/gpu/drm/i915/display/intel_dsi_vbt.c
> @@ -460,8 +460,10 @@ static int i2c_adapter_lookup(struct acpi_resource *ares, void *data)
>  		return 1;
>  
>  	adapter = i2c_acpi_find_adapter_by_handle(adapter_handle);
> -	if (adapter)
> +	if (adapter) {
>  		intel_dsi->i2c_bus_num = adapter->nr;
> +		put_device(&adapter->dev);
> +	}
>  
>  	return 1;
>  }

-- 
Jani Nikula, Intel
