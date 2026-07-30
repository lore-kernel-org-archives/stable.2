Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2B9411671;
	Thu, 30 Jul 2026 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414594; cv=none; b=fjWWRvHkKM1MxN+/wawnnLZa5KM4ya8roIUg0HJW5wOixcOQrD+VBQA+UBBtTJjgAyfv/IDl0J96/xCgMJxb7Ghm6Bys5imS/vxIPh94SHofO/CvUdAcZzuHz5GqQiPqSD3nLI1hD+MeH5CmzaRZTLI/BI8Y9PLpRXu7KPWlYxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414594; c=relaxed/simple;
	bh=OO/SE1PwhpajyMbmM2qT0kMyzsBUzzKtu8jgtvCBiE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsiDs0Yn/QM+PAeSE7HeLQgOr1HBBXQ8RBdynfxwxUQvlepK/a8WA0+OgMgxFlNvcK87PVzcLcc7scQHCUXhmjwgZI0JOK/uPR93QUtNCF2jG0cvACOQs7vl7ZCfKreVfMADVZ5JwFh1ummmLxJIInpx/jGeV3+cIgiISqqxbzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFyUf4dR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFyUf4dR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785414592; x=1816950592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OO/SE1PwhpajyMbmM2qT0kMyzsBUzzKtu8jgtvCBiE0=;
  b=cFyUf4dRe+eOsrgSvGyg/iftDLmfM0mYjY2fmWSwcEFhlKf45Syv9Lix
   UwonmXt91L4QQT8XPM6TjH4BpYOtRVJ4sUKk9ifxMnFZQmc4im7B1hmTM
   8vWlKii5wLVrbLqieCGN79cSs5/cu+dNAU2hI+QH4Rfvhci4ccqYmVCqq
   EY4iScDb9FY1fe9IDmS5d8eQmRJ5yqTzgNK+BUU5mI3ekNOffvSr89yjW
   pOcB0BCudCe34FoOtL7mmXHhuvKqyhZg19I+uub151qse7Q4AhSWcJbzY
   p4I0kkIjUT02hqdyiSOzf6RTey/S8b+60+z1agw7pda0yj5njfCyHuoEc
   w==;
X-CSE-ConnectionGUID: 9P4gY5khSwGgnh+w9lt/Rw==
X-CSE-MsgGUID: 6reNcY9WQCeUQ6IwEyB1tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="89712425"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="89712425"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 05:29:51 -0700
X-CSE-ConnectionGUID: jkRxFni7TQWU5acaCyekJw==
X-CSE-MsgGUID: PwXQ/QiXQ8CZulru9stBfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="264561145"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO alaakso-desk) ([10.245.246.85])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 05:29:49 -0700
Date: Thu, 30 Jul 2026 15:29:45 +0300
From: Antti Laakso <antti.laakso@linux.intel.com>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: israel.a.cepeda.lopez@intel.com, hansg@kernel.org,
	gregkh@linuxfoundation.org, sakari.ailus@linux.intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	13667453960@163.com, stable@vger.kernel.org
Subject: Re: [PATCH] usb: misc: usbio: check ibuf_len against rxbuf_len in
 bulk msg
Message-ID: <amtDubB1yNk1JGXG@alaakso-desk>
References: <20260722101810.458634-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722101810.458634-1-yijiangshan@kylinos.cn>

On Wed, Jul 22, 2026 at 06:18:10PM +0800, Jiangshan Yi wrote:
> ibuf_len is the bulk IN (receive) buffer size, but the EMSGSIZE check
> in usbio_bulk_msg() compares it against txbuf_len — the bulk OUT
> endpoint size.  Both are taken independently from different endpoints
> in usbio_probe(), so the check is wrong when they differ.
> 
> Use rxbuf_len for the IN direction.  This matches the buffer that
> actually holds the response data.
> 
> Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  drivers/usb/misc/usbio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/usbio.c b/drivers/usb/misc/usbio.c
> index 3c2474dca810..fe093e7760d5 100644
> --- a/drivers/usb/misc/usbio.c
> +++ b/drivers/usb/misc/usbio.c
> @@ -265,7 +265,7 @@ int usbio_bulk_msg(struct auxiliary_device *adev, u8 type, u8 cmd, bool last,
>  	lockdep_assert_held(&usbio->bulk_mutex);
>  
>  	if ((obuf_len > (usbio->txbuf_len - sizeof(*bpkt))) ||
> -	    (ibuf_len > (usbio->txbuf_len - sizeof(*bpkt))))
> +	    (ibuf_len > (usbio->rxbuf_len - sizeof(*bpkt))))
>  		return -EMSGSIZE;
>  
>  	if (ibuf_len)

Tested-by: Antti Laakso <antti.laakso@linux.intel.com>
