Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32943D45E5;
	Tue, 13 Oct 2026 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886020; cv=none; b=Usp2oh088REpKUG+Mdc3j934qbYZ/RGBr0eDYlivtzQv3eczrRZfMxvqpimhKZ1gpKcQHkgUyoAINF9gQAIW7+SORqH5xeBLqvjwY6onP7C/kk+VDNAAerGY992NbwKSg8NlYOqiZe+UJvmSsGwsmkt8mrq3B73+aaTxSxjwXWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886020; c=relaxed/simple;
	bh=dgq1IZdW3DciMm9JnLKA+2Zm1NZEdMi0ps/PO/zaXZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opkjb54aMchzmQCeD0EpTMOn8LX/ySs8Oythrpfn+3zc8C+FgQ9HpUCTEz6+60rkdkO7mGtqd83qWvymbf/LUYm2QX6wj5ZbYZ3251Lblm9Z3kVoU3lM6E2smEzFiUm9LJhzXPbP2Yev/mb6bS46Ohkcw2TlWsBGAEIHqKATzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNWkiN8a; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNWkiN8a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791886019; x=1823422019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dgq1IZdW3DciMm9JnLKA+2Zm1NZEdMi0ps/PO/zaXZA=;
  b=cNWkiN8artU9H/Rul0F3QOiNT6J3bfsWT1HgzeXIU7YLjAvNHoD/nFSZ
   7H8bxKP/zLIGqv4vAeyebOIZ1TDtNa9pcC3QOBgtuOS4fyHiiRQh2nGOp
   tb61Vmps4nEmt3VM8tQsMkw6pC7Hp433TRRcVRtm+6R/TgSiyXghlD7WX
   dgMsSrtOLGo82ilH7z4osmS/vnoN7ZqcXhZKZcwRg2jnCOcmgqcNxTgKc
   9TwPOnJB22+BL0lrKmZy6qNOBYg3nuKwnclWnnPqWw8akLsnIgU8vhGFg
   tSsdUFATJYMBC0+fACbEp85SPNMbHIYH7eS8udTQwsH+G1FDbG9jWcyGC
   Q==;
X-CSE-ConnectionGUID: PavVpg0lThuFbHLYBY70Yg==
X-CSE-MsgGUID: uH9I8ZulRXqFYKdV/MU5XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="615496"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="615496"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 03:06:58 -0700
X-CSE-ConnectionGUID: qczMn9lwRpuQ8EpKOX5Kxg==
X-CSE-MsgGUID: TSZAeIzoTLejTvWNDOfn6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1232172"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 03:06:56 -0700
Date: Tue, 13 Oct 2026 13:06:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yibo Tan <lhfff@tju.edu.cn>
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	=?iso-8859-1?Q?Jean-Fran=E7ois?= Lessard <jefflessard3@gmail.com>,
	Surendra Singh Chouhan <kr494167@gmail.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] auxdisplay: linedisp: prepare message before
 registration
Message-ID: <as4Cvc3PS4sLEjlL@ashevche-desk.local>
References: <20260912161152.1683002-1-lhfff@tju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912161152.1683002-1-lhfff@tju.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Sep 13, 2026 at 12:11:52AM +0800, Yibo Tan wrote:
> Since the line-display attachment support was added, linedisp_register()
> has displayed its initial message before calling device_add().  The
> HT16K33, MAX6959 and GPIO segment drivers implement display updates with
> delayed work, so that display operation can publish driver-owned work
> before the final fallible registration step.
> 
> If device_add() fails, the registration error path releases the display
> buffers and the caller's probe failure releases its managed private data.
> The admitted worker can then access both freed objects.  In an HT16K33
> KASAN reproducer, a real device_add() -EEXIST failure produced a
> slab-use-after-free first in __pwq_activate_work() and then in
> ht16k33_seg7_update().
> 
> The vulnerable kernel queued and executed the freed HT16K33 work in three
> of three runs.  With this change, the same three runs reached the same
> device_add() failure without queuing the update and produced no KASAN,
> WARNING, Oops or panic.
> 
> Separate message preparation from the hardware update.  Prepare the
> initial message before registering the device or attribute groups, and
> only invoke the non-failing update after registration succeeds.  Apply the
> same ordering to linedisp_attach(), which has the same static pattern but
> currently has no in-tree caller.

Yeah, but this will fix only work queueing and not the whole issue as was
earlier noted (about allocation of the private data in the driver and using
it inside the auxdisplay core. Can we rather redo the _register() / _unregister()
APIs to follow the design that is used, for instance, in IIO subsystem?

-- 
With Best Regards,
Andy Shevchenko


