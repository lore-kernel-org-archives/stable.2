Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408380;
	b=cvh9QkfQoAATn49gIl2eVKEWK52csl8N7woLrtn92Zm3/JabS+gxWI+lhantyt8LyijC
	 lQfBkY0GFlQ7gjAxqGD8S2aQrHJNqWniaGqLT8YFJFvh8+rnMgqGOFbgvNXTC19OajldI
	 ckj0FOgEIfarnclgCrW+bW0WgSfvjRF5EcjLdlMeiBNkCy60oIo+WCvQqW9bxHpl8dmKD
	 2hO3OsXlBzQCdgEgAid01QhU47DBgp7xHGOFXbRb1WXFU1as6EceEVhduTofYTHuuBPeH
	 nYZ0GkW/B/j9suOFhIngNRaSd27oQNv2KenCOzU9yM3AYWOHxBCndmhOlJYQEIQVrQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408380;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Em4EKoomQzRqCmU2LdTaxgS3/XCVwcRA3NsOk+tsLy4=;
	b=2bD6s8R0EwUjdQSF5UEGBeNqKV3NzR0UJcfNXzs2Vem4NX3GIt+Op0CGAwT35udQA/BX
	 smfXZUNSIjMbHzBC4G4MeWxiBiNyQGdaxvxorSUBzLnMXCMqwbZFiZL/9CeLtLc5tfLse
	 1ei7UPZfNQZu8JM42U12ohguvQ1BDDE6eVbK4W50smulEPEqNFsWsJ5nLoRJaj1XjA3RE
	 ug4s8m432QQCj3WWDlh2kzUT59kqalN4dM6QfWRTrLEeZnYHcxTFiWEuGz+4eIy+9XYRQ
	 7RGfx9tBKA7gAPVPQ9XdLaVRMIfq9U58cLh5EBQb2y7+7IIszayQ/Wxw4jMljaFJDjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OPipuQmN;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3922D606A326;
	Wed, 11 Nov 2026 14:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3922D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OPipuQmN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794408381; x=1825944381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OtE5O1BfQvMDhBRcvXpXpqkumAp3IpNUCIvlpc/VYDQ=;
  b=OPipuQmNAADEF506uoNdWIoGFCSpHJSiXYRO5ropTEVTE6q6njcOi9ot
   oQbpldjHuRPwSdqkuiwNIAWzvRGwGNJT57gZVPIFPFeijpdZlWTCA8gvy
   o9n039jJmfH8/P0BYfL21DpfIFy+Hh0f6Sh5tpTSd47W9JrSKRWxoqOQJ
   yqVykeH/B1nSafRcGQRTcsBRmdeHi8MsvD3M+pkxHFGhfhD+/+Czdc7p1
   qt1QDh2j6pErcC2iKE5mSLw+2MkJyFdb/iURcWT9gI3Nsjg/+W8192aJ5
   RZy6M5O123/DjodHhzqBzNpQ/BwtyUiD4OWj3oab+gX/lIJQG7bfmHASn
   Q==;
X-CSE-ConnectionGUID: wg299LpwTIKVRQp6iAksFw==
X-CSE-MsgGUID: EwOg3E1CSF2H4XMzGAn4qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3276718"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3276718"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:46:20 -0800
X-CSE-ConnectionGUID: u7JpfAaFTwqDCf/sHVz83g==
X-CSE-MsgGUID: hi4ZGr8NTJeJDmBls6NVJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="8322908"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.142])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 06:46:17 -0800
Date: Wed, 11 Nov 2026 16:46:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hyunjung Ko <hj351016@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Kaixin Wang <kxwang23@m.fudan.edu.cn>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] HSI: ssi_protocol: don't cancel_work_sync() under
 ssi->lock in ssip_reset
Message-ID: <avR_tx9ze-eAa0_N@ashevche-desk.local>
References: <20261111090447.3047656-1-hj351016@gmail.com>
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
In-Reply-To: <20261111090447.3047656-1-hj351016@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 11, 2026 at 06:04:47PM +0900, Hyunjung Ko wrote:
> ssip_reset() calls cancel_work_sync(&ssi->work) inside the
> spin_lock_bh(&ssi->lock) section. cancel_work_sync() calls might_sleep(),
> so running it under the bh spinlock triggers "BUG: sleeping function called
> from invalid context". In addition, the cancelled work ssip_xmit_work() ->
> ssip_xmit() takes ssi->lock itself, so waiting for it while holding the
> lock can deadlock.
> 
> Move cancel_work_sync() out of the locked section. It still runs in
> ssip_reset() before teardown, so the use-after-free fix is preserved.

But is it okay to run before timers are gone?

...

>  	spin_unlock_bh(&ssi->lock);
>  	if (test_and_clear_bit(SSIP_WAKETEST_FLAG, &ssi->flags))
>  		ssi_waketest(cl, 0); /* FIXME: To be removed */
> +	cancel_work_sync(&ssi->work);
>  	spin_lock_bh(&ssi->lock);
>  	timer_delete(&ssi->rx_wd);
>  	timer_delete(&ssi->tx_wd);
>  	timer_delete(&ssi->keep_alive);
> -	cancel_work_sync(&ssi->work);

-- 
With Best Regards,
Andy Shevchenko


