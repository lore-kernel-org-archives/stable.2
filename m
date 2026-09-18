Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F441D111;
	Fri, 18 Sep 2026 09:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724918; cv=none; b=seTshQM47UZKogpJdPUHkp+7UCGKVB2wC/7Kand4jr733MEzLElxzbIc9gPKwzEHMDKt8xmoFrUFmsazb+QUyRetF1jL8iLnUBmIc0/li/RWNwKXyMBLw6eUEFOvdXS5eCi9rr4k0jrcp0paRiJGC+wbKogbD7GsfKIcVkfP3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724918; c=relaxed/simple;
	bh=R1Q6tgrssWjxVXZG48jNeOeCkukP5PcrOOVEod48gNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3tR7FyLPCDEZ2ExVtbeLkCGH0KE2byMrbPQGtYbAgTxh8SBKUIWAa4yiYWgBnBi8SjIrdTtv27FLv0AgiDRNdGN583gzp2C+9Jj57Z51KalX2RjJtOQfFg9lQgF2+ohBtd0UHk/qntCuLgMhBPHbmOIX4EwsFpyi6GWi9Np0/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3R3l/aT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3R3l/aT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789724917; x=1821260917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R1Q6tgrssWjxVXZG48jNeOeCkukP5PcrOOVEod48gNY=;
  b=c3R3l/aTMoGXclOLq9eNnKlHhmwu0655i9Vo/xav9aO4+ISDTn2IGFGl
   IQdZBN2v+itrnyoFSCiNmhtetyBMzV9Ew4Pm5OM0tdW5uN1JsNtkd8m2X
   lTtkvJWeRQzr9VSi7ustSqu3OwDWwLG3n+k5s4z1ml2d7qYrOwns/56Mf
   KD5/1I9w8wJYtlo3Hjr22CVeX1mZCTsN7jHgFPRWx/Ss4sz2+DtBkQwB9
   Sn/5T2s7e8JMXiczuQ5BXBgn1Jwl4YVVVzoDMxKYvt0AuFolxSJaiIIO9
   kdXpcAM8LrLhClEfoVMPBiOe/fHh4J3BA+KmQTfkLK4BH5DhfaRP/ETJg
   g==;
X-CSE-ConnectionGUID: afQlzGyJRBmnt8D85sXz/Q==
X-CSE-MsgGUID: 6aavX9nNSf6PDRiOCKVALA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107723430"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107723430"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:48:37 -0700
X-CSE-ConnectionGUID: PuP2ECV7QbqSqgUz+3tipw==
X-CSE-MsgGUID: zbZe4yVBQxWv1g0V3eQJhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="279549854"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:48:33 -0700
Date: Fri, 18 Sep 2026 12:48:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	sashiko-bot@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 01/11] iio: dac: mcp47feb02: initialize dac_data field
 in channel data struct at probe
Message-ID: <aq0I7xIgbPC62AxA@ashevche-desk.local>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
 <20260918-mcp47feb02_refactor-v7-1-82ca794eafe2@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-mcp47feb02_refactor-v7-1-82ca794eafe2@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 18, 2026 at 12:06:27PM +0300, Ariana Lazar wrote:
> Prevent operations which use cache from overwriting default hardware values
> with zeros by reading active DAC registers during probe to correctly
> initialize the channel struct DAC values.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


