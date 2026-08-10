Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAF43115B8;
	Mon, 10 Aug 2026 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391965; cv=none; b=srZ4qhwLRIFiRacz8aE874LkD2hvy/0oqEkOn7IoBH6a55BdxhDisi+usbImsDRvDM5ZP/RgOiYWkqgqZoUOE0icnafQqpAB58hCfTG/LXD+J0mZ7yd+7J8qE+EZA0sxipoSve6mT297nY+iOz/3KUetWpRcm+OagxoQIM5sIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391965; c=relaxed/simple;
	bh=GJzvZUAcXcG8+ZqC2+GWmIUGcg3U/VEazc88pad6P/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UE4Su7fN1M07I6nyM+DKwtk3R8YDMLNBcNlsjrI9H37ZbEAvgDImjUMlqMWuv4oubkCsrgNMO5oNZjpmkbdozMLMsAmxOeMZksEPECrmSlqSc68PAiQ8lS3pdIEawETvFWBnz07kYKPwGjW9p+JKxPxK5XEIgsX5rNqgdrJUdIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=muXo5Wc/; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muXo5Wc/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786391963; x=1817927963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GJzvZUAcXcG8+ZqC2+GWmIUGcg3U/VEazc88pad6P/A=;
  b=muXo5Wc/dVNaK6j9KfctKXliFEhH8vqeMOhtzOKvyof4FBkMKUVaj+aF
   MtXUnRp3+8+OfC9WdBt3Ntd8zzKbBvjuHRoCjvG71eFy52coK40+otoN/
   dNLXFi0PTpv4hZ0XJOno6GSw0yv4vn9b2pOWZr0llmnGhgDNdR7+GYkIj
   2CkauCCtcKWTiRgY7JsxcYILaSZFoD+uR2O3kgyFnR8KjJPhgeRSkNOzj
   tPqx+VDJeakyNUt9nKDoWPk/y3coir8WNn5tnvHG3e4EvNtFyjfFnPW8x
   hEZe0nglk2y+Atk3ftXURkDPJOf3nsrNcOalnckmUAm0KRI/ULccVbTuI
   w==;
X-CSE-ConnectionGUID: NB7eu1X0T6udo6wgiufzMw==
X-CSE-MsgGUID: zKCQqJXhQjKfxsvGc3e7uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="74452232"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="74452232"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:59:22 -0700
X-CSE-ConnectionGUID: 6KDIvMvrQO218ZwzEYYU/w==
X-CSE-MsgGUID: Rz+G8zv2QzmYHF9JEhJvUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="261385336"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:59:18 -0700
Date: Mon, 10 Aug 2026 22:59:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>,
	Maslov Dmitry <maslovdmitry@seeed.cc>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Pan Chuang <panchuang@vivo.com>,
	Yangtao Li <frank.li@vivo.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 0/7] iio: light: ltr501: Add ltr329 support
Message-ID: <anotkhjg8Xq7X-Nv@ashevche-desk.local>
References: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-liteon-ltr329-v4-0-8bd3dfd15280@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 09:11:10AM +0200, Esben Haabendal wrote:
> The LiteON LTR-329ALS-01 chip is similar to the LTR-303ALS-01, except for
> interrupt support and related registers, which LTR-329ALS-01 does not have.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
for patches 4, 5, and 7.

-- 
With Best Regards,
Andy Shevchenko


