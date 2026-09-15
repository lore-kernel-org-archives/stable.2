Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019E3B42F6;
	Tue, 15 Sep 2026 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478996; cv=none; b=uj+Q7YgO6sg7w+fYijeG9rJdC8DkDNHrG4QaQRTPjV6rtGk6367k0wNqBsbdPCw1/nSK6upenOcDoYtTcMkaq8/DTTWUJzjcOHYRZ0uQmeaQGWf56TDfKGJ5FSsn5ZufyvOwGpxwomOWcue3Rdudna7OgKK7vIaVqYWbV5XxOB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478996; c=relaxed/simple;
	bh=ri2qq/jw753mYH6odikXnKMl5T5shxFd/q4wWGQpaeo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IIZZUNwakI7wkkiFKrwRKJdfPyaNMrvSgGC+Trk+EFUGNuJTWpexA3QBNnEgHsSQuZft5lNts3vHA3YDsQLd27iDmys4H9ubjdOtxLy5nQpupp4gyyBdXo1jwtlSxidP2OnmEI3WNzMFyT1vSgT91WRaNQTQxqqTuZ6HWWASqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3u9b6D1; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3u9b6D1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789478994; x=1821014994;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ri2qq/jw753mYH6odikXnKMl5T5shxFd/q4wWGQpaeo=;
  b=D3u9b6D1ziHHgGKXDaiUb0wkvZM6FK25g5sfNj9vHsbsOnLSoCuYnnW7
   ITTcLIkxeCandZpJ/No7BA3SoL3UvMoKI0xpW3bwnYnYTFAX6yQ4wiuzy
   b1DyFLvBFnkG/Z6tiw+NHuTL2t33T0QFEJkEm6Phdu+XbhLbOM+c00tIr
   TPcfgQoNeAst1HYJgc/ysBgPMy/x6MhSY9lay2Nb12EA/iii2tsFmIK1P
   v+uNP5pIeoVbL2gaGvrK29kUxg5PtnbSMfgeGAzfL97h8HqGLe5m8PD1M
   OYJStd2VkFtYXyO8hTJKVEXDxAwHcuhno53tMexd2HtU/W1okXONfixfR
   A==;
X-CSE-ConnectionGUID: 9GtwQ6SySQ+6BqpsU+5wPg==
X-CSE-MsgGUID: LrqCwuO1TqeDaAjObliwfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89856400"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89856400"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 06:29:54 -0700
X-CSE-ConnectionGUID: XBhhIZMoRIagdjbPA+9aZg==
X-CSE-MsgGUID: weR6e0KnQxaIIBX4A36w7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269333808"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 06:29:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 15 Sep 2026 16:29:45 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: Jorge Lopez <jorge.lopez2@hp.com>, Hans de Goede <hansg@kernel.org>, 
    =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: hp-bioscfg: fix slab-out-of-bounds write
 in hp_convert_hexstr_to_str
In-Reply-To: <20260802010921.7487-1-meatuni001@gmail.com>
Message-ID: <7a2fd1e1-6ed3-778f-2182-e4c199567599@linux.intel.com>
References: <20260802010921.7487-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 2 Aug 2026, Muhammad Bilal wrote:

> hp_convert_hexstr_to_str() sizes its output buffer using the raw
> hex-encoded input length, but the decoded string written into it can
> need up to two bytes of output per five bytes of input when escaping
> '\\', '\r', '\n', or '\t', plus one more byte for the NUL terminator
> written unconditionally after the decode loop. For a short encoded
> value the decoded length plus terminator can reach or exceed the
> allocated size, causing an out-of-bounds slab write.

Please try to improve the wording so that I don't have to figure the 
input and output formats from the code.

Does the input format contain leading 0x "0x09 0x.." which is decoded to 
"\t..." as that is the only way I can make the 5 -> 2 relation make sense?

I suppose you could add an example input and the resulting output. ...That 
might be enough.

> KASAN caught a one-byte overflow during BIOS attribute enumeration
> on boot, triggered by a one-byte encoded input value:
> 
> BUG: KASAN: slab-out-of-bounds in hp_convert_hexstr_to_str+0x6d8/0x710 [hp_bioscfg]
> Write of size 1 at addr ffff8881032e5d81 by task (udev-worker)/520
> The buggy address is located 0 bytes to the right of
> allocated 1-byte region [ffff8881032e5d80, ffff8881032e5d81)
> 
> Size the allocation to the worst-case decoded length, two bytes per
> five-byte input chunk, plus the terminator, instead of the raw input
> length.
> 
> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -442,7 +442,7 @@ int hp_convert_hexstr_to_str(const char *input, u32 input_len, char **str, int *len)
>  	*len = 0;
>  	*str = NULL;
>  
> -	new_str = kmalloc(input_len, GFP_KERNEL);
> +	new_str = kmalloc(2 * DIV_ROUND_UP(input_len, 5) + 1, GFP_KERNEL);
>  	if (!new_str)
>  		return -ENOMEM;
>  
> 

-- 
 i.

