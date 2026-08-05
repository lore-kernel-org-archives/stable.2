Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A36D38E8B4;
	Wed,  5 Aug 2026 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950108; cv=none; b=gkxtL7sU87wWQK6VFkvws65GuuNI1o8S//L2k05cbgRc+HSUYXmxazRYezVo7gQ0rgixWYbDMJg6TDJQkLrjoftBRAJZxXuyFas10QVwuq62w8yBN37wJFG0TE+41k4P3SVWNexJ6I4dHtUBs6Y9qVtIVq17Tqh2vM5DUkVjTl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950108; c=relaxed/simple;
	bh=yrMtwvffhOFgch0ZpZ3JKvaHFhD0dyMlZsfsRbSr9CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsMa/BG5yjdoMs02CR6NBN1qg1Qb2LTVUHIa2khg326bwaDltitOXMJjnXd1kHjgT0HDT+o/cisWlZtdecfzjkw4zwH635D0XGX/Dm5E+E378CnSGIdM2fJD1qaCuWN0zR5wg2uZ75jmhspO+ODqpzPA5O0vTBU4KhRuVvhDNSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AQ54UW3P; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AQ54UW3P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785950106; x=1817486106;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yrMtwvffhOFgch0ZpZ3JKvaHFhD0dyMlZsfsRbSr9CY=;
  b=AQ54UW3Pekba7S4GwOCZF6OHP8+cw9jJZqNqlkbHLrUVDEszhgGsEu56
   9aicXO+VAdDL8Ms94KYQ5GjsVMR260ulwiihVSV42KcweTpnyAoJoTNLM
   XM8jebV5xf0+d7VHIf+zZquoC4pJOXCiV5jVRdHZFZabA5K7JNUM657jz
   EeLaTcA3d70ZcGf/ZeNJF0HEgfTKEv6f57M2+TzR1elGhpFTEODtZLucF
   zrRk3jVMGaaSFngc1ufQK0MiAqkaJlefQx6sDog+hXB5rcIo6yPADQljM
   creqRuX6wvv0E+M/khHvszpP7rlSCrr/aoLRCQxxxqdrkttKBY4XyBApj
   g==;
X-CSE-ConnectionGUID: Pqsa8PBcSBaNqTfHoBDiXQ==
X-CSE-MsgGUID: 0qk4/+m3Rai4MoY4TF8qLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86410044"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="86410044"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 10:15:05 -0700
X-CSE-ConnectionGUID: VRz7co5gQKSrJlf7sDiNNg==
X-CSE-MsgGUID: h9AoMFrLT5ay6hxjHNNouQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261929312"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 10:15:05 -0700
Message-ID: <9864f171-f702-4e30-997c-b0ecd8cb1311@linux.intel.com>
Date: Wed, 5 Aug 2026 10:15:04 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] iio: light: ltr501: Add ltr329 support
To: Esben Haabendal <esben@geanix.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>,
 Maslov Dmitry <maslovdmitry@seeed.cc>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/4/2026 10:02 AM, Esben Haabendal wrote:
> The LiteON LTR-329ALS-01 chip is similar to the LTR-303ALS-01, except for
> interrupt support and related registers, which LTR-329ALS-01 does not have.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---

Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> Changes in v3:
> - Removed duplicated error message on devm_request_threaded_irq() failure.
> - Added Fixes: and Cc: stable tags to fix for error handling of
>   devm_request_threaded_irq() failure.
> - Added no_irq_support boolean to simplify checking for chip irq support.
> - Moved check for no_irq_support from ltr501_read_intr_prst() and
>   ltr501_write_intr_prst() to callers. Note: event functions are not
>   registered for no_irq_support devices.
> - Moved #include <linux/array_size.h> into its place according to
>   alphabetical sorting order (although the rest is not really wel sorted).
> - Restored alphanumerical ordering of compatible list in bindings
>   documentation.
> - Ordered device arrays and enum values according to alphanumerical sorting
>   order.
> - Link to v2: https://patch.msgid.link/20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com
> 
> Changes in v2:
> - Fixed error handling when irq is defined for a chip that does not support
>   irq, powering the chip down again.
> - Added simlar fix to error handling of devm_request_threaded_irq() error
>   handling, powering the chip down again on failure.
> - Added explicit #include <linux/array_size.h>.
> - Link to v1: https://patch.msgid.link/20260715-liteon-ltr329-v1-0-31f027051594@geanix.com
> 
> To: Jonathan Cameron <jic23@kernel.org>
> To: David Lechner <dlechner@baylibre.com>
> To: Nuno Sá <nuno.sa@analog.com>
> To: Andy Shevchenko <andy@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: Nikita Travkin <nikita@trvn.ru>
> To: Maslov Dmitry <maslovdmitry@seeed.cc>
> To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: linux-iio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> ---
> Esben Haabendal (6):
>       dt-bindings: iio: light: ltr501: Sort compatible enum array
>       dt-bindings: iio: light: ltr501: Add missing ltr303 compatible
>       dt-bindings: iio: light: ltr501: Add ltr329 compatible
>       iio: light: ltr501: Power down chip if request irq fails
>       iio: light: ltr501: Add ltr329 driver support
>       iio: light: ltr501: Fix sorting order of device arrays
> 
>  .../bindings/iio/light/liteon,ltr501.yaml          |   4 +-
>  drivers/iio/light/ltr501.c                         | 117 +++++++++++++--------
>  2 files changed, 78 insertions(+), 43 deletions(-)
> ---
> base-commit: 075b74841bd0065a3bda3440873c747938e69b68
> change-id: 20260711-liteon-ltr329-a3eb12414866
> 
> Best regards,
> --  
> Esben Haabendal <esben@geanix.com>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

