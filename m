Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264596;
	b=3qnIl8qaV/Aki1cV5BR3XZQh7mB0Rn110MaJhYd8ucctSm82vFW9rFUr32EWgHNhi9o2
	 LPWN2inPXJRJqChBUeaGTcDHUoCm7xXFGEE/ECf3mRR1VuXrii9z7B/zoFL+xJLv4Tvf8
	 8Pe9n0FqkOjeEvS9DgpkJW1DCdauNFxQ86NdhvZKv603af537W1wCGP6p4cYc6wItvUWz
	 W611CH947/arOj8xeCIrTNussj8QJAglWvuO89tfm6TPs8yNUBgHfmRS+wl/ET4bZnToG
	 mwoLWpISFnYOVm8tgkezSCrLS0NTmjs9riaaK4Lw32/v1dz1ixb/lTS0l7V5OxeAbHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264596;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=hf+yqNYutAL2aRXI265QMA+VjlewtD9d2PAyBCFW/tY=;
	b=3TkJ4iL0ktEjz4/BPHJC8iaVHEv7f9m3kvmBQpZXxyDpNe3WzHVexQ5BmqYFMeiYFfJ7
	 Z8nE4/FN1YYJpaRKFgKjCf7DfaYAMiI8GXl+WYaaq8X1KA8CSn7fIkCfsNRx/NDaoWKgc
	 m/hQsKBXl0fdp9a1gR+I239HHfoXNXDCjazwqS+lGRjrNCl9pCjs6dbDRQFQf7d1OSoNl
	 BxoKXORMgbJUno63ZNLUu9C0ML1HzlsleZ5QYSOcTZV49SryHtyT76LpKjEMbSxMnkZrM
	 eaz9Edraptzaok0KLQ1LpyzpoAhwQP7GKjfSeaJaLhqqAiYe1hKpjIOAweTzD0GQsKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="WMC/eAkC";
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4415606A31C;
	Mon,  9 Nov 2026 22:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4415606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WMC/eAkC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794264596; x=1825800596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V7lq3Nojdk4Wi4HvLSchpdyNNJVzu2RqwGA3f0BC3wI=;
  b=WMC/eAkC2kw3STiIZDmNczvCnO2zwU+ooPQiVvlyFCLdIV5LAFW1KmqX
   0sr1rHwz3ECvpBO9cBZb+sw0HrswBs4Widk689beMqs5riElw2hkekD4O
   nHyF2hiY7WPLz9N/nFx2yptdQtOezBXJ2rgfEIgcURjCBSwhGnKDumpWc
   aFdidFmpWcFgBHS8k50PNl7s+15jmqU9k8ccp68RkhTNoKJFKePs/Upug
   tDHWFqI//eMO3mVe28I7ui05qfxV6O2HJzM2PDEDc3YMZaGeKtxAzkOFK
   qv/GafwJuzO6hCbP9NNqKZL21xt+YB6HTNEynN3c2gm1Zl+v8CXU7cIPN
   g==;
X-CSE-ConnectionGUID: 7NwHCjzRT7avopTVuLHI9w==
X-CSE-MsgGUID: griNA61wSD6DQccTCp7udg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2995970"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2995970"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:49:55 -0800
X-CSE-ConnectionGUID: g8JDfDVAS4SVWzVWmZmJxg==
X-CSE-MsgGUID: vtYgExP0SwSsDgFv8Tk78g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="9770089"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 14:49:53 -0800
Date: Tue, 10 Nov 2026 00:49:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sergey Khimich <serghox@gmail.com>,
	Sia Jee Heng <jee.heng.sia@intel.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: dw-axi-dmac: poll the correct enable bit
 during termination
Message-ID: <avJOD_jpXRpvspY1@ashevche-desk.local>
References: <20261108-submit-dw-axi-dma-stop-pause-v1-v1-0-c48ec19e9ee4@gmail.com>
 <20261108-submit-dw-axi-dma-stop-pause-v1-v1-1-c48ec19e9ee4@gmail.com>
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
In-Reply-To: <20261108-submit-dw-axi-dma-stop-pause-v1-v1-1-c48ec19e9ee4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 08, 2026 at 10:02:36PM -0700, James Hilliard wrote:
> For channels 16 through 31, the channel enable bits occupy bits 32 through
> 47 of the extended DMAC_CHEN register. dma_chan_terminate_all() only reads
> the low word and tests BIT(chan->id), so it can conclude that an upper-bank
> channel has stopped while its actual enable bit remains set. Descriptors
> can then be freed while hardware still owns them.
> 
> Poll axi_chan_is_hw_enable(), which already handles both register banks
> and the smaller channel layouts, instead of constructing another mask.

...

> -	ret = readl_poll_timeout_atomic(chan->chip->regs + DMAC_CHEN, val,
> -					!(val & chan_active), 1000, 50000);
> +	ret = read_poll_timeout_atomic(axi_chan_is_hw_enable, enabled, !enabled,
> +				      1000, 50000, false, chan);

With a single argument it's readx_poll_timeout_atomic().
While at it, you may use 1 * USEC_PER_MSEC and 50 * USEC_PER_MSEC instead of
plain numbers.

	ret = readx_poll_timeout_atomic(axi_chan_is_hw_enable, chan,
					enabled, !enabled,
					1 * USEC_PER_MSEC, 50 * USEC_PER_MSEC);

-- 
With Best Regards,
Andy Shevchenko


