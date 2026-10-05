Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17AF48B36A;
	Mon,  5 Oct 2026 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206785; cv=none; b=eurqbLV0MAA4E/1jMT6jYLpGUdpkJXLTDZWaPNRFnImXJUzxwLc1G7VblcW3E0FsuG4uyK+4TA4plnVaB7yXpn0x7EhWRo9wZ/tQlgLMkb/fZ+4V9iIZk/YxHheWftyYkKjxrJ/NtrJoYW9S/HkoInO/VX8bJC3h1OLS5p+kE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206785; c=relaxed/simple;
	bh=woRWU3EZt7kxCDcOyyqviz/xWJvgT5f9srtLPq7RCrA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gN4B3yFVrTSfCnJBKWNDIQFX0Vxa+8roZhj/95QNGNGX5+7ku6eYqz/qJBW69PnpZG/xN441Zi1TSSqRyWscShKjihSHd/l8WoPLHLtSaeHng5fFbHbL7AalOmNJcKoW82ddlQ9Qn/NMbpwZGgtHi0AKOQSr/8YaqoPNl9u3guQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kk2Kb3yw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kk2Kb3yw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791206733; x=1822742733;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=woRWU3EZt7kxCDcOyyqviz/xWJvgT5f9srtLPq7RCrA=;
  b=kk2Kb3ywRptnRl5wpK/EY7pFHqd3PxPQ9fSTXQh+bV17TMZBNcyMx6P7
   lKiJv9Wp8dunMWPI1guGmn6D0lZqkPRQDSeNEdrYgRxLaV0+womCYMEXB
   kQqajjLKnNE6S18nVmcdWOMBPVSRTMQMFeYIfYEYzRViGWgkTGfAjGzUo
   bQ8mwB5nvalK7iN8Gxs3cab2Ah/nMTYEqI1KoGM2RxBbH78jgxKYu68Lh
   x91h80Oar8Eh0yDG8u1dlWU4bgjJm6jcfbQCHMsrkAhYj+Liih0CU4uqP
   rf99ZkxwSEIzqnsGyfEVm01+1IcvOPltztKnmlFcf3i3CF4PRKygy6XSM
   Q==;
X-CSE-ConnectionGUID: 36ZOpGjGTIqJbM7In5pl/w==
X-CSE-MsgGUID: /iJVR8fmTvWzQEHgTh478w==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="90933100"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="90933100"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 06:25:22 -0700
X-CSE-ConnectionGUID: A71FfODuQ2eZtQile0P+tw==
X-CSE-MsgGUID: nAE8NuefSfaf2ho26GYizQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="276944873"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.199])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 06:25:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 Oct 2026 16:25:13 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH v4 6/9] platform/x86: hp-bioscfg: fix heap OOB with
 embedded NUL in store paths
In-Reply-To: <20261002191434.58529-7-meatuni001@gmail.com>
Message-ID: <67806c30-fb5a-1871-442f-8037a06c1c9c@linux.intel.com>
References: <20261002191434.58529-1-meatuni001@gmail.com> <20261002191434.58529-7-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 3 Oct 2026, Muhammad Bilal wrote:

> The store handlers copy the input with kstrdup(), which stops at the
> first NUL, but pass the full write size to
> hp_enforce_single_line_input(). With an embedded NUL the copy is
> shorter than count, so the helper reads, and can write one byte, past
> the allocation.
> 
> Writing "A\0" followed by 4093 bytes of "B" to current_password makes
> memchr() scan 4093 bytes past a 2-byte copy. On an HP EliteBook 840 G2
> running Linux 7.2.7 all 100 such writes fail with -EINVAL although the
> input has no newline, so memchr() matched one in the heap. A userspace
> replica under ASan reports the same 4095 byte read, 0 bytes after the
> 2-byte region.
> 
> Use kmemdup_nul() so the copy is always count + 1 bytes long.
> 
> Compile tested only.
> 
> Fixes: 5f94f181ca25 ("platform/x86: hp-bioscfg: bioscfg-h")
> Fixes: 8646a3b5ee3a ("platform/x86: hp-bioscfg: passwdobj-attributes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>

I don't understand this change.

What is the usecase for using the input beyond the first NUL?

> ---
> Changes in v4:
>  - New patch
> 
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.h              | 2 +-
>  drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> index ac57d6eab..77cb9cac1 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
> @@ -326,7 +326,7 @@ enum hp_wmi_data_elements {
>  		int i;							\
>  		int ret = -EIO;						\
>  									\
> -		attr_value = kstrdup(buf, GFP_KERNEL);			\
> +		attr_value = kmemdup_nul(buf, count, GFP_KERNEL);	\
>  		if (!attr_value)					\
>  			return -ENOMEM;					\
>  									\
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> index a2f50ecbe..6c123d7a5 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c
> @@ -93,7 +93,7 @@ static int store_password_instance(struct kobject *kobj, const char *buf,
>  	char *buf_cp;
>  	int id, ret = 0;
>  
> -	buf_cp = kstrdup(buf, GFP_KERNEL);
> +	buf_cp = kmemdup_nul(buf, count, GFP_KERNEL);
>  	if (!buf_cp)
>  		return -ENOMEM;
>  
> 

-- 
 i.

