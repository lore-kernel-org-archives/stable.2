Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86A54DA535;
	Mon, 19 Oct 2026 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407494; cv=none; b=APOR1ooE9EYJja84T2tv7GZLlM8rl460PIWqifPS3lG2qnlklY5DhdUxK9BY0CBO7fJBCRmd5DWl3AYgD3UMY6tsjdAsoGCgAS96og/s23c1pr8Sseycq6p7iTj8naZnoEXhyeekINV2NtGvZFKehlb3Hhz0Dfv0GcCLmdgS2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407494; c=relaxed/simple;
	bh=zxCw7LM35gSBCwkwViMSJmmfnBJ863fFFLzm1ixlyBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRQgtEnAlSTUJZDigxSOAhF6AwOMOqPAjtct+zx4rJzIelF/GFrYcvWTI8mIRw1YrycopVxqM7JJYkp2w1U1hpb63tp4TtJU9m62e+sY9viDAqnRZUF6qUN7zuwWho9Oa8rg/p+OvnrdOLn5Jm70AWe8mvKKtgzd95jkPJdIUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nnzFnmXy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nnzFnmXy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792407493; x=1823943493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zxCw7LM35gSBCwkwViMSJmmfnBJ863fFFLzm1ixlyBo=;
  b=nnzFnmXyFGwyT+vzb+/Ydo15HoZ1L9DOVk0gKHuyldgUle7xxMKki81A
   LS1DCGb0QFcFTAsb2QVQZKNbAWxUg4d0Rjyek9swNpkoPlrmaVyjOB2/z
   I1e5mbKzsT+pWqwa6QoYv5PjOVeEMtz3bZNefTh0CH+xgqHGART8Agi5r
   2i4ughxaMkrLbpyLfsc1HyTaqiribr++WC9dDn51/Y9XOqllCE0QTlIta
   atQgt+VoVaSjN+GX0diSqDPRV837hmpHUqfmX+/CDyXWf4dqRgK9+SIl+
   jKA8lf61RUFttidGDxR9vTTw4XgpLA++q8Yuz+TctpyYRoJ9warTEsr60
   Q==;
X-CSE-ConnectionGUID: TkdngWUJTwW8U/IfDI6wEA==
X-CSE-MsgGUID: PkBmw6AGTU+tizRGpij4SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1096236"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1096236"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:58:12 -0700
X-CSE-ConnectionGUID: YqohVtC6Qt6aYquL0muSJg==
X-CSE-MsgGUID: eS3B/quwTqqx05hLssKdhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2392023"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:58:09 -0700
Date: Mon, 19 Oct 2026 13:58:06 +0300
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
Subject: Re: [PATCH v3 3/3] iio: humidity: hid-sensor-humidity: Use
 per-instance callbacks
Message-ID: <atX3vi_iQ--p1Pha@ashevche-desk.local>
References: <20261019023420.83976-1-ch@murgatroid.com>
 <20261019023420.83976-4-ch@murgatroid.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019023420.83976-4-ch@murgatroid.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 18, 2026 at 07:34:20PM -0700, Christopher Hoover wrote:
> hid-sensor-humidity keeps a single static struct
> hid_sensor_hub_callbacks for all instances and overwrites its pdev in
> every probe, so with two humidity sensors, input reports for one are
> delivered with the other's platform device, and a NULL dereference
> follows once that device is removed.  The same bug was found in
> hid-sensor-temperature, which shares this code.
> 
> Keep the callbacks in struct hid_humidity_state, as the other HID
> sensor drivers (accel, gyro, als, ...) do.

Same comment as per previous patch.

-- 
With Best Regards,
Andy Shevchenko


