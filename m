Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794819906;
	b=KZZCwuXmHc4d3MOJvLoHO40qIfTppbRFWrwxY4yrN/qP5HVowE+o5l9Hu/S5CalJR96G
	 N9YSZukVkBpqQxe4PkzVdg2tN7RAILR2RKUbMLm/5Uns/vg3uK5OQSkaBVq1WxtvI5Kje
	 2XlO3Ityl7DR4SSvdbQLCSYCaXEQ41kf3/knGRFLDvJDcyTP8P+m3kcAcT7a2RxVKUVzl
	 2nZZ9s02HhBbvZmG4mANYWDWgNlb8/owsQYgwJQygDen/c9romliz9p3SuqEmU3O+1d4K
	 i/fyk+Nr3q4JfwD+GL2AyDONPjKxIDeDhRW3p1aMPeLxgj2caTrhtAk/ugKF8exCUKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819906;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=S/BVf+wCPpxgbONwK8YVViVJ5dU2RaSmQAyYCoDGIfw=;
	b=U7Q+KHkrVA4CJCUsm2UmaGFAjLpL0GIdCnDA2UkK9TG0WD5nysU3H6ModsnAr+i5gXHj
	 SGn5h7do9WAnOUEggFXUYSy7EysRhaVhDKdDevdT6deOKVnpDYiTTGIOxi8uTXVWWgbFX
	 wr3+6IwCXYegCI0fVJTxGgYbVOB7Lbcw0DtIBXRRmrHhT8rhyud8NRG3R1SJaB97GWoTm
	 PV055EM28vJiZp3VdMRJF5NxB/uvn72HJXJyPC1BiOgG0G6c9uURoS/E8kbJJMzmi+Yv1
	 9xPVuDCOPqUZZ3Cq4POUPbeuVweDywKittiAE5aqFNxjMfraMZlPeX6wwdAO/RoG+bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Re5a36VI;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D99606A323;
	Mon, 16 Nov 2026 09:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4D99606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Re5a36VI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794819906; x=1826355906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y/DPPHEqSVMRWKFHVM9/QU1bU+d1l3ZEah+OesLhmls=;
  b=Re5a36VIpWmPdH5Upho8POT2bTiJqxW0NKznw+Q9v7TorW6JGn0wnhQX
   tFCLcp1KX+vO5UjX/W2ei3frfWSPaxYdXdo046yTyhikoX7EX8T8jT9GO
   G447q1JUVKlYU8wmOC489uCJQXt0/5xzJvfMScs1M31dl7+Xvx7zd9qh/
   o5kWMNEZEfjm2uPtzsJl/1lILHLTXZfvsubAPe5zrP+ZXnBNY0H8g5jEP
   erDblLxsjrONSO2VEGUiy7WZiGOIXb6OBIUJgLxlew1xreottHknKoCMv
   u2KgfhIoxALTcd3aKWSZ19hN7eZ3Tqt0Lw371OC0VvhkNC25sspJJ7R1+
   g==;
X-CSE-ConnectionGUID: 8X9rc4NwQSG67fQPD4Meqw==
X-CSE-MsgGUID: DFUW/vNhRmKSAXlzpFhLmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3590349"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3590349"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:05:02 -0800
X-CSE-ConnectionGUID: fjTKKebzQ/2t8qyYxsLWTA==
X-CSE-MsgGUID: GWux2NoqTu2G/M9FPUMXMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9824387"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:04:58 -0800
Date: Mon, 16 Nov 2026 11:04:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Dan Williams <djbw@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v7 00/10] dmaengine: dw: serialize completion and
 termination
Message-ID: <avrHOJ-fVZOO32bI@ashevche-desk.local>
References: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
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
In-Reply-To: <20261115-submit-dw-dma-synchronize-v1-v7-0-8d58f3d49e4d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 15, 2026 at 12:19:33AM -0700, James Hilliard wrote:
> Keep client callbacks in the controller tasklet while preserving polled
> completion. Serialize descriptor ownership across completion, error
> recovery and termination, and wait for callbacks before a client reuses
> its resources.
> 
> The series first serializes completion, error recovery and cookie
> accounting with termination. Separate patches extract hardware-LLP
> residue calculation, calculate it in the status getter, simplify completion
> handling and report queued residue. Channel release and
> device_synchronize then gain tasklet draining before the final patch
> adds deferred notifications and shared completed-descriptor cleanup.
> 
> The series adapts Serge Semin's channel-restart and callback fixes [0-2].
> Polling continues to advance cookies and software-LLP blocks, while client
> notifications run from the controller tasklet. Synchronization preserves
> pending tasklet runs from other channels.
> 
> Based on dmaengine/fixes at 6628e7d4c6b2.

Most of the patches refer to Fixes tag as an initial commit 3bfb1d20b547.
But some are not. I think the Fixes tag(s) in many patches in this series
is (are) broken and/or incomplete.

Another question, wouldn't move this driver to use virt-dma infra be helpful
to begin with?

-- 
With Best Regards,
Andy Shevchenko


