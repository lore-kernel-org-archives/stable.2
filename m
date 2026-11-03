Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702932;
	b=IUGSRyB7jLS0MzkV0jPJFai4fR+RhyhYvR1CngNrVPPcckkSKKeu6Cm1g3UtRbbxWi40
	 uKXohgM8NZ+EYQMl8C5+XKJqOiRRiOY5jDeJtMuji1zKZZoE0kOjgCTWDBDzV0EjokrQZ
	 jtEvW1TfOuGDabjb3gFirt4X1Vp1WWKz27jUvxQgUPEo6QucNHMfoCmkQ8xRNoXoBR7JG
	 0ZhloIRuIv8yWzd4LYjujH/AjMstwZBtTLl5kOqmH9yw1C0TNxYAEU/66nJKMtqFnqEe1
	 zChzF42/x8hjblyfj/VpMrPpJtYrNyyEoBwyTzfZ8/KyjlLNM6R2j07kIfHZPdOkArQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702932;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=50pkaCz8b4z8jaQs9WghlsSPJli4Zqrxz0vpX2mV8AQ=;
	b=iy+rrkDxX/71/xqtsyJp35/rANs06UPrcZW2gTVPZwB8zzJyGVLajNDpnpFOAmanVLXM
	 TtyjuYpRLLEtMDwTiXc5oyRKLD3XMApldVfNlV87e0s7MMnl3zwRWSo3m9FROj/xOh+p+
	 EcGEOi5ZkifkCmI/6to9c2VUODK88D1B2OtD+RIyl/IgmBtWZH2uQibysDDpdjfnm282K
	 lIpgQNqdKw3Lqdeqp8FFfixbM8XDVUOYOjTYSEBvYyzGQS4PIKg9SxrM21lnJZq6Ern6H
	 toAprDT0RutRQzNA0wW0Nt24UsIb9J0opmMuW6SIAmMcvlmTAA88WZKFoi5Ak5HwX3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BVv1oYgp;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594B0606A332;
	Tue,  3 Nov 2026 10:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 594B0606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BVv1oYgp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793702932; x=1825238932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mv7pmrDh8sYJR4u7eLjn9aGpW2b0JTNwn14X6yW880U=;
  b=BVv1oYgpsvTKPJfvNiLo0h+3cb85RKp9wmxX9H/yYD3d3tax1JBzb+yc
   KtKQwGsINwDqqcAuBb3pOI4oD6HdczTyQhZMVZ8sUzD+0CDPxy0nLcV91
   ybSnMqh+TNzf+9w5YuRew/pSMfb1eOG9fpVZiyGsRmYA/3GtHoeSBXWRR
   pv5CUb84jTJA5vd9IK2bQUtvsqTUgMkUU2AAU4suimkS/fVx+2vJrcGnk
   UBYEocbPnvoj1tmWJgvT3DrL5Iehr917I8tQT90wtsAYrR9odcRB6iA5Z
   xP1yccyMNZ54++mF/xCU4J1PK9f6fy5y7lf7xvTCFJRUDel2o40cDYeDc
   g==;
X-CSE-ConnectionGUID: p3l42IIRTz2/W+l7URI9qQ==
X-CSE-MsgGUID: 2zZckBp0T3GfLhwfYnPUng==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2326282"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2326282"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:48:51 -0800
X-CSE-ConnectionGUID: wSPmumnPQXWrk1dPpk4ksw==
X-CSE-MsgGUID: 7RKJ6rh8RU24Fxi0vH6O/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6221460"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:48:48 -0800
Date: Tue, 3 Nov 2026 12:48:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/7] gpiolib: wait for pending label frees before
 cleaning up desc_srcu
Message-ID: <aum8DRhBqCOiEUsj@ashevche-desk.local>
References: <20261103-gpiolib-chip-removal-v5-0-aambrozewicz@nvidia.com>
 <20261103-gpiolib-chip-removal-v5-1-aambrozewicz@nvidia.com>
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
In-Reply-To: <20261103-gpiolib-chip-removal-v5-1-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 12:32:34PM +0200, Adrian Ambrozewicz wrote:
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
> Use srcu_barrier(), which waits for them.
> 
> Reproduced with a hogged gpio-sim line, setting the chip live and back
> on a 4-CPU guest with srcutree.convert_to_big=1: it warns within 60
> cycles; with this change, 1000 cycles pass.

...

> Assisted-by: LLM

This tag is obsoleted. Instead explain under '---' how AI has been used to
generate this contribution.

-- 
With Best Regards,
Andy Shevchenko


