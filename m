Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967512;
	b=bBR5uWB98i8JQRVVQf/lkaZW8QSi3zI4oTf+2hGxfrSpyvVjoRk1O+I3wmTfKyWrrjry
	 560u9snjFVhnoLy8ZqrP1t0VMOV3GSUr+xkuygWGqtTFIPFDNGCENNUKd4vE4fuW7f57g
	 IFaDuOz2fSRwSYQkobR2g4C3bYcmp77pacqmMfOr2cRWJFSod5lGqj9I11nhAx2CUwEbt
	 ViAdfsi7EVMrBG0kszrdF2TLv6FH4Q6c9pZrTZoML/IOFLPYCZVosGO+bWV20Rn371C5w
	 C4aieCMKUGWfCMidi9jOT+8KVaaXNCypoek5hbCYTY3thoeQGWCw8k4wkSXqaeAltSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967512;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=zCLXkYAKL0HKldd5qjdjzOdKmuBMa8ky/YhC47nvTcA=;
	b=ASzFk2+dRsqK7os5h16V3ISPMesT/Qq36AJAb7yYHdAFJxLDe+fOwnkCTKZFiBQ0qkAz
	 3kmMStW/3OZdqR2jUzJumj9ghfpQIL9E/q9IsrlPJ6IJXwCbZWRU9hJGvibJQwRsb9yTF
	 /uen4Ko4iZBz91zTfl0wK61ZJwZegntOgj5sIkAx+S30tTGHOZvcFgNJye0ebuL/5o1PS
	 pOUj51WUvTwZbbU0dxpcTBLYJW47BqC0VooFv0sw/BxPZEJGvQohsVao/uDVEGPnTn74P
	 +WiC1kSMIC6u7OD+SphWV5K+jI4wjR9HQUWJIqZNaAXajbiYNscP6CZGsMCl4m9he3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=doMYTeNd;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B70A606A881;
	Wed, 18 Nov 2026 02:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B70A606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=doMYTeNd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794967512; x=1826503512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c+DGJYiKoRxY19HXbBWcOxRfxZ9WSWBFgf/e7nZq9TA=;
  b=doMYTeNdu2w+yLeCFBR471221HUwQ/pJSYIApnG+2tpWNW3JEOv5v2Ux
   GxRSRYPyYdehNhLkprt5uquWjJnwWXU1XvVfUYhHVUtz1s8SC96FWraxI
   AGNs5VRfOcCZHWgQp6vsx0eUE6PogNw7hYfBp0ZI3OgZiBpug6q1QX7jT
   P9WuNMiYW/kpJrM+snTG4kelSfymWi3bOxPnmJARR4NWc0bZY+2zDActr
   F2wm6VLWktit/JlC9pircbempJ9/1PL+27DJEa1Q63ViBMH4URTkzP2BG
   i1IQcPixDZPfwm0Z32sZCNFm1aCa+5Z/+9cZDglmt30OMyT77hUK2HVuN
   Q==;
X-CSE-ConnectionGUID: dL+GrTgQTJChoH/yr/FeZg==
X-CSE-MsgGUID: OwoMtUBGThilgcfdaJW7UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3653104"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3653104"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 18:05:12 -0800
X-CSE-ConnectionGUID: uUkNA5I9TxiXFAOrntU3eA==
X-CSE-MsgGUID: px2HxreTQQaslvTkquyKjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10244426"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 18:05:09 -0800
Date: Wed, 18 Nov 2026 10:05:05 +0800
From: "Lai, Yi" <yi1.lai@intel.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 1/8] gpiolib: wait for pending label frees before
 cleaning up desc_srcu
Message-ID: <av0H0VfZM81smF55@ly-workstation>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
 <20261116-gpiolib-chip-removal-v6-1-aambrozewicz@nvidia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-gpiolib-chip-removal-v6-1-aambrozewicz@nvidia.com>

On Mon, Nov 16, 2026 at 03:47:04PM +0200, Adrian Ambrozewicz wrote:
> desc_set_label() frees the old label with call_srcu() on
> gdev->desc_srcu, and gpiodev_release() calls synchronize_srcu() before
> cleanup_srcu_struct(). synchronize_srcu() waits for a grace period, not
> for queued callbacks. Once the srcu_struct uses per-CPU callback lists,
> a label freed by gpiochip_free_hogs() can still be pending, and
> cleanup_srcu_struct() warns:
> 
>   WARNING: kernel/rcu/srcutree.c:706 at cleanup_srcu_struct+0x239/0x330, CPU#0: init/1
>   Call Trace:
>    gpiodev_release
>    device_release
>    kobject_put
>    devres_release_all
>    device_release_driver_internal
>    platform_device_unregister
>    gpio_sim_device_deactivate
>

After this patch applied, the call trace can no longer be reproduced.

Tested-by: Yi Lai <yi1.lai@intel.com>
 
> Use srcu_barrier(), which waits for them.
> 
> Reproduced with a hogged gpio-sim line, setting the chip live and back
> on a 4-CPU guest with srcutree.convert_to_big=1: it warns within 60
> cycles; with this change, 1000 cycles pass.
> 
> Fixes: a86d27693066 ("gpiolib: fix the speed of descriptor label setting with SRCU")
> Cc: stable@vger.kernel.org
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 6f8f30b767ef..ce04277a8900 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -897,7 +897,7 @@ static void gpiodev_release(struct device *dev)
>  	struct gpio_device *gdev = to_gpio_device(dev);
>  
>  	/* Call pending kfree()s for descriptor labels. */
> -	synchronize_srcu(&gdev->desc_srcu);
> +	srcu_barrier(&gdev->desc_srcu);
>  	cleanup_srcu_struct(&gdev->desc_srcu);
>  
>  	ida_free(&gpio_ida, gdev->id);
> -- 
> 2.43.0
> 
