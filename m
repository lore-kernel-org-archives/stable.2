Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C6379CD;
	Sun,  5 Jul 2026 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783234445; cv=none; b=peTz6HhLBMyfZmGUst2jWZsapKgFcd70Od6NDaGiwntIzWY/2Lhvvxp0Q+BvA454iKhBZLRJ2XKYTFt8U8gnK1/ftaPYxMiBLj7njY5yrQzn4z5UDPMeMzvsWv/DNKpmHzAz7QtcWAajKQmd2Ips3obfCpNBPgQoozZJNBYIh+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783234445; c=relaxed/simple;
	bh=1K/oCZuBo1hej93gsuY/Nv6rhP03Rw0nTmUgc/UD1P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoEGqEWQnFA7xJ1Ony7MtVCp2aYQ7TjZB1K9/haQNEC9eDMPGuPyLDBqdnB16OpdIzoJi1DLHKFGvBUbPexIXKpOf6a5A5jeh3FjvYxOonzTWBdy+E9wPzTUvrWjEDZdXkHdUL5MpQCwUv6DPpM1nxU2Vo4HVICL3o+lTatW5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aawh5O+3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aawh5O+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783234444; x=1814770444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1K/oCZuBo1hej93gsuY/Nv6rhP03Rw0nTmUgc/UD1P0=;
  b=aawh5O+3BwvEB0scPfZOT3MqMrDQdeD8mhjEWvgu4rKVCOnfFKzmjDsA
   ZRZMZNbJCZxiFyRLVBm2bf5ORWmZWQUdpkTrN2t74STJXp1DbqEzwhze3
   ujE8s2X8w2Cl/GPPRPCxvtEJqOr8zYl28FcdSOXtsYLZ053lS03iSxAp3
   tzvRZlM5iDGqY49Az/yXmG+gKwI2P/kRJhY2v3uI0DL1Objrl4ZsLN//M
   9TJjkpci5G0c4/eEPgcJ+7astMhq5V+wWUnjDJszn+fJg38IWBSwdHF48
   QazE3Hr+MQaT6Wh/21gumUSWyHHmbtg9o7/n90WCTW7W5hE3BT1It/tJ0
   A==;
X-CSE-ConnectionGUID: /N+LxnvBSQSdPRw8vgZKEQ==
X-CSE-MsgGUID: kWJkL1a4QPCJzhoTx3YJsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11837"; a="83950814"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83950814"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 23:54:03 -0700
X-CSE-ConnectionGUID: q3kzJ0KDQSunDCzK/dXPRQ==
X-CSE-MsgGUID: aml1RhBoTS+Wqpj+3KZf0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,148,1779174000"; 
   d="scan'208";a="252959887"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 23:54:00 -0700
Date: Sun, 5 Jul 2026 09:53:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Melbin K Mathew <mlbnkm1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150: free irq before teardown
Message-ID: <akn_hlxkSDRG389t@ashevche-desk.local>
References: <20260705042731.388592-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705042731.388592-1-mlbnkm1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 05, 2026 at 06:27:31AM +0200, Melbin K Mathew wrote:
> bmc150_accel_core_probe() requests the interrupt with
> devm_request_threaded_irq().  The managed IRQ is released only after the
> driver remove callback has returned unless it is freed explicitly.
> 
> bmc150_accel_core_remove() currently unregisters the IIO device and
> triggers, cleans up the triggered buffer, suspends the chip and disables
> the regulators while the IRQ action is still registered.  A late
> interrupt can therefore run the hard or threaded handler while the IIO
> trigger state is being torn down or after the device has been put into
> deep suspend.
> 
> Free the IRQ at the start of remove so that no handler is running while
> the rest of the driver state and hardware resources are dismantled.

In general this is correct fix, but have you checked the rest of remove if it
has any communication with HW and if that communication relies on IRQ to be on?

(*yes, this is very unlikely, but please double check as rarely we have some HW
 that might need that, and in such a case the fix might be different)

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


