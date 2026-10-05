Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D547CC61;
	Mon,  5 Oct 2026 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207687; cv=none; b=RMoK0+BiVdTPjDbaj8+L79eK7laHu6jB9q47ef/j9m7tfIE0HO+oLYTLLWvhcnR7qXqBoRU6XnUG9WDHHiEXrBIkxH+bm1hLiAoUK+5Lkzf4YxaMY2FiUHjHS3dP0qMZRLVkT55OSOQyXuL7MeSB2TVr1Db4wjALe0VkRP/sprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207687; c=relaxed/simple;
	bh=Its1uLI0Y7rFTMZltg1TOVMxLOEmgb3xiZrFUQigsE0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=taBKh6lBR7Kc5AFJ2LbaOLspXPSGCZ86R30yyO/PtfmYXmG+/7lLn01su4xvDQPhIiB0eB8ng2hpIcETTQFUCeWqoYmLUSyFP2VWtJ5GX9zWsTpYxzQ+gVT/yO5O17ea8tX7XFiGhdOgGHYXVmVoH0iK5u97LBrihssvVv6Laig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YNPo21cb; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YNPo21cb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791207686; x=1822743686;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Its1uLI0Y7rFTMZltg1TOVMxLOEmgb3xiZrFUQigsE0=;
  b=YNPo21cboTKOI+N8w22KRlDA0mwuXyMSr1VmXvwtCvqV/sk95y171IGV
   ZRdd6cD8NE95tvvFzW7OgSbBHJe0Qdvcvcly9b21JC81pH/LqfumR8YKp
   kk0JJZxmz9cmwG16i3+a/roKb47N3+OfFg9AGYuzdg33lyefCuyZz/WbS
   GUIEkFOs+zx6sZFEtdwrWFYnUby8mge2tRokijXD/ds5RX/9cL8CZYbnD
   loot88+5bXRxSZct+J+xiPRwmz4uF75RvfKXjf3lEYkh6M1y8tJOCkxOt
   cOWF+Q79eL2vemID+piTaB9hs22NrGXZis1yOcMt73gK88gOtu3pwfPs7
   Q==;
X-CSE-ConnectionGUID: yTwc1wopS7yPnNmeYeDnRA==
X-CSE-MsgGUID: mgXUBHmWRcC4jxSGnKzBCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="117395291"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="117395291"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 06:41:25 -0700
X-CSE-ConnectionGUID: zl2w/f3/TH6eDlbSJGz8fg==
X-CSE-MsgGUID: pvbg3saRQUCYrzbTzRrGNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="275463252"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.199])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 06:41:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 Oct 2026 16:41:18 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v4 8/9] platform/x86: hp-bioscfg: NUL-terminate the SPM
 auth token
In-Reply-To: <20261002191434.58529-9-meatuni001@gmail.com>
Message-ID: <ec29e795-2b9a-36de-490e-64bb843d5dc8@linux.intel.com>
References: <20261002191434.58529-1-meatuni001@gmail.com> <20261002191434.58529-9-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 3 Oct 2026, Muhammad Bilal wrote:

> auth_token_store() copies the token with kmemdup(), which does not NUL
> terminate it, but hp_calculate_security_buffer() and
> hp_populate_security_buffer() treat it as a C string and read past the
> allocation.

Again here.

If something is treated as C string later, how is it valid to prepare it 
with kmemdup_nul()? I just don't follow that logic.

Either something is a string or it isn't, which way this is?

> A lone newline (echo > auth_token) is worse: kmemdup() of 0 bytes
> returns ZERO_SIZE_PTR, which passes the NULL checks, so a later
> attribute write calls strlen() on address 0x10.
> 
> Use kmemdup_nul(), which allocates one extra byte for the terminator
> and never returns ZERO_SIZE_PTR.
> 
> Compile tested only.
> 
> Fixes: b2715aa2e135 ("platform/x86: hp-bioscfg: spmobj-attributes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
> Changes in v4:
>  - New patch
> 
>  drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> index f0eb5c445..19f0f9f16 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/spmobj-attributes.c
> @@ -316,7 +316,7 @@ static ssize_t auth_token_store(struct kobject *kobj,
>  		length--;
>  
>  	/* allocate space and copy current auth token */
> -	bioscfg_drv.spm_data.auth_token = kmemdup(buf, length, GFP_KERNEL);
> +	bioscfg_drv.spm_data.auth_token = kmemdup_nul(buf, length, GFP_KERNEL);
>  	if (!bioscfg_drv.spm_data.auth_token) {
>  		ret = -ENOMEM;
>  		goto exit_token;
> 

-- 
 i.

