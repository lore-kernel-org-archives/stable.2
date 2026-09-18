Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AD03B42F2;
	Fri, 18 Sep 2026 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724996; cv=none; b=BhaClA7GP8YWVMSoDW1x2B1U5lOnDoPegWBbDyuEPaSOP4DOMHIP/rjKlNV3BjbfD3QX77SbEntQVaJvTrAO0KfX0b8EPCSnyoVmyVcYz/MhdGB9s2LF/bgLa1cTVa+I24G0qxLeOA1qq2/eehqOZkG9Y7P7L7P4AXoXs6WmK+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724996; c=relaxed/simple;
	bh=dQs72jl617d0zss2YiQy/8kofHtr6/cDtsDJu+YSKmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsAcjK8smBiUS854HPhy/d8ShhGCJRkn57/sIuQU1gYqJ8Mph9HouIhorhuG/kbYQf15ZfBoPwvtw6VO6xSM0GTyMXIbjJHUNQv412+0v0xe/6Bzo+kVyYrtToorrBEBjFzpK7ii3GMfHumYdduUwJJQ3HjTNWRzVYispFp5zNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YG8z41jt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YG8z41jt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789724995; x=1821260995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dQs72jl617d0zss2YiQy/8kofHtr6/cDtsDJu+YSKmM=;
  b=YG8z41jtUa2S/IyK1+otvMcFlRXTkbSII4iQVf3YgZsDmETAiXHd9e64
   qu6h2G1aC+ejo5ernEpdSYveocIg1zLM0Q8TaGcTASouKurl756lr7z3h
   A95vW4YMkZnbCBRSf1EyQtuEjx3r9zptTNbPllBihJJcWF1/eZdetK54V
   AxD7Un6gLJcenCiq4hWMTDBu3Mop+Ui6HVTr+d6TIheV2B6nzzDNa+rPI
   6rLk7SIj8VXyeIyDmf8W1hT6/7hQ47lAVYRxcaWTnnhMlW//TDIcZ3GDe
   L1yhMLxN4QsmKh0WYmDbmBzYJbwq+uwJGh6cmbfZRKap+T89qJxknipxn
   A==;
X-CSE-ConnectionGUID: 6D2E78uJQTarj40GHKxkxQ==
X-CSE-MsgGUID: GHXX6vwmTvCLOuV76BJqRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90235863"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90235863"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:49:54 -0700
X-CSE-ConnectionGUID: Ifr+ZALjS1iRvazIbq+VCA==
X-CSE-MsgGUID: RMvmV9IkSaO+IgAlP3cXTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="297791472"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:49:51 -0700
Date: Fri, 18 Sep 2026 12:49:49 +0300
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
Subject: Re: [PATCH v7 05/11] iio: dac: mcp47feb02: Increase EEPROM
 Programming Write Cycle Time
Message-ID: <aq0JPbBEuVah2PSg@ashevche-desk.local>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
 <20260918-mcp47feb02_refactor-v7-5-82ca794eafe2@microchip.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-mcp47feb02_refactor-v7-5-82ca794eafe2@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 18, 2026 at 12:06:31PM +0300, Ariana Lazar wrote:
> Increase the EEPROM write polling timeout to prevent -ETIMEDOUT errors and
> incomplete nonvolatile write cycle, according to the time specified in the
> datasheets (11-16 ms).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


