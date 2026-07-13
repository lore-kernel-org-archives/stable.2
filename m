Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253F3D0910;
	Mon, 13 Jul 2026 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933449; cv=none; b=Qu8Izlv37iQ6vCzyliU541UjSAsiP8DSZKNmuSnB68tfc5aXU8EiQc61hCd1vOVjR0yyEkXLxKkcFLksuTlUgXf/FjUTXjbnVPXomFFyRt1Ewf2QMeVfZZEvRrQHSR+yA07nCv6Yb63Hpg1fOBybcCdJ0sEZ9NEJzsQC4Mbz4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933449; c=relaxed/simple;
	bh=K/B9Jar5GXEGS3ZtBkahTtghczLbjNej/Lz+ODFIUgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ry8lRBQwxo/PGoLOLE15BlTDuXn6ofzELZtpWa2FhsaNeAQjxP93oyARvGG0+xHcuSxfA7/xTwkVmoc+EA8Tf4WCjpwoQdBq95vjpjWdjGF7/r8tg/NsAw7tCa62C2kwyd5CiCW9wNa5Gj4lSo8MDUJvBNOcmmLTtSHtbvXcFdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJDs5x8s; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJDs5x8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783933447; x=1815469447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K/B9Jar5GXEGS3ZtBkahTtghczLbjNej/Lz+ODFIUgg=;
  b=cJDs5x8sl9nTT5hytYuLp767PoT4S2GhaB9NtS6EdE6m+QYtsu4rzk0H
   VR9FuTCfNwu/juYUAf2hGlPViS41d26Coh8WZgf37z93BNEmy5SxfZeWY
   jFVyJZ1nRTl4hN+khuhOAypoXbsJC2/pbwf427pSmWm8blo8NRz22q/Ts
   dQFOkpvR51e+urcTgszLgGuclm/Q1Tx30D5qS160dYTk2zhHrngltDTtV
   Gpe/JZosYDA4jr3nht41rX6OiJ0inP0Ovwrfbrdh9R10L6cyxguePB9lu
   CMv4CB26ypuUROhfXm0p7UGltRxlYnifss8itEyvLRYGyS2COdsVsjy6j
   g==;
X-CSE-ConnectionGUID: s/dtWW/3Rfeg3bZS0FSXMQ==
X-CSE-MsgGUID: 4HlOhMSoT2iZICO9AVbzdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84653689"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84653689"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 02:04:05 -0700
X-CSE-ConnectionGUID: +KxS+KV4TB2hftdK4O3/oA==
X-CSE-MsgGUID: EINWM0ImSm2Tu/cxwgVEFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="249134004"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 13 Jul 2026 02:04:03 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 6AAA695; Mon, 13 Jul 2026 11:04:02 +0200 (CEST)
Date: Mon, 13 Jul 2026 12:04:00 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: class: drop PD lookup reference
Message-ID: <alSqAJRbeeLpJ1P9@kuha>
References: <20260704231436.4060902-1-shuangpeng.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704231436.4060902-1-shuangpeng.kernel@gmail.com>

On Sat, Jul 04, 2026 at 07:14:36PM -0400, Shuangpeng Bai wrote:
> usb_power_delivery_find() wraps class_find_device_by_name(). That helper
> returns a device reference that must be released by the caller.
> 
> select_usb_power_delivery_store() only needs this reference while calling
> the pd_set callback. Drop it once the callback returns. Otherwise the sysfs
> write can pin the selected USB Power Delivery object and prevent it from
> being released on unregister.
> 
> Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

Revieved-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2:
> - Cc stable@vger.kernel.org as requested.
> 
>  drivers/usb/typec/class.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 0977581ad1b6..0595e8cb83aa 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1619,6 +1619,7 @@ static ssize_t select_usb_power_delivery_store(struct device *dev,
>  		return -EINVAL;
>  
>  	ret = port->ops->pd_set(port, pd);
> +	put_device(&pd->dev);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.43.0

-- 
heikki
