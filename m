Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794E395D98;
	Fri, 18 Sep 2026 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741090; cv=none; b=H1Xx7jhAMyYpuWCdsB8wmCIDq30SACT8iYG2KAeci9fkcry4gTfelYi3jX630jwp+/CJ7Vxxi7OhbJhlrjFcVnrZVGlop+WPbkKVSTOTmDHUa38/SlMeZjrEFmYzSK+r04gKME3Q/HUmz9Ll9CvQigsT2Zl3GdWKfaV5W/fo5dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741090; c=relaxed/simple;
	bh=z30lrQPWTLUK69YDeqm3Vt6qZbUGZk0KZ8R+9cEMCm8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YAC8c5X6PFRHTyZfukowahF0TTBX7WWWBhmS6P6McjPPDxfmAWsOpkPxDFLdI4UCaNuf0mclQYGI7fcXPVPqLVqrdMZAz/5unEFbpHBvIgDmNNzeb15Dxt6megUXc5r1nnZKHbQl4ybkuy11vYipSZTTaddP0GtDhGvQb7D8Cmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mISaDRCY; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mISaDRCY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789741088; x=1821277088;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=z30lrQPWTLUK69YDeqm3Vt6qZbUGZk0KZ8R+9cEMCm8=;
  b=mISaDRCYXeCL/pVAE/sfBIGpMNTkA9+W9RnZdR4CEoZ1E2c97ym0XUNF
   SlkBaLXH3A+dZb8o+SqcGTUTuJUvsMGGiTW1L/Ag+Wu1PvOvsGQETi9Zz
   aaEqowlJWL9rfUS7rww1eVHowNaDcV2o/ReFEXyFLpUR9u9/esszMZRra
   2SNZxBbQCegMouPn+zeiqP57rlOfObMgPMWmb68S9gCwDsnFWUnJq6MLh
   aGfmx6Z2DLetO+r9ITWCe9URYrcRUo371NfIDE7E2ivm+pHQn1uEI+Hbg
   Y70CJJJ07oxDDPfqntjB3twUJ1ZSw99E1IJLYv7rLZfSqjFMBngkFMpg5
   Q==;
X-CSE-ConnectionGUID: unL72u6GQU+379p8i0zFuw==
X-CSE-MsgGUID: iIZfhZz0QzSrfDObbZy1cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="89385534"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="89385534"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 07:18:07 -0700
X-CSE-ConnectionGUID: 5YHrGFCoSziLXxLRRX/Bwg==
X-CSE-MsgGUID: r3ZJJ7rKTwyP6Q1b9i0Qeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="271742144"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.223])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 07:17:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 18 Sep 2026 17:17:05 +0300 (EEST)
To: Muhammad Bilal <meatuni001@gmail.com>
cc: jorge.lopez2@hp.com, Hans de Goede <hansg@kernel.org>, 
    linux@weissschuh.net, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] platform/x86: hp-bioscfg: fix heap OOB read and
 buffer desync in hp_get_string_from_buffer()
In-Reply-To: <20260824225610.18471-3-meatuni001@gmail.com>
Message-ID: <a67d4e52-5e87-0e76-4c91-cb8ba2be31f9@linux.intel.com>
References: <20260824225610.18471-1-meatuni001@gmail.com> <20260824225610.18471-3-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 25 Aug 2026, Muhammad Bilal wrote:

> hp_get_string_from_buffer() has several buffer boundary and memory
> safety bugs when parsing UTF-16 strings from WMI BIOS buffers:

Can these be fixed separately? It would help review.

