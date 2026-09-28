Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B304848B6;
	Mon, 28 Sep 2026 13:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790600890; cv=none; b=L7FKIFW4kFOgfQ31YfCC/QuOOkQSmeq2jQSp9VszKZC/Q2u3YAiRmMxziKZqkJAp3Xwk5AfcYxMLTxhU+RvEfF9u2teJdHUEH48hspRbA5Fwmy0JnYrSjp/P91d42VxWutd3qd5LvOejR/CnET2tqJwTUNSxmqwdwIfHMRNc5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790600890; c=relaxed/simple;
	bh=bm9nAwO6vFtN0WgH54PMOwvG9IdII+DIteKoWycbzWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VHTEM3+ls6fhCFD1+L4xJ4ixOlvi4g7CjbNk9mx6E4PWJ1fOXS/ouhJVCVE/tw3nr4jipbeKj5k1ftTpJqQATLhz7ZYNXdSiUGZPj1rMPiLM+kZCIglkzG/qxoLkRt91GhU453g7+yS1ke59fca6K6HoDAAdMwLd9BrI5yw9ALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cfI0rMpL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cfI0rMpL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790600889; x=1822136889;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bm9nAwO6vFtN0WgH54PMOwvG9IdII+DIteKoWycbzWE=;
  b=cfI0rMpL2aBuAbPC/pkS55m931q3qfsoRgVNTW2xkhGRv5oOCh4kRjFs
   Hre8d/eXVGV/EDOumZDssGLayMC0RKHi7c0uiGMY9YEaFhRrE675KXMsc
   /XlC8DQ3f4XqqoNkVByG/oRofxoNra2y9Q40O8fv5S/mqkdFcU4o6UhgK
   4tUJ9PoKPpqDDbMbneZ+Gv9U2k8+1IWD4ynK7j521h3r2GC+4vQi06RzL
   f73aZ81eUABNmevBDbz00qoPCCukeiykvTq61rgAbCPGKpGLYxQz30ZS3
   5T2zmho5OSqAI8EiGCL2SlAmfeltC55k/bU1Yvw4LlptSr4/MnDf+EBNh
   w==;
X-CSE-ConnectionGUID: 3lIfUOEyTgyhiIveIPoHdA==
X-CSE-MsgGUID: KnfTYK2vRjeRdr2KYVXksg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="93788050"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="93788050"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 06:08:07 -0700
X-CSE-ConnectionGUID: bWy20A38Q7yp4PaIe4g4Rg==
X-CSE-MsgGUID: QjSfbDTUTcKUcBzEr6fg6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="302999362"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 06:08:06 -0700
Received: from [10.102.89.17] (soc-5CG4396XFD.clients.intel.com [10.102.89.17])
	by linux.intel.com (Postfix) with ESMTP id 0177920B5708;
	Mon, 28 Sep 2026 06:08:03 -0700 (PDT)
Message-ID: <143280f0-1c93-405b-b03d-b6404893cdd7@linux.intel.com>
Date: Mon, 28 Sep 2026 15:08:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v2 2/2] ice: release the VF MSI-X window when
 ice_start_vfs() fails
To: Linkui Xiao <xiaolinkui@126.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
References: <20260928065306.1514795-1-xiaolinkui@126.com>
 <20260928065306.1514795-2-xiaolinkui@126.com>
Content-Language: pl
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
In-Reply-To: <20260928065306.1514795-2-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28.09.2026 08:53, Linkui Xiao wrote:

> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 95abc6704820..df84dbe12cba 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -446,8 +446,10 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
>  		return -ENOMEM;
>  
>  	vsi = ice_vf_vsi_setup(vf);
> -	if (!vsi)
> -		return -ENOMEM;
> +	if (!vsi) {
> +		err = -ENOMEM;
> +		goto free_irqs;
> +	}
>  
>  	err = ice_vf_init_host_cfg(vf, vsi);
>  	if (err)
> @@ -457,6 +459,9 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
>  
>  release_vsi:
>  	ice_vf_vsi_release(vf);
> +free_irqs:
> +	ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
> +
>  	return err;
>  }
>  
> @@ -490,6 +495,8 @@ static int ice_start_vfs(struct ice_pf *pf)
>  				dev_err(ice_pf_to_dev(pf), "Failed to attach VF %d to eswitch, error %d",
>  					vf->vf_id, retval);
>  				ice_vf_vsi_release(vf);
> +				ice_virt_free_irqs(pf, vf->first_vector_idx,
> +						   vf->num_msix);

Nit: For consistency with the teardown: loop (which frees IRQs before releasing the VSI), consider swapping the order here too - currently this branch releases the VSI first, then frees IRQs, the opposite order. Not functionally significant, just readability.

>  				goto teardown;
>  			}
>  		}

Reviewed-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>


