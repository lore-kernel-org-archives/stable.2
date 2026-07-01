Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E54779A3
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904801; cv=none; b=lQJSFZVx7TEi07e8ZvvOLasFrvrxP99X5RfsRxLpPYMYOYZCFQg/EnHH8UneIQtl2hSZ6VhsItA9zvMjdCBL5keKHFpe7QW6VmBzv/jzESBRkckLaGke1Bd+FZSdDqxbln+V5qyXH61mdlBCse++3lOlQVPYnFLrbv3PHvEYTA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904801; c=relaxed/simple;
	bh=gyO/hx1mJEoB9s4Jb/OgGuQ2OFVjNXQVa1TidDgDBxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Et+9dFHTC6uFiqup5JPMePpF/iLqvXLi8aZkQin7Q5X3IvIxVWqlrLa2Jn6AGMaux+7dmITbh5bt+qcDAxHvOk3j4xG/9dhd0dNPGRsRSYZYQaVP5S5r1kG2eOVaKBn9fdPNBIeDkG9UJkOvrqoWK3d6INUh6AFx2MEkbG9+CRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOuVgQ9N; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOuVgQ9N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782904798; x=1814440798;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gyO/hx1mJEoB9s4Jb/OgGuQ2OFVjNXQVa1TidDgDBxs=;
  b=MOuVgQ9NDKza7mUcpLNa82759rit5zlK3EqGvD7BFYWCxTlmXA/qFatU
   NR+a5cf5Z8h35C1GkCXB5IGNlt5FdrFV9jKaJvBrA193YYPvVO/aOaAyK
   BFbo+heY6k/Hi3eXo0Yx5IH8C5VO2ytv57iV5C2jXTpxQPt7614VQ9m+o
   3WPRsBWMSKaD3y+SlIWhukbvaP3mv7WzG/Ze3tWYoanUZ3Jib0UfV5qhc
   T41uhUqN8lvCEtC5hb+vucHBy48FvLJy/MwlUZTWuxjgq7/ec+GOdOnz6
   xykyut/BlRAAf+hgF8b6S43A9ESlPMSz7stmOMJfbBzi+aLgeaEujFG5R
   w==;
X-CSE-ConnectionGUID: W2GmjCGYQN2K0gzaBI4exw==
X-CSE-MsgGUID: l+ARxQVXSJS7VN6qu57tbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="87547652"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="87547652"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:19:57 -0700
X-CSE-ConnectionGUID: VonLuFK8S1mY3IUQRcmzIg==
X-CSE-MsgGUID: XE1wrlocSoyhSWvPHJQjiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="252667810"
Received: from rvuia-mobl.ger.corp.intel.com (HELO [10.245.244.98]) ([10.245.244.98])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:19:56 -0700
Message-ID: <7395991e-eb9e-483b-bdc9-7eb756a1b31c@linux.intel.com>
Date: Wed, 1 Jul 2026 13:20:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/gem: Fix NULL deref in I915_CONTEXT_PARAM_SSEU
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Intel graphics driver community testing & development
 <intel-gfx@lists.freedesktop.org>
Cc: Direct Rendering Infrastructure - Development
 <dri-devel@lists.freedesktop.org>, Martin Hodo <martin.hodo@intel.com>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, stable@vger.kernel.org
References: <20260701075555.52142-1-joonas.lahtinen@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20260701075555.52142-1-joonas.lahtinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

On 7/1/26 09:55, Joonas Lahtinen wrote:
> Setting context engine slot N into I915_ENGINE_CLASS_INVALID /
> I915_ENGINE_CLASS_INVALID_NONE and attempting to apply
> I915_CONTEXT_PARAM_SSEU to the same slot N will deref NULL.
> Fix that.
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
>  drivers/gpu/drm/i915/gem/i915_gem_context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> index aeafe1742d30..347d1f2c05f5 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
> @@ -850,7 +850,7 @@ static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,
>  		pe = &pc->user_engines[idx];
>  
>  		/* Only render engine supports RPCS configuration. */
> -		if (pe->engine->class != RENDER_CLASS)
> +		if (!pe->engine || pe->engine->class != RENDER_CLASS)
>  			return -EINVAL;
>  
>  		sseu = &pe->sseu;

