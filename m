Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C210A3DEAF6;
	Thu,  6 Aug 2026 21:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052272; cv=none; b=JPjZurEsd2quQT49ysp9YXcjhlBBu3Hu9uASihtpEuvR5YHTJMYcYMKdZ8ya1FmHuXrJ37BqoKNnyEGc6pMPEZB6s6mLxfQ0Rih4iBiU5sxoiF55x/D2SkDjjQl2xaJ+oIZk7sHYVm69OD86aH6TJ8NCJYbSGpeCHgJt6CYwCGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052272; c=relaxed/simple;
	bh=mjGVUIQVFQSUlNRTElAwT9SVkk1YkNAmsTb3lxEI7Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/76i0ES6UZL6+9LY+aGVTrXI7I5YgcAsUIQmv+aLzWO56dKm0+5zXTleYRU6j56u0E1ONdh4uFCFFUaQTDo5se7SG5fGZfgWjBfOx0wPESpCBtO2oBRySPUTYQpC2qiBayepjfj/HddBrR5g2JHrPnBRv7vnZMSnupqClTuR5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9zwjhgt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9zwjhgt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786052271; x=1817588271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mjGVUIQVFQSUlNRTElAwT9SVkk1YkNAmsTb3lxEI7Tw=;
  b=n9zwjhgtE5AS6dFziqyk2eFIUrudfexsHuiOxE3RrktIZrxKYpFzKsRG
   We4h/7OXhwnMCRbVAGhPt9IbvgcTfTw4TDhZ15D+Ai9UhZmf5DtSu42vG
   +5xrj5Ob4UBBo/RxkkebNw1jfQlofDRTOQcDiVAYtS2hQXK9plnsu8jlc
   VTQUNUzYW/N0cCNG0kmiJbwq9QYhbe5QBqmQv76dfg5GGmg/3JfxuYzDb
   7PMyM8ZmtVyDXrNG/jxLJQoI8FZ7TLjdFI8xmRz5+OuXAze8zhJ2XVebF
   Ug9yVItR7YlKg0Z+VD/ycwfLyPop0rn9tY4rl1wWLIlctwipfARqhfYdE
   A==;
X-CSE-ConnectionGUID: N4jsXghkRcWxuJkrO4ieXg==
X-CSE-MsgGUID: QCllghm2T/6+T/jn5GcfOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="74199394"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="74199394"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:37:50 -0700
X-CSE-ConnectionGUID: q2z1aFAzSP6ZvmILdJpalQ==
X-CSE-MsgGUID: ve2ZWh9wQKyOPW9r8bgqYQ==
X-ExtLoop1: 1
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:37:46 -0700
Date: Fri, 7 Aug 2026 00:37:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>,
	Maslov Dmitry <maslovdmitry@seeed.cc>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/6] iio: light: ltr501: Power down chip if request
 irq fails
Message-ID: <anT-qMXnSJ2BL9x2@ashevche-desk.local>
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
 <20260804-liteon-ltr329-v3-4-c6b768c7c745@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804-liteon-ltr329-v3-4-c6b768c7c745@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 04, 2026 at 07:02:15PM +0200, Esben Haabendal wrote:
> In case devm_request_threaded_irq() failed, we were leaving the chip
> powered instead of powering it down again. Power down the chip switching
> ALS and PS modes to standby.
> 
> The dev_err() message was causing duplicated error messages, as
> devm_request_threaded_irq() calls dev_err_probe() on failure.

> Fixes: 7ac702b3144b ("iio: ltr501: Add interrupt support")

Be careful with this. The removing of the error message should either go
separately, or you should be assured that the IRQ core prints it for you
in all stable kernels where this goes to be backported.

> Signed-off-by: Esben Haabendal <esben@geanix.com>

-- 
With Best Regards,
Andy Shevchenko


