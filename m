Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CD94825D9;
	Mon,  5 Oct 2026 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206028; cv=none; b=eK/K5tAWa0xYY5y+oZRZyWAlqEGhtR6PgxibQoOR3gq2CFr2usHuvW3tBE00CEWXbQw6pwtCjbdVTmSMTgN6iBLkcFa82aYV9bZ0gx3Kiurz+BQOgmg/t6hRsD91mIipprORJxcAzAwY9PuG2vykWHrxrcs+3bLoRwNyVCprD9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206028; c=relaxed/simple;
	bh=jHYIbSaADz5P1gQxuCMHQV3cSCPTdVjdEGqvYaf9DMg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cYvcxeK6TIwQB8gvqEPHse+IN69bsMHarH21GtxFGO/tuGv8wWkvuXJtiJJxTJfvLERpEYoA6M0cDmCLFj7voektptq99fi2UVnS3jwQAtYo2RycQ39e1e+UBO7TiutkDZ3QNCcTmkg6rWD1TtnuL9uNtBBxNQZRbgDsQSEz2Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFLk0JwG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFLk0JwG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791206027; x=1822742027;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jHYIbSaADz5P1gQxuCMHQV3cSCPTdVjdEGqvYaf9DMg=;
  b=GFLk0JwG30HOaDVlep5DvlDOJgWNsxbhuVnO61DEbN78bMkC2wmxD68t
   wMAyZiAYEVHc2HlTxcPvd0Liuu8VjWerZTjTihZkm3VEcogxk3+2k/o2/
   HejoUnvFB1lue/46RQYTVVte6obEnbivj1MRfcZHkedWbNKy+q0zd92qf
   CWjESveP6azTDndItLxlrIQYF01VZrxoImPNa1Q149xDCLRwCVQA8z6Zj
   LsDe1y6mWmkXy6H1rCm7L/O82EMDWQrRAWI6Tlg800Z2lDZ5GhkuoAy0t
   m+bcCE7F6HdiK9iTOnc1Y6YDNxQ4uKtWc3QuwCy7U3FANyCkHmxIEtJAx
   g==;
X-CSE-ConnectionGUID: 46aEwm8/SGaCFFzN5Tasig==
X-CSE-MsgGUID: WoTpnC+nRBSXkOonSPaJZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="90824816"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="90824816"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 06:13:47 -0700
X-CSE-ConnectionGUID: 2EAiuyU3RNuIH2fw3c2Tgw==
X-CSE-MsgGUID: NrO5WPpKQGCsSijM4yzicA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="314826421"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.199])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 06:13:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 Oct 2026 16:13:39 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v4 4/9] platform/x86: hp-bioscfg: allow clearing
 current_password
In-Reply-To: <20261002191434.58529-5-meatuni001@gmail.com>
Message-ID: <5522067a-b952-6e75-8e76-beda285fa4c9@linux.intel.com>
References: <20261002191434.58529-1-meatuni001@gmail.com> <20261002191434.58529-5-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 3 Oct 2026, Muhammad Bilal wrote:

> The ABI documents echo "" > current_password as the way to end a
> session, but validate_password_input() rejects an empty string when
> min_password_length is nonzero. The password stays cached, and since
> the previous patch the write also fails with -E2BIG.

After I apply a patch, it's no longer a "patch", so the wording should 
anticipate that.

> Skip the length check for an empty current_password so the write
> clears it.
> 
> Before the previous patch the write returned 1 on an HP EliteBook 840
> G2 (min_password_length is 8) but cleared nothing.
> 
> Compile tested only.
> 
> Fixes: 8646a3b5ee3a ("platform/x86: hp-bioscfg: passwdobj-attributes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
> Changes in v4:
>  - New patch
> 
>  .../platform/x86/hp/hp-bioscfg/passwdobj-attributes.c    | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> index 3f4c45d9b..f0551b455 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> @@ -60,7 +60,8 @@ int hp_get_password_instance_for_type(const char *name)
>  	return -EINVAL;
>  }
>  
> -static int validate_password_input(int instance_id, const char *buf)
> +static int validate_password_input(int instance_id, const char *buf,
> +				   bool is_current)
>  {
>  	int length;
>  	struct password_data *password_data = &bioscfg_drv.password_data[instance_id];
> @@ -69,6 +70,10 @@ static int validate_password_input(int instance_id, const char *buf)
>  	if (length > 0 && buf[length - 1] == '\n')
>  		length--;
>  
> +	/* An empty current_password clears the session password */
> +	if (is_current && !length)
> +		return 0;
> +
>  	if (length > MAX_PASSWD_SIZE)
>  		return -E2BIG;
>  
> @@ -97,7 +102,7 @@ static int store_password_instance(struct kobject *kobj, const char *buf,
>  		id = get_password_instance_id(kobj);
>  
>  		if (id >= 0)
> -			ret = validate_password_input(id, buf_cp);
> +			ret = validate_password_input(id, buf_cp, is_current);
>  	}
>  
>  	if (!ret) {
> 

-- 
 i.

