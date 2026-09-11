Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83786455623;
	Fri, 11 Sep 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789143865; cv=none; b=fzJLzy2LH/D6/fleIv4ltvYs2wFBXP+zFtzKubThiClhnIjjecTE32+DIOGBk5vMRBRN4vXIaZiCv6vG/Uoi6XJV7fs4wFpG0rsEmk+rvSIkFtRMeWNDHrDAHys4gQ9zzpN+7tZDLGRKE2ALQHNDB4d0Bpj/pgjOueLJFSt6oYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789143865; c=relaxed/simple;
	bh=lQoyE24wkikaS7D/5zG7Nvy3qw7xryzYAjVBQ2/y2V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjoHrs4K3J1OEiBYjAn72gMFR/SeEo5iYDbp09x7Wi3Z9WXqrcf/e8Nn3DyvdttCaJK8CIV77sZEsmkUpyVB8HCKE7nAtzrArSQYgzFUSrqMKIdgtFJBWUH/pt5blJGAfPCAcvMTZ8UFxQJJdw4KRP7esSp8ouhzqAQb34CGq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lN22sOny; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lN22sOny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789143863; x=1820679863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lQoyE24wkikaS7D/5zG7Nvy3qw7xryzYAjVBQ2/y2V0=;
  b=lN22sOny4rxmGKK0kqmEsRc3C20kAsK5nE1OnIFuA2NzYoX5FjJpqB1j
   jUvkJiLfe2wu3ul+lemZ+lncNbwaHJXkMEqbxqzz38rrYfaOPxaiXw/gw
   B5+1TVr7nsLI3ZkjtmtozHl0HY7PyjsDlXTg51qg5bxtFzw62FZYEt2Y7
   KdemV6pgditfV7Is8/W3fFqihEpfP7+pnsJueAVRLZfetdI8fSZBW0MqV
   4Oks5cFl43tNAJ6v6CTxigLzyhYtspCBbAQaNQXKCZp+1IcGMMOVtMR8z
   4CVyPDzqA/hrynVc+p59efsduZRpWqVzDYwSfAhSVeuqqojsJcaGmifzo
   w==;
X-CSE-ConnectionGUID: tvWMdh1UQBuYUIUnZfaqIA==
X-CSE-MsgGUID: tyzuE3KgSfqjtTziF1wxrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89741725"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89741725"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:24:23 -0700
X-CSE-ConnectionGUID: 6LKV0QSpSM+cPWNOoL2p2A==
X-CSE-MsgGUID: 8+dZhKKESHKxVLx2cNDnsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="277220906"
Received: from amilburn-desk.amilburn-desk (HELO kekkonen.fi.intel.com) ([10.245.244.203])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:24:21 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 049BC121089;
	Fri, 11 Sep 2026 19:24:25 +0300 (EEST)
Date: Fri, 11 Sep 2026 19:24:24 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Steve Longerbeam <slongerbeam@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] media: ov5640: Initialize mutex before probe cleanup
Message-ID: <aqQrOJ2qcu1d3RBh@kekkonen.localdomain>
References: <20260910081608.1264077-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910081608.1264077-1-runyu.xiao@seu.edu.cn>

Hi Runyu,

On Thu, Sep 10, 2026 at 04:16:08PM +0800, Runyu Xiao wrote:
> ov5640_probe() can jump to entity_cleanup when regulator setup fails,
> before sensor->lock is initialized. The cleanup path unconditionally
> destroys the mutex, so this error path passes an uninitialized mutex to
> mutex_destroy().
> 
> Initialize the mutex after media_entity_pads_init() succeeds and before
> ov5640_get_regulators(). This keeps earlier direct-return paths outside the
> mutex lifetime while ensuring that every path reaching mutex_destroy() has
> initialized the mutex.

A single sentence should be enough to describe what this patch does.

> 
> Fixes: 19a81c1426c1 ("[media] add Omnivision OV5640 sensor driver")
> Cc: stable@vger.kernel.org
> 
> Found by PatchProof Module 4 candidates
> PILOT-4c6b03072e508260 and PILOT-4f9a36d855eb7c54.
> 
> No runtime reproducer was available; the failure path was verified by
> inspection and the affected object was built successfully.

This paragraph I'd drop, too. Please keep the tags together.

> 
> Tested-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> Assisted-by: LLM Codex
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/media/i2c/ov5640.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> index 8deb5f550..36c8bb345 100644
> --- a/drivers/media/i2c/ov5640.c
> +++ b/drivers/media/i2c/ov5640.c
> @@ -3930,12 +3930,12 @@ static int ov5640_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	mutex_init(&sensor->lock);
> +
>  	ret = ov5640_get_regulators(sensor);
>  	if (ret)
>  		goto entity_cleanup;
>  
> -	mutex_init(&sensor->lock);
> -
>  	ret = ov5640_init_controls(sensor);
>  	if (ret)
>  		goto entity_cleanup;

-- 
Regards,

Sakari Ailus
