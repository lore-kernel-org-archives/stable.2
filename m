Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3B0421233;
	Fri, 18 Sep 2026 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724945; cv=none; b=etTvE8NC8y+M94orK1hR6HYfA5fMxAcrbfX1ilxQo5E/rDGw1diliZt42thLUgUo8yp0sBSKXICq7I60bD06yMuhhNxoocvdRzywSaBn2xtspiHwCPkUAG4C/ypjxBxYaWTCU8J0TBhV/330Ox4oYQKwJSuKxAi4FUUj/ihZ4jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724945; c=relaxed/simple;
	bh=BrtByww3MJEyfn7mXHXfUIkuHB2ELQxGele3Zky/gsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjosiRv5Z+6G6/STTTI8Vn56nbmL4VySgXJc82CxyfjAh8vXhOBkS2qcNMAfaMDbjgFecewW942D4GugalKbGvMBbU5z1O+fDYKDYpfuCV7a7IhmwVM62TwD2RXYfM2gcows5/a4BODNI06Z22izGb/VEzPB5OyhJoGez/6bkA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1kVpVMy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1kVpVMy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789724943; x=1821260943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BrtByww3MJEyfn7mXHXfUIkuHB2ELQxGele3Zky/gsw=;
  b=T1kVpVMyD6gAjnwu/A7FShRRooVPlaqYcF3v0uaKN6ESsChWvQ5CB8K+
   UjJiBS/XUO2jc4fsvPLZ5eVpLCI0AIL+2L1zA487H9aocw7qae93HLjiR
   3I3rJY0arUUYiz3NZYzYYFcLoXSlCkq0WtsmhTMEjGyNDkupaeRFjH+RS
   /Fq8yFHYyQGYqCl/eql34ZQroBiIJKq5sZvXEhakmwCZCSPMXAO7O8nSt
   CB69gERnlshNI1vpaCV0QfbY1KPzRdHgeVcdmMz0yW1r/8WqQ4x0V4urb
   tUbQ2VbTtICCC/Eq1TdtRbC0v9xUA6qUEYDG6XgAyxwMCRWChnIrcheSA
   A==;
X-CSE-ConnectionGUID: oyZAD9mNQJmi8RzOCIuXCA==
X-CSE-MsgGUID: eFlL+/0qSSW95hK/+GNlxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90235706"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90235706"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:49:03 -0700
X-CSE-ConnectionGUID: 5HVOiosVRO6dqFMc97h/qA==
X-CSE-MsgGUID: jVhIMUrRRbycVPk3MeyYag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2738402"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:49:00 -0700
Date: Fri, 18 Sep 2026 12:48:57 +0300
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
Subject: Re: [PATCH v7 02/11] iio: dac: mcp47feb02: Fix gain field
 initialization for active channels
Message-ID: <aq0JCajfTXMHI9sY@ashevche-desk.local>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
 <20260918-mcp47feb02_refactor-v7-2-82ca794eafe2@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-mcp47feb02_refactor-v7-2-82ca794eafe2@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 18, 2026 at 12:06:28PM +0300, Ariana Lazar wrote:
> As per MCP47FXBX48 Datasheet, in the format of the Gain Control and System
> Status Register each DAC channel has one bit to control its gain,
> starting at bit 8, while bits 0-7 contain status or unimplemented bits.
> 
> The previous formula didn't initialize correctly all channels, being
> replaced by using field_get() with the already defined macro used in write
> operations where needed in the rest of the driver implementation.
> DAC_GAIN_MASK(i) extracts the gain control bit for each active channel
> correctly in one step.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


