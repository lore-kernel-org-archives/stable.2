Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483C33E3DA4;
	Mon, 19 Oct 2026 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407464; cv=none; b=SS2XNZRiCrsY9UkLZN7DcE1HcHs1Jc/JM32yYUG0pG8X0RQ0UDNM2wXmBgpTKJyJcaYP6FfuQKHyYQhDYdLsCa8XF1FXUujIfAATMEvUkadlBKyU28FzymQv1mpZyfWIaVQdf+hwYLSfV3t8W3joEGINTRsxRWA+Jea4GerGiM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407464; c=relaxed/simple;
	bh=q80m4nE2uwVii8/kh82DSr3qQf5x8VbtGu88HSiCsUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gq6j7htF23qCisnweUw7SaiZ9iszzNYdPZk3Fr9bUgg58tQBOhs0CFkEum6xQB6knm7MAVW2185qrEpG9zjbfWrjMQqWHz4eaYRUmFkkWpW2MPZUe1AldgdGdglu3bprw1nZGgX/FnIfrXSRcnO21gaMaROvIJn3Oa3FZFRX/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJWjK8NW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJWjK8NW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792407463; x=1823943463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q80m4nE2uwVii8/kh82DSr3qQf5x8VbtGu88HSiCsUk=;
  b=IJWjK8NWMzkJBFL+BzAST3kae+uz6R5Wj9YAH4NZ+6xFY/oPz5P0wCeF
   PtKIVya0xkV1x21iwT/YzT5/JPR9pWmRkfRETT/BceUqS+nWEDwfYhXea
   fIafNThq5DkVJLU7T9LQjlacx1Xp21C8AfPsnE0cjaa1TmBLEFZYTJi+7
   onO5VB8uK3rW3d35rmKyLQY8OO42r+YTrmd//zz53WlV3ZfgW3ZyEID6W
   PA2HT6ZUyySJ6wUTaQPDuyr4yL5BfwABuiON4TDkhUNc5yHGf2cFL6VnR
   yaLXjzhHW8KKUdvl8lhARP+v0lBAi0GiQM8VGxm28mBe59unnI3yN2a/T
   A==;
X-CSE-ConnectionGUID: mZwZR/SpRBO7PI8GGrAOiQ==
X-CSE-MsgGUID: gN/lXSGnQNyDYlOgQjxpHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1096226"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1096226"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:57:42 -0700
X-CSE-ConnectionGUID: cgU4XWHtSeGdFFotcM6G9Q==
X-CSE-MsgGUID: dvyKMqqJTwOgbaEcd+AYXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4347318"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:57:40 -0700
Date: Mon, 19 Oct 2026 13:57:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Christopher Hoover <ch@murgatroid.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Lixu Zhang <lixu.zhang@intel.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: temperature: hid-sensor-temperature: Use
 per-instance callbacks
Message-ID: <atX3ocWrOi1l8N_U@ashevche-desk.local>
References: <20261019023420.83976-1-ch@murgatroid.com>
 <20261019023420.83976-3-ch@murgatroid.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019023420.83976-3-ch@murgatroid.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 18, 2026 at 07:34:19PM -0700, Christopher Hoover wrote:
> hid-sensor-temperature keeps a single static struct
> hid_sensor_hub_callbacks for all instances and overwrites its pdev in
> every probe.  With two temperature sensors, input reports for one are
> delivered with the other's platform device; once that device is
> removed, platform_get_drvdata() returns NULL and
> temperature_capture_sample() dereferences it:
> 
>   BUG: kernel NULL pointer dereference, address: 00000000000003a8
>   RIP: 0010:temperature_capture_sample+0xd/0x50 [hid_sensor_temperature]
> 
> The oops happens in sensor_hub_raw_event() with the hub's spinlock
> held, so the hub's removal then hangs.  It reproduces with two uhid
> devices that each declare a temperature sensor, one destroyed while
> the other still sends input reports.
> 
> Keep the callbacks in struct temperature_state, as the other HID
> sensor drivers (accel, gyro, als, ...) do.

...

>  struct temperature_state {
>  	struct hid_sensor_common common_attributes;
> +	struct hid_sensor_hub_callbacks callbacks;
>  	struct hid_sensor_hub_attribute_info temperature_attr;

To me sounds like this new member is misplaced. The _attributes and _attr
current members kinda tighten to each other, while callbacks is separate from
this "group".

>  	struct {
>  		s32 temperature_data;

No need to resend just for this, I hope Jonathan will tweak this whilst
applying.

-- 
With Best Regards,
Andy Shevchenko


