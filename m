Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591217;
	b=jb4F+Rk8/v1KUsq8Nq75ikPPtbGEBq1leyFM+hilfWWsfXT/jL45hkmR+i+0aZ9iylyF
	 rB8DxPvTITC98pJJw0iWq4kIiaExbwevTz3BeWb21zNxUA1hkfNRA0SjKqaKCP19saYN5
	 tKZzgqXdguD5J8XIH/VWkJWB+3aYl0aMOY54s5t2yVPdowBsIk0yf6iAD3/PCOkVWntLN
	 uZVU9NXxPePLbxvsEqg64o2TXcvWBCuuSrr1Tze/3iiwiqP4cTFrTt4B1+Vsn6Z8Y7jwA
	 fn8qIW/Yq32qpnE+XcTZayHTJTeG+d0slDHnz3gktUKxro9osB5O3bMq6tn67etkMcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591217;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=e54v2sXDpXMrvOIRvuJWrskKuA/9bxwpK1+m7psog2g=;
	b=PMKfN9fQJYCg7OmglGmpsRmoYFhpe6aGTMvxbtCtePLvKX5UTSruP/Q7kt0pkP7a2PPo
	 7TB8zwjsF31hKrQn7eN4ROXSn+1AkihA8jEel49r7gUwvBGwfRnRJTbg5tl0kRWS8IzuM
	 uX1qpJ5NlShC8gDXhcaZk/0NtpYcmO0edfUnPygHMAJEYSmWfJlnt/gk8WBEXYDMeAuuN
	 s7s7spwL60MaPcq+/ftBJyBnCaITk4UGpg3C2U/YvlQoZs37CGagqElU7HQS78JElvOui
	 0RtQE5VQ2X+dy8McvU1wdQXonZweK579/TOnYgSBa6af3yKev6F6FUW0xULG/WAvOug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Y/u/IBLE";
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5930C606A31B;
	Wed, 21 Oct 2026 14:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5930C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y/u/IBLE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792591216; x=1824127216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5LBM5+UAfH4pTOtJLNmTz3V90cHmGa/1nHPHhl+paT4=;
  b=Y/u/IBLE5END4Qj1ceKVRbvqpCCJ9aqr9vjQF8OUjfJv+2R79Y328L9C
   FoTyWKj6EcqQeYfYRAGrbTtgRaqqrzbccH8NYmZ+r1elNCHcxleYWbwi4
   r7ln1ALfFvFMCCHGY58LNmlhzwiAj8vzKSmiC9gVp+is732j3wEavIefK
   8h9p2FIzSeh0Q2yPZzpDMs31tdHRUAMbvPOY8Nuc4rhEuZSAHday0fh3D
   8GpnyQzTxxAQCAAb+dTy2cmqNCU31bGwCWQoJMeVsd3INxu8qfWxsL8yP
   zXpQDYUEeVy7wRX/TSRs9OcjTd7W7I0s/a+uzzcEEFRp8aywkKJvD+SXa
   g==;
X-CSE-ConnectionGUID: Oezi0kkmTcu+vq7MGKP9CA==
X-CSE-MsgGUID: oQ2cXQgUScGfEibsKBklEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1414540"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1414540"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 07:00:16 -0700
X-CSE-ConnectionGUID: ziacZsOlSdGtF2YRQU78Yw==
X-CSE-MsgGUID: 0OVA9fH4QYq7LQfsN0UpSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="4860352"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 07:00:13 -0700
Date: Wed, 21 Oct 2026 17:00:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>,
	Chong Qiao <qiaochong@loongson.cn>,
	Corey Minyard <corey@minyard.net>,
	Huacai Chen <chenhuacai@kernel.org>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 02/28] mfd: ls2kbmc: Unregister GPIO GSI via
 devm_add_action_or_reset()
Message-ID: <atjFa1-RbI9Q-z5R@ashevche-desk.local>
References: <20261021121245.3111563-1-lee@kernel.org>
 <20261021121245.3111563-2-lee@kernel.org>
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
In-Reply-To: <20261021121245.3111563-2-lee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 21, 2026 at 12:09:24PM +0000, Lee Jones wrote:
> ls2k_bmc_init() unconditionally calls acpi_unregister_gsi() immediately
> after requesting the GPIO interrupt via devm_request_irq().  This
> prematurely disposes of the active IRQ mapping while the interrupt
> handler remains registered, breaking the GPIO watchdog interrupt and
> causing a use-after-free when devres later frees the disposed IRQ
> descriptor on probe failure or device unbind.
> 
> Register a devm_add_action_or_reset() callback before devm_request_irq()
> so that acpi_unregister_gsi() is invoked only after devres has freed the
> interrupt.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
assuming you will add Reported-by: Sashiko...

-- 
With Best Regards,
Andy Shevchenko


