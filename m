Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811AD42903C;
	Fri, 18 Sep 2026 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724972; cv=none; b=VUG2qqmQ8qYLC93mt+uYtiWmoCX2PC9MqE8S8sS27z+PkkTKqclE0cXy1otZiOc5h1rgVzsobVvboM1dNIBykhupi9oYP4gGlfVClwfICBLsw5Omen7kxfjD1ltaHXukxg/62lJxOINNFZLdQjYyNbPK1/8czhlqJ3i2ek0xvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724972; c=relaxed/simple;
	bh=+GQfbVSzy+p3fpCnh6P/A9onoRTCCbp5K34rXMqOEUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyhWK8MGTx5RrFG1tELMCdLLDG7o4k+npsXkZomR0w0Ca8C6BmbtascAH9nBS7qtJPWNrWmhvVA/rfFe8zMVdrl+sJuMD5tKJiR98slqHAmeP+YumeG7O/vYqQ7n29nCF9uLuIevEmN7lCHmZ05Gra2Slf7UTQKpwd51ycofZ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YtauurOm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YtauurOm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789724970; x=1821260970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+GQfbVSzy+p3fpCnh6P/A9onoRTCCbp5K34rXMqOEUs=;
  b=YtauurOm0M6ukk7HJpoSiRie+xi4qvlMlzW2fZ6U2/ZmgoksB8NZCPkZ
   MNHv81X/CRF3+GeSiAlPuFfA5wP9Il4VJJ0o1jOUXQwbbZMrpLMXoBcCL
   7tJzSeegc6fo6rc9csF6UdaT+xeQrIPuzqw+zMiuQUZAULLgdWA8AnV28
   zDz+vUjkv6t00CwgW0D5zi1Pr5mIFWJ7Jk6d/U9ZAVb/Bxplpt/Wvu5De
   XcV6YFbrU+tFrtTQ8YI2dqY8SFkqUZ5qIYl43YcfNft3C+NjEMGD5APcI
   9/kXSsyqH65rXSV322Fa1BP9VTvrPPzQJQ3DKRAgq1hOGVjYb+jlOEhfK
   A==;
X-CSE-ConnectionGUID: Lt/Qp6nvQ3iO+SoygGfugg==
X-CSE-MsgGUID: gECR868gQWiiqJUKqbrh4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90235774"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90235774"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:49:29 -0700
X-CSE-ConnectionGUID: 9IkTo1c5SH2cm5jcPpn+Pw==
X-CSE-MsgGUID: kTVijObLSkC/4XNE1C55bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2738778"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:49:26 -0700
Date: Fri, 18 Sep 2026 12:49:24 +0300
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
Subject: Re: [PATCH v7 04/11] iio: dac: mcp47feb02: Return len when disabling
 EEPROM store
Message-ID: <aq0JJNLu9mnQ1aP4@ashevche-desk.local>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
 <20260918-mcp47feb02_refactor-v7-4-82ca794eafe2@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-mcp47feb02_refactor-v7-4-82ca794eafe2@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 18, 2026 at 12:06:30PM +0300, Ariana Lazar wrote:
> When state is false, return the number of bytes (len) the buffer has
> instead of 0 to properly signal that the input buffer was fully consumed,
> preventing unnecessary write retries.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


