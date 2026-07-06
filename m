Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586F637D114;
	Mon,  6 Jul 2026 06:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783318301; cv=none; b=RU5Hueu3bFhpHd7Akbri2kv6ZVeiJzJ2Vm8ObsenrErREWSSyM3SbzobQxCbRMqtXGNWc4GysDFRRm3vIVdS2h88G3N88E1vFC2FZu+rWb1Ob/t3l0htNXfQ9YK7bQi9YcxyODwguDzaiVJgYemFlhQ0YQ9sIG85kYv4jT0TxMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783318301; c=relaxed/simple;
	bh=4FNyroCFzDU6GNKjynRdVC6aEFSJ5FrF9nGYQKVEJno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb9FBGWCwo0PDkzm4mlwDzr4Vpgfxv29O+cJPNvYCwKBCBPzv1naGW6QAx/kJqQYi1SMcKImKlXdVsS9jT9xI8K6j56iU9Uyfm4ncTK4CCr0571386wxCHFSuSU0Ia9/yXhBBytuNcZ+8vauIGQf8ZfnvV45XtOVa2zFFGNRNoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iojLuAK5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iojLuAK5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783318299; x=1814854299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4FNyroCFzDU6GNKjynRdVC6aEFSJ5FrF9nGYQKVEJno=;
  b=iojLuAK5nHUY3xQwXnfZIYk/oHkNMVfBv45g+p7IDafd/3CVKBb8QpC7
   p3uVdWV5AokeVzMzy+UuhUSnk/+QOF7FFWM7WuTMitULVCVTtNQB42INU
   vqHTcT/9NNyWO/cF7/Htg+ByxFp9BGoCMgijqaVgeZGNAPBL4wzhHDvKd
   qiFCEJUH4MR3MOjI5dmPLEDDxHQnxe4MSwAROmk6mr9Np6h+t3RmW5MS8
   YYKG2iPYZUS2uDPALuiT5LYXJvxrPVpajkayKUrUbzGKSo8WLZrB/k2uG
   YGZozk39F786nt4n1e/I3qN7OBh3ta8xZUS4rO3D6G0WxSvUvZHBAIXFV
   Q==;
X-CSE-ConnectionGUID: 1Ut1rkOSRDaoPL/ABOlqMA==
X-CSE-MsgGUID: M1TsP/leS1eyqLsdd+8s1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="95320269"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="95320269"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 23:11:37 -0700
X-CSE-ConnectionGUID: xDu7sIkMRyC6CeZEDnuUQA==
X-CSE-MsgGUID: Lgvpn3Y2RKKrz3wrv/Vn3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="255564397"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.48])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 23:11:35 -0700
Date: Mon, 6 Jul 2026 09:11:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Melbin K Mathew <mlbnkm1@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150: free irq before teardown
Message-ID: <aktHFWgrl76gi-oX@ashevche-desk.local>
References: <20260705042731.388592-1-mlbnkm1@gmail.com>
 <20260706000233.3104e0d3@jic23-huawei>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706000233.3104e0d3@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 06, 2026 at 12:02:33AM +0100, Jonathan Cameron wrote:
> On Sun,  5 Jul 2026 06:27:31 +0200
> Melbin K Mathew <mlbnkm1@gmail.com> wrote:

> > bmc150_accel_core_probe() requests the interrupt with
> > devm_request_threaded_irq().  The managed IRQ is released only after the
> > driver remove callback has returned unless it is freed explicitly.
> > 
> > bmc150_accel_core_remove() currently unregisters the IIO device and
> > triggers, cleans up the triggered buffer, suspends the chip and disables
> > the regulators while the IRQ action is still registered.  A late
> > interrupt can therefore run the hard or threaded handler while the IIO
> > trigger state is being torn down or after the device has been put into
> > deep suspend.
> 
> For me this raises a load of questions.

Oh, I was too quick with my glance on this.

> In particular having the interrupt
> torn down before we remove userspace interfaces (as occurs after this change)
> is itself a big source of race conditions as we have to cope with userspace
> being able to poke every interface with the interrupts missing.  So it is
> a design pattern I'm very resistant to!
> 
> Anyhow, is this theoretical or have you seen it in practice? i.e. can we test
> fixes? Are we talking spurious or shared interrupts, or is there a path in
> which a race generates a real interrupt? My guess would be the thread
> running a while after the interrupt but please confirm.  What is the effect
> of talking to the device when powered down? Bus errors, stalls?  A quick
> glance at the datasheet suggests some registers are fine, so this description
> would need to say which ones that are accessed are not.  I think it's only
> the fifo_data but I haven't checked the code or datasheet closely.  What
> actually happens if we access that register? An error or garbage data?
> 
> Maybe we just turn the power on again in the thread handler? Vast majority of the
> time that will just be a ref count increment and decrement, but in the race
> here it will turn the power on again so no problem accessing the device.  
> Or a local flag to say if accessing that fifo register is fine - if it's
> not just erroring out on trying.
> 
> We do have internal infrastructure to close down races around
> teardown (see the exist_lock and how iio_dev->info is set to NULL
> which acts as a marker of a device going away - maybe we need to make
> that available to drivers (though I'd rather not as it's easy to use
> wrong!) I'm not aware of any core interfaces such as accessing the
> buffers or open chardevs etc that are not appropriately guarded so
> hopefully the races you are seeing are just at the driver
> level. The usual route to handling this stuff is to make the interrupt
> handling safe to the transitions that occur on tear down, not reorder
> things to stop the handler running.  Note that making it safe
> can absolutely include simply returning errors from accesses that don't
> work due to power conditions.
> 
> > Free the IRQ at the start of remove so that no handler is running while
> > the rest of the driver state and hardware resources are dismantled.

> > +	if (data->irq > 0)
> > +		devm_free_irq(dev, data->irq, indio_dev);
> 
> If (and it is a very big if) this is the right thing to do then it must
> be accompanied by documentation of why we need the remove to not be in
> the reverse order of probe.  Also, rip out devm registration and
> move to none devm for everything after the request of the irq.
> 
> Note that because userspace interfaces are still up at this point
> we may well get normal operations generating unhandled interrupts, potentially
> resulting in the interrupt core taking that interrupt offline.
> 
> It is for this reason that we generally disable userspace interfaces
> first and then remove the interrupts.

Indeed, the current logic seems correct.

> >  	iio_device_unregister(indio_dev);
> >  
> >  	pm_runtime_disable(dev);

-- 
With Best Regards,
Andy Shevchenko


