Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947633890F6;
	Thu, 17 Sep 2026 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658253; cv=none; b=Hka2ORkNgy0GNzdXaJUD3fp7X3EA2P+FSbIZqxeoaDxwQIG1Whf4PBtEI/d6UPsukih/W+5mU4IaUw57S1spHWH/yA4a69h1ndmZAhIuAb4rVWr3crtV/MNe2/l/9CE28AOA5vcfcu7Jm4jR/XL4gIodMLziRUtd5TKWAkRcnQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658253; c=relaxed/simple;
	bh=NT3+ATGeONp3oK/FSMfxmNCRnlixycSJ6Gkz34ZYjfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIXOiejKELYcD8e0BQUbBVP7tNhXbG5EqvpNbqCj07F5GXonK+LLopm+IxeDbGHjhNGToOggDwItyfcU9yned1DL8SRxqYbHwILWyh1vHewF1vzLVlVtZ09+11HZn6rEb0SDj7D5c2cdt3cD6E7VScogO8iZknJ2vJFgLjLTOtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oAa8WcM1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oAa8WcM1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789658245; x=1821194245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NT3+ATGeONp3oK/FSMfxmNCRnlixycSJ6Gkz34ZYjfA=;
  b=oAa8WcM1ZSzk3yiUysZnZDBs6jHcCMvFVbdTwCuB8Yssh1NGFhTz0ysB
   QsZDZYoveaPBF00SB8/sNcaD8Zeu+mpfADFEnLxzWP9/8llYDvPc0dSLt
   bs8k7CeAej2dZZeJTXaLRZnTlFJTpjinBc2TrBdjHzkKaifl3aNqk8Hzc
   KjnP1FEZO4BWxI1TTAsgarNkOc+sS82VLUlxQgfe9Len4dTihtKfJt3Tr
   kD8rPr0dGgzP0vBEvVeV2iJeWod5i2BWzbQs8E0cCUJpM01Y4yEgkDtds
   QdDiFev5LATs6GGe7yTBm/5Og1/Ab1Iz/sNtKblU7bfApDxKqHXEnsCoe
   A==;
X-CSE-ConnectionGUID: NE5o52KpQsWe9KPz0ed1Jg==
X-CSE-MsgGUID: AqlkBajiT3+UjFys79mhvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="101436946"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101436946"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 08:17:17 -0700
X-CSE-ConnectionGUID: y+czv+RFS/upre1CRvYDWQ==
X-CSE-MsgGUID: yA8acciLQymRCApaAYukRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269590351"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 08:17:15 -0700
Date: Thu, 17 Sep 2026 18:17:12 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] gpio: cdev: fix kernel stack leak to user-space in error
 path
Message-ID: <aqwEeLLuIC1AoLQ1@ashevche-desk.local>
References: <20260917-gpio-cdev-stack-leak-fixes-v1-1-2bb52879e49c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-gpio-cdev-stack-leak-fixes-v1-1-2bb52879e49c@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 17, 2026 at 04:39:05PM +0200, Bartosz Golaszewski wrote:
> If we fail to acquire the GPIO chip guard in gpio_desc_to_lineinfo(), we
> return immediately before zeroing the info struct we'll end up passing
> to the user-space later in lineinfo_get_v1(). This may leak the kernel
> stack contents. Move the memset() before trying to acquire the SRCU read
> lock.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  	unsigned long dflags;
>  	const char *label;

It might be not obvious for a reader, perhaps a short comment why it's done
here?

> +	memset(info, 0, sizeof(*info));

-- 
With Best Regards,
Andy Shevchenko


