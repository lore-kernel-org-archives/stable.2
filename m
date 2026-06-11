Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134FF44D011;
	Thu, 11 Jun 2026 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781195321; cv=none; b=qMfpaJnu50MB8ImwTcGyzdpj0CL1NHcYy7BzEf+WGxH7hafBDmJaYr5MPtvwSq8HDPxvqtBgIY65c16AxxUWHQnasKUrd7GXVaErh8jeAO5da6FH1VGW70fp0i0E2v057HSz5HnrKSHW8HvYU3IeSEpuy98Mz31wPHM4XF+yizY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781195321; c=relaxed/simple;
	bh=C0oszD8SAqpd1jfUd3Z9NcqatEKo9eoDC7luL7OG+UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHZSGIo8RX9ogf9/UI9VwW5XdQSUAA4e6wKe4hd2gbrwuPKHdhqnKayMnkDqPzKOlY2J8minCEiHnmt3AD0KBse30Dn+OXdbWhlmiQyJ0/RkZ9/mWU3iCst49idbE7zp2BPD1y5VPgHjYjDlatMxlHgTAekLkvWmpuSFmhsnbqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lu6dPLx6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lu6dPLx6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781195319; x=1812731319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C0oszD8SAqpd1jfUd3Z9NcqatEKo9eoDC7luL7OG+UU=;
  b=Lu6dPLx6GcyFI+MLZIt7SrYpATlCl8CyyLH36uDziriGefqKR4Eg3YuO
   WV+NlIrXIH22RvVyDiuoohu7c43vCMkBePr3FzfTOLIEUDGMdOnvQ0hRp
   MowzqfD4GyRNjKfsaYcnZpAPzoIhVMnjYP2Xn87BVEn3c5WcMfjmjWzKA
   3cVgZ+zulYc/Hhk9/+swMYfsJwP64gAAmx9TRuFD1GYOy0ob5lrhKKHAE
   +F1ccr+qLS1znpsBY0E9cYEpgebNo5uhaFrLfnIVRrK7uu1mEmwvhy5G8
   SC6xL7qE/Kad291euXvoN67/nJQd80t+qx+75VwZpLihUqRH19PuLTi4x
   g==;
X-CSE-ConnectionGUID: 4HHPueiWSzGhDvIrfrNpYA==
X-CSE-MsgGUID: Tl65XeZPT4Oxz5EatgLTEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81997700"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="81997700"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:28:38 -0700
X-CSE-ConnectionGUID: uzMx9dBpTBG2E2LPhIiqaQ==
X-CSE-MsgGUID: qud89/ILT0GMkTpBqsxf3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="276720633"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.246.20.168]) ([10.246.20.168])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 09:28:35 -0700
Message-ID: <8d96249e-1492-4111-83e7-b84914e6dc90@linux.intel.com>
Date: Thu, 11 Jun 2026 18:28:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: fix memory leak in
 ice_lbtest_prepare_rings()
To: Dawei Feng <dawei.feng@seu.edu.cn>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, zilin@seu.edu.cn, stable@vger.kernel.org
References: <20260611161204.605962-1-dawei.feng@seu.edu.cn>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260611161204.605962-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11.06.2026 18:12, Dawei Feng wrote:
> ice_lbtest_prepare_rings() frees Rx rings only when
> ice_vsi_start_all_rx_rings() fails. If ice_vsi_setup_rx_rings() fails
> after allocating some descriptors, or if ice_vsi_cfg_lan() fails after
> the Rx rings were prepared, the function reaches the Tx cleanup path
> without releasing the initialized Rx resources.
> 
> Fix this by adding separate unwind paths for Rx setup failure and LAN
> configuration failure. The Rx setup failure path releases the partially
> prepared Rx rings before freeing Tx rings, while later failures first
> undo the LAN Tx configuration and then release the Rx rings in reverse
> setup order.
> 
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing
> v6.13-rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still
> present in v7.1-rc5.
> 
> An x86_64 allyesconfig build showed no new warnings. As we do not have an
> Intel E800 Series adapter available to run the ethtool offline loopback
> selftest, no runtime testing was able to be performed.
> 
> Fixes: 0e674aeb0b77 ("ice: Add handler for ethtool selftest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>

LGTM
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> ---
> Changes in v2:
> - Fix cleanup order
> 
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index f28416a707d7..10a4abc66974 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -1069,18 +1069,18 @@ static int ice_lbtest_prepare_rings(struct ice_vsi *vsi)
>  
>  	status = ice_vsi_cfg_lan(vsi);
>  	if (status)
> -		goto err_setup_rx_ring;
> +		goto err_cfg_lan;
>  
>  	status = ice_vsi_start_all_rx_rings(vsi);
>  	if (status)
> -		goto err_start_rx_ring;
> +		goto err_cfg_lan;
>  
>  	return 0;
>  
> -err_start_rx_ring:
> -	ice_vsi_free_rx_rings(vsi);
> -err_setup_rx_ring:
> +err_cfg_lan:
>  	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
> +err_setup_rx_ring:
> +	ice_vsi_free_rx_rings(vsi);
>  err_setup_tx_ring:
>  	ice_vsi_free_tx_rings(vsi);
>  

