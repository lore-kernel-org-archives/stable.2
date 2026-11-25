Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614945;
	b=YTXvG3EwfkvWhmuvaIf1Fqtk40WfFo4B0CpK/5NVM3sx0c8v8tv548OI02X+cL9yUhHF
	 oc9IV2+h22oIjnsq2bo65+x7AAcKG1RsEiOLFaCo5rmfE57mI3vPJYrbfaPO+b1IEBkZB
	 +5Zd2cuGv5drsS45UIN/6b4q4qy1+5pkrnhJXzVQg2Hj5jCrTfGXPUk5youeHr7Szmd6T
	 T0FMc9XNzmAK21UcnBnZzfS0Wxz6LHPctQguLE8e0DCV0k2f/EwhuWw1Bc3FhUIPuYcNF
	 DasogYKgMke2ZBpS/N8y1y6EDFE2Fa3UjHrGrX14ySvw6+k/vf0quHBbO2pXfolPOgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614945;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=HL5BDdiLUu9s2bDSb5mlLsYXZ7kl3IzM5JsLxRkQbyY=;
	b=md2zJaNfcu3WOqGhNdq+JEtrIVn63tp+ny1Q29Mp5kkAnHjsGd25VyBQa2x2qT86OCko
	 vxQz2o1f7rGLpxI59bMb9ylaXdknAIbSWmj4eSSRQaPdpKwff7EsnaNIXg/XSVP+9nszO
	 PlHoT7F1JZZ3p0ZZ2N8Ag8EE81doaJcguWymB63tYNC3QJAWIiLYRnZ4yrfEI7KwfOd5Y
	 KjCf3gR6iUncb251ReH6+smlUQwBj7BFl2scFsCcPLwQMjM9+yy6R7Wp7KNJNcAn0ea3J
	 dT6QCbAnQx0bRZhvIXtMZPkSEWxR+lHERJaOfrjS0zB8gXN2kSoFdAQF6aOJyUIzJSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=boUhwLZB;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3E3606A31E;
	Wed, 25 Nov 2026 13:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F3E3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=boUhwLZB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795614946; x=1827150946;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=doKOSbWDv1051Z1A99L7HmDwCfX5pJZ1mlV4wkLx4wk=;
  b=boUhwLZB1rx43T4fh95Ol0HWWvjgyHt5hsNihDNciATA5cFDmNlDFco5
   Ig5CQTZHBVqIbIQz/6lxoFJ0mrofqg2N3/uZFLTTHYxbDUl6mYceM1ur8
   q61ENzvVtwDrPYxXzxj5t0a6A7vYh81RAWQpqkO7ZB1RJdhy7Ubu3KGYn
   D40YxzsivF51zw2yosNTJLoRozUCwe157+QMxRNPd+NYhtiG7Nzl32hgZ
   qC2OBf/9C/Fv1gz/s5jBVKVPgVSBwPI8YK+6IJtjDMO9TbgAq3wPE9ABF
   //MdHFMRaHKgBhk2Vvu4zSj+XdzguXyiVrPd42/IxoUGb31vyPvjXKmx1
   Q==;
X-CSE-ConnectionGUID: 0X3S45wSSMad7IOjnA4TPQ==
X-CSE-MsgGUID: a8AQJzViSIinM83WFUNphA==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4397058"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4397058"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 05:55:14 -0800
X-CSE-ConnectionGUID: Bja0jfy/Qsu+LjUhVGOoKw==
X-CSE-MsgGUID: d+S0he5QT7Gb8y78OZBF/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11689382"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 05:55:11 -0800
Date: Wed, 25 Nov 2026 15:55:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	Andrea Merello <andrea.merello@iit.it>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bno055: restore the order of the gyroscope
 range codes
Message-ID: <awbovcR_uXgM35WE@ashevche-desk.local>
References: <20261125082840.1340359-1-maoyixie.tju@gmail.com>
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
In-Reply-To: <20261125082840.1340359-1-maoyixie.tju@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 04:28:40PM +0800, Maoyi Xie wrote:
> Commit 399b883ec828 ("iio: imu: bno055: fix OOB access of hw_xlate
> array") also reversed the hw_xlate table of the gyroscope scale.
> bno055_gyr_scale_vals[] runs from 125 to 2000 dps, which the chip
> encodes as 4 to 0 (datasheet, Table 3-9 "Gyroscope configurations").
> 
> With fusion off, in_anglvel_scale now reports and selects the ranges in
> reverse order. Restore the order.

> Fixes: 399b883ec828 ("iio: imu: bno055: fix OOB access of hw_xlate array")

I agree with the fix, it's unclear in the culprit commit why the order was
reversed.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


