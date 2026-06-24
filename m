Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29027B32C;
	Wed, 24 Jun 2026 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300985; cv=none; b=nCLSOq8l5FyMeB1EKkLZdfbaEEJjxiuFvMDkzup7dI0lc3qdsNh9HKdMpe0Vi0skK81NeQTnUm1MrsgqdJ2Sp9g0KG9SknaI8DP3f5jRnyrkKdKlMe0UAJ1a7irKZ6JBM9dwtl264B4jyff1DCfC+B27Uvj0bK1pOrI6j/jJHPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300985; c=relaxed/simple;
	bh=ED1Ki3ahuXOOZUi8v8sep7F0cikuaaUEWN1kwvcTpwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Is4ptgmXmcglmen0vwr6HlfC7SGk/vdt2NOtTrY2OCumPeQeEm+cZBcy6EhSkPbWuShu02/+k+Md0p2he/A5Efb5Drsl4znrWPdae/Cv0N8NVw2ahpaozsgEwZCuYQeFzp6yhTujLuyLz0Mat7hPD3mzksOi/bhrJSJM6FlKGbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JlgvWI0a; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JlgvWI0a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782300983; x=1813836983;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ED1Ki3ahuXOOZUi8v8sep7F0cikuaaUEWN1kwvcTpwU=;
  b=JlgvWI0avJuIUWRE6hzPwYAq7Yih798QZi1Or+4kizLmGy6DOUO0jI3d
   KL/3xxSz0u3+OJdNodQu8sKZKN4irYhMvmi9XfbVMp+TKc1V2rCbSVwcs
   hlXd9bWexBOHAn6f7KY3jGfdyfeeewxmHciz0nByWhwzd0/CihzUH86WI
   ltkNh90ux0YwZqBvaVsXsYVBx8N2rcUdUOgURUuePIbMp4G7Cv3l2Hw7C
   qulpLNRC4irZmDCnSUVIekoaJDYSxrGKLz8z4jdi9mbxOyNe2WubnEj3U
   dh+uPIIfpvqiuEYin85Z3Xgan4T/6G/xtmM6z6ThnoIWI6KwLvjIYKVN7
   g==;
X-CSE-ConnectionGUID: dPt7nRQOSCSLWAu/w5m0iA==
X-CSE-MsgGUID: o6/9GNFNS4mmOK0xc5mzDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82172968"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="82172968"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:36:22 -0700
X-CSE-ConnectionGUID: 7sWNOukbToKXY6GPJzT6zg==
X-CSE-MsgGUID: BhncjoHVSmSrfhvYXt/OeQ==
X-ExtLoop1: 1
Received: from mszycik-desk.igk.intel.com (HELO [10.217.160.239]) ([10.217.160.239])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:36:20 -0700
Message-ID: <4a54f8fd-2779-41dd-9d5d-f19151b68976@linux.intel.com>
Date: Wed, 24 Jun 2026 13:36:13 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2] ice: eswitch: fix use-after-free
 of metadata_dst in repr release
To: Doruk Tan Ozturk <doruk@0sec.ai>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: michal.swiatkowski@linux.intel.com, wojciech.drewek@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, horms@kernel.org
References: <20260618145003.47471-1-doruk@0sec.ai>
Content-Language: en-US
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <20260618145003.47471-1-doruk@0sec.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/06/2026 16:50, Doruk Tan Ozturk wrote:
> ice_eswitch_release_repr() frees the port representor metadata_dst via
> metadata_dst_free(), which directly kfree()s the object and ignores the
> dst_entry refcount. The eswitch slow-path TX routine
> ice_eswitch_port_start_xmit() takes a reference on this dst with
> dst_hold() and attaches it to the skb via skb_dst_set(). If such an skb
> is still in flight (e.g. queued in a qdisc) when the representor is torn
> down, the metadata_dst is freed while the skb still points at it. When
> the skb is later freed, dst_release() operates on already-freed memory.
> 
> Replace metadata_dst_free() with dst_release() so the metadata_dst is
> freed only after the last reference is dropped. The dst subsystem frees
> metadata_dst objects from dst_destroy() once the refcount reaches zero
> (DST_METADATA is set by metadata_dst_alloc()).
> 
> Same class of bug and fix as commit c32b26aaa2f9 ("netfilter:
> nft_tunnel: fix use-after-free on object destroy").
> 
> Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
> Cc: stable@vger.kernel.org
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> Reviewed-by: Simon Horman <horms@kernel.org>

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

> ---
> v2:
>  - Correct the Fixes: tag to 1a1c40df2e80 ("ice: set and release
>    switchdev environment"); the previously cited fff292b47ac1 only moved
>    the affected code rather than introducing the unbalanced free, and the
>    bug dates back to when switchdev support was added (Simon Horman).
>  - Add Simon Horman's Reviewed-by. No functional change.
> 
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index 2e4f0969035f..41b30a7ca4a9 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -95,7 +95,7 @@ ice_eswitch_release_repr(struct ice_pf *pf, struct ice_repr *repr)
>  		return;
> 
>  	ice_vsi_update_security(vsi, ice_vsi_ctx_set_antispoof);
> -	metadata_dst_free(repr->dst);
> +	dst_release(&repr->dst->dst);
>  	repr->dst = NULL;
>  	ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
>  				       ICE_FWD_TO_VSI);
> --
> 2.43.0

