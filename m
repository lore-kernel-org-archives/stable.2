Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B1D4CC29E;
	Thu,  3 Sep 2026 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448840; cv=none; b=XvRUEtyNcMcvhubsZTiKjplPIvJ8uJlr+xzIA0MTfF7pieQE1PwRU5W1i7h3DSIMAShnDMjH2lGLaUy0D1OLnTCUaNQqoCIodgWTRD8HsizKOe1jSiz4lKXke7OVF6O3zOqk8ioUfKIhpY/94/RJB2NoPU/E5t0UzoI9bxOeqRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448840; c=relaxed/simple;
	bh=oAY7hv/EwUzgz64rd4cjEjliORWWEShw0sw1SZsO4nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeYfIFDtDDyR3POWlidbxUAy9Ndaf8n9zl94nYu10EZmyKBs30/p1Z6FnjKsU0NNbizCE9KYYAzb0n/kz+gT9AzylwALXMMvAFeH2HiQlTwh03b3btkIzVC3qDpB1M33rvFRuHBtii/TLpV7Ag+SNm2bQU2kdmbCcW0LiymWg1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cum6BF2Y; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cum6BF2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788448838; x=1819984838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oAY7hv/EwUzgz64rd4cjEjliORWWEShw0sw1SZsO4nQ=;
  b=Cum6BF2YDzfVYOB2UewO1GJmvRl0hcBVNU5gmZ9/DIe/udGQq9C+J5PZ
   t/IvPFV4hZBTzcQNNEDKDRCgeOjQO4EO+UTHsfx/2hdLjGruHIZMzB6wn
   PUhsT1dKNdrSzP3NPdyAArYMnNP1A24P381GORJVLOiwTTndaL/oAjr4M
   1ipq6NgisELmwNsnfqkTg7vgujmx7ij92qOFYnpyehAcq5LQ7Pdi3GXn1
   t6t1Bp0TIl0IAaOFZpWkICdMAHoZBlDWP7yGUp2UKg1FJ9bp1UPFeqsQV
   8f1/3f/2KuxWNu0kzHDD9JVsb9qbiLdMzT91KJtytSEDsJNL15bZp1dMX
   g==;
X-CSE-ConnectionGUID: gV3kLeUyQua4v5U3tAxudA==
X-CSE-MsgGUID: A/zgvJxoTKy8MtOtI4htUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="88077057"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="88077057"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:20:38 -0700
X-CSE-ConnectionGUID: L15uMUjtSp+DIHSuVLnD6A==
X-CSE-MsgGUID: GJQFniDjRSewum2khlSAXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="299626458"
Received: from rvuia-mobl.ger.corp.intel.com (HELO mdjait-mobl) ([10.245.244.159])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 08:20:36 -0700
Date: Thu, 3 Sep 2026 17:20:29 +0200
From: Mehdi Djait <mehdi.djait@linux.intel.com>
To: Antti Laakso <antti.laakso@linux.intel.com>
Cc: linux-media@vger.kernel.org, sakari.ailus@linux.intel.com, 
	miguel.vadillo@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] media: i2c: cvs: Add sensor node in bound callback
Message-ID: <apmPgC1ffSp60Mcb@mdjait-mobl>
References: <20260903100753.3176233-1-antti.laakso@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903100753.3176233-1-antti.laakso@linux.intel.com>

Hello Antti,

Thank you for the patch!

On Thu, Sep 03, 2026 at 01:07:53PM +0300, Antti Laakso wrote:
> Sensor device nodes are created in the complete callback, which is only
> called when all devices are successfully registered. If any device fails
> to register, e.g. due to a missing driver, the complete callback is
> never invoked and sensor nodes are not created.
> 
> Create sensor device nodes in the bound callback instead, ensuring they
> are available as soon as sensor is bound regardless of other devices
> registration status.
> 

This does actually fix the issue I had on my Dell laptop with two
camera sensors:
HIMX1092 OVTI02C1

But for the HIMX1092 a driver does not exist (yet) in upstream.

Tested-by: Mehdi Djait <mehdi.djait@linux.intel.com> # Dell XPS 13 9350 + IPU7
Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

> Fixes: 8e2b43d2c10b ("media: i2c: cvs: Add driver of Intel Computer Vision Sensing Controller(CVS)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Antti Laakso <antti.laakso@linux.intel.com>
> ---
>  drivers/media/i2c/cvs/v4l2.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/i2c/cvs/v4l2.c b/drivers/media/i2c/cvs/v4l2.c
> index 9fadca7a3bee..863112cde266 100644
> --- a/drivers/media/i2c/cvs/v4l2.c
> +++ b/drivers/media/i2c/cvs/v4l2.c
> @@ -13,6 +13,7 @@
>  #include <media/v4l2-async.h>
>  #include <media/v4l2-common.h>
>  #include <media/v4l2-ctrls.h>
> +#include <media/v4l2-device.h>
>  #include <media/v4l2-event.h>
>  #include <media/v4l2-fwnode.h>
>  #include <media/v4l2-mc.h>
> @@ -400,7 +401,7 @@ static int cvs_csi_notify_bound(struct v4l2_async_notifier *notifier,
>  				struct v4l2_async_connection *asc)
>  {
>  	struct icvs *ctx = notifier_to_csi(notifier);
> -	int pad;
> +	int pad, ret;
>  
>  	pad = media_entity_get_fwnode_pad(&sd->entity, asc->match.fwnode,
>  					  MEDIA_PAD_FL_SOURCE);
> @@ -409,9 +410,13 @@ static int cvs_csi_notify_bound(struct v4l2_async_notifier *notifier,
>  
>  	ctx->remote = &sd->entity.pads[pad];
>  
> -	return media_create_pad_link(&sd->entity, pad, &ctx->subdev.entity,
> -				     ICVS_CSI_PAD_SINK, MEDIA_LNK_FL_ENABLED |
> -				     MEDIA_LNK_FL_IMMUTABLE);
> +	ret = media_create_pad_link(&sd->entity, pad, &ctx->subdev.entity,
> +				    ICVS_CSI_PAD_SINK, MEDIA_LNK_FL_ENABLED |
> +				    MEDIA_LNK_FL_IMMUTABLE);
> +	if (ret)
> +		return ret;
> +
> +	return v4l2_device_register_subdev_nodes(sd->v4l2_dev);
>  }
>  
>  /**
> -- 
> 2.55.0
> 
