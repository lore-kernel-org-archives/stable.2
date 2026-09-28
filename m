Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08104BB5C5;
	Mon, 28 Sep 2026 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600894; cv=none; b=bZBQ5FX7kUPz16pOEd6U00/ZAPrBE7SIM+Tob7K4XnxBII1uIAyzMD0f9OEBSxRr9RQDXTiVc9BUeWCVLOJhwoFUVuJDUgz/ugRyi3J04Y3Iy0serECiVjBzhUKMEdTps/b0tR75+x8AWtu+13xkfcEM/fXkLje45xLC8v5kDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600894; c=relaxed/simple;
	bh=5Hj9ni/TpoYtr93aWbk+8aZHf1HPKdtjqnX/zK20FhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sb7Gzp23vSHD1jywV7JWHfDD92aErPlt2VckPWXRPVYEqhQsoBlL4MN2RWzGputNi0mXKSXCydT17nbdZPdLGDCThzcS6YqigrSW+bVobY9HJLM06Ff52iUSb2FKeStE8VdkBzNNp6phY6fRypT571l0atAPeblphxvQK8ncfBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dR8gqznU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dR8gqznU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790600893; x=1822136893;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5Hj9ni/TpoYtr93aWbk+8aZHf1HPKdtjqnX/zK20FhE=;
  b=dR8gqznUghk9Le6WVaW1C5IoUwcFqUCU4708zjgW1aRakuCXAKQSfm4h
   pPYyGuGgHV6gaa4DPOuKe3o9xvaXOHRG+62o3RqBY/vYzX3vB0Zjg3xh0
   mcxd9xKsuKhc4DtGYQXDckt7lXgt6k2C0O0FKAe6XDJQx9u2UzcnfvIkx
   L5d14R/iPhE3wZU+EUnkhhR34TqNsoragLckdqNOWjCDA7411DfIyTyW8
   e15nECuQ25TtvA8Zvjf1Ty84wdtFV083dIGgzCpO3Q214EKsh3L8L6GY0
   TiV+hiNUvkg3TGqTnbywMoHy7yOl7RHntUkv2uw0kQi+/dIf8d/asrmmj
   g==;
X-CSE-ConnectionGUID: 2NO5N3zxScKdKeDFlZJCbQ==
X-CSE-MsgGUID: g4Tqk17OTbOUEnst4hWB1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90251926"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90251926"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 06:08:13 -0700
X-CSE-ConnectionGUID: vNPCrckvR2G4WnuKzPkR4w==
X-CSE-MsgGUID: utS07yfGSJGK+ziMUtQmAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="273195135"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 06:08:13 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
	by linux.intel.com (Postfix) with ESMTP id 9ECA020B5708;
	Mon, 28 Sep 2026 06:08:09 -0700 (PDT)
Message-ID: <1dc822f8-e2f8-4e22-aeba-dc91476c27ad@linux.intel.com>
Date: Mon, 28 Sep 2026 15:08:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
 ice_start_vfs() fails
To: Linkui Xiao <xiaolinkui@126.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
References: <20260928065306.1514795-1-xiaolinkui@126.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260928065306.1514795-1-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28.09.2026 08:53, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> ice_start_vfs() attaches every VF it brings up to the eswitch with
> ice_eswitch_attach_vf(), but the teardown path only undoes the queue
> mappings and the VF VSI. Nothing calls ice_eswitch_detach_vf() for the
> VFs that were attached before the failure, and the caller, ice_ena_vfs(),
> goes straight to ice_free_vf_entries(), which drops its reference to
> every VF.
> 
> The port representors created for those VFs therefore outlive the
> failed VF creation:
> 
>   - the representor netdev stays registered and its devlink port stays
>     registered too. That port is embedded in struct ice_vf, so it ends
>     up pointing into the memory that ice_sriov_free_vf() releases;
> 
>   - repr->vf keeps pointing at the freed struct ice_vf, and repr->src_vsi
>     at the VF VSI that ice_vf_vsi_release() tore down. The leftover
>     netdev is still visible to the user, so even a plain
>     "ip -s link show" of it reaches ice_repr_get_stats64(), which calls
>     repr->ops.ready() -> ice_check_vf_ready_for_cfg(repr->vf) and then
>     reads repr->src_vsi through ice_update_eth_stats();
> 
>   - the virtchnl ops of that VF, which ice_repr_add_vf() replaced with
>     ice_virtchnl_set_repr_ops(), are never handed back to
>     ice_virtchnl_set_dflt_ops();
> 
>   - pf->eswitch.reprs never becomes empty, so ice_eswitch_detach() never
>     calls ice_eswitch_disable_switchdev(). pf->eswitch.is_running stays
>     true, with the bridge offloads and the devlink rate topology still
>     up, and ice_eswitch_release_env() is skipped, so the uplink VSI is
>     left in the switchdev configuration that ice_eswitch_setup_env()
>     gave it.
> 
> Detach the representor in the teardown loop the way ice_free_vfs() does,
> ahead of ice_vf_vsi_release(), because ice_repr_rem_vf() and
> ice_eswitch_release_repr() both need repr->src_vsi to still be valid.
> Every VF the teardown loop walks completed ice_eswitch_attach_vf()
> successfully, and ice_eswitch_detach_vf() already returns early for a VF
> without a representor, so no extra condition is needed.
> 
> Hold vf->cfg_lock across the teardown of each VF as well, like
> ice_free_vfs() does. The VFs unwound here are the ones that already
> reached set_bit(ICE_VF_STATE_INIT), which is exactly what
> ice_check_vf_ready_for_cfg() checks, so a host administrator can still
> run "ip link set dev <pf> vf N ..." and a VF can still send a mailbox
> message while the loop walks them. Both paths take cfg_lock and then run
> ice_reset_vf(), which gets to ice_eswitch_update_repr() and writes
> through the representor that is being freed, or reach
> ice_vc_process_vf_msg() reading vf->virtchnl_ops while
> ice_virtchnl_set_dflt_ops() hands them back.
> 
> Fixes: fff292b47ac1 ("ice: add VF representors one by one")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> v1:
> - Link: https://lore.kernel.org/netdev/20260921031616.3390259-1-xiaolinkui@126.com/
> 
> Changes in v2:
> - Hold vf->cfg_lock across the teardown of each VF, the way ice_free_vfs()
>   does, so that a concurrent VF reconfiguration cannot walk through the
>   representor and the virtchnl ops that are being torn down.
>   (Sashiko AI review)
> - Patch 2/2 is new and returns the VF MSI-X window that the same failure path
>   reserves. That is a separate, pre-existing bug, so it is not folded in here.
>   (Sashiko AI review)
> - Not carrying over the Reviewed-by from Aleksandr Loktionov, as the code
>   changed after his review.
> 
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index e04de0215596..95abc6704820 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -508,8 +508,13 @@ static int ice_start_vfs(struct ice_pf *pf)
>  		if (it_cnt == 0)
>  			break;
>  
> +		mutex_lock(&vf->cfg_lock);
> +
> +		ice_eswitch_detach_vf(pf, vf);
>  		ice_dis_vf_mappings(vf);
>  		ice_vf_vsi_release(vf);
> +		mutex_unlock(&vf->cfg_lock);
> +
>  		it_cnt--;
>  	}
>  


Reviewed-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>

