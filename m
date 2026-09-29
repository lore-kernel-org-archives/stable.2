Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85B3E49C4;
	Tue, 29 Sep 2026 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679661; cv=none; b=pVynIAsd9lu9a73Fi5SYxTmAyCphrUdd722tdQWhivpbDeBfoQSAZZ2Dh0UtBfGkMXLaawb1Wjq5X6dRWbPJ7okgntflos8PyslMYBsNfiyRPC/a3OgZ+IDqTJMhr0srAfpKCZsuHx+iKTFPS5AsC1/wTsqV/AlDwiREPerO57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679661; c=relaxed/simple;
	bh=0pFXy/fdIRnNcAETTNDwsniCvI0wDKj5V/XTQICIkOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOJB30dHN4nQ41imzARBOHtw1WvVBXoBNCUZUUwbC/g/D1kmGn5tIxkz0+WWvIm9vMs4iuGCuKGGa6bF3eYwIiIxJKVnHTCh3OLjShLVniGfF6l+2IEx2f2h5WEaLhYdvpn9EG69QqqjQRvaHId7zCO1WeG7l87Yg+fJ5hZRp4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=is9HXH6p; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="is9HXH6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790679658; x=1822215658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0pFXy/fdIRnNcAETTNDwsniCvI0wDKj5V/XTQICIkOE=;
  b=is9HXH6pHSg4CaOrjP7p5x8+hMX7e644TQtFZPNx3YCkG34/w2TLbOy0
   I27Q6N9+uqS0e+AzailX43V/rJGX/qW4PecCqbmbtOQqqPLg+uRuc7Zb4
   dXUKOOvs/CDqboA2EeXBMF7Zde+gdrrmV/7oRRx6qyVjBdwZDJ/vR73AO
   Zc/nIwntE1wCUB9sOceGoOaVEf8DLHSyxYf+tMd0UwqbR3DTp6pjO3s8E
   jZq1QSOUqq2R4+lMLjdQxDQT2IwSPGPp6CBw+5jJV42cJa+1RRtP41dmD
   t7upk4c429CH7l/XNEdRlb6lE9vH6NPf+RlG7Fu3aVsPjYSX0ja9kXTTg
   g==;
X-CSE-ConnectionGUID: MsfeBCWRQFydpnCSTZj9MQ==
X-CSE-MsgGUID: OfA32epOQeiWIo2whhyz4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101919335"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="101919335"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 04:00:54 -0700
X-CSE-ConnectionGUID: 9LIAaicHSDWG8X1/qAB9TQ==
X-CSE-MsgGUID: 4N4uOVZmRdaU67s0dNEwaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="303302935"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 04:00:52 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 53C73121840;
	Tue, 29 Sep 2026 14:00:55 +0300 (EEST)
Date: Tue, 29 Sep 2026 14:00:55 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Weibin Liu <liuwb@xiaopeng.com>
Cc: broonie@kernel.org, wentong.wu@intel.com, lixu.zhang@intel.com,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: ljca: validate the response length before copying
 the data
Message-ID: <aruaZz_KQaGGXDH_@kekkonen.localdomain>
References: <20260929080126.4168981-1-liuwb@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929080126.4168981-1-liuwb@xiaopeng.com>

Hi Weibin,

On Tue, Sep 29, 2026 at 04:01:26PM +0800, Weibin Liu wrote:
> ljca_spi_read_write() only checks that the response from the adapter
> carries the packet header and a non-zero payload length before copying
> r_packet->len bytes from the response into the transfer buffer.

I agree the check is incomplete, but you need to still perform the check
for the header before accessing it.

> 
> The payload length is taken from the packet the device sent back and is
> neither bounded by the number of bytes actually received nor by the
> size of the requested transfer: a misbehaving adapter can announce a
> payload larger than what it actually sent, and the memcpy then reads
> past the end of the 60-byte input buffer and writes past the end of the
> caller's transfer buffer.
> 
> Reject responses whose announced payload is not fully contained in the
> received data or exceeds the requested transfer length.
> 
> Fixes: caee8e38da67 ("spi: Add support for Intel LJCA USB SPI driver")
> Cc: stable@vger.kernel.org # 6.8+
> Signed-off-by: Weibin Liu <liuwb@xiaopeng.com>
> ---
> Reviewer notes:
> 
> - r_packet->len is a device-controlled field; the old code only
>   required it to be non-zero before memcpy()ing that many bytes into
>   the caller's buffer. The receive buffer is LJCA_SPI_BUF_SIZE (60)
>   bytes, so an announced payload larger than what the adapter actually
>   sent already reads past the end of the input buffer, independently
>   of the transfer length.
> - The new check bounds the payload by both the number of bytes
>   actually received (ret) and the requested transfer length (len), so
>   the copy stays inside both buffers.
> 
> Tested on x86_64: with this patch applied the driver builds, loads and
> unloads cleanly; no LJCA adapter is available to exercise the SPI
> transfer path on hardware.
> 
>  drivers/spi/spi-ljca.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-ljca.c b/drivers/spi/spi-ljca.c
> index 0c6e6248d..bd07e5df9 100644
> --- a/drivers/spi/spi-ljca.c
> +++ b/drivers/spi/spi-ljca.c
> @@ -105,7 +105,8 @@ static int ljca_spi_read_write(struct ljca_spi_dev *ljca_spi, const u8 *w_data,
>  			    (u8 *)r_packet, LJCA_SPI_BUF_SIZE);
>  	if (ret < 0)
>  		return ret;
> -	else if (ret < sizeof(*r_packet) || r_packet->len <= 0)
> +	else if (ret < sizeof(*r_packet) + r_packet->len ||
> +		 r_packet->len <= 0 || r_packet->len > len)
>  		return -EIO;
>  
>  	if (r_data)
> 
> base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
> prerequisite-patch-id: e48582f6ffe124b3806593af6e22b74682c8a83f
> prerequisite-patch-id: 369f74b9a7ecde56141b13ec671f9200345a3bab
> prerequisite-patch-id: cbf6f60473c80add5b2cddf22d142f35a4e3c834

-- 
Regards,

Sakari Ailus
