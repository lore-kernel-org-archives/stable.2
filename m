Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407781;
	b=cXN0Wa2FObcVp4pf/U/q+agaMQhs0q2/RolHESK4xzLqqmawWMM+mvmApgwdaDi/9s5r
	 8g02D+Yz94LgxYr48SrA9221yjQ9yX61zTlqqeRXpdSxGG1F21eVx4SJ9OXrEyxCTTWvf
	 c7LMQXcY03FlHrhkw9ucV/DQthD8TdJnWQfzZywu2Za/kR98uFu6+cBGIP6QlQ2ZkD7ET
	 XW9SE/LrKIyH2POFhB5M5N8LUf9BNsaNq6sf+Ndl7DEVY366Xbzz/zNxUIdfsp8c2y0PW
	 PPnWAwZ4iqCxBQ/NuLSa0wo/ix96L1rfdsmgA8a0wIIFqUFZ0nY2aALTZPesgECzuRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407781;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=FWxiG1B+Db4JRltlZYC13MvgLHZ4LKzVEvoYeh2GRKI=;
	b=xEfM3K30/sEa8lf5MqIME8Z8qbGlahFK/wa33ZnhtDTGwbgTcO9MnPEs+WgOMKtE3U7z
	 I1kAY5lPs69IJUNnvsZqqQkTae0iw3pH6iJr7LC5SZzFO2GfeWDI71TzWVWHCN83iR81i
	 AjITx3PZ2mT8SRuyKyOqYNrp5clroLaRIsfgDpF6WQOFdv5WMCqaxtnFG5nmO6vZiqBWh
	 dcmhdaIbU9PJB/uRPnKU0Ww1KkAG0zjYgo74PjDRtN+k3IvNnqymGpczxX6im6uCJ6Dp/
	 6op0NvmTuCr58S21JbGGntPzLgBiLdVupeNRSCSlQSh8HTfqQconT4uxXEwxzAX/hhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EUfhrfTP;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F3606A327;
	Wed, 11 Nov 2026 14:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E8F3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EUfhrfTP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794407781; x=1825943781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ODmSwqzv6dlvz43TtOzhl0WSmF6mv80rIt7JvrCqLuE=;
  b=EUfhrfTPjS7z3O2n7trPT/CcBkYD0T6MCBzMgCScN0me2NVS0hbQLSNM
   7u8JqwCP2/0WDwQhVZlwSiQB8usuRX7mRZQqwEj4IQze37fq4iZ/7XtXi
   6yQ9Iw74qSQNsmDJTPfSBHEL50d8+wBqcVnOUo5Wlu0l+lSDSnv7dcKOY
   fzFanDm4xU03QOXB5yzMMhXx1hsiur8TwnPVc8kUATHu9AKOUp072oUYc
   sQef/eJdb4KIZnuaeIvXynjLXAz5iJ+9WUlMXNTsxZRUZ4uTyzP6F+EIw
   bjGONqfEDJQZCcTGGTMhIZlD4qVIANxJmmZC+3BJta59ezq/I8ZvZ0ITW
   Q==;
X-CSE-ConnectionGUID: 80TfZLGGSQW2ENW5QMM7lg==
X-CSE-MsgGUID: G5VPmowdSxyPjf9rFJBuIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3050978"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3050978"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:36:21 -0800
X-CSE-ConnectionGUID: YY0jrshyT2Kb56gQ0cymCw==
X-CSE-MsgGUID: VTA/3sF7TF630BSET156Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8763922"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:36:12 -0800
Date: Wed, 11 Nov 2026 16:36:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sergey Khimich <serghox@gmail.com>,
	Sia Jee Heng <jee.heng.sia@intel.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] dmaengine: dw-axi-dmac: preserve pending pause
 requests
Message-ID: <avR9WSbaBlNtNUjn@ashevche-desk.local>
References: <20261110-submit-dw-axi-dma-stop-pause-v1-v3-0-35fdfba8b61d@gmail.com>
 <20261110-submit-dw-axi-dma-stop-pause-v1-v3-4-35fdfba8b61d@gmail.com>
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
In-Reply-To: <20261110-submit-dw-axi-dma-stop-pause-v1-v3-4-35fdfba8b61d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 08:15:15PM -0700, James Hilliard wrote:
> dma_chan_pause() clears SUSPENDED even when polling times out. Hardware
> can set that status after the last poll, and the unconditional clear then
> discards an acknowledgment the caller never observed. Another channel's
> interrupt can also consume the status because the shared IRQ handler
> clears every channel's status before taking its lock.
> 
> Leave SUSPENDED to the pause and resume paths. Track the suspend request
> separately from its acknowledgment so a timeout can be followed by either
> a pause retry or a resume. Wait for acknowledgment before clearing the
> hardware request, since hardware ignores an earlier clear. If that wait
> also times out, return -EAGAIN with the request still pending.
> 
> A completed transfer is also quiescent, but its completion handler may
> still need to advance a cyclic descriptor. Defer that restart while a
> pause is pending, and resume it without reprogramming the first LLI.
> Track the active descriptor until its completion handler runs so that
> resume and issue_pending cannot restart a completed cyclic segment or
> reissue a completed noncyclic descriptor while its IRQ is pending.
> Start queued work after the active descriptor is retired, respecting the
> pause request.
> 
> Clear stale suspension status at the start of a new descriptor rather
> than at each cyclic restart. Reset the software state after successful
> termination and when allocating a channel for a new client.
> 
> Store the lock-protected pause flags as bitfields in existing padding,
> keeping cyclic in a separate byte because it is set outside vc.lock.

...

> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> @@ -42,6 +42,12 @@ struct axi_dma_chan {
>  	void __iomem			*chan_regs;
>  	u8				id;
>  	u8				hw_handshake_num;

> +	bool				cyclic;

> -	bool				cyclic;

This move doesn't belong to this patch. Yes, I understand that `pahole`
suggested better layout, but make it in a separate patch.

-- 
With Best Regards,
Andy Shevchenko


