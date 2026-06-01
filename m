Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D530338E8CD;
	Mon,  1 Jun 2026 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305557; cv=none; b=ue9+txd6WO/UVonTBxNoLYQsx4YkG0dCCTOCQlpWClM0BcxSedW54nHpfWM9FZhiR7vhyMDg+ecV4NI0W/ONl32yl6rruMtqBjc4F5dkU1/4OHVGLecvxbHTJvQ8fUOI0BgjoLnhpvw1rh1sFO2rDRc8f1ur9aL9T2+7U8lvNtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305557; c=relaxed/simple;
	bh=wcQZubXFj92w5s2C5QPjxynJFvtcWsTj+RW8zM8eY3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mp2Uz2iWWS0vVnoHJK6luWyW6fjsR6amWQ2qnCUIa3N75ibkuI53kQlJZo4yMfy/7MSwUuyeyxtg/AR+trzFTKZrD0a2/X2puoKUF3dPpFoJKw3ogEkBECUBk8RzZfxuZgwunfmaFsabQ9wOxOWqh3n7SpeeXRBii2ZZvH9em8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtdnsfUR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtdnsfUR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780305556; x=1811841556;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wcQZubXFj92w5s2C5QPjxynJFvtcWsTj+RW8zM8eY3s=;
  b=GtdnsfURuPQqFjeDaI4naPJc0x7logSVgd/qBVqjf6DIKSVeYCIMNlWn
   NisyXHn++5Lx1EmfmpL0N6ir8I1Wfu4iiKWAb6v9Fu5WZcKIKrcdPnOt7
   VmB1H2Sz2RQCEmbBIkRaJn2uLDu+OXyB01S+7i/XhBhGT+n3bg+apqi9E
   RKFqrebwH2ZpyjY1sB8J7Q8UViU1u9TwcZqVccuMoJ8JytbrOpDTX+/fC
   L21qOWCLXcF53G4TjweXNvr8mcmX7TVCGVKjHsSMz2zPRNzSMq/MAHy72
   kMq5Ftr4Xj5aNCzhSq7PSHAzqcIMDGfCEzvosfOZZeMzKjFRCsOafzJfa
   A==;
X-CSE-ConnectionGUID: 2cN371V+RsC0StblyJiksQ==
X-CSE-MsgGUID: r5Ou1T3ZT9qVjvbRjL5ipQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="84948309"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="84948309"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:19:15 -0700
X-CSE-ConnectionGUID: yAwssWEbRYOo/Yw4Utq+IA==
X-CSE-MsgGUID: 777dSKA9Q1moknFX8mAvDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="243619328"
Received: from unknown (HELO [10.217.160.157]) ([10.217.160.157])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:19:12 -0700
Message-ID: <f8a922da-8463-48b1-8e4b-a6bda0767d32@linux.intel.com>
Date: Mon, 1 Jun 2026 11:19:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net] i40e: fix netdev leak in
 i40e_vsi_setup() error paths
To: Dawei Feng <dawei.feng@seu.edu.cn>, anthony.l.nguyen@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 jesse.brandeburg@intel.com, sln@onemain.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org,
 Zilin Guan <zilin@seu.edu.cn>
References: <20260527110205.1780595-1-dawei.feng@seu.edu.cn>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260527110205.1780595-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/05/2026 13:02, Dawei Feng wrote:
> i40e_config_netdev() allocates vsi->netdev for main and VMDQ VSIs. If
> i40e_netif_set_realnum_tx_rx_queues(), i40e_devlink_create_port(), or
> register_netdev() fails, i40e_vsi_setup() goes to err_netdev without
> releasing the netdev. The existing cleanup only frees the netdev after a
> successful register_netdev(), so these error paths leak the allocation.
> 
> Reorder the error paths at err_netdev to ensure proper cleanup of the
> allocated device.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1-rc5.
> 
> An x86_64 allyesconfig build showed no new warnings. As we do not have an
> Intel Ethernet Controller XL710 family adapter to test with, no runtime
> testing was able to be performed.
> 
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Cc: stable@vger.kernel.org
> 
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

We could introduce additional goto label for i40e_config_netdev() instead of
if condition, but the latter is probably safer in this case (without splitting
the different VSI types setup to functions).

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 6d4f9218dc68..1ced01b0cc09 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -14491,13 +14491,15 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>  	if (vsi->netdev_registered) {
>  		vsi->netdev_registered = false;
>  		unregister_netdev(vsi->netdev);
> -		free_netdev(vsi->netdev);
> -		vsi->netdev = NULL;
>  	}
>  err_dl_port:
>  	if (vsi->type == I40E_VSI_MAIN)
>  		i40e_devlink_destroy_port(pf);
>  err_netdev:
> +	if (vsi->netdev) {
> +		free_netdev(vsi->netdev);
> +		vsi->netdev = NULL;
> +	}
>  	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
>  err_vsi:
>  	i40e_vsi_clear(vsi);

