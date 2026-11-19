Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109502;
	b=bXfd6GK9yhSnowfTMnR6mPbuJOOSecUFWMKRczo1MZJVonLX6+WhBu6JxmSFHndpcBBg
	 oLqd6lRh7la00eUfSYebzxIPIrsNSsLpiirLFiT5gFl85hX1zvhU6nt0blcZ/LttL7BkT
	 jvVJUuenfPvKLLav5IPiRMjCjtMENMAbDvbV4CtrD4lJKzPSAOLCooT924m0LE4XhMkSj
	 iM+vrQO0+U4zhKxtoJ2o2hCu6VdVlKnO2J8yhuCoo2ijhyHkIKOf1T4N/AAZxRrYF9FpJ
	 VGN30/NeUQ1PP5N0dgDcnYjCxh9WBwq56I8Nn6jVARvZDQJKiuLmVrpp1he0E1iaoEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109502;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=FU9gR1dcoWLtL0sHRAxH8ZWMSEUomoVnjE/ppuPtboM=;
	b=21QCs/mI/fSdrgC7U3P65CmJdvP/CgdLA7HqxUrkayujVzR5X2RbqFd2OM196GDZJUVV
	 PQ2eRM6EWS5vq4h6EHCyK5vHWCeqXvyYN0SNtrFnuxqF+m8IjVWsUkMSQdcOcd376Zhgp
	 RhHGEc0rmJRL14kxW2y0ecEqJffMTRsZoRhJUl0uP3awwX/n5stSaMNLuutMmz2ON0iBH
	 aKzqN9dkUd9pbJ8RWTfhmB+Wm+oh2yYcu25xJQiT57so2zIMYwc5zEjF9keuZxLLOiJYz
	 FysJEaPp6SMQpIY9Gcn0AKPcWwuFvOsK3iLA9P4bntUZUcgwpiq/0GvvvTbrTH9vu3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DXy9jWl1;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9899C606A320;
	Thu, 19 Nov 2026 17:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9899C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DXy9jWl1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795109502; x=1826645502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qyA+t8Qays51sjn9XNSdEfaU+PoeWkwXgQUuw38mVe4=;
  b=DXy9jWl1saxWXJVZtfnTBvJPdj9p7aRN/iulSsz0xrN1bvQdLrqszlte
   Txa5bJz3mYUwoCtbEe4vNunrzI9W3691L8Bk7fiUdfLQbUO7uIFIzIRYR
   7kmyATFBMBwgpPC3E3sw8XmhDLB+5ShgDZI0GJKxM47Os+9aw3YVOupw/
   1oflXuTtnC1uEcbgmvavGVWU9owDBMmZHvpL2Qa3zrRBUt/5sdUTzzZEX
   1RslLoKNO1QbWNh9MTXqX0tDkQXP/ixEtSIL7E5b65qOY4h46Us5IftO2
   84enUfJX9iKcYfFcsMsxcmzWpi/IaDJTiL2lq/Y8A3NA80Df7Wv1Srgea
   g==;
X-CSE-ConnectionGUID: 0bq5YT5GRfKFQSZcZ0FG/w==
X-CSE-MsgGUID: g6clW9S5S52KzWn2ngw8fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3977276"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3977276"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:31:27 -0800
X-CSE-ConnectionGUID: g9wR7/PuRHWwHqkeMLZi8A==
X-CSE-MsgGUID: y7MiF8JoSZixBl5J76Es+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10829680"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 09:31:24 -0800
Date: Thu, 19 Nov 2026 19:31:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 08/10] iio: adc: qcom-spmi-adc5-gen3: Reject empty reg
 property in probe
Message-ID: <av8yak7K18Cm3wdd@ashevche-desk.local>
References: <20261119153151.1397003-1-lee@kernel.org>
 <20261119153151.1397003-9-lee@kernel.org>
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
In-Reply-To: <20261119153151.1397003-9-lee@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 19, 2026 at 03:30:41PM +0000, Lee Jones wrote:
> If a firmware node supplies an empty reg property,
> device_property_count_u32() returns 0, which passes the negative error
> check in adc5_gen3_probe() and leaves num_sdams set to 0.  Subsequent
> zero-length allocations return ZERO_SIZE_PTR, which is then dereferenced
> when requesting the VADC SDAM interrupt, and num_sdams * 8 - 1 wraps in
> unsigned comparisons when counting TM channels.
> 
> Return -EINVAL when device_property_count_u32() reports zero elements.

ENOENT is usually used for that.

-- 
With Best Regards,
Andy Shevchenko


