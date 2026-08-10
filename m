Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E80282F06;
	Mon, 10 Aug 2026 04:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786337065; cv=none; b=pJU4zJG1sp1Ob4UkV1fLScOI3BWMf9+fbmqrT24s9CJdkUI3plc4mReVlqTNntPwvQGawFiv1VtsUX0S/Nr1Ob8uxAIX0WlEl1IonHEGwEeLioABxuYGlEbzf7I9lqj6Z5uDvnmsFaxS9lr5e75skib1NBWwZVjWbLwdzJKVfw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786337065; c=relaxed/simple;
	bh=hk/sy57+YYgPjt/LWf4TWSBfwUCC6ANmbZjTdcVKbOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLeu5gJuJtxgaT7RJXBLlZvqgV/q3ZBhT48jQvpHLdkmG9kNwxPJBbSHjDmwdeHSJR68dSOIUOk1UCJisQhWlhkFhJhzKVbAoRWcvvhF16l5jegcaxL7hPd2RxhLDojvpglNOFcVRKwgq+PatM5X93BPoyFrPszIH8BX05bK0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/G0ZpxK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/G0ZpxK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786337063; x=1817873063;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hk/sy57+YYgPjt/LWf4TWSBfwUCC6ANmbZjTdcVKbOQ=;
  b=Q/G0ZpxK9wE9guFmiV83tKiOJUQcM88DaLbHGqdU/V0YpAd5luvm7lIo
   gydMO3kYnGxPqmExqCI5rahknPjmq2ZEpHEoV2aUJ1ctRLwZMjO7AJAqg
   7dlv2UikJtW0mu7hl+nhlCb9FaYY52Et1JPG0T0WaeFgddidwHiGhzaaf
   YuycXnQtO3/tFhlDQheaEip6/WtBBiMnjiSEvvoh/VhpWXj6UAtI4UhPN
   1kVfF3lLhZhXvPhmvfak1FiJVJhFBzyqDLk+tnTB3d6hKuc0frKOCelKQ
   j37JblYD/2vNkeMET22hrVs3uitQjptyk5z0kNMfpMpgwa5FkIizapn7X
   A==;
X-CSE-ConnectionGUID: chB6S0+wQ0K9ZtfjktUrHA==
X-CSE-MsgGUID: gDUmiWBVTs2D6fjtyy7L8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86603378"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="86603378"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 21:44:23 -0700
X-CSE-ConnectionGUID: HLI33W2dTkiuw8MN8Wu8Kw==
X-CSE-MsgGUID: xVmBqZ5YTkGisihorCP0aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="259611325"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 09 Aug 2026 21:44:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 298EA99; Mon, 10 Aug 2026 06:44:20 +0200 (CEST)
Date: Mon, 10 Aug 2026 06:44:20 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>, Ben Dooks <ben-linux@fluff.org>,
	Dirk Brandewie <dirk.brandewie@gmail.com>,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] i2c: designware-pci: fix autosuspend cleanup during
 teardown
Message-ID: <20260810044420.GD893316@black.igk.intel.com>
References: <20260809073055.2980971-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260809073055.2980971-1-lgs201920130244@gmail.com>

On Sun, Aug 09, 2026 at 03:30:55PM +0800, Guangshuo Li wrote:
> i2c_dw_pci_probe() calls pm_runtime_use_autosuspend(), but
> i2c_dw_pci_remove() does not call the matching
> pm_runtime_dont_use_autosuspend() during teardown.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped.
> 
> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
> 
> Add the missing pm_runtime_dont_use_autosuspend() call to the driver
> remove path.
> 
> This issue was found by manual code inspection.
> 
> Fixes: 18dbdda89f5c ("i2c-designware: Add runtime power management support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
