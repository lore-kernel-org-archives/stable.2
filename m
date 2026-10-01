Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B59F44F568;
	Thu,  1 Oct 2026 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790878711; cv=none; b=Exp6FmDL4k6CwvO9HQrjnrgGzAJZYDmTmjkyCKrsocIIVuotzgWE034GhhRcnWmLj/1fW+k1d8GNrflaoLWTy0KqVPcAVvufRpYIKdlfwWnwTxgUVPO0NaoL/hB5qaSRLf9Ct8LZMMamwgTxKznU++Hd6NXL0FXd7FOx279wicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790878711; c=relaxed/simple;
	bh=IabwWKOswkpFd4HIBeDWnWJYOXJ4bYdDLIUepUooG3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBi9i0XH5C6DThJ+5aqLNKhfx3EoqCxPnNoIl2NS9d9brBoyUEPOkRKtfejGt8/LHlMYOAmbDCzzVWvkMn6dwGpqyZyFStMEeODV11VQuCpWngAacb3rmwvuK2AaU7Ip5tmriimqNeKWpyDGd0yXKNBOngNKNlEG8Tmr3PTu1K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVcd9hq4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVcd9hq4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790878707; x=1822414707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IabwWKOswkpFd4HIBeDWnWJYOXJ4bYdDLIUepUooG3I=;
  b=eVcd9hq47Ywurow9nlD0AiThzOlmRD51svtalwSaW/Kt5PUOOEdf0+lU
   CouHQmjRyrs/Zm3A0T1F8/z6OGpVHSHIOJLC3yymZCxfZyXOwMWe5U14J
   Sa1Oh2csa25VghZlUe5L4BH8bd9nlYHMLw4ldW9JBlldrzO+Grj6gU1R0
   nZ0hlehfSLaQsjokM3oCFpvIfx6PpZq3RbElHMo1VGlGiBafYi4R5Ffxn
   nks3VnoCq6GBD7iSgcJOJs8RV+U85e00IBEabvxgOMe1+2fWTUpEAxhnf
   y0jOl/fdS0YMiRW893ynfM9uMZH1nv7OgfwixzK0SvmeSVVtl2NFz/GCb
   A==;
X-CSE-ConnectionGUID: v++a9cwiSR+Iu3zZ+dCU1A==
X-CSE-MsgGUID: xR4ugUJLQRykPESE8e0tcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91665421"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="91665421"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 11:18:22 -0700
X-CSE-ConnectionGUID: v7RVLPY1SgGF+8A6XIEwiA==
X-CSE-MsgGUID: 790NtqA+S6KlwPhAmiBeKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="305557716"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.27])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 11:18:21 -0700
Date: Thu, 1 Oct 2026 21:18:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Imre Kaloz <kaloz@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI: Disable MSI for ULi M1575 EHCI controller
Message-ID: <ar6j6rx6dGaf6kpE@ashevche-desk.local>
References: <20260930191100.6127-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930191100.6127-1-kaloz@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 09:10:58PM +0200, Imre Kaloz wrote:
> With MSI, the ULi M1575 EHCI controller (10b9:5239) intermittently stops
> executing its asynchronous schedule. Control transfers time out ("device
> not accepting address", "device descriptor read/64"), the port is handed
> to the companion OHCI controller and the device ends up at full speed. On
> a configured hub the stall shows up as hub descriptor and status read
> failures. Only re-initializing the controller recovers it.
> 
> On a Sun Ultra 45, 65 of 800 controller initializations stalled with MSI
> and none of 200 with INTx. Each initialization is an unbind and bind of
> ehci-pci on the EHCI function, with MSI or INTx selected through its
> msi_bus attribute; with this quirk, 0 of 100 cycles of the same loop
> stalled. The stall reproduces on a kernel that already contains
> commit 0b60557230ad ("usb: ehci: Prevent missed ehci interrupts with
> edge-triggered MSI").
> 
> The OHCI functions (10b9:5237) keep MSI. They showed no stall, and the
> hub enumerated through them on MSI during the EHCI failures, so only the
> EHCI function is quirked.
> 
> The illumos EHCI driver also disables MSI on this chip, in
> ehci_register_intrs_and_init_mutex() in
> usr/src/uts/common/io/usb/hcd/ehci/ehci_util.c.
> 
> Until USB HCDs started trying MSI first in v5.9, the controller always
> used INTx. Disable MSI so it uses INTx again on this chipset.

Since it's tested on real HW, the quirk makes sense.
Thanks for report and the fix!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


