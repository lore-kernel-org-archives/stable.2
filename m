Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193CA39A808;
	Wed, 15 Jul 2026 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784127607; cv=none; b=bUFGsWQizSYG/vsli41sc85YHpyaD6dsfK234FYzKJBWXNN3Imc4srSB4OHvN+1UepWxBQsv/3sMm0M8teywAAabp8XhP1ZOpAAkcYErzly58zbkMDn5XBKakjxbQcM4dUqbR/QMDOvolspsZ5BBjMFFToeORuPZFKzoNmwFQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784127607; c=relaxed/simple;
	bh=JiXROtKbxqQGZb8SthpIP65GDaAPPh7cLSX8uJOkRsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ3ki+s0HfZBcr9/4vD5/CqknK7EnUeu4E7nI3l2Omwu+pFGgB+cgudDj5wKBeehJ6CQTNGwRBIUFrwpIhmKBapiSdsUYSGGI75NBeW36/A+3hl6S5boVbz18GxaILrplWkTZG3n9YODUF7yP5x74Qiu33t0Ce1SW4s2FpiKMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwhvXuEy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwhvXuEy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784127604; x=1815663604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JiXROtKbxqQGZb8SthpIP65GDaAPPh7cLSX8uJOkRsg=;
  b=lwhvXuEymKWAR/SOXJss0DpSGtFHWhUo1FqQwWoUVabzq7ednnlOsZMc
   dPrZEPOWGmXw0RN2VWUH+ToHgMtmRNmhRzralgnXeBF4krQwokx/L71Ha
   WigBaz+dr9XwABEtvBfPvvgw7oV6Ckm86DDSV07pPAiei0zPCefnaa01B
   VkHm/DZ+NFj2xF64aM1DOnBoIjADQdGCnGxleUYsV51/+g4CuZgtxWi/U
   Av8zXFkxYQHGAyGfIbGUbFvmnRWHBg3Figc1GSOzfihSoPLFNA/c9W14R
   d1YQp0tZSqEB9DGRLwo9UWmawE5yQQMQDcn9wRsRsiBrydmJAjovXwvaC
   Q==;
X-CSE-ConnectionGUID: yd0VjcqbTxWIkqnCAw9HVA==
X-CSE-MsgGUID: lqhptcRQToWw2iyAtAoqOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110314469"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="110314469"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 08:00:03 -0700
X-CSE-ConnectionGUID: dmB0BYZpQcG2Uvu1+b/B0Q==
X-CSE-MsgGUID: wHMEosIsQnO3xw/BilGxyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="260022398"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP; 15 Jul 2026 08:00:00 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 43CAE95; Wed, 15 Jul 2026 16:59:59 +0200 (CEST)
Date: Wed, 15 Jul 2026 17:59:57 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/3] drm/xe/i2c: Fix the interrupt handling
Message-ID: <alegbWVPz6oI_yMA@kuha>
References: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
 <20260713155601.711389-3-heikki.krogerus@linux.intel.com>
 <alcoDtq2aul-tA_h@black.igk.intel.com>
 <aldYjL2pxA7QxoLN@kuha>
 <ald1HG6KzjWb9CUK@black.igk.intel.com>
 <aleEReNBnQMy3-1E@kuha>
 <aleSjGxhStAiqLk6@kuha>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aleSjGxhStAiqLk6@kuha>

> Hi Raag,
> 
> > > > > > -	/* Forward interrupt to I2C adapter */
> > > > > > -	generic_handle_irq_safe(xe->i2c->adapter_irq);
> > > > > > +	xe_i2c_handle_smbus_alert(xe->i2c);
> > > > > 
> > > > > [1] Can we move the below re-assert code to wq now? Or do you suspect any
> > > > > side-effects?
> > > > 
> > > > I think that you know this better than I do. But at this point
> > > > interrupt is cleared, so why should we wait for the wq?
> > > 
> > > When does AMC clear the alert signal? Is it when you query from the wq?
> > > If the answer is yes, there's a possibility we might end up with an
> > > interrupt storm here.
> > > 
> > > > To play it safe, can we change this as a followup if necessary?
> > > 
> > > Sure, I'll leave it to you.
> > 
> > I'll move it to the wq. There are no side-effects.
> 
> Can you check does this work:

Nevermind. I'll send the next version.

Thanks,

-- 
heikki
