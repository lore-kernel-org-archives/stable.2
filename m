Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109076;
	b=ip92wQzgVhkz4jKQk0hpfVXjQcaPVi4ZLF869D7o22yWH2DnlUSmU69KPG7opDzW4u2u
	 2rdYdV2wUxgq3egrCIjG8Zk2LBirfRHZcxTMnuZ4aZX9I5OYx/OMBtr9rKXSpW6feHcai
	 qOITWzpIOH7Xt4cyAs1DFRSzEqrJ5h+kI6bamXjAZbBHssDOGVVceOopzG7bxYCj9VdOw
	 9LXUMvbb8NwW6pgM67pOMjF9LaBsC+l1KEVtaFA8NnMofNwNvAkMa5NkUl3NrwG4a07Ma
	 2OH8fiJmQ6mpbEoWXtrwgQRxWwOpSgnvBHAowLSVhb3iabvAFJqTkaEcKhIRlcyl/nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109076;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=vDq+dwDh9VHOyE9PGWl7oPgRqIwaNRdCgws6u1M1EvA=;
	b=2ANCctLMsg6sq+WzbOYFzUg6Mad0lHDlPPSJ8umLq2OcUoqJqpZdkHQPn3iqWDixtW1k
	 2rd6hBpRt6mVOx/Rj0bwX58JhzgFbC4VG5h795N5pcVhAZ62MSam2kY9J6JfVcj3RaUJN
	 u+Um8UURGtrLHn8zCNZ/sWVnk1SlUISDlIJOJPowzJgDWydPBV+atBFAPxnwR/Ajp9p/Z
	 ZLKhqD6cibI7O4V7hZcZExZvaxmZsHjVa8ZE4smapyBpA7Afh8OleBvyGpzE2z5m5PBGM
	 w3zrVA/yRc7A8G5q2JbmF06mIJn/tWLe4bXeP3DRoREoDeXJ8qCcvDsWE7Aa79quqJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j66G0FK+;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFCF606A325;
	Thu, 19 Nov 2026 17:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BFCF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j66G0FK+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795109077; x=1826645077;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MKwGymcfbhD1OXly6CaW73N6VxGumEiDjiKrm7VXbkM=;
  b=j66G0FK+YgVcU3An2Y/5kmJMLgW0edeE1++m8wmPWCOCGyod+ioo/V/b
   NsZzp0u6d57xgU/dIo3NrTxw4J3Zf49qSfzn36EprLHsOhX+TEKIriMGv
   aioAqFDyCeKLK/D05RfccnzrmhfVOkWsRNzgyZPUeCODod0FxiviputXo
   QGln5XypxfXtVNcz0ICLyg6F++h/GqEUaaDUEPNtg3XmnpTc9zXsZH7YG
   MciUxnd4tQd6Nfy2hBXz2RlgQEpl2tBPPRWSeSOZKrwQOCkpJBgRhkkyH
   yfPQLdH20YrBJoHG93pWR4v8wIBSoGMajJeHRtQlq0e6kQxACFuEtXZpt
   g==;
X-CSE-ConnectionGUID: SXH53SVxQNe160KtMPQH+A==
X-CSE-MsgGUID: Vq+9WKLnS7anpooFrZdjwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3855711"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3855711"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:24:36 -0800
X-CSE-ConnectionGUID: GjIjjLCTQn+hGDx23MTRSQ==
X-CSE-MsgGUID: QOl9cBzES66bHUzesE5z9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="11057979"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:24:32 -0800
Date: Thu, 19 Nov 2026 19:24:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 04/10] iio: adc: stm32-adc: Validate channel index before
 writing chan_name
Message-ID: <av8wzmfrU7zLzGmU@ashevche-desk.local>
References: <20261119153151.1397003-1-lee@kernel.org>
 <20261119153151.1397003-5-lee@kernel.org>
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
In-Reply-To: <20261119153151.1397003-5-lee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 03:30:37PM +0000, Lee Jones wrote:
> stm32_adc_generic_chan_init() reads the child node's reg property into a
> signed int and, when the optional label property is present, writes into
> adc->chan_name[val] and calls stm32_adc_populate_int_ch() before
> checking whether val exceeds adc_info->max_channels.  Because val is
> signed, values with the top bit set also become negative and bypass the
> upper-bound check altogether.
> 
> Store val as a u32, matching fwnode_property_read_u32(), and move the
> max_channels bounds check immediately after reading reg.

...

> +		if (val >= adc_info->max_channels)
> +			return dev_err_probe(dev, -EINVAL,

-ECHRNG

However it seems in the original code like this.

> +					     "Invalid channel %u\n", val);
> +
>  		ret = fwnode_property_read_string(child, "label", &name);

-- 
With Best Regards,
Andy Shevchenko