> First, the loop that counts how many characters will need backslash-
> escaping uses the same variable as both the accumulator and the loop
> bound:
> 
>   size = src_size / sizeof(u16);
>   ...
>   for (i = 0; i < size; i++)
>           if (src[i] == '\\' || src[i] == '\r' ||
>               src[i] == '\n' || src[i] == '\t')
>                   size++;
> 
> Each escape character found extends size, which is also what i is
> compared against, so the loop keeps going past the buffer's true
> character count once any escape character is seen at or near the end
> of the valid range. Every escape character found causes one additional
> out-of-bounds src[i] read.
> 
> Second, once conv_dst_size is computed, the conversion call passes the
> byte length instead of the character count:
> 
>   utf16s_to_utf8s(src, src_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
> 
> utf16s_to_utf8s()'s inlen parameter is a count of u16 units: its main
> loop decrements inlen once and advances the source pointer by one
> wchar_t per character consumed. src_size here is a byte count (the
> code's own preceding comment, "size value in u16 chars", computes the
> true character count separately as src_size / sizeof(u16)), so passing
> it directly makes the conversion loop walk up to twice as many u16
> units as the source buffer actually holds whenever maxout does not
> run out first.
> 
> Third, the bounds check 'if (*buffer_size < src_size)' is checked after
> src++ has already stepped over the 2-byte prefix. If *buffer_size equals
> src_size, only src_size - 2 bytes remain, so reading src_size bytes
> reads 2 bytes past the end of the input buffer.
> 
> Finally, at the end of the function, the pointer and remaining buffer
> size are adjusted using the escape-inflated size rather than the actual
> number of input bytes consumed from the WMI buffer (sizeof(u16) +
> src_size), causing the buffer pointer and remaining length to drift out
> of sync for subsequent property parsers.
> 
> Fix these by:
> - Keeping the true, unmodified character count in a separate orig_size
>   variable.
> - Checking *buffer_size against sizeof(u16) + src_size before reading.
> - Accurately advancing *buffer and *buffer_size by sizeof(u16) + src_size.
>
> Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 29 +++++++++++---------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> index 32b99a862082..dd453a9b962f 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -60,6 +60,7 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
>  	u16 *src = (u16 *)*buffer;
>  	u16 src_size;
>  
> +	u16 orig_size;
>  	u16 size;
>  	int i;
>  	int conv_dst_size;
> @@ -67,17 +68,16 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
>  	if (*buffer_size < sizeof(u16))
>  		return -EINVAL;
>  
> -	src_size = *(src++);
> -	/* size value in u16 chars */
> -	size = src_size / sizeof(u16);
> -
> -	/* Ensure there is enough space remaining to read and convert
> -	 * the string
> -	 */
> -	if (*buffer_size < src_size)
> +	src_size = *src;
> +	if (*buffer_size < sizeof(u16) + src_size)
>  		return -EINVAL;
>  
> -	for (i = 0; i < size; i++)
> +	src++;
> +	/* size value in u16 chars */
> +	orig_size = src_size / sizeof(u16);
> +	size = orig_size;
> +
> +	for (i = 0; i < orig_size; i++)
>  		if (src[i] == '\\' ||
>  		    src[i] == '\r' ||
>  		    src[i] == '\n' ||
> @@ -93,9 +93,12 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
>  		conv_dst_size = dst_size - 1;
>  
>  	/*
> -	 * convert from UTF-16 unicode to ASCII
> +	 * Convert from UTF-16 unicode to ASCII. utf16s_to_utf8s() counts
> +	 * its length argument in u16 units, not bytes, so pass the
> +	 * original character count rather than src_size (bytes) or the
> +	 * escape-inflated size.
>  	 */
> -	utf16s_to_utf8s(src, src_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
> +	utf16s_to_utf8s(src, orig_size, UTF16_HOST_ENDIAN, dst, conv_dst_size);
>  	dst[conv_dst_size] = 0;
>  
>  	for (i = 0; i < conv_dst_size; i++) {
> @@ -121,8 +124,8 @@ int hp_get_string_from_buffer(u8 **buffer, u32 *buffer_size, char *dst, u32 dst_
>  		src++;
>  	}
>  
> -	*buffer = (u8 *)src;
> -	*buffer_size -= size * sizeof(u16);
> +	*buffer += sizeof(u16) + src_size;
> +	*buffer_size -= sizeof(u16) + src_size;

I really don't even understand how this function is even supposed to 
work... So lets try to agree on its functionalit first and if that makes 
any sense...

1. Function calculates some lengths

2. Calls utf16s_to_utf8s() to do src -> dst conversion

3. It overwrites dst in a loop by copying from src or escaping the src 
   char.

What is the purpose of step 2 if step 3 overwrites dst? Does this happen 
to work just because ASCII chars in src are <= 0x7f so the copy in step 3 
won't mess _most_ strings up??


-- 
 i.

