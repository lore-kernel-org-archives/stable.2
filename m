Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E764F93B5;
	Fri, 18 Sep 2026 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789739669; cv=none; b=IIkHYsgtq9037IuuFjB0gGXyL/5rJ+CUU39S3K7nfp0YxL9MwMMzs4jcLRcFUBA++6RvQ0x7OXWEiAUPC5x+G210yaktLfm8+6bsArTOE0VpP+k0TO3kesDrdOXJbC+mF8gWXwpFu/nTQljEwF1lX0NbSkmZ6sJ7cBAul54wDJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789739669; c=relaxed/simple;
	bh=AuMiDhFMblXy0IqBDjT1yFy4y+GlouICGZTNEKp77JE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cf7Ev8hVBgdc5X0rWTjkY+KzK93Nkol22C/cFpFJmA0aMnKYkUgfgZm44AJqFPYAzgtGn2BgbER3RXLhhj0UtLsf0V7O689J3w8l/9/a9Cg3EvwHDWNnI4e271jWPHhFFH8Ca3+UFkKcdSf0N3ES1Rh4Y0dRketseHHhcUlYC5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LckJnu9C; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LckJnu9C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789739665; x=1821275665;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AuMiDhFMblXy0IqBDjT1yFy4y+GlouICGZTNEKp77JE=;
  b=LckJnu9CiiENDJrmWxq/5ESJyIPenvFk5m3gRXv5gOt3txrlCuqc2IjW
   Pi5yxkSVK+NQVf1bVQo3P1EBeISKfN4kF2zXaRmQES24EDl/Mm8pQMIu7
   2uq8o+27ziZVUWrFoTILKs2V9kGvMLsUaOSYLhPT1sazzRwavLeFWoO2t
   cdusNqr85i4PePRF9c4a1B2I2Nsfoprq3IW/+WjBtMNV5EQLMuqVzfvgM
   Gw2e5t0S6CgPURp8RVmxuOL0sNH14NyD/N93UVvEMPheHe+yyeUqhsyDX
   FgVmLx2xsoPKulIG+boXpiO4ROU1K+6Erf/0ZkOg9ot4TgzxthmAEmo22
   Q==;
X-CSE-ConnectionGUID: p/deSa/MTMWxNLssAF9hNQ==
X-CSE-MsgGUID: vp8mvx6WTwqczo7KUk6oeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="107750100"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="107750100"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:54:22 -0700
X-CSE-ConnectionGUID: dSIGPUQxTNm8gHvb5a2a7Q==
X-CSE-MsgGUID: X7xVVCUFR2ShCFu28xxsEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="2842259"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 06:54:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Sep 2026 16:54:11 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: jorge.lopez2@hp.com, Hans de Goede <hansg@kernel.org>, 
    linux@weissschuh.net, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/x86: hp-bioscfg: fix OOB read in
 hp_get_integer_from_buffer() on unaligned input
In-Reply-To: <20260824225610.18471-2-meatuni001@gmail.com>
Message-ID: <7dfd5559-5ad0-e12c-b26c-96abe139bc17@linux.intel.com>
References: <20260824225610.18471-1-meatuni001@gmail.com> <20260824225610.18471-2-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Aug 2026, Muhammad Bilal wrote:

> hp_get_integer_from_buffer() aligns the read pointer before dereferencing
> it:
> 
>   int *ptr = PTR_ALIGN((int *)*buffer, sizeof(int));
> 
> When *buffer is not 4-byte aligned, PTR_ALIGN() advances ptr forward by
> 1-3 bytes to reach the next aligned address. The bounds check that
> follows does not account for that advance:
> 
>   if (*buffer_size < sizeof(int))
>           return -EINVAL;
> 
> This only confirms 4 bytes remain from the original *buffer, not from
> the aligned ptr. If *buffer is unaligned and *buffer_size is between 4
> and (pad + 3) bytes, *(ptr++) reads up to 3 bytes past the end of the
> buffer.
> 
> *buffer_size is also under-decremented on every call, aligned or not:
> 
>   *buffer_size -= sizeof(int);
> 
> *buffer is advanced to the aligned, post-read position, but
> *buffer_size only accounts for the 4 bytes of the integer itself, not
> the alignment padding skipped to reach it. Each unaligned read leaves
> *buffer_size overstating the true remaining space by the pad amount,
> an error that compounds across repeated calls against the same buffer
> (hp_get_common_data_from_buffer() calls this in a sequence), making
> later bounds checks against *buffer_size progressively less reliable.
> 
> Compute the padding explicitly, check for it, and account for it when
> advancing *buffer_size, so the pointer and the remaining-length count
> stay consistent with each other.
> 
> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> index 0edc6e7cfa9a..32b99a862082 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -39,14 +39,18 @@ struct kobj_attribute common_display_langcode =
>  int hp_get_integer_from_buffer(u8 **buffer, u32 *buffer_size, u32 *integer)
>  {
>  	int *ptr = PTR_ALIGN((int *)*buffer, sizeof(int));
> +	u32 pad = (u8 *)ptr - *buffer;
>  
> -	/* Ensure there is enough space remaining to read the integer */
> -	if (*buffer_size < sizeof(int))
> +	/*
> +	 * Ensure there is enough space remaining to read the integer,
> +	 * including any padding PTR_ALIGN() introduced to reach it.
> +	 */
> +	if (*buffer_size < pad + sizeof(int))
>  		return -EINVAL;
>  
>  	*integer = *(ptr++);
>  	*buffer = (u8 *)ptr;
> -	*buffer_size -= sizeof(int);
> +	*buffer_size -= pad + sizeof(int);

Shouldn't all thse sizeof()s be based on sizeof(*integer) or sizeof(*ptr) 
instead of unbound "int"?

And is type of ptr correct? If it is, this lacks an underflow check?

This driver is such a nightmare... :-( Thanks for helping to clean it up.


-- 
 i.

