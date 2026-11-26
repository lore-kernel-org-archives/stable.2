Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669765;
	b=qD0vTfEksAUY6OQxkVNOFNbHVYEwWUMRW5YILJ6XcaZMtQ0EKubbhik5T9aaAU3YsB/J
	 8sTnIWAchOusqrCxs1aY/KVgl8E3WjIInXkEEIwQuknCcqv2mpd3LUpCZIOf3BKG5d8zH
	 SGeXhv70ereKBcQLSBwyg9bZuZwTvrNeoyPCDrqF/Y2AcHTUN2q5d8lmGgQtv5eCn7Ppx
	 upHelnSbjAHLoXBFxtbglbBnN5+N7p36qlZkAsRxj6Z9o91sQUjPUqibeYB+niAkIxg3B
	 8fQNlWP1GHvv4mLrd1Du7kITHL/4cpnviZ8lk26h4Qmckxc1kyoTSeD/9NlrFCgLCUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669765;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Wd3WkYSBVTZqn9lUFbAv0tJhQxpzlY3zFJFj4VoS+2U=;
	b=YBGQg666BFkWdAw5nSaYz68BQoz17xRMN4rwBryEXYDQ2c3O95HpSOjp4CgJah8wYfA3
	 jkhlpnzIR0ld18NXIMpEohbRKxWN2rS9GU3KxRjNFaOICg0mf0yjp5nQ3hAGpXwWHVs1y
	 nAy+w620q5vqVQa+yZCiG6Ij0V//sbH7rx0gLak7oTAROLybUkVqCu+AppavVEBuS11OE
	 zVYHtUJcW9yoC/f0F1csZKO9afKygeNRXsPV6Q0dUXE1fbp7TxlvORTQDWu7u2UzkaxT1
	 stpk9VIKmC+2qXDd2KU5uFtV+WYvyZkCQDH5wiiDZzDrhoOVHHFc5Ozlz/LP+aiLjog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EVVVCBxb;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D616606A32A;
	Thu, 26 Nov 2026 05:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D616606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EVVVCBxb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795669765; x=1827205765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m5vwEA1O/E7I5dldo8TjfqXH6ZiDa3r2M1nFsbFMI94=;
  b=EVVVCBxbinvnS3opccW8o4d1T7P5Iw4bOt9hZmZ6cDqVrnms0gJ0dgGz
   jys+isvl6uj1YbdPk5n0TXXyNwiTKYZA97bZgQVmH4YpvXMf2v9g2TQ6B
   +E+kUiajnCufK5W4wgdqL7MM1VDm8VrBrI8eQ7O7/nJHXLvlsIJ0AEUjE
   E8Gy1kBdEph0Onj7CzoKnT4Byz/YdZr2+uk7r2cOEM9lp8hVxjkTOizuG
   gTPUka9ZF6xfBPHMIuWochgVjVMeYt0h2Lt/cII50wLrFv0hCLOXiYtqh
   cz3/cpb8fGutFUn6uZSHIESrUqi2waymJAveysB3eVF2KKEYt9WMtbk9F
   Q==;
X-CSE-ConnectionGUID: g7JgmQDxTj24k/MNUy0Mrg==
X-CSE-MsgGUID: 4hVjPefsRVKMhsS0vI1UNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4458008"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4458008"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 21:09:24 -0800
X-CSE-ConnectionGUID: iTnN2f5eRZyVbdEV0Pif5w==
X-CSE-MsgGUID: uSGWSdNvRU2HirscstXH0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="12670923"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 25 Nov 2026 21:09:22 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id CEA3098; Thu, 26 Nov 2026 06:09:20 +0100 (CET)
Date: Thu, 26 Nov 2026 06:09:20 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org, stable@vger.kernel.org,
	Norman Herms <dockseed@proton.me>
Subject: Re: [PATCH] gpiolib: use the of_xlate() result when hogging lines
Message-ID: <20261126050920.GJ191152@black.igk.intel.com>
References: <20261125-gpio-three-cell-hog-v1-1-724b15c4f0d8@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261125-gpio-three-cell-hog-v1-1-724b15c4f0d8@oss.qualcomm.com>

On Wed, Nov 25, 2026 at 04:03:41PM +0100, Bartosz Golaszewski wrote:
> Since commit d1d564ec4992 ("gpio: move hogs into GPIO core"),
> gpiochip_add_hog() takes the hogged line from the first cell of the
> "gpios" property. The of_xlate() callback is still called for OF nodes
> but only to get the flags so on controllers that compute the offset in
> of_xlate() (sunxi, Qualcomm PMIC GPIOs, tegra186, ...) the wrong line is
> hogged.
> 
> Use the descriptor returned by of_xlate() for OF nodes.
> 
> Cc: stable@vger.kernel.org
> Fixes: d1d564ec4992 ("gpio: move hogs into GPIO core")
> Reported-by: Norman Herms <dockseed@proton.me>
> Closes: https://lore.kernel.org/all/qh4LV99kGaQYdQuGbsPX4b9Fm6Cip_Ow7ImY4icfwI8IsbMQy_09FovZY82b-_HVkDmR2ELMlKe8bzCuBB5NpaZizoO-s4tc11zAX30FDhw=@proton.me/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Mika Westerberg <westeri@kernel.org>
