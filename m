Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728868;
	b=M9Cc6GeHyWwgN6k1U1CHzilLwUk80iHKxkqOW2/CnUBAWganpVkIiJxfNL61AG3ImZwr
	 JMF4mzBd0fHtUq/+GE1T+Va9IekUy7PkYZlqaMqlLuu0I7PpbPIXTQp0IeLUt0pAE86Jf
	 6CeJ32xW6ajpK/45vz/b6SfSMlYGdLweMG4M0PyaF1EFAou8oSO7CiCEs6dGR3p2YoOC1
	 tImO6UTXHqrIrtJvRESLqi4HEY6H1pUGLiFMRzkfVu+dh54szO7ikeab3ShP4FU3P3dMu
	 1Ky+lB46GSRzkXzrx4N/PRyoOkF7WoY5gyup/asLT2O0su+AVnZ1MnhWyUzVGX9fcfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728868;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=LihcftIqtHPBx/BrYp2PBuP9LehJ9ydf5sfAZouf5C0=;
	b=PfacG04jBFnvYWx99BvkuyRPJuZFGrWp4lmq0YIkcMuciJ7mVic8Dd7GFEuSRn6KvRih
	 HaShx7vC4d+Hya9fOMuvNK0fKI6+bToC9WDCmSeYHb26x739cMIqF5mACa3Pyq3avMHLJ
	 JoR126BslcDmZAnjvRWOuuv620VNkh7nYe3xJA8QfNmLnlsF2Ogc/BeDYfSRYRKveY1hO
	 M7WTZ6xMzsbcGtWrA23NxL2oA8o2RUw6icogbpHzIPSjZEx/eyClP+IAY3gI2IYabB4mA
	 bzEDwIQulkFghzB3iqCPp4PyiOrEBKzNhNPjMZyHtch0Cbytcd7akHvVGlMPlaxmtRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FU2td6Ru;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF3C606A31B;
	Tue,  3 Nov 2026 18:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FF3C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FU2td6Ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793728867; x=1825264867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZEu3T8PKR06aXeT5T9tiffD3wPOcQDLY2cPsllGkJb8=;
  b=FU2td6RuGbqAdYnvgUZtkmeutBvX9bpcs2/0aFbtMXWudPqrDxt6j0B6
   Iv6Q3DqoHgccS1ecdcOUsVDY0FhSQ7Y+IbJoxhvdn1iZaTA6tsAUp6P2+
   JbmAU9coLwBzF6Hss5XRxskV2cQhMcQNza6Jml1zjvPSGngIe7dchG/na
   EBvdZb/RjvLyanEVdHQIS8VhJIW6CsMpS7sbKDXChMvgIQwbt//UPasnX
   ixk+waBGEyKaq2jaNQd0Ajg9oo7rTnYu6BAoxpld/QdYrECVW05+tfdmU
   kb2VPA9wI7WyxnRUxhavBzyqA8IIIFWebKcw8u4txwEKJb8BAs600zx/x
   g==;
X-CSE-ConnectionGUID: BrLltAQpTYS94N2wauE2vw==
X-CSE-MsgGUID: GtqkIw9xTG6SJvmUT5mRfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2494043"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2494043"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:01:07 -0800
X-CSE-ConnectionGUID: QBmGdKfMTHyif7+/Dou+uA==
X-CSE-MsgGUID: r8oFF1v1SbyfMQy59H8d2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8271042"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 10:01:05 -0800
Date: Tue, 3 Nov 2026 20:01:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yu Zhang <yuz08559@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: trigger: fix use-after-free in
 current_trigger_store() on concurrent writers
Message-ID: <auohXrCmejLW20Ta@ashevche-desk.local>
References: <20261026100246.68005-1-yuz08559@gmail.com>
 <20261102034532.33246-1-yuz08559@gmail.com>
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
In-Reply-To: <20261102034532.33246-1-yuz08559@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 02, 2026 at 01:45:32PM +1000, Yu Zhang wrote:
> current_trigger_store() holds iio_dev_opaque->mlock only around the
> INDIO_BUFFER_TRIGGERED / trig_readonly checks and then drops it. The rest
> runs unlocked: it reads the current trigger into oldtrig, acquires the new
> one by name, stores it into indio_dev->trig, and drops the old trigger's
> reference with iio_trigger_put().
> 
> sysfs does not serialize writes to the same attribute issued through
> different open file descriptors (each open has its own kernfs_open_file),
> so two threads can run current_trigger_store() on the same
> .../trigger/current_trigger concurrently. Both read the same oldtrig, both
> overwrite indio_dev->trig, and both call iio_trigger_put(oldtrig). The
> extra put drops the trigger's refcount to zero while it is still in use,
> frees it, and a concurrent writer then dereferences the freed trigger.
> 
> With two sets of writers hammering current_trigger between two software
> triggers on an iio_dummy device, KASAN reports:
> 
>   refcount_t: addition on 0; use-after-free.
>   WARNING: CPU: 3 PID: 3467 at refcount_warn_saturate+0xbb/0xe0
>    kobject_get+0xf6/0x100
>    current_trigger_store+0x15c/0x4b0
>   ...
>   BUG: KASAN: slab-use-after-free in current_trigger_store+0x168/0x4b0
>   Freed by task 3468:
>    kobject_put+0x125/0x220
>    current_trigger_store+0x2cc/0x4b0
>   Allocated by task 3454:
>    __iio_trigger_alloc+0xc7/0x100
>   ...
>   Oops: general protection fault
>    __module_get+0x27/0xd0
>    current_trigger_store+0x192/0x4b0
> 
> Hold mlock across the whole operation so that reading oldtrig, swapping
> indio_dev->trig and dropping the reference are atomic with respect to
> other writers (and to buffer enable, which the -EBUSY check guards).
> Acquiring the new trigger with iio_trigger_acquire_by_name() under mlock
> is safe: it only takes iio_trigger_list_lock, and the buffer path already
> calls iio_trigger_{attach,detach}_poll_func() with mlock held.
> 
> The trigger swap itself keeps its goto based cleanup of the newly
> acquired trigger, so move it into a helper and take mlock with guard()
> in current_trigger_store() around the mode checks and the helper call,
> rather than mixing guard() and goto in one function.

...

> +static ssize_t current_trigger_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> +
> +	guard(mutex)(&iio_dev_opaque->mlock);
> +
> +	if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED)
> +		return -EBUSY;

+ Blank line.

> +	if (iio_dev_opaque->trig_readonly)
> +		return -EPERM;
> +
> +	return iio_trigger_set_current(indio_dev, buf, len);
> +}

> +

Drop this blank line.

>  static DEVICE_ATTR_RW(current_trigger);

-- 
With Best Regards,
Andy Shevchenko


