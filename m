Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C74A9D78;
	Fri,  9 Oct 2026 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542535; cv=none; b=Dn3WX1Gr2Wg2aWcKZCFyMq+9sC55xsuq9tuesgLcv0sbl9gp4laBGtedhGJbNBsZZtpCvTWP6QZBKo63mVKEqKQwlbyg9xQvQZdOdYSwzCb6HvE1S/Y+0VBc80UoEuuUVHTHXlhg8QcevboRbFU8QUPKMrFPTaX/6B/zkXkyI8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542535; c=relaxed/simple;
	bh=G8zZEauSW2lGtU4vcEDrk63phvBJmfc8HD0fIorPZms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dO4My3psi46jZ7afBxa6GF5S9Bj04IagdZClMLJl14VEG5JUlQgRTcnI/GgXLPd//VKSuiLS7kLk3zPTDzQn/Upu5j5tNpubXZNbf34v1/eD+fsF0dr9yFYBGF5qwkwcIFbIqxRlZXi5i/xy8tCsUvfrXR5Ph/11UlclnSh8hzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7yc3uVk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7yc3uVk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791542533; x=1823078533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G8zZEauSW2lGtU4vcEDrk63phvBJmfc8HD0fIorPZms=;
  b=l7yc3uVkgRbuIN1sKMtjzcSm73bCVBtRN6LUD6IKXzwcw/2+U5mbJBv+
   hWxU++kOt+sYbgv2TBb0UZIyPxirX9gTbbaSaY4zDcBW1YJ6wrO/dTxJH
   Tp3M+mIDG+ngPIiTWALcGnFWj1amvMLpwo9R+feeRiTMgtmorrU8GY0bd
   9+T2SQv/I1jLY8WJHLfTf4aoeLQr0ROq24vcMF9oiRUseXvepMZZM91pE
   TwNTA7PSMdntkkjGGrgj+D5Ezi1U6fICLQNuHiFW2P0g18DeE3K4sFi1Y
   y58OFo+bZ3kkc7WKc4/wTNEnSIJkMAzgLCOIjR64TyToEx2AoL7Z5FQIZ
   g==;
X-CSE-ConnectionGUID: BVYz+PnhRZaj4oos/TXQ/w==
X-CSE-MsgGUID: HTexCIlWSz24/TTfcbOLmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="233187"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="233187"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 03:42:12 -0700
X-CSE-ConnectionGUID: 4cnk+2VyRpWJ1hx8FiEWow==
X-CSE-MsgGUID: LBnXbz/ZSYC5oGBccZMycw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="227168"
Received: from rpolaka-mobl.amr.corp.intel.com (HELO alaakso-desk) ([10.125.109.76])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 03:42:10 -0700
Date: Fri, 9 Oct 2026 13:42:05 +0300
From: Antti Laakso <antti.laakso@linux.intel.com>
To: praveenpuglia@gmail.com
Cc: Miguel Vadillo <miguel.vadillo@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mehdi Djait <mehdi.djait@linux.intel.com>,
	Marco Nenciarini <mnencia@kcore.it>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: i2c: cvs: Leave the privacy LED to firmware on
 Synaptics SVP7xxx
Message-ID: <asjE_UdsewYa4kjz@alaakso-desk>
References: <20261008-cvs-privacy-led-v1-1-b78d5c512cba@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-cvs-privacy-led-v1-1-b78d5c512cba@gmail.com>

On Thu, Oct 08, 2026 at 08:39:37PM +0530, Praveen Puglia via B4 Relay wrote:
> From: Praveen Puglia <praveenpuglia@gmail.com>
> 
> The Synaptics SVP7xxx (06cb:0701) quirk sets ICVS_HOST_PRIV_CTRL, so
> SET_DEV_HOST_ID tells the CVS firmware that the host owns the privacy
> LED. Nothing in the driver drives it, though: V4L2_CID_PRIVACY is a
> read-only placeholder. The firmware then never turns the LED on and the
> camera streams with the LED off.
> 
> The host has no way to drive it on these machines either. On the Dell
> Pro Max 16 Premium (MA16250) the only camera LED that INT3472 exposes
> is the IR flood LED. The out-of-tree Intel vision driver sends
> privacy_led_host = 0 for this bridge, and the LED works there.
> 
> Drop ICVS_HOST_PRIV_CTRL from the quirk (quirks 0x7a -> 0x3a). The LED
> now turns on while streaming and the stream is unaffected.
> 
> Tested on a Dell Pro Max 16 Premium (MA16250) with v7.2.8.
> 
> Fixes: 8e2b43d2c10b ("media: i2c: cvs: Add driver of Intel Computer Vision Sensing Controller(CVS)")
> Cc: stable@vger.kernel.org
> Link: https://github.com/intel/ipu6-drivers/issues/417
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Praveen Puglia <praveenpuglia@gmail.com>
> ---
> This is my first kernel patch. I found and debugged this with an AI
> assistant (Claude), then verified it myself on the laptop: quirks read
> 0x3a, the LED turns on and off with streaming, and the stream is
> unchanged. Tested as a rebuilt module on Fedora's v7.2.8, not on
> v7.3-rc.
> 
> Marco Nenciarini reproduced this on the same laptop with Debian and
> v7.2.6, and found no host-controlled privacy LED pin in the DSDT/SSDTs:
> https://github.com/intel/ipu6-drivers/issues/417#issuecomment-5996738346
> ---
>  drivers/media/i2c/cvs/core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/cvs/core.c b/drivers/media/i2c/cvs/core.c
> index d4a3b9c3ba..3520325717 100644
> --- a/drivers/media/i2c/cvs/core.c
> +++ b/drivers/media/i2c/cvs/core.c
> @@ -72,7 +72,6 @@ static const struct icvs_device_quirk cvs_quirk_table[] = {
>  	},	/* Lattice NX33 */
>  	{ 0x06CB, 0x0701, ICVS_SKIP_FW_RESET |
>  			  ICVS_HOST_SENSOR_PWR_CTRL |
> -			  ICVS_HOST_PRIV_CTRL |
>  			  ICVS_FW_BUF_SIZE_256 |
>  			  ICVS_FW_HEADER_SIZE_256
>  	},	/* Synaptics SVP7xxx */
> 
> ---
> base-commit: 47324d3a5b3abd781295044d01d92d09f184e872
> change-id: 20261008-cvs-privacy-led-7d0f2327c31f
> 
> Best regards,
> -- 
> Praveen Puglia <praveenpuglia@gmail.com>
> 

Tested-by: Antti Laakso <antti.laakso@linux.intel.com>
