Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795071687;
	b=xknZvZWsS+RRHvm/0lOe5FgQSQZ8G5TU8LY+MdOyFoBwqX39g/ugg5ziL7FqkT1AULv0
	 msAW+Ag0hciq9ydBe6Vl+PHHaVvy+Fs8uGAqI6w3aj5Q/YsMMPwxowbw5WJPVoOD6flAZ
	 SeeYI8VbP7wRU7DkTVIAEBAL2GgD4rDoRl2F2eGt+tDjtQJYBzfLVBGlxmHaCuL65DZ0F
	 SFSksrAz0QiVmknkV/Kxwioe7MfCgetC1tAv7iqEUVOvPNmsxQdvdkOPelszaEJY/Zqmh
	 dw+d7g7GdB3zzWjHUe5MxxkE3GXKnePFGSaoIbCh54gN7diiE7efkN3WtNrLU4bujJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795071687;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=TKxI/zjOOz3+xUcxLOHEoh90fzBkqyluqyFqJ8B+k1w=;
	b=XK/KecO8NmuOjDiKvz8Guh0IrdjpgA4pUQFETusl8EJ0exyKtneY/GJ0JrB1pxmpoOYU
	 cAl8+ElZ3Nq5t5bDVmH5BA3KcGIB3WXU3maId+PBWuzGyyhIbvoLb7eVFMPVfKDeYiE/r
	 4vmuoGBOYk2AF783V6YlPTHDapeubo52ERcaaa4OeZKZvV4rchAIIhxYZO5tqkj/ZpxCN
	 nkM5hHVvwnWSGA8sr/gobZbiAoCMHB2f8Xj25K3lwok8NC22zpVaMgd9ImxFMfJSFFUB3
	 Jm7DSPLcnYo4xc5TnQXHnmVK3UlB/NgtOabLPYUOD0nNtphexk6f4To7iIFhB0ScdHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OCmTMHD8;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B8F606A324;
	Thu, 19 Nov 2026 07:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27B8F606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OCmTMHD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795071687; x=1826607687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8g1755zPK67ShsRPYeaMhnaS+wHpG7c9awUGHZuV6Gk=;
  b=OCmTMHD8/6yR0WoEeIulo/q8nimNuMHqdJ1Ei3n8O9NG0qBVEt9h4ZVG
   GtflHq4vBycqHy9cn9Gt5uw4GI+fB61iiW79IhhTcWjS078crhzKid1fr
   XMnvsg/gQldxH5l3aPL9Wf5PEWk4fnHTh6IOKDFVYfTgnLYLtn2udUtBf
   69054C6+XR+b4zTGvphRKN+nRez0tRi0iDe7qpo84Is1aigQmVibcRjA2
   r7nhGozkE9ANKiDoLQ3gk0hZ4k2Cj7Vf59FwJrpjdEfXRW4w/7RZ57RsT
   UD8uBbDGclZNBPtpMhUDVo25ZsUJ/FXIouMDvwpgwsxbcVbSwaARiuhWN
   A==;
X-CSE-ConnectionGUID: 0P9F8hCBQ1uE+wOo/Xzz4w==
X-CSE-MsgGUID: qFUjqyHSRAylNAg2/nfW4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3801502"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3801502"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 23:01:27 -0800
X-CSE-ConnectionGUID: xwq9djGQQ0eEr8/I5TAf/A==
X-CSE-MsgGUID: 29ixMr13QsaI0tkNP0/iWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10718521"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 23:01:24 -0800
Date: Thu, 19 Nov 2026 09:01:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti_am335x_adc: Fix potential use-after-free on
 DMA unbind
Message-ID: <av6ewi7KaAHG3aQv@ashevche-desk.local>
References: <20261118-324f82bd41-iio-adc-0@mail.sdu.edu.cn>
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
In-Reply-To: <20261118-324f82bd41-iio-adc-0@mail.sdu.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 18, 2026 at 10:27:02PM +0800, Guangshuo Li wrote:
> A channel reference does not keep the DMA provider bound. If the EDMA
> provider is unbound first, ADC removal accesses the freed channel when
> freeing its DMA buffer and releasing the channel.
> 
> Link the ADC platform device to the provider so the ADC is removed first,
> including when firmware device links are disabled. The driver core drops
> the link on probe failure or ADC removal.
> 
> This issue was found by our static analysis tool under development.

...

> +	if (!device_link_add(&pdev->dev, dma->chan->device->dev,

Now we need to use helpers to access DMA devices. For backport you will need
another patch. See dmaengine_get_provider_device().

> +			     DL_FLAG_AUTOREMOVE_CONSUMER))
> +		goto err;

-- 
With Best Regards,
Andy Shevchenko


