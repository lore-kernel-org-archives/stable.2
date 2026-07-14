Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2940C2E414;
	Tue, 14 Jul 2026 14:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784038464; cv=none; b=lVv9n1P5IRDPNQ/08IPaY1hUldg/IzgrFq2rmv32lkYqVoNTK9hVi1uZtBS/6mE5Kp0eVRVH59yYPJVO5+B2UfWs15TEUGPeFex/dNekiwlxNNGH38pVLPualSjsk+F6Xlmd4rzLqQNoSo5ZFeRFnc97woNzqofGnO/4GTuKsV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784038464; c=relaxed/simple;
	bh=VkST+EdPPIavkd2tO6RlXwaE19h/M8XpmMIEdjDPk5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o55uilwWzTALaOaOHAenEGmnCyPbQmeKID5S4IqEp+fKDQR3u59GBSn6HAEOBfd92dyfezDw2TJQCKLCBNGXZoiwBPkgw/HaSTVz5ZQcjP0KUJ7jcLl3CAOXoTJ7PJj+/YiXhcsxRfJ3vZieXTH4xUWySM7+FrKV8XwFVzS5LOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHG+XdUu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHG+XdUu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784038462; x=1815574462;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VkST+EdPPIavkd2tO6RlXwaE19h/M8XpmMIEdjDPk5I=;
  b=lHG+XdUuGwv61L/31aIasQ9oGJ4O7QovgOIcm2zpWBHI4gV4q9e6jgCQ
   RQ4f7nKThlqUJWwyJOD0I4H9AbgvwM/4d6u6Y3UYBqEzaAYaCKe+gmN6o
   2HqwCAawRiHMkNMextLGTMhm1+G7sOGvcgrhC9Og+fV6IUGHLCaMPp6oW
   gezPQYtU9IOkbjrqOoPJjOKQi+P4JFqBwM829McFOlDx+D51iWAao/92m
   x/osAQ0AhZ/N+/teBV4kmWrxpCsTSxFo6mTN3txMd26HqVGo7sXxEvi8o
   XTxsuiPbaP2sEuOoOzyceLM1qkiHmYdulgKCSM5wx6S+CCQ7tPlNhhUtE
   A==;
X-CSE-ConnectionGUID: 20oJ0itmTzeIvYt8HjX24g==
X-CSE-MsgGUID: VAm7WrE4Q2KOos6qv4/kkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="107453767"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="107453767"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:14:21 -0700
X-CSE-ConnectionGUID: XNDBffWPQcqRRTw6K42CzA==
X-CSE-MsgGUID: fIA3r63tQkqMBAwAez07mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="252485361"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.20.168]) ([10.246.20.168])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:14:18 -0700
Message-ID: <36c68c94-0382-4d31-b114-fde2a5ad35cf@linux.intel.com>
Date: Tue, 14 Jul 2026 16:14:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix use-after-free in
 dynamic port cleanup
To: xuanqiang.luo@linux.dev, intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, sridhar.samudrala@intel.com,
 wojciech.drewek@intel.com, piotr.raczynski@intel.com,
 michal.swiatkowski@linux.intel.com, jacob.e.keller@intel.com,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 stable@vger.kernel.org
References: <20260714063937.26325-1-xuanqiang.luo@linux.dev>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260714063937.26325-1-xuanqiang.luo@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14.07.2026 08:39, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> ice_dealloc_dynamic_port() uses dyn_port->vsi->idx to erase the dynamic
> port from pf->dyn_ports. However, it frees the VSI before reading the
> index for the erase, resulting in a use-after-free.
> 
> Follow the reverse of the allocation order in ice_alloc_dynamic_port()
> by erasing the xarray entry before freeing the VSI.
> 
> Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Thank you!
I wonder how such a glaring issue survived in the codebase for so long.
Perhaps ice_vsi_free() exited early for some reason.

> ---
>  drivers/net/ethernet/intel/ice/devlink/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
> index 2a2e56777f9f7..3ede246490027 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/port.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/port.c
> @@ -590,8 +590,8 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
>  
>  	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
>  	ice_eswitch_detach_sf(pf, dyn_port);
> -	ice_vsi_free(dyn_port->vsi);
>  	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
> +	ice_vsi_free(dyn_port->vsi);
>  	kfree(dyn_port);
>  }
>  

