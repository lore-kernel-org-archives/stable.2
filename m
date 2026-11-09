Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794261189;
	b=QCysn2AZQoySkEFze/d+gGHwtxKe9HcS88A+VRlEP46g72zemxpVTIaAZDLDMVplWLr3
	 07mRQy40iZ7Ve61rhteuh5HAiOBSC3NidOGF8X3uLgg168bYNRWr7aGHUBGiStPEAXvJe
	 v4jMZlZL5lshDUw/J9MH6UH0+2WJ9IZlZnhS2JHFx/51hcHu7mQBb9McGqIFXVWeJf+PR
	 kpv04hI1hBpg19R2z0zJaAkeN1OOeG3xiwQB4kNiKY3EBbzZT6n7l5rpGQOL/InoQKxHo
	 8MYOd8JU/oJKp9ZBVuBH4pr7ZKn/2gm7eLWNc7zAua+lIJdgwnDL3M4xJqPOqqKTGPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794261189;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=cWrTHrhjMJkdIpxHpr48X/5dTj1ezXP2AOnHxHCAkkU=;
	b=v4s7OoR5HaU8QW/o0kMDh4wo3wf/ju0R0qIEWJ/94QxmQMMnsIEkpWBj2vhlLLflUH92
	 0IJLGTL3p/c/QAY38yG4f+LUpJ0r9Inlc3tMJTIGbdB1rSVCJcPrEn2OkiG4HU4pznjc+
	 Lt8MOL0L7Wf33Jm3Tx2x7OaUYxBz1Vkg/So0kJ6g0ZrWoC2z5r+4isxqABYGJj1hJdpZv
	 WdFGyXAv/rk8Jfc6g5aFHlCyb2it+pOlrn09jls0qSTt+FhpbOLiHrj/ovk9+IZpYJMv/
	 KO8oqxHAv2CMoFGZv8SKSmSxuE/A5ByXVj3AOGqBiCQ2Hl/XxSjhjoCYVf6OAG8rnAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bj2Pu2bV;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF47F606A31C;
	Mon,  9 Nov 2026 21:53:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF47F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bj2Pu2bV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794261188; x=1825797188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=47rl7GHP11GZJhI4/OCDmLMOusvHUXAz+Mz7a8yPdho=;
  b=Bj2Pu2bVDrNi5K1K35r74TC5k7BH2eiOkA3LEa4PDH8FG1cA4F0tG5eG
   n/i0ZXK9UByTRtL5g9M7og4RuLdXrsOvFr/Mn7/VvTD1SvprYewCnbBwi
   bJytEW2nWd0j8Xxaz0D0O2yQV5teJE/TQ4WD+78+EhyhpgM/qfNcDDLNl
   GrsebD9fyExUkZkkeEUp/3BzxrRJPK20Iuh/6Lq4smt2wmx1NGE+K7aYV
   brP/muLB3w6fkAEfs/aAwaRg4fd/MnyqdDQmjwgbmjqMFUJHL5sczO9ei
   3lEkgcfTCvFShqBaKUlnLPwanF+vKkAz8s1Zuy4GyvZdeSclDHXxXTk1t
   g==;
X-CSE-ConnectionGUID: HvQyrFVyQ2GveMDreeqANA==
X-CSE-MsgGUID: 9IKCUEZeTZOpGfd8VhCbQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2889617"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2889617"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:53:07 -0800
X-CSE-ConnectionGUID: XtKZoMU+RKyLbhKNbasT5w==
X-CSE-MsgGUID: kq1ZhVbmR4yjLX71MfSJUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7990591"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 13:53:05 -0800
Date: Mon, 9 Nov 2026 23:53:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Kent Gibson <warthog618@gmail.com>,
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 4/5] gpiolib: don't overwrite the entire flags field
 in gpiod_free_commit()
Message-ID: <avJAv_3ACjvyc9VU@ashevche-desk.local>
References: <20261109-gpio-desc-flags-atomic-v2-0-c4c54b476628@oss.qualcomm.com>
 <20261109-gpio-desc-flags-atomic-v2-4-c4c54b476628@oss.qualcomm.com>
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
In-Reply-To: <20261109-gpio-desc-flags-atomic-v2-4-c4c54b476628@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 11:27:08AM +0100, Bartosz Golaszewski wrote:
> Use gpiod_update_flags() to clear all request-related flags in one go
> instead of risking racing with concurrent users and overwriting any
> changes they could have done between READ_ONCE() and WRITE_ONCE().

...

>  #include <linux/acpi.h>
>  #include <linux/array_size.h>
>  #include <linux/bitmap.h>
> +#include <linux/bitops.h>
>  #include <linux/cleanup.h>
>  #include <linux/compat.h>
>  #include <linux/debugfs.h>

No need, bitmap API implies all bitops.

> +		set_mask_bits(&desc->flags,
> +				   BIT(GPIOD_FLAG_ACTIVE_LOW) |
> +				   BIT(GPIOD_FLAG_REQUESTED) |
> +				   BIT(GPIOD_FLAG_OPEN_DRAIN) |
> +				   BIT(GPIOD_FLAG_OPEN_SOURCE) |
> +				   BIT(GPIOD_FLAG_PULL_UP) |
> +				   BIT(GPIOD_FLAG_PULL_DOWN) |
> +				   BIT(GPIOD_FLAG_BIAS_DISABLE) |
> +				   BIT(GPIOD_FLAG_EDGE_RISING) |
> +				   BIT(GPIOD_FLAG_EDGE_FALLING) |
> +				   BIT(GPIOD_FLAG_EVENT_CLOCK_REALTIME) |
> +				   BIT(GPIOD_FLAG_EVENT_CLOCK_HTE) |
> +				   BIT(GPIOD_FLAG_IS_HOGGED), 0);

Indentation is broken (and it has spaces, which makes me totally confused what
the point of those spaces in the first place?).

-- 
With Best Regards,
Andy Shevchenko


