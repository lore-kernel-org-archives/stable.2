Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90764466B4C
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904773; cv=none; b=j40JgRlDSFZ3Z5z+o/ZslhKyqSEgH4LBjdRZNcq1HPSd46GEX4UuQAh87oWcNGv2MZEeH9AVEwTvTU0c6aQONyCeizgQV2jwOj7KepVMo40LkVYTxpWIDmBoKUtS0wwfQFIG/4Qu1k2WIw6Q79NyxVofeerWQwl/GqWQVvlNRwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904773; c=relaxed/simple;
	bh=vEEKLJlOZE7ycVNjS78Qg1dFqDS/f56RKZhlhNIuyNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Skc2067itDjHiss5AAbdrJ2OKEBTJTqDklDm5VUEbgxo9ZkBfuexHgrJUSm2PFKIwS+vIhwM8QFPyzRLxviwSZzx6RtvrIqzpHB1/go9UyS9aGTUfn3uBYgmLFBbN9W/Mf1UM/tZm/DWh5hsdbCE/PGBScptNTepERt1PuK2Tig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7rPWIxT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7rPWIxT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782904772; x=1814440772;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vEEKLJlOZE7ycVNjS78Qg1dFqDS/f56RKZhlhNIuyNI=;
  b=A7rPWIxTqz3N/0JRFDYK1QgZpse31pSayoHPQocw6f+qAR3BDTPOF+Ft
   vtLywvBFsh/5WTlW7/K8rr4aI7lG/DHHH0zdmBNlyLygmGY0SNSJzfP8X
   yl0iEfQESufJ+rjAGhOtZv3n8Q8LVD22hsQUBEuiQMHLovGzldzMfxfPA
   aMBggp0Z0z+pQUmriAMRhKEEE4dW+Cg1L5Hgjpq/bUodglZ9PiJcUcrLi
   cos1kEYla/ISZRUcK6l+A5Pq1BYL7wZi+wDgN7+JGr5OOU43JVY1GwxYN
   mf1krQhWw4RFYWg+GhFj35wbb36leFw3yLG6HJTqDfFfsq6ob83WA62Di
   w==;
X-CSE-ConnectionGUID: eNpaC9DcTseJKMu/i+4QwQ==
X-CSE-MsgGUID: uLDglE9aSJu4OUvJTAmVFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="87547643"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="87547643"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:19:32 -0700
X-CSE-ConnectionGUID: p9AUZjeBTH6qkXwNuR8G8w==
X-CSE-MsgGUID: 8K+QDoDJRVi22E9oE9voGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="252667741"
Received: from rvuia-mobl.ger.corp.intel.com (HELO [10.245.244.98]) ([10.245.244.98])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:19:31 -0700
Message-ID: <334874ba-a0e9-4b6d-b148-e8173786fd9a@linux.intel.com>
Date: Wed, 1 Jul 2026 13:20:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/gem: Do not leak siblings[] on proto context
 error
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Cc: Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>, Martin Hodo <martin.hodo@intel.com>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, stable@vger.kernel.org
References: <20260701073030.44850-1-joonas.lahtinen@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20260701073030.44850-1-joonas.lahtinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

On 7/1/26 09:30, Joonas Lahtinen wrote:
> After a successful BALANCE/PARALLEL_SUBMIT extension on context
> creation, error during processing of next user extension leaks
> the siblings[] array. Fix that.
> 
> Discovered using AI-assisted static analysis confirmed by
> Intel Product Security.
> 
> Reported-by: Martin Hodo <martin.hodo@intel.com>
> Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
> Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v5.15+
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/gem/i915_gem_context.c | 22 +++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index aeafe1742d30..87fce2adfeef 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -769,8 +769,8 @@ static int set_proto_ctx_engines(struct drm_i915_file_private *fpriv,
>  		struct intel_engine_cs *engine;
>  
>  		if (copy_from_user(&ci, &user->engines[n], sizeof(ci))) {
> -			kfree(set.engines);
> -			return -EFAULT;
> +			err = -EFAULT;
> +			goto err;
>  		}
>  
>  		memset(&set.engines[n], 0, sizeof(set.engines[n]));
> @@ -786,8 +786,8 @@ static int set_proto_ctx_engines(struct drm_i915_file_private *fpriv,
>  			drm_dbg(&i915->drm,
>  				"Invalid engine[%d]: { class:%d, instance:%d }\n",
>  				n, ci.engine_class, ci.engine_instance);
> -			kfree(set.engines);
> -			return -ENOENT;
> +			err = -ENOENT;
> +			goto err;
>  		}
>  
>  		set.engines[n].type = I915_GEM_ENGINE_TYPE_PHYSICAL;
> @@ -800,15 +800,21 @@ static int set_proto_ctx_engines(struct drm_i915_file_private *fpriv,
>  					   set_proto_ctx_engines_extensions,
>  					   ARRAY_SIZE(set_proto_ctx_engines_extensions),
>  					   &set);
> -	if (err) {
> -		kfree(set.engines);
> -		return err;
> -	}
> +	if (err)
> +		goto err_extensions;
>  
>  	pc->num_user_engines = set.num_engines;
>  	pc->user_engines = set.engines;
>  
>  	return 0;
> +
> +err_extensions:
> +	for (n = 0; n < set.num_engines; n++)
> +		kfree(set.engines[n].siblings);
> +err:
> +	kfree(set.engines);
> +
> +	return err;
>  }
>  
>  static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,

