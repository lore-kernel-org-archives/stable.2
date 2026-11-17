Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904394;
	b=Ts3Reu7SBTNKhhhvisEMX2IecVWRkN8h8z4l/e1OGWH+5+qHE7bjz4AEIcl+GREwpA+m
	 C93Ceiy6o1OLUgnwNIrABN9Get+B6G90xDOeByAjZ0VJB7GShhb8y6kQcFja2YV8X9UV2
	 lSJ5vU9b4KoozgmDGaB/wvlNQx3uwwkt669czyY8pbIHiBJzdqtzzkhIRRL94hcvECVfB
	 3mohNctfJMwN9otN7eE8SWHlz72U1oHk30J9a2f6Qgbc2hVwV0vakUAn8AeaGesI5m8yD
	 qexIBKB3XEcFVkhwXjoLJVtVDTJiEXzzeoV0HBAHZruYldc95SJnRRE32rpQgN0LOjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904394;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=SBLXT5ticXkqSe7DNjsbDeeQNU+F8ahKxzqWSGRlJBA=;
	b=i6zgL7EL7hb+0vqemOwCtLkLJS+MnkDHTSrsEs2gowefYoW40JTtNWEcU8ICaAREwQKX
	 WQyQqTsq+XGmshKqL72Ntuu6Oej7vZhFww7H8BNuvj2uv/9PCX3J20OTbSuKqPJjtg1Oc
	 9okTto8toy5SoD1/FysGhT6tYoVTgo+0fVdV7KU5NZbzFcRPXkBZU4zdqgm7SHbEjr06d
	 Krepbdb4OuljJ6riMHpC5zt9ECecB+WngXmdR9i588rAK0xPTl6EfwUYVWyljBWy9pn7X
	 I+N79SDY0oc22VfHQOAzqx0NixRxrS2GOZfRTfzcQ5BJfRChPJd4sHFmFi8g0SvWUOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H80bhDJS;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662CD606A88F;
	Tue, 17 Nov 2026 08:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 662CD606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H80bhDJS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794904394; x=1826440394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UdJyVMmnFBqlzJcuy4z1yuoFRCu0yzL8poLxpguc2hE=;
  b=H80bhDJSNT8e9LiWOKOmy71RiDT19cZmiOqDrzsMT7u3kmT5QJv/+z8X
   zVUTF4zcHQ/EBZk8UWycRgeqUsS52AP2G9/m0kF6r//zu75rFYmU6/z83
   m40Ttb3R1wxOXxMGO3ZOiHEvjI0iDVEg2Tv7O3XS35hstakyhNzqLK5d/
   im9zRSbrQgE2PtjFfT3pztilZ4c8y4BgJ43BfwICV58JJXf0G2nnmhHV3
   iKyBkUOJJUKhgzOVnYbjENVEH9TK2lUUzFxYAZXNfrRA/t8O69tLTBr/Y
   SDTtM9/77BTENteQ+paVLQpLXVSEw9LUPxCs5CUdzJ6SFm9m0TpaEIHHg
   A==;
X-CSE-ConnectionGUID: nANH1HvuSuatjRIo342bfQ==
X-CSE-MsgGUID: R+h8fp+DRmyrsAOU+VMmfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3563736"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3563736"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 00:33:13 -0800
X-CSE-ConnectionGUID: zjY75UvJSfWzSqEef0/bDA==
X-CSE-MsgGUID: Kf/0gr13SQW+hJW4+IUj6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10305651"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 00:33:10 -0800
Date: Tue, 17 Nov 2026 10:33:08 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kent Gibson <warthog618@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Jia Jia <physicalmtea@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 2/8] gpiolib: free the label of lines released after
 their chip was removed
Message-ID: <avwRRBrtZYPTtRjq@ashevche-desk.local>
References: <20261116-gpiolib-chip-removal-v6-0-aambrozewicz@nvidia.com>
 <20261116-gpiolib-chip-removal-v6-2-aambrozewicz@nvidia.com>
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
In-Reply-To: <20261116-gpiolib-chip-removal-v6-2-aambrozewicz@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 16, 2026 at 03:47:05PM +0200, Adrian Ambrozewicz wrote:
> gpiod_free_commit() drops the consumer label only while the chip is
> still there. A line that user space keeps requested across
> gpiochip_remove() is released when gdev->chip is already NULL, and its
> label leaks:
> 
>   unreferenced object (size 32):
>     comm "gpio-hold"
>     backtrace (crc 7ff222d9):
>       desc_set_label
>       gpiod_request_commit
>       gpiod_request
>       linereq_create
>       gpio_ioctl
> 
> Clear the label before the chip check. The ->free() callback, the flags
> update and the line state notification need the chip and stay under it.
> 
> Reproduced with gpio-sim: request a line, set the chip's "live"
> attribute to 0, then close the request. kmemleak reports up to 30 such
> objects after 30 cycles; with this change, none after 100.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


